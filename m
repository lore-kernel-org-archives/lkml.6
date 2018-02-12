Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AH8x224d2/4up3Wz7vyIWf+DBgMLCROyqjzbsL26iyZOuRMOjOQErico3Gg1+U2UrXCJ5yvLwD4n
ARC-Seal: i=1; a=rsa-sha256; t=1518461162; cv=none;
        d=google.com; s=arc-20160816;
        b=CwlCa4S0rqm9UHdzTd/7hRXykhChKNs0UIFFCtobzbpmEuBn6ST7AE9OWfAat4R1Aq
         Wzc1ITQcZvCWA5nWp6V4WQYi/hbw5EYo+fhvFxWJf9vLe+o6etUw62nQ/5x1Qm4tSWpY
         TOYFTmbHMeP2N97bQ9gFSwMRIYiEDKDJQu7EWG8AstJq9OwFklqU0EfoKxu/KaLUlhmS
         aJuy+8d9mK7IKIPcFEDLm0Ah9E6rO2r8oyAFfsijfriGUdMjsUMrWhBqimtP8/R99h2A
         MMP+76/1MRuVYecHzHUrBqX0VjQxEs1evtHLvMO3pej2IvY6Jj6DzZZr2MHBHE1y8PsT
         sJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=64ao8uaeps0Foww8D2F7WQA+koPgQMgSMf8VLK7cqdI=;
        b=Tb6XzrmM8/5o8D6oczn96l+EZpVre1LQK1biQmYmd4vZcKkCGZmulaIq5zAL8KNqLu
         x0oGhoZq5HN9sBWZ5iAEsjw3j/xj52VtAOAXzx1Vgl0GHiSuV06WOs0WpaRtspQMz7b1
         mo3/8q7w2Oj1PrJp2OP4PTkiuR3RG97O06qcx8Zm8qsxUp9SpqOd3I0RUCYXPFLqna9P
         gFp8JN3ZzhhMgJvvv8yx1HAw5qdfmybXGGI4rCZ/OWOGxabCufVCf2620o2OB6wbqKoY
         SOFd9+DdSCexwebXuJX22wzFcX+vW7/89UBcJWcMFxvLcNcqU2b2ntAeJixsMURQilgV
         +5sg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH v5 12/20] firmware: arm_scmi: add option for polling based performance domain operations
Date: Mon, 12 Feb 2018 18:45:16 +0000
Message-Id: <1518461124-17371-13-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592221931529149832?=
X-GMAIL-MSGID: =?utf-8?q?1592221931529149832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to implement fast CPU DVFS switching, we need to perform all
DVFS operations atomically. Since SCMI transfer already provide option
to choose between pooling vs interrupt driven(default), we can opt for
polling based transfers for set,get performance domain operations.

This patch adds option to choose between polling vs interrupt driven
SCMI transfers for set,get performance level operations.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 19 +++++++++++--------
 include/linux/scmi_protocol.h    |  8 ++++----
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index a14093386b57..6c9126dd6ec7 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -303,8 +303,8 @@ static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
 	return ret;
 }
 
-static int
-scmi_perf_level_set(const struct scmi_handle *handle, u32 domain, u32 level)
+static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
+			       u32 level, bool poll)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -315,6 +315,7 @@ scmi_perf_level_set(const struct scmi_handle *handle, u32 domain, u32 level)
 	if (ret)
 		return ret;
 
+	t->hdr.poll_completion = poll;
 	lvl = t->tx.buf;
 	lvl->domain = cpu_to_le32(domain);
 	lvl->level = cpu_to_le32(level);
@@ -325,8 +326,8 @@ scmi_perf_level_set(const struct scmi_handle *handle, u32 domain, u32 level)
 	return ret;
 }
 
-static int
-scmi_perf_level_get(const struct scmi_handle *handle, u32 domain, u32 *level)
+static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
+			       u32 *level, bool poll)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -336,6 +337,7 @@ scmi_perf_level_get(const struct scmi_handle *handle, u32 domain, u32 *level)
 	if (ret)
 		return ret;
 
+	t->hdr.poll_completion = poll;
 	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
 
 	ret = scmi_do_xfer(handle, t);
@@ -411,23 +413,24 @@ static int scmi_dvfs_get_transition_latency(const struct scmi_handle *handle,
 }
 
 static int scmi_dvfs_freq_set(const struct scmi_handle *handle, u32 domain,
-			      unsigned long freq)
+			      unsigned long freq, bool poll)
 {
 	struct scmi_perf_info *pi = handle->perf_priv;
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
-	return scmi_perf_level_set(handle, domain, freq / dom->mult_factor);
+	return scmi_perf_level_set(handle, domain, freq / dom->mult_factor,
+				   poll);
 }
 
 static int scmi_dvfs_freq_get(const struct scmi_handle *handle, u32 domain,
-			      unsigned long *freq)
+			      unsigned long *freq, bool poll)
 {
 	int ret;
 	u32 level;
 	struct scmi_perf_info *pi = handle->perf_priv;
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
-	ret = scmi_perf_level_get(handle, domain, &level);
+	ret = scmi_perf_level_get(handle, domain, &level, poll);
 	if (!ret)
 		*freq = level * dom->mult_factor;
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 6785dd9f61e3..06e8ef1d8aea 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -103,14 +103,14 @@ struct scmi_clk_ops {
 struct scmi_perf_ops {
 	int (*limits_set)(const struct scmi_handle *, u32, u32, u32);
 	int (*limits_get)(const struct scmi_handle *, u32, u32 *, u32 *);
-	int (*level_set)(const struct scmi_handle *, u32, u32);
-	int (*level_get)(const struct scmi_handle *, u32, u32 *);
+	int (*level_set)(const struct scmi_handle *, u32, u32, bool);
+	int (*level_get)(const struct scmi_handle *, u32, u32 *, bool);
 	int (*device_domain_id)(struct device *);
 	int (*get_transition_latency)(const struct scmi_handle *,
 				      struct device *);
 	int (*add_opps_to_device)(const struct scmi_handle *, struct device *);
-	int (*freq_set)(const struct scmi_handle *, u32, unsigned long);
-	int (*freq_get)(const struct scmi_handle *, u32, unsigned long *);
+	int (*freq_set)(const struct scmi_handle *, u32, unsigned long, bool);
+	int (*freq_get)(const struct scmi_handle *, u32, unsigned long *, bool);
 };
 
 /**
-- 
2.7.4
