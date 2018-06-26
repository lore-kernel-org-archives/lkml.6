Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF72C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD73263F0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfEHc8ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD73263F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935330AbeFZBeV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:34:21 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45117 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935292AbeFZBeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:34:18 -0400
Received: by mail-io0-f196.google.com with SMTP id l25-v6so14348604ioh.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zI5lUKlAzQRSNWtdWKX5W3a7202aqO9Sdf68xxZgub0=;
        b=hfEHc8efQuVe/ftrktwFiIaaIqmLCzoz8a9rNWgyNtPu54bQNAC9uAxQcbz9Fo2geS
         ilTEJW0rJWRnkOBwzclVRCdG4fOVVcGbPLWd5Q6WWU5N9TnsjxcaAqTCZTNKrRrPAAFL
         7gKRg6J2798Y+GI3KQsAV+QuQI0dJJtmr653c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zI5lUKlAzQRSNWtdWKX5W3a7202aqO9Sdf68xxZgub0=;
        b=HEtLKKZ1IV6cikvzE64B37tgZrGHXRScHKHSkjw8S1+Zd+63zw0qpMKaNmLa/7SD4T
         mvylU+9hk5J16om/YJhYh2veGXCSNTXgmuGyMx3GBMkJVzDKeb5LNz99CQCKtrhnyW9m
         8+HDbDkayQ2spVfiV1T+cDjpNsx3QushWS1meyXQLjB83O7ApU8nRa5RHUfBSDQVTb9x
         oBBuMkw96KwX3G+zoaFifZJyh85BtH9AcQLHsOsAoY9wXQ911SFpzEsj9HWmqXZsNQWp
         LzQBU1nZF50herw938YKkP/hVbUwClpgNn3GlPzTbONFhzdFWk0W6JJdAZnMrUnmabCa
         ZdtA==
X-Gm-Message-State: APt69E0CyqGo5TO8HmmgtujWrBq3lQoAWJJn1LPOU7i5Br3yhp7HMfoP
        Z5zY0JonqZmr+q/6fuQTcw4jDgovBf0=
X-Google-Smtp-Source: ADUXVKLEtpWshX8xUTz4Q4HXZmzfKYG1rZUJogEKD79uuwQz5gGUO22cb3Jckta1eBmhdJpO91PWzg==
X-Received: by 2002:a6b:1844:: with SMTP id 65-v6mr11901946ioy.16.1529976857085;
        Mon, 25 Jun 2018 18:34:17 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id h62-v6sm184699ioa.22.2018.06.25.18.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 18:34:16 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH resend 5/5] remoteproc: Introduce prepare and unprepare for subdevices
Date:   Mon, 25 Jun 2018 20:34:09 -0500
Message-Id: <20180626013409.5125-6-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626013409.5125-1-elder@linaro.org>
References: <20180626013409.5125-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

On rare occasions a subdevice might need to prepare some hardware
resources before a remote processor is booted, and clean up some
state after it has been shut down.

One such example is the IP Accelerator found in various Qualcomm
platforms, which is accessed directly from both the modem remoteproc
and the application subsystem and requires an intricate lockstep
process when bringing the modem up and down.

[elder@linaro.org: minor description and comment edits]

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Alex Elder <elder@linaro.org>
Tested-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 56 ++++++++++++++++++++++++++--
 include/linux/remoteproc.h           |  4 ++
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 2ede7ae6f5bc..283b258f5e0f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -776,6 +776,30 @@ static int rproc_handle_resources(struct rproc *rproc,
 	return ret;
 }
 
+static int rproc_prepare_subdevices(struct rproc *rproc)
+{
+	struct rproc_subdev *subdev;
+	int ret;
+
+	list_for_each_entry(subdev, &rproc->subdevs, node) {
+		if (subdev->prepare) {
+			ret = subdev->prepare(subdev);
+			if (ret)
+				goto unroll_preparation;
+		}
+	}
+
+	return 0;
+
+unroll_preparation:
+	list_for_each_entry_continue_reverse(subdev, &rproc->subdevs, node) {
+		if (subdev->unprepare)
+			subdev->unprepare(subdev);
+	}
+
+	return ret;
+}
+
 static int rproc_start_subdevices(struct rproc *rproc)
 {
 	struct rproc_subdev *subdev;
@@ -810,6 +834,16 @@ static void rproc_stop_subdevices(struct rproc *rproc, bool crashed)
 	}
 }
 
+static void rproc_unprepare_subdevices(struct rproc *rproc)
+{
+	struct rproc_subdev *subdev;
+
+	list_for_each_entry_reverse(subdev, &rproc->subdevs, node) {
+		if (subdev->unprepare)
+			subdev->unprepare(subdev);
+	}
+}
+
 /**
  * rproc_coredump_cleanup() - clean up dump_segments list
  * @rproc: the remote processor handle
@@ -902,11 +936,18 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 		rproc->table_ptr = loaded_table;
 	}
 
+	ret = rproc_prepare_subdevices(rproc);
+	if (ret) {
+		dev_err(dev, "failed to prepare subdevices for %s: %d\n",
+			rproc->name, ret);
+		return ret;
+	}
+
 	/* power up the remote processor */
 	ret = rproc->ops->start(rproc);
 	if (ret) {
 		dev_err(dev, "can't start rproc %s: %d\n", rproc->name, ret);
-		return ret;
+		goto unprepare_subdevices;
 	}
 
 	/* Start any subdevices for the remote processor */
@@ -914,8 +955,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	if (ret) {
 		dev_err(dev, "failed to probe subdevices for %s: %d\n",
 			rproc->name, ret);
-		rproc->ops->stop(rproc);
-		return ret;
+		goto stop_rproc;
 	}
 
 	rproc->state = RPROC_RUNNING;
@@ -923,6 +963,14 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	dev_info(dev, "remote processor %s is now up\n", rproc->name);
 
 	return 0;
+
+stop_rproc:
+	rproc->ops->stop(rproc);
+
+unprepare_subdevices:
+	rproc_unprepare_subdevices(rproc);
+
+	return ret;
 }
 
 /*
@@ -1035,6 +1083,8 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 		return ret;
 	}
 
+	rproc_unprepare_subdevices(rproc);
+
 	rproc->state = RPROC_OFFLINE;
 
 	dev_info(dev, "stopped remote processor %s\n", rproc->name);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 8f1426330cca..e3c5d856b6da 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -477,15 +477,19 @@ struct rproc {
 /**
  * struct rproc_subdev - subdevice tied to a remoteproc
  * @node: list node related to the rproc subdevs list
+ * @prepare: prepare function, called before the rproc is started
  * @start: start function, called after the rproc has been started
  * @stop: stop function, called before the rproc is stopped; the @crashed
  *	    parameter indicates if this originates from a recovery
+ * @unprepare: unprepare function, called after the rproc has been stopped
  */
 struct rproc_subdev {
 	struct list_head node;
 
+	int (*prepare)(struct rproc_subdev *subdev);
 	int (*start)(struct rproc_subdev *subdev);
 	void (*stop)(struct rproc_subdev *subdev, bool crashed);
+	void (*unprepare)(struct rproc_subdev *subdev);
 };
 
 /* we currently support only two vrings per rvdev */
-- 
2.17.1

