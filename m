Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADBCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1EE2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ke/0/CBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1EE2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbeKTDBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:01:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730931AbeKTDBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:01:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68AB9206BA;
        Mon, 19 Nov 2018 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645432;
        bh=oHZ+lvbQWIkgvMN6WuljezjmZ87zrkHQyfEyCdXM5Ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ke/0/CBM4U0eJxEoPxnfiOGf1jg5u9fKhv5JbFdcSpHzr54adgbu8bAaKNJw8Wk1N
         GWWH68G76HCylXZ8283+JM2P8CIBgdyFkyet0DXMXJ1mRPvtRv6buu7xjaCU0/kHHC
         gAmu2PpTBmyQBP6owcbr/FYJm+xmqfKrbyb1iTlg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.19 161/205] fuse: fix possibly missed wake-up after abort
Date:   Mon, 19 Nov 2018 17:27:48 +0100
Message-Id: <20181119162639.608639347@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit 2d84a2d19b6150c6dbac1e6ebad9c82e4c123772 upstream.

In current fuse_drop_waiting() implementation it's possible that
fuse_wait_aborted() will not be woken up in the unlikely case that
fuse_abort_conn() + fuse_wait_aborted() runs in between checking
fc->connected and calling atomic_dec(&fc->num_waiting).

Do the atomic_dec_and_test() unconditionally, which also provides the
necessary barrier against reordering with the fc->connected check.

The explicit smp_mb() in fuse_wait_aborted() is not actually needed, since
the spin_unlock() in fuse_abort_conn() provides the necessary RELEASE
barrier after resetting fc->connected.  However, this is not a performance
sensitive path, and adding the explicit barrier makes it easier to
document.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: b8f95e5d13f5 ("fuse: umount should wait for all requests")
Cc: <stable@vger.kernel.org> #v4.19
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dev.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -129,9 +129,13 @@ static bool fuse_block_alloc(struct fuse
 
 static void fuse_drop_waiting(struct fuse_conn *fc)
 {
-	if (fc->connected) {
-		atomic_dec(&fc->num_waiting);
-	} else if (atomic_dec_and_test(&fc->num_waiting)) {
+	/*
+	 * lockess check of fc->connected is okay, because atomic_dec_and_test()
+	 * provides a memory barrier mached with the one in fuse_wait_aborted()
+	 * to ensure no wake-up is missed.
+	 */
+	if (atomic_dec_and_test(&fc->num_waiting) &&
+	    !READ_ONCE(fc->connected)) {
 		/* wake up aborters */
 		wake_up_all(&fc->blocked_waitq);
 	}
@@ -2167,6 +2171,8 @@ EXPORT_SYMBOL_GPL(fuse_abort_conn);
 
 void fuse_wait_aborted(struct fuse_conn *fc)
 {
+	/* matches implicit memory barrier in fuse_drop_waiting() */
+	smp_mb();
 	wait_event(fc->blocked_waitq, atomic_read(&fc->num_waiting) == 0);
 }
 


