Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790E2ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248BA21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IhHFuiFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248BA21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbeITIbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:31:20 -0400
Received: from mail-sn1nam02on0096.outbound.protection.outlook.com ([104.47.36.96]:62018
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388614AbeITIbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4I8KiV3s+HqwYeII1CoJOqF6M1ttiwTc3/fMuM6wYI=;
 b=IhHFuiFEInYiIa681V+7tX2VZfnWE4zw/0oMbK6VATWw8IwsuNX8BZmpeOc02mf+KOcfD3+4Of99Mw6EmcIoAAz6v/PLs6cPF5SRncvOXYXjPWIKeP3aCFMoIzzqg1MD9HKCNxWngULSmkJFajC4fu/0RePlrXa+3MqY/696B1g=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:50:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:50:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bo Chen <chenbo@pdx.edu>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 3/4] e1000: ensure to free old tx/rx rings in
 set_ringparam()
Thread-Topic: [PATCH AUTOSEL 3.18 3/4] e1000: ensure to free old tx/rx rings
 in set_ringparam()
Thread-Index: AQHUUIyYL/Td5HTnTEeJr/8BRweN9g==
Date:   Thu, 20 Sep 2018 02:49:48 +0000
Message-ID: <20180920024943.58781-3-alexander.levin@microsoft.com>
References: <20180920024943.58781-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024943.58781-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:B9t+UIUPu8fnkwHsr22GqWo0NTQ7P8oeHsx47CyTnHKYKDBNyqIL8dQwccQ46oJVWHwIZRgK5VAhC7SB4jBQNZ6kwTAc9wfH9eR0yxX76DtvjrZHZNlKussUaMhIjRBrcsVVFH4jCsbcrU7wlLEguf7YYrwRS1WXK1WY4YjHarDZEdixzR50c/NneK0CIYsyVcenV/MgU6zMQzDAq8wt8lO85OgC+zjP8R19+Qvnec+uVVhthUKG2pvzg+Q5/EQ53xevqAX3ZgY6VdwLvW8+25c83Tfn3CMcA4MUwocl2iCBP9zzJRRGq6sahScK+Y7NivBltyCLBb4JWn8hr0xZxhMRBB8tOxC8WHrPtUaLZv2cf+d3ZChlUOegGN7e444ZjwxZ83i2OqmUi1SLWkwReUtKcMdkOeb6ol/vTrhyKC4q//wJu5BRPig1iiiTsFO+lCKQoDGA3tyiONUDPQIy9A==;5:wggqOWtEzmXp/kWa1/VSd3jI1yODcKv4A6b1qMWCY4Po+qOiOdhvQGW1y1afHSjWSGMgBj7Jcvd1YS5JfokniB00RRT8DNH2AG7GJfc2GZwAj0hCmG0p28+Hcz9BZvLKd1jv+0iRHQgPCov9VR53JWmr6ReZrhtpjaSLUVEc/G0=;7:eScTSegtD8EXkSJKNACUOk/E78i460shXTzsTKHHOeao8alIhfWfKwbnD1mtkacNMj8gCRZ2XLeW9mndi7OGscIDwMLeGypfnocCXkbA7Fw++W0zov+MUcukTBIlfiw5qxWW1n+Ioax8TbSyJ522/qDEY3PSQdd9rvRwCF4lDtgwJLv6GEtYRtQe29myUAwZehy/uHRETrFx2Tb+N6d0pklPgC3B+gXKSV56jrGfX3lBgzZg2izXH0GaIOeQZk0E
x-ms-office365-filtering-correlation-id: b41f0d24-b603-4e15-cc6d-08d61ea3c7b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB08550B33CA2F2EF9BC6926B2FB130@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(240347492878265)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(136003)(396003)(376002)(189003)(199004)(2501003)(186003)(86612001)(10290500003)(478600001)(2906002)(86362001)(6666003)(106356001)(575784001)(3846002)(5660300001)(2900100001)(6116002)(8936002)(105586002)(1076002)(53936002)(14454004)(7736002)(305945005)(81156014)(81166006)(8676002)(6512007)(68736007)(72206003)(6346003)(107886003)(102836004)(26005)(256004)(6506007)(36756003)(446003)(476003)(2616005)(71200400001)(71190400001)(486006)(217873002)(66066001)(11346002)(97736004)(25786009)(22452003)(5250100002)(10090500001)(6436002)(316002)(6486002)(110136005)(54906003)(99286004)(4326008)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Gg6NKxVV99udFjNinEJjXe23Tl3V2LW9lduYWivjUhXsv7U5hYTmChetk+nzoRuLli6KdXTpAKcaBlRLPlyW2hTnrB9QrLIFIQPdLldcJ3JNmGfhe3NHYjjUaZoO+Z72CUyBr+kGLdBVA0duvP/FtzgrvQX0ETR+uBbDZ2cYd3GbwSvx2ZpSXX4nxnSc/xH5Wo/op9CMLb2c7zxAUg+2H/eSKGfO2Cp4Ve0+/tUWr/V6btHMt1wtP9hq6MQdQkoybYOJK1omXq7qzzmD3yE0s0UozeX17c1sRLsYdTNKMSs5mVIt/466PpeOv+gZP5EGTnNsV4h//Flzzzl2koTLDroJTMCi0jZDC+pb8GBfR6k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41f0d24-b603-4e15-cc6d-08d61ea3c7b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:49:48.6311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Chen <chenbo@pdx.edu>

[ Upstream commit ee400a3f1bfe7004a3e14b81c38ccc5583c26295 ]

In 'e1000_set_ringparam()', the tx_ring and rx_ring are updated with new va=
lue
and the old tx/rx rings are freed only when the device is up. There are res=
ource
leaks on old tx/rx rings when the device is not up. This bug is reported by=
 COD,
a tool for testing kernel module binaries I am building.

This patch fixes the bug by always calling 'kfree()' on old tx/rx rings in
'e1000_set_ringparam()'.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net=
/ethernet/intel/e1000/e1000_ethtool.c
index ab3d94d0c731..615d2145f411 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -646,14 +646,14 @@ static int e1000_set_ringparam(struct net_device *net=
dev,
 		adapter->tx_ring =3D tx_old;
 		e1000_free_all_rx_resources(adapter);
 		e1000_free_all_tx_resources(adapter);
-		kfree(tx_old);
-		kfree(rx_old);
 		adapter->rx_ring =3D rxdr;
 		adapter->tx_ring =3D txdr;
 		err =3D e1000_up(adapter);
 		if (err)
 			goto err_setup;
 	}
+	kfree(tx_old);
+	kfree(rx_old);
=20
 	clear_bit(__E1000_RESETTING, &adapter->flags);
 	return 0;
--=20
2.17.1
