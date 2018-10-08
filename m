Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC86C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463F62145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjUlRd+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463F62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeJIBr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbeJIBr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:47:59 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D8BF214C2;
        Mon,  8 Oct 2018 18:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023695;
        bh=Kc1IuMAsgZARi7lYma8PnF5DJStoFR/IJX3gCgu2+OQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjUlRd+k5Df1GJZDgZSg42cSPs4lrQCD9dmYq+pcaekYBmsiQj2G0nTuvz9t5KuJy
         aZhhmOJKxRl2y+RmaxQWB7uzlsuZVVtXpZtdu0XHT3FClie0Wg5TeSAEbI51AhtS7B
         EFnFDNmcPyr31tz1w+nSCTv8dBszv0Q0jdp4+X2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhouyang Jia <jiazhouyang09@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 029/113] drivers/tty: add error handling for pcmcia_loop_config
Date:   Mon,  8 Oct 2018 20:30:30 +0200
Message-Id: <20181008175532.282872264@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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


