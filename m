Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6KisD7I8GVu8NgAAmS7hNA
	; Thu, 07 Jun 2018 14:09:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2B4AE608B8; Thu,  7 Jun 2018 14:09:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9E4CC6063F;
	Thu,  7 Jun 2018 14:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E4CC6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933239AbeFGOJv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:09:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39442 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932829AbeFGOJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:36 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbM-0005Zl-R9; Thu, 07 Jun 2018 15:09:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0003HR-TV; Thu, 07 Jun 2018 15:09:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Kirill Marinushkin" <k.marinushkin@gmail.com>,
        "Takashi Iwai" <tiwai@suse.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.347057304@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 381/410] ALSA: usb-audio: Fix parsing descriptor of
 UAC2 processing unit
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill Marinushkin <k.marinushkin@gmail.com>

commit a6618f4aedb2b60932d766bd82ae7ce866e842aa upstream.

Currently, the offsets in the UAC2 processing unit descriptor are
calculated incorrectly. It causes an issue when connecting the device which
provides such a feature:

~~~~
[84126.724420] usb 1-1.3.1: invalid Processing Unit descriptor (id 18)
~~~~

After this patch is applied, the UAC2 processing unit inits w/o this error.

Fixes: 23caaf19b11e ("ALSA: usb-mixer: Add support for Audio Class v2.0")
Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/uapi/linux/usb/audio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/uapi/linux/usb/audio.h
+++ b/include/uapi/linux/usb/audio.h
@@ -369,7 +369,7 @@ static inline __u8 uac_processing_unit_b
 {
 	return (protocol == UAC_VERSION_1) ?
 		desc->baSourceID[desc->bNrInPins + 4] :
-		desc->baSourceID[desc->bNrInPins + 6];
+		2; /* in UAC2, this value is constant */
 }
 
 static inline __u8 *uac_processing_unit_bmControls(struct uac_processing_unit_descriptor *desc,
@@ -377,7 +377,7 @@ static inline __u8 *uac_processing_unit_
 {
 	return (protocol == UAC_VERSION_1) ?
 		&desc->baSourceID[desc->bNrInPins + 5] :
-		&desc->baSourceID[desc->bNrInPins + 7];
+		&desc->baSourceID[desc->bNrInPins + 6];
 }
 
 static inline __u8 uac_processing_unit_iProcessing(struct uac_processing_unit_descriptor *desc,
