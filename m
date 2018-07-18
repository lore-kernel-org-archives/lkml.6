Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C02CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13432064D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b3IgVoag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13432064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbeGRPpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:45:17 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:26965 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbeGRPpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:45:17 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180718150656epoutp045b410df52049f1609c3eb9e84474372e~CfvWM5cMU2369823698epoutp04H;
        Wed, 18 Jul 2018 15:06:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180718150656epoutp045b410df52049f1609c3eb9e84474372e~CfvWM5cMU2369823698epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531926416;
        bh=LBjsHzCVpo7Tp6FSOLnIQM44D+6aBS1K4TTjvoZ2J3Q=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=b3IgVoagVQvlhj+6x/sy6Ra4eXqMd5iK6uCChAyNhnrrZjt0SJXM12OrrKY6eLuWa
         DL0+7drZI4MBfOl27aFaoDzVUoGiF99iNh4thTI2YA0RSMqjgDanr5VgYRatUc+PHO
         +Keowfz3gz3O3CYBDCCqhmcj6L//4WdYXBqK3dSc=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.197]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20180718150654epcas5p29172ba79d3ff3837de8f0d927082cf96~CfvUS1oA81327013270epcas5p2f;
        Wed, 18 Jul 2018 15:06:54 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.E3.04186.E875F4B5; Thu, 19 Jul 2018 00:06:54 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20180718150653epcas2p3c2f0e36569529df72ce0b79a22867eac~CfvTk9THD2602826028epcas2p3X;
        Wed, 18 Jul 2018 15:06:53 +0000 (GMT)
X-AuditID: b6c32a47-9c7ff7000000105a-c3-5b4f578ea214
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.54.04192.D875F4B5; Thu, 19 Jul 2018 00:06:53 +0900 (KST)
Received: from srikanthh.sa.corp.samsungelectronics.net ([107.108.218.43])
        by mmp1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PC200D9MHZBC870@mmp1.samsung.com>;
        Thu, 19 Jul 2018 00:06:53 +0900 (KST)
From:   Srikanth K H <srikanth.h@samsung.com>
To:     perex@perex.cz, tiwai@suse.com, elfring@users.sourceforge.net,
        ben.hutchings@codethink.co.uk, viro@zeniv.linux.org.uk,
        keescook@chromium.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     cpgs@samsung.com, srikanth.h@samsung.com
