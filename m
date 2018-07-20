Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B383AECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C7720833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C7720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbeGTNNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:13:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34608 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbeGTNNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:13:15 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 49EA3BBD;
        Fri, 20 Jul 2018 12:25:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: [PATCH 3.18 01/29] ibmasm: dont write out of bounds in read handler
Date:   Fri, 20 Jul 2018 14:10:56 +0200
Message-Id: <20180720115159.025828728@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720115158.974693829@linuxfoundation.org>
References: <20180720115158.974693829@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit a0341fc1981a950c1e902ab901e98f60e0e243f3 upstream.

This read handler had a lot of custom logic and wrote outside the bounds of
the provided buffer. This could lead to kernel and userspace memory
corruption. Just use simple_read_from_buffer() with a stack buffer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/ibmasm/ibmasmfs.c |   27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -507,35 +507,14 @@ static int remote_settings_file_close(st
 static ssize_t remote_settings_file_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
 {
 	void __iomem *address = (void __iomem *)file->private_data;
-	unsigned char *page;
-	int retval;
 	int len = 0;
 	unsigned int value;
-
-	if (*offset < 0)
-		return -EINVAL;
-	if (count == 0 || count > 1024)
-		return 0;
-	if (*offset != 0)
-		return 0;
-
-	page = (unsigned char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
+	char lbuf[20];
 
 	value = readl(address);
-	len = sprintf(page, "%d\n", value);
-
-	if (copy_to_user(buf, page, len)) {
-		retval = -EFAULT;
-		goto exit;
-	}
-	*offset += len;
-	retval = len;
+	len = snprintf(lbuf, sizeof(lbuf), "%d\n", value);
 
-exit:
-	free_page((unsigned long)page);
-	return retval;
+	return simple_read_from_buffer(buf, count, offset, lbuf, len);
 }
 
 static ssize_t remote_settings_file_write(struct file *file, const char __user *ubuff, size_t count, loff_t *offset)


