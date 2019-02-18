Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD177C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA4E2146E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KjhUWIvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392133AbfBRSVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:21:34 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33939 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392078AbfBRSVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:21:32 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190218182131euoutp019919c14093e9f516271454e055655894~EiFnY7Z3V3074130741euoutp01r
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 18:21:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190218182131euoutp019919c14093e9f516271454e055655894~EiFnY7Z3V3074130741euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550514091;
        bh=b2iaLzmSEcFaz20hz0kaymKbyDrXzknzPzghNngGPJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjhUWIvWJUmAiG7rLmFlPpC1xfSANskswqzHQT37/fAD5uXl9zktBYv9zO4nX+Xyy
         CYcaU6Hh8vOZNS4a/u1uBAs4f+BA1kOMKsazRT6tAckDQI2F2G0w5WmaKDX++iWn76
         dJvUA7Vabo0t1GMIl+1+rT75gmqwO30YH22XaqUg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190218182130eucas1p1163aab1630a4a65b1cb82424c6b68930~EiFmUJZSO0172501725eucas1p1c;
        Mon, 18 Feb 2019 18:21:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5E.87.04294.9A7FA6C5; Mon, 18
        Feb 2019 18:21:29 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190218182129eucas1p236fc8ccddd9a8cde25c15f7545276885~EiFlijdsI2469324693eucas1p2m;
        Mon, 18 Feb 2019 18:21:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190218182128eusmtrp1e42cdce2c1e52f6af683333478c10ada~EiFlTWX0l2427024270eusmtrp1v;
        Mon, 18 Feb 2019 18:21:28 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-19-5c6af7a934f9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6B.F8.04128.8A7FA6C5; Mon, 18
        Feb 2019 18:21:28 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190218182128eusmtip17d767e79a6dbc12add67961dff5b4ed3~EiFku1yJP1523015230eusmtip1T;
        Mon, 18 Feb 2019 18:21:28 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 1/2] trace: events: add devfreq trace event file
Date:   Mon, 18 Feb 2019 19:21:08 +0100
Message-Id: <1550514069-9237-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550514069-9237-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djPc7orv2fFGEy8omuxccZ6VovrX56z
        WpxtesNucatBxuLyrjlsFp97jzBarD1yl93i0oEFTBafNzxmtLjduILNYl/HAyaLw2/aWR14
        PGY3XGTxaNl3i93j4Ls9TB7v911l8+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6MF+072Qqe
        ClasnZnawNjB38XIwSEhYCKx+UtSFyMXh5DACkaJXw9Xs0M4Xxgl2i8vgXI+M0pM2/KZrYuR
        E6xj8b27jBCJ5YwSxw6dY4Nr2XT7EBPIXDYBPYkdqwpBGkQErCRetL8Cm8Qs0Mwk8axtIQtI
        QljAWeLXuynsIDaLgKpEx7xZrCA2r4CnxLc5fUwQ2+Qkbp7rZAaxOQW8JH6v3Am2WUJgOrvE
        5pcvGSGKXCSa/s9lhbCFJV4d38IOYctInJ7cwwJhF0uc7VgF9UKNRPvJHVA11hKHj19kBTma
        WUBTYv0ufYiwo8SsC3uZIWHEJ3HjrSBImBnInLRtOlSYV6KjTQiiWkNiS88FqIvFJJavmQY1
        3ENi29bL0OCZyyjR2LGfbQKj/CyEZQsYGVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIE
        ppbT/45/2cG460/SIUYBDkYlHt4Fy7NihFgTy4orcw8xSnAwK4nwHrsBFOJNSaysSi3Kjy8q
        zUktPsQozcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cAofqzVR2vZVO2V1odY3y+aa2JT
        MMWIVY/r25KVxTYm6gxnbnXf2W1x89fkO02uBRUBCxk32Ox6YBjJYb5jQ//5VS8WvphY7mMY
        FmFro/ri4sItul2WJ95L9OXZbV93+61Y1pV7jhMs3h6XeH7w0uL1NbHaJe3nvvqJbCi6/lef
        Icf8Qk5YwvVeJZbijERDLeai4kQAj0277SkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsVy+t/xu7orvmfFGKx+ZWKxccZ6VovrX56z
        WpxtesNucatBxuLyrjlsFp97jzBarD1yl93i0oEFTBafNzxmtLjduILNYl/HAyaLw2/aWR14
        PGY3XGTxaNl3i93j4Ls9TB7v911l8+jbsorR4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MF+072QqeClasnZnawNjB38XIySEhYCKx
        +N5dxi5GLg4hgaWMEtOvXGGESIhJTNq3nR3CFpb4c62LDaLoE6PEt22zgIo4ONgE9CR2rCoE
        qRERsJF4P/cMC0gNs0A/k0TTkg5WkISwgLPEr3dTwAaxCKhKdMybBRbnFfCU+DanjwligZzE
        zXOdzCA2p4CXxO+VO8GOEAKqOf94F8sERr4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcx
        AoN927GfW3Ywdr0LPsQowMGoxMO7YHlWjBBrYllxZe4hRgkOZiUR3mM3gEK8KYmVValF+fFF
        pTmpxYcYTYGOmsgsJZqcD4zEvJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZqakFqUUw
        fUwcnFINjFzpP88o7FlbvtDpsJSMZDL/a6bQbdevea6p/PbZQX/7z3PnaufYzZZr3/ZMkM/4
        zJXOa38ZVh5qS7z8469/Ue95JvZ1y4OCxBKX1RfdE8py9b79OIR53Vpla6uQhHCWXLb7FicT
        ZzrP6vix4bmZRn/S7t8617a0MG/a1F/KlegdPvUk39raZiWW4oxEQy3mouJEAGonEeWMAgAA
