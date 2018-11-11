Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5BDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853C2208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qd7Ypr2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853C2208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbeKLJub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732323AbeKLISB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:01 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8F79223AE;
        Sun, 11 Nov 2018 22:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975286;
        bh=QvD2yYSKxM01tVJHZpOCmBlKrJLkWN5CSYuQ5Mzscj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qd7Ypr2hGYkAzU7vOY0lfEL7aPY2njQxqEywy482zRP/yUdMVwTMfEMxcKYOo0b1d
         lNIvDqJIJwevtIp2p5ezKpniml/7bjBx92kxiZ9KgqtFaQcV/iRQr4lz9KdMsRYAOJ
         CZTEogdv9HYJcet3/L05H7F54UeCTj81i/Ho1V6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.19 209/361] usb: typec: tcpm: Fix APDO PPS order checking to be based on voltage
Date:   Sun, 11 Nov 2018 14:19:16 -0800
Message-Id: <20181111221649.462027969@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

commit 1b6af2f58c2b1522e0804b150ca95e50a9e80ea7 upstream.

Current code mistakenly checks against max current to determine
order but this should be max voltage. This commit fixes the issue
so order is correctly determined, thus avoiding failure based on
a higher voltage PPS APDO having a lower maximum current output,
which is actually valid.

Fixes: 2eadc33f40d4 ("typec: tcpm: Add core support for sink side PPS")
Cc: <stable@vger.kernel.org>
Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/tcpm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -1430,8 +1430,8 @@ static enum pdo_err tcpm_caps_err(struct
 				if (pdo_apdo_type(pdo[i]) != APDO_TYPE_PPS)
 					break;
 
-				if (pdo_pps_apdo_max_current(pdo[i]) <
-				    pdo_pps_apdo_max_current(pdo[i - 1]))
+				if (pdo_pps_apdo_max_voltage(pdo[i]) <
+				    pdo_pps_apdo_max_voltage(pdo[i - 1]))
 					return PDO_ERR_PPS_APDO_NOT_SORTED;
 				else if (pdo_pps_apdo_min_voltage(pdo[i]) ==
 					  pdo_pps_apdo_min_voltage(pdo[i - 1]) &&


