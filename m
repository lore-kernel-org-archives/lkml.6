Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC39C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DEB20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cOL6qgYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DEB20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbeIBRXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:11 -0400
Received: from mail-eopbgr700118.outbound.protection.outlook.com ([40.107.70.118]:63159
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728494AbeIBRXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Nk2vMalqt6MQvFhRcBbZshpFAvr+WXYdyk96Bk6GlA=;
 b=cOL6qgYszCPkrrwE3yiEurd6eXXxDJFbIXauYZescfi6jbD3JM63EuxDWhtIbGCApiEt3DqRJtIH0Rn9Ai98BUW7gGR1TcjsdYamwlr9B+dT/YRgX76stHubPhAdcLNV483faG6dlsq3hbq+Gur1r4TUYD/hlMpdnilfwBcHcS8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Erica Bugden <erica.bugden@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 26/89] ftrace: Add missing check for existing
 hwlat thread
Thread-Topic: [PATCH AUTOSEL 4.14 26/89] ftrace: Add missing check for
 existing hwlat thread
Thread-Index: AQHUQr3JFkupBwh/30OCsucUYPgHYg==
Date:   Sun, 2 Sep 2018 13:06:39 +0000
Message-ID: <20180902064918.183387-26-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:w4iFddsyC+xuGY23qGiQamgOAeTZpLTyPF8Mlm03KzqVnU6AAaQsTt+H222k/lxW5IdPKGc8uHxlwlaJLNnMDA8x6wqKfLr8TxnFm6imGlVRH/H5mORXYZj/zKV0TCv9I7pjCV0/cxDtflAi3H0Pi/WPgkWeWg4LNzeL6vb0UxFnJQXCM9RBuRlIR4g9UvK3KZzIzU3B5BPsOmlkyJwMzCKerzdGB4of9hc7W4KP9GNA27A2XYhANFRx/qbw7usiiFCpmRNbO+XCpLgRgB64j54UTYsAHm4iDoOZjQNgCsVgoeDIccJLQz/xt1jAwPMAfteOjtQwgwEL1tHn1Jkt+9w2DMbatRRS+T7p2HkAjn0saKH63Yz/ulKEJggz8BR4oIWf4y/Fa0w1u5g5jXdZFNioVIHASA1A1SRCPzCWd69wtKm+orHGGmLPHwUo0gXj5SeBxSzd5QjBVN9M4a2Rmw==;5:ttweu2+VXXOZddzrLV3u/tnactYtS03xR6OYEs2kJsE2QyynviDO+u1AkUMcQ3MXqWjxJUXPQYin17vuItMkoi0ngNnrYlorVM7mNwG68lzGSY7CSL8Hzn0UHY/VVmFzk0O+bfRWT+3tneEbJPP2im5PnV+UNkaR9N5sIpP8k2g=;7:HqtlSzsjJ0MDm6ZhWDgvApzWZmfpZVZPOMCjcP4uoGogZSPwb1o38316ZRGL8r8Sj34BgPCDfNBIrNX+0cqFyj2amwA5xdULKyNyLqLG5eZT0CmAHpwqbGBZHdN1QEQbQwp3rZxfo7TU9XOoabjAAiyAcAJgQz/I+kmySdRj1JPJHA1mIZYnXw75k1SZIIk6y8m8Yunsc3FdD/VZvrGOn1zMxsKKz1HQ7S80pzQ6cElz7Qrr2SBfIOUkQ4FgbT70
x-ms-office365-filtering-correlation-id: 273f9976-9ae6-465b-8258-08d610d4fb4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0856EA0EED2392BA169EE9B4FB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(6306002)(8676002)(6512007)(14444005)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(966005)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ukmWGwD4ZbLxqgG3nDtRhZ8rvfDNdD9QdhHuTgon4BT60MGJ5GfbhhmQTwB9Km1sm3ZGp5AuzJN2kW0U2nMFLpcglHqd32M8MIk5zL+/Tbv6ASCDIT+QT67I896NQjZSInZUm3iScRKXVYhZeAX9EsGw2X7k6lSes4j3iSGuBYWvwajroduufuGFXdjqhluaOA8THv+M5ocyDmr99jchBi47cjAGQnA9rTQiQ3XaB6no/2Y74YEL1ZhkpbdgAbmL47CD1aBoqDWAyYXT97adb1wBgYBVExYUTs/IxTuL0L86dsQ/6aD8WPSrWUVFUgcDSmt9nT50xx+/86dO8jrLjxoNxQjLdysGPwpKXCR8LsU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273f9976-9ae6-465b-8258-08d610d4fb4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:39.3089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
