Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DF7C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C988720851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f1h6Yd0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C988720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeLCOcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:32:47 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60069 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbeLCOcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:32:46 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181203143131euoutp01a79fc2fb7c5e95d4efa55214574f2236~s2R02UGEZ1512915129euoutp012
        for <linux-kernel@vger.kernel.org>; Mon,  3 Dec 2018 14:31:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181203143131euoutp01a79fc2fb7c5e95d4efa55214574f2236~s2R02UGEZ1512915129euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543847491;
        bh=hQaTflaPAMrXhPUYetvubirH4OuUf8G7UubV1XcVpX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1h6Yd0d/aw/GaSDBOASRGsMOGXAeTKGW3Fn8s+jvDpO/b8LeFwJFlfCyDI4sfb7+
         UizncwVpS1BmHnomTF4SB25mJ2Vb/sReTmxbiLA6ayuNMwOUPCpXKcl/nhEYDSAIv9
         Hzthb5t4MmfTAzLOTN0dBb7UkmHZT3fMb6zyV3ag=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181203143130eucas1p24a0d75463ca5060e53476c03cba2b462~s2Rzq4End0423304233eucas1p2V;
        Mon,  3 Dec 2018 14:31:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EA.CA.04441.24E350C5; Mon,  3
        Dec 2018 14:31:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5~s2Ry5wXfg0265802658eucas1p2w;
        Mon,  3 Dec 2018 14:31:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181203143129eusmtrp1740db19da50ae1b486db1b6a94838b53~s2Ryp7pK91650116501eusmtrp1k;
        Mon,  3 Dec 2018 14:31:29 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-a7-5c053e429b2c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 21.F8.04128.14E350C5; Mon,  3
        Dec 2018 14:31:29 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181203143128eusmtip2050810cd61bd1a904e1e5193d81b6d33~s2Rxtc6xo0581705817eusmtip26;
        Mon,  3 Dec 2018 14:31:28 +0000 (GMT)
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
Subject: [PATCH v2 1/5] devfreq: refactor set_target frequency function
Date:   Mon,  3 Dec 2018 15:31:11 +0100
Message-Id: <1543847475-7600-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUzMcRzH+/6ei8vP1fJZyJzZqqm02Xw3tJjND5v5hz9i4/BbNd3J/XqQ
        hzkhlZTnDCdW5jpHyjnXk3SdQnq4lNKDaW1MCj2hebzrd+a/1/f9eX/en8/3uy9HKr/TgVy8
        NknUadUJKsaHstZPNoetiqK3Lv447ItrH4Tg0kslNH5Y+pXGnePvaVzgaKbx0cISBr84qcF5
        Ax9J3NJyj8VN6UMs7tbPwZfPVxO4bOAVjV9WXGXw2CkHwpdaHhH4jqOPxTc7nQTuOWJkcN/z
        J66MxjYaH692sDjj9hcaD7W+oaJBsFZaacF8zYyEK3onJZzOG0VCYdUHQigzZTFCjcHMCveL
        Dgu/61mh9lMVIVg6TlBCrsWEBOPtb6wwVha00TfGZ/kuMSE+RdRFRG33iRvM6iUSi2DfyMlC
        Qo+K/bORNwf8EjD2n2KzkQ+n5I0ILo5XEvJhHEGP8xktH8YQGM6NUv9a+ksveFy3EHS33vjf
        MnqvwxXGcQwfDjbTXneDP1+IoM0W4vaQ/FMSKkbOEu6CH78G7tQ0kG6m+IXQ//j5FCv4tTA4
        WUvK04LgdXPWFHvz6+C8sYB0BwFfzEGl+TOSTavh67ERz3p+MNhgYWWeA43ncjy6BE2ZJkbm
        g3Dimc3jWQZ1DU7avTTJh0BJRYQsr4T88vSpuwDvC13DM90y6cKz1nxSlhWQmaGU3cFgyWkl
        ZA6AW+aLnnABOibKGfl5DAjac03UaTTv8v9h1xEyoVlisqSJFaVIrZgaLqk1UrI2NnznHk0Z
        cv3Hxt8NozY00bbDjngOqaYrordRW5W0OkVK09gRcKTKX5G41yUpdqnT9ou6Pdt0yQmiZEez
        OUo1S3HA6+0WJR+rThJ3i2KiqPtXJTjvQD262/0h8FBSf1DOwQe9v7RR5WJuzuDTsIG6uI3v
        1yOvDSkPO+3NC6ICNmUXLOq6OjG3fajiwJaM48Ez0p0/YjIimyYzu1TDienzg+rjX65Yvjk/
        22bXN85NsDoUhrEf0Uzwn2Kbwas9YtrR0EOicnWeefbPM0vfWaKtqU3Dfu0arxhWRUlx6shQ
        Uiep/wKJSXTOiwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xe7qOdqwxBs0vhCwObtW02DhjPavF
        9o3fWC2uf3nOajH/yDlWi+bF69ksznTnWvQ/fs1scf78BnaLs01v2C1uNchYzJqyl8li0+Nr
        rBaXd81hs/jce4TRYsb5fUwWa4/cZbdYev0ik8XtxhVsFndPHQWacfoSq0Xr3iPsFm2rP7Ba
        vLlwj8VBwmPb7m2sHmvmrWH0mN1wkcVjQv8nRo/Fe14yeWxa1cnmsX/uGnaPzUvqPf4dY/c4
        +G4Pk8eWq+0sHn1bVjF6rFj9nd3j8ya5AL4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9
        Q2PzWCsjUyV9O5uU1JzMstQifbsEvYxXnXeYCpZIVHzsXszUwLhSpIuRk0NCwETi4capTF2M
        XBxCAksZJSb9+8cKkRCTmLRvOzuELSzx51oXG0TRJ0aJrc+bGbsYOTjYBPQkdqwqBImLCCxn
        lLj/czY7iMMs8IBZouP5JrBJwgLuEmv3H2cGsVkEVCUeHjgFZvMKeEq8+nmQGWKDnMTNc51g
        NqeAl8SUFfPBbCGgmpa9K5gnMPItYGRYxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERix2479
        3LKDsetd8CFGAQ5GJR5eh3iWGCHWxLLiytxDjBIczEoivAWFQCHelMTKqtSi/Pii0pzU4kOM
        pkBHTWSWEk3OByaTvJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZqakFqUUwfUwcnFIN
        jDw/dHoMjqjse3PpJtO88iVr4uW3KQvt8Os4fs3pq54TX+jyl/unOp1RWlD1/Nc3mU37GKNf
        SL9+t/ZB4t0nz/6uvxQ6l7Xg83bJqmOcgsuPx17vXpnbabV3mqr1uZlNTEsWuF/Ysu5R7tZD
        O387CbVyqG8xC9+hp+OSrGZQt59J+M23qKr9c2uUWIozEg21mIuKEwGk5vXm7gIAAA==
X-CMS-MailID: 20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The refactoring is needed for the new client in devfreq: suspend.
To avoid code duplication, move it to the new local function
devfreq_set_target.

The patch is based on earlier work by Tobias Jakobi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 62 +++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1414130..a9fd61b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -285,6 +285,40 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
 	return 0;
 }
 
+static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
+			      u32 flags)
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
+	return err;
+}
+
 /* Load monitoring helper functions for governors use */
 
 /**
@@ -296,8 +330,7 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
  */
 int update_devfreq(struct devfreq *devfreq)
 {
-	struct devfreq_freqs freqs;
-	unsigned long freq, cur_freq, min_freq, max_freq;
+	unsigned long freq, min_freq, max_freq;
 	int err = 0;
 	u32 flags = 0;
 
@@ -333,31 +366,8 @@ int update_devfreq(struct devfreq *devfreq)
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
+	return devfreq_set_target(devfreq, freq, flags);
 
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

