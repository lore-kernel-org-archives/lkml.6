Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B14C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DFB217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498974;
	bh=rZEk1SY6ixLVR5lnumhEcCZukjKKfdhc1pvxJ0bR0DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M1rJBi75ZPKnmcT9PvIW1HctFREIChFJW7V5hdQfso3nFqZ6CFt+t9SfOhhs5Hyal
	 h2NNsebJskPEuHFujxlX0CB7xEC70p8GQeIAPL8yZlxVp9DmiqG/ITHq6YiOglqjBV
	 hjeG+MqCq1Zz9U1gD4VkgQqgOplMczXCCMPl/Zqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391240AbfBROJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:09:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390090AbfBROJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:09:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C4C4217D7;
        Mon, 18 Feb 2019 14:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498968;
        bh=rZEk1SY6ixLVR5lnumhEcCZukjKKfdhc1pvxJ0bR0DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7zdLo0DtiugUic+tjsr2H0mgy6hAYxZwzKdkDwCaMvI+kLS4dMR6ijRrIJP8j3iw
         70pryMrZH8ysLpZTfke6UzKpU1lJhNa+/fKyRunYFQe0pYk76r0n4Riy7hdqxjMZme
         qWDxuzSaffdulqxAxJl9oLIGgXgWp6ZPVkYdxavE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 035/108] drbd: Avoid Clang warning about pointless switch statment
Date:   Mon, 18 Feb 2019 14:43:31 +0100
Message-Id: <20190218133521.158202749@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index eecd19b37001..250e9be65e74 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -185,6 +185,7 @@ static inline void ct_assert_unique_operations(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	case 0:
 		;
 	}
 }
@@ -203,6 +204,7 @@ static inline void ct_assert_unique_top_level_attributes(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	case 0:
 		;
 	}
 }
@@ -212,7 +214,8 @@ static inline void ct_assert_unique_top_level_attributes(void)
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



