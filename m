Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBEEC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ECD23FB2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2ECD23FB2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754172AbeFVJuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:50:51 -0400
Received: from verein.lst.de ([213.95.11.211]:55640 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751242AbeFVJuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:50:50 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D8C9668E45; Fri, 22 Jun 2018 12:00:14 +0200 (CEST)
Date:   Fri, 22 Jun 2018 12:00:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <xiaolong.ye@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Subject: Re: [lkp-robot] [fs] 3deb642f0d: will-it-scale.per_process_ops
        -8.8% regression
Message-ID: <20180622100014.GA12425@lst.de>
References: <20180622082752.GX11011@yexl-desktop> <CA+55aFw5ghByk_zCN25G6rPPSAQma3Mh0t4s18CtLg=h6U9+Zg@mail.gmail.com> <20180622095608.GA12263@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622095608.GA12263@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And a version with select() also covered:

---
From 317159003ae28113cf759c632b161fb39192fe3c Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 22 Jun 2018 11:36:26 +0200
Subject: fs: optimize away ->_qproc indirection for poll_mask based polling

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/select.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/select.c b/fs/select.c
index bc3cc0f98896..2c9d81892509 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -528,6 +528,24 @@ static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 					wait_key_set(wait, in, out, bit,
 						     busy_flag);
 					mask = vfs_poll(f.file, wait);
+					if (f.file->f_op->poll) {
+						mask = f.file->f_op->poll(f.file, wait);
+					} else if (file_has_poll_mask(f.file)) {
+						struct wait_queue_head *head;
+
+						head = f.file->f_op->get_poll_head(f.file, wait->_key);
+						if (!head) {
+							mask = DEFAULT_POLLMASK;
+						} else if (IS_ERR(head)) {
+							mask = EPOLLERR;
+						} else {
+							if (wait->_qproc)
+								__pollwait(f.file, head, wait);
+							mask = f.file->f_op->poll_mask(f.file, wait->_key);
+						}
+					} else {
+						mask = DEFAULT_POLLMASK;
+					}
 
 					fdput(f);
 					if ((mask & POLLIN_SET) && (in & bit)) {
@@ -845,7 +863,25 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
 	/* userland u16 ->events contains POLL... bitmap */
 	filter = demangle_poll(pollfd->events) | EPOLLERR | EPOLLHUP;
 	pwait->_key = filter | busy_flag;
-	mask = vfs_poll(f.file, pwait);
+	if (f.file->f_op->poll) {
+		mask = f.file->f_op->poll(f.file, pwait);
+	} else if (file_has_poll_mask(f.file)) {
+		struct wait_queue_head *head;
+
+		head = f.file->f_op->get_poll_head(f.file, pwait->_key);
+		if (!head) {
+			mask = DEFAULT_POLLMASK;
+		} else if (IS_ERR(head)) {
+			mask = EPOLLERR;
+		} else {
+			if (pwait->_qproc)
+				__pollwait(f.file, head, pwait);
+			mask = f.file->f_op->poll_mask(f.file, pwait->_key);
+		}
+	} else {
+		mask = DEFAULT_POLLMASK;
+	}
+
 	if (mask & busy_flag)
 		*can_busy_poll = true;
 	mask &= filter;		/* Mask out unneeded events. */
-- 
2.17.1

