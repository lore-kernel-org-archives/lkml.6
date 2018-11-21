Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C1EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F16B21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LxcMmjh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F16B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbeKVEha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:37:30 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38066 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732541AbeKVEh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:37:28 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181121180204euoutp01f5778cba2ae0bedc43f02420b0dfb2a7~pNaPCvRMC0920709207euoutp01_
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 18:02:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181121180204euoutp01f5778cba2ae0bedc43f02420b0dfb2a7~pNaPCvRMC0920709207euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542823324;
        bh=caHqBywNIZe62FMEK8RKMURrBXS1eVzbboJZjefYi04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LxcMmjh0JD9Ndb77YJZQ/4b+/pYQnwh1jArZjMzGMM4jJjSBkutUcgdDwBWZhJOPb
         945JKx45uiXe4fFPk/SGVnFesaRIZZ9k0+wQJpiCaMDkoSdLoyDFZbGSWolY56CQbO
         o0m6aTlnTz+i6g5Lt2cysRV01yXRYqaetJ8+3WtU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181121180203eucas1p2ba2f74fb5af5c1e14081ed6b5bfd8125~pNaN9ck9e3244932449eucas1p2F;
        Wed, 21 Nov 2018 18:02:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A6.89.04294.B9D95FB5; Wed, 21
        Nov 2018 18:02:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181121180202eucas1p27d3aa58411abeae03181c38b91fc67de~pNaNBC26v0549405494eucas1p2h;
        Wed, 21 Nov 2018 18:02:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181121180202eusmtrp15bf75ed2f2fd162596003c6b5f9a68a9~pNaMxfkOg2594725947eusmtrp1n;
        Wed, 21 Nov 2018 18:02:02 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-bf-5bf59d9bc85d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AB.7C.04128.A9D95FB5; Wed, 21
        Nov 2018 18:02:02 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181121180201eusmtip2aab775dd1624480b29c934938be1a814~pNaL5vPVR1643316433eusmtip2O;
        Wed, 21 Nov 2018 18:02:01 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 2/6] devfreq: refactor set_target frequency function
Date:   Wed, 21 Nov 2018 19:01:37 +0100
Message-Id: <1542823301-23563-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe1BMURzHnfvYe0vLtSo/MZgdRnmUDOOM13j0xx3+YDAGmWFxJ7Eb7ZX3
        jC0j1VbySEZFM2GzZdK2slIo1Za0lchrSt7SMrRL00jsdcN/n/N9/H5nzhyWVPXQAWxk1C5B
        H6XRqhXeVElNr2NqZva38Gk5H1S44loQLjpTSOPrRd9p/Nj9nsbnqxw0PpxbqMD3jTp87HUX
        iRsbrzK4Ic7J4GeG0fjsqXICW1630rilNEuBXSlVCJ9pvEXgK1VtDL74uJnAz2PzFLjtXrVn
        Rv0DGh8pr2JwfP4XGjub2qkFwJfcLKH5gnMFiM80NFN82rFuxOeWdRK8xZyo4G9nFzB88YVD
        fH8Nw1d8LiN466OjFJ9qNSM+L7+H4V2WMcuHrPOeu0XQRu4W9CHzN3pvzXoTS+y0Beztie1k
        DOi4fxLyYoGbATfev2AkVnF5CFwGnyTk7WE3goa+bko+uBB8rL1E/22k16SQsmFCYM39Rf6r
        1HUUoyTEsgouGGzmaKngy+UieGALkjIkV0tC6dcThGQM58LA/TwTSUxxE+BeTuEfXcktgYb2
        dwPbxsBTRyIpsRe3FFzmNCQNAu4yC86Xr0g5FAYP41oZmYfDR7t1gEdD/clkSmYRGhLMCpkP
        wtE620BmDty1N9PSpUkuCApLQ2R5IRxvKWIkGbgh8OTTMEkmPXiiJIOUZSUkxKvkdCBYk5sI
        mf3BVHB6YDgP6T8cjPw85xAYL70j09DYs/+X5SBkRiOEGFEXIYjTo4Q9waJGJ8ZERQRv3qGz
        IM93rO+3u22otG9TJeJYpPZRBq79Fq6iNbvFfbpKBCyp9lUmrPNIyi2affsF/Y4N+hitIFai
        USylHqE8MKgjXMVFaHYJ2wVhp6D/6xKsV4ABxcXmney05g92RS9+8nYh07U+v29Ph3/W6i/Z
        xnb7+pG98V/bA9LvjIvwtfjVOh0pbU6/xpWz5xi73b6L15QdWTbuR3lLE/NzciZtv2lUzTqk
        nTI+tVrR5WNakXF13tIDS+pOzZwWer7X1GTS9j/dbt27amjixDC8YebURaG3VVMqbm1TU+JW
        TegkUi9qfgOkBxl7igMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xe7qz5n6NNthxVcTi4FZNi40z1rNa
        bN/4jdXi+pfnrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+
        xmpxedccNovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOr
        xZsL91gcJDy27d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaP
        g+/2MHlsudrO4tG3ZRWjx4rV39k9Pm+SC+CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHU
        MzQ2j7UyMlXSt7NJSc3JLEst0rdL0MuY86SRqWCHVMX3xpfsDYwTxboYOTkkBEwkph7rZe5i
        5OIQEljKKHF14RNWiISYxKR929khbGGJP9e62EBsIYFPjBKTHwLFOTjYBPQkdqwqBOkVEVjO
        KHH/52x2EIdZ4AGzRMfzTWCDhAVcJL7cns0IYrMIqEqcWrCeCcTmFfCSOHvvGdQyOYmb5zqZ
        QWxOAW+Jz6smMEIs85K4Mm8h6wRGvgWMDKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC43Xb
        sZ9bdjB2vQs+xCjAwajEw6sR+TVaiDWxrLgy9xCjBAezkghvRxRQiDclsbIqtSg/vqg0J7X4
        EKMp0FETmaVEk/OBqSSvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwen
        VAPjBouZHAEqkz/tLvgbpDvHcoWsqYAC4yYZt0t6V3vV5YM1AsJYG39IuCUIHNu9ZBJ39cNt
        TqIMCZ07n964uz1tWq/dreAe3hfrzN57839fbmSwd1qr3RX9D5euzbrBESc/MTInnqFRe9dG
        uVc3Vxum5qfvmn/ahqNMq1joscrkBLXptbMfKO9UYinOSDTUYi4qTgQAR714yO0CAAA=
