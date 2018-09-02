Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CAAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFE5204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="U1Bq7qdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFE5204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbeIBRWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:17 -0400
Received: from mail-eopbgr680128.outbound.protection.outlook.com ([40.107.68.128]:38064
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727355AbeIBRWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg/id7omxsP2DmdbUG5BD9WOPT5g/vufIL6iqbN8fNQ=;
 b=U1Bq7qdiamZ0Iyo7Lwsvv8RwHOAqxqqxb/GvGP8/9v+JIjJL0UA9Ev0jkf+qCKMtZ+RJscJBX9kXuRZGn6E4YgIInZQbq0/rRwLm3CF2lsQhDbPganaSktV2aRfwqEDKkzVUghJ/2IV7sikzm7hCXaCvJWx5OSl4nii+EA7fBfA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:06:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     BingJing Chang <bingjingc@synology.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 16/89] md/raid5: fix data corruption of
 replacements after originals dropped
Thread-Topic: [PATCH AUTOSEL 4.14 16/89] md/raid5: fix data corruption of
 replacements after originals dropped
Thread-Index: AQHUQr3C8RvhpHt8wkCx1wDbjT7JXA==
Date:   Sun, 2 Sep 2018 13:06:28 +0000
Message-ID: <20180902064918.183387-16-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:eMFgGRt9RLmSVyCXisIg7x7QTbd60/OMpuYjQxaLeJNiHdcaQNJKuJHgehIgS9TTRS+nS4joo/cr0rt/K1paB335RHfH11MWdbHguukotYt5eBoFS+t9LID58eFjmLzv+6UWq7htTuiClM31RB0xVRJilMiOO2dGTb6131HZxDMegovpRxT23U+n45+Z4DhQZXzwBp1PgMRAHwBZfrExE48YnkBybkmrtuvF4I5lElQXAzf/sJrQC+FPk6sth/ihXO6LPOr87+V5OpF5bcEukJhX4gKD3obowMAbXEFYm2lguzlfoBN0WXB2AXz7M1N9/rX2ynB6ty0EgaCxhUxIlnmZ9sgD5qOjyg8c1v/YlyG7l09PdkmQrCStEP//wtqdTC9v4Jev7FMM68MQhntXkD2/k4ISkRerJVdqQEU2agZWf6NDMA9FCnpWsouv1n4vhqtILX49CjCC7/+meZlscg==;5:GTOePZS8mikaccP6Sy1fv4clmb94RXlpykWbMyAw6mRpxDKeTEbs4og1aHI/t9NkiycbqCPNxMwYtBMg189IbbFOWvbccYiKynwK8JvEYnhev/PjLUbylW3rsqF9hjltm8RvW4XbUtNeQRyBvrc2K8rs9kLDAU2srHYJbEnxqTY=;7:06pDgfGYp1MvpXEpeUZkrd9e17Aew8ortDdYm6U2nbZdlhV0M4QHFsCx5PtRgJhdzPkxWqZtazLx+xoLbgMQ76T9YOzuM9U4UBbKZS9a/Wwo4T+b6g9dXcejrKBfWkNdaDkTldXcufvLu9AxJRbZOva59Fs32hdMkbXrVFsMp4wjZG5pjOEJHYQ9F3ncL5FYF1n3ot4CDCAcUzGjGrnPUAgxZF5FhWVDIcZmw+aXsSzEHPSM6KNBgoPgfjpuCPll
x-ms-office365-filtering-correlation-id: 17b7a7a3-4302-4897-1eb1-08d610d4e535
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB062949B85D965C40BEEC3D11FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(14444005)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: YiHtE/9f75RpHFi3wKpzR287E/we7kevBzGgJOEMSr+ZjQJrIedqKa4dLEfWs6VIJCFk6rN/oOALQiTIVdkrhL6XRQ409fA395uNsOJeriDRg26KIwD7HFa1OdnXVx+9x0/U0ROq5wVbrywaU3a01BrOnPQHXE9ISxBqilnnUrLAqfOsUbKSWRiZGmYWHB4drPc9GYg4tpMlJh95dT2EDmoHjxGjvk3SjL9k2qM6uTDn0esUBfrBVw3sLipnafSxnMft81KKJmDfNv6+5LXTlfOQmnhgjuIdGGxxFLHmTOlq5T9hj4nfbOuqAkxSEviv5ASkEb0fUT2hot/Yfn5A0crioqaDeQo4e8phjBioaHA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b7a7a3-4302-4897-1eb1-08d610d4e535
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:28.2237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

[ Upstream commit d63e2fc804c46e50eee825c5d3a7228e07048b47 ]

During raid5 replacement, the stripes can be marked with R5_NeedReplace
flag. Data can be read from being-replaced devices and written to
replacing spares without reading all other devices. (It's 'replace'
mode. s.replacing =3D 1) If a being-replaced device is dropped, the
replacement progress will be interrupted and resumed with pure recovery
mode. However, existing stripes before being interrupted cannot read
from the dropped device anymore. It prints lots of WARN_ON messages.
And it results in data corruption because existing stripes write
problematic data into its replacement device and update the progress.

\# Erase disks (1MB + 2GB)
dd if=3D/dev/zero of=3D/dev/sda bs=3D1MB count=3D2049
dd if=3D/dev/zero of=3D/dev/sdb bs=3D1MB count=3D2049
dd if=3D/dev/zero of=3D/dev/sdc bs=3D1MB count=3D2049
dd if=3D/dev/zero of=3D/dev/sdd bs=3D1MB count=3D2049
mdadm -C /dev/md0 -amd -R -l5 -n3 -x0 /dev/sd[abc] -z 2097152
\# Ensure array stores non-zero data
dd if=3D/root/data_4GB.iso of=3D/dev/md0 bs=3D1MB
\# Start replacement
mdadm /dev/md0 -a /dev/sdd
mdadm /dev/md0 --replace /dev/sda

Then, Hot-plug out /dev/sda during recovery, and wait for recovery done.
echo check > /sys/block/md0/md/sync_action
cat /sys/block/md0/md/mismatch_cnt # it will be greater than 0.

Soon after you hot-plug out /dev/sda, you will see many WARN_ON
messages. The replacement recovery will be interrupted shortly. After
the recovery finishes, it will result in data corruption.

Actually, it's just an unhandled case of replacement. In commit
<f94c0b6658c7> (md/raid5: fix interaction of 'replace' and 'recovery'.),
if a NeedReplace device is not UPTODATE then that is an error, the
commit just simply print WARN_ON but also mark these corrupted stripes
with R5_WantReplace. (it means it's ready for writes.)

To fix this case, we can leverage 'sync and replace' mode mentioned in
commit <9a3e1101b827> (md/raid5: detect and handle replacements during
recovery.). We can add logics to detect and use 'sync and replace' mode
for these stripes.

Reported-by: Alex Chen <alexchen@synology.com>
Reviewed-by: Alex Wu <alexwu@synology.com>
Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/raid5.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 07ca2fd10189..5018fb2352c2 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -4516,6 +4516,12 @@ static void analyse_stripe(struct stripe_head *sh, s=
truct stripe_head_state *s)
 			s->failed++;
 			if (rdev && !test_bit(Faulty, &rdev->flags))
 				do_recovery =3D 1;
+			else if (!rdev) {
+				rdev =3D rcu_dereference(
+				    conf->disks[i].replacement);
+				if (rdev && !test_bit(Faulty, &rdev->flags))
+					do_recovery =3D 1;
+			}
 		}
=20
 		if (test_bit(R5_InJournal, &dev->flags))
--=20
2.17.1
