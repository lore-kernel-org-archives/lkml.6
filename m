Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA12C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 22:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0D4206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 22:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550961991;
	bh=jsoZEYlZLb7mPNmpd4CdG+Ml30LViGD9aKg4bGpNni8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0gi3pRnCwKT69txnCrUg09fjmusCuIANcW6NSR8D98TBtpIBgvkI8D+Yu843wEomq
	 12cyyrERBthRbjNa/B349ZVJCVRjKkvOuKLbCibC1nlG3eZfp2X35gOFhxWmssQx9K
	 Nt8P5AYiVMc4I7Aa3+bm6t+oYBkNA0RQ4ZeMWNkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfBWWq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 17:46:29 -0500
Received: from mail-yw1-f50.google.com ([209.85.161.50]:44658 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfBWWq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 17:46:29 -0500
Received: by mail-yw1-f50.google.com with SMTP id x21so2250021ywx.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 14:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Foic8TLGpFEWQebCcc/J37yQ/BZX4rqLMDGduE61c7g=;
        b=uOAYfzotZAJii3L9frTDNuViWrjN5s3VP0P9fDPLlKH507eSRTLony830IYQ3073Ag
         Ub0fXTBwYFgbAU8TKNZ0giV/oN3EB1MXuG6+WZNJPK+SUGt9Lp9T6T3eajgx0Qc8HMGJ
         h/TAkwy0eK1H0F+1fmej2amidpMvtn3YVbYhnhbqq+Tp9Qi9nab7ZR986TaJDk1vB80W
         VPDFNo0ZrCTt5aIqzU+mZkrTlCXn+IgyioIMHCBMOH3C8ZaM6toT3wLrzlb8WN+sUiWR
         BSS/GxTerRaVuhzO0PhS/rHx1tq7U8DDSkRsjJhdzFxB7nye3Y6fTKdzEF8l1wpBWHfm
         m2MA==
X-Gm-Message-State: AHQUAuY1XGSaD7MJVV3njQ6H/nDSIdzsHiHyHVNgSpGRvfJ15BUojJKZ
        GfKuyQQtBQuPtjw/ATn9FEE=
X-Google-Smtp-Source: AHgI3IalnwdiMYy/npy4mUQOjhhowUfA3rNcImsp8uJRMJKJHCa1qYIlBIJ5NPM2nYwvbE09sHL+qQ==
X-Received: by 2002:a81:7850:: with SMTP id t77mr8686724ywc.451.1550961988248;
        Sat, 23 Feb 2019 14:46:28 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:180::1:537c])
        by smtp.gmail.com with ESMTPSA id z77sm2156704ywz.91.2019.02.23.14.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 14:46:26 -0800 (PST)
Date:   Sat, 23 Feb 2019 17:46:22 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "dennis@kernel.org" <dennis@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [RFC] percpu: use nr_groups as check condition
Message-ID: <20190223224622.GA31069@dennisz-mbp.dhcp.thefacebook.com>
References: <20190220134353.24456-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220134353.24456-1-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Wed, Feb 20, 2019 at 01:32:55PM +0000, Peng Fan wrote:
> group_cnt array is defined with NR_CPUS entries, but normally
> nr_groups will not reach up to NR_CPUS. So there is no issue
> to the current code.
> 
> Checking other parts of pcpu_build_alloc_info, use nr_groups as
> check condition, so make it consistent to use 'group < nr_groups'
> as for loop check. In case we do have nr_groups equals with NR_CPUS,
> we could also avoid memory access out of bounds.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  mm/percpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index db86282fd024..c5c750781628 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2384,7 +2384,7 @@ static struct pcpu_alloc_info * __init pcpu_build_alloc_info(
>  	ai->atom_size = atom_size;
>  	ai->alloc_size = alloc_size;
>  
> -	for (group = 0, unit = 0; group_cnt[group]; group++) {
> +	for (group = 0, unit = 0; group < nr_groups; group++) {
>  		struct pcpu_group_info *gi = &ai->groups[group];
>  
>  		/*
> -- 
> 2.16.4
> 

This seems right to me. It is quite the edge case though. I've queued
this for 5.1.

Thanks,
Dennis
