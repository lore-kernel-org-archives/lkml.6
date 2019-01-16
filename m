Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D980EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDCD206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eVVvOqKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392059AbfAPMG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:06:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57148 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731741AbfAPMGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:06:55 -0500
Received: from zn.tnic (p200300EC2BC98A0074F02E32486DBF81.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:8a00:74f0:2e32:486d:bf81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 828251EC0987;
        Wed, 16 Jan 2019 13:06:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547640414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Zo8DokdWARy/QnwYQxuTAzOkWKvaS7oPExAPHyuEB2o=;
        b=eVVvOqKJEUAEYLe+lctHEpbEvHMW2Vcs0/nHzMRs661lXCUPETGtIYbgmvONUgzNwEW3gp
        w/pegDV+Ef7GUfk6/uG9bO071IE9rulyaS2K2d/hozh4NteDbMgO25SacwzIIk1Vg+9aW+
        +RSqvG2vTSRegb5y6h0Jp1P86x8TWSk=
Date:   Wed, 16 Jan 2019 13:06:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/UV: Replace kmalloc and memset with kzalloc
 and kcalloc
Message-ID: <20190116120647.GE15409@zn.tnic>
References: <20190115173713.GA31031@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115173713.GA31031@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 11:37:13AM -0600, Gustavo A. R. Silva wrote:
> Replace kmalloc_node and memset with kzalloc_node, and
> kmalloc_array and memset with kcalloc.
> 
> Also, remove unnecessary pointer to void vp.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  arch/x86/platform/uv/tlb_uv.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
> index a4130b84d1ff..ed7e3a21344b 100644
> --- a/arch/x86/platform/uv/tlb_uv.c
> +++ b/arch/x86/platform/uv/tlb_uv.c
> @@ -2010,8 +2010,7 @@ static void make_per_cpu_thp(struct bau_control *smaster)
>  	int cpu;
>  	size_t hpsz = sizeof(struct hub_and_pnode) * num_possible_cpus();
>  
> -	smaster->thp = kmalloc_node(hpsz, GFP_KERNEL, smaster->osnode);
> -	memset(smaster->thp, 0, hpsz);
> +	smaster->thp = kzalloc_node(hpsz, GFP_KERNEL, smaster->osnode);
>  	for_each_present_cpu(cpu) {
>  		smaster->thp[cpu].pnode = uv_cpu_hub_info(cpu)->pnode;
>  		smaster->thp[cpu].uvhub = uv_cpu_hub_info(cpu)->numa_blade_id;
> @@ -2135,15 +2134,12 @@ static int __init summarize_uvhub_sockets(int nuvhubs,
>  static int __init init_per_cpu(int nuvhubs, int base_part_pnode)
>  {
>  	unsigned char *uvhub_mask;
> -	void *vp;
>  	struct uvhub_desc *uvhub_descs;
>  
>  	if (is_uv3_hub() || is_uv2_hub() || is_uv1_hub())
>  		timeout_us = calculate_destination_timeout();
>  
> -	vp = kmalloc_array(nuvhubs, sizeof(struct uvhub_desc), GFP_KERNEL);
> -	uvhub_descs = (struct uvhub_desc *)vp;
> -	memset(uvhub_descs, 0, nuvhubs * sizeof(struct uvhub_desc));
> +	uvhub_descs = kcalloc(nuvhubs, sizeof(*uvhub_descs), GFP_KERNEL);
				       ^^^^^^^^^^^^^^^^^^^^

I'm changing that back to sizeof(struct uvhub_desc) as it is clearer
this way.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
