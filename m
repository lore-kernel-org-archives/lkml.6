Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC966ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC12F20852
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vBH7pOVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC12F20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeGRKo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:44:56 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:13132 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeGRKoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:44:55 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180718100744epoutp042b0111e624bbe3456e6cc6ab03def07d~CbqG7czVU1296712967epoutp04G;
        Wed, 18 Jul 2018 10:07:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180718100744epoutp042b0111e624bbe3456e6cc6ab03def07d~CbqG7czVU1296712967epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531908464;
        bh=DuoYZZIhHsNXw6SY+a+JK9UdUNr9nnmy+NwrZ67o2LQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=vBH7pOVzV6Qe41CCdFFCDQzF8F3lppWIcV0m0NWZsTOUhP6oFZru24hiRbsSffDhw
         K5X+6OkRVLcR/Q2++q0wMDC6HpiEabUVDTfBbyWy1RcwErdMWDJsM0P0qTyhPh9qG8
         sp+RuY1rVBOsRwqJ8iBykUJdZ4YbiJGXM6Bwu8No=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.198]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20180718100742epcas5p1105fc0e078baeabe36a5525ec1ec4edb~CbqFUQCk61166511665epcas5p18;
        Wed, 18 Jul 2018 10:07:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.CF.04203.E611F4B5; Wed, 18 Jul 2018 19:07:42 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180718100741epcas1p393bea852d102e903ab6a48ff952761db~CbqEmuzpK1549115491epcas1p3M;
        Wed, 18 Jul 2018 10:07:41 +0000 (GMT)
X-AuditID: b6c32a39-235ff7000000106b-28-5b4f116e4aa1
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id ED.3F.03915.D611F4B5; Wed, 18 Jul
        2018 19:07:41 +0900 (KST)
Received: from srikanthh.sa.corp.samsungelectronics.net ([107.108.218.43])
        by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PC2000UW44NTX70@mmp2.samsung.com>;
        Wed, 18 Jul 2018 19:07:41 +0900 (KST)
From:   Srikanth K H <srikanth.h@samsung.com>
To:     perex@perex.cz, tiwai@suse.com, elfring@users.sourceforge.net,
        ben.hutchings@codethink.co.uk, viro@zeniv.linux.org.uk,
        keescook@chromium.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     cpgs@samsung.com, srikanth.h@samsung.com
