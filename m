Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF30CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9BC27FFA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9BC27FFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936410AbeF2Oum (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:50:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932254AbeF2Ouk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:50:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1832F81A8B7E;
        Fri, 29 Jun 2018 14:50:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-106.ams2.redhat.com [10.36.117.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 982982026D68;
        Fri, 29 Jun 2018 14:50:37 +0000 (UTC)
From:   Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 03/20] arm64: Add a helper for PARange to physical
 shift conversion
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-4-git-send-email-suzuki.poulose@arm.com>
Cc:     cdall@kernel.org, kvm@vger.kernel.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, punit.agrawal@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, julien.grall@arm.com, james.morse@arm.com,
        kvmarm@lists.cs.columbia.edu
Message-ID: <163cca54-3e0d-750d-a203-c97b2e3f2f29@redhat.com>
Date:   Fri, 29 Jun 2018 16:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-4-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 29 Jun 2018 14:50:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 29 Jun 2018 14:50:40 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
> On arm64, ID_AA64MMFR0_EL1.PARange encodes the maximum Physical
> Address range supported by the CPU. Add a helper to decode this
> to actual physical shift. If we hit an unallocated value, return
> the maximum range supported by the kernel.
> This is will be used by the KVM to set the VTCR_EL2.T0SZ, as it
s/is// and s/the KVM/KVM
> is about to move its place. Having this helper keeps the code
> movement cleaner.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2:
>  - Split the patch
>  - Limit the physical shift only for values unrecognized.
> ---
>  arch/arm64/include/asm/cpufeature.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 1717ba1..855cf0e 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -530,6 +530,19 @@ void arm64_set_ssbd_mitigation(bool state);
>  static inline void arm64_set_ssbd_mitigation(bool state) {}
>  #endif
>  
> +static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
> +{
> +	switch (parange) {
> +	case 0: return 32;
> +	case 1: return 36;
> +	case 2: return 40;
> +	case 3: return 42;
> +	case 4: return 44;
> +	case 5: return 48;
> +	case 6: return 52;
> +	default: return CONFIG_ARM64_PA_BITS;
> +	}
> +}
>  #endif /* __ASSEMBLY__ */
>  
>  #endif
>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

