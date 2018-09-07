Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1310BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955C32083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eU7dOgGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955C32083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbeIGFQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:30 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:29216
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729775AbeIGFQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWaJBhojwoEx6/I+pJMoOFIaqonXzSkZq014e/MT+dw=;
 b=eU7dOgGqVgQHC1WEJfvazFX5/nQOGY7o640gTHN9VQmspgaKYLpeVaBagiSeA9Gwe2fUDvo5BrVn/xuIm1pNP4hqzsp/v+Sk7HHESgFssH5k0fkoQ3ca1qPqXVfkwggOwclDGSpNf/3rAiHejgEXFi320oEU/TtFwOpTz3B8UVM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 22/67] IB/ipoib: Fix error return code in
 ipoib_dev_init()
Thread-Topic: [PATCH AUTOSEL 4.14 22/67] IB/ipoib: Fix error return code in
 ipoib_dev_init()
Thread-Index: AQHURkL4JUSEF4szYkihgaKVT3cJZw==
Date:   Fri, 7 Sep 2018 00:37:35 +0000
Message-ID: <20180907003716.57737-22-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:vpEbYDtKUmY9frl4PNnNujltMs1zE7vlWJEOeiIvvZ1px7D9nFNGhKI+2ggeTQ61Za04FgMkFsPHr1nHptRBdymBFQa+HCkRDhr3y4oBHd372KO9gGdGaHwExgufHhyaWyO0vbMd+nDriS/OStp9DGqP3S7TjtcujbMF9epM48xSQWlpKfscqtU+s5p1AmPAqeWMSenwjhNKUajtl5eUBpnIpcJTn6N+UEzejE5gIndpBTAnCOxJZdCU1h+knpnGYD65beB5srIR0Z7hagsyf+LJOzrlnseLx3WQqVk+QXVjvpLtFQn+IrMseyZki7c9CZ6IPl0YNlOPDdbuCGerfLz+FnyRbXbAF+nefuziS2Eqw5FWjBSIeVlsDuNsLQzS8T0I+iJEHNE9XpYzVFzdRnMJ3oPZJW5Fewqtq2CTF0NeI7Coy5Z8xwMJdC1ht9kNVn2fbo4IhphgmNJEZ3YXBw==;5:vfCcKVxLgJeQw8X/581gc5qEUrZ/uEwqx/iDxXDCRS+3xLXIMODO0W50ROsEB5Jh6zk5xBJF7HsurCLHthRckIetIDQbye1lM0PqfadzJvjax31LIu263FTjj7QAIns7HJ90jk/H6KYbbEBanohootRM+5oc+DSxevyj1JJJzDY=;7:6g93Ncmz+BMIIcIkpBX+w8Jhtc3CUlW7ewgpNwIT5rrvPEw2SQ0kAPAkMD2b+fz0IR8zwYz/4aRxcPNutu1uITXOsFbieQ4YdHTRYFBZUVcyHyaclIMbbS4r+Zx4EL+z+c+jF6Gk3VarAtHPgLgkGyx6MRbRAfcq3XiWdZUI03hFW6zhXCSy2uQMT/YT5ryCBUMxCY+4V9o3g87+5vNH2KGg+r+YlA7KvLNbaWcBhpMs9TmYMIXnNQavr5+RcLgr
x-ms-office365-filtering-correlation-id: 9045209a-1314-48d8-18c9-08d6145a3614
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840AE9A1300A8D0B319962CFB000@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(66066001)(186003)(99286004)(26005)(8936002)(76176011)(102836004)(81166006)(81156014)(5250100002)(54906003)(6506007)(110136005)(11346002)(446003)(316002)(476003)(2616005)(106356001)(6486002)(86362001)(6436002)(105586002)(86612001)(97736004)(486006)(6346003)(53936002)(6512007)(68736007)(10090500001)(2501003)(1076002)(22452003)(6116002)(3846002)(36756003)(4326008)(8676002)(10290500003)(2900100001)(25786009)(256004)(14444005)(305945005)(72206003)(7736002)(478600001)(14454004)(217873002)(6666003)(5660300001)(107886003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: pduEgBcTSFsprH8+pQ2wfxBZhprnnT6KkhCi/d60gG4a2mNmPGwpJlh1An3q9QRbNrFRKjQfVsby50YR5A8coo38AUaavBt8UyDq85rPABkpZzBsUZ4OCAOWiI44k5XwbPjooOmAkQntBUMpPspa/WATy4yz1ykgemYcEdWgt/f803sIlW/lME6q5GoYqNHNa62tGoDImp0KIrcPCwnbCeNNJgQ51lhWhn7/jpEka4B6gvjjtiH+J61CaMoAvWPzLe0q3ei9plYYwZmjekae4CcDSuGzjh5zWb+sVJMfScaKkWUwGHFW4GPG7+VcVu8U8jrZFWECA686wozC9Zpl695hVwbZrOB793fNXAxTJtM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9045209a-1314-48d8-18c9-08d6145a3614
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:35.3729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 99a7e2bf704d64c966dfacede1ba2d9b47cb676e ]

Fix to return a negative error code from the ipoib_neigh_hash_init()
error handling case instead of 0, as done elsewhere in this function.

Fixes: 515ed4f3aab4 ("IB/IPoIB: Separate control and data related initializ=
ations")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband=
/ulp/ipoib/ipoib_main.c
index 6bc9a768f721..e6ff16b27acd 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1752,7 +1752,8 @@ int ipoib_dev_init(struct net_device *dev, struct ib_=
device *ca, int port)
 		goto out_free_pd;
 	}
=20
-	if (ipoib_neigh_hash_init(priv) < 0) {
+	ret =3D ipoib_neigh_hash_init(priv);
+	if (ret) {
 		pr_warn("%s failed to init neigh hash\n", dev->name);
 		goto out_dev_uninit;
 	}
--=20
2.17.1
