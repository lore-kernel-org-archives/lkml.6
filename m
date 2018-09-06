Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF7DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0640206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0640206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeIFNJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:09:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42482 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbeIFNJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:09:52 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Qxpyof8OjICm; Thu,  6 Sep 2018 10:35:13 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCBB900329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:b900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D65951EC02D1;
        Thu,  6 Sep 2018 10:35:12 +0200 (CEST)
Date:   Thu, 6 Sep 2018 10:35:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 18/21] edac: cpc925: use for_each_of_cpu_node iterator
Message-ID: <20180906083506.GA10768@zn.tnic>
References: <20180905193738.19325-1-robh@kernel.org>
 <20180905193738.19325-19-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180905193738.19325-19-robh@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 02:37:35PM -0500, Rob Herring wrote:
> Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
> has the side effect of defaulting to iterating using "cpu" node names in
> preference to the deprecated (for FDT) device_type == "cpu".
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-edac@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack and I will take via the DT tree. This is dependent on the
> first 2 patches.

Completely unknown territory for me so I'd trust your judgement. Staring
at 1/21, the conversion looks ok except the removal of those prints that
a cpu nodes are not present - I wonder if they even meant anything or
were just there during driver development...

>  drivers/edac/cpc925_edac.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
> index 2c98e020df05..3c0881ac9880 100644
> --- a/drivers/edac/cpc925_edac.c
> +++ b/drivers/edac/cpc925_edac.c
> @@ -593,8 +593,7 @@ static void cpc925_mc_check(struct mem_ctl_info *mci)
>  /******************** CPU err device********************************/
>  static u32 cpc925_cpu_mask_disabled(void)
>  {
> -	struct device_node *cpus;
> -	struct device_node *cpunode = NULL;
> +	struct device_node *cpunode;
>  	static u32 mask = 0;
> 
>  	/* use cached value if available */
> @@ -603,20 +602,8 @@ static u32 cpc925_cpu_mask_disabled(void)
> 
>  	mask = APIMASK_ADI0 | APIMASK_ADI1;
> 
> -	cpus = of_find_node_by_path("/cpus");
> -	if (cpus == NULL) {
> -		cpc925_printk(KERN_DEBUG, "No /cpus node !\n");

This thing...

> -		return 0;
> -	}
> -
> -	while ((cpunode = of_get_next_child(cpus, cpunode)) != NULL) {
> +	for_each_of_cpu_node(cpunode) {
>  		const u32 *reg = of_get_property(cpunode, "reg", NULL);
> -
> -		if (strcmp(cpunode->type, "cpu")) {
> -			cpc925_printk(KERN_ERR, "Not a cpu node in /cpus: %s\n", cpunode->name);

... and this thing.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
