Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF0CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024D02098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024D02098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbeIXTVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:21:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:56720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728792AbeIXTVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:21:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38437B022;
        Mon, 24 Sep 2018 13:19:36 +0000 (UTC)
Date:   Mon, 24 Sep 2018 15:19:35 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
cc:     penguin-kernel@i-love.sakura.ne.jp,
        syzbot+6fb572170402d311dd39@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>, syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: INFO: task hung in fsnotify_connector_destroy_workfn (2)
In-Reply-To: <CAOQ4uxhmFsvy6y6NgcFPs4NF1Lg7J0h2VoWgiL8WfXdDz+Z0FQ@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1809241511500.15880@cbobk.fhfr.pm>
References: <0000000000006364200575dfc280@google.com> <2f4ce251-cf84-8bd2-72fc-a3ff687d5188@I-love.SAKURA.ne.jp> <CAOQ4uxhmFsvy6y6NgcFPs4NF1Lg7J0h2VoWgiL8WfXdDz+Z0FQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2018, Amir Goldstein wrote:

> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    11da3a7f84f1 Linux 4.19-rc3
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=141ffbca400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9917ff4b798e1a1e
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=6fb572170402d311dd39
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136a60ae400000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+6fb572170402d311dd39@syzkaller.appspotmail.com
> > >
> >
> > Since it kept printk()ing for at least 93 seconds, it might have kept for 150 seconds.
> >
> > [  174.614333] hid-generic 0000:0000:0000.0003: unknown main item tag 0x0
> > [  268.196102] INFO: task kworker/u4:1:23 blocked for more than 140 seconds.
> >
> > Since the reproducer is simple, this might be lockup due to continuous printk().
> > If syzbot can reliably reproduce this problem using the reproducer, try
> > ratelimiting printk().
> 
> Right.. and I was able to reproduce after setting CONFIG_HID_GENERIC=y
> but unless I am missing something, the core problem doesn't seem related to
> fsnotify and $SUBJECT, so CCing HID maintainer.

Alright, so you're basically triggering a never-ending flow of kmsgs being 
printed out from HID parser due to doing crazy things with the parser, and 
that causes the issues for the kworker trying to flush them out.

I guess the patch below fixes it, however the kworker should not really be 
blocked by this I think ... adding a few more printk folks to double-check 
why the kworker would get stuck due to massive printk() flood.

diff --git a/include/linux/hid.h b/include/linux/hid.h
index d44a78362942..b81332fe85a4 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1157,22 +1157,22 @@ do {									\
 } while (0)
 
 #define hid_printk(level, hid, fmt, arg...)		\
-	dev_printk(level, &(hid)->dev, fmt, ##arg)
+	dev_printk_ratelimited(level, &(hid)->dev, fmt, ##arg)
 #define hid_emerg(hid, fmt, arg...)			\
-	dev_emerg(&(hid)->dev, fmt, ##arg)
+	dev_emerg_ratelimited(&(hid)->dev, fmt, ##arg)
 #define hid_crit(hid, fmt, arg...)			\
-	dev_crit(&(hid)->dev, fmt, ##arg)
+	dev_crit_ratelimited(&(hid)->dev, fmt, ##arg)
 #define hid_alert(hid, fmt, arg...)			\
-	dev_alert(&(hid)->dev, fmt, ##arg)
+	dev_alert_ratelimited(&(hid)->dev, fmt, ##arg)
 #define hid_err(hid, fmt, arg...)			\
-	dev_err(&(hid)->dev, fmt, ##arg)
+	dev_err_ratelimited(&(hid)->dev, fmt, ##arg)
 #define hid_notice(hid, fmt, arg...)			\
-	dev_notice(&(hid)->dev, fmt, ##arg)
+	dev_notice_ratelimited(&(hid)->dev, fmt, ##arg)
 #define hid_warn(hid, fmt, arg...)			\
-	dev_warn(&(hid)->dev, fmt, ##arg)
+	dev_warn_ratelimited(&(hid)->dev, fmt, ##arg)
 #define hid_info(hid, fmt, arg...)			\
-	dev_info(&(hid)->dev, fmt, ##arg)
+	dev_info_ratelimited(&(hid)->dev, fmt, ##arg)
 #define hid_dbg(hid, fmt, arg...)			\
-	dev_dbg(&(hid)->dev, fmt, ##arg)
+	dev_dbg_ratelimited(&(hid)->dev, fmt, ##arg)
 
 #endif

-- 
Jiri Kosina
SUSE Labs

