Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B9AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35A7204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IVwy7TG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35A7204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbeGWW37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:29:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35467 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388216AbeGWW36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:29:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id f18-v6so1507577lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yBVsh6ID+PsAyzotZUt/Xk6nH1yT1g8qCa+S1iZw298=;
        b=IVwy7TG7ftfrIEfjwsj/F+Zs7DcjFkdRg1aF2AsiZa4KZsvpJDZSPdOcTxk03eWroy
         pb/wrVUTfAhSh4txJ2bPUixtqVFctE+Zpi3bW8eUsKd871JtGej67yrPqafOVaczI1cu
         PuGW6rDhsb7B6byBwmfOaBXQXR4hRoCJq+3Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yBVsh6ID+PsAyzotZUt/Xk6nH1yT1g8qCa+S1iZw298=;
        b=fxTPdjTE2Xq9NU9mR7cnx6EQ4bareZG6nAV3DiOPYb/6BSbvSIZPMEDvdibSk5rC9l
         /zv6Dw+WhSNiaDvrS5Bm/oHZSqjbeQywi5agVdgEYXEj5nKWJbK4i/m01Q8DINZTAzTl
         3M46HtAsVQ1dDZlu+1tb8c9CEStNdAQW2doismcoc+US4q0HMmRoPZ2gRDxAJlTtVGDG
         GJhXqW+Bj8+OH9j88cvt/9/RPDTjfu74Ya20FaNG7grc5eMPAoCmTCBUDMJ5/WY83TG/
         BMAahLE30CJP48TRkMrxg+I7Gaeua2gpm8INRKPGXVYYtvUykJI07iDTSvuIZWQAzzah
         O5dQ==
X-Gm-Message-State: AOUpUlFsCxNKHpkHi2/5sk23EEEKwtdMyvGf4h0/RJN1B1QdmolOyNO6
        DW6MS+z7kM/lCazen6OFNi9lDQ==
X-Google-Smtp-Source: AAOMgpfalo0LzRLn7LvteCFTVY+3qn6I3fqTjT1wD/o5S+kNzlxo0TTz0hKOggo4XkMjgDgS0wBwow==
X-Received: by 2002:a19:9fc8:: with SMTP id i191-v6mr7992213lfe.79.1532381210944;
        Mon, 23 Jul 2018 14:26:50 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id q4-v6sm1990435ljh.36.2018.07.23.14.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 14:26:50 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com
Cc:     corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        andrew@lunn.ch, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 net-next 2/6] net: ethernet: ti: cpdma: fit rated channels in backward order
Date:   Tue, 24 Jul 2018 00:26:30 +0300
Message-Id: <20180723212634.3219-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723212634.3219-1-ivan.khoronzhuk@linaro.org>
References: <20180723212634.3219-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to TRM tx rated channels should be in 7..0 order,
so correct it.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

