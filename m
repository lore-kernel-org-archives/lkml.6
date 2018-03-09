Return-Path: <georgi.djakov@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520629817; cv=none;
        d=google.com; s=arc-20160816;
        b=muqReyCLGnYaXjvDvqnh4BD9tG06mdkhJ5gq6bC5Utf4aOYHMi2jn0D0MN+rd4CSHf
         FARc9ed724dKfxbUMfn5XYXvZFm/Wpf9kkZ4HsYfctfNw4GrzbmRPJ5M8qbFYUo6hulS
         4rzgzJ7JlF2E0Aca2P0MVAOJt2agp7sD9EK86yLDIUs7N7VpCQz9yJavvYUGf8iGOhHt
         MphRi41ciSHGtreyipP8pjz/UZBNxFI5pQQkjlIA+ObosYE3/7sCgZAKJAIG0uJT7iOL
         fDUp9MlL9MWIBzsRAZr/GlUCzT8Heqce0BGoVc1FgPaGJWUu+X5WsRq40Qpb8gtSEzAU
         KkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=ubl75YrZdeVmEqG+voml2HeBoZ7TZ2oNfWbg7nL2iU8=;
        b=BFfPPoSRehehckG+kQS43TD5Um7yrZkhwNzMRZgqpaBaQ1QAbJNYp2oGrS8HwhOLze
         CHSS/MVjnJFRlazPptYLJZYQquvvXb9EsZvMJ8x9i2AMk83DWtLVfFSTeCDMYxmysvaq
         DVn9olJY79uK4+2NKJPpIUQ48icPyPCVvSL7TVG67Gd1Azir4gLy+zRg5ZbNRPLt/lai
         3+pvr+Ei1n0ED78Z7Xnzj7tTmvForjlVdC8oycOZF1xkeVM3o6qI+Ywle0XT9hwtcJ5b
         R0DAWCY0cgTEQ45Vq24Lxar3nktR3qM8ZDi3VjCS1XyryHqw4TU0K4gDRyPkp8oznn3l
         WZKg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Z6QAARZo;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Z6QAARZo;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELu71rdz87CR/+Z+YMbo5fxrEFGFFEqOm0bvIXIn0Pcj8C0w1SLStVU8TP5hKCn5w93MZj271g==
From: Georgi Djakov <georgi.djakov@linaro.org>
To: linux-pm@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net,
	robh+dt@kernel.org,
	mturquette@baylibre.com,
	khilman@baylibre.com,
	vincent.guittot@linaro.org,
	skannan@codeaurora.org,
	bjorn.andersson@linaro.org,
	amit.kucheria@linaro.org,
	seansw@qti.qualcomm.com,
	davidai@quicinc.com,
	mark.rutland@arm.com,
	lorenzo.pieralisi@arm.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	georgi.djakov@linaro.org
Subject: [PATCH v4 7/7] interconnect: Allow endpoints translation via DT
Date: Fri,  9 Mar 2018 23:09:58 +0200
Message-Id: <20180309210958.16672-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309210958.16672-1-georgi.djakov@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495931519090821?=
X-GMAIL-MSGID: =?utf-8?q?1594495931519090821?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently we support only platform data for specifying the interconnect
endpoints. As now the endpoints are hard-coded into the consumer driver
this may leed to complications when a single driver is used by multiple
SoCs, which may have different interconnect topology.
To avoid cluttering the consumer drivers, introduce a translation function
to help us get the board specific interconnect data from device-tree.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c  | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/interconnect.h |  6 ++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index a06f752a6aaa..014993473763 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/uaccess.h>
 
 static DEFINE_IDR(icc_idr);
@@ -297,6 +298,43 @@ static int constraints_apply(struct icc_path *path)
 	return 0;
 }
 
+struct icc_path *of_icc_get(struct device *dev, const char *name)
+{
+	struct device_node *np;
+	u32 src_id, dst_id;
+	int index, ret;
+
+	if (!dev || !name)
+		return NULL;
+
+	np = dev->of_node;
+
+	index = of_property_match_string(np, "interconnect-names", name);
+	if (index < 0)
+		return ERR_PTR(index);
+
+	/*
+	 * We use a combination of phandle and specifier for endpoint. For now
+	 * lets support only global ids and extend this is the future if needed
+	 * without breaking DT compatibility.
+	 */
+	ret = of_property_read_u32_index(np, "interconnects", index * 2 + 1,
+					 &src_id);
+	if (ret) {
+		dev_err(dev, "interconnect src port is invalid (%d)\n", ret);
+		return ERR_PTR(ret);
+	}
+	ret = of_property_read_u32_index(np, "interconnects", index * 2 + 3,
+					 &dst_id);
+	if (ret) {
+		dev_err(dev, "interconnect dst port is invalid (%d)\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	return icc_get(src_id, dst_id);
+}
+EXPORT_SYMBOL_GPL(of_icc_get);
+
 /**
  * icc_set() - set constraints on an interconnect path between two endpoints
  * @path: reference to the path returned by icc_get()
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 5a7cf72b76a5..996c48ea67d5 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -16,6 +16,7 @@ struct device;
 #if IS_ENABLED(CONFIG_INTERCONNECT)
 
 struct icc_path *icc_get(const int src_id, const int dst_id);
+struct icc_path *of_icc_get(struct device *dev, const char *name);
 void icc_put(struct icc_path *path);
 int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 
@@ -26,6 +27,11 @@ static inline struct icc_path *icc_get(const int src_id, const int dst_id)
 	return NULL;
 }
 
+static inline struct icc_path *of_icc_get(struct device *dev, const char *name)
+{
+	return NULL;
+}
+
 static inline void icc_put(struct icc_path *path)
 {
 }
