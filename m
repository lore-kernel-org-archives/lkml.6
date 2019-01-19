Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209C9C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E221C2177E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9/yUcOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfASBo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:44:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43282 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730331AbfASBoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:44:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so7423054pfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 17:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GNlj8CHga4sec3MzFSUyZCmaJEDR0dqJiCOQWV34Lwg=;
        b=d9/yUcOSin4bxjn8Whp6+X9Zkebs+EERMQApdnrwEnD3ayPT2ciqwRCFFbkl52HzId
         Cpe22qP9YpExSI5/YvvYs7839fowLLC4gAimKXuV47/3XafCv5644fFnj7LVnTQKcIqH
         6f7ttgHT7tX6aL+ZLrKZg9+KVZUx2qI3yL2Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GNlj8CHga4sec3MzFSUyZCmaJEDR0dqJiCOQWV34Lwg=;
        b=t0x3JdDR9FceAQ0YPWpmHoo/gXsCb3cVNdV8RqdrcQHeDKbwWpDwrd4cfBf7qbV2SC
         jefhswwXaqWwHnmP5PNWieNxSnSW61ZHMvrVd1OjIwn3uSaCKmAJtmwLfG3+cFm9t87l
         9xr8oGBkuBdFq1wMo538GJp4HiZrK/M0gUMr4IWVUXfWBnb2buD8X/Im7kzMqV8OzmYQ
         4KNuRYXdyYw6l/q5zFxCRyXtNDNQzxhVQ8VXCUV+qlgAZFVllpwXKhZDCP6oKcznn56I
         r6PQXLxPNCvVJGuQIkhnCLB9Zzz4G8k8oN06y0tNuzEXf/NQDaupteWIJPmjGBg+1Po3
         lTtg==
X-Gm-Message-State: AJcUukeFxOmJkLa6b3Y+61MdXlmPjQ2YXbPZqVyUGxe7rWhkQTdbd1Xi
        K0d09rRmIu+acendIPqmL/8yJQ==
X-Google-Smtp-Source: ALg8bN4G/6s3DxkweK7xn6V7l6PUkRhq5CLTzSJziX4DhUwAQDmjnGpW2CYgXJ/F6uLVJU5pYiX4Vw==
X-Received: by 2002:a62:425b:: with SMTP id p88mr21930903pfa.137.1547862263994;
        Fri, 18 Jan 2019 17:44:23 -0800 (PST)
Received: from localhost.localdomain (li421-24.members.linode.com. [50.116.3.24])
        by smtp.gmail.com with ESMTPSA id d21sm8648436pfo.162.2019.01.18.17.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 17:44:23 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 5/8] perf cs-etm: Change tuple from traceID-CPU# to traceID-metadata
Date:   Sat, 19 Jan 2019 09:43:44 +0800
Message-Id: <20190119014347.27441-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119014347.27441-1-leo.yan@linaro.org>
References: <20190119014347.27441-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If packet processing wants to know the packet is bound with which ETM
version, it needs to access metadata to decide that based on metadata
magic number; but we cannot simply to use CPU logic ID number as index
to access metadata sequential array, especially when system have
hotplugged off CPUs, the metadata array are only allocated for online
CPUs but not offline CPUs, so the CPU logic number doesn't match with
its index in the array.

For this reason, a reliable way for accessing metadata array is to use
traceID to find associated metadata; by accessing metadata content we
can know not only the CPU number but also for ETM version, which can be
used for sequential change for setting sample flags for exception
packets.

This patch is to change tuple from traceID-CPU# to traceID-metadata,
thus it can use the tuple to retrieve metadata pointer according to
traceID.

