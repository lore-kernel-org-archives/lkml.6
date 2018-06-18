Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239F8C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AC920864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AC920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030329AbeFRIhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:37:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36580 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030301AbeFRIhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:37:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 60C04CB7;
        Mon, 18 Jun 2018 08:37:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 165/189] mtd: Fix comparison in map_word_andequal()
Date:   Mon, 18 Jun 2018 10:14:21 +0200
Message-Id: <20180618081215.856872890@linuxfoundation.org>
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

From: Ben Hutchings <ben@decadent.org.uk>

[ Upstream commit ea739a287f4f16d6250bea779a1026ead79695f2 ]

Commit 9e343e87d2c4 ("mtd: cfi: convert inline functions to macros")
changed map_word_andequal() into a macro, but also changed the right
hand side of the comparison from val3 to val2.  Change it back to use
val3 on the right hand side.

Thankfully this did not cause a regression because all callers
currently pass the same argument for val2 and val3.

Fixes: 9e343e87d2c4 ("mtd: cfi: convert inline functions to macros")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mtd/map.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/mtd/map.h
+++ b/include/linux/mtd/map.h
@@ -312,7 +312,7 @@ void map_destroy(struct mtd_info *mtd);
 ({									\
 	int i, ret = 1;							\
 	for (i = 0; i < map_words(map); i++) {				\
-		if (((val1).x[i] & (val2).x[i]) != (val2).x[i]) {	\
+		if (((val1).x[i] & (val2).x[i]) != (val3).x[i]) {	\
 			ret = 0;					\
 			break;						\
 		}							\


