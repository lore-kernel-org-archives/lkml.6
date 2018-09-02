Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8716DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CF720652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LR0RbUBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CF720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbeIBRgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:36:19 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:54352
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728994AbeIBRbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+IPxe3XVuC2YXoKyU9qYLlKgCGuar3yA22V1K/eGNc=;
 b=LR0RbUBt8pvwENKNUasVAEIvfJAXjao+T0bJcngS+0U4kCFMQNJIvK8Zx5angNMlr1juInu+ZOKR4L9PU94GjYg/iKnG1o8qS3fpGjfysjGpswWHbGFUU5SJ+/Xuv1yvQYmkVKuvWHoJkFd+7Ma2sUOQgCGPF1D2lvhB/lKwsRo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     BingJing Chang <bingjingc@synology.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 07/47] md/raid5: fix data corruption of
 replacements after originals dropped
Thread-Topic: [PATCH AUTOSEL 4.4 07/47] md/raid5: fix data corruption of
 replacements after originals dropped
Thread-Index: AQHUQr8OvAmvhpvyCECWwfoaovphmA==
Date:   Sun, 2 Sep 2018 13:15:45 +0000
Message-ID: <20180902131533.184092-7-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:4rHJsYyo6iRtw5ezYU7C8Uh21x/SZIMJRva29YZJYar+si5dyep3SKpy8ZXFHVSfhes74ZO/WTJmqBjIm16H+EJNeKz+n/8wXBLJ0LZ5vvVrHPJshTzkVTWogc1FM6IzcpTQDdXvskcqadyFHDqNq1CDxW3bcr0Hc7RJAfuges3YWxlHDQVdPQncEqEhiR8qQJpM1GZ4jKAOwYnKpWWT39PKMCNDlobESQWcUyaZHf/Z5sHxeBGMtN7ybqGklMR8TdyQXpBCecUnAou/mGfyHhixhzTjQtuHMef1JsYEXZGok8cMpcB78pNooHq3Niqbsp5/pbK9dScPucE+nWjGEzRHerwZgRuOr1woQTniRF6/9Y35BWUsVWNKBNvuCNvGoRZLWD8K5vQFwWFgoney3xPShyODuV5Tbb4PKyzmo78uAfYA3hXSWzpV3o9vufZwvphVni+oAcSVS9JF2V8JhA==;5:GfQb1FjhO8srndVzn+DnGVF8w6LYcU/DQTYhxgaLOnwKdhhIsgdcx6ifvaeGU9TWFEnObp43lav8csumEw/XoZqMp2hB3bkvji/2D2PMw76IfxhjUu1uCqeUpUblZUkeoeAvmtYpqQgxTZkFbAOFSi+934YwqEJl268yBaPnCDs=;7:VGPDC3fzlGSnKr2a7s7nJEH6ILWUcY2jXMXW1BBXLZZYbTOhOTvbI62YS8iJrMgWB98MkPokZmjA5bCducBVf0lexoynGK02kE5QNzXHVCRnYUt4mcYFavZzo2znjcwEwDDnCmiS0NYEf9BsHCzHIYHdvgYjxJiJ2n8BJuws93mTLA3jhETICl+0myd9GC7xDqf2mt8Y9bWxkfyKEE3MpiXQidiaZ+PS4QXhiYAfJ5geAyW/81E27o6UAVo8cDZy
x-ms-office365-filtering-correlation-id: ea727d8d-e383-4425-de0c-08d610d63140
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184CCE6891B755C898715F4FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qdN5tAzNLNq1kGYpiPKfxNChunKQGkX7Yw7rjWbPfxZWqQ966dZ2lnWPDRmDtfE9QRnwPN7R2ndno8YyF/q2LexquZ0Ws2I/rlhitF0VP+M+cH88vtaKg7Gy4fmMxHvhrf8L+Bka5dMTm26nAWxgMHS4x3QsmRc1gwhpriB2Dxz3mXmwFmXz/a6SHpL5L6HVxHYFBR/sxFQp/yVcUjbDfTuvz01nKyCkfMQSB3a6CPqvlYJMrYkF40TBTIamexpECrxK3h9LzaZRo2z7KLuKPrUQD1Hg4CAqp3VFH7MmLVVdvPwWUTmqEuG4KWvADkI0QpsfJArCJHSA61/wWPz99/Vvq0bvgSiDQUf2rC36tm0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea727d8d-e383-4425-de0c-08d610d63140
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:45.3162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index d59b861764a1..0841d8f10a58 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -4190,6 +4190,12 @@ static void analyse_stripe(struct stripe_head *sh, s=
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
