Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836DFC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E23620864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E23620864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967175AbeFRIbf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:31:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967158AbeFRIbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:31:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 11E57C75;
        Mon, 18 Jun 2018 08:31:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Regnery <tobias.regnery@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 049/189] usb: typec: ucsi: fix tracepoint related build error
Date:   Mon, 18 Jun 2018 10:12:25 +0200
Message-Id: <20180618081211.308447559@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Regnery <tobias.regnery@gmail.com>

[ Upstream commit 2f860691c2d2e3af1404ffeb2d22dd5c3dbca811 ]

There is the following build error with CONFIG_TYPEC_UCSI=m, CONFIG_FTRACE=y
and CONFIG_TRACING=n:

ERROR: "__tracepoint_ucsi_command" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_register_port" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_notify" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_reset_ppm" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_run_command" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_ack" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_connector_change" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!

This compination is quite hard to create because CONFIG_TRACING gets selected
only in rare cases without CONFIG_FTRACE.

The build failure is caused by conditionally compiling trace.c depending on
the wrong option CONFIG_FTRACE. Change this to depend on CONFIG_TRACING like
other users of tracepoints do.

Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/typec/ucsi/Makefile
+++ b/drivers/usb/typec/ucsi/Makefile
@@ -5,6 +5,6 @@ obj-$(CONFIG_TYPEC_UCSI)	+= typec_ucsi.o
 
 typec_ucsi-y			:= ucsi.o
 
-typec_ucsi-$(CONFIG_FTRACE)	+= trace.o
+typec_ucsi-$(CONFIG_TRACING)	+= trace.o
 
 obj-$(CONFIG_UCSI_ACPI)		+= ucsi_acpi.o


