Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ADBECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D472147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HTNFkVog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D472147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbeIQI3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:02 -0400
Received: from mail-eopbgr690092.outbound.protection.outlook.com ([40.107.69.92]:17633
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729959AbeIQI27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ODrMZ9ht5MFHH5kGdwNcMWilZxJk+CR9gVFWBOj3v8=;
 b=HTNFkVogbGobE8qwOwm2reVFdMxJowDVnk5EGSYojyJyC7MiG+xngwVHTzHmXk1AzcY5ejLwQ9JRdWQRDo8yrbDFXE69ki5KzDssxND95HVwv25TDgycXLsy5k0vWUHTlyIc/iQ24hQNyco5x1NZjwhIv4jjCZS6veLDhxnoXxY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:03:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mikulas Patocka <mpatocka@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 22/87] arm64: fix infinite stacktrace
Thread-Topic: [PATCH AUTOSEL 4.14 22/87] arm64: fix infinite stacktrace
Thread-Index: AQHUTjLjt/ckk+mcgUOJgYfdfIu1TA==
Date:   Mon, 17 Sep 2018 03:02:37 +0000
Message-ID: <20180917030220.245686-22-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:eEa3tT4mb1zS55/YJfYEpJkVVGc9I5j/x+/BTi+K8BqHVzZjM9xFG2wiQBY3zSRYYp2Qkxd6zTF5f53P8zWhZjMgTj59NkIcCTx16G4I1Z9j5Xi15vIiywXi8UMqtt9+bsD5aO8Gvj0bJt2pSW1AS94kl0GsyHKU1FQC4HJg2fPjdBkU02D4oZ3lJG68kHw3aVZZwW4oI30tLIaTgz0Cuw0SaVACn3ouQK0S3wmhqe6JDd6GPG4Q7xcyM/0TgpMKM/ztxoUtCqFth/WFEQmgePV+g5lREXtB9UxOwfbraJWaDEYG6WEm1ojGWGvphveqNMdc6nAzl028STMQpelZbnNRQYGCcdx4PQigl7iKhWGmwC2WeH+wQQhReuwJSJWSYiqOVYQbIu28PE3LYT/wJY/gvDQNcRhmdtwsMmXycH/448n2lsHHGPMfH8TzGM874+mfdUjUij17jAjWl9fdtg==;5:R2iaMw1PRkF8O8xhO01ukYyL3kHQetp3mHEDwNvJI4uNhyjkZ3Yhw4F+KYZ/QBgaswk5HVIjLpRpLOn5svgm/IM5uHFOL7L5U7tm5wsQSm7F5uA1shRHxTkjG59H9Zsv7kw3obhFJqamgV1AjizEB31Y5cPwifbfodXoWUyCLG8=;7:Gj7+cn5SlM5ZYhV2EULnCzbEAMSpaIX50RbNbShg+Sou2cXS7anC6dEntYH+ch71hEyvwDia0yarPG5MREUzSg6QbKXtD4bAaf50iGDr9Tis70O91CAKnxhpxJNOzA0ju6/ijE+Im9Uzsj1+bgaBk4vP4u85pKSDQnQBr6zll4+jM8l+XCTW68o/iQ+031vwJJikylaIMwHp5Bi6ncuXFKXDp2OM7/LPPWtLqhMygexG/96om4Ua6LYyZyTZIKbo
x-ms-office365-filtering-correlation-id: 7a5f6f7e-ec6f-4133-3ce9-08d61c4a2a10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB04701CAF0041E3D4BFCBD6D9FB1E0@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(189003)(51234002)(199004)(1076002)(25786009)(4326008)(107886003)(5660300001)(3846002)(6116002)(54906003)(110136005)(22452003)(316002)(86612001)(76176011)(53936002)(6512007)(68736007)(7736002)(305945005)(86362001)(2900100001)(256004)(66066001)(8936002)(11346002)(446003)(10290500003)(6486002)(14454004)(81156014)(486006)(6506007)(2501003)(99286004)(26005)(2906002)(10090500001)(478600001)(72206003)(105586002)(6436002)(102836004)(186003)(8676002)(2616005)(476003)(5250100002)(36756003)(81166006)(106356001)(6346003)(14444005)(97736004)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: FSagRQQEV1mGJIF/6ioh/k9plCA2SshPxKco3EoMRlM2QSd3dmllrhXb7ByARGB+1qqI/bpcSCDOt0oqW0y0Kho1WJ/y0K4r/b3Z1ZWAumMsFOAXOsXvy3IK2AnuBaHmrNDAmKKb/Bvj+xVVdxZz6XaY62UGwQeOgGzMm3eSl3jvWbNEkNaehB8ZObuHBiPlQ25eNfeeGYkoBFBHYLhoHyhdzTPePapJ2hSWdCzvpgTMhvMkqI/HNNB1DTVXqWe63XgbOflz+XYw/q5qyXfldU//TQsgcddB9qoKLwLXPORHjYTmGB0b9TEDPkAny6cpIgQ0fi5oVpHMv8SA13Cuv1LyE3a/3Us8sFC+JNuOaaA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5f6f7e-ec6f-4133-3ce9-08d61c4a2a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:37.9000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
