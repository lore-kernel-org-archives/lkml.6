Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55D2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC7420661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UyNWZYCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC7420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbeGTLiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:38:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37006 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeGTLiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:38:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id q10-v6so10893648wrd.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 03:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3BGy1/bbqYkeAhTc4J93y9HrXKmyNIjiyNcZvFVAl0s=;
        b=UyNWZYCrrx56kQqaJ+EKnWK7O8Uxnf/xcXCSwO1+yEn4eQytBm91+puRM1SD0tonf/
         DQsNdJSrSjEt/n9JxqM8Y8l53tacevCvFEwkGZlMZKVokk5c0MFeEYg/bFgyydCXmg8u
         TOFAIUvnYLODp/+Vu8xrz9LqIHD0r7UUkJAnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3BGy1/bbqYkeAhTc4J93y9HrXKmyNIjiyNcZvFVAl0s=;
        b=kWSGfaJ9SVJjuPt0zNRGAVXuSsMwa4WZ83A+Kan94O3Avy9s+UY+szwmd9Sk2py/XM
         9jwaVvO8+QgVDlbvmLBVa683t+XJVicarnRWEvvKxX58FaQR1ZK9pAL+XhNktdta/edR
         Ytm35qRcKrV8ze7HhU1aIKLH3HGAdzaWLAMAcHqkpjSiI1pdKaCmvI76fUnPW239Ue8I
         cpzU8qDoDBjaXGuE7mitCLvJMG01OKsyACykGc818N1nZ/VOGbhzT5YJQCOJZp4CrFA2
         FMxMdRDbj09LBXlMpXpgcJTwfwkZKaedC7Q/Y7EieDJmms3JESnSKJSoGSc8/J3v1/cU
         JqYA==
X-Gm-Message-State: AOUpUlGrM8kmEbe6TDphVBPJ0XgQFegC9Ttrfucewmdi9RkLwU0qALRj
        ID0U70QCMl2XMfOcqg+JjO65Mg==
X-Google-Smtp-Source: AAOMgpfhaW/9wowxsQemg9NKnqJhkHk/GpFt92z5pcXM1rSbe0WvX1MXvEcTqfkGpA9W3FFX4P5Dig==
X-Received: by 2002:adf:c684:: with SMTP id j4-v6mr1156875wrg.243.1532083819455;
        Fri, 20 Jul 2018 03:50:19 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id r1-v6sm1261000wrs.39.2018.07.20.03.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 03:50:18 -0700 (PDT)
Date:   Fri, 20 Jul 2018 11:50:16 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Baolin Wang <baolin.wang@linaro.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Eric W Biederman <ebiederm@xmission.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: use bool for binary state indicators
Message-ID: <20180720105016.pdzvdqxda2u55apz@holly.lan>
References: <1532078617-13767-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532078617-13767-1-git-send-email-hofrat@osadl.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 11:23:37AM +0200, Nicholas Mc Guire wrote:
>  defcmd_in_progress  is the state trace for command group processing
> - within a command group or not -  usable  is an indicator if a command 
> set is valid (allocated/non-empty) - so use a bool for those binary 
> indication here.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> 
> Found during code review.
> Not a functional issue - just type correctness.
> 
> Patch was compile tested with: x86_64_defconfig + CONFIG_KGDB=y,
> CONFIG_KGDB_KDB=y
> (some sparse/smatch warnings not related to the proposed change though)
> 
> Patch is against 4.18-rc5 (localversion-next is next-20180720)
> 
>  kernel/debug/kdb/kdb_main.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index bb4fe4e..fda515a 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -658,7 +658,7 @@ static void kdb_cmderror(int diag)
>   */
>  struct defcmd_set {
>  	int count;
> -	int usable;
> +	bool usable;
>  	char *name;
>  	char *usage;
>  	char *help;
> @@ -666,7 +666,7 @@ struct defcmd_set {
>  };
>  static struct defcmd_set *defcmd_set;
>  static int defcmd_set_count;
> -static int defcmd_in_progress;
> +static bool defcmd_in_progress;
>  
>  /* Forward references */
>  static int kdb_exec_defcmd(int argc, const char **argv);
> @@ -676,9 +676,9 @@ static int kdb_defcmd2(const char *cmdstr, const char *argv0)
>  	struct defcmd_set *s = defcmd_set + defcmd_set_count - 1;
>  	char **save_command = s->command;
>  	if (strcmp(argv0, "endefcmd") == 0) {
> -		defcmd_in_progress = 0;
> +		defcmd_in_progress = false;
>  		if (!s->count)
> -			s->usable = 0;
> +			s->usable = false;
>  		if (s->usable)
>  			/* macros are always safe because when executed each
>  			 * internal command re-enters kdb_parse() and is
> @@ -695,7 +695,7 @@ static int kdb_defcmd2(const char *cmdstr, const char *argv0)
>  	if (!s->command) {
>  		kdb_printf("Could not allocate new kdb_defcmd table for %s\n",
>  			   cmdstr);
> -		s->usable = 0;
> +		s->usable = false;
>  		return KDB_NOTIMP;
>  	}
>  	memcpy(s->command, save_command, s->count * sizeof(*(s->command)));
> @@ -737,7 +737,7 @@ static int kdb_defcmd(int argc, const char **argv)
>  	       defcmd_set_count * sizeof(*defcmd_set));
>  	s = defcmd_set + defcmd_set_count;
>  	memset(s, 0, sizeof(*s));
> -	s->usable = 1;
> +	s->usable = true;
>  	s->name = kdb_strdup(argv[1], GFP_KDB);
>  	if (!s->name)
>  		goto fail_name;
> @@ -756,7 +756,7 @@ static int kdb_defcmd(int argc, const char **argv)
>  		s->help[strlen(s->help)-1] = '\0';
>  	}
>  	++defcmd_set_count;
> -	defcmd_in_progress = 1;
> +	defcmd_in_progress = true;
>  	kfree(save_defcmd_set);
>  	return 0;
>  fail_help:
> -- 
> 2.1.4
> 
