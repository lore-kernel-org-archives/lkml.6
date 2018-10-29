Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC9FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E712084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cdj/bG62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E712084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeJ3C6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:58:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40443 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbeJ3C6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:58:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id b9-v6so4189266pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uuVBjLPPAr7vrrxtncgOpWRyj/co0fFGtiULUHSo5OQ=;
        b=cdj/bG62aAL2KnWaVIAJOSrpnC9nsbsXjlggJ6B4TOaBaVxAQ6niOV4YmXCNLDD+aS
         o8RSp1GrDIo6cW0XokWZoyRkvyuge1ANtIF5d2SmghbRacfD9khbep4aBt284a/DhMGX
         wwpy3XRtX76rgm6BpD/CSNA4U/BAad+cmtoRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uuVBjLPPAr7vrrxtncgOpWRyj/co0fFGtiULUHSo5OQ=;
        b=cgBNOor+c434fAVnnftvrXUwe8amJWxkhe7fFoAsl7msu/xcvn8bNuveCMbjEsZ985
         cPZDY7NjiWwo3w7L+sPLUgRPZs8hRJro9pmlco5xGhQCVPM1tqHbAPslbxW7GuabJhEB
         kD0FQ71AYV9Xi+iwYyfUm0zFyAi8KKir571WmzmMs6jvk32eHDb/9LegE4/hX+7U0bn4
         oA55Cmcv3j2ni3MvJfE1hrmtFgAh35rep698na7HqppcRF7HXD0tuQrG3Vynh8fFnl9s
         Oxyn408ipitjsWMHn39aD2zkxEBajF8M8ghEZoVVeHCsjCb3f6PQ1AmgouMu1u51dKBx
         3NOw==
X-Gm-Message-State: AGRZ1gLdNTMepPvhxil/uAXLtc9CVgJ+zH/gaCdDqHrdqnbpVY3dPIe7
        MWRSO4chAInPwNVxcuPVV9ddDA==
X-Google-Smtp-Source: AJdET5c2PDQALEVV+aHTh8q3e5YsAPaHEDo1keDmh9zyoI809z4dgnYzJmUQlESJWYq9B7Wa4BZIgQ==
X-Received: by 2002:a17:902:1124:: with SMTP id d33-v6mr6564607pla.125.1540836508342;
        Mon, 29 Oct 2018 11:08:28 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id u13-v6sm20537765pgp.18.2018.10.29.11.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:08:26 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        tglx@linutronix.de, mingo@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        jslaby@suse.com
Subject: [PATCH 3/7] serial: qcom_geni_serial: Process sysrq at port unlock time
Date:   Mon, 29 Oct 2018 11:07:03 -0700
Message-Id: <20181029180707.207546-4-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
References: <20181029180707.207546-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's take advantage of the new ("serial: core: Allow processing sysrq
at port unlock time") to handle sysrqs more cleanly.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3c8e0202da8b..20edce1e222e 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -499,9 +499,7 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 					continue;
 			}
 
-			spin_unlock(&uport->lock);
-			sysrq = uart_handle_sysrq_char(uport, buf[c]);
-			spin_lock(&uport->lock);
+			sysrq = uart_prepare_sysrq_char(uport, buf[c]);
 
 			if (!sysrq)
 				tty_insert_flip_char(tport, buf[c], TTY_NORMAL);
@@ -811,7 +809,8 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 		qcom_geni_serial_handle_rx(uport, drop_rx);
 
 out_unlock:
-	spin_unlock_irqrestore(&uport->lock, flags);
+	uart_unlock_and_check_sysrq(uport, flags);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.19.1.568.g152ad8e336-goog

