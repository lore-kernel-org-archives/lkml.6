Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB730C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A8D20880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763266;
	bh=QgJD/T9lCWiyWoChVaStS+gbKGCQyMsC6biQZm/qqu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ft57itp4n5BkNHl42TjnVoWoZgavh9bm/kOVKi1Wqqq4s9/ksM/hPzj3bndGztzvJ
	 wKc9A1OacEKoei30etTXoZU3xIFayEr/8v/yZNIh+2PkMtXIu6LVLRyV1ame4ey1gC
	 gtck2kk0NAorIp+ikbAOiEq6hY03Xtqxa7YDG+bE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbfA2Lpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:45:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729523AbfA2Lpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:45:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFEF22083B;
        Tue, 29 Jan 2019 11:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762347;
        bh=QgJD/T9lCWiyWoChVaStS+gbKGCQyMsC6biQZm/qqu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0dK/9XsRppiO5cpzqHUqOBGdJsiEGx4P8p6fu78s/yjsd+SxIg5WCkEeMrf5FMZL
         gm1mtQMMocTmNdXDUY7Y0aybyxSUuuhazF/Lepl7Pe5NIOeCwlZJcrua4kvCH4BX1L
         LQPEY+sN8IhTlJIrrVG512vQCN1QSvn8FUe6B6Iw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 059/103] Input: input_event - provide override for sparc64
Date:   Tue, 29 Jan 2019 12:35:36 +0100
Message-Id: <20190129113204.233323662@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


