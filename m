Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE39C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EEC20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EEC20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeH3WuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:50:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:54928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726959AbeH3WuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:50:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4CC93ACC2;
        Thu, 30 Aug 2018 18:46:40 +0000 (UTC)
Date:   Thu, 30 Aug 2018 20:46:39 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: efi boot failures due to PTI with 32 bit builds and Intel CPUs
Message-ID: <20180830184639.6iv5itjex6y45w3j@suse.de>
References: <20180829201659.GA29801@roeck-us.net>
 <20180830071951.dv6wgnn6ikfhh7yt@suse.de>
 <f6d9bdcd-98a6-fcf2-5308-936ffd714ea7@roeck-us.net>
 <20180830113059.qj6yvw4ggktc7yex@suse.de>
 <915dca84-c98a-fc63-3210-b21dd926b3d4@roeck-us.net>
 <20180830180849.nmh646ehnolphq4v@suse.de>
 <CA+55aFzQwC59pkeA+T3E0G4SZe4dQsYcmnf1eKGYnYpcPTKhSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzQwC59pkeA+T3E0G4SZe4dQsYcmnf1eKGYnYpcPTKhSQ@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:21:49AM -0700, Linus Torvalds wrote:
> On Thu, Aug 30, 2018 at 11:08 AM Joerg Roedel <jroedel@suse.de> wrote:
> >
> > Without a mapped GDT the #PF and #DF handlers also can't be started, so
> > the machine triple-faults. Below diff fixes it for me, I'll send a
> > proper patch tomorrow.
> 
> Hmm. Is there any reason why this code doesn't just use
> 
>         load_fixmap_gdt(0);

No idea, probably the function didn't exist when the code was written?
I can change that when writing the patch.

> and shouldn't it do it after loading the new %cr3?

That seems more robust, yes. No sure if the old %cr3
(initial_page_table) has the fixmap gdt mapped at all.


	Joerg