X-CMS-MailID: 20190218182129eucas1p236fc8ccddd9a8cde25c15f7545276885
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190218182129eucas1p236fc8ccddd9a8cde25c15f7545276885
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190218182129eucas1p236fc8ccddd9a8cde25c15f7545276885
References: <1550514069-9237-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190218182129eucas1p236fc8ccddd9a8cde25c15f7545276885@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds a new file for with trace events for devfreq
framework. They are used for performance analysis of the framework.
It also contains updates in MAINTAINERS file adding new entry for
devfreq maintainers.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 MAINTAINERS                    |  1 +
 include/trace/events/devfreq.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 include/trace/events/devfreq.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 41ce5f4..9c44076 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4447,6 +4447,7 @@ S:	Maintained
 F:	drivers/devfreq/
 F:	include/linux/devfreq.h
 F:	Documentation/devicetree/bindings/devfreq/
+F:	include/trace/events/devfreq.h
 
 DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)
 M:	Chanwoo Choi <cw00.choi@samsung.com>
diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
new file mode 100644
index 0000000..cf5b877
--- /dev/null
+++ b/include/trace/events/devfreq.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM devfreq
+
+#if !defined(_TRACE_DEVFREQ_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DEVFREQ_H
+
+#include <linux/devfreq.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(devfreq_monitor,
+	TP_PROTO(struct devfreq *devfreq),
+
+	TP_ARGS(devfreq),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, freq)
+		__field(unsigned long, busy_time)
+		__field(unsigned long, total_time)
+		__field(unsigned int, polling_ms)
+		__string(dev_name, dev_name(&devfreq->dev))
+	),
+
+	TP_fast_assign(
+		__entry->freq = devfreq->previous_freq;
+		__entry->busy_time = devfreq->last_status.busy_time;
+		__entry->total_time = devfreq->last_status.total_time;
+		__entry->polling_ms = devfreq->profile->polling_ms;
+		__assign_str(dev_name, dev_name(&devfreq->dev));
+	),
+
+	TP_printk("dev_name=%s freq=%lu polling_ms=%u load=%lu",
+		__get_str(dev_name), __entry->freq, __entry->polling_ms,
+		__entry->total_time == 0 ? 0 :
+			(100 * __entry->busy_time) / __entry->total_time)
+);
+#endif /* _TRACE_DEVFREQ_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.7.4

