Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD499C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A407220881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763579;
	bh=G8UQrWMvAVgDHmMeOjscpuNeJIBnzw4jrIHAXKHOwU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y0XtjSkoh6o2p8fpbqXODkheOUwRRhFnZgBhb2XhtvxRY4cRWNX4qRC5d6Ya66QO9
	 D2uRtvFtjW8dGgHkWVll0GWMXKUUZ7MpStItb9MNoUHvUUbhoVZmq2kbmtdFFQ6Wun
	 +UfMGn2YUANTH1OVOQsdkiJuuuuyGWWHtoKHnxf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfA2MGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:06:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729815AbfA2LlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:41:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3D7E2183F;
        Tue, 29 Jan 2019 11:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762072;
        bh=G8UQrWMvAVgDHmMeOjscpuNeJIBnzw4jrIHAXKHOwU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWGnYoPsCwkm3ir2LOfbl9MOKBg7rs92ZNgG7Od418sl+eDijiCt8MypKggxQM83Y
         Y7oxbjTJbYr4Gu5fZFuZd31lxSUYOfivXs2lBEqAkyMgaaFTWd5KN0M5NxmgLG6Y5e
         eE4hStlEO7YkBsfSIE0OKpcJGlePxPkUabxhRdWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.20 067/117] Input: input_event - provide override for sparc64
Date:   Tue, 29 Jan 2019 12:35:18 +0100
Message-Id: <20190129113210.938813738@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Deepa Dinamani <deepa.kernel@gmail.com>

commit 2e746942ebacf1565caa72cf980745e5ce297c48 upstream.

The usec part of the timeval is defined as
__kernel_suseconds_t	tv_usec; /* microseconds */

Arnd noticed that sparc64 is the only architecture that defines
__kernel_suseconds_t as int rather than long.

This breaks the current y2038 fix for kernel as we only access and define
the timeval struct for non-kernel use cases.  But, this was hidden by an
another typo in the use of __KERNEL__ qualifier.

Fix the typo, and provide an override for sparc64.

Fixes: 152194fe9c3f ("Input: extend usable life of event timestamps to 2106 on 32 bit systems")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/input.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -26,13 +26,17 @@
  */
 
 struct input_event {
-#if (__BITS_PER_LONG != 32 || !defined(__USE_TIME_BITS64)) && !defined(__KERNEL)
+#if (__BITS_PER_LONG != 32 || !defined(__USE_TIME_BITS64)) && !defined(__KERNEL__)
 	struct timeval time;
 #define input_event_sec time.tv_sec
 #define input_event_usec time.tv_usec
 #else
 	__kernel_ulong_t __sec;
+#ifdef CONFIG_SPARC64
+	unsigned int __usec;
+#else
 	__kernel_ulong_t __usec;
+#endif
 #define input_event_sec  __sec
 #define input_event_usec __usec
 #endif


