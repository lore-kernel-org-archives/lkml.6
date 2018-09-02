Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C263C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97DC20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VavQj2A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97DC20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeIBRUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:52 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:63944
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728318AbeIBRUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etdBows2GtwEbZyBC0HpB1EyqL72HWnFaQljDo+bqCw=;
 b=VavQj2A+EAMZ7AK8eX0Wl+sxOdfLvjEIn0MPJuucle4MugJVDBJqdkF3qUwVNTdq+rp9DIqYI3WIDmYr9u2LUd2NX8tz4sJUv8nnvHVFwlyUmhlp/MlHotL1Q3RXHSxSh1nguuVtaWYm6pnaCvZVj5/cJ3bWBGnJnh1RnVV1uoE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jinbum Park <jinb.park7@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 082/131] pktcdvd: Fix possible Spectre-v1 for
 pkt_devs
Thread-Topic: [PATCH AUTOSEL 4.18 082/131] pktcdvd: Fix possible Spectre-v1
 for pkt_devs
Thread-Index: AQHUQr2GSrv+CdR4skSiz/H0cHc9xg==
Date:   Sun, 2 Sep 2018 13:04:47 +0000
Message-ID: <20180902064601.183036-82-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:idteOL/WW1O9f3tTKJBsjz14rFeZEpJuByMlVizhDlikCxDM34aPqSc6nCbDfUTIce+EHP6qhYIXnl6fvYQfPYbPTkclDGMlBlLsN3sKIdIi4367d0hViINoXxG9PfMkpbfiDi6ipUxm/q9xYCLZzrIxoqKJRG22VPJDPy2Cd6AvqO+m4418MZD+wyyrH+z2oNO+oHw0JP/OEVwYArvlOUqPuuILXiGpJluqkZnqj+pYFjyayhffDx+96JCba1X3zGL39XjW+MTyKT0FxMEu5Tlx3b1OYyDg6G9SfRXt13uYv9n+izB4UGK7W3mB/aIsVVuQPJnGfUePBWMiCXM/Nm7S6dN11fYK4YY5iU+r6V1t0Dx/SxLPG6iA2+HCcRyVutyWUKFPRaRClWcVnQcU5Atc7CejUeVHDoSkxsH6UQALqNz3Om4dOcVuppwXQiR0zt8uKVmxF1Q3L6u+KfEX1g==;5:7z7WeNo08hf3lsJBnQtkU+KDtbaJ0v71yR/U9S1xdlpkKE6/tujVRpBB2k5FkhBbtZnET7nuo8Bxp8Vmzha0sF/BnrUCkplaAYYPaWeWabyXYY0O1wOkPXRLxKV4oJ7qrx+HcNPUNCvQuSzSON8RIWTROlFf3n3GE5NU7KEldIA=;7:hHiIyTIeq5Gbwqx+59xgZ9JGl/S96sCfrY47w4oHdUyE0X8SdLBYrW4khJf+FLwQYeMzjYwBBpVo4/7grjcmKOzCaCtiEiDlhPzWy8t/UNHppa8D+4408mf3YRfG+9wpv9pIIweSzW3K/CN8pY+VxoixLLhlGEBO/8bkG1TcpaThk5FpMiMO9fG3K3vskWuSXBVjnqLpV46j8tTP6/HQUUsW7lhTSmcEw2eU6d+iz+se9/w2GoLsAvmMSSjz9IQ6
x-ms-office365-filtering-correlation-id: b5e3ee76-8420-4251-0841-08d610d4aee7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07416D796E1E10BFCA80847FFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(192374486261705)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(39060400002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(6306002)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(966005)(10290500003)(133343001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lmZ09JFcMRvIZpo/lC9oNRqnG6Scn5tgzgBzUWwPUVcsQWybr2T7iaHf3Cwtso1k0f0qcZIwYXblm4+sGJT2Opm3WvznUr/KHxCCOh2YiajcelR+yPtoQLAbDyuilgMZm+Op0VNzHeb2D49VXLyN45IIXP/q+bXYemcOXr5fq25qDW6iNiHaHXq/4/Wi8nYjNN2lQ4+SsZjuJ9rmXeyJLXA9Blgc4LYy7Xh8YlL1dbq9oGwSuh964iXqQzLfJ3DHNjVczwEUZNytUlr9ayXkkF5dk9R9xjh8587yn0GujRRRf6hwXej88RUpgCpFAMdm+SW9/UlRPh4/57/EKV5zTebrySaMSycTuJps7MzIjds=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e3ee76-8420-4251-0841-08d610d4aee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:47.3608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinbum Park <jinb.park7@gmail.com>

[ Upstream commit 55690c07b44a82cc3359ce0c233f4ba7d80ba145 ]

User controls @dev_minor which to be used as index of pkt_devs.
So, It can be exploited via Spectre-like attack. (speculative execution)

This kind of attack leaks address of pkt_devs, [1]
It leads an attacker to bypass security mechanism such as KASLR.

So sanitize @dev_minor before using it to prevent attack.

[1] https://github.com/jinb-park/linux-exploit/
tree/master/exploit-remaining-spectre-gadget/leak_pkt_devs.c

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/block/pktcdvd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index b3f83cd96f33..01f59be71433 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -67,7 +67,7 @@
 #include <scsi/scsi.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
-
+#include <linux/nospec.h>
 #include <linux/uaccess.h>
=20
 #define DRIVER_NAME	"pktcdvd"
@@ -2231,6 +2231,8 @@ static struct pktcdvd_device *pkt_find_dev_from_minor=
(unsigned int dev_minor)
 {
 	if (dev_minor >=3D MAX_WRITERS)
 		return NULL;
+
+	dev_minor =3D array_index_nospec(dev_minor, MAX_WRITERS);
 	return pkt_devs[dev_minor];
 }
=20
--=20
2.17.1