X-CMS-MailID: 20181121180202eucas1p27d3aa58411abeae03181c38b91fc67de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121180202eucas1p27d3aa58411abeae03181c38b91fc67de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121180202eucas1p27d3aa58411abeae03181c38b91fc67de
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180202eucas1p27d3aa58411abeae03181c38b91fc67de@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The refactoring is needed for the new client in devfreq: suspend.
To avoid code duplication, move it to the new local function
devfreq_set_target.

The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
solve issue with devfreq device's frequency during suspend/resume.
During the discussion on LKML some corner cases and comments appeared
related to the design. This patch address them keeping in mind suggestions
from Chanwoo Choi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 62 ++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index e20e7e4..cf9c643 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -285,6 +285,42 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
 	return 0;
 }
 
+static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
+			      unsigned long *prev_freq, u32 flags)
+{
+	struct devfreq_freqs freqs;
+	unsigned long cur_freq;
+	int err = 0;
+
+	if (devfreq->profile->get_cur_freq)
+		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
+	else
+		cur_freq = devfreq->previous_freq;
+
+	freqs.old = cur_freq;
+	freqs.new = new_freq;
+	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
+
+	err = devfreq->profile->target(devfreq->dev.parent, &new_freq, flags);
+	if (err) {
+		freqs.new = cur_freq;
+		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
+		return err;
+	}
+
+	freqs.new = new_freq;
+	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
+
+	if (devfreq_update_status(devfreq, new_freq))
+		dev_err(&devfreq->dev,
+			"Couldn't update frequency transition information.\n");
+
+	devfreq->previous_freq = new_freq;
+	*prev_freq = cur_freq;
+
+	return err;
+}
+
 /* Load monitoring helper functions for governors use */
 
 /**
@@ -296,7 +332,6 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
  */
 int update_devfreq(struct devfreq *devfreq)
 {
-	struct devfreq_freqs freqs;
 	unsigned long freq, cur_freq, min_freq, max_freq;
 	int err = 0;
 	u32 flags = 0;
@@ -333,31 +368,8 @@ int update_devfreq(struct devfreq *devfreq)
 		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
 	}
 
-	if (devfreq->profile->get_cur_freq)
-		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
-	else
-		cur_freq = devfreq->previous_freq;
-
-	freqs.old = cur_freq;
-	freqs.new = freq;
-	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
+	return devfreq_set_target(devfreq, freq, &cur_freq, flags);
 
-	err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
-	if (err) {
-		freqs.new = cur_freq;
-		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
-		return err;
-	}
-
-	freqs.new = freq;
-	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
-
-	if (devfreq_update_status(devfreq, freq))
-		dev_err(&devfreq->dev,
-			"Couldn't update frequency transition information.\n");
-
-	devfreq->previous_freq = freq;
-	return err;
 }
 EXPORT_SYMBOL(update_devfreq);
 
-- 
2.7.4

