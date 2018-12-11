Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCF3C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F05120855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544542996;
	bh=FiEsUDgBVmx7ZKwnsp7N1vK34T18XK0gSdd2mlyJH3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fwTxlIB+E7Jw1BYLOPtiF3+U/HM6BD+/KOZVv2NeJ/H8Bskqe5fgyn6z3Rn/csdG8
	 kPcJefdUnsHV2pWg0SyvxZdlEAy1xv61uLHuHqQ8wrFVmvd+pmAl3BLUvNARbdFtw0
	 QHdwHXxAe2cMEqVaX/R9m+wk9agifSGKstL447hw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F05120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeLKPnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:43:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbeLKPnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:43:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32F3320880;
        Tue, 11 Dec 2018 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544542992;
        bh=FiEsUDgBVmx7ZKwnsp7N1vK34T18XK0gSdd2mlyJH3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGN+qVB5mAEIe4A/iL8a9Tx0NJLMZeRIzmdOyRfvGK3O1JYaAfXlRs8BUOG9sG0zN
         L5I0S1bo8FTdiZFBUlUfwCfU0rcm1DsGAvQ08ubDC0Bs8vJDb9FF705ne3PXszCmbE
         liriNBW9uHdUjfBFI9C2ABIeCDCiWs7+SzY27K+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Wilck <mwilck@suse.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 3.18 26/54] scsi: scsi_devinfo: cleanly zero-pad devinfo strings
Date:   Tue, 11 Dec 2018 16:41:14 +0100
Message-Id: <20181211151547.472039485@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Wilck <mwilck@suse.com>

commit 81df022b688d43d2a3667518b2f755d384397910 upstream.

Cleanly fill memory for "vendor" and "model" with 0-bytes for the
"compatible" case rather than adding only a single 0 byte.  This
simplifies the devinfo code a a bit, and avoids mistakes in other places
of the code (not in current upstream, but we had one such mistake in the
SUSE kernel).

[mkp: applied by hand and added braces]

Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/scsi_devinfo.c |   22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -33,7 +33,6 @@ struct scsi_dev_info_list_table {
 };
 
 
-static const char spaces[] = "                "; /* 16 of them */
 static unsigned scsi_default_dev_flags;
 static LIST_HEAD(scsi_dev_info_list);
 static char scsi_dev_flags[256];
@@ -290,20 +289,13 @@ static void scsi_strcpy_devinfo(char *na
 	size_t from_length;
 
 	from_length = strlen(from);
-	strncpy(to, from, min(to_length, from_length));
-	if (from_length < to_length) {
-		if (compatible) {
-			/*
-			 * NUL terminate the string if it is short.
-			 */
-			to[from_length] = '\0';
-		} else {
-			/* 
-			 * space pad the string if it is short. 
-			 */
-			strncpy(&to[from_length], spaces,
-				to_length - from_length);
-		}
+	/* this zero-pads the destination */
+	strncpy(to, from, to_length);
+	if (from_length < to_length && !compatible) {
+		/*
+		 * space pad the string if it is short.
+		 */
+		memset(&to[from_length], ' ', to_length - from_length);
 	}
 	if (from_length > to_length)
 		 printk(KERN_WARNING "%s: %s string '%s' is too long\n",


