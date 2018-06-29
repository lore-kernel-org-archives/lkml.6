Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43481C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ADF27FFA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1ADF27FFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936480AbeF2OvC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:51:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936445AbeF2OvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:51:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C73997A7E6;
        Fri, 29 Jun 2018 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-106.ams2.redhat.com [10.36.117.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9339A1C739;
        Fri, 29 Jun 2018 14:50:58 +0000 (UTC)
Subject: Re: [PATCH v3 05/20] kvm: arm/arm64: Fix stage2_flush_memslot for 4
 level page table
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-6-git-send-email-suzuki.poulose@arm.com>
Cc:     cdall@kernel.org, kvm@vger.kernel.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, punit.agrawal@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, julien.grall@arm.com, james.morse@arm.com,
        kvmarm@lists.cs.columbia.edu
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <0820efa5-1524-9039-2340-421aad88b3c5@redhat.com>
Date:   Fri, 29 Jun 2018 16:50:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-6-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 29 Jun 2018 14:51:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 29 Jun 2018 14:51:00 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
> So far we have only supported 3 level page table with fixed IPA of 40bits.
> Fix stage2_flush_memslot() to accommodate for 4 level tables.
in 06/30 you add the justification for this change I think. worth to put
in here as well?

> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  virt/kvm/arm/mmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 1d90d79..061e6b3 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -379,7 +379,8 @@ static void stage2_flush_memslot(struct kvm *kvm,
>  	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
>  	do {
>  		next = stage2_pgd_addr_end(addr, end);
> -		stage2_flush_puds(kvm, pgd, addr, next);
> +		if (!stage2_pgd_none(*pgd))
> +			stage2_flush_puds(kvm, pgd, addr, next);
>  	} while (pgd++, addr = next, addr != end);
>  }
>  
> 

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


