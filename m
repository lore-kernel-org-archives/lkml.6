Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B12C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144BD20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144BD20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936810AbeFRIbi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:31:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967158AbeFRIbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:31:35 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E3A76C75;
        Mon, 18 Jun 2018 08:31:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 058/189] thermal: int3403_thermal: Fix NULL pointer deref on module load / probe
Date:   Mon, 18 Jun 2018 10:12:34 +0200
Message-Id: <20180618081211.654646476@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 13b86f50eaaddaea4bdd2fe476fd12e6a0951add ]

Starting with kernel 4.17 thermal_cooling_device_register() will call the
get_max_state() op during register.

Since we deref priv->priv in int3403_get_max_state() this means we must
set priv->priv before calling thermal_cooling_device_register().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/int340x_thermal/int3403_thermal.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/thermal/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3403_thermal.c
@@ -194,6 +194,7 @@ static int int3403_cdev_add(struct int34
 		return -EFAULT;
 	}
 
+	priv->priv = obj;
 	obj->max_state = p->package.count - 1;
 	obj->cdev =
 		thermal_cooling_device_register(acpi_device_bid(priv->adev),
@@ -201,8 +202,6 @@ static int int3403_cdev_add(struct int34
 	if (IS_ERR(obj->cdev))
 		result = PTR_ERR(obj->cdev);
 
-	priv->priv = obj;
-
 	kfree(buf.pointer);
 	/* TODO: add ACPI notification support */
 