Subject: [PATCHv2 1/1] Preventive fix in sound module
Date:   Wed, 18 Jul 2018 20:37:00 +0530
Message-id: <1531926420-25488-1-git-send-email-srikanth.h@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1531908468-1352-1-git-send-email-srikanth.h@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7bCmhW5fuH+0wYvdPBZXLh5isrix8x+r
        xctDmhbnO5czW5zpzrW4vGsOm0Xnrn5Wix0vXjFZbPi+ltHi/N/jrA5cHhs+N7F5zG64yOLx
        7OVkJo99b5exefRtWcXosX7LVRaPplPtrB6fN8l5bHrylimAMyrVJiM1MSW1SCE1Lzk/JTMv
        3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoTiWFssScUqBQQGJxsZK+nU1RfmlJ
        qkJGfnGJrVK0oaGRnqGBuZ6REZA2jbUyMgUqSUjNuHy8kalgD2/F4RNxDYy/uLoYOTkkBEwk
        uibPYQGxhQR2MEpM2FLXxcgFZH9nlGibPYEJpujl1lmsEIndjBJN548wQjg9TBKTd6wBa2cT
        0JZ4/7eZEcQWEbjIKLHkqAyIzSygI9G9YwlYXFjAVGLi/Ctg9SwCqhKHGi6zdzFycPAKuElM
        eh8PsUxO4uSxyawgNidQ+M2EGWC7JAT2sEl0nzvDDFIvIeAicWUpJ0S9sMSr41vYIWxpiWer
        NkLVT2aUWLZsOdQHqxkl3j3wg7DtJWYs3soMcRufRMfhv+wQM3klOtqEIEo8JG6u2MgGCZWZ
        jBKf9oZOYJRcwMiwilEstaA4Nz212KjAWK84Mbe4NC9dLzk/dxMjON1oue9g3HbO5xCjAAej
        Eg9vxl/faCHWxLLiytxDjBIczEoivAff+0UL8aYkVlalFuXHF5XmpBYfYjQFhsZEZinR5Hxg
        KswriTc0NTIzM7A0MzK2MDRWEufdw+sRLSSQnliSmp2aWpBaBNPHxMEp1cAYeDpKee3llYlp
        2ccanNeq7Mx/ezCi+2JvqbTRBS2fCbv+hrz7YGPwWXkj88Odb2eH88VlNJSl79D6fi+d/XnV
        Myu+japGhl96tM78mLb9ls1KMX3DT546qZKCiuYP9uqtUI22juRy/S4SFev2ymH3pSkGXulp
        3/smnf/he/NSyum1h7UqG+8osRRnJBpqMRcVJwIAbDOLJE0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVy+t9jAd3ecP9og9Z+aYsrFw8xWdzY+Y/V
        4uUhTYvzncuZLc5051pc3jWHzaJzVz+rxY4Xr5gsNnxfy2hx/u9xVgcujw2fm9g8ZjdcZPF4
        9nIyk8e+t8vYPPq2rGL0WL/lKotH06l2Vo/Pm+Q8Nj15yxTAGcVlk5Kak1mWWqRvl8CVcfl4
        I1PBHt6KwyfiGhh/cXUxcnJICJhIvNw6i7WLkYtDSGAno8T0O0fZIZw+Jom+Hz+YQarYBLQl
        3v9tZgRJiAicZ5SYv3YHG0iCWUBHonvHEkYQW1jAVGLi/CssIDaLgKrEoYbLQJM4OHgF3CQm
        vY+H2CYncfLYZFYQmxMo/GbCDLBWIQFXiZPdl5gnMPIsYGRYxSiZWlCcm55bbFRglJdarlec
        mFtcmpeul5yfu4kRGIbbDmv172B8vCT+EKMAB6MSD2/GX99oIdbEsuLK3EOMEhzMSiK8B9/7
        RQvxpiRWVqUW5ccXleakFh9ilOZgURLn5c8/FikkkJ5YkpqdmlqQWgSTZeLglGpgnDRHKTtt
        InucnmOWB0eMAr9Fs72ByYMFpvoX/5YuC7K//0NRd43T9qcmO3hVQzhEGKfyMpcWHZCZ8X8f
        j6xgFYP5v/UlZ/7m+Lp1G1y6PymvT097XrlhScSuw3/ck1dMmhjwyt9c6YWM5fKDsVU7k+Md
        j5ZOPXZmndGKQj/b7II/axpecsYrsRRnJBpqMRcVJwIA1WmILj8CAAA=
X-CMS-MailID: 20180718150653epcas2p3c2f0e36569529df72ce0b79a22867eac
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180718150653epcas2p3c2f0e36569529df72ce0b79a22867eac
References: <1531908468-1352-1-git-send-email-srikanth.h@samsung.com>
        <CGME20180718150653epcas2p3c2f0e36569529df72ce0b79a22867eac@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the timer object is created without the card for entries
"SNDRV_TIMER_CLASS_CARD" and "SNDRV_TIMER_CLASS_PCM", then
while reading the sound info entry in function
"snd_timer_proc_read" the card information is directly
dereferenced without checking for NULL and hence kernel
panic occur. So as preventive measure while the creating
the sound timer object is created the card information
availability is checked for the mentioned entries and
returned error if its NULL.

Signed-off-by: Srikanth K H <srikanth.h@samsung.com>
---
 sound/core/timer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index c7be4f1..06f734f 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -883,6 +883,11 @@ int snd_timer_new(struct snd_card *card, char *id, struct snd_timer_id *tid,
 
 	if (snd_BUG_ON(!tid))
 		return -EINVAL;
+	if (tid->dev_class == SNDRV_TIMER_CLASS_CARD ||
+			tid->dev_class == SNDRV_TIMER_CLASS_PCM) {
+		if (WARN_ON(!card))
+			return -EINVAL;
+	}
 	if (rtimer)
 		*rtimer = NULL;
 	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
@@ -1192,12 +1197,10 @@ static void snd_timer_proc_read(struct snd_info_entry *entry,
 			break;
 		case SNDRV_TIMER_CLASS_CARD:
 			snd_iprintf(buffer, "C%i-%i: ",
-					timer->card ? timer->card->number : -1,
-					timer->tmr_device);
+				    timer->card->number, timer->tmr_device);
 			break;
 		case SNDRV_TIMER_CLASS_PCM:
-			snd_iprintf(buffer, "P%i-%i-%i: ",
-					timer->card ? timer->card->number : -1,
+			snd_iprintf(buffer, "P%i-%i-%i: ", timer->card->number,
 				    timer->tmr_device, timer->tmr_subdevice);
 			break;
 		default:
-- 
1.9.1