Subject: [PATCH 1/1] Preventive fix in sound module
Date:   Wed, 18 Jul 2018 15:37:48 +0530
Message-id: <1531908468-1352-1-git-send-email-srikanth.h@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7bCmnm6eoH+0weYv4hZXLh5isrix8x+r
        xctDmhbnO5czW5zpzrW4vGsOm0Xnrn5Wix0vXjFZbPi+ltHi/N/jrA5cHhs+N7F5zG64yOLx
        7OVkJo99b5exefRtWcXosX7LVRaPplPtrB6fN8l5bHrylimAMyrVJiM1MSW1SCE1Lzk/JTMv
        3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoTiWFssScUqBQQGJxsZK+nU1RfmlJ
        qkJGfnGJrVK0oaGRnqGBuZ6REZA2jbUyMgUqSUjNOHtyL1PBLbaKjt8PmRsYN7N2MXJySAiY
        SExdspm5i5GLQ0hgB6PE5k/NTBDOd0aJfSsuMsNUPX7ZxQqR2MAoMWnlRXYIp4dJYvnnqYwg
        VWwC2hLv/zaD2SICFxkllhyVAbGZBXQkuncsAYpzcAgLGEu83eUIYrIIqEps2F0BUsEr4CrR
        cvgSE8QuOYmTxyaD7ZIQWMAm8WhfD9QRLhLX3jyGKhKWeHV8CzvIHAkBaYlLR20h6iczSixb
        thyqZjWjxLsHfhC2vcSMxVuZIc7hk3j3tYcVopdXoqNNCKLEQ2Ll9n52EFtIIFZi++UzLBMY
        JRYwMqxiFEstKM5NTy02LDDVK07MLS7NS9dLzs/dxAhOLFqWOxiPnfM5xCjAwajEw5vx1zda
        iDWxrLgy9xCjBAezkgjvwfd+0UK8KYmVValF+fFFpTmpxYcYTYEhMJFZSjQ5H5j08kriDU2N
        zMwMLM0tzSwMLJTEebfzekQLCaQnlqRmp6YWpBbB9DFxcEo1MPrvrYj4foc9/YHl3FtdRX0W
        O2I+G5cfUCkRr9/e7H39s+V8yX8+vz9uzM0Jn7DP6brATM/pn3jM9uvu0H+zTcrJ3WeGMvO/
        xc0HkiT5N5p6CC67phBvrpG2c8KCZRfEpzT22MZHRzm+1XhQN8exh/fp9kcBbInTDdVjg7Z8
        fS15SmL2u1kat5RYijMSDbWYi4oTAd0ZPMZCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCLMWRmVeSWpSXmKPExsVy+t9jQd1cQf9og5Z2FYsrFw8xWdzY+Y/V
        4uUhTYvzncuZLc5051pc3jWHzaJzVz+rxY4Xr5gsNnxfy2hx/u9xVgcujw2fm9g8ZjdcZPF4
        9nIyk8e+t8vYPPq2rGL0WL/lKotH06l2Vo/Pm+Q8Nj15yxTAGcVlk5Kak1mWWqRvl8CVcfbk
        XqaCW2wVHb8fMjcwbmbtYuTkkBAwkXj8sgvI5uIQEljHKDF7/jk2CKePSaJnzhawKjYBbYn3
        f5sZQRIiAucZJeav3cEGkmAW0JHo3rEEKMHBISxgLPF2lyOIySKgKrFhdwVIBa+Aq0TL4UtM
        EMvkJE4em8w6gZFrASPDKkbJ1ILi3PTcYqMCw7zUcr3ixNzi0rx0veT83E2MwLDadlirbwfj
        /SXxhxgFOBiVeHgz/vpGC7EmlhVX5h5ilOBgVhLhPfjeL1qINyWxsiq1KD++qDQntfgQozQH
        i5I47+28Y5FCAumJJanZqakFqUUwWSYOTqkGRlGlA+Xuxa3bdi49y9nDVu37piT41HM1jban
        UX/3iq65zXHj7cWz+rPeF6hyLZv6k731sGNby/9ZHddvSOafzO66/LluTfmW5Lj8/3tW3g46
        Y3h/4k8HjhIf8+KDe9o+squ/uxH172SX6ydzxribNjvUM5UY2TuCG1fuNz6uzdS4L+DxpoTq
        WiWW4oxEQy3mouJEABFSdiYnAgAA
X-CMS-MailID: 20180718100741epcas1p393bea852d102e903ab6a48ff952761db
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180718100741epcas1p393bea852d102e903ab6a48ff952761db
References: <CGME20180718100741epcas1p393bea852d102e903ab6a48ff952761db@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srikanth K H <srikanth.h@samsung.com>
---
 sound/core/timer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index b6f076bb..c7be4f1 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1192,10 +1192,12 @@ static void snd_timer_proc_read(struct snd_info_entry *entry,
 			break;
 		case SNDRV_TIMER_CLASS_CARD:
 			snd_iprintf(buffer, "C%i-%i: ",
-				    timer->card->number, timer->tmr_device);
+					timer->card ? timer->card->number : -1,
+					timer->tmr_device);
 			break;
 		case SNDRV_TIMER_CLASS_PCM:
-			snd_iprintf(buffer, "P%i-%i-%i: ", timer->card->number,
+			snd_iprintf(buffer, "P%i-%i-%i: ",
+					timer->card ? timer->card->number : -1,
 				    timer->tmr_device, timer->tmr_subdevice);
 			break;
 		default:
-- 
1.9.1