For safe accessing metadata fields, this patch provides helper function
cs_etm__get_cpu() which is used to return CPU number according to
traceID; cs_etm_decoder__buffer_packet() is the first consumer for this
helper function.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  8 ++--
 tools/perf/util/cs-etm.c                      | 37 ++++++++++++++++---
 tools/perf/util/cs-etm.h                      |  4 +-
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 294efa76c9e3..cdd38ffd10d2 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -305,14 +305,12 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 			      enum cs_etm_sample_type sample_type)
 {
 	u32 et = 0;
-	struct int_node *inode = NULL;
+	int cpu;
 
 	if (decoder->packet_count >= MAX_BUFFER - 1)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
-	/* Search the RB tree for the cpu associated with this traceID */
-	inode = intlist__find(traceid_list, trace_chan_id);
-	if (!inode)
+	if (cs_etm__get_cpu(trace_chan_id, &cpu) < 0)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
 	et = decoder->tail;
@@ -322,7 +320,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 
 	decoder->packet_buffer[et].sample_type = sample_type;
 	decoder->packet_buffer[et].isa = CS_ETM_ISA_UNKNOWN;
-	decoder->packet_buffer[et].cpu = *((int *)inode->priv);
+	decoder->packet_buffer[et].cpu = cpu;
 	decoder->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
 	decoder->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
 	decoder->packet_buffer[et].instr_count = 0;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1aa29633ce77..e89989fe0a5c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -97,6 +97,20 @@ static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
 	return CS_ETM_PROTO_ETMV3;
 }
 
+int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
+{
+	struct int_node *inode;
+	u64 *metadata;
+
+	inode = intlist__find(traceid_list, trace_chan_id);
+	if (!inode)
+		return -EINVAL;
+
+	metadata = inode->priv;
+	*cpu = (int)metadata[CS_ETM_CPU];
+	return 0;
+}
+
 static void cs_etm__packet_dump(const char *pkt_string)
 {
 	const char *color = PERF_COLOR_BLUE;
@@ -252,7 +266,7 @@ static void cs_etm__free(struct perf_session *session)
 	cs_etm__free_events(session);
 	session->auxtrace = NULL;
 
-	/* First remove all traceID/CPU# nodes for the RB tree */
+	/* First remove all traceID/metadata nodes for the RB tree */
 	intlist__for_each_entry_safe(inode, tmp, traceid_list)
 		intlist__remove(traceid_list, inode);
 	/* Then the RB tree itself */
@@ -1519,9 +1533,20 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 				    0xffffffff);
 
 	/*
-	 * Create an RB tree for traceID-CPU# tuple. Since the conversion has
-	 * to be made for each packet that gets decoded, optimizing access in
-	 * anything other than a sequential array is worth doing.
+	 * Create an RB tree for traceID-metadata tuple.
+	 *
+	 * The conversion between traceID and CPU logic ID number has to
+	 * be made for each packet that gets decoded: firstly retrieve
+	 * metadata pointer from trace ID by using traceID-metadata tuple,
+	 * then read CPU logic ID number in metadata.
+	 *
+	 * It's not safe to directly use CPU logic ID number as index to
+	 * access metadata sequential array, e.g. when system have
+	 * hotplugged out CPUs, the metadata array are only allocated for
+	 * online CPUs but not offline CPUs, thus the CPU logic number is
+	 * not consistent with its index in the arrary.  For this reason,
+	 * we need to fallback to use TraceID-metadata tuple as a reliable
+	 * method to access metadata.
 	 */
 	traceid_list = intlist__new(NULL);
 	if (!traceid_list) {
@@ -1587,8 +1612,8 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 			err = -EINVAL;
 			goto err_free_metadata;
 		}
-		/* All good, associate the traceID with the CPU# */
-		inode->priv = &metadata[j][CS_ETM_CPU];
+		/* All good, associate the traceID with the metadata pointer */
+		inode->priv = metadata[j];
 	}
 
 	/*
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 37f8d48179ca..5d70d10f3907 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -53,7 +53,7 @@ enum {
 	CS_ETMV4_PRIV_MAX,
 };
 
-/* RB tree for quick conversion between traceID and CPUs */
+/* RB tree for quick conversion between traceID and metadata pointers */
 struct intlist *traceid_list;
 
 #define KiB(x) ((x) * 1024)
@@ -78,4 +78,6 @@ cs_etm__process_auxtrace_info(union perf_event *event __maybe_unused,
 }
 #endif
 
+int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
+
 #endif
-- 
2.17.1

