Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F50C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5907020858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5907020858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeJIADx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:03:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39269 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIADx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:03:53 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <afa@pengutronix.de>)
        id 1g9YkP-0001bI-6n; Mon, 08 Oct 2018 18:51:09 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <afa@pengutronix.de>)
        id 1g9YkM-00065X-MS; Mon, 08 Oct 2018 18:51:06 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [PATCH RFC] proc: Don't retain negative dentries
Date:   Mon,  8 Oct 2018 18:50:10 +0200
Message-Id: <20181008165009.21890-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The referenced commit 1da4d377f94 ("proc: revalidate misc dentries")
caused following userspace code to access a stale /proc/net/dev
after the network namespace was changed:

    system("ip netns add testns");

    printf("default:\n"); {
        int devinfd = open("/proc/net/dev", O_RDONLY);
        sendfile(STDOUT_FILENO, devinfd, NULL, 4096);
        close(devinfd);
    }

    printf("testns:\n"); {
        int ns_fd = open("/var/run/netns/testns", O_RDONLY);
        setns(ns_fd, 0);

        int devinfd = open("/proc/net/dev", O_RDONLY);
        sendfile(STDOUT_FILENO, devinfd, NULL, 4096);
        close(devinfd);

        close(ns_fd);
    }

Despite switching the network namespace, the read access from the
newly opened file gave back what the very first read in the default
network namespace returned.

This doesn't occur if /proc/net/dev is opened within a new process,
which might explain why this wasn't noticed previously.

As I don't see a reason why one would keep negative dentries for procfs
at all, amend the code not to do this anymore.

Fixes: 1da4d377f94 ("proc: Don't retain negative dentries")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---

Notes:
    Alexey, could you check this doesn't lead to a regression
    concerning the bug you fixed?

 fs/proc/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 8ae109429a88..412b3c52d5d5 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -231,7 +231,7 @@ static int proc_misc_d_revalidate(struct dentry *dentry, unsigned int flags)
 
 static int proc_misc_d_delete(const struct dentry *dentry)
 {
-	return atomic_read(&PDE(d_inode(dentry))->in_use) < 0;
+	return 1; // Don't retain negative dentries
 }
 
 static const struct dentry_operations proc_misc_dentry_ops = {
-- 
2.19.0

