Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A3EC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165F5204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165F5204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbeIMTFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:05:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34030 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730616AbeIMTFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:05:19 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2E190D19;
        Thu, 13 Sep 2018 13:55:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 042/197] fs/proc/vmcore.c: hide vmcoredd_mmap_dumps() for nommu builds
Date:   Thu, 13 Sep 2018 15:29:51 +0200
Message-Id: <20180913131843.229876419@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a2036a1ef2ee91acab01a0ae4a534070691a42ec ]

Without CONFIG_MMU, we get a build warning:

  fs/proc/vmcore.c:228:12: error: 'vmcoredd_mmap_dumps' defined but not used [-Werror=unused-function]
   static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,

The function is only referenced from an #ifdef'ed caller, so
this uses the same #ifdef around it.

Link: http://lkml.kernel.org/r/20180525213526.2117790-1-arnd@arndb.de
Fixes: 7efe48df8a3d ("vmcore: append device dumps to vmcore as elf notes")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ganesh Goudar <ganeshgr@chelsio.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/vmcore.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -225,6 +225,7 @@ out_unlock:
 	return ret;
 }
 
+#ifdef CONFIG_MMU
 static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 			       u64 start, size_t size)
 {
@@ -259,6 +260,7 @@ out_unlock:
 	mutex_unlock(&vmcoredd_mutex);
 	return ret;
 }
+#endif /* CONFIG_MMU */
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 
 /* Read from the ELF header and then the crash dump. On error, negative value is


