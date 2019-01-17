Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2107EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39EF205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="U66aGGMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfAQPSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:18:38 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32845 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfAQPSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:18:38 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so11738318qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 07:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YjvaZ9G1FSwHziIyQYueDHCrTavQC6T5hLnDZZ3kn1E=;
        b=U66aGGMBzHV1m12IXV2YA92+Nf8TF5rBr12sDl8wFIqf9srrAdSTPxF8+T0bl3jfLC
         b5PkzQburC4/cE5kuTR+wftO6WnxiDVkt2TJ5+GgKjQMaiqRDpBG2OBRg7XnuzQBYrGg
         BW/YAJ9FkwCL5M7YVjuub+VC86V1eDuAU5edg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YjvaZ9G1FSwHziIyQYueDHCrTavQC6T5hLnDZZ3kn1E=;
        b=WgXlxIvuT7dOqUd5LLSnpbljdGWTCKqqunN2xp+FoG8lAdoSKz1l704k0LreVbmx0k
         HkJZ63XO4e+tdz5Yp6hXa4rr6lXVJopMTmLGLfliDCLcBQy/9DlyzJgMP+cIK8iNfbnJ
         HpY6Cuvzi90tWUZeQ67RhARyIcy/GYNTzh8XBmrKFdcNFTS7E4XemA38dUszHb4xe0qG
         1KLdEni+P4EOTSa2oPDfHy9oUNs0Ga9FJ3XqBaf01/0u7XH0xnmPN2FTfSl8hUxG4d7l
         xi9aWTwV6BjFtxy0Nuf506VcDRk909lsZ6iKo2PgV4Oxb1ERWw7r+bwQx9H6xx41bfwX
         1jAA==
X-Gm-Message-State: AJcUukfsD/8sCeYti295o5QPfxAU2YLrklLPfBPDp8+WBPskgiRRqpnb
        LNAViXGryAYjtxFArDJvGKsEVw==
X-Google-Smtp-Source: ALg8bN719NNaOzVPLVOVrtxrVxlWhRpYRukdkLOqd4unC9l+LfxKJbSG5wH08zPvxKGdacxDmDiJaw==
X-Received: by 2002:a05:6214:c7:: with SMTP id f7mr11976285qvs.44.1547738316551;
        Thu, 17 Jan 2019 07:18:36 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id p8sm57925042qtk.70.2019.01.17.07.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 07:18:34 -0800 (PST)
Date:   Thu, 17 Jan 2019 10:18:33 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] pstore/ram: Fix console ramoops to show the previous
 boot logs
Message-ID: <20190117151833.GA51139@google.com>
References: <20190117062620.23908-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117062620.23908-1-saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:56:20AM +0530, Sai Prakash Ranjan wrote:
> commit b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz()
> arguments") changed update assignment in getting next persistent
> ram zone by adding a check for record type. But the check always
> returns true since the record type is assigned 0. And this breaks
> console ramoops by showing current console log instead of previous
> log on warm reset and hard reset (actually hard reset should not
> be showing any logs).
> 
> Fix this by having persistent ram zone type check instead of record
> type check. Tested this on SDM845 MTP and dragonboard 410c.
> 
> Reproducing this issue is simple as below:
> 
> 1. Trigger hard reset and mount pstore. Will see console-ramoops
>    record in the mounted location which is the current log.
> 
> 2. Trigger warm reset and mount pstore. Will see the current
>    console-ramoops record instead of previous record.
> 
> Fixes: b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz() arguments")
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>


Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks!

 - Joel

> 
> ---
> 
> I guess commit msg can be improved.
> ---
>  fs/pstore/ram.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 96f7d32cd184..441a44215456 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -128,7 +128,7 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], int id,
>  		     struct pstore_record *record)
>  {
>  	struct persistent_ram_zone *prz;
> -	bool update = (record->type == PSTORE_TYPE_DMESG);
> +	bool update;
>  
>  	/* Give up if we never existed or have hit the end. */
>  	if (!przs)
> @@ -138,6 +138,8 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], int id,
>  	if (!prz)
>  		return NULL;
>  
> +	update = (prz->type == PSTORE_TYPE_DMESG);
> +
>  	/* Update old/shadowed buffer. */
>  	if (update)
>  		persistent_ram_save_old(prz);
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
