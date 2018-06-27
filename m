Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2038C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7044926104
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7044926104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754626AbeF0PGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:06:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:50888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754530AbeF0PGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:06:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AD9E6ADF4;
        Wed, 27 Jun 2018 15:06:42 +0000 (UTC)
Date:   Wed, 27 Jun 2018 17:06:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Namit Gupta <gupta.namit@samsung.com>,
        linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        a.sahrawat@samsung.com, himanshu.m@samsung.com
Subject: Re: [PATCH] printk: remove unnecessary kmalloc() from syslog during
 clear
Message-ID: <20180627150641.p56xyy6mdzvnfpig@pathway.suse.cz>
References: <CGME20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2@epcas5p3.samsung.com>
 <20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com>
 <20180625133705.7zsg2rkw4xtyg6ie@pathway.suse.cz>
 <20180625103704.49811ec1@gandalf.local.home>
 <20180625144407.GB443@tigerII.localdomain>
 <20180626124332.62isabqkefpgqpgk@pathway.suse.cz>
 <20180626103959.79e92a35@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626103959.79e92a35@gandalf.local.home>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-06-26 10:39:59, Steven Rostedt wrote:
> On Tue, 26 Jun 2018 14:43:32 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > On Mon 2018-06-25 23:44:07, Sergey Senozhatsky wrote:
> > > On (06/25/18 10:37), Steven Rostedt wrote:  
> > > > 
> > > > Is IMHO rather ugly.  
> > > 
> > > Either way works for me. So I'll leave it to you and Petr to decide :)
> > >   
> > > > And the original patch has one more advantage. If buf and clear are
> > > > both NULL/zero, we don't take any locks.  
> > > 
> > > But we never use syslog_print_all(buf = NULL, clear = false). It's either
> > > NULL/true [move forward clear idx, do not copy to user], or !NULL/use defined
> > > value [copy to user, move or don't move clear idx forward]  
> > 
> > Yup, I suggest the following version as a compromise. It has the code
> > duplication but I agree that it is negligible. Otherwise, it looks
> > cleaner.
> > 
> 
> This looks fine. For proper history though, what I do in this case,
> would be to make this into two patches. One with Namit's original
> patch, and then a second that removes the code duplication (your patch).

Makes sense. I have just pushed the original patch (with Sergey's
formatting fixes) into printk.git, for-4.19 branch. And I propose
the clean up patch, see below.

I am sorry for the mess. It seems that nothing can be considered
a simple obvious change. And my attempt to safe people time had
the opposite effect.


Proposed patch:

From: Petr Mladek <pmladek@suse.com>
Date: Wed, 27 Jun 2018 16:37:42 +0200
Subject: [PATCH] printk: Clean up syslog_print_all()

syslog_print_all() is called twice. Once with a valid buffer
and once just to set the indexes.

Both variants are already handled separately. This patch just
makes it more obvious. It does not change the existing behavior.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 16b02cc51a14..fcc1992c040a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1356,16 +1356,6 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	u64 seq;
 	u32 idx;
 
-	if (!buf) {
-		if (clear) {
-			logbuf_lock_irq();
-			clear_seq = log_next_seq;
-			clear_idx = log_next_idx;
-			logbuf_unlock_irq();
-		}
-		return 0;
-	}
-
 	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
@@ -1437,6 +1427,14 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	return len;
 }
 
+static void syslog_clear(void)
+{
+	logbuf_lock_irq();
+	clear_seq = log_next_seq;
+	clear_idx = log_next_idx;
+	logbuf_unlock_irq();
+}
+
 int do_syslog(int type, char __user *buf, int len, int source)
 {
 	bool clear = false;
@@ -1481,7 +1479,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Clear ring buffer */
 	case SYSLOG_ACTION_CLEAR:
-		syslog_print_all(NULL, 0, true);
+		syslog_clear();
 		break;
 	/* Disable logging to console */
 	case SYSLOG_ACTION_CONSOLE_OFF:
-- 
2.13.7

