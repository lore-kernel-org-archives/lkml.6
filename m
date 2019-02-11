Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61F3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96681222AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897295;
	bh=KWxsmT2AJG7d0oMP2hceH5pxbx4YTwsBjSoQHUnlZso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1P1cFjfdQIDacC31H34RnLNC6s4+3VWC5tAloxU94VDqQxGorI1UHX6joXntnFjtW
	 pYh9Kh5NH6/0bx3M9WSZzS4EcBJn76OtxfeyG/JbR/YypgXkTRTy7joBGYdq8H2h7q
	 rl2SuZyImX3Hqy2qyuylfHsfUmpgBBj5m5xQql1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390218AbfBKPBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:01:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390206AbfBKPBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:01:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A03B3222A6;
        Mon, 11 Feb 2019 15:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897289;
        bh=KWxsmT2AJG7d0oMP2hceH5pxbx4YTwsBjSoQHUnlZso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QIu8pt5JjEBCDfFQA3MJ1hkKVdiyuGJjldRneuBQiTxDm25BRFZjyBaHgIQ8ZZAXq
         nzSQF+C+bpCAs7hjBl/IYpUzEMhCJR/tLpGpi04fxv3g7oDa9bAnRUm/bNHgwdnKJc
         NkC3W+UHx812++bHmvcr92j6BN8bejj7NbP06FL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 121/205] drbd: Avoid Clang warning about pointless switch statment
Date:   Mon, 11 Feb 2019 15:18:39 +0100
Message-Id: <20190211141836.370224286@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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



