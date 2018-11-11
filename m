Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB170C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959352080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959352080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbeKLF4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:56:38 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52080 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbeKLF4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:56:38 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtB-0000l9-3S; Sun, 11 Nov 2018 19:59:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001QN-3M; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        syzbot+cd8bcd40cb049efa2770@syzkaller.appspotmail.com,
        "Laura Abbott" <labbott@redhat.com>,
        "syzbot" <syzkaller@googlegroups.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.789319473@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 054/366] staging: android: ion: Switch to
 pr_warn_once in ion_buffer_destroy
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Laura Abbott <labbott@redhat.com>

commit 45ad559a29629cb1c64ee636563c69b71524f077 upstream.

Syzbot reported yet another warning with Ion:

WARNING: CPU: 0 PID: 1467 at drivers/staging/android/ion/ion.c:122
ion_buffer_destroy+0xd4/0x190 drivers/staging/android/ion/ion.c:122
Kernel panic - not syncing: panic_on_warn set ...

This is catching that a buffer was freed with an existing kernel mapping
still present. This can be easily be triggered from userspace by calling
DMA_BUF_SYNC_START without calling DMA_BUF_SYNC_END. Switch to a single
pr_warn_once to indicate the error without being disruptive.

Reported-by: syzbot+cd8bcd40cb049efa2770@syzkaller.appspotmail.com
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/android/ion/ion.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -272,8 +272,11 @@ err2:
 
 void ion_buffer_destroy(struct ion_buffer *buffer)
 {
-	if (WARN_ON(buffer->kmap_cnt > 0))
+	if (buffer->kmap_cnt > 0) {
+		pr_warn_once("%s: buffer still mapped in the kernel\n",
+			     __func__);
 		buffer->heap->ops->unmap_kernel(buffer->heap, buffer);
+	}
 	buffer->heap->ops->unmap_dma(buffer->heap, buffer);
 	buffer->heap->ops->free(buffer);
 	if (buffer->pages)

