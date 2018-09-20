Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CCDC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2167D21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MPNr3lNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2167D21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388489AbeITIaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:46 -0400
Received: from mail-eopbgr700120.outbound.protection.outlook.com ([40.107.70.120]:3328
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388452AbeITIal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/Us2izlAUz8yHFxu/jhr6s+Xi7P9g9Ft+hnCAxUqxE=;
 b=MPNr3lNlYxyEpxwqTithAc+TQod93nrPKUQuERWKjbqUdIimU/xNQ68ukTch9gcGL4/TM/VpOigF7bFIozvhGDt1pIr8YLCUvKsH9xao3WWGWX5g52ZfLcpB38Q5Hru7jjDqPRpU74i1oDISTED/E0HHX9w36xo7Wo7pBmpnrWk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:49:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Huazhong Tan <tanhuazhong@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 10/25] net: hns: fix skb->truesize
 underestimation
Thread-Topic: [PATCH AUTOSEL 4.14 10/25] net: hns: fix skb->truesize
 underestimation
Thread-Index: AQHUUIxkF+qRBPa3y0OCLDs0Dna+cw==
Date:   Thu, 20 Sep 2018 02:48:21 +0000
Message-ID: <20180920024810.58594-10-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:VgQ0TsxHjfcgxXxd5pksUbLpGbtYwrj/3ZuHUwBUV9uVwOEpddmNXyZ9NIK7djoyyETnJ2gTSMd0pIgBLu7OeAmVYW11J0LL9adgbKtaDjCtJx9ExzybW60DEBC56cP/TxRy1vn64mZOQn7dkYWn3ECWyyYOcp6StacRZH2qdr+SU0eTPqk5XXaszRF9vbA6uX+vRzcmOqBxnaIdbV06Y3/QwgBGs7b+yA3KsV2TO8q1arc7/+dtP0+YzoCC9d29bjzdnIDSoLLymhRlJRG9ASRMYX6kh1CruOVOzZT0BQFIBGIdFRQ8Hk/EG7ox9O+SGUPoC88l5hZNA/oJKTczUBdUkHxb4BcrpDp76pmsKEbs5LuDkwIyiN6GsHDTYtNZYG+eqd0P/qcqzY31pXvue6AtfV/YC3RMdQ7RlZb21G1XwK7Xs03IM75clBgGp86Yones8Sf5T8qK5T1qeknZ7A==;5:iJYbZpbBeBWCXyFcuK1XUewz3L+lQjLniDMRfl9Dad8i3fcMBO+HPGjA2SzU07JWoeaQ1iHRGY2ieJspwo7tpeBPak9ezbNjI4NHoNIB+P8O5y80yjfvFoa/dKocmAIey6YYHjtnjJfNULcsW5cQS3x4VDtlD1W52wvIV89sd0s=;7:43PWid9SWxkoqDhILCE0/Z/oVzQkAVMxBmOpzQRGDi79Hakk1/yDU2m1pW9E9v7Elw3wTGhOlMsvzwlpP/5UVbYzv1yYuVCo/yRU/xqRzN1m0cFzTkO5XXz6tXfoLnD1aaZKeOZ/X6bPXvf1KN0v7wLzeIOjs9zhkauIQmBkigIoCXxSF33QLuW8zvD4psHCluthurOH0cW8/5DXOI9O6tfaG8dv1jyLiXAiOFuRBclDnzOrPQ462LEHdq354utZ
x-ms-office365-filtering-correlation-id: edae9cd5-dd0f-495f-b29f-08d61ea3a5cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB011935F0B517B90A6CA27B25FB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(575784001)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jXYmwWaFAF+n5yLF8GtbNzTRtn92lhX5Iz1nBVqx7XytkIvYYm7vju2tZD6Qwi9oUPE6Wr2O8YJsW7SqtrTX6WrSiM8lJ25AZx6rLYzPM1yDYGo1i82eCdmpKmxnt/tXKhx85CWQpZCDcHjwytHwgEHI9Uqy2SaUSAu7gmQZuhs0AymG+rXU8px4qDuzt5nJ9SdXhEUgop6wp3mOEMEG34c4MH318pMjNn4gL+SVHgiWIQous02UP0PG8pnXWuoxLJP+oRpNyqdDgWnY40weg4gb10AnwoUcFD9VTNmoqkh2QPosfDM9aED/ja3zegk1be3y6rsHOD4vg+lDRGhoF0yYk2yJQbb1gK3V3Ea6QHc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edae9cd5-dd0f-495f-b29f-08d61ea3a5cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:21.8977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit b1ccd4c0ab6ef499f47dd84ed4920502a7147bba ]

skb->truesize is not meant to be tracking amount of used bytes in a skb,
but amount of reserved/consumed bytes in memory.

For instance, if we use a single byte in last page fragment, we have to
account the full size of the fragment.

So skb_add_rx_frag needs to calculate the length of the entire buffer into
turesize.

Fixes: 9cbe9fd5214e ("net: hns: optimize XGE capability by reducing cpu usa=
ge")
Signed-off-by: Huazhong tan <tanhuazhong@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/et=
hernet/hisilicon/hns/hns_enet.c
index e77192683dba..25a9732afc84 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -530,7 +530,7 @@ static void hns_nic_reuse_page(struct sk_buff *skb, int=
 i,
 	}
=20
 	skb_add_rx_frag(skb, i, desc_cb->priv, desc_cb->page_offset + pull_len,
-			size - pull_len, truesize - pull_len);
+			size - pull_len, truesize);
=20
 	 /* avoid re-using remote pages,flag default unreuse */
 	if (unlikely(page_to_nid(desc_cb->priv) !=3D numa_node_id()))
--=20
2.17.1
