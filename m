Return-Path: <richard@nod.at>
X-Google-Smtp-Source: AH8x226J7cFvBkBblo/SfygjtV0G+ursv36+H2/GbTHlPVJb9dkgFxffwBHZyJp9wOALkXgwGnrh
ARC-Seal: i=1; a=rsa-sha256; t=1519143294; cv=none;
        d=google.com; s=arc-20160816;
        b=n7FIkiyCC9mPIrn6MISGAMu8HgJ5lD8FehbTqn7RkohHUUO+8XtQsz5i06YqUIqUm1
         GpBisvZ6UorSSCemxZe67EFV/oZN4ssKlT/pveb3q6eU6GJ9bh+sU0hp9dL1onZkeIkj
         mHGwfutqicWLtJpGdPVFqxNOtNL7BvXXt2h+JNEIAFm8bKNieCNAlib3cstpq7i3LDae
         2hRbb6l25MdvPhKa7VWncgQD5VZvI25+noW+P6CGtPP1D35rXIolDaKRUsYJs7Be7QNE
         JsbGL6cdTyCnRFxGsfmJp1PEilgdX1QiDyxMzjE360uV+VyRA5FHuIYZVyHEV9maCO3u
         Cglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=SpHEGOZfVDY99vtVJkDQ5y2GTldubcdIlk4PzsCriF4=;
        b=oYVuHewZI7vclDCdiGvp5LCfKUKuAoRE9XsQulLwVtJLXpdsN4XDjwvfy0xOy8LbLh
         PoELZF/2ZwfRaezctf9ePu86aMmgzUgPrFXg4b0d57EdnOSaQCltEfIeTY6CvUh4U1vl
         vbL23muuAHyWUBxWyhB1Ig23s0OEj4ww4g9ANF57YXGu7V27/LsJl+2lzI+ES2q8n0LA
         LpV1Ym4reEGiVONpqwxil3MjXACJMAADIoLKj9rLVJjKayVCgbLRpGaCXE/pBbPAfOFa
         qQbzV0aTXvZUwT0Qs9AhjEshmRI7cvMHjh7aI6xhUdbuIBW9fed63OCscwKd1lVqhj4T
         S1Tw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
From: Richard Weinberger <richard@nod.at>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, david@sigma-star.at, kbuild-all@01.org, Sam Ravnborg <sam@ravnborg.org>, Arnaud Lacombe <lacombar@gmail.com>, Nick Bowler <nbowler@elliptictech.com>, Michal Marek <mmarek@suse.cz>, Nicolas Pitre <nico@linaro.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2] kbuild: Don't source kernel config
Date: Tue, 20 Feb 2018 17:16:07 +0100
Message-ID: <1919455.eZKeABUfgV@blindfold>
In-Reply-To: <CAK7LNAQT8jEHt39xG7BvMMWjObdvCCpPhJAA83LFut4ewUVQsg@mail.gmail.com>
References: <20180219092245.26404-1-richard@nod.at> <14335276.CH3Xr2i6I8@blindfold> <CAK7LNAQT8jEHt39xG7BvMMWjObdvCCpPhJAA83LFut4ewUVQsg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592820606337824892?=
X-GMAIL-MSGID: =?utf-8?q?1592937199552322312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Dienstag, 20. Februar 2018, 17:00:39 CET schrieb Masahiro Yamada:
> 2018-02-21 0:25 GMT+09:00 Richard Weinberger <richard@nod.at>:
> > Am Dienstag, 20. Februar 2018, 16:18:11 CET schrieb Masahiro Yamada:
> >> 2018-02-19 18:22 GMT+09:00 Richard Weinberger <richard@nod.at>:
> >> > Don't source the kernel config file in shell scripts.
> >> > The config file is not a shell script and often imported from untrusted
> >> > sources.
> >> > What could possible go wrong? ;-)
> >> 
> >> Please enumerate your real problems.
> > 
> > Build a kernel where the .config contains something like:
> > CONFIG_CMDLINE_BOOL=y
> > CONFIG_CMDLINE="`echo hello > world`"
> 
> Same for Makefile
> if a string symbol is referenced from Makefile, like
> 
> CONFIG_CROSS_COMPILE="$(shell echo hello > world)aarch64-linux-gnu-"

Correct. But you forget that the .config file is often imported from untrusted 
sources. Like on LKML, "my kernel explodes, this is the .config".
Jonny random Kernel developer then takes the .config and builds it... 
 
> > I'll send a v3 because I forgot to convert one function in the shell
> > script to the new bash array. kbuild bot FTW. :-)
> 
> You do not need to do so.

Okay, let's wait until toxic .configs appear in the wild. ;-)

> This patch is so ugly.
> 
> Also, changed shell scripts have '#!/bin/sh' shebang,
> but you are adding bash as a requirement.

An alternate approach would be this:
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 5c12dc91ef34..ff0a7c62344b 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -161,6 +161,13 @@ static int conf_set_sym_val(struct symbol *sym, int def, 
int def_flags, char *p)
 	case S_STRING:
 		if (*p++ != '"')
 			break;
+
+		p2 = strpbrk(p, "`$");
+		if (p2 && !(p2[0] == '$' && p2[1] != '(')) {
+			conf_warning("string contains forbidden characters");
+			return 1;
+		}
+
 		for (p2 = p; (p2 = strpbrk(p2, "\"\\")); p2++) {
 			if (*p2 == '"') {
 				*p2 = 0;

That way the conf tool will sanitize the .config before shell scripts will 
source it.

Thanks,
//richard
