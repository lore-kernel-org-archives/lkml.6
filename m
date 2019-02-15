Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B8AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6FA2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198437;
	bh=2K0MItoCg0hnOi1BYWUODwaGFGgRj3BR7iSEEWFpinY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AOndQmdn3nAUItv/YZ77eOjpCSpO/vQnXL+Rt7PFcjbLLk9oqlqSnBT/rO7XHColD
	 JdN3MV3TItTV7n84iVwE3yGYYIWmA0KsVvBhGnmmL2dKFmOH9RZrqtsnp9qlWe01vi
	 zI9LZ2AGa/Lwb2MbOIb+nG5ANfNQSc9HOQ5pT93I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfBOCkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:40:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389129AbfBOCJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:09:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11B7D21B68;
        Fri, 15 Feb 2019 02:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196597;
        bh=2K0MItoCg0hnOi1BYWUODwaGFGgRj3BR7iSEEWFpinY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iC4g+1xmxzH03ZDRZzXYULcbA3CJnN65zv7cYkuso4rL83//V06zPzJAm4w+aKU2U
         Kb7OflP1mA1KQhRGJsWSKbj+5tac5/bJOK6VhMm2VJQEzH+x0QCqzHlCeyKhodyusN
         toOjh6dDMAWKuujs/HAx995+/ZUKQSMiRvVoRUnk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.20 35/77] staging: rtl8723bs: Fix build error with Clang when inlining is disabled
Date:   Thu, 14 Feb 2019 21:08:13 -0500
Message-Id: <20190215020855.176727-35-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 97715058b70da1262fd07798c8b2e3e894f759dd ]

When CONFIG_NO_AUTO_INLINE was present in linux-next (which added
'-fno-inline-functions' to KBUILD_CFLAGS), an allyesconfig build with
Clang failed at the modpost stage:

ERROR: "is_broadcast_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
ERROR: "is_zero_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
ERROR: "is_multicast_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!

These functions were marked as extern inline, meaning that if inlining
doesn't happen, the function will be undefined, as it is above.

This happens to work with GCC because the '-fno-inline-functions' option
respects the __inline attribute so all instances of these functions are
inlined as expected and the definition doesn't actually matter. However,
with Clang and '-fno-inline-functions', a function has to be marked with
the __always_inline attribute to be considered for inlining, which none
of these functions are. Clang tries to find the symbol definition
elsewhere as it was told and fails, which trickles down to modpost.

To make sure that this code compiles regardless of compiler and make the
intention of the code clearer, use 'static' to ensure these functions
are always defined, regardless of inlining. Additionally, silence a
checkpatch warning by switching from '__inline' to 'inline'.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index bcc8dfa8e672..9efb4dcb9d3a 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -850,18 +850,18 @@ enum ieee80211_state {
 #define IP_FMT "%pI4"
 #define IP_ARG(x) (x)
 
-extern __inline int is_multicast_mac_addr(const u8 *addr)
+static inline int is_multicast_mac_addr(const u8 *addr)
 {
         return ((addr[0] != 0xff) && (0x01 & addr[0]));
 }
 
-extern __inline int is_broadcast_mac_addr(const u8 *addr)
+static inline int is_broadcast_mac_addr(const u8 *addr)
 {
 	return ((addr[0] == 0xff) && (addr[1] == 0xff) && (addr[2] == 0xff) &&   \
 		(addr[3] == 0xff) && (addr[4] == 0xff) && (addr[5] == 0xff));
 }
 
-extern __inline int is_zero_mac_addr(const u8 *addr)
+static inline int is_zero_mac_addr(const u8 *addr)
 {
 	return ((addr[0] == 0x00) && (addr[1] == 0x00) && (addr[2] == 0x00) &&   \
 		(addr[3] == 0x00) && (addr[4] == 0x00) && (addr[5] == 0x00));
-- 
2.19.1

