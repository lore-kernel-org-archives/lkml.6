Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA30C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE4C2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE4C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbeLCMEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:04:13 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59144 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeLCMEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:04:12 -0500
Received: from 79.184.252.87.ipv4.supernova.orange.pl (79.184.252.87) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id 8a403304dd5b4437; Mon, 3 Dec 2018 13:03:25 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chanho Min <chanho.min@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux 4.20-rc4)
Date:   Mon, 03 Dec 2018 13:03:16 +0100
Message-ID: <1718869.PGhsHE7EHz@aspire.rjw.lan>
In-Reply-To: <20181203083942.GF31738@dhcp22.suse.cz>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com> <20181203074700.GA21240@gmail.com> <20181203083942.GF31738@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 3, 2018 9:39:42 AM CET Michal Hocko wrote:
> On Mon 03-12-18 08:47:00, Ingo Molnar wrote:
> [...]
> > I reviewed the ->cred_guard_mutex code, and the mutex is held across all 
> > of exec() - and we always did this.
> 
> Yes, this is something that has been pointed out during the review. Oleg
> has argued that making this path freezable is really hard and that we
> should be changing de_thread to sleep withtou cred_guard_mutex long term
> anyway (http://lkml.kernel.org/r/20181114143705.GB13885@redhat.com).
> 
> Failing suspend seems like a real problem while the lockdep one doesn't
> really reflect any real deadlock, right? So while the patch is not
> perfect it shouldn't make the situation much worse. Lockdep splat is
> certainly annoying but is it any worse than a suspend failing?
> 
> Now, I wouldn't mind to revert this because the code is really old and
> we haven't seen many bug reports about failing suspend yet. But what is
> the actual plan to make this work properly? Use
> freezable_schedule_unsafe instead? Freezer code has some
> fundamental design issues which are quite hard to get over.

I agree and we just need to look deeper into this.

I had hoped that this would work since you and Oleg agreed with it, but since
it doesn't, let's do a revert for now and get back to this later.

Thanks,
Rafael

