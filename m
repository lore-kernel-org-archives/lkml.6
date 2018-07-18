Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00820ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0372075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0372075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbeGRQM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:12:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730987AbeGRQM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:12:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45CFC7DAC2;
        Wed, 18 Jul 2018 15:34:32 +0000 (UTC)
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7B41F2026D69;
        Wed, 18 Jul 2018 15:34:30 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Wed, 18 Jul 2018 17:34:29 +0200
Date:   Wed, 18 Jul 2018 17:34:29 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 1/2] KVM: Switch 'requests' to be 64-bit (explicitly)
Message-ID: <20180718153429.GC6348@flask>
References: <1531214840-24686-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531214840-24686-1-git-send-email-karahmed@amazon.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 18 Jul 2018 15:34:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 18 Jul 2018 15:34:32 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-10 11:27+0200, KarimAllah Ahmed:
> Switch 'requests' to be explicitly 64-bit and update BUILD_BUG_ON check to
> use the size of "requests" instead of the hard-coded '32'.
> 
> That gives us a bit more room again for arch-specific requests as we
> already ran out of space for x86 due to the hard-coded check.
> 
> The only exception here is ARM32 as it is still 32-bits.

What do you mean?

I think we're just going to slow down kvm_request_pending() on 32 bit
architectures.

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
> v1 -> v2:
> - Use FIELD_SIZEOF
> ---
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> @@ -130,7 +130,7 @@ static inline bool is_error_page(struct page *page)
>  #define KVM_REQUEST_ARCH_BASE     8

Now that the base is easily moveable, we could also lower it to 4 and
get few more arch flags.

Bumping requests to 64 bits is probably inevitable and this patch looks
good.

In v4, you have proposed the bitmap-array solution that would easily
allow more than 64 requests -- was the problem that possible
implementations of kvm_request_pending were not as efficient for current
amount of requests?

Thanks.

>  #define KVM_ARCH_REQ_FLAGS(nr, flags) ({ \
> -	BUILD_BUG_ON((unsigned)(nr) >= 32 - KVM_REQUEST_ARCH_BASE); \
> +	BUILD_BUG_ON((unsigned)(nr) >= (FIELD_SIZEOF(struct kvm_vcpu, requests) * 8) - KVM_REQUEST_ARCH_BASE); \
>  	(unsigned)(((nr) + KVM_REQUEST_ARCH_BASE) | (flags)); \
>  })
>  #define KVM_ARCH_REQ(nr)           KVM_ARCH_REQ_FLAGS(nr, 0)
