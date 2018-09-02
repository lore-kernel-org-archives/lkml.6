Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619BEC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1169A20835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E5jyF3FK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1169A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeIBRpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:45:39 -0400
Received: from mail-eopbgr710105.outbound.protection.outlook.com ([40.107.71.105]:27886
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728562AbeIBRV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsSaO7lCql/1CafQ2dby/g85V8zgTaXduvJqVi+jsNU=;
 b=E5jyF3FK4NTv0ezwAAcdtf4k7h847y9O6TIrQjbDeLvXYOLuZbbdL8XQgbu+g8s7SGv0ZZjJ4H1eqz66X+2sGAaFgglPRoEWnUfY60/WolHKyV/xcgYeyRU5zSxgCrqsTxVX2BBhcXVNmm0qJ8hav2kbXp/O/KGgANPKCvmXnJo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 104/131] f2fs: fix to wait on page writeback
 before updating page
Thread-Topic: [PATCH AUTOSEL 4.18 104/131] f2fs: fix to wait on page writeback
 before updating page
Thread-Index: AQHUQr2W5EipNDkfSEy+TiNah6gInw==
Date:   Sun, 2 Sep 2018 13:05:14 +0000
Message-ID: <20180902064601.183036-104-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:NLhjcrXo5VgX7ZYe1WrTD4xxaKYz/4ZxmvS88DjFvSDcEiPPaOx9mq8hRQItctpt740az5rYw/FdHsK5feIlIcZazwAS8gcryL93sNoduIqjYHbRkNmR0H+rO4ZihSZ6qkGF1qhRMT6fNiUJL5sXUAp2p+s/izDEmGOfJYvULjWigyrtE7CAXz1fOMlQPQk8/UMdXDIzP5aSLXx3FYcUpA6nX1P2YRdeyIGRqj/BT/MhEh4kwRL3oRDr7Kggdf/UMWf6xz/GFZULtuA6ctukHC36CLuOcnq783xB/wS8FrbFdJegk017yDrtwVbuaoogjqaE7bx1KtTNT1p3d8nexL6su8PnRsFU2aZLMZeKylvwzOR1AUWCVHyjuzRj/homKmICwV4Pes3SvgmJzRLs2tq5mjc+qseypAnaxT/tgl5osDczaBhHSv9vDR8haWPzZfl13MgZ7NLXjDnnmaKqkw==;5:jvrdtisxPF8zQo6sZc37kWkEaA3evm/IqS0cQG4pEyKHFmJyujZxko6TE+naeQQLJWaC2PgFIm5Mp9tk0foRDhBKpLDAz9gSlZ+U6yCGH79MQstuaSIvVdlfci7T5VhDnPDNCWHJBKAE8T8br1tESMXEs5G+SYeQQNozy7FS0+Y=;7:S0471FTvKYlVoeVoRkQfKrpbvf7rBBDzSA6SWrTu/zmAvGDX5BgfkWcqQrh7B3ivryRNVF1Oy+uEeQ/+ItJfytiCYYSvQxOHDBOc+yM3HlG4yDIZ1fOwpGbknhCNd132YNZsv6LDqUGoofqwoO4JMtUGG3AJVhCsBMN7TopISPk7wiesXiKgJpZ7u0Gsxl1Xzl0MOcZ3eaGqkcb0Se5Qi1ertH6OtVxgNu3UvWW0CZEKOn5Qr35O5c19zba1ScHj
x-ms-office365-filtering-correlation-id: ae236dc9-e9ce-445e-e2c9-08d610d4c642
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184D25431F8A6C1A5FFF784FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(107886003)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(14444005)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(575784001)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OPgaHUfZ50tiF59x5+UKHI14HMANJtgzGkYQ8ufYgh72lpjkshj4k0+K3ExFlZ/6hV41FMFRhHrdLDzPwnRmrfiPIH+CIkWrWvKMxEjj+fhvqhclRuiRZSG2BwVKRBiPk9hRzPU85+mSX1HssZ+v2rKNrYr6Dvn7503e1qL+5mr/c/SyJ2phNM31/VGZNIo1Y35VSLTD/Cnhyz2LSLVi+1U7zVLq05S8QfTX+GG91KvR1eaHQTm2aooQMHO5WPLeyu4KhnHy9yA8p9cmtFNgqKWhlL1/L77NphMHcfvtEh6PjrqMFA/SE70+Wr8k1fm2niFiBs4u1tlNsvRPVC/Ft5HwCVuEDDEOyMpv7Bcj9q8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae236dc9-e9ce-445e-e2c9-08d610d4c642
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:14.1711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 6aead1617b3adf2b7e2c56f0f13e4e0ee42ebb4a ]

In error path of f2fs_move_rehashed_dirents, inode page could be writeback
state, so we should wait on inode page writeback before updating it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/inline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index f882de2ede95..2bcb2d36f024 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -498,6 +498,7 @@ static int f2fs_move_rehashed_dirents(struct inode *dir=
, struct page *ipage,
 	return 0;
 recover:
 	lock_page(ipage);
+	f2fs_wait_on_page_writeback(ipage, NODE, true);
 	memcpy(inline_dentry, backup_dentry, MAX_INLINE_DATA(dir));
 	f2fs_i_depth_write(dir, 0);
 	f2fs_i_size_write(dir, MAX_INLINE_DATA(dir));
--=20
2.17.1
