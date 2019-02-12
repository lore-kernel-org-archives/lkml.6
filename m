Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D672CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB07E218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfBLBiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:38:54 -0500
Received: from icp-osb-irony-out6.external.iinet.net.au ([203.59.1.106]:12135
        "EHLO icp-osb-irony-out6.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbfBLBix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:38:53 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BMAABQI2Jc/4Sh0HYNVhwBAQEEAQE?=
 =?us-ascii?q?HBAEBgVIGAQELAQGEE4QElFoBAQEGgRCJXY5bgXuEdAMCg2M1CA0BAwEBAQE?=
 =?us-ascii?q?BAQKBVwEBAQMHBIR6JwRSKAEHBQImAkkWE4UZqwpxfDMaihWBC4FziVx4gQe?=
 =?us-ascii?q?BRIIqiD+CVwKRBDqRYQmSaQwCilYDh3gBLZ1XA4IJTS4KgyeQamWCWIdbhAM?=
 =?us-ascii?q?BAQ?=
X-IPAS-Result: =?us-ascii?q?A2BMAABQI2Jc/4Sh0HYNVhwBAQEEAQEHBAEBgVIGAQELA?=
 =?us-ascii?q?QGEE4QElFoBAQEGgRCJXY5bgXuEdAMCg2M1CA0BAwEBAQEBAQKBVwEBAQMHB?=
 =?us-ascii?q?IR6JwRSKAEHBQImAkkWE4UZqwpxfDMaihWBC4FziVx4gQeBRIIqiD+CVwKRB?=
 =?us-ascii?q?DqRYQmSaQwCilYDh3gBLZ1XA4IJTS4KgyeQamWCWIdbhAMBAQ?=
X-IronPort-AV: E=Sophos;i="5.58,361,1544457600"; 
   d="scan'208";a="139282751"
Received: from unknown (HELO [192.168.1.228]) ([118.208.161.132])
  by icp-osb-irony-out6.iinet.net.au with ESMTP; 12 Feb 2019 09:38:32 +0800
Subject: [PATCH] autofs: clear O_NONBLOCK on the pipe.
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Date:   Tue, 12 Feb 2019 09:38:29 +0800
Message-ID: <154993550902.3321.1183632970046073478.stgit@pluto-themaw-net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>

autofs does not expect the pipe it is given
to have O_NONBLOCK set - specifically if __kernel_write()
in autofs_write() returns -EAGAIN, this is treated
as a fatal error and the pipe is closed.

For safety autofs should, therefore, clear the O_NONBLOCK flag.

Releases of systemd prior to 8th February 2019 used
  pipe2(p, O_NONBLOCK|O_CLOEXEC)
and thus (inadvertently) set this flag.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index b735f2b1e462..70c132acdab1 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -216,6 +216,8 @@ static inline int autofs_prepare_pipe(struct file *pipe)
 		return -EINVAL;
 	/* We want a packet pipe */
 	pipe->f_flags |= O_DIRECT;
+	/* We don't expect -EAGAIN */
+	pipe->f_flags &= ~O_NONBLOCK;
 	return 0;
 }
 

