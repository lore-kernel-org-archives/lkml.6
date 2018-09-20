Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E266C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B3221521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WlWjjcS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B3221521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbeITIbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:31:12 -0400
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com ([104.47.32.108]:32896
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388571AbeITIbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCPZMkgNFvHun/2LD9ad+dUEtOPtVqRqmZkYctZUM4o=;
 b=WlWjjcS1ljg+4E8V93HiQCmYP5KG9O5njNfctbld4HfmR+xCzob1X07iOZzLsmG8FgEplHTd1UcNO5gBUKIVgM/P7MBpVq8GLI39NAgPhhN7GvuOyehAFreXTFVYW3vz2vQZuK3CPT3wTCFUFBn5q3QuESip5sx5/opNw3Kl4wM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:50:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:50:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Huazhong Tan <tanhuazhong@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 2/7] net: hns: fix length and page_offset overflow
 when CONFIG_ARM64_64K_PAGES
Thread-Topic: [PATCH AUTOSEL 4.4 2/7] net: hns: fix length and page_offset
 overflow when CONFIG_ARM64_64K_PAGES
Thread-Index: AQHUUIyREARvGtaRPU2PwgljlRe/9g==
Date:   Thu, 20 Sep 2018 02:49:37 +0000
Message-ID: <20180920024932.58727-2-alexander.levin@microsoft.com>
References: <20180920024932.58727-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024932.58727-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:clAzksz8Ic3oMPQYBn9s1fCJscGzNwGvL/+JENpIToO6Mh/jrNZ4Gmw9IGtWgVtGNBeQtlN2HNZ9gdK8dHeKqhxEJ/AFMKgDC07Luj1jkmfqjdVkZIAsiFCa5EZcKRoqnDZTGXTJhGZ10U7dh/FLhXJa2xhe8wA6bpiifVJvFDA/rgJHWKaUCqPOKZD57K3XqK3awRdqKlb61DSJv/KUBTX5nrn5EqciWKHCRRfbMzuOy9KUG5OiFwUtV1f1qaoyMhfLrBG5tX7EJkV0cRqqlZj7f7MZvIaxpi5dJTDc/C3YLUXrsBxtNtkJYU0DesELqdRt6c27WucN3ckO3hSAD0PEdBPwFpzN68ax08vAaA/lG5Q+5s7pVxBcyoj1n9EgIAz13Bq8pWU2qJDVhyuvVV2/FW3iZ/2fV9f7YrgBgNeajfE/A1pnj03p+XxG/XSJ3RqjH3GAUTMEKZHUH1hnNg==;5:qtiikX/xGQ5VsBIKIWgHvrpeJOSmfQU2vUs3XBXTqBBg4F/7RjEPKzEio519Bt+8Na4NkXTyVKjZOq0tNhOnduMXyy2GIAfQ8x5FlskZoFm3uwyVKSJblIjHcVbXR/wsfl6rOz0VWt5CQe0HVnSeqdAuJxrp0I/Khkcy3fCPbd0=;7:ax3uAwy6goUloIwCGfuyxUs5sLsFsHLgJylz9IpGPzLD8eARWAqerePkaxMXlReUIpXtGqOrrL+ZT3458mR6RgdUdapV+qCMrO7Tu28YrHBAmKVYGD/O7L2WJ0QpL4ngu9aZAqMaPXaYnb/E5KYTvx46g1J4djPI927ZKqJkAXkCJ053WDrx9/85jBUvskF62VBwX/TvAP57edXU8ENZ8rzpSBaTRHW0U61+MtMaf3yHcAd6AwczPdMtl4PEezhG
x-ms-office365-filtering-correlation-id: f0bcbf66-ccf4-4cb5-0858-08d61ea3c485
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855800470C709531691ADCCFB130@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(136003)(396003)(376002)(189003)(199004)(2501003)(186003)(86612001)(10290500003)(478600001)(2906002)(86362001)(6666003)(106356001)(575784001)(3846002)(5660300001)(2900100001)(6116002)(8936002)(105586002)(1076002)(53936002)(14454004)(7736002)(305945005)(81156014)(81166006)(8676002)(6512007)(68736007)(72206003)(6346003)(107886003)(102836004)(26005)(256004)(6506007)(36756003)(446003)(476003)(2616005)(71200400001)(71190400001)(486006)(217873002)(66066001)(11346002)(97736004)(25786009)(22452003)(5250100002)(10090500001)(6436002)(316002)(6486002)(110136005)(54906003)(99286004)(4326008)(15760500003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jlrzrv+kG2J5XODK9itjynSDG4eCbSJDqLocquZwpi/X0VsWRnSCb+TioCEcPfVsYAizj3ELb3LKSlgb3S4sGQNYUBh/FaIdn64Vg/rFJKkQn77QPujewVMYWxZ7gsrgmQM4XqPz0IdL+Db1vSYGvNc/N9cKoCIIVjtET3ncA0wiyfhAOWdpiM+c3hr1H2jvvvmEysf957q4Y2wHc1ExAi1aicrFqEQy6OCCsXiHE8sifJorKqJ1fYe6Lby7sOuwmfw+NxVkbRbrVk7pH2oC5EAeNuDONJB1JUmvvLbSHsIJrqabm05TGn1FYQYXI/c2/gZrnbuhJ5jHbbC0trCPPJ7S6HKM7BxfjQDhfaGv2Ow=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bcbf66-ccf4-4cb5-0858-08d61ea3c485
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:49:37.1468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit 3ed614dce3ca9912d22be215ff0f11104b69fe62 ]

When enable the config item "CONFIG_ARM64_64K_PAGES", the size of PAGE_SIZE
is 65536(64K). But the  type of length and page_offset are u16, they will
overflow. So change them to u32.

Fixes: 6fe6611ff275 ("net: add Hisilicon Network Subsystem hnae framework s=
upport")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns/hnae.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.h b/drivers/net/ethern=
et/hisilicon/hns/hnae.h
index cec95ac8687d..fe37fc7ec76e 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.h
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
@@ -171,10 +171,10 @@ struct hnae_desc_cb {
=20
 	/* priv data for the desc, e.g. skb when use with ip stack*/
 	void *priv;
-	u16 page_offset;
-	u16 reuse_flag;
+	u32 page_offset;
+	u32 length;     /* length of the buffer */
=20
-	u16 length;     /* length of the buffer */
+	u16 reuse_flag;
=20
        /* desc type, used by the ring user to mark the type of the priv da=
ta */
 	u16 type;
--=20
2.17.1
