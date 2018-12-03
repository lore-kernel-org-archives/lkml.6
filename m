Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2532C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D65206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D65206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbeLCNRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:17:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:46596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbeLCNRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:17:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DA1BAC5A;
        Mon,  3 Dec 2018 13:16:32 +0000 (UTC)
Date:   Mon, 3 Dec 2018 14:16:31 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: don't unconditionally shortcut print_time()
Message-ID: <20181203131631.n4uzbh2tdlskobg5@pathway.suse.cz>
References: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181129141921.djeumz723fr7pasn@pathway.suse.cz>
 <201811300226.wAU2Q2JG060388@www262.sakura.ne.jp>
 <20181130123027.cyqfi2k34nh2gjmx@pathway.suse.cz>
 <02b4ce85-c1e5-6601-e3a7-cecfbd5298dc@i-love.sakura.ne.jp>
 <8634f952-7a14-055d-943c-d219ab5d8c1b@i-love.sakura.ne.jp>
 <1c1de4f8-f08e-37e5-2438-47ab985d476e@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1de4f8-f08e-37e5-2438-47ab985d476e@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2018-12-02 14:02:28, Tetsuo Handa wrote:
> On 2018/12/02 8:49, kbuild test robot wrote:
> >> kernel/printk/printk.c:2396:5: error: 'printk_time' undeclared (first use in this function)
>         ^~~~~~~~~~~
> Thanks. printk_time depends on CONFIG_PRINTK=y. Added a dummy definition.
> 
> 
> 
> >From f903b9fa36159472a207f93e2405e45e3999f650 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sun, 2 Dec 2018 13:57:01 +0900
> Subject: [PATCH v2] printk: fix printk_time race.
> 
> Since printk_time can be toggled via /sys/module/printk/parameters/time ,
> it is not safe to assume that output length does not change across
> multiple msg_print_text() calls. If we hit this race, we can observe
> failures such as SYSLOG_ACTION_READ_ALL writes more bytes than userspace
> has supplied, SYSLOG_ACTION_SIZE_UNREAD returns -EFAULT when succeeded,
> SYSLOG_ACTION_READ reads garbage memory or even triggers an kernel oops
> at _copy_to_user() due to integer overflow.
> 
> To close this race, get a snapshot value of printk_time and pass it to
> SYSLOG_ACTION_READ, SYSLOG_ACTION_READ_ALL, SYSLOG_ACTION_SIZE_UNREAD and
> kmsg_dump_get_buffer().
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

The patch looks good to me.

Acked-by: Petr Mladek <pmladek@suse.com>

I'll wait few more days for an eventual feedback before I push it
into printk.git.

Best Regards,
Petr
