Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B41C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493EB20936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493EB20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733260AbeGJS2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:28:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732718AbeGJS2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:28:08 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E3335DB4;
        Tue, 10 Jul 2018 18:27:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+55b1d9f811650de944c6@syzkaller.appspotmail.com,
        Laura Abbott <labbott@redhat.com>
Subject: [PATCH 4.4 05/47] staging: android: ion: Return an ERR_PTR in ion_map_kernel
Date:   Tue, 10 Jul 2018 20:24:29 +0200
Message-Id: <20180710182337.272497491@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182337.047502999@linuxfoundation.org>
References: <20180710182337.047502999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laura Abbott <labbott@redhat.com>

commit 0a2bc00341dcfcc793c0dbf4f8d43adf60458b05 upstream.

The expected return value from ion_map_kernel is an ERR_PTR. The error
path for a vmalloc failure currently just returns NULL, triggering
a warning in ion_buffer_kmap_get. Encode the vmalloc failure as an ERR_PTR.

Reported-by: syzbot+55b1d9f811650de944c6@syzkaller.appspotmail.com
Signed-off-by: Laura Abbott <labbott@redhat.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ion/ion_heap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -38,7 +38,7 @@ void *ion_heap_map_kernel(struct ion_hea
 	struct page **tmp = pages;
 
 	if (!pages)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	if (buffer->flags & ION_FLAG_CACHED)
 		pgprot = PAGE_KERNEL;


