Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC1CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E0E2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQcDvRiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E0E2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeKHG1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:27:24 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41750 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeKHG1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:27:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id e22-v6so8215916pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 12:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qh8SUCvk0AdcvaB+4Ld0PBDQj8TxGPAmkD/Ka4xWprA=;
        b=vQcDvRiW1jh7mdPL/oQ1ufq/GSQl/U+4Hp4pbU8+yqxwdyQn965ZYJKdnD+2d2cltq
         df+HWOjUmf9K/mebKUv3E3M9wYneb3gkSkXe7bJFhxz+Cy4f/tnT3cUZpvZw0oCmke7w
         0dovzS1GDK446HjIa7npfAfdxx24uURROGwchjP8zMOKK7fAJWiF+BaTAj3QCDXn8FVE
         ncUyA3/vC9ZFNre3sP8N1npeXytxref+5K5sM5mYgucgMIaTORH1PX02aogElRyKPYyq
         4QuMcOp8/N519Z1pZMBBqOg4ab6EgCiKPjyRcm2IcCsGeKpuNfEazIcEgjPm/SuCItkO
         uffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qh8SUCvk0AdcvaB+4Ld0PBDQj8TxGPAmkD/Ka4xWprA=;
        b=HASmv9FHom8I9lupqwuVHijiAy0sU7oiCeoj4X7riV9RPi16vYZq1/GQwBKEeiJiIi
         zTIlsl20OH4K8llfoNLzapPFdfKQBF03gvNg5e4beQhZlv8xcDuZzsICqfFKoIOpqzd2
         kGx4hqEYi9aXk6DDqAsrtCaSZ0S/EFR0nxVY4prRX+XDBBDf66zWpE6VL35CHkaJlWGQ
         hRIvVRjwyDJJQI5NwJDDtgFmzgtSCmH2ZmE/DsSbue8LmB4pGghDegt0wdHFiaBnXhYt
         owS1T+Mkvh0dcQsZS21iUSmbWiQjSArh8cppmdwNVbqYhzWOkLrodnVFyukl6riNGD10
         yyHA==
X-Gm-Message-State: AGRZ1gJNj4vkb2dldCopn97BwYjzpYOwtuZAmZrMVsYh5LjImn3v6udk
        Pl0A3TPJN+Xzzlp8wiD+XgM=
X-Google-Smtp-Source: AJdET5e5ucSm2aK3aJVA6O6mDkx3c2LfzHD7TzPbpTn/PAiIA11N0ndtapwcs6w9vguDTikIORX4xA==
X-Received: by 2002:a62:3501:: with SMTP id c1-v6mr1783806pfa.173.1541624116554;
        Wed, 07 Nov 2018 12:55:16 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g21-v6sm1472895pgh.82.2018.11.07.12.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 12:55:15 -0800 (PST)
Date:   Wed, 7 Nov 2018 12:55:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Genki Sky <sky@genki.is>
Cc:     Brian Norris <briannorris@chromium.org>, lists@nerdbynature.de,
        yamada.masahiro@socionext.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
Message-ID: <20181107205514.GB12273@roeck-us.net>
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
 <20181106.192305.406697677@genki.is>
 <20181107022156.GA254567@google.com>
 <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
 <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
 <20181107184435.GA168339@google.com>
 <20181107.204358.257636196@genki.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107.204358.257636196@genki.is>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 12:43:58PM -0800, Genki Sky wrote:
> On Wed, 7 Nov 2018 10:44:37 -0800, Brian Norris <briannorris@chromium.org> wrote:
> > On Tue, Nov 06, 2018 at 08:00:36PM -0800, Brian Norris wrote:
> > > On a different tangent: how about the --no-optional-locks (see
> > > git(1))? Will this get you your "up-to-date" result without writing to
> > > the .git directory? I've only read the documentation, but not tested
> > > it.
> 
> This option definitely seems to be what we want, good find.
> 
> > Unfortunately, --no-optional-locks is new as of git 2.14. Dunno how new
> > of a git we expect people to use.
> 
> Hmm, I'm not sure who can speak to this.
> 
> Though if it's too recent, then based on earlier discussion, it sounds
> like something like this (hack) might work best:
> 
>   [ -w .git ] &&
>           touch .git/some-file-here 2>/dev/null &&
>           git update-index --refresh --unmerged >/dev/null
>   if git diff-index --name-only HEAD | ...

I do not think it is a good idea to create a random file in the .git directory
under any circumstance, and much less so if an output directory was specified,
no matter if the path is read-only or not. I also still think that it is a
bad idea to touch the source tree if an output directory was specified.
It defeats the purpose of specifying an output directory.

Ubuntu 16.04 ships with git version 2.7.4.

Guenter
