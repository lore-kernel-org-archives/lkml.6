Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BD8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CB421741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694604;
	bh=F95uzW5aA4HOsG1tNEdwlq3ZdENQRrRJosWhBaKlnZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FVP84SlKob/bvLsRxkl9anmeQFbC/1xwWmko/K6nLAUQWxZWRhFfAHZOCGhdK7IC/
	 QBxTg+lWjNopnfW4tJacYt7bZ89KVod9e/LevgWn3/Wr+Vf8kUcmU61gePR857yuHp
	 WmOuEyDPenJ6mRKoUbVBtIaypQrHgbH8lctc+Kfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbfA1QRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:17:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388223AbfA1QR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:17:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16D792086C;
        Mon, 28 Jan 2019 16:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692247;
        bh=F95uzW5aA4HOsG1tNEdwlq3ZdENQRrRJosWhBaKlnZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrBFZkYQ9qWAyWX0RwQaHoJFYF4w6VPxejWwreWffRta/5iH99loK12keGQq4bM7W
         fcJ2AYU8WL7mo56Nk6AWCA7tss3QcN5jZvKeY7na+xJcM+aD40DL+mPBSthnHQVLCD
         fUX12pEhJsoiu6Rr/XkNDjM4ec2pTx0aUQHC6jKA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 126/170] drbd: Avoid Clang warning about pointless switch statment
Date:   Mon, 28 Jan 2019 11:11:16 -0500
Message-Id: <20190128161200.55107-126-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit a52c5a16cf19d8a85831bb1b915a221dd4ffae3c ]

There are several warnings from Clang about no case statement matching
the constant 0:

In file included from drivers/block/drbd/drbd_receiver.c:48:
In file included from drivers/block/drbd/drbd_int.h:48:
In file included from ./include/linux/drbd_genl_api.h:54:
In file included from ./include/linux/genl_magic_struct.h:236:
./include/linux/drbd_genl.h:321:1: warning: no case matching constant
switch condition '0'
GENL_struct(DRBD_NLA_HELPER, 24, drbd_helper_info,
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/genl_magic_struct.h:220:10: note: expanded from macro
'GENL_struct'
        switch (0) {
                ^

Silence this warning by adding a 'case 0:' statement. Additionally,
adjust the alignment of the statements in the ct_assert_unique macro to
avoid a checkpatch warning.

This solution was originally sent by Arnd Bergmann with a default case
statement: https://lore.kernel.org/patchwork/patch/756723/

Link: https://github.com/ClangBuiltLinux/linux/issues/43
Suggested-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/genl_magic_struct.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
index 5972e4969197..eeae59d3ceb7 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -191,6 +191,7 @@ static inline void ct_assert_unique_operations(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	case 0:
 		;
 	}
 }
@@ -209,6 +210,7 @@ static inline void ct_assert_unique_top_level_attributes(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	case 0:
 		;
 	}
 }
@@ -218,7 +220,8 @@ static inline void ct_assert_unique_top_level_attributes(void)
 static inline void ct_assert_unique_ ## s_name ## _attributes(void)	\
 {									\
 	switch (0) {							\
-		s_fields						\
+	s_fields							\
+	case 0:								\
 			;						\
 	}								\
 }
-- 
2.19.1

