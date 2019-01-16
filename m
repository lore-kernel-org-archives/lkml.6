Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3905C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729022082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eng73Q+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405265AbfAPQLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:11:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40542 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405252AbfAPQL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:11:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so7558455wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgRm2aO2Ij1KQwzH5NiF8dvBkSLnMrQ8RcNVlPauU/8=;
        b=eng73Q+rXVdfvwKcoCIxc2D2TnbLST3DbvtVZT8/wMBHycQWUXcjrQVVYynjYN/eNf
         VonNHpkhw1c7lT6ZkVMUAofI3642MqI0OXWXKd32g4ZlYaDCKlGeEL2s8PpN9ptmiyT0
         xqsUXzokZRLa+SpQMOVnOyL4vTE3MoqtorQrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgRm2aO2Ij1KQwzH5NiF8dvBkSLnMrQ8RcNVlPauU/8=;
        b=Apg+rDlq4xKm23EVs9j9mk5in3mmtXg9KY4LDrE8n1n2sCIeP1xyeLF2GTAgxx5GYg
         uNrxqd76rBfl80wMkJcMxLyIb6/2cDGjbS6mRIemvrcLKleiSWAMPQ9N37N7YmH3wP/E
         EZ6K5t3Nas31dr+XX8lRbjd8McGY0qwNmYmG+X0CjLzZ7qZJUyVDxIe0qNFXOKi6MoQN
         Gk1wy2Ucg+/nujQR7g/IalRLUlEQ5tdVDnH+eh/RSixhK4gb5zLaOnfsRHMYidBbnxzD
         XCVimeGMdNJakynFroPxobnS/pFO9yaV/C2JZD86ot+LvWXk00rR9VEAdsX2DbYQ43iH
         JLIg==
X-Gm-Message-State: AJcUukehfq1qfMLUH0Fv5TiaAF7+K1ohFrNwujMtC8zJcJu67MlN+yJJ
        FhePhTyOvNmluphx8ppQODjUEROmSk8=
X-Google-Smtp-Source: ALg8bN5vTpTdgFrNsBazJWOvWRE+OuJSwyAUdPF+54h9gkihY+LCJgCaEB709+03Af7ay7801ioi0Q==
X-Received: by 2002:adf:b3c3:: with SMTP id x3mr8262877wrd.294.1547655085306;
        Wed, 16 Jan 2019 08:11:25 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a17sm78193407wrs.58.2019.01.16.08.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 08:11:24 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     andy.gross@linaro.org, olof@lixom.net, arnd@arndb.de,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, abailon@baylibre.com,
        maxime.ripard@bootlin.com, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, georgi.djakov@linaro.org
Subject: [PATCH v13 8/8] interconnect: Revert to previous config if any request fails
Date:   Wed, 16 Jan 2019 18:11:03 +0200
Message-Id: <20190116161103.6937-9-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190116161103.6937-1-georgi.djakov@linaro.org>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When consumers report their bandwidth needs with icc_set_bw(), it's
possible that the requested amount of bandwidth is not available or just
the new configuration fails to apply on some path. In this case revert to
the previous configuration and propagate the error back to the consumers
to let them know that bandwidth is not available, hardware is busy or
whatever error is returned by the interconnect platform driver.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 8091d998549a..6005a1c189f6 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -414,14 +414,18 @@ EXPORT_SYMBOL_GPL(of_icc_get);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 {
 	struct icc_node *node;
+	u32 old_avg, old_peak;
 	size_t i;
 	int ret;
 
-	if (!path)
+	if (!path || !path->num_nodes)
 		return 0;
 
 	mutex_lock(&icc_lock);
 
+	old_avg = path->reqs[0].avg_bw;
+	old_peak = path->reqs[0].peak_bw;
+
 	for (i = 0; i < path->num_nodes; i++) {
 		node = path->reqs[i].node;
 
@@ -434,10 +438,19 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	}
 
 	ret = apply_constraints(path);
-	if (ret)
+	if (ret) {
 		pr_debug("interconnect: error applying constraints (%d)\n",
 			 ret);
 
+		for (i = 0; i < path->num_nodes; i++) {
+			node = path->reqs[i].node;
+			path->reqs[i].avg_bw = old_avg;
+			path->reqs[i].peak_bw = old_peak;
+			aggregate_requests(node);
+		}
+		apply_constraints(path);
+	}
+
 	mutex_unlock(&icc_lock);
 
 	return ret;
