Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862C0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5132192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FijtRViz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FijtRViz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfBQFGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 00:06:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43468 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfBQFGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 00:06:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AE1896081B; Sun, 17 Feb 2019 05:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550379963;
        bh=AFUgXgq7Cy+33lynzOffSN3VRuEjlhTpEi8maDQKxto=;
        h=From:To:Cc:Subject:Date:From;
        b=FijtRVizMXkp0EPhQPXnMdGCVTLI/CsKY/7o0llOMNtfg6s/sBQwqEBIogzuWg5y+
         eK9z4Hi0R7kNr5u3e7O0warm238MywJd8XHRDInT0aHHuxPmnW/STQ9+/o50eyf1cL
         thSOV0ofICO+jXqv9q6ewzkJiH+qf9wyEMinsdGE=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3900860709;
        Sun, 17 Feb 2019 05:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550379963;
        bh=AFUgXgq7Cy+33lynzOffSN3VRuEjlhTpEi8maDQKxto=;
        h=From:To:Cc:Subject:Date:From;
        b=FijtRVizMXkp0EPhQPXnMdGCVTLI/CsKY/7o0llOMNtfg6s/sBQwqEBIogzuWg5y+
         eK9z4Hi0R7kNr5u3e7O0warm238MywJd8XHRDInT0aHHuxPmnW/STQ9+/o50eyf1cL
         thSOV0ofICO+jXqv9q6ewzkJiH+qf9wyEMinsdGE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3900860709
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH] tty: serial: msm_serial: Remove __init from msm_console_setup()
Date:   Sat, 16 Feb 2019 22:05:52 -0700
Message-Id: <1550379952-19457-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the complexities of modern Qualcomm SoCs, about a half dozen drivers
must successfully probe before the clocks for the console are present, and
the console can successfully probe.  Depending on several random factors
such as probe order and modules vs builtin, msm_serial may not be able to
successfully probe for some, at which point, __init annotated functions
may become unmapped.  If this occurs, msm_console_setup() will be called
from the probe path, but will no longer exist, resulting in a kernel
panic.

Resolve this issue by removing the __init annotation from
msm_console_setup().

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 736b74f..1090960 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1634,7 +1634,7 @@ static void msm_console_write(struct console *co, const char *s,
 	__msm_console_write(port, s, count, msm_port->is_uartdm);
 }
 
-static int __init msm_console_setup(struct console *co, char *options)
+static int msm_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = 115200;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

