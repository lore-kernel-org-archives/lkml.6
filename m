Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1100EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE98621522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Y795wyPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE98621522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbeITIaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:18 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:44649
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbeITIaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9iMYwPYqSU/UZYlsJlFFPZod9SxF7beoUwPMZtdA2Y=;
 b=Y795wyPN7/iDkz55iVurrWClTJgjq4xzIqE3xw1XbmfabRVWYt1XjEIaQmo1mzIogJbiQ6aB9DEaT+WiI2wpgOilfyaKv+WDpp0dvlnGqK2htJExy0nGH8hCczG2+MQxj5ZH3l906H3iMT4NFMPclnBRPEU1Xg0PlzaMMKcGeVU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bo Chen <chenbo@pdx.edu>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 11/25] e1000: check on netif_running() before
 calling e1000_up()
Thread-Topic: [PATCH AUTOSEL 4.14 11/25] e1000: check on netif_running()
 before calling e1000_up()
Thread-Index: AQHUUIxlZYFQ6bFsuUC8qPEIwghlQQ==
Date:   Thu, 20 Sep 2018 02:48:22 +0000
Message-ID: <20180920024810.58594-11-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:KJwGTePXSsNHT3+pkX7NxdA472iHQNjzv17EFogpLQLeFvjP+c+EXLHlsvFX8ZcUtEbGZUmtGuqBQZQNjAihcKtJJLnEhmqy8wvetEMeqxkSduFLc9EFjgX+ahdQXnXU2n3is8KPJtZB8Hz66GztAO8zlwY2PwnB7iaVx5AfZ6QPw5D7xcVKe8l/k1CpFNCECPIVVZ6Uwf4UUuznMlBrop9UbFwdFM81FsFMZNgD9uq/ZuDox3Fgstz8hMWylbbw+IFSLU8vMM4nOzi7LxtYk8g88klXBg7trQov5lGU/O8zvltv6O4xcG4PPn5VFdvuvcZDXj2oCMowFm93MEv1WLTpseLlKZSkFSi7k6ldRUe+BTlssMRYDcLzE96G9l+HPuXMZBFMLpTCAgUDM8Mc+YAXjpoMqa8odeTuqY4wrFgW/nOXgxDKMhmQzVOLSULFawevaCEKeRpUmKOl4TJPQA==;5:JVnWY79L7Ef6gmeI4/64cHiu3vezrmS7L7KoujlfiL1K3Lj6Wd9X+ZIF0zijkZN1DG0dpKFpXwg1N9A610h7JCvEdTuKHOFksV2SpGRis52erUvjy3zd+ucGmCabhULS1OjJbXoB0drfe8McsSy9G2iD+D8Yuz/iwWBaWIKB/Ls=;7:WKhl7xtuDT3zXGp4jKiQJsKj10GmmOPw/1qReHUjAzyyJ1780oGvN13J99lFjjdoHHgC1UFX1lZkr17z+7GCV+Uuz+aBEcwOojXhWNN+0fJm/lbSMiVbmbBMoZvDAN7+d7oINpG7aKkQcFxIhxAgkFZB27N4wX/ZC6sAXbT8xmN3yqlk28oF6Y5Qf/pyvM+zX6xGyq1Cmvq9KhCYou7vvrYXG5IJr0JpRqZi7GFe6gThvBzzko6ouo2ojCI9njsh
x-ms-office365-filtering-correlation-id: 90bfebc2-2c76-487e-7447-08d61ea3a60e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744F94B5595005EA8816FD2FB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(240347492878265)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(14444005)(256004)(6666003)(71190400001)(6486002)(316002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X5D6wxryqw3MHrnhaHG9oX21fzqQhQxgcMdAy+2QNz+fwVOijvFyFuQW/DPQAM58O1QXPJHut/UsC3c5nHK0VH3hD+Mwj9I0fWyx0BVtOBmfe/rT2gkkkf1pmTtfaPMKIFMtSvlZHVeObAqq2cCyxHobMMeBC8FvS4WpxERWnM9QSQUhGAOqZZgv/Ac9slxHnVsBvO2/xwCGPG3JVnaH2XbobZCbjqrievr28yMJTi2dk5TcJzulcE2FgN6U+7fhlnVD7u59CTN+JidfJJ5exgzsUMp5A8livwZ5JTwsD8q6P0IogYj7bWpeYdVHw212ETZEK6m+0If2uQxYfWRavqCFd2rVHGw3oCxgASXc6nU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bfebc2-2c76-487e-7447-08d61ea3a60e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:22.5383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Chen <chenbo@pdx.edu>

[ Upstream commit cf1acec008f8d7761aa3fd7c4bca7e17b2d2512d ]

When the device is not up, the call to 'e1000_up()' from the error handling=
 path
of 'e1000_set_ringparam()' causes a kernel oops with a null-pointer
dereference. The null-pointer dereference is triggered in function
'e1000_alloc_rx_buffers()' at line 'buffer_info =3D &rx_ring->buffer_info[i=
]'.

This bug was reported by COD, a tool for testing kernel module binaries I a=
m
building. This bug was also detected by KFI from Dr. Kai Cong.

This patch fixes the bug by checking on 'netif_running()' before calling
'e1000_up()' in 'e1000_set_ringparam()'.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net=
/ethernet/intel/e1000/e1000_ethtool.c
index 3b3983a1ffbb..d44d3643677d 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -664,7 +664,8 @@ static int e1000_set_ringparam(struct net_device *netde=
v,
 err_alloc_rx:
 	kfree(txdr);
 err_alloc_tx:
-	e1000_up(adapter);
+	if (netif_running(adapter->netdev))
+		e1000_up(adapter);
 err_setup:
 	clear_bit(__E1000_RESETTING, &adapter->flags);
 	return err;
--=20
2.17.1
