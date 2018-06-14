Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5A861C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E759208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6H6uVx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E759208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936265AbeFNOGT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936257AbeFNOGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:06:17 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C42D6208CB;
        Thu, 14 Jun 2018 14:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985176;
        bh=Cdfd6AaaxDIYsoJV78Bqe1EhoWYU3taRH1BGz54IF1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z6H6uVx7psqYAZ5PeQV+KGILcG7FJ2ySnfNwvLeTTc1S4p7hxfR1ShAzCxatWdyo6
         tjQP4llYdYcQhAkczaWjy+dG8S6cfK9LBcwe9HH6zvj7xKus2ay3gL0W7JcFwoeSLt
         /OIiIx28WhvOQDQAqmVfAUFT9YKaOCfF1Lg/ItHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+cd8bcd40cb049efa2770@syzkaller.appspotmail.com,
        syzbot <syzkaller@googlegroups.com>,
        Laura Abbott <labbott@redhat.com>
Subject: [PATCH 4.17 09/45] staging: android: ion: Switch to pr_warn_once in ion_buffer_destroy
Date:   Thu, 14 Jun 2018 16:04:00 +0200
Message-Id: <20180614132127.249261777@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132126.797006529@linuxfoundation.org>
References: <20180614132126.797006529@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ion/ion.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -114,8 +114,11 @@ err2:
 
 void ion_buffer_destroy(struct ion_buffer *buffer)
 {
-	if (WARN_ON(buffer->kmap_cnt > 0))
+	if (buffer->kmap_cnt > 0) {
+		pr_warn_once("%s: buffer still mapped in the kernel\n",
+			     __func__);
 		buffer->heap->ops->unmap_kernel(buffer->heap, buffer);
+	}
 	buffer->heap->ops->free(buffer);
 	kfree(buffer);
 }


