Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4044C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EEE23FE7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EEE23FE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932867AbeGFFrg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:47:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932824AbeGFFrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:47:33 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EAC2186A;
        Fri,  6 Jul 2018 05:47:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 4.17 05/46] usb: typec: tcpm: fix logbuffer index is wrong if _tcpm_log is re-entered
Date:   Fri,  6 Jul 2018 07:46:26 +0200
Message-Id: <20180706054524.870420292@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054524.595521988@linuxfoundation.org>
References: <20180706054524.595521988@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Chen <peter.chen@nxp.com>

commit d5a4f93511b7000183c0d528739b824752139f79 upstream.

The port->logbuffer_head may be wrong if the two processes enters
_tcpm_log at the mostly same time. The 2nd process enters _tcpm_log
before the 1st process update the index, then the 2nd process will
not allocate logbuffer, when the 2nd process tries to use log buffer,
the index has already updated by the 1st process, so it will get
NULL pointer for updated logbuffer, the error message like below:

	tcpci 0-0050: Log buffer index 6 is NULL

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jun Li <jun.li@nxp.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/tcpm.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -388,17 +388,18 @@ static void _tcpm_log(struct tcpm_port *
 	u64 ts_nsec = local_clock();
 	unsigned long rem_nsec;
 
+	mutex_lock(&port->logbuffer_lock);
 	if (!port->logbuffer[port->logbuffer_head]) {
 		port->logbuffer[port->logbuffer_head] =
 				kzalloc(LOG_BUFFER_ENTRY_SIZE, GFP_KERNEL);
-		if (!port->logbuffer[port->logbuffer_head])
+		if (!port->logbuffer[port->logbuffer_head]) {
+			mutex_unlock(&port->logbuffer_lock);
 			return;
+		}
 	}
 
 	vsnprintf(tmpbuffer, sizeof(tmpbuffer), fmt, args);
 
-	mutex_lock(&port->logbuffer_lock);
-
 	if (tcpm_log_full(port)) {
 		port->logbuffer_head = max(port->logbuffer_head - 1, 0);
 		strcpy(tmpbuffer, "overflow");


