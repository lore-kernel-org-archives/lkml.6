Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EB8C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D910620874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D910620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937950AbeFSM4b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:56:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:39149 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937770AbeFSM4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:56:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B6FA0ACD9;
        Tue, 19 Jun 2018 12:56:28 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 21563A0A1B; Tue, 19 Jun 2018 14:56:28 +0200 (CEST)
Date:   Tue, 19 Jun 2018 14:56:28 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: regression: /proc/$pid/cmdline lacks trailing '\0' in 4.18-rc1
Message-ID: <20180619125628.fso5wyqsgo7hgh33@unicorn.suse.cz>
References: <20180619060754.voy2nziqwl5ehfp5@unicorn.suse.cz>
 <20180619092254.kmww3fpqjqcsjrna@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619092254.kmww3fpqjqcsjrna@unicorn.suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:22:55AM +0200, Michal Kubecek wrote:
> On Tue, Jun 19, 2018 at 08:07:55AM +0200, Michal Kubecek wrote:
> > In v4.18-rc1, /proc/$pid/cmdline is missing final null byte which used
> > to be there in v4.17 and older kernels:
> > 
> > 4.17.1:
> > tweed:~ # cat /proc/self/cmdline | od -t c
> > 0000000   c   a   t  \0   /   p   r   o   c   /   s   e   l   f   /   c
> > 0000020   m   d   l   i   n   e  \0
> > 0000027
> > 
> > 4.18-rc1:
> > lion:~ # cat /proc/self/cmdline | od -t c
> > 0000000   c   a   t  \0   /   p   r   o   c   /   s   e   l   f   /   c
> > 0000020   m   d   l   i   n   e
> > 0000026
> > 
> > The code has been rewritten quite a lot in 4.18-rc1 so I didn't find yet
> > where exactly does the change come from. Still looking.
> 
> The issue was introduced by commit 5ab827189965 ("fs/proc: simplify and
> clarify get_mm_cmdline() function"). The problem is that when looking
> for the null character at or after args_end, strnlen() is used and it
> returns the length _without_ the null character (if there is one) so
> that we don't copy it.
> 
> I'll submit a patch once I test it.

It was more complicated than I thought. The patch below seems to resolve
the issue but I'll need to run more tests before I'm confident to submit
it officially.

Michal Kubecek



From: Michal Kubecek <mkubecek@suse.cz>
Date: Tue, 19 Jun 2018 14:47:23 +0200
Subject: [PATCH] proc: add missing '\0' back to /proc/$pid/cmdline

Recent rewrite introduced a regression, /proc/$pid/cmdline is missing the
trailing null character:

mike@lion:/tmp> cat /proc/self/cmdline | od -t c
0000000   c   a   t  \0   /   p   r   o   c   /   s   e   l   f   /   c
0000020   m   d   l   i   n   e
0000026

This is because strnlen() is used to search for the null character but it
returns the length without it so that we need to copy one byte more (but
only if we actually found a null character). And once we pass the null
character to userspace we need to make sure next read returns 0 (EOF).

This is another problem, even if rather theoretical one: if userspace seeks
to arg_end or past it, we only start checking for null character from that
position so that we may return random segment of environment rather then
EOF.

Resolve both by always starting no later than at arg_end-1 (so that we
always catch the right null character) but don't copy data until we reach
the requested start position.

Fixes: 5ab827189965 ("fs/proc: simplify and clarify get_mm_cmdline() function")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 fs/proc/base.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b6572944efc3..ac60405f5015 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -209,7 +209,8 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
 			      size_t count, loff_t *ppos)
 {
 	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long pos, len;
+	unsigned long req_pos, pos, len;
+	bool end_found = false;
 	char *page;
 
 	/* Check if process spawned far enough to have cmdline. */
@@ -236,25 +237,27 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
 		env_start = env_end = arg_end;
 
 	/* We're not going to care if "*ppos" has high bits set */
-	pos = arg_start + *ppos;
+	req_pos = arg_start + *ppos;
 
 	/* .. but we do check the result is in the proper range */
-	if (pos < arg_start || pos >= env_end)
+	if (req_pos < arg_start || req_pos >= env_end)
 		return 0;
 
 	/* .. and we never go past env_end */
-	if (env_end - pos < count)
+	if (env_end - req_pos < count)
 		count = env_end - pos;
 
+	pos = min_t(unsigned long, req_pos, arg_end - 1);
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
 
 	len = 0;
-	while (count) {
+	while (count && !end_found) {
 		int got;
-		size_t size = min_t(size_t, PAGE_SIZE, count);
+		size_t size = count + (pos < req_pos ? req_pos - pos : 0);
 
+		size = min_t(size_t, PAGE_SIZE, size);
 		got = access_remote_vm(mm, pos, page, size, FOLL_ANON);
 		if (got <= 0)
 			break;
@@ -276,11 +279,23 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
 				n = arg_end - pos - 1;
 
 			/* Cut off at first NUL after 'n' */
-			got = n + strnlen(page+n, got-n);
+			n += strnlen(page+n, got-n);
+			got = min_t(int, got, n + 1);
+			end_found = !page[n];
 			if (!got)
 				break;
 		}
 
+		if (pos + got <= req_pos) {
+			/* got > 0 here so that pos always advances */
+			pos += got;
+			continue;
+		}
+
+		if (pos < req_pos) {
+			got -= (req_pos - pos);
+			pos = req_pos;
+		}
 		got -= copy_to_user(buf, page, got);
 		if (unlikely(!got)) {
 			if (!len)
-- 
2.17.1

