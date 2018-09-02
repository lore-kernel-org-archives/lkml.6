Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DA5C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80821205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Abv5vHz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80821205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbeIBRYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:45 -0400
Received: from mail-bn3nam01on0091.outbound.protection.outlook.com ([104.47.33.91]:56192
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727876AbeIBRYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLKjPtzFgVHjUtKBklZAYa0GAj+F+Es534nzfH5cbRA=;
 b=Abv5vHz13ulMbZbdg5E1OZgz/jDPRVhcGseo2vyWAv6ml+vx4NK2KrZXkfhtpGv4SGlZr5gQAgJg+tkKHE+ycrqiBeZufwA027eRmlxRh4TQ3d9SotzHmuysZsehoN6NhWOKDPbC0T+JVUPLpPbuKdhkF2/zi+z/bOKb27MxMEE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     BingJing Chang <bingjingc@synology.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 08/62] md/raid5: fix data corruption of
 replacements after originals dropped
Thread-Topic: [PATCH AUTOSEL 4.9 08/62] md/raid5: fix data corruption of
 replacements after originals dropped
Thread-Index: AQHUQr4SR0yTJhnBkU+BUjw4KODMhw==
Date:   Sun, 2 Sep 2018 13:08:42 +0000
Message-ID: <20180902065131.183542-8-alexander.levin@microsoft.com>
References: <20180902065131.183542-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902065131.183542-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:tCaNl3HTxdgPr1CC0z9/XnRUMtnGLSco+jrPEPg7xoTsf+Jvn1knKyI2sfbKc1bPCKEDGdbL/kcsTbpJ8asrBn1Aqoz/fCulB6u9scKu1Gp10+/3AlXPHT65x5RWet4FEvglY9+/1qNrinn1f2v6/+/GwRDk07omZCpoH4BgJlNsjb8o0N/2E0vCSyExbh9v2IrHsacD5jquEzp9HIInZQwYKgHJgYCRstNdVSWvrwyZukQ72nea8fET5g6eCrSPp/mMRhV/FslOCk6ydTDQQwTr5BPoU0KTmYVoaEVrWba0UXas3y6d5/6ZK56LPlggbJa4+PDVIRJpd2FYJG3TvKiVP6VL+7zqztdG3cnfjHXbYixnOXnx0rhO8IdI6QXI5ZXPieDFtPNAbYsGyz9XYj9IOb+2K80Q8OS1Wvc5DgM2uNQ+8X8xmr0U4xY397nZCdwZBDpjnTzSZx43E6PodQ==;5:7y01TwxNWU5ZMXig2MGMJz2wcqa1nEItM63qiJEnp17RZmYk/L421TM1b7HN5LbJlIjtVP0Gd7Lar6eYfugMo6I2dyZ+9vuKAmnmj7Ze5pfBS+sslOuzwoVqX7wf3eNQAtd5mUVXV6k3LIQQ4djCpOEh4WNbhvU4QP+y1rDWXRY=;7:SxX2a2KU3Yr+x2cEhQesjWj6r7Iug5XhIsHbbX3jz/iAn8UlTWfgBLjf9g6pEddwXZVJSKUIw+8sUjTB1sFFMq/FmLxENKXQD1rIlXQ8bsW6RVXq97NVNCYc2uSU6fL/1WL52FiFlZpypgVi8y8w4YVQOCKuHlc5TMefMaVxUFjjAbE581ay6arebbkukEazFtl+J0Y28U7XYDNY/cZ43S2+NEZcnnMqKxGCxBuDG0yqDXbItdI7Ct7dtQpN8oUg
x-ms-office365-filtering-correlation-id: da1cf949-c0f0-4426-5a75-08d610d53d22
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04690EF9CC215F3E90711BF6FB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(6666003)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(217873002)(476003)(486006)(256004)(102836004)(86612001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PtM/GQTfU7/4Z5B8rRGB7pGY/xKZDG5KV3hsN9h1GXP7pDS6hwImVEODrVVmgOwjSdgscKSUE9BUq+b9Qv6hyv/6YQjPGPTThHTWTbRyJdcyBUGKCBgivZv3HF3PJj4l7QfdNEi5pvKRDCFd4RLiW16bG20ePaqIYk0LQW9SyKPTJYK9Fo6++sZcUZ1tyFPT4ZRoKGr500JcsMcVKBX3q9QsEhdeki7IQcTyPvmp9EYw5S0i5aogSO4b9e8QUrp8VoRiMIM0IUSVTRema18xApt3UAQrY6VDI9c4/2R18FZz/QiUDCvU8g/k2mg/RS7QWlIo/IyBIcvzvx3HWnUbNn/8Uo7S1xsMtrBGM5k/xKY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1cf949-c0f0-4426-5a75-08d610d53d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:08:42.1825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index e43b9f80bb1d..4afc419da60f 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -4207,6 +4207,12 @@ static void analyse_stripe(struct stripe_head *sh, s=
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
 	}
 	if (test_bit(STRIPE_SYNCING, &sh->state)) {
--=20
2.17.1
