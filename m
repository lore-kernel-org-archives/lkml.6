Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F76ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F82214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BJjtZUy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F82214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbeIQI0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:18 -0400
Received: from mail-eopbgr730108.outbound.protection.outlook.com ([40.107.73.108]:57545
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728769AbeIQI0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ODrMZ9ht5MFHH5kGdwNcMWilZxJk+CR9gVFWBOj3v8=;
 b=BJjtZUy/aArKYST1A0We+SOnayp28VNjMBUkfjfTpOkEt8C14HWKR3lriWMUR6llEsWHYBPMFSoI1FKt/IOCjQh18FpamQb0zv/4iO0a+10UX25n8YAA/jYOazoDJ9LNNX6NwIGvz7EgajGepIWdYkN6md7BWeUVApbDm3EUHok=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:01:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mikulas Patocka <mpatocka@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 032/136] arm64: fix infinite stacktrace
Thread-Topic: [PATCH AUTOSEL 4.18 032/136] arm64: fix infinite stacktrace
Thread-Index: AQHUTjKZkwzoLz5wYky3itWJrfizsw==
Date:   Mon, 17 Sep 2018 03:00:32 +0000
Message-ID: <20180917030006.245495-32-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:cCeFHKSXjoZm5ag5V5hhAEO7hnepDZZXPWZrp5Oe57rkwbpWrpWBb9+cmevZPgczfXMajz9TN7LeLdp0kY+uiw09VBlLAuU5pOoMhyQ03eijkBh31mcIsKBSp66d/XChOliSTeuP4EEY8P0ncCWAtUSyRQ+G4Wp/d7xMc/7hP77dHuJCoaq2/q/KGSZ097ij0pnFB1GQy4iUxTDcilYGS/pS9eCoUQhB3HM1vim2D5O9BkNZbaUTniYEzei71cxqriWTj7b2hoyrVX9Z6nJCvNED/ZZK8SDVEFOt9jg03UgxHMPUYEfQdAv8u5lIoVKsk2og1tizGHlhwEV/y7NjIr3CbVCcArsVy7EQL/XOLAH/o0E8DMx7qy0x+Yjj79GYThM28a+mpnWte/ge/jWjKYaYQotp/TYkfHvKtZCEdXms9mhPmoubY+8Nxg48YilID/ErzIC4aKFbheMa8FiypA==;5:E5beUMA4fbjgdmFeia9UAZBI7Md3/zp5I/G1cyd+10wq3FODHFgGcbfimgJqVvmmrZ2mAFs88aRKbmc3xh6VjwQwKF3+1HJJ8KPaedit0OnhstWLyHrnZ87g4SsE4+b9+m//UejWTiBem+sdlQFp1Um6E1g+opt1FqXzq8bUbnk=;7:rNxJfaMZvgE25GFIgIlJYBKWcC3aSI8oWUpxhwEJJ4BOLNKpteIZTstNkEclT467svrGoq+c2Fgxww4c2yDl3lMsWOsQ85uWCm95JeFvh+5o0/r05Gw0jV9A13goQuJnahYM8VIVbCzBr9fxJD+O0Ud9IRtyM8Fnl/0ujaRM/X1rJ8pLQ50GjB/m1JEmxl6EOVe6dYrYpbHr41qNdXfaKIWXNHkRZgGNSmhWC1XwCwhClHIrskTncDTWbvntEXYf
x-ms-office365-filtering-correlation-id: 26388634-b51e-4e9b-561f-08d61c49cd5c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB062978B0E881A33B3CA1446EFB1E0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(51234002)(189003)(199004)(76176011)(1076002)(86612001)(105586002)(22452003)(5250100002)(6666003)(7736002)(68736007)(4326008)(86362001)(2501003)(99286004)(6116002)(3846002)(36756003)(107886003)(72206003)(25786009)(106356001)(14454004)(6436002)(5660300001)(10290500003)(486006)(2616005)(446003)(6506007)(11346002)(97736004)(256004)(476003)(478600001)(305945005)(14444005)(217873002)(81166006)(102836004)(6512007)(8676002)(6486002)(2906002)(66066001)(2900100001)(186003)(26005)(54906003)(316002)(53936002)(8936002)(10090500001)(81156014)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mrAG7BBaFU7nCtae0pAeLCRYfEEnRihbZk4BSay/OgvfNiNjhmQ/bRiA826gjPiOXWhW5++QlYX0cbZJDeG++PbuMttmUyGHFD6VRCoId350W3eWkPNLaeR4MZr5NMX9YJ6LfAb1wLOsm74OXQikzMnv+HCw3+duLA30DK9k+q/AfPzF+xg4xcRdVhh6VrgB+1aRM74T41z5aEaSN2wYxFU9zpYoiojg96M+pVJowc0bbGhNVm78FbQnSitmIQtZ3Oey+xVlVprxPb0IJUqh/Sxh487tXAJrVw0fAyAw71AH5Agq98Ndbh1CS4BkH2Vp2ZVoeZTNsNrzFfDy6YL4RiI1tNv2HSPAD97xlHClf6s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26388634-b51e-4e9b-561f-08d61c49cd5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:32.4640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index d5718a060672..e160ca123da3 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -56,6 +56,9 @@ int notrace unwind_frame(struct task_struct *tsk, struct =
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
