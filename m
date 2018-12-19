Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAE3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF7F217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cDKBJJAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbeLSQrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:47:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55997 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbeLSQrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:47:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so6693036wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 08:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bHbJIKGn9h8iYyxX5CO4ModreIkr2dmaBDzEXIMnsfg=;
        b=cDKBJJADqvLadiYWOSvmea4zhx1xVd5H5aSV9LizOLN48KX19zJ+EmjRYFeAhYixO4
         CzqYKqMrKHmf+kpe6NW/dpx7x+sOFlBeHW1NwTuPcSUIjU5shFKe9AgTLSJOCqGVwBzq
         ZmauHDOZnIRrSFofQ/eUi4f8Q6XbUCO5sedro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bHbJIKGn9h8iYyxX5CO4ModreIkr2dmaBDzEXIMnsfg=;
        b=cKNeXBPeP26WNIrmHiieZblOGWgCg6y+9mofgR/Py76z6Zbd1ac3B/RqRNAVVQXViO
         TnxFT+vmGT60WEW9TSNgnssCqD0mkqCLAmk0tCBno00A95Na8amvCyIgE+V/V0KQ1hpv
         tvZLP4M62A3D04EqyStPiVV2D0jsitgjWPGIs32mHE4v9ReW8Z6Ee+MRMmoNuMcyHkQK
         Tzg1PSJB9drJv4uShCtTU187uzWeQ8sEgIRRW9YD82COJlTUyAs5RJVB+goIwpSjYKuV
         Rv8QRWToaWqEtEYUqUaqBUa1BObt8OP0GoAiKMlIjaq1g1h+Gega6Wg37eMpv/G90kD4
         DKiA==
X-Gm-Message-State: AA+aEWYFBw8NLUBVnq0mGnAT6S+8MwcbGOs+GbZ6Iryyd8293F1U+9vH
        ejP65PwMh7KXIWqfV/m5P+f/TA==
X-Google-Smtp-Source: AFSGD/UWyaZ7cm9RNPvJ1RlO8enhFP69j/jcmn7lEL1LZtCViuCbJTF60YX6YQ06+8MaOwBWwY92TA==
X-Received: by 2002:a1c:cf82:: with SMTP id f124mr8116584wmg.95.1545238053572;
        Wed, 19 Dec 2018 08:47:33 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id x76sm13514500wmd.27.2018.12.19.08.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 08:47:32 -0800 (PST)
Date:   Wed, 19 Dec 2018 16:47:30 +0000
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
Message-ID: <20181219164730.247lzfcsmmjjzibp@holly.lan>
References: <1532078617-13767-1-git-send-email-hofrat@osadl.org>
 <20180720105016.pdzvdqxda2u55apz@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720105016.pdzvdqxda2u55apz@holly.lan>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 11:50:16AM +0100, Daniel Thompson wrote:
> On Fri, Jul 20, 2018 at 11:23:37AM +0200, Nicholas Mc Guire wrote:
> >  defcmd_in_progress  is the state trace for command group processing
> > - within a command group or not -  usable  is an indicator if a command 
> > set is valid (allocated/non-empty) - so use a bool for those binary 
> > indication here.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Applied! Thanks.

> 
> > ---
> > 
> > Found during code review.
> > Not a functional issue - just type correctness.
> > 
> > Patch was compile tested with: x86_64_defconfig + CONFIG_KGDB=y,
> > CONFIG_KGDB_KDB=y
> > (some sparse/smatch warnings not related to the proposed change though)
> > 
> > Patch is against 4.18-rc5 (localversion-next is next-20180720)
> > 
> >  kernel/debug/kdb/kdb_main.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index bb4fe4e..fda515a 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -658,7 +658,7 @@ static void kdb_cmderror(int diag)
> >   */
> >  struct defcmd_set {
> >  	int count;
> > -	int usable;
> > +	bool usable;
> >  	char *name;
> >  	char *usage;
> >  	char *help;
> > @@ -666,7 +666,7 @@ struct defcmd_set {
> >  };
> >  static struct defcmd_set *defcmd_set;
> >  static int defcmd_set_count;
> > -static int defcmd_in_progress;
> > +static bool defcmd_in_progress;
> >  
> >  /* Forward references */
> >  static int kdb_exec_defcmd(int argc, const char **argv);
> > @@ -676,9 +676,9 @@ static int kdb_defcmd2(const char *cmdstr, const char *argv0)
> >  	struct defcmd_set *s = defcmd_set + defcmd_set_count - 1;
> >  	char **save_command = s->command;
> >  	if (strcmp(argv0, "endefcmd") == 0) {
> > -		defcmd_in_progress = 0;
> > +		defcmd_in_progress = false;
> >  		if (!s->count)
> > -			s->usable = 0;
> > +			s->usable = false;
> >  		if (s->usable)
> >  			/* macros are always safe because when executed each
> >  			 * internal command re-enters kdb_parse() and is
> > @@ -695,7 +695,7 @@ static int kdb_defcmd2(const char *cmdstr, const char *argv0)
> >  	if (!s->command) {
> >  		kdb_printf("Could not allocate new kdb_defcmd table for %s\n",
> >  			   cmdstr);
> > -		s->usable = 0;
> > +		s->usable = false;
> >  		return KDB_NOTIMP;
> >  	}
> >  	memcpy(s->command, save_command, s->count * sizeof(*(s->command)));
> > @@ -737,7 +737,7 @@ static int kdb_defcmd(int argc, const char **argv)
> >  	       defcmd_set_count * sizeof(*defcmd_set));
> >  	s = defcmd_set + defcmd_set_count;
> >  	memset(s, 0, sizeof(*s));
> > -	s->usable = 1;
> > +	s->usable = true;
> >  	s->name = kdb_strdup(argv[1], GFP_KDB);
> >  	if (!s->name)
> >  		goto fail_name;
> > @@ -756,7 +756,7 @@ static int kdb_defcmd(int argc, const char **argv)
> >  		s->help[strlen(s->help)-1] = '\0';
> >  	}
> >  	++defcmd_set_count;
> > -	defcmd_in_progress = 1;
> > +	defcmd_in_progress = true;
> >  	kfree(save_defcmd_set);
> >  	return 0;
> >  fail_help:
> > -- 
> > 2.1.4
> > 
