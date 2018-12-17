Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194ABC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9EC206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="z24guUcy";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="OHIeYwu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbeLQLwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:52:22 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:51412 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726831AbeLQLwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:52:22 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2018 06:52:21 EST
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id 26EB420F51;
        Mon, 17 Dec 2018 14:47:17 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 9CXhe2H8B3-lGmqG0xO;
        Mon, 17 Dec 2018 14:47:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1545047237; bh=JSa+lr7oBunPFnNL83Fu/xL1MjGNucQ7jkZFInpSPGc=;
        h=Subject:From:To:Cc:Date:Message-ID;
        b=z24guUcynnF+f6YGhwP4HMau5AxzzMhce2tRztvVYx4V6oBUNwPx17rq5lDiwhgxr
         4ZihjxbtrTzEVXBB+AXDNu+5G1DPRsWO359Oe/W1G4h4yjC7Gyom1PE6zQg3WJE0Oa
         5E795obAYH1ybBRMJKSK8HHWA6LoXOXQqN6XKaXU=
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:0:3712::1:90])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id omTYaNRnMg-lG9elx9r;
        Mon, 17 Dec 2018 14:47:16 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1545047236; bh=JSa+lr7oBunPFnNL83Fu/xL1MjGNucQ7jkZFInpSPGc=;
        h=Subject:From:To:Cc:Date:Message-ID;
        b=OHIeYwu9csjKC52+hM/TppKdx58Ag5QMRacwjfDqEu3XvjDyC5KfjQfcSvXVyBhAd
         sshjzGsvA/7y7dLl/YA6XRRR+x9eVvbiG4fd/cAmTem41OQ89Tr5FiIxKUSCA8zKEi
         5sCiM9Wje92+6nJGNxIchBZ4Pyz9ETX9zPTppw/E=
Authentication-Results: smtpcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH] tools/perf: fix silent build with 'make -s'
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>
Date:   Mon, 17 Dec 2018 14:47:14 +0300
Message-ID: <154504723398.564691.16359911285545406564.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tools/perf/Makefile conflicts with option '-j'.
The rest options must be passed as is.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 tools/perf/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 7902a5681fc8..989c3d2f847b 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -16,7 +16,7 @@
 #
 # We don't want to pass along options like -j:
 #
-unexport MAKEFLAGS
+MAKEFLAGS := $(filter --j% -j,$(MAKEFLAGS))
 
 #
 # Do a parallel build with multiple jobs, based on the number of CPUs online

