Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E920FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF26F20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f73yPWZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391313AbfAOXHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:07:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42999 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391292AbfAOXHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:07:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so2023263pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 15:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yP2FasSJHEKUvmhM1NueUcXAVpTqjNNg1l20bnmEqxo=;
        b=f73yPWZGnexRNZGn6npQodSzy1FwWsuGGI8atkevYafdxTj9Bgi4zFdrGmQ9dxEQk1
         AjFqAi50+sW9npyd2KpsXn/7W1Z+IqbOoib12qDYV8QkulSU9i3YJ4kZ0sAK46GlJ59r
         FSe5TOBJyCwUmmxcqca3cyPUZxjllYob/RUpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yP2FasSJHEKUvmhM1NueUcXAVpTqjNNg1l20bnmEqxo=;
        b=J36Pv9lbgyvm5gV4PQ1CIkgVmsm6pK1e1RqUxLhoAEHrlpTg4NZI2X6HYcmkXkQZTV
         PoDNb84asGycDQcr4aiIoip70A+ejl9DxdbgtidDAqdn7T4Rchyd7PETF8Dj+BRU0iCK
         8/ccXR/tZI0O4MccQrm5XeDTDoxXUiWrg12FhwV+TthzA1g64UwiOuc7GJ0JYjucY1Uv
         YBLONMHMyj+SIbJ7sX1aTxAbNJe+HoBPThQy+oNSyLMFCFricavyFhrNPL/YzKQC05Ip
         ZOAzmLE6boSRdNsamOuGzM7OgYcTjTptJZ5XlaoDco86dacYC+WLhZ1gRdMeW5uc3th8
         Whmg==
X-Gm-Message-State: AJcUukfEIfTyBjr2AA53tv3Qnc7QS0gH26u1fcME/7OW1D7OVWjAp+Ws
        0ZxfpnGpfGXUFBevKZ7ozeGA+Q==
X-Google-Smtp-Source: ALg8bN7j3gB8hbQAeB9GZ/VnFp3JiYHJ5uAHxY+4709KtpQtbdU7shOV3SgBgQbCLc55/XW4tVkLKw==
X-Received: by 2002:a63:413:: with SMTP id 19mr5881392pge.7.1547593671526;
        Tue, 15 Jan 2019 15:07:51 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h19sm4985928pfn.114.2019.01.15.15.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 15:07:50 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        suzuki.poulose@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/7] coresight: Use event attributes for sink selection
Date:   Tue, 15 Jan 2019 16:07:38 -0700
Message-Id: <20190115230742.13730-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115230742.13730-1-mathieu.poirier@linaro.org>
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses the information conveyed by perf_event::attr::config2
to select a sink to use for the session.  That way a sink can easily be
selected to be used by more than one source, something that isn't currently
possible with the sysfs implementation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 16 ++------
 drivers/hwtracing/coresight/coresight-priv.h  |  1 +
 drivers/hwtracing/coresight/coresight.c       | 39 +++++++++++++++++++
 3 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 292bd409a68c..685d16001d0b 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -201,18 +201,10 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		return NULL;
 	INIT_WORK(&event_data->work, free_event_data);
 
-	/*
-	 * In theory nothing prevent tracers in a trace session from being
-	 * associated with different sinks, nor having a sink per tracer.  But
-	 * until we have HW with this kind of topology we need to assume tracers
-	 * in a trace session are using the same sink.  Therefore go through
-	 * the coresight bus and pick the first enabled sink.
-	 *
-	 * When operated from sysFS users are responsible to enable the sink
-	 * while from perf, the perf tools will do it based on the choice made
-	 * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
-	 */
-	sink = coresight_get_enabled_sink(true);
+	/* First get the selected sink from user space. */
+	sink = coresight_get_sink_by_id(event->attr.config2);
+	if (!sink)
+		sink = coresight_get_enabled_sink(true);
 	if (!sink || !sink_ops(sink)->alloc_buffer)
 		goto err;
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 579f34943bf1..071bb98d358f 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -147,6 +147,7 @@ void coresight_disable_path(struct list_head *path);
 int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
 struct coresight_device *coresight_get_sink(struct list_head *path);
 struct coresight_device *coresight_get_enabled_sink(bool reset);
+struct coresight_device *coresight_get_sink_by_id(u64 id);
 struct list_head *coresight_build_path(struct coresight_device *csdev,
 				       struct coresight_device *sink);
 void coresight_release_path(struct list_head *path);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 526f122a38ee..7e2ce0beb2a0 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/stringhash.h>
 #include <linux/mutex.h>
 #include <linux/clk.h>
 #include <linux/coresight.h>
@@ -541,6 +542,44 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
 	return dev ? to_coresight_device(dev) : NULL;
 }
 
+static int coresight_sink_by_id(struct device *dev, void *data)
+{
+	struct coresight_device *csdev = to_coresight_device(dev);
+	unsigned long hash;
+
+	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
+		/*
+		 * See function etm_perf_sink_name_show() to know where this
+		 * comes from.
+		 */
+		hash = hashlen_hash(hashlen_string(NULL, dev_name(dev)));
+
+		if (hash == (*(unsigned long *)data))
+			return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * coresight_get_sink_by_id - returns the sink that matches the id
+ * @id: Id of the sink to match
+ *
+ * The name of a sink is unique, whether it is found on the AMBA bus or
+ * otherwise.  As such the hash of that name can easily be used to identify
+ * a sink.
+ */
+struct coresight_device *coresight_get_sink_by_id(u64 id)
+{
+	struct device *dev = NULL;
+
+	dev = bus_find_device(&coresight_bustype, NULL, &id,
+			      coresight_sink_by_id);
+
+	return dev ? to_coresight_device(dev) : NULL;
+}
+
 /*
  * coresight_grab_device - Power up this device and any of the helper
  * devices connected to it for trace operation. Since the helper devices
-- 
2.17.1

