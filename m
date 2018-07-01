Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA1CC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A108424EF3
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A108424EF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933940AbeGAQoy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:44:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933918AbeGAQoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:44:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D620792B;
        Sun,  1 Jul 2018 16:44:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.17 176/220] media: v4l2-compat-ioctl32: prevent go past max size
Date:   Sun,  1 Jul 2018 18:23:20 +0200
Message-Id: <20180701160915.589831406@linuxfoundation.org>
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

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

commit ea72fbf588ac9c017224dcdaa2019ff52ca56fee upstream.

As warned by smatch:
	drivers/media/v4l2-core/v4l2-compat-ioctl32.c:879 put_v4l2_ext_controls32() warn: check for integer overflow 'count'

The access_ok() logic should check for too big arrays too.

Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -871,7 +871,7 @@ static int put_v4l2_ext_controls32(struc
 	    get_user(kcontrols, &kp->controls))
 		return -EFAULT;
 
-	if (!count)
+	if (!count || count > (U32_MAX/sizeof(*ucontrols)))
 		return 0;
 	if (get_user(p, &up->controls))
 		return -EFAULT;


