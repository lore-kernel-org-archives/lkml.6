Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0316FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F6921486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F6921486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbeIXRkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:40:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50554 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeIXRkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:40:43 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6F3601070;
        Mon, 24 Sep 2018 11:39:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 047/105] ata: libahci: Correct setting of DEVSLP register
Date:   Mon, 24 Sep 2018 13:33:33 +0200
Message-Id: <20180924113118.594351948@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
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

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 2dbb3ec29a6c069035857a2fc4c24e80e5dfe3cc ]

We have seen that on some platforms, SATA device never show any DEVSLP
residency. This prevent power gating of SATA IP, which prevent system
to transition to low power mode in systems with SLP_S0 aka modern
standby systems. The PHY logic is off only in DEVSLP not in slumber.
Reference:
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets
/332995-skylake-i-o-platform-datasheet-volume-1.pdf
Section 28.7.6.1

Here driver is trying to do read-modify-write the devslp register. But
not resetting the bits for which this driver will modify values (DITO,
MDAT and DETO). So simply reset those bits before updating to new values.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libahci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2052,6 +2052,8 @@ static void ahci_set_aggressive_devslp(s
 		deto = 20;
 	}
 
+	/* Make dito, mdat, deto bits to 0s */
+	devslp &= ~GENMASK_ULL(24, 2);
 	devslp |= ((dito << PORT_DEVSLP_DITO_OFFSET) |
 		   (mdat << PORT_DEVSLP_MDAT_OFFSET) |
 		   (deto << PORT_DEVSLP_DETO_OFFSET) |


