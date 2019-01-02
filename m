Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5734C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8966B2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nENtUXR/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o53PFq3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfABG7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:59:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57546 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbfABG7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:59:45 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 047DE60722; Wed,  2 Jan 2019 06:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546412385;
        bh=rRtnfLLwyfFD1tOYGp/KrrvjdmpDS/5yJounfvxv4Iw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nENtUXR/HeBB/O7D0G38KAYfb1o7tClzeGafjtm3bMV6Pb9PZ55ss+q2ZI2iMhjXe
         yMecpGkJZc2DxLuw3Q2xQYZxOKDujV56aG4BwVG7Kjz3m+Ub3LMqea5MK+P97WlcYa
         CSNbeOG3DFdvlzoloClaMigh8UCPPGrtXQoDcGt4=
Received: from [10.204.79.128] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sramana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C8E760722;
        Wed,  2 Jan 2019 06:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546412376;
        bh=rRtnfLLwyfFD1tOYGp/KrrvjdmpDS/5yJounfvxv4Iw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=o53PFq3iz/rrw/JOdWsg3bCoNjpEs2hoLU/ORjiygijtdT+X4QyNfnyAuCcTCMzQb
         kzS9cfT/W68oCP+nPI/BM967Km7py2X3zFDwgDaLrhsDPq6tPmrjMdH1gAZOywVmGs
         eakybRsC6VNS+uL3DxXdPeZUpr0frR84Hi22bxK0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C8E760722
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sramana@codeaurora.org
Subject: Re: [PATCH] genirq: Make sure the affinity to be set is not empty
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1545312957-8504-1-git-send-email-sramana@codeaurora.org>
From:   Srinivas Ramana <sramana@codeaurora.org>
Message-ID: <45756028-c96f-e3b5-389d-d8f022c59c5d@codeaurora.org>
Date:   Wed, 2 Jan 2019 12:29:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1545312957-8504-1-git-send-email-sramana@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/2018 7:05 PM, Srinivas Ramana wrote:
> If the default_affinity is managed/initialized by a system and
> all the cpus present in irq_default_affinity are hotplugged out
> we may end up passing a cpumask of 0 to irq_do_set_affinity().
> 
> Fix this by falling back to cpu_online_mask in case the
> calculated affinity becomes zero.
> 
> Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
> ---
>   kernel/irq/manage.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 9dbdccab3b6a..5c0ba5ca5930 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -393,6 +393,9 @@ int irq_setup_affinity(struct irq_desc *desc)
>   	}
>   
>   	cpumask_and(&mask, cpu_online_mask, set);
> +	if (cpumask_empty(&mask))
> +		cpumask_copy(&mask, cpu_online_mask);
> +
>   	if (node != NUMA_NO_NODE) {
>   		const struct cpumask *nodemask = cpumask_of_node(node);
>   
> 

Hi,

Can you provide your feedback on this?

Thanks,
-- Srinivas R

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
