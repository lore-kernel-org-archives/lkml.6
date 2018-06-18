Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08C4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1EC20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1EC20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968148AbeFRIhz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:37:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968119AbeFRIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:37:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ED250CBA;
        Mon, 18 Jun 2018 08:37:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 178/189] drm/dumb-buffers: Integer overflow in drm_mode_create_ioctl()
Date:   Mon, 18 Jun 2018 10:14:34 +0200
Message-Id: <20180618081216.372195590@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 2b6207291b7b277a5df9d1aab44b56815a292dba ]

There is a comment here which says that DIV_ROUND_UP() and that's where
the problem comes from.  Say you pick:

	args->bpp = UINT_MAX - 7;
	args->width = 4;
	args->height = 1;

The integer overflow in DIV_ROUND_UP() means "cpp" is UINT_MAX / 8 and
because of how we picked args->width that means cpp < UINT_MAX / 4.

I've fixed it by preventing the integer overflow in DIV_ROUND_UP().  I
removed the check for !cpp because it's not possible after this change.
I also changed all the 0xffffffffU references to U32_MAX.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20180516140026.GA19340@mwanda
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_dumb_buffers.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/drm_dumb_buffers.c
+++ b/drivers/gpu/drm/drm_dumb_buffers.c
@@ -65,12 +65,13 @@ int drm_mode_create_dumb_ioctl(struct dr
 		return -EINVAL;
 
 	/* overflow checks for 32bit size calculations */
-	/* NOTE: DIV_ROUND_UP() can overflow */
+	if (args->bpp > U32_MAX - 8)
+		return -EINVAL;
 	cpp = DIV_ROUND_UP(args->bpp, 8);
-	if (!cpp || cpp > 0xffffffffU / args->width)
+	if (cpp > U32_MAX / args->width)
 		return -EINVAL;
 	stride = cpp * args->width;
-	if (args->height > 0xffffffffU / stride)
+	if (args->height > U32_MAX / stride)
 		return -EINVAL;
 
 	/* test for wrap-around */


