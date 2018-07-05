Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABCDC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4532400C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4532400C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753776AbeGENvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:51:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50032 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753290AbeGENvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:51:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27A4C18A;
        Thu,  5 Jul 2018 06:51:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19A393F5BA;
        Thu,  5 Jul 2018 06:51:41 -0700 (PDT)
Date:   Thu, 5 Jul 2018 14:51:39 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: Switch 'requests' to be 64-bit (explicitly)
Message-ID: <20180705135139.orifhe4mag7p6zj3@lakrids.cambridge.arm.com>
References: <1523744804-8220-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523744804-8220-1-git-send-email-karahmed@amazon.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15, 2018 at 12:26:44AM +0200, KarimAllah Ahmed wrote:
> Switch 'requests' to be explicitly 64-bit and update BUILD_BUG_ON check to
> use the size of "requests" instead of the hard-coded '32'.
> 
> That gives us a bit more room again for arch-specific requests as we
> already ran out of space for x86 due to the hard-coded check.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
>  include/linux/kvm_host.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6930c63..fe4f46b 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -129,7 +129,7 @@ static inline bool is_error_page(struct page *page)
>  #define KVM_REQUEST_ARCH_BASE     8
>  
>  #define KVM_ARCH_REQ_FLAGS(nr, flags) ({ \
> -	BUILD_BUG_ON((unsigned)(nr) >= 32 - KVM_REQUEST_ARCH_BASE); \
> +	BUILD_BUG_ON((unsigned)(nr) >= (sizeof(((struct kvm_vcpu *)0)->requests) * 8) - KVM_REQUEST_ARCH_BASE); \
>  	(unsigned)(((nr) + KVM_REQUEST_ARCH_BASE) | (flags)); \
>  })
>  #define KVM_ARCH_REQ(nr)           KVM_ARCH_REQ_FLAGS(nr, 0)
> @@ -223,7 +223,7 @@ struct kvm_vcpu {
>  	int vcpu_id;
>  	int srcu_idx;
>  	int mode;
> -	unsigned long requests;
> +	u64 requests;

The usual thing to do for bitmaps is something like:

#define KVM_REQUEST_NR		(KVM_REQUEST_ARCH_BASE + KVM_REQUEST_ARCH_NR)

	unsigned long requests[BITS_TO_LONGS(NR_KVM_REQUESTS)];

>  	unsigned long guest_debug;
>  
>  	int pre_pcpu;
> @@ -1122,7 +1122,7 @@ static inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
>  	 * caller.  Paired with the smp_mb__after_atomic in kvm_check_request.
>  	 */
>  	smp_wmb();
> -	set_bit(req & KVM_REQUEST_MASK, &vcpu->requests);
> +	set_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);

... which wouldn't require a void cast to make the bit API functions
happy (as these expect a pointer to the first unsigned long in the
bitmap).

Thanks,
Mark.
