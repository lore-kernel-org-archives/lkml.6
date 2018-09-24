Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B12ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D0E2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Jb1aZjMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D0E2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbeIXVKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:10:46 -0400
Received: from mail-eopbgr690114.outbound.protection.outlook.com ([40.107.69.114]:33005
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733004AbeIXUvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqnLUlkYqyAgBEO1ZB/bglXZEDJX4KL8nSKVGwGXq0k=;
 b=Jb1aZjMbhwaKlG7TvAFsy54kXuFv8fvcsPqwDj8y6o/t7bW4ibm4CRoY/O9kLRTYdLTNKzpLIkV66F3rIxvD6HNZrIbF41JRl88SIHtqAa9FDUodhtwUaTHefrJc0spvqFTLEhs4+zdGf5vCLTplnC2zbvFhOyq0yI9TvT8nyaE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:49:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 55/76] net: cadence: Fix a
 sleep-in-atomic-context bug in macb_halt_tx()
Thread-Topic: [PATCH AUTOSEL 4.18 55/76] net: cadence: Fix a
 sleep-in-atomic-context bug in macb_halt_tx()
Thread-Index: AQHUVBWrQb8AGFUzuUO0UF5DayW0MA==
Date:   Mon, 24 Sep 2018 14:48:35 +0000
Message-ID: <20180924144751.164410-54-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:AmHNuGzbmT7C27esIGlLC93FDsTdAVBUMGeNRpko7zBXkqX7mPyR2X/kj7+cc7doP4TjdHSLJOPA/umInQ4lnrUP39uOZBMpt9qJBi3Hah6cVetAUOxOuo9sG6Amy2qUBJS4PHLgH3Na+797pDVJOa3iO1E0TOkno2DmsXOW0rNHasc8iY467uN7afn6XpzZ9VMkE8LOyKIFIXhrCEBADaR0QLH+1b++/fQhEgt35/F08Ix5e1BRJz/CoUJaeAlhfJTculXIVHYpQFAV9769AyyZa5fLc88QWY2w1LOCjASKKtXha8Lw0MDPNxM/+SM/ZZIHAM0G4fdSVOj+JOdT24rQQFgjBft9P6DiKmmB9LUCwNoa4gmqUsrrUW9kACj1wAcoQ9QwXUFERckw/EyOWgQCUcANut0ZolcsQ7canKpjDtxYn15bPcVKXItTOSo9wbBIvSlQletZrzr8svZz6g==;5:qBrGJN0uR0Vdu78xzWv6ly8/Y6gYadOGDcmIarR7k4I0q0ZLKDyNrqUl3HmnfMgb2Hb/C4N3MAXjHEMLk6cXNE5tl0rDrBa/KwFL85cUq2sJLCKFeKSZMhJ0XAyHUnlP/zu9CA3FWbS/zITrSU2X6Dknrmf5tZGhVnvj8ZDQA6k=;7:jUMzdoSqjEYMh/zxATbinnBLtdEV9lU6X2GArkhRLhyWlp41N/W438uoVdbMEo3mS24koRtGCMKgvlnZgoAJICGx6FGuvAAU0g3edXc4E14nhkcn21Maobh9PKzriLjvLrEg/LcB7k2UdNl287MFp90h6m1/NLmGx/HGNDETcKtBLq4bn8p5s6YsNfswSOZQ8i9VAh89zYEnGdVwgiX157BOK0hgoEdqf/wLQvdWKpvW4DrtTan+CQ23GlTETMH+
x-ms-office365-filtering-correlation-id: 524baef7-724d-408a-9a6d-08d6222cdd9a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07448BBC0D644A5D5C09CBF6FB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(11346002)(446003)(476003)(86362001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(7736002)(36756003)(97736004)(86612001)(316002)(3846002)(6116002)(1076002)(217873002)(14444005)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(39060400002)(22452003)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(66066001)(72206003)(105586002)(14454004)(76176011)(25786009)(106356001)(31853002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fyXmrEwmGmUdmtdxikuP3GW/BNSoIZGCVZ30ZoDesudMevVosd/9rdFzJIew2/ppWroqIo/rSYPQj57z0XBxehUI315w6MurCe3YbPtzv9EE+nrwJcc8WyUNE1thKhntqVOvfC2P2pImZlpwriZHtRlqRlmAgVRqk4kwbNhOopRgZc+87h1/W9yfXRGkB0j9EBMPvDhOHDktCEEqn5RHuF32XiHfRUWFsmOR9MdogAu9Mo/LFkEd66YhoHA72bAlSlwRymVVdstxV9BXPomUkU2L2/BNJvRSW//faHR8xKY4ryzwTSYZy+sUwcGhZ27AMLQc8SC9PD5aEdA/eiZFrvY48lJxvF/UYDPFxEaPZB4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524baef7-724d-408a-9a6d-08d6222cdd9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:35.0651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
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
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/etherne=
t/cadence/macb_main.c
index 515d96e32143..c4d7479938e2 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -648,7 +648,7 @@ static int macb_halt_tx(struct macb *bp)
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
