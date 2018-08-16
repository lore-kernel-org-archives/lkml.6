Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD5FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0498A21473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0498A21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeHPVmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:42:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbeHPVmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:42:50 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5F0A5CEB;
        Thu, 16 Aug 2018 18:42:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Siqi Lin <siqilin@google.com>,
        Erick Reyes <erickreyes@google.com>
Subject: [PATCH 3.18 07/15] ALSA: info: Check for integer overflow in snd_info_entry_write()
Date:   Thu, 16 Aug 2018 20:41:44 +0200
Message-Id: <20180816171633.819923543@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171633.546734046@linuxfoundation.org>
References: <20180816171633.546734046@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erick Reyes <erickreyes@google.com>

Commit 4adb7bcbcb69 ("ALSA: core: Use seq_file for text proc file
reads") heavily refactored ALSA procfs and fixed the overflow as
a side-effect, so this fix only applies to kernels < 4.2 and
there is no upstream equivalent

snd_info_entry_write() resizes the buffer with an unsigned long
size argument that gets truncated because resize_info_buffer()
takes the size parameter as an unsigned int. On 64-bit kernels,
this causes the following copy_to_user() to write out-of-bounds
if (pos + count) can't be represented by an unsigned int.

Signed-off-by: Siqi Lin <siqilin@google.com>
Signed-off-by: Erick Reyes <erickreyes@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/info.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -253,6 +253,7 @@ static ssize_t snd_info_entry_write(stru
 	struct snd_info_buffer *buf;
 	ssize_t size = 0;
 	loff_t pos;
+	unsigned long realloc_size;
 
 	data = file->private_data;
 	if (snd_BUG_ON(!data))
@@ -261,7 +262,8 @@ static ssize_t snd_info_entry_write(stru
 	pos = *offset;
 	if (pos < 0 || (long) pos != pos || (ssize_t) count < 0)
 		return -EIO;
-	if ((unsigned long) pos + (unsigned long) count < (unsigned long) pos)
+	realloc_size = (unsigned long) pos + (unsigned long) count;
+	if (realloc_size < (unsigned long) pos || realloc_size > UINT_MAX)
 		return -EIO;
 	switch (entry->content) {
 	case SNDRV_INFO_CONTENT_TEXT:


