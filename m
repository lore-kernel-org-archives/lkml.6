Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BF4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D342243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D342243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbeKNVez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:34:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:56350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727598AbeKNVez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:34:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76B1AAF76;
        Wed, 14 Nov 2018 11:32:01 +0000 (UTC)
Date:   Wed, 14 Nov 2018 12:31:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chanho Min <chanho.min@lge.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Seungho Park <seungho1.park@lge.com>,
        Inkyu Hwang <inkyu.hwang@lge.com>,
        Donghwan Jung <donghwan.jung@lge.com>,
        Jongsung Kim <neidhard.kim@lge.com>
Subject: Re: [PATCH v2] exec: make de_thread() freezable
Message-ID: <20181114113159.GR23419@dhcp22.suse.cz>
References: <1541994885-20059-1-git-send-email-chanho.min@lge.com>
 <20181113145339.GD16182@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113145339.GD16182@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-11-18 15:53:39, Michal Hocko wrote:
> On Mon 12-11-18 12:54:45, Chanho Min wrote:
> > Suspend fails due to the exec family of functions blocking the freezer.
> > The casue is that de_thread() sleeps in TASK_UNINTERRUPTIBLE waiting for
> > all sub-threads to die, and we have the deadlock if one of them is frozen.
> > This also can occur with the schedule() waiting for the group thread leader
> > to exit if it is frozen.
> > 
> > In our machine, it causes freeze timeout as bellows.
> > 
> > Freezing of tasks failed after 20.010 seconds (1 tasks refusing to freeze, wq_busy=0):
> > setcpushares-ls D ffffffc00008ed70     0  5817   1483 0x0040000d
> >  Call trace:
> > [<ffffffc00008ed70>] __switch_to+0x88/0xa0
> > [<ffffffc000d1c30c>] __schedule+0x1bc/0x720
> > [<ffffffc000d1ca90>] schedule+0x40/0xa8
> > [<ffffffc0001cd784>] flush_old_exec+0xdc/0x640
> > [<ffffffc000220360>] load_elf_binary+0x2a8/0x1090
> > [<ffffffc0001ccff4>] search_binary_handler+0x9c/0x240
> > [<ffffffc00021c584>] load_script+0x20c/0x228
> > [<ffffffc0001ccff4>] search_binary_handler+0x9c/0x240
> > [<ffffffc0001ce8e0>] do_execveat_common.isra.14+0x4f8/0x6e8
> > [<ffffffc0001cedd0>] compat_SyS_execve+0x38/0x48
> > [<ffffffc00008de30>] el0_svc_naked+0x24/0x28
> > 
> > To fix this, make de_thread() freezable. It looks safe and works fine.
> 
> It's been some time since I have looked into this code so bear with me.
> One thing is not really clear to me. Why does it help to exclude this
> particular task from the freezer when it is not sleeping in the freezer.
> I can see how other threads need to be zapped and TASK_WAKEKILL doesn't
> do that but shouldn't we fix that instead?
> 
> Or maybe I am missing something important here.

Just to not distract from the quick fix. This will silence the freezer
but I believe that we need a better fix to not block exec by freezer
long term. It seems much more complicated though so a quick fix makes
some sense for now.

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
