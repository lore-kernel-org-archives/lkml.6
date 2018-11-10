Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A692AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AE520858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AE520858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=genki.is
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbeKJSnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:43:12 -0500
Received: from genki.is ([104.200.25.21]:43314 "EHLO genki.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbeKJSnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:43:12 -0500
Received: by genki.is (OpenSMTPD) with ESMTP id 8c944eca;
        Sat, 10 Nov 2018 08:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=genki.is; h=date
        :message-id:mime-version:content-transfer-encoding:content-type
        :from:subject:to:cc:in-reply-to:references; s=dkim; bh=+8yWhWqTt
        2Z08lChR9XsGiW6wH0=; b=fa3aaJzLSmflf/SXPzUxiAbzOd7isrH2ZqxRznuJg
        Rdv879PXeVXSR5He7T8fF3dBv8AuBn3tId84CR2HV+Z+xqKDoZUVUqO2uBCJ7pe5
        rOVQ5xfgIECKYPV5IAW48XYr9/RlLAIjPfOn8J0myY8BvvYx2eg9f7U/p0xrIfNl
        RucukGEPaQfG+3biIUH/Z9kzXtwQiXNo8UGXFNKUfzPSLUCtDxbeA7PQW04bBdTH
        3Hu0xKRInMBHdReXBPKJdsCruKbRrQEGHALLvnxWgcytOg32/b7GBQvoSDwk3iZN
        UnI2WF7vDEKMn8piNBUkoufFluPpkhk4tk4R6+TKXeZEg==
Received: by genki.is (OpenSMTPD) with ESMTPSA id d1677770 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sat, 10 Nov 2018 08:58:56 +0000 (UTC)
Date:   Sat, 10 Nov 2018 00:58:26 -0800
Message-ID: <20181110.085826.230851261@genki.is>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
From:   Genki Sky <sky@genki.is>
Subject: Re: [PATCH] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
To:     Brian Norris <briannorris@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christian Kujau <lists@nerdbynature.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20181109183436.GA45531@google.com>
References: <20181107022156.GA254567@google.com>
        <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
        <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
        <20181107184435.GA168339@google.com> <20181107.204358.257636196@genki.is>
        <20181107205514.GB12273@roeck-us.net> <20181107.210731.330601031@genki.is>
        <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com>
        <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
        <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
        <20181109183436.GA45531@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks very much for doing this. But, this patch always prints
-dirty for me, even with no untracked changes in git. I think this is
because:

On Fri, 9 Nov 2018 10:34:37 -0800, Brian Norris <briannorris@chromium.org> wrote:
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 71f39410691b..eab1f90de50d 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -73,8 +73,19 @@ scm_version()
>  			printf -- '-svn%s' "`git svn find-rev $head`"
>  		fi
>
> -		# Check for uncommitted changes
> -		if git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
> +		# Check for uncommitted changes.
> +		# First, with git-status, but --no-optional-locks is only
> +		# supported in git >= 2.14, so fall back to git-diff-index if
> +		# it fails. Note that git-diff-index does not refresh the
> +		# index, so it may give misleading results. See
> +		# git-update-index(1), git-diff-index(1), and git-status(1).
> +		local git_status
> +		git_status="$(git --no-optional-locks status -uno --porcelain 2>/dev/null)"
> +		if [ $? -eq 0 ]; then
> +			if echo "$git_status" | grep -qv '^.. scripts/package'; then

Shouldn't this be:

	if printf '%s' "$git_status" | grep -qv '^.. scripts/package'; then

I.e., use printf not echo? Because of echo introducing a newline.

With echo:
	$ x=$(printf ''); if echo "$x" | grep -qv 'ignore'; then echo dirty; fi
	dirty
	$ x=$(printf '\n'); if echo "$x" | grep -qv 'ignore'; then echo dirty; fi
	dirty
	$ x=$(printf 'ignore\n'); if echo "$x" | grep -qv 'ignore'; then echo dirty; fi
	$ x=$(printf 'untracked\n'); if echo "$x" | grep -qv 'ignore'; then echo dirty; fi
	dirty

With printf:
	$ x=$(printf ''); if printf '%s' "$x" | grep -qv 'ignore'; then echo dirty; fi
	$ x=$(printf '\n'); if printf '%s' "$x" | grep -qv 'ignore'; then echo dirty; fi
	$ x=$(printf 'ignore\n'); if printf '%s' "$x" | grep -qv 'ignore'; then echo dirty; fi
	$ x=$(printf 'untracked\n'); if printf '%s' "$x" | grep -qv 'ignore'; then echo dirty; fi
	dirty

(Hopefully I'm not missing something.)
