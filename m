Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312D0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012A722419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012A722419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbeKNXEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:04:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:44622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732845AbeKNXDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:03:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69815B0F5;
        Wed, 14 Nov 2018 13:00:23 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 13/16] staging: vchiq_core: fix logic redundancy in parse_open
Date:   Wed, 14 Nov 2018 13:59:39 +0100
Message-Id: <20181114125942.25163-14-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114125942.25163-1-nsaenzjulienne@suse.de>
References: <20181114125942.25163-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We update sync to reflect that the firmware version is compatible with
that option. We don't need to check both of them again further down the
code.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c    | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index a45cdd08e209..5ee667d46eb5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1461,9 +1461,7 @@ parse_open(VCHIQ_STATE_T *state, VCHIQ_HEADER_T *header)
 					service->sync = 0;
 
 				/* Acknowledge the OPEN */
-				if (service->sync &&
-				    (state->version_common >=
-				     VCHIQ_VERSION_SYNCHRONOUS_MODE)) {
+				if (service->sync) {
 					if (queue_message_sync(
 						state,
 						NULL,
-- 
2.19.1

