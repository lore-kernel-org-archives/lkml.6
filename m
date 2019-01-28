Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE21C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19162084C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693904;
	bh=4ltj/ieFSaAipp8bXE1/D/CtETkJnEi7zQ581lDvsHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rdKRBJBrlLcTGrwzzm9W8sdLPcPsFka0qfmFBTSYEeJevcdC5SIx6bfS688iPm3dA
	 xNZkxYduQVO9udwNG3u8IKlvuND2LmkUVTNJaR+ln3fJ4ffV9UBA+DmLrOgs/6KQsz
	 lSyZDOxTXfk28OsAmoIRiJcmTryw/9NbBL1zeOsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389568AbfA1QpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389324AbfA1QWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:22:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A48FA20663;
        Mon, 28 Jan 2019 16:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692575;
        bh=4ltj/ieFSaAipp8bXE1/D/CtETkJnEi7zQ581lDvsHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vuf0aHvF2u3DhW9N8OGpCjp4ZZtOfmnDJ4LqJRbX2+KMDTqS+6gWjq3BGTSQoysyo
         u/s6abRTS2HmdWt+q5Rh+otNEQeCL1MC/4+SIHbfYbfCs0Iulu+8wEzbQv/IcuweQ1
         Og9aTec6bpBMZ1rbGUUp73ir0e9WpUrlE3X6k82U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 074/107] drbd: Avoid Clang warning about pointless switch statment
Date:   Mon, 28 Jan 2019 11:19:14 -0500
Message-Id: <20190128161947.57405-74-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
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
index 6270a56e5edc..d0d6fdc22698 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -190,6 +190,7 @@ static inline void ct_assert_unique_operations(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	case 0:
 		;
 	}
 }
@@ -208,6 +209,7 @@ static inline void ct_assert_unique_top_level_attributes(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	case 0:
 		;
 	}
 }
@@ -217,7 +219,8 @@ static inline void ct_assert_unique_top_level_attributes(void)
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

