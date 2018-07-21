Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6E9ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7C0206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bWsVoDny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7C0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeGUMwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 08:52:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37132 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbeGUMwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 08:52:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id j8-v6so3474548lfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J0gNx+HMMc7tXkTsJONncvK4d9iP3vDtXPedoLleIHE=;
        b=bWsVoDnyCcM+fPbyUSRxA86ssLvb4p+TrvXBvjbLSRf6x+gnRdEADpWM7h4HhBURXv
         cH6nyQ2DLggqslRXB3arPdAf0GNmb0TRYOzscgVbKbT/R46KOvwqyCHXzQ92qzH2xWvn
         RSxfNPxFFr2ia0Au4YgkbvfL8e28JwbIbL0AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J0gNx+HMMc7tXkTsJONncvK4d9iP3vDtXPedoLleIHE=;
        b=dPG/s+ZyKl6gNG4YcagWUJkF57l8MBdi48ualz35uObc+VqwXIso5Yp/suIVQZhqDr
         T8PZGgM1eYjRVFFajJZBcDXU0mrZnKTZaqUzhgs+QMWH7V74EKczMybgY0iAP+ERbxOu
         LXAsIIVm2XS00VqWustmbIMaHKpTK90XnFPWpZp/lGgKdIAxqdLVY+r4hakHOuzZvPac
         3aGLYiyADxwL8Um6nwEIPL6o4+2zcXqK0JcNYsivhsB0aJxzLW2Ww3sMF2rtiqDzno/L
         gGEDjK8cIywBkh+TIKn7JareiY0QUocwR6DzgdizAgDAWsV06QIK8zpW/tHzYP+jarbe
         nv5A==
X-Gm-Message-State: AOUpUlHgN8eAh1wILy6cPnGNwCYExRuu/g1M66C0AJkFWB4Pc7dEFY+r
        ZmNFdWZavaSV4OfGlS6im1W/uw==
X-Google-Smtp-Source: AAOMgpesw5hgFAkptlq0c+qBKS33IMyjRYtMJUoKCvcIbX2gPG36B8GfIF/JDdbzNr/Fhe/4N7Bryg==
X-Received: by 2002:a19:a111:: with SMTP id k17-v6mr3261804lfe.131.1532174375716;
        Sat, 21 Jul 2018 04:59:35 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 73-v6sm664260lfs.44.2018.07.21.04.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 04:59:35 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com
Cc:     corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        andrew@lunn.ch, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 net-next 2/6] net: ethernet: ti: cpdma: fit rated channels in backward order
Date:   Sat, 21 Jul 2018 14:59:19 +0300
Message-Id: <20180721115923.1389-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721115923.1389-1-ivan.khoronzhuk@linaro.org>
References: <20180721115923.1389-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to TRM tx rated channels should be in 7..0 order,
so correct it.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/davinci_cpdma.c | 31 ++++++++++++-------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index 4f1267477aa4..4236dcdd5634 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -406,37 +406,36 @@ static int cpdma_chan_fit_rate(struct cpdma_chan *ch, u32 rate,
 	struct cpdma_chan *chan;
 	u32 old_rate = ch->rate;
 	u32 new_rmask = 0;
-	int rlim = 1;
+	int rlim = 0;
 	int i;
 
-	*prio_mode = 0;
 	for (i = tx_chan_num(0); i < tx_chan_num(CPDMA_MAX_CHANNELS); i++) {
 		chan = ctlr->channels[i];
-		if (!chan) {
-			rlim = 0;
+		if (!chan)
 			continue;
-		}
 
 		if (chan == ch)
 			chan->rate = rate;
 
 		if (chan->rate) {
-			if (rlim) {
-				new_rmask |= chan->mask;
-			} else {
-				ch->rate = old_rate;
-				dev_err(ctlr->dev, "Prev channel of %dch is not rate limited\n",
-					chan->chan_num);
-				return -EINVAL;
-			}
-		} else {
-			*prio_mode = 1;
-			rlim = 0;
+			rlim = 1;
+			new_rmask |= chan->mask;
+			continue;
 		}
+
+		if (rlim)
+			goto err;
 	}
 
 	*rmask = new_rmask;
+	*prio_mode = rlim;
 	return 0;
+
+err:
+	ch->rate = old_rate;
+	dev_err(ctlr->dev, "Upper cpdma ch%d is not rate limited\n",
+		chan->chan_num);
+	return -EINVAL;
 }
 
 static u32 cpdma_chan_set_factors(struct cpdma_ctlr *ctlr,
-- 
2.17.1

