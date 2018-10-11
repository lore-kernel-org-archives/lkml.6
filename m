Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2387C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77068213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmIRdRnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77068213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeJKXE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbeJKXE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:04:57 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B50D52098A;
        Thu, 11 Oct 2018 15:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272235;
        bh=DWiaycFcIFiIItZis6KF0e1M3I1WcoG1hJfhM1xANkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TmIRdRnVPGxW3fbUAfSrwrDhfoG5NLCYxv8nuJNxceQXHIJ7ZEUN1rF+GHeqwT3Su
         fqoUMumI81OiXS1uYfxPMBTgiyIwcKM0l5ggnEr9AxwFeXFH3I0A9VD+91+EsG5Fpf
         aMb8jxI8ieLV3sX86wbTmI8UgL/d2w9xWZVss73Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhouyang Jia <jiazhouyang09@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 037/120] drivers/tty: add error handling for pcmcia_loop_config
Date:   Thu, 11 Oct 2018 17:33:38 +0200
Message-Id: <20181011152551.272014275@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 85c634e919bd6ef17427f26a52920aeba12e16ee ]

When pcmcia_loop_config fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pcmcia_loop_config.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/serial_cs.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -629,8 +629,10 @@ static int serial_config(struct pcmcia_d
 	    (link->has_func_id) &&
 	    (link->socket->pcmcia_pfc == 0) &&
 	    ((link->func_id == CISTPL_FUNCID_MULTI) ||
-	     (link->func_id == CISTPL_FUNCID_SERIAL)))
-		pcmcia_loop_config(link, serial_check_for_multi, info);
+	     (link->func_id == CISTPL_FUNCID_SERIAL))) {
+		if (pcmcia_loop_config(link, serial_check_for_multi, info))
+			goto failed;
+	}
 
 	/*
 	 * Apply any multi-port quirk.


