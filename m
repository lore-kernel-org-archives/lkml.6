Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695D5C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1067B20835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E6VSCmaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1067B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeIBRvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:51:22 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:39552
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727788AbeIBRT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Nk2vMalqt6MQvFhRcBbZshpFAvr+WXYdyk96Bk6GlA=;
 b=E6VSCmaHdZ8HZpT4hUsvwYmF0wL6IZQXLI4Rs96IOOoT9vTGyLaYiB4gQ7nuiI6shsv7yCMAJ/8jy47sZfCYH3WHfiQ1+I1CTyldOxB58QctI7eYfk9cZIWDcp3tlNqf4EeOV5iVceoRqydIfd5jrLqFPBi9yvJPQDgnm3Rpx4o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Erica Bugden <erica.bugden@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 037/131] ftrace: Add missing check for existing
 hwlat thread
Thread-Topic: [PATCH AUTOSEL 4.18 037/131] ftrace: Add missing check for
 existing hwlat thread
Thread-Index: AQHUQr1gBE/wJ8UrN0ygaxjXaATxCw==
Date:   Sun, 2 Sep 2018 13:03:43 +0000
Message-ID: <20180902064601.183036-37-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:H2zVfXVnRlqgGOQKzt0tdpTWgDek2MY/7VXFnK5TaR7GM2U25jsqULrTxapugbY8DZ/PTv1/EEAT5q0PReX0LVdYrErl5O2d7rk4NB4AkpIDhjPEcDj5q3r5Wtb4U2/T0A3jZG2BozNSNcRdFQF/07mg/8OtHNI67T7CxLBFHToo+yiWYRKwDdDdO5FGbVJ3YryIDu1341br57iJDm6WfFF8e8aaKHW1vnKjWAOnYHSwjaeSA41xdZD4zcqEMp1TtAAzt3pJXEbUQhScEac6dgejAx3/Hbi4tELE3B97VbmanDHGxDZzF0N034KVBNHRLC1/KNvdULvvGzP+tnJvLVgUIk8o8NdT/Y/Pd1KwqY2YqgMHLEVCthhxaoHpU5j0Lz6RCwxDP1hGxuWHIMBsrSPKayw+yE9sx0aBDRj7pqtWXechyK4MhKvFZIaynXjNXSG9nfmwqJ+UY+HRwQNocg==;5:sI4CmZJ6WvAv+jaGp4sx+7aBVvdUzJ6ZFOQeXfObk7OTyGE7nU/2NzYTXIghpLvIP/NsXxqSVelBa8Nm77s2/HCLD5voGmevhyiAl+R8xzvud+GGM3OIazadyMm072uz6kvRqVsIauu0enIsOaFtRX/uGlGNjneZO6SDxgbsOAY=;7:ENWfbkGbllrixzpH0zfRFOfQyjIOo+eqvhxYwmZzzSZTihIhjGe0wkpoArmtP6GpKfKvzGumhKHZbk3IVUGnsfAjaA6uJTnc+3yEuvcqqT6xSxR9zzfWLPn+1uQretzm4cRjSBsuwRWtDmPI6n0NkGCITVqPGlub88L4SKELoU39S7eZ3oN4/UF11GopmOnsFZTs2FmLG5LiODxJasHkTecyHUexW1sKxovqzhR+VjG2X9lh27nPkb7YKmZWMkQn
x-ms-office365-filtering-correlation-id: 7ffee395-361a-482f-ebc0-08d610d49258
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01354ADD2D0B436ECF895B5BFB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(6306002)(2616005)(6512007)(966005)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: apeNv7QZuGwJdUzH4onh/JtX5qUkhRzLxhhT5QBjEA2l+vZT7jgRwqEW2ZngjvxqM+uuPVb2RLjOczsd6KbKGiX6KzUcuYZpm19VnwaGsBvko+BMOKpgw3A4562WrRGEw25mj1md8VT3SoYUIBiUjU0R2gVR14CghG0YX0c7QsNmfEWAvJxLE8sRCXYeUbVaePX94jhoVjqMF06zGs+CkyHQJ77F8xuR2duv2+Y/GEoUxULvxx6dP/GqSv6zfKvCUZbYndn7BQ4lAxpDYG46WDqGnRPA++JWu2xYsNdHJ8Q5OyLcF6USIkTL8mzIb2+kkVw8cEnz4JVEnKyf/1HTpzNcEKx6nTrMEk8STxtrozg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffee395-361a-482f-ebc0-08d610d49258
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:43.7364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erica Bugden <erica.bugden@linutronix.de>

[ Upstream commit 82fbc8c48adffd73297e7edbd7266a89d00cc52f ]

The hwlat tracer uses a kernel thread to measure latencies. The function
that creates this kernel thread, start_kthread(), can be called when the
tracer is initialized and when the tracer is explicitly enabled.
start_kthread() does not check if there is an existing hwlat kernel
thread and will create a new one each time it is called.

This causes the reference to the previous thread to be lost. Without the
thread reference, the old kernel thread becomes unstoppable and
continues to use CPU time even after the hwlat tracer has been disabled.
This problem can be observed when a system is booted with tracing
enabled and the hwlat tracer is configured like this:

	echo hwlat > current_tracer; echo 1 > tracing_on

Add the missing check for an existing kernel thread in start_kthread()
to prevent this problem. This function and the rest of the hwlat kernel
thread setup and teardown are already serialized because they are called
through the tracer core code with trace_type_lock held.

[
 Note, this only fixes the symptom. The real fix was not to call
 this function when tracing_on was already one. But this still makes
 the code more robust, so we'll add it.
]

Link: http://lkml.kernel.org/r/1533120354-22923-1-git-send-email-erica.bugd=
en@linutronix.de

Signed-off-by: Erica Bugden <erica.bugden@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/trace/trace_hwlat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index d7c8e4ec3d9d..2d9d36dd5fe7 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -354,6 +354,9 @@ static int start_kthread(struct trace_array *tr)
 	struct task_struct *kthread;
 	int next_cpu;
=20
+	if (hwlat_kthread)
+		return 0;
+
 	/* Just pick the first CPU on first iteration */
 	current_mask =3D &save_cpumask;
 	get_online_cpus();
--=20
2.17.1
