Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F24FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF82B2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF82B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLCIjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:39:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:52290 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725968AbeLCIjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:39:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5E14AEC6;
        Mon,  3 Dec 2018 08:39:44 +0000 (UTC)
Date:   Mon, 3 Dec 2018 09:39:42 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chanho Min <chanho.min@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181203083942.GF31738@dhcp22.suse.cz>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
 <20181203074700.GA21240@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203074700.GA21240@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-12-18 08:47:00, Ingo Molnar wrote:
[...]
> I reviewed the ->cred_guard_mutex code, and the mutex is held across all 
> of exec() - and we always did this.

Yes, this is something that has been pointed out during the review. Oleg
has argued that making this path freezable is really hard and that we
should be changing de_thread to sleep withtou cred_guard_mutex long term
anyway (http://lkml.kernel.org/r/20181114143705.GB13885@redhat.com).

Failing suspend seems like a real problem while the lockdep one doesn't
really reflect any real deadlock, right? So while the patch is not
perfect it shouldn't make the situation much worse. Lockdep splat is
certainly annoying but is it any worse than a suspend failing?

Now, I wouldn't mind to revert this because the code is really old and
we haven't seen many bug reports about failing suspend yet. But what is
the actual plan to make this work properly? Use
freezable_schedule_unsafe instead? Freezer code has some
fundamental design issues which are quite hard to get over.
-- 
Michal Hocko
SUSE Labs
