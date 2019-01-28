Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42405C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1545B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691746;
	bh=F95uzW5aA4HOsG1tNEdwlq3ZdENQRrRJosWhBaKlnZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2l8BFRacOByqyZ5B/fvAFUHdk5aZizy7KR6JWTPat5AJ1419rnXQWv3rQJ0nc9Q3q
	 OPJ/CWN6Uf+8xarVk1H1leoPhAkmPZEDYYuSnOUY6bo2nWNGrob6ArHB+QDLWm49LC
	 NVcQAWjlJ1vb/CODB6Uqlp/j3t0a7RcIw+7PrGR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbfA1QJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:09:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732523AbfA1QJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:09:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 230722084A;
        Mon, 28 Jan 2019 16:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691740;
        bh=F95uzW5aA4HOsG1tNEdwlq3ZdENQRrRJosWhBaKlnZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jg8G45MjWN9EEk5ZSTZgYcQHFtFdHoXRF8yUl/UqrtgB/czgVbv+MTFy4kz+kZOQZ
         l95HjHJtdldDqAGJoOGSN+WGO4loVbBRDus4a21mkbiP1CBnl+zlfEmn55rMb0k14B
         R317owoWli4BK17r0iPvkZOCH5N1rYNuHq+iTh0U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 202/258] drbd: Avoid Clang warning about pointless switch statment
Date:   Mon, 28 Jan 2019 10:58:28 -0500
Message-Id: <20190128155924.51521-202-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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

