Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D3CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BB6214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gydhJQmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BB6214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbeIRADH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:03:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34342 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbeIRADG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:03:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so8088697pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 11:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=B0zBpssfvxrtSCSyQbtyOm38bQlWUmZUf/lgu2ZUuu8=;
        b=gydhJQmQB9w8ls3zQWkNha1rmmvVTOnARsOVMj4ZvhJhMzm9Xe/ArVavuZd74PwTxn
         Tm+dcT/GYyJlf8SzmUoXuHTBtkcLZrf8X5hTIbucDMWR5qhbRxAJd8YHWLBa3qt94Fpo
         RYC8jIw7x/VCC9WtLCVKC7n3Z3IXqSkbyO948=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=B0zBpssfvxrtSCSyQbtyOm38bQlWUmZUf/lgu2ZUuu8=;
        b=C33VDx3Ddz1UfueUOLUiqlAnVN6LMzLvOrN3ntU2pisjKdukKT+MXMUntMg3h7FA7u
         T/CB7E/C92sDjXgjVRTRsM70nMicn/7NeR6rNH1DIP6ANJ3Gght3GzWibPFr+m+OcPU0
         xP+Eeh0qQeqAlWiA896ffftPHejXSJ5BuPqT+rlrUJG+l4jlYQpzAH5GxwyWh5q/swNp
         /2SA5c+HVgeuKmIz3iWNaS8L8xtFTKCkC7akXG26FsXisyXY3AzVSv8kPLj5wrTAP5rX
         8+SK16rI7/sYrEAuy56OQwx5xgclwVVO8RrXxByBf+fWUQ1GxvnAY2cy96tVWrGpSsQB
         kZ+A==
X-Gm-Message-State: APzg51D4vpqoO7xltU2N6EZlcZvh9n/XlDdrl72/lOkVN4zaLS5DUKhe
        g0vhxgoVFZT106bA3PKO4kyZXg==
X-Google-Smtp-Source: ANB0VdZsIjCG2/aUuIPcHnbOZxo9xyrMNzeRei+RJXhyV+TVL76D9cwD0VHfv4QeuxEAVfbmdhPcXw==
X-Received: by 2002:a62:47d1:: with SMTP id p78-v6mr27118912pfi.197.1537209273296;
        Mon, 17 Sep 2018 11:34:33 -0700 (PDT)
Received: from ubuntu.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id i7-v6sm17544137pgs.17.2018.09.17.11.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Sep 2018 11:34:32 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        broonie@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] serial: sprd: Change 'int' to 'unsigned int'
Date:   Mon, 17 Sep 2018 11:33:43 -0700
Message-Id: <7167a2917e6469e7d7a04fa4558f3486b8294722.1537208449.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
References: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
In-Reply-To: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
References: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register offset value should be 'unsigned int' type.

Moreover, prefer 'unsigned int' to bare use of 'unsigned'.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
Changes from v1:
 - Add acked tag from Chunyan.
---
 drivers/tty/serial/sprd_serial.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 03b0cd4..8d5c9cd 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -109,12 +109,14 @@ struct sprd_uart_port {
 static struct sprd_uart_port *sprd_port[UART_NR_MAX];
 static int sprd_ports_num;
 
-static inline unsigned int serial_in(struct uart_port *port, int offset)
+static inline unsigned int serial_in(struct uart_port *port,
+				     unsigned int offset)
 {
 	return readl_relaxed(port->membase + offset);
 }
 
-static inline void serial_out(struct uart_port *port, int offset, int value)
+static inline void serial_out(struct uart_port *port, unsigned int offset,
+			      int value)
 {
 	writel_relaxed(value, port->membase + offset);
 }
@@ -598,8 +600,7 @@ static void sprd_putc(struct uart_port *port, int c)
 	writeb(c, port->membase + SPRD_TXD);
 }
 
-static void sprd_early_write(struct console *con, const char *s,
-				    unsigned n)
+static void sprd_early_write(struct console *con, const char *s, unsigned int n)
 {
 	struct earlycon_device *dev = con->data;
 
-- 
1.9.1

