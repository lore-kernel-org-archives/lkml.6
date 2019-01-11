Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB6FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF152133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="X0U57Tao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfAKATw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:19:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48798 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730820AbfAKATr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:19:47 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x0B0Hocr022390
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:19:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=27wiaeGV76L5sFQtxla39EcIT2hw+kgYbekhwmla2Ms=;
 b=X0U57Tao7Leiyc+w3vMn8x60XyRKQDkL83US9zF+k1Ynd8N+k7iZ3BzPxlM/6ryb5nVX
 f2cd9OLm+INU52aMe4/b4HMkBGh2PIF+pV1eWB417X5ppITLGGFRHlyTIZHz2Py54a02
 TUlevZTTcTcQ3EeyTFHAVMN/wcJ+gJj1JK0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2pxb7sh1pg-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:19:46 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 10 Jan 2019 16:19:41 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 21A0262E20C4; Thu, 10 Jan 2019 16:19:38 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <dsahern@gmail.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v7 perf, bpf-next 5/8] perf, bpf: emit PERF_RECORD_KSYMBOL for BPF program load/unload
Date:   Thu, 10 Jan 2019 16:19:30 -0800
Message-ID: <20190111001933.4153792-6-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190111001933.4153792-1-songliubraving@fb.com>
References: <20190111001933.4153792-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables emitting PERF_RECORD_KSYMBOL for BPF program load and
unload. A PERF_RECORD_KSYMBOL is issued for each BPF sub program.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/events/core.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8a8fa1b066ff..023821605b8d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7798,6 +7798,30 @@ static int perf_event_bpf_get_name(char *name, int len, void *data)
 	return 0;
 }
 
+static void perf_event_bpf_emit_ksymbols(struct bpf_prog *prog,
+					 enum perf_bpf_event_type type)
+{
+	bool unregister = type == PERF_BPF_EVENT_PROG_UNLOAD;
+	int i;
+
+	if (prog->aux->func_cnt == 0) {
+		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
+				   (u64)(unsigned long)prog->bpf_func,
+				   prog->jited_len, unregister,
+				   perf_event_bpf_get_name, prog);
+	} else {
+		for (i = 0; i < prog->aux->func_cnt; i++) {
+			struct bpf_prog *subprog = prog->aux->func[i];
+
+			perf_event_ksymbol(
+				PERF_RECORD_KSYMBOL_TYPE_BPF,
+				(u64)(unsigned long)subprog->bpf_func,
+				subprog->jited_len, unregister,
+				perf_event_bpf_get_name, subprog);
+		}
+	}
+}
+
 void perf_event_bpf_event(struct bpf_prog *prog,
 			  enum perf_bpf_event_type type,
 			  u16 flags)
@@ -7808,6 +7832,16 @@ void perf_event_bpf_event(struct bpf_prog *prog,
 	    type >= PERF_BPF_EVENT_MAX)
 		return;
 
+	switch (type) {
+	case PERF_BPF_EVENT_PROG_LOAD:
+	case PERF_BPF_EVENT_PROG_UNLOAD:
+		if (atomic_read(&nr_ksymbol_events))
+			perf_event_bpf_emit_ksymbols(prog, type);
+		break;
+	default:
+		break;
+	}
+
 	if (!atomic_read(&nr_bpf_events))
 		return;
 
-- 
2.17.1

