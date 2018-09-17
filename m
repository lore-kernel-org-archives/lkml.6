Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B829ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1B2214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1B2214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeIQS5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:57:47 -0400
Received: from foss.arm.com ([217.140.101.70]:59082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbeIQS5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:57:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED36915AD;
        Mon, 17 Sep 2018 06:30:25 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF0393F557;
        Mon, 17 Sep 2018 06:30:25 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 591301AE3063; Mon, 17 Sep 2018 14:30:44 +0100 (BST)
Date:   Mon, 17 Sep 2018 14:30:44 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robert.richter@cavium.com,
        cwu@amperecomputing.com
Subject: Re: [PATCH RESEND 5/6] arm64: add sysfs vulnerability show for
 speculative store bypass
Message-ID: <20180917133043.GD23040@arm.com>
References: <20180827143310.641-1-ykaukab@suse.de>
 <20180827143310.641-6-ykaukab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827143310.641-6-ykaukab@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 04:33:09PM +0200, Mian Yousaf Kaukab wrote:
> Return status based no ssbd_state. Return string "Unknown" in case
> CONFIG_ARM64_SSBD is disabled or arch workaround2 is not available
> in the firmware.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> ---
>  arch/arm64/kernel/cpu_errata.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 8469d3be7b15..8b60aa30a3fa 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -744,4 +744,24 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
>  	return sprintf(buf, "Not affected\n");
>  }
>  
> +ssize_t cpu_show_spec_store_bypass(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	switch (arm64_get_ssbd_state()) {
> +	case ARM64_SSBD_MITIGATED:
> +		return sprintf(buf, "Not affected\n");
> +
> +	case ARM64_SSBD_KERNEL:
> +	case ARM64_SSBD_FORCE_ENABLE:
> +		return sprintf(buf,
> +			"Mitigation: Speculative Store Bypass disabled");
> +
> +	case ARM64_SSBD_FORCE_DISABLE:
> +		return sprintf(buf, "Vulnerable\n");
> +
> +	default: /* ARM64_SSBD_UNKNOWN*/
> +		return sprintf(buf, "Unknown\n");
> +	}
> +}

This probably wants extending for CPUs that support SSBS (see
for-next/core).

Will
