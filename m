Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EED6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E4D2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DZjWOdgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E4D2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeKHEQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:16:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39118 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeKHEQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:16:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so7682938pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 10:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GeINo/k3+aADKtUi/bndFuPJ1JmVtBQL/rueuoH+QB0=;
        b=DZjWOdgp7V5O9EXMFQQ9dcVpLocqT/AJCaY/dfTVfuPOAITptgW83c0/AADwopFvoW
         NwcBK+rjP3ldlsT0SIgWxU5gIlDywQOyIMdiWtMamMKxZ1Fn0NUFTKgvokQCCIe13J3W
         hRZUPn3d7odbIP2zQESrYlJ3hJsHLf29xP86I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GeINo/k3+aADKtUi/bndFuPJ1JmVtBQL/rueuoH+QB0=;
        b=E1O6gEyPFxihFg9ALESdgy8IbmXbPUp47AM+G8V0KXJBxEWvF9nmmEhQccixP4nGui
         t+hRZegQSc3OqNSFaw8B2D1QNjvdQAZowSSrq5v0oARcYSIHW8LIbHNlWNDz7+VP63ym
         OVG/I/HTdw0CPElrMwJyXz2v133NEZrnOPfM4cCQ3PLzkLyyEVYrORNxxIGuMYXJyIA5
         NKmignI25JhQJEDObRS2p1rO/syz7v7T3ySmn/W85lCT95JzGkfUCR1BTbkioIb7XP9B
         C3Z4ElGyZDJkrmTiO6r8kEo7yUuuhBDGBb+1IPQVGxrgLVJObtiPlTpZ8nHKX+m7zU0L
         hXAg==
X-Gm-Message-State: AGRZ1gLskqFnLoSqI1BQo+16KxhT6R7bDyvebLSfEJu7yIfyBoVAHx7l
        P04+xISiN8VxwduHP0aaEgIk5mTRTzs=
X-Google-Smtp-Source: AJdET5een1Mpkkbu+kXKhUiLHOkUDg0VMzFon7I70d8HKTYeoXnVhyJkzyj9Lne39Ae/daFwqK7O6g==
X-Received: by 2002:a62:250:: with SMTP id 77-v6mr1415929pfc.16.1541616282201;
        Wed, 07 Nov 2018 10:44:42 -0800 (PST)
Received: from google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id 196-v6sm4406423pfc.71.2018.11.07.10.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 10:44:40 -0800 (PST)
Date:   Wed, 7 Nov 2018 10:44:37 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     lists@nerdbynature.de
Cc:     sky@genki.is, Guenter Roeck <linux@roeck-us.net>,
        yamada.masahiro@socionext.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
Message-ID: <20181107184435.GA168339@google.com>
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
 <20181106.192305.406697677@genki.is>
 <20181107022156.GA254567@google.com>
 <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
 <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 08:00:36PM -0800, Brian Norris wrote:
> On a different tangent: how about the --no-optional-locks (see
> git(1))? Will this get you your "up-to-date" result without writing to
> the .git directory? I've only read the documentation, but not tested
> it.

I think I can add a little to this: that option definitely avoids
writing to the git index (thus, avoiding the problem that Guenter and I
are trying to resolve) and the documentation suggests it should still
get up-to-date index information (thus, avoiding the problem that Genki
was trying to fix). So something like this would work (on top of the
revert):

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 71f39410691b..7dfe45badcca 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -74,7 +74,7 @@ scm_version()
 		fi
 
 		# Check for uncommitted changes
-		if git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
+		if git --no-optional-locks status -uno --porcelain | grep -qv '^.. scripts/package'; then
 			printf '%s' -dirty
 		fi
 
Unfortunately, --no-optional-locks is new as of git 2.14. Dunno how new
of a git we expect people to use.

Brian
