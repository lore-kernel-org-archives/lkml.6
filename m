Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFAAC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671F821AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671F821AA8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbeHIAp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:45:27 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.214]:28781 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729245AbeHIAp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:45:27 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id D7525D2FDD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Aug 2018 17:23:45 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id nWrpfDxMJPvAdnWrpfF6aS; Wed, 08 Aug 2018 17:23:45 -0500
X-Authority-Reason: nr=8
Received: from [189.250.54.46] (port=36210 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fnWrp-001QYX-7k; Wed, 08 Aug 2018 17:23:45 -0500
Date:   Wed, 8 Aug 2018 17:23:44 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: usb-audio: Mark expected switch fall-through
Message-ID: <20180808222344.GA3140@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.54.46
X-Source-L: No
X-Exim-ID: 1fnWrp-001QYX-7k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.54.46]:36210
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1357413 ("Missing break in switch")
Addresses-Coverity-ID: 114917 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/usb/mixer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 73e811f..c63c84b 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -856,12 +856,14 @@ static int check_input_term(struct mixer_build *state, int id,
 					term->type = UAC3_PROCESSING_UNIT << 16; /* virtual type */
 				else /* UAC_VERSION_2 */
 					term->type = UAC3_EFFECT_UNIT << 16; /* virtual type */
+				/* fall through */
 			case UAC1_EXTENSION_UNIT:
 			/* UAC2_PROCESSING_UNIT_V2 */
 				if (protocol == UAC_VERSION_1 && !term->type)
 					term->type = UAC3_EXTENSION_UNIT << 16; /* virtual type */
 				else if (protocol == UAC_VERSION_2 && !term->type)
 					term->type = UAC3_PROCESSING_UNIT << 16; /* virtual type */
+				/* fall through */
 			case UAC2_EXTENSION_UNIT_V2: {
 				struct uac_processing_unit_descriptor *d = p1;
 
-- 
2.7.4

