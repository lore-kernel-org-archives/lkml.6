Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB1CC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7BD2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7BD2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbeKUBXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:23:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:39262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729411AbeKUBXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:23:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4C94B0CE;
        Tue, 20 Nov 2018 14:54:14 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 16/16] staging: vchiq: add more tasks to the TODO list
Date:   Tue, 20 Nov 2018 15:53:51 +0100
Message-Id: <20181120145351.30390-17-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120145351.30390-1-nsaenzjulienne@suse.de>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TODO list was missing some tasks needed before upstreaming the
device.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/interface/vchi/TODO | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchi/TODO b/drivers/staging/vc04_services/interface/vchi/TODO
index 0b3ec75ff627..fc2752bc95b2 100644
--- a/drivers/staging/vc04_services/interface/vchi/TODO
+++ b/drivers/staging/vc04_services/interface/vchi/TODO
@@ -49,3 +49,45 @@ such as dev_info, dev_dbg, and friends.
 
 A short top-down description of this driver's architecture (function of
 kthreads, userspace, limitations) could be very helpful for reviewers.
+
+7) Review and comment memory barriers
+
+There is a heavy use of memory barriers in this driver, it would be very
+beneficial to go over all of them and, if correct, comment on their merits.
+Extra points to whomever confidently reviews the remote_event_*() family of
+functions.
+
+8) Get rid of custom function return values
+
+Most functions use a custom set of return values, we should force proper Linux
+error numbers. Special care is needed for VCHIQ_RETRY.
+
+9) Reformat core code with more sane indentations
+
+The code follows the 80 characters limitation yet tends to go 3 or 4 levels of
+indentation deep making it very unpleasant to read. This is specially relevant
+in the character driver ioctl code and in the core thread functions.
+
+10) Reorganize file structure: Move char driver to it's own file and join both
+platform files
+
+The cdev is defined alongside with the platform code in vchiq_arm.c. It would
+be nice to completely decouple it from the actual core code. For instance to be
+able to use bcm2835-audio without having /dev/vchiq created. One could argue
+it's better for security reasons or general cleanliness. It could even be
+interesting to create two different kernel modules, something the likes of
+vchiq-core.ko and vchiq-dev.ko. This would also ease the upstreaming process.
+
+The code in vchiq_bcm2835_arm.c should fit in the generic platform file.
+
+12) Get rid of all the struct typedefs
+
+Most structs are typedefd, it's not encouraged in the kernel.
+
+13) Get rid of all non essential global structures and create a proper per
+device structure
+
+The first thing one generally sees in a probe function is a memory allocation
+for all the device specific data. This structure is then passed all over the
+driver. This is good practice since it makes the driver work regardless of the
+number of devices probed.
-- 
2.19.1

