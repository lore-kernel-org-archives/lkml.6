Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D793FECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87405214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Zrklt2W8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87405214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbeIQImX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:42:23 -0400
Received: from mail-eopbgr690134.outbound.protection.outlook.com ([40.107.69.134]:52946
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729428AbeIQIbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwaikJ0YczO44J31lFyBni9w54l8pw3PnQNtVW9osJM=;
 b=Zrklt2W88bHGIkYZsfJVerkPlpMaOBJbpf8uZf58fOOgi3qXwnRH6vkIe8KMgvqVvHJRl2n2jR12e1pQ9LueQ5P89uqsrBPOGM8rCDRMMUeu9WKJfEs0cNjSSO7+DZf9HKEf+DiFWv5rBl9Tpi4RimnLEtwYdFBjG4apeHoFDJ8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mikulas Patocka <mpatocka@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 15/57] arm64: fix infinite stacktrace
Thread-Topic: [PATCH AUTOSEL 4.9 15/57] arm64: fix infinite stacktrace
Thread-Index: AQHUTjMQ+9DWk0shckqS2DghBdSDVQ==
Date:   Mon, 17 Sep 2018 03:03:52 +0000
Message-ID: <20180917030340.378-15-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:fgmNPYrqkQIU0+VAsHWVk4hvEL9VmswGd/yD5F77LDnR/BKdc1DGsF7CMwe9ecX29lojd16SXyhyHgYFAg9+/mor2HDxpPNJYL5R1w903+OfCwsfpwx243+MjCqVKc75xTDJ/7YRCl0syUhtbZTWByuC6CIO2Nrm5jpGHAPWvWL3aJSXnxyaVZnDWxtwOlxEdg7kXfc9Uan+zLF2eSrLPTu5Ym+Ayy4+PaVNm8gZshMfLXGl71ggOQk0jWMKiCE+plZTJswiclY21RFthMQgIcvjPT7c4iNRbE70OMRYqk6atkdt3+5oE5on2gsySE0qSfvNnDePudDz/C+O7QXLobXO5ZyE3qj83bBMmEViPltBnjc5cRqP+2hEY3qGm5lP7iKAdYXz3figun3xiI5XApYzGTay6Ebj9pqIwTREXQG5THUZYJKEBl7GHA0wjUh2+I+g28cV992IXJzR525KEA==;5:wA7y7U9MA1zxzz0k2YfNiq1pzx6p6TnT+/lEDYenrBDlCodLDAgLNknSEQAVIMpQkyol0joJywH7bqtAgEhrDY32GO4pxfVBAjNR5emsBD1BNuFHznD4+xihMrD5a0o6B1HcLjUkRLTDBjObBXhN++LjPqI9tYz20PeQ53wb6Ac=;7:G5rJMat9Z9zy22m2eO7FnAdbRABDNXeGw4jxGjG2vkRsLlSK++pQV2s75X36IH2evHOiHqqSNsdk+hPlfZ63S5JlzORXUuLczMJ2AgJNhpXc2fuc1xslG7ARUEzfr7zBYLZpAyAkAsmXbc4UKKFW4jBIdP4VPrG2TzLxnH2VmD0ZeIZcw4d3RJxXsbUEDZCusdN9efnS4MAJXBAtSb0JyGFTvO7hlm97K8VaQ4w7Hn8Xz8YgidbYSMaT/3UVSOb4
x-ms-office365-filtering-correlation-id: ab31222c-99de-40db-acc3-08d61c4a7331
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB01209D87D3E8C48EE4ABDF8FFB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(51234002)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(575784001)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /JAQCrYJf4qaQGERlBPS8nV2AbPo2cpCupW5ODiZ0k+5MTOhb5l130DWvsYk5FooAhy9S2N4SRpIJCMeiG+KGgA87hIxjumCH4uHhdhRpHxHcl7UwxC6aY4QX2U9ZLoLnwk02cYkgaAOzCkvEe7IJUDZsfoHrZVX8NLc4N0bI5lDrw7J9pe8qdPcVJ6q8/Bfc2vI2zV1peEBeEhQkg0vaSa87B1BQhk94/+sbF/zpozX9tx+/lEl6GpH820q+xdwDawxQhclh27d1qgjEAOM66eF80N4T82HPKLuvANgcibQkcnqb4MiKl8zQNubFZjPvFGb164b9XQ7Q2m8+h6vhlH/VtnM+Izfhv62sC6Qiqc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab31222c-99de-40db-acc3-08d61c4a7331
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:52.6491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 7e7df71fd57ff2894d96abb0080922bf39460a79 ]

I've got this infinite stacktrace when debugging another problem:
[  908.795225] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  908.796176]  1-...!: (1 GPs behind) idle=3D952/1/4611686018427387904 sof=
tirq=3D1462/1462 fqs=3D355
[  908.797692]  2-...!: (1 GPs behind) idle=3Df42/1/4611686018427387904 sof=
tirq=3D1550/1551 fqs=3D355
[  908.799189]  (detected by 0, t=3D2109 jiffies, g=3D130, c=3D129, q=3D235=
)
[  908.800284] Task dump for CPU 1:
[  908.800871] kworker/1:1     R  running task        0    32      2 0x0000=
0022
[  908.802127] Workqueue: writecache-writeabck writecache_writeback [dm_wri=
tecache]
[  908.820285] Call trace:
[  908.824785]  __switch_to+0x68/0x90
[  908.837661]  0xfffffe00603afd90
[  908.844119]  0xfffffe00603afd90
[  908.850091]  0xfffffe00603afd90
[  908.854285]  0xfffffe00603afd90
[  908.863538]  0xfffffe00603afd90
[  908.865523]  0xfffffe00603afd90

The machine just locked up and kept on printing the same line over and
over again. This patch fixes it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/kernel/stacktrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.=
c
index 0cc01e0d38eb..40b2680748f8 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -69,6 +69,9 @@ int notrace unwind_frame(struct task_struct *tsk, struct =
stackframe *frame)
 	frame->fp =3D READ_ONCE_NOCHECK(*(unsigned long *)(fp));
 	frame->pc =3D READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
=20
+	if (frame->fp <=3D fp)
+		return -EINVAL;
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	if (tsk->ret_stack &&
 			(frame->pc =3D=3D (unsigned long)return_to_handler)) {
--=20
2.17.1
