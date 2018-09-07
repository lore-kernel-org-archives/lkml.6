Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75355C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B2320645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B2320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbeIHCLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:11:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbeIHCLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:11:16 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AA67BACC;
        Fri,  7 Sep 2018 21:28:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Kalauskas <peskal@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 52/89] drivers/block/zram/zram_drv.c: fix bug storing backing_dev
Date:   Fri,  7 Sep 2018 23:09:46 +0200
Message-Id: <20180907210858.699744342@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Kalauskas <peskal@google.com>

commit c8bd134a4bddafe5917d163eea73873932c15e83 upstream.

The call to strlcpy in backing_dev_store is incorrect. It should take
the size of the destination buffer instead of the size of the source
buffer.  Additionally, ignore the newline character (\n) when reading
the new file_name buffer. This makes it possible to set the backing_dev
as follows:

	echo /dev/sdX > /sys/block/zram0/backing_dev

The reason it worked before was the fact that strlcpy() copies 'len - 1'
bytes, which is strlen(buf) - 1 in our case, so it accidentally didn't
copy the trailing new line symbol.  Which also means that "echo -n
/dev/sdX" most likely was broken.

Signed-off-by: Peter Kalauskas <peskal@google.com>
Link: http://lkml.kernel.org/r/20180813061623.GC64836@rodete-desktop-imager.corp.google.com
Acked-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: <stable@vger.kernel.org>    [4.14+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/zram/zram_drv.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -321,6 +321,7 @@ static ssize_t backing_dev_store(struct
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	char *file_name;
+	size_t sz;
 	struct file *backing_dev = NULL;
 	struct inode *inode;
 	struct address_space *mapping;
@@ -341,7 +342,11 @@ static ssize_t backing_dev_store(struct
 		goto out;
 	}
 
-	strlcpy(file_name, buf, len);
+	strlcpy(file_name, buf, PATH_MAX);
+	/* ignore trailing newline */
+	sz = strlen(file_name);
+	if (sz > 0 && file_name[sz - 1] == '\n')
+		file_name[sz - 1] = 0x00;
 
 	backing_dev = filp_open(file_name, O_RDWR|O_LARGEFILE, 0);
 	if (IS_ERR(backing_dev)) {


