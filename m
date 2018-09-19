Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103E1ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A963521524
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1PEbsu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A963521524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbeISX4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732841AbeISX4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:56:32 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE5CB21522;
        Wed, 19 Sep 2018 18:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537381046;
        bh=s8Iub3kqu+kXwC/VWCFasNw4k6a8dvDyOr+IDN8rJNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1PEbsu8kZ6FTw23ePAkzpYHjFjwP/S66VUo+JUR6WkVEBfQX6J1kkJU1fd1P+IVz
         2YjstQtJJIdqp3TJ5guSEcsavi2Eajn6kUAsbopIc2fvRonj1KMr9EvouuuJBp+H9A
         6EAaNt9tS/L40U+EjQxamuHBtLWHkMobwZHI0fJs=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id B35F1140260; Wed, 19 Sep 2018 15:17:23 -0300 (-03)
Date:   Wed, 19 Sep 2018 15:17:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, kim.phillips@arm.com,
        Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v5 2/9] tools, pager: Support overwriting the pager
Message-ID: <20180919181723.GE31812@kernel.org>
References: <20180918123214.26728-1-andi@firstfloor.org>
 <20180918123214.26728-3-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918123214.26728-3-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 18, 2018 at 05:32:07AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add an interface to the auto pager code that allows callers
> to overwrite the pager.

Applied,

- Arnaldo
 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/lib/subcmd/pager.c | 11 ++++++++++-
>  tools/lib/subcmd/pager.h |  1 +
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/subcmd/pager.c b/tools/lib/subcmd/pager.c
> index 9997a8805a82..e3d47b59b14d 100644
> --- a/tools/lib/subcmd/pager.c
> +++ b/tools/lib/subcmd/pager.c
> @@ -23,6 +23,13 @@ void pager_init(const char *pager_env)
>  	subcmd_config.pager_env = pager_env;
>  }
>  
> +static const char *forced_pager;
> +
> +void force_pager(const char *pager)
> +{
> +	forced_pager = pager;
> +}
> +
>  static void pager_preexec(void)
>  {
>  	/*
> @@ -66,7 +73,9 @@ void setup_pager(void)
>  	const char *pager = getenv(subcmd_config.pager_env);
>  	struct winsize sz;
>  
> -	if (!isatty(1))
> +	if (forced_pager)
> +		pager = forced_pager;
> +	if (!isatty(1) && !forced_pager)
>  		return;
>  	if (ioctl(1, TIOCGWINSZ, &sz) == 0)
>  		pager_columns = sz.ws_col;
> diff --git a/tools/lib/subcmd/pager.h b/tools/lib/subcmd/pager.h
> index f1a53cf29880..a818964693ab 100644
> --- a/tools/lib/subcmd/pager.h
> +++ b/tools/lib/subcmd/pager.h
> @@ -7,5 +7,6 @@ extern void pager_init(const char *pager_env);
>  extern void setup_pager(void);
>  extern int pager_in_use(void);
>  extern int pager_get_columns(void);
> +extern void force_pager(const char *);
>  
>  #endif /* __SUBCMD_PAGER_H */
> -- 
> 2.17.1
