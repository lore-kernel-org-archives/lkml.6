Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B31C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F8021841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217283;
	bh=ASJkPlw79uE8VDccTJklANK97EtHdUAEnWTkYYVUnIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TMIJfxyTm6/xtJ2e4Xdulpltuc6am0sicEHXbvTa0jMJouGTzVnSgGlt8vpGLk807
	 6qTWlRo5jdkORop72zcJ1GJ4qx6FczxXgMnTJoC1pkw0pFVhxe4QN/ddPvAW/jLzni
	 lQNwLzzE/dxskD+pCprr46bhzdk4RofPfa2Vk3XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbfAKOem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:34:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389928AbfAKOek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:34:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFFEF204EC;
        Fri, 11 Jan 2019 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217279;
        bh=ASJkPlw79uE8VDccTJklANK97EtHdUAEnWTkYYVUnIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dLQDjYI7XDt57W5KbZ5jF57vlVYTuhRfu6y2KHdVNhBjFRt3RlfHnRLtq3SU3yBG7
         XROiD9pA1TQF2JqdjzjBu8ComS4Oo2X4EwGRcekwghal1COVHkCnfgh4e8RTGUCAxZ
         RKiEJVsQ3WKyCFdnu+6qpMFfOdTxT3WjPfqZMi6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, Shaohua Li <shli@fb.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.14 072/105] md: raid10: remove VLAIS
Date:   Fri, 11 Jan 2019 15:14:43 +0100
Message-Id: <20190111131109.031726599@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 584ed9fa9532f8b9d5955628ff87ee3b2ab9f5a9 upstream.

The raid10 driver can't be built with clang since it uses a variable
length array in a structure (VLAIS):

drivers/md/raid10.c:4583:17: error: fields must have a constant size:
  'variable length array in structure' extension will never be supported

Allocate the r10bio struct with kmalloc instead of using the VLAIS
construct.

Shaohua: set the MD_RECOVERY_INTR bit
Neil Brown: use GFP_NOIO

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid10.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4591,15 +4591,18 @@ static int handle_reshape_read_error(str
 	/* Use sync reads to get the blocks from somewhere else */
 	int sectors = r10_bio->sectors;
 	struct r10conf *conf = mddev->private;
-	struct {
-		struct r10bio r10_bio;
-		struct r10dev devs[conf->copies];
-	} on_stack;
-	struct r10bio *r10b = &on_stack.r10_bio;
+	struct r10bio *r10b;
 	int slot = 0;
 	int idx = 0;
 	struct page **pages;
 
+	r10b = kmalloc(sizeof(*r10b) +
+	       sizeof(struct r10dev) * conf->copies, GFP_NOIO);
+	if (!r10b) {
+		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+		return -ENOMEM;
+	}
+
 	/* reshape IOs share pages from .devs[0].bio */
 	pages = get_resync_pages(r10_bio->devs[0].bio)->pages;
 
@@ -4648,11 +4651,13 @@ static int handle_reshape_read_error(str
 			/* couldn't read this block, must give up */
 			set_bit(MD_RECOVERY_INTR,
 				&mddev->recovery);
+			kfree(r10b);
 			return -EIO;
 		}
 		sectors -= s;
 		idx++;
 	}
+	kfree(r10b);
 	return 0;
 }
 


