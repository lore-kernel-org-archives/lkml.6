Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBEFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDF120838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TQsRxu1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDF120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeH3WZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:25:26 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:46309 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbeH3WZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:25:26 -0400
Received: by mail-io0-f178.google.com with SMTP id y12-v6so8330742ioj.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 11:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FI+I6cRkCEmaetFhFsSJwsPWcCR5w+Fm8VmnGlTb/XM=;
        b=TQsRxu1GeiuOi2kTovr0zkX7HJgJhpkD5RCgNLsuesfN0621etXh2Bj30oARKMOIR9
         /yvpv/DFqyZzYlIikcSBHPWCKS2HkU5ooAHKSezVVdksAMGP/tVKZREb3DKNfSX9LE8r
         40SKjz4QE00drYh23rop9QW9DOtioJiqOxGF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FI+I6cRkCEmaetFhFsSJwsPWcCR5w+Fm8VmnGlTb/XM=;
        b=CSu0I4d7w08nwgZRB4FsGzmtl5KEgbv2vCbitGrQke9+fHvAyLYG1vcxnY/Pbd8ZYu
         M2mSACFG9q7xaCWvGYM+75+aZmRW7fD8oe2KiHSRmgLHp+WCOnp8oOE4zczdMxd7nixz
         rKV69qImIWqKAfHsTnRP6Fe+liVqlc+vLqhJWDsRN9VJsTLeSYdQ6Qo2d0pWIiPphWYn
         2fxrJ0sFFLynWRjAiVHltfZhoNef7heHDI1v7JOOUNP4yat8e1faV8Pdcv0HLjDYvnGK
         mz7WSQWgL2BISvCD+hx+fa95cr+wRZsYOFemrQ4q9vEak43Vc4Kj/vw+Zg9fEAU+s6GU
         6s2Q==
X-Gm-Message-State: APzg51BmjdE8e4RqGY9kItmvV/VKhT9SQy4QFqCQCFd6d4yYyd83uiqa
        YHibJORvBY8ypuXyEJ9eGZTHCWUbETJk7D0lCoODUMaD
X-Google-Smtp-Source: ANB0VdYMRbjGaTzZ75sE7WrhqCnEeskw5fRgcqmp+VjJjdoNIniQBY5LYSi7JeYwnIaKilw8otIDngAiyWk0DHuTEz4=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr10523014ioh.203.1535653321032;
 Thu, 30 Aug 2018 11:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180829201659.GA29801@roeck-us.net> <20180830071951.dv6wgnn6ikfhh7yt@suse.de>
 <f6d9bdcd-98a6-fcf2-5308-936ffd714ea7@roeck-us.net> <20180830113059.qj6yvw4ggktc7yex@suse.de>
 <915dca84-c98a-fc63-3210-b21dd926b3d4@roeck-us.net> <20180830180849.nmh646ehnolphq4v@suse.de>
In-Reply-To: <20180830180849.nmh646ehnolphq4v@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Aug 2018 11:21:49 -0700
Message-ID: <CA+55aFzQwC59pkeA+T3E0G4SZe4dQsYcmnf1eKGYnYpcPTKhSQ@mail.gmail.com>
Subject: Re: efi boot failures due to PTI with 32 bit builds and Intel CPUs
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:08 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> Without a mapped GDT the #PF and #DF handlers also can't be started, so
> the machine triple-faults. Below diff fixes it for me, I'll send a
> proper patch tomorrow.

Hmm. Is there any reason why this code doesn't just use

        load_fixmap_gdt(0);

and shouldn't it do it after loading the new %cr3?

               Linus
