Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D589C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3E120811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="ScVZJdKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3E120811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeLNI2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:28:17 -0500
Received: from mail-eopbgr60136.outbound.protection.outlook.com ([40.107.6.136]:60028
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbeLNI2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09/67b3DYgV1d2jnz0rqVpMc5spJAI0aZRn6YJoh3rE=;
 b=ScVZJdKq8PGFEHsqL/qNArqyJTAOcTF6oeCy2gAt4/K0v4m3/qZC98RTq8iGACQVX/lzg3c6V/aPDz+BPhqGlq/eOFMKMtO7VU/OwvlPIq9ISFCPc4wwl66v+nH58KvMDsqnxRLc67CcDOOIDLRUALVYceInqCC/88beaYEFWlk=
Received: from HE1PR07CA0043.eurprd07.prod.outlook.com (2603:10a6:7:66::29) by
 AM5PR0701MB2834.eurprd07.prod.outlook.com (2603:10a6:203:46::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1446.9; Fri, 14 Dec
 2018 08:27:57 +0000
Received: from AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by HE1PR07CA0043.outlook.office365.com
 (2603:10a6:7:66::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1446.9 via Frontend
 Transport; Fri, 14 Dec 2018 08:27:57 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.240) by
 AM5EUR03FT015.mail.protection.outlook.com (10.152.16.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18 via Frontend Transport; Fri, 14 Dec 2018 08:27:56 +0000
Received: from lfs-10.localdomain ([10.157.83.243])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id wBE8RqxQ004241;
        Fri, 14 Dec 2018 08:27:52 GMT
Received: by lfs-10.localdomain (Postfix, from userid 69031427)
        id 3758F95FE; Fri, 14 Dec 2018 10:27:52 +0200 (EET)
From:   Benjamin Bouvier <benjamin.bouvier@nokia.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>
CC:     <rostedt@goodmis.org>, <u.kleine-koenig@pengutronix.de>,
        <bigeasy@linutronix.de>, <pkondeti@codeaurora.org>,
        <alexander.sverdlin@nokia.com>, <linux-kernel@vger.kernel.org>,
        Benjamin Bouvier <benjamin.bouvier@nokia.com>
Subject: [PATCH] sched/debug: Add tracepoint for RT throttling
Date:   Fri, 14 Dec 2018 10:27:41 +0200
Message-ID: <20181214082741.8507-1-benjamin.bouvier@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(396003)(2980300002)(189003)(199004)(52314003)(44832011)(336012)(305945005)(47776003)(106466001)(1076002)(97736004)(48376002)(50466002)(103686004)(2906002)(107886003)(4326008)(6266002)(26826003)(110136005)(16586007)(42186006)(316002)(106002)(54906003)(478600001)(53936002)(14444005)(36756003)(356004)(6666004)(52956003)(51416003)(5660300001)(68736007)(2616005)(476003)(126002)(186003)(81166006)(8936002)(50226002)(8676002)(81156014)(486006)(26005)(86362001)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0701MB2834;H:fihe3nok0734.emea.nsn-net.net;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT015;1:9mdeLI8/0+Pqm/FCUz9Tpiftqd3cfCHhUbdnw06oMfMGN27tToA1QP4/5MKqII9PgY86OJTNIOWeSmPLVBB3KKgusWn+CqhFOUcmMGOucAsTmk1VKQ9tZJP1p0/AGOZI
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d464d933-f99f-4b09-a1ed-08d6619e0ce2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:AM5PR0701MB2834;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2834;3:0ds0ScIjGiNn4RX8/9Jh3g/kUyaOV/IJLBAUvZvt5K1Di/Pz/56lQfgpGHtdJOFOrQJ9qmpfX4GG6OTM8dhAnK2iviAmGNiDmfUq1ikaZZsUzN8TPqB9daT9UG8nZQax84DgX/OBGJS4y5si3/G7eh2YrRLctjef1Lio6sgANH4hqLILBj9V3NRdEfpPhFZMxLRowlMzfMoJLVplDotmFrtfqCTdOSzjoU9IVk+8Xl4UMVl90wqzNZzAX3siZC6FgFKc+fBEX/7bvHd+hOsLVIY1+SbzTJbhAP49kMcZYd5WF6a21uJd8BSldhSX48gYrV78Xej4gAbsgqK+PR4d9h81AnJ7Rsz8088B2tfyUMI=;25:jgO1ZwCjO5njd+X8ypmzXwjlLNUnuItCX4+PSl6oRw6IlNzNkaImCdH/csHA6j4VDLwUaFWwQuQ39co3FS/GDoYl7qq3Yiy9Hdx+zTqh2itl9ow2I+IRUKJ33cst6zKzSr39ASbUY+0OP8Bc5bG9W8Lm8rrwKv1fz5CIe7d6/ube2YMTK0xk+OwJwNB1uBev43SarNH1hb3S+AtuNQ/dsw73QCwb8m2qR2TiZaoUzYfhU0gKCC7VUCgRYmTaPN4ZebdkN7MZ4IRNdgY1db5CvMUyrRUT8P2x4MDrwXl9H1r1F1/0XiHwFR5718Qg3PxZuqU2ctvuA45CEM4/wwfNFg==
X-MS-TrafficTypeDiagnostic: AM5PR0701MB2834:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2834;31:ok4xuB2riWvD4bmX8JXylQpovwEu9QiruGSFarjS0xje86B64eKUTZqww8e73jYqEzveGDwmoJROYIxBI5+XcxYVvNTrKvqUshlsmSelzTJ7cH9LmT0J4WTAzLSRgTCs3i9tBjEDkSKiryGgLeU7rRzLh5xVBwGLkapUeUyNirzxMkOeGWTzeapUQoJCrxzvuKiaDLb5wC6WAgt85fh0V95pKpoYpuQILcSkVHwK62o=;20:ECm3mualDjBxLJhTAXqP8snTY7PH6cDUjVM+u4DRCRWEqeMhbfmwgOTzRNsBC4tJveHsu7lh3Rhj4BgXlb0CjPJEQF593ibB1gEQHObo0kQs+TQLD1K3qbw1baAyyQpX/SnLjtCpTmgpSHIvk4yEkXZOl6L0sRVQSIP3AWbOVq9EBoidKXvaTL2QLGsWUiQOCc/skpPJk8zsQR57KZT3W10pUfTRq6sDD77cV10NqeUpcYjDTUmk6zalku5EoRKlLqSGT4huUaz2KOVJAF3orzmFR0JE/7FHl1TsOQjRlftY1R4fjX0M1rUIKj6ZkvNFBa4OVUAWAE06EvRgUy8DVBUU6tuFkxioM7ONmU+HlPKRkcZ9aTTHFsF7MYM3GueIy3KrYX+he9W2ECukacyO+UgwRFckKShlAS0JIRkJyN9j5xkC4hEtJgfMk73tjKBrICyZfeH2ACYAyKj4SHLBM9wZdiyg4xj1TDHmOZ80VK0/3/3mF5ZFDurSFW/jLrXmBf5Bm/0l1hZnf/usHyye3PDiXaXwoW+THqK0qDXL8OMgSqebzHg0sH2Q8vl/ufBoOyrpaoO96L+TzKZFZMA4xT6uvh1Ki1PXpBvwBuX0L6U=
X-Microsoft-Antispam-PRVS: <AM5PR0701MB283413FCB634B918F05630B681A10@AM5PR0701MB2834.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(806100)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM5PR0701MB2834;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0701MB2834;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2834;4:XyQC3jvp1Os9JDv0XJOu2XZlsHw0L4yxLOqdjXHHD2zC1aAjWja5bKlaukB4ZU8GVLomO2QWFsrDsi8EJVehtzzXxvLIgCb5tLwwnO8PVJ3SQZj5lkKGscsmcD+L4OFURRA179ePV4TkWvN+eaH39VPo9ruOT8mH5DBG3Jce9ILD1xE/te5QzZQv9XECq0gAXfDEezaAx1dpy77cDXXMVmsTSBF+J5wiiLxfVu1lsAgb8XPrBMjbmTSkDW4Xr/4NRJsTZsJqd+CJt9iSbcydgg==
X-Forefront-PRVS: 08864C38AC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0701MB2834;23:UnawZajit3wgnTDBAuop/fE2pSvvNgqbt5ObgH6?=
 =?us-ascii?Q?UiuMW9bmDGwGqW5Ev95nqVLncItYLVGWNQbczKkD83qg5rH3aG9VaTNM3lz9?=
 =?us-ascii?Q?IkChJL5oUcSGgxjsNiscdUcdEYt1t3FwOjT+AWz0DGRR7z0GEnbcrSAiyIv9?=
 =?us-ascii?Q?plWMRZIkukCRud3vpbSB/hwDMMOnnNxTk3Zbnqdhp/WCmFA1O85HV57YsO5T?=
 =?us-ascii?Q?UrIlIShufB6SYtD7hL84q+IDl4WZ43wBvo6okAK+NBHol7BG2yuxr7zWiFWN?=
 =?us-ascii?Q?cfj/eJJM6OEAeVat24/Y5lq0hpcuORUap21+YVuVUttRzBK1TGq8ROwwv8uu?=
 =?us-ascii?Q?+4l5bS9otnO1EwJT+/KPcMVrX2fb+2a8caCCmtNhmd1oeSFadmpPHhWIcVPt?=
 =?us-ascii?Q?Zu3rN3vKx1tN2E24Zt8s2s+3rMMIcxNDVlsy7QbdDPeOYkuGKWq8WBpiYXB9?=
 =?us-ascii?Q?NOW61TUAisf0dzSGuuLzBbDwfp+I5gdl+TC0+nCi+zXoR1Hx9N+oKzZYGRzp?=
 =?us-ascii?Q?HkxV4pTSeX+3GXPDm/oCyXNzLx9fxMozSSweiwMoxs3jQglC0CIKhTeHT2Pt?=
 =?us-ascii?Q?by95AbqSLk5QKTuW/S0qPUvidih6rm2v+1k+vXemUu5gODQccnPJhAHqjcZ/?=
 =?us-ascii?Q?JJtkTweP9nXzw1FiOCg6L9oHU+4djxxIrdneJb4yJNSzsl2TNHqgfSNIzY4l?=
 =?us-ascii?Q?ioou1B4jXjIN3kvS9uMpr2rgrlHt7l5EY2fw+ihrpdCGSf+9rR3P8qnt04sf?=
 =?us-ascii?Q?6l9F8shs16Yskg5YBq6c0o2Oj2vuBvoWC3Es/Mj6Nbvhu+GOqIorvJOEggvs?=
 =?us-ascii?Q?DjTMmC+PqL3YHzYSzwu3gPCFvvk7Z+AtRu0f/tZsnQCZaw+njof9KvICg4bh?=
 =?us-ascii?Q?qutY2i4/RbQJ4IFZ8l/Qi1J52dVCAVXXnxIUJG/chyqq9m7zkpgsQc/fC1Gt?=
 =?us-ascii?Q?dHTuHOdJNJ+E07XB39nnk86QelbHk6c3B1a9Q57dU+ZvWsAxam+N/rDblpCY?=
 =?us-ascii?Q?YX5mCes0uREquUF90PG+6rmZeMdoCe/VLAmC+yT7pvEohzQS954hB1uoEHpD?=
 =?us-ascii?Q?IpP990V9VrWgnTbxhpUOYeA8C9lNDosuC+78aegFv58sBEZi3fbJ11QKxKNg?=
 =?us-ascii?Q?LkQmRewPrFvIrbWuhYthqefJCpb7c/uGj5SkbKYZ8Skti8nEr8CmwTLaLRzD?=
 =?us-ascii?Q?yo5iWaSa3u2Z/Uwg=3D?=
X-Microsoft-Antispam-Message-Info: /3/HcQX5S/888UtgWgQ23srjfakBvZD1WU6jEUXvCxGnNZbjSeGKe4bUAqXGglop3W7o3CuIwCJ6cu5FE+zH2oRM9mvIZUaWTz/Jz6fcrrN5dTBRAlaFjT5oFz62ti/eNXf9v7glp4sOmjnAOXptk+5jTsPs0QjZXcZfM5YXYq6XX9PKhJqRvaSBu1X0kjwtXziQDncGuJXm6Swjf6J5XNUwC/2CelziWhJHD09kKeCbylrCWTU44FAk76NAqCB+lCg1WHtyc3zWJqVqpNzVgFmv24sX580kuc0FqXEnX3KHs049df7l/kt16R4F2p/W
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2834;6:/4wJ/5QAOHGG+Skq17+neUupSg7JX7OJuWJuo67Gv81q9XLyGYrzt6LT1FxfZ9bT/yfKg0ysgmweX3Hv6U14jGouGqbuj/7SeIZ3dfK+vjVjySBdihpGond+bDAJG8GR4r45b85QKc6nXN4WThxcPZUBAJc/VwSy9RTwziDhtXC7O7K6Ay31kyev8PkiTZeUAwsXZ2/XbyWYF6F351nGb3IgAAFrdk5IVrtaMFT/tTsq7E7Hb4SeTZ3rqoSU+6TM48ICk53ScGoD2rEj262mzD3FNF59lr7DD4owKMefuCzYYrvnbqeW06rw29CsjACtE53EZs3tyk1FDoe4J7J4LiP3eU4iykkaklWehmmZJPrnCQ8st+W2WmKy25NfeZr6GyfEbG2QdwanD4+cj6b760qxg6x4ypAGI1hyreqkmkNkcyq7N1K0b2heAN2znqd9Fo7tHkv8dvgE6fGfWX6/TQ==;5:O5hxg1qz+oafcbzQJcoIwC0dOTGuqCadhv2dB5r6JbpXUWPOwrWFnb4/WMItn3m2qEgj9Cjrbb+2pf+mzW7agqdW3u+D0KGJyyvvVnObWYQoMhSx36u1Akaev0+HbJviIdza9N+37pLsdC5AiR6NHf4/XRhn7DiF93ODEDxBX3o=;7:Vguql78grlay3FEI/xe8zoVRUcRirOTxtUIy3bbK1w9erimnxA4iYyO58JH68rdlRR1ylGjrThgsWdoCcoiMboOIKeDXiHZLNAwfd5RTj0aZb9gDNZ8Faeh/S6Q9uQMlxIXFIMCAZ4/MNrGZCnbQLQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2018 08:27:56.6378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d464d933-f99f-4b09-a1ed-08d6619e0ce2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0701MB2834
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is currently no information on which RT task is throttled, add a
new tracepoint for debug purpose. By the way improve printk debugging
message by adding task name, pid and cpu for which the throttle has been
executed.

Signed-off-by: Benjamin Bouvier <benjamin.bouvier@nokia.com>
---
 include/trace/events/sched.h | 27 +++++++++++++++++++++++++++
 kernel/sched/rt.c            |  6 +++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9a4bdfadab07..09d3f7566f0a 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -587,6 +587,33 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
 
 	TP_printk("cpu=%d", __entry->cpu)
 );
+
+/*
+ * Tracepoint for RT throttling task.
+ */
+TRACE_EVENT(sched_rt_throttling,
+
+	TP_PROTO(struct task_struct *tsk, int cpu),
+
+	TP_ARGS(tsk, cpu),
+
+	TP_STRUCT__entry(
+		__array(char,	comm,	TASK_COMM_LEN)
+		__field(pid_t,	pid)
+		__field(int,	cpu)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__entry->pid	= tsk->pid;
+		__entry->cpu	= cpu;
+	),
+
+	TP_printk("comm=%s pid=%d cpu=%d",
+			__entry->comm, __entry->pid,
+			__entry->cpu)
+);
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a21ea6021929..1a0ee91c9e16 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -6,6 +6,7 @@
 #include "sched.h"
 
 #include "pelt.h"
+#include <trace/events/sched.h>
 
 int sched_rr_timeslice = RR_TIMESLICE;
 int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
@@ -928,7 +929,10 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 		 */
 		if (likely(rt_b->rt_runtime)) {
 			rt_rq->rt_throttled = 1;
-			printk_deferred_once("sched: RT throttling activated\n");
+			printk_deferred_once(
+				"sched: RT throttling activated for task pid %d (%s) on cpu:%d\n",
+				rt_rq->rq->curr->pid, rt_rq->rq->curr->comm, rt_rq->rq->cpu);
+			trace_sched_rt_throttling(rt_rq->rq->curr, rt_rq->rq->cpu);
 		} else {
 			/*
 			 * In case we did anyway, make it go away,
-- 
2.10.2

