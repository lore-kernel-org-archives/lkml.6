Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2F1ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693F02087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YyrUhnyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693F02087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389312AbeIXUye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:34 -0400
Received: from mail-eopbgr680134.outbound.protection.outlook.com ([40.107.68.134]:2178
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731884AbeIXUyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF2NCr6/eMwb4C1hkFwCDeqh1KxGriQPCdvj9WUWXEg=;
 b=YyrUhnygwvLP/W+ZMD5Wm9XQa81iK5Bg+2qN/PVTm52LYWzwfpb32vYrTssoOImmGxxSLag/a+a7s2YXiV/9uiCPTojhfZp3CFUyQklnxPUFQYhRnPMEhlDNvf31dak4ZpJ+vhfjfJpMCHWbC2rZbVARastWOMISqXk34pnDifA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:51:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 07/13] net: cadence: Fix a
 sleep-in-atomic-context bug in macb_halt_tx()
Thread-Topic: [PATCH AUTOSEL 3.18 07/13] net: cadence: Fix a
 sleep-in-atomic-context bug in macb_halt_tx()
Thread-Index: AQHUVBXkydkzCqcwGEeQfnZO5fHR4w==
Date:   Mon, 24 Sep 2018 14:50:11 +0000
Message-ID: <20180924144959.164754-7-alexander.levin@microsoft.com>
References: <20180924144959.164754-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144959.164754-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:DxZ0VPPwggElhaFwsje1eL9L5V3N0L/LOYi7b32zEJtrzqQRWmnaA8rdfVvLFgJmUFCVn2PLKkqYz9SrmvNIxGTVsx5VYDX8IJOOAQE/7OcLfudlsUPmuPcEfS8jOy5Db+Hr5/IOoRk80Khb3d1ICleu77g8MovodgkIXSqfLdZHBuZmHGaH0YmCnkq2m0Wp+tSW8z5HnFgC0YarmK5Aw2vinQRfnSk7CcUp5jJH7eNe5bz9kMnaEbpsBOuMLldRXgFEEiFHeIcdtkmdZV192u/A35+l/GqBuDYX8p7E+4jupXNpnU9EDCRcqISsnkHqS078HVHVEgA9qNs0WHQlhy9QgRj0jN52RnhdgSkrIxA8Z0YgHsBqBmbayZ0mFeSvvg0r+CyfRx04GdKAmwR+v19xuk5JNgRixIgHZkNTVik1ItQW32pwwqxPFfECITWWMmtYLw7fx4UKadNvOE+S6g==;5:GWAe1Z3A8aZLQLj6axpgpqQLGCbhfY4aDKBsjRbyUCPyriqvNQvLIRZQpZdR1PNFajm9+kFpZJXPdPG/6DoXmINPkz2I9jzqS8rpVkAWoqr24hABxj2NIY7nHbj3OpAWDuorKSZqw5CLQXXfY4vDltyoC8kdqJ8FxQpb/wUd+4w=;7:o0CJOtCYPvcpVLVEAImDLCdV1k1y1WhFJeLf9zr/jUmyOR+9ep7aAUqr0N1OFmBGaLiOwT+P1UdOGud4wo2R7xtFBePBbUOeAy0uM7K/JnLN4VI9je3TlnSIJpdkNYPpnTuCXMpiKSUhLJeG5T3FAiu1Q6iC0vj6G5tBpJuF8Atpz3FQieYBo5GWWdZQjFukWrz+o4+GAcVgOrKbDnI1auUThuMRPUCJLOpBvP/R63EtXNPfqoJr+uoOuofVUZrT
x-ms-office365-filtering-correlation-id: 42c8985d-0f2c-4121-1179-08d6222d4222
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB063160A0FA813ED9119C3F0CFB170@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(10290500003)(316002)(8936002)(66066001)(4326008)(107886003)(6666003)(39060400002)(22452003)(6512007)(25786009)(110136005)(54906003)(305945005)(68736007)(53936002)(7736002)(99286004)(5660300001)(2900100001)(6486002)(186003)(97736004)(26005)(6436002)(217873002)(71190400001)(10090500001)(1076002)(71200400001)(2616005)(11346002)(446003)(476003)(5250100002)(3846002)(486006)(2501003)(14444005)(256004)(86612001)(105586002)(14454004)(86362001)(81156014)(81166006)(106356001)(76176011)(72206003)(2906002)(478600001)(36756003)(102836004)(8676002)(6506007)(6116002)(31853002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TeqV27mTYWu9FPAdjrxEUxlBLf01Wznh8R2+fcGsGZC84VIhGf1cx9WAm6mERdfdCGslF8iu+Vg5gxmjN1GmztcwcE6mLFX3ukk3Xz8QH15gfm9r6yCKzG83MYbqiBr66ux2Tgd/yYN8Cx57SaCusqM9+q+qPJHNU/0WPCo1q5Bgj1HhlUXKapWgBtJZjcm2cqtxphaH2QOx1w0UJkjmpO+keFVME6zgtl7DubEl/vbkUmnDnDHiiYQ2C1w6dSNq0DD+OB9WjROR6ttW5Vt3XW6Tyra/tMzgdarAA2m+FRqGS4s2/cY7kZF5dY4pPNe9ESszRvNbhb202w6olgB8b8Djbiy46xUaVT9qcUhoR0U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c8985d-0f2c-4121-1179-08d6222d4222
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:50:11.2894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 16fe10cf92783ed9ceb182d6ea2b8adf5e8ec1b8 ]

The kernel module may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] usleep_range
drivers/net/ethernet/cadence/macb_main.c, 648:
	usleep_range in macb_halt_tx
drivers/net/ethernet/cadence/macb_main.c, 730:
	macb_halt_tx in macb_tx_error_task
drivers/net/ethernet/cadence/macb_main.c, 721:
	_raw_spin_lock_irqsave in macb_tx_error_task

To fix this bug, usleep_range() is replaced with udelay().

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/cadence/macb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cad=
ence/macb.c
index 4d9fc0509af6..b3e134e53bf1 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -464,7 +464,7 @@ static int macb_halt_tx(struct macb *bp)
 		if (!(status & MACB_BIT(TGO)))
 			return 0;
=20
-		usleep_range(10, 250);
+		udelay(250);
 	} while (time_before(halt_time, timeout));
=20
 	return -ETIMEDOUT;
--=20
2.17.1
