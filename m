Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB98C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E045A2541C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E045A2541C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753790AbeGAQqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:46:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38548 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032147AbeGAQqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:46:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 458EBA73;
        Sun,  1 Jul 2018 16:46:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Justin Forbes <jmforbes@linuxtx.org>
Subject: [PATCH 4.17 220/220] virt: vbox: Only copy_from_user the request-header once
Date:   Sun,  1 Jul 2018 18:24:04 +0200
Message-Id: <20180701160917.319534512@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
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

From: Wenwen Wang <wang6495@umn.edu>

commit bd23a7269834dc7c1f93e83535d16ebc44b75eba upstream.

In vbg_misc_device_ioctl(), the header of the ioctl argument is copied from
the userspace pointer 'arg' and saved to the kernel object 'hdr'. Then the
'version', 'size_in', and 'size_out' fields of 'hdr' are verified.

Before this commit, after the checks a buffer for the entire request would
be allocated and then all data including the verified header would be
copied from the userspace 'arg' pointer again.

Given that the 'arg' pointer resides in userspace, a malicious userspace
process can race to change the data pointed to by 'arg' between the two
copies. By doing so, the user can bypass the verifications on the ioctl
argument.

This commit fixes this by using the already checked copy of the header
to fill the header part of the allocated buffer and only copying the
remainder of the data from userspace.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virt/vboxguest/vboxguest_linux.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/virt/vboxguest/vboxguest_linux.c
+++ b/drivers/virt/vboxguest/vboxguest_linux.c
@@ -121,7 +121,9 @@ static long vbg_misc_device_ioctl(struct
 	if (!buf)
 		return -ENOMEM;
 
-	if (copy_from_user(buf, (void *)arg, hdr.size_in)) {
+	*((struct vbg_ioctl_hdr *)buf) = hdr;
+	if (copy_from_user(buf + sizeof(hdr), (void *)arg + sizeof(hdr),
+			   hdr.size_in - sizeof(hdr))) {
 		ret = -EFAULT;
 		goto out;
 	}


