Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6430CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148842077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PzSTNOmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148842077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeIBRwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:52:36 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:40784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbeIBRTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CzY5SWTv/VC7PztRRV93HfaAPOfYKQ1fc0NTf9NptA=;
 b=PzSTNOmp3Sym4cAGJvWGgYRdfCAzceAQfbryj/MQZE+OleO5JjJNNL5Fiz/WRtJO8AsodTI6X1XNfICvPAEjeqaEivs3vwau7FWMjrtFL1dwu47m0ODEj25/WZApmTbAQFkGmMQLt2/GqLrGSFhdKwZZLBYNbFG/R9kqD7TUhb0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     BingJing Chang <bingjingc@synology.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 024/131] md/raid5: fix data corruption of
 replacements after originals dropped
Thread-Topic: [PATCH AUTOSEL 4.18 024/131] md/raid5: fix data corruption of
 replacements after originals dropped
Thread-Index: AQHUQr1XX2xCjktgrECrVt3H+lNkcw==
Date:   Sun, 2 Sep 2018 13:03:28 +0000
Message-ID: <20180902064601.183036-24-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:Jg64J/9Sx+IdPh2O91BdQD6C+qhLs/B5iHsvtYtqmNlv2h2wkBCly3EcmOw5HgZKvzCBrK4cYuSPQpKWxvojjbbRxxExwTh1/BpTjRd4OAH4eA2DPUINIb8CoMJNw7kUuHDwF0ScZe+59+Hwg6A45BDxT6qD++yJN3dnHKjfLJdsLuiqMLnOQ0ysVey/Q6FfPIz6eSAPoa5K2KwLbvHnO7HcpxwtN4TIgMp0HSn30SWlrXCfl7NDTS3mNDaMSjEYBBRPVPmZtIMCOdn38b6jrPfCCEsJcIS1rQ7qmFYL+Hj5Ohii5kntfZce7WrbWmOG9ZI6LbnvVTSpoa34qKRp/+0AfgBck3nX70GNWRDZcRjJ4WBiqhT0Y/Afgfv+4abVphGL9EH+3qeJNFLS3Xr9Nehi3knv3ePwYTGv/f2aJCzQyx+11tytvKkIT3Lz+yIx+TfgQPU4P6Gn+n9XyfQ51g==;5:zx8lKCs2JKY3xHyTDX4qTC2iz7WfT3VG4BKj9ZgXJtujFWCzvdAXUyUsno/fI6TKuwtOvmVgRopE/pa4l4YyME6Nf3WV80E/PiVpFXWOW9gLBpoLlUwTV0EERUGRlBsncHvw0U8JpNQLdZk1Yh9wz3DsCLH0EHCSIKdo5a4pyFg=;7:x7w60aHqYFRG1yNptTsdUc5VHAmiX9kQ7RKMznvHcNgtBv4e8XR82eGNFC8TOiIY/mP59XfllqG2AKoTKWq3wKf1Knj9DKb9IL+fNM2LmBbMpSfe3dEcFAnwMzNn4LyBFJod1V2OZZTWYaof4nn6nu9duNMUYpJ+0cMZCaI4gDWGYAKqUSN/nyS4Xlg2UHFQI762mC1vlQDDEPzh639XR2OzidRLyXVRVJdEogMwrDQ44X63kbT5uhij+2d+pIEe
x-ms-office365-filtering-correlation-id: fec374cb-c2ac-48f2-cce9-08d610d47a42
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150086B1C914FE7128E89CCFB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(14444005)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(476003)(2900100001)(11346002)(186003)(2501003)(575784001)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: h3N6tjQmzy9Gh5ehoLcX0+H3vmUXy4r2uFmcSVdV8euxP7HomSvH9W50fnq97VEfkiyVNvVtYhxdJd2H+/wyESuu5p6nmQNe9dS6xTvy9r3rjotU6k6un6iVTChUgjPHc1RjiqOaeuzZ2KCRALMokBZJ51MTYH/X+b91w9Lg2vZrzhHwob8rW5z/hKEMLo0SdxjwLDZ/a4iKZuknRq3OfRnNwINJd/wqC8CTTaP81rCnRzdcaNdU8BDb/FzDYUHRD2eG1766JzIeqW9yq8yjF2HENooRmhztI+HRCAKkiUKbYU4u4En9gjGdMGIubtVMBqpDi0YWaIAZsYYfXt2dMMouRpeN+HfLgoc23sHWupU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec374cb-c2ac-48f2-cce9-08d610d47a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:28.8372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
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
index 2031506a0ecd..49107c52c8e6 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -4521,6 +4521,12 @@ static void analyse_stripe(struct stripe_head *sh, s=
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
