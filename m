Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C77C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0849D21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LPmuwjmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0849D21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388744AbeITIfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:35:17 -0400
Received: from mail-eopbgr710099.outbound.protection.outlook.com ([40.107.71.99]:10496
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387611AbeITIa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZHFb8UmvLVcwVuq0nHDrRE08lImHkvhjUJSQibuPbg=;
 b=LPmuwjmGat6HLA+j7/T2yoUmIETqNniOAltEUmkiTKLE5iFJ68kDOF311I/DZy8Cn+iFkx96+i7qKH/9ELNiImJSFnrZBJyCctJOP85L3IoE/RtlM2zBFzWx1qaXuXBKzOOIQCgKcIR+5bDyJkyPIcy3KdbkN5G4MIgsxT873gg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Thu, 20 Sep 2018 02:49:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Huazhong Tan <tanhuazhong@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 05/14] net: hns: fix skb->truesize underestimation
Thread-Topic: [PATCH AUTOSEL 4.9 05/14] net: hns: fix skb->truesize
 underestimation
Thread-Index: AQHUUIxycpQfVbrwXEeNmRL0H4LeEA==
Date:   Thu, 20 Sep 2018 02:48:45 +0000
Message-ID: <20180920024838.58666-5-alexander.levin@microsoft.com>
References: <20180920024838.58666-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024838.58666-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:R8pZdKu734e/6zl7AA2ZkVTqPPpRsH+kAGlB2043C5uMTUoDvqe1ei8WlhyVMc3XDgnICVuGJGTfzr7BBufhESwojkuaNcCI3OubakwLQ/CQ1kxUQfF/Ie0MYzWyVR6iqsjbhzHtfrrdPHi9fN99inaHabHCsV/xl2IRyG8s59aWLmw9ErX8Kjcs/iBB/r0F/vzlMAmD0j/3l/iHTl8/SIAMXgIw6GXJj6TWAK4QKcTIFAMH1zPwsCj0/9JA8QIPes2H0n4hXBIPtOq5dIlW6L+58mj9TC5TMPHDz6cMNy24IWnRnF4pLw6kA/jfESHwn4dFCdKvRENzSD8EJLI05XGi28ckUQFn9lF4EESKsESqJpINkEwjtLoBnOXMPQNih0v9PN5mFVs3LaZL0eq3cDcpQMgDKruZA9NgHeaxWf/AjI7C2R8wHZjtoEJf/zU6hRaCvRP9JHoJaRP+LbW3dg==;5:xCaD3gp99qPRrWgg4ffPN9mVnVQVhvq3AtqlNAcHEHmrbl7OlVFGGrtMLDCdP4cRovaQ85X9Fv1g86rQrUdphMCT7GnQsyFTzkXccNri1w8sfabI5lGYNw97eqscmo2IasxXn68ZQBwdUuJAy4g0m/GSv4TYWFn4t+FOyDnOi8s=;7:zAPTDaazETR2isd8QYXwIjhM9wPnyG97PmiseV0XCDplz0U1F4bB285PitZw9Ymn8/QT3UTw4p3l49bJ4Ah+kgpTrokul18OrtD51YCsgXVh88px1KF0le8YnPJZQVcKDALB7Kp1mONFpizh11vc3a+JeHM1lfus4rVORrMVzXaoWS/CSDCFZgdZTYSXm1JhOzzYJqkhYzuILJl+g0DlWQdqBrZP/ulZ3gPS1ugifUzQ6WBCeaHvc5RDHGbbXIDA
x-ms-office365-filtering-correlation-id: 9e7b1806-cee4-4eaf-6975-08d61ea3ab9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
x-microsoft-antispam-prvs: <CY4PR21MB0469AF7298392B4EB66B66D2FB130@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(6506007)(53936002)(2906002)(10290500003)(6512007)(478600001)(97736004)(8676002)(2501003)(68736007)(305945005)(99286004)(14454004)(81166006)(106356001)(7736002)(36756003)(76176011)(186003)(5250100002)(105586002)(476003)(8936002)(72206003)(486006)(2616005)(11346002)(6486002)(6436002)(446003)(6346003)(81156014)(26005)(102836004)(86362001)(54906003)(575784001)(22452003)(86612001)(6666003)(3846002)(6116002)(25786009)(4326008)(5660300001)(316002)(10090500001)(107886003)(14444005)(1076002)(66066001)(217873002)(2900100001)(256004)(110136005)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: yK5/nry2jmmY2d3N861VfvS25FfDkly/ZFxMdc+Jk/lDW/uc96bb5Je9rW/bzOGi6SCoaMyoWVm14zfb/FKhELqccU54cE7wIYVZU9lX28JmmzRu6/abIS0TVz0/9Co623zU1KDB0J+soH2KTywJfdYmjMsyko/hZk1+Xr6NvQw4ekQEXA3cEBM0WfDPXVNhMTPa2Jr9h7nZNbeDs3TBWVDqQzxHZVsGkhsmbaMz9iMSTca239yS1kEbEjtQoSK0f0jyMHeBo+9aiaX5/ZkpyLYntCTgbKQn6m0SOBLssYgXgQ65KhF2n3/u7zFrikzn448d+YR6fPkjFFOksmJC0ITd3NLNR9xAUbSCtqHZHag=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7b1806-cee4-4eaf-6975-08d61ea3ab9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:45.3662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 111e1aab7d83..8a2a07e21324 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -529,7 +529,7 @@ static void hns_nic_reuse_page(struct sk_buff *skb, int=
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
