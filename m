Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56712C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC5F20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC5F20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbeIXSIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:08:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730394AbeIXSIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:08:51 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B34CF107B;
        Mon, 24 Sep 2018 12:07:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timo Wischer <twischer@de.adit-jv.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 097/111] ALSA: pcm: Fix snd_interval_refine first/last with open min/max
Date:   Mon, 24 Sep 2018 13:53:04 +0200
Message-Id: <20180924113114.602984839@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timo Wischer <twischer@de.adit-jv.com>

[ Upstream commit ff2d6acdf6f13d9f8fdcd890844c6d7535ac1f10 ]

Without this commit the following intervals [x y), (x y) were be
replaced to (y-1 y) by snd_interval_refine_last(). This was also done
if y-1 is part of the previous interval.
With this changes it will be replaced with [y-1 y) in case of y-1 is
part of the previous interval. A similar behavior will be used for
snd_interval_refine_first().

This commit adapts the changes for alsa-lib of commit
9bb985c ("pcm: snd_interval_refine_first/last: exclude value only if
also excluded before")

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/pcm_lib.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -648,27 +648,33 @@ EXPORT_SYMBOL(snd_interval_refine);
 
 static int snd_interval_refine_first(struct snd_interval *i)
 {
+	const unsigned int last_max = i->max;
+
 	if (snd_BUG_ON(snd_interval_empty(i)))
 		return -EINVAL;
 	if (snd_interval_single(i))
 		return 0;
 	i->max = i->min;
-	i->openmax = i->openmin;
-	if (i->openmax)
+	if (i->openmin)
 		i->max++;
+	/* only exclude max value if also excluded before refine */
+	i->openmax = (i->openmax && i->max >= last_max);
 	return 1;
 }
 
 static int snd_interval_refine_last(struct snd_interval *i)
 {
+	const unsigned int last_min = i->min;
+
 	if (snd_BUG_ON(snd_interval_empty(i)))
 		return -EINVAL;
 	if (snd_interval_single(i))
 		return 0;
 	i->min = i->max;
-	i->openmin = i->openmax;
-	if (i->openmin)
+	if (i->openmax)
 		i->min--;
+	/* only exclude min value if also excluded before refine */
+	i->openmin = (i->openmin && i->min <= last_min);
 	return 1;
 }
 


