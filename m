Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8939AC64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AFD2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aIgFoPc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AFD2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbeJAHPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:05 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:2013
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728834AbeJAHPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RINT2NZKGGtnj4GK4Py/XxU9QoiDdRV5UJYihBd4fGI=;
 b=aIgFoPc0RWmKo+JB4c1xW3qotX5qk7Qw952AKZx8IyvlPVaLcKW+9jFv6mfpVFhfSBsoaOLNRgN8Cuc5bTmdb0xvFxDycm8MPEbJWUTu+lxwfJkzy6JtFhQZqW35OARF9zLqXtOLPLpxI++EUot6zoJ3d4flla5+c2Izzfzvn3A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:39:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 22/37] net: ena: fix driver when PAGE_SIZE ==
 64kB
Thread-Topic: [PATCH AUTOSEL 4.14 22/37] net: ena: fix driver when PAGE_SIZE
 == 64kB
Thread-Index: AQHUWR8prgWzhO8Bv0+87sVI+S0KKA==
Date:   Mon, 1 Oct 2018 00:39:06 +0000
Message-ID: <20181001003850.147107-22-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:FzSZ5gTKZXlln/mOI2CfCT9EvMTVqWHIh3MDDWk2wF8ItQbbnICFPcd1OPJX5CUBCOtKkAQsgveTshnvK9P92GhGcqXzWkgSRlg8wy624jM4truzkZXUoxfH478+gW30/ZF3wU2XMq8PeiNTjAlwzxwRYpTbfqXbzRxNqfOx6vNikqEHJGNVoPyOKOL2ug/IeVbt3KdknkGgyE+EhAYVphzrfI6sCamRzr0Gt9+WRFU7fufMrkAs/TnL7FL0Gm1lxI9SiYnEMj0kyCaitnEFFnZ3YcCNWNRxaDWwThZb3Wd7Qy90s/b9dJkvu1sJsoEKZRbFCLAxTt3Xsdjb1nxo1IJVsHqlngrBytMgtKpuq0R7SsCq5cpWirjLBNAtcJWcFyUrGsnaWBOZPlWvoiOZLRB+4v9R4SE1CgNLqY9L0JdfuYex/Jl0xU+t9jMiAGLYXTog39DvzZCssRlsSQu2mg==;5:Ffv/WrDFqQitPGh0HJGBKIVKpZ6tsoe3OTQC7jwjGTAQZMRWUOKK9vIHZpNBKOLo963qzQkoUixmKofvJs6jz24lB0kHacw5Bhq78yd4lsrXp90eUWIs35xBKzBYfCMmnsT5C5twtZWlmHWzGRViubwQEJr560MuSDD83Pk/QAU=;7:FhV42tg8FJLRKM9Bre+gVg6kmtewTKURbdjn/W/RykZFTuDNZlMKrp/UHiCBS/NnUzPrVXmdieVZZ+1KwzJTblkaKymPc7T8ZqeR1jVsEW4HC3/PXlNNBsAy4zNPYUhvGQUrA3As+iQnL7Y6tP4NCLZa1eJuq27PTE+X+CIjFvK9BGJEwEZaNT7WupsK7nGYoRiyGm450izZQiwxZfj2KwmmG1QpUQJ8QAu2Tq9Az/E1zOQ/8jTB1KvbZRX7ICRW
x-ms-office365-filtering-correlation-id: e70fef65-bf8c-4115-1620-08d62736629a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB085421EF6B4F8E23F8175EDBFBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(47284530071512)(33061846794335)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(2906002)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(14444005)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: TZUcmRdvvL3l0pXW/n08cZtrivtElxq5JFaeOPObCWG4jW/ndBhBPAxRh6pdn/NR4yGpyXyovuzV499xBy2ZTx2SAps5mZ3QiaY9iL9ZRdk0LhJORRsIFkR0FmEWfW4Dw+wb4FSHTi97+YKmvfn5YbizgmUqSQ317auDYeHCwjImIWsom8a04s1b9wVxt0OIH9gRCCyCRc0GA2Kx342CG10o9uJ/SCBrAHTpxQEUWacAisped/Gv7q9/XYlyYCzgzPcMk1HokZMw0mn5rSNhaNQL7Usz9M3/iv/WY1guB0w+CP7rlI/UI3uAUbDPwIyYNdHW9y/MPuCZqGASveTW6LLN/mfVxVJrOde3dIbp404=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70fef65-bf8c-4115-1620-08d62736629a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:06.7875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit ef5b0771d247379c90c8bf1332ff32f7f74bff7f ]

The buffer length field in the ena rx descriptor is 16 bit, and the
current driver passes a full page in each ena rx descriptor.
When PAGE_SIZE equals 64kB or more, the buffer length field becomes
zero.
To solve this issue, limit the ena Rx descriptor to use 16kB even
when allocating 64kB kernel pages. This change would not impact ena
device functionality, as 16kB is still larger than maximum MTU.

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 10 +++++-----
 drivers/net/ethernet/amazon/ena/ena_netdev.h | 11 +++++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/eth=
ernet/amazon/ena/ena_netdev.c
index 67df5053dc30..60b3ee29d82c 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -456,7 +456,7 @@ static inline int ena_alloc_rx_page(struct ena_ring *rx=
_ring,
 		return -ENOMEM;
 	}
=20
-	dma =3D dma_map_page(rx_ring->dev, page, 0, PAGE_SIZE,
+	dma =3D dma_map_page(rx_ring->dev, page, 0, ENA_PAGE_SIZE,
 			   DMA_FROM_DEVICE);
 	if (unlikely(dma_mapping_error(rx_ring->dev, dma))) {
 		u64_stats_update_begin(&rx_ring->syncp);
@@ -473,7 +473,7 @@ static inline int ena_alloc_rx_page(struct ena_ring *rx=
_ring,
 	rx_info->page_offset =3D 0;
 	ena_buf =3D &rx_info->ena_buf;
 	ena_buf->paddr =3D dma;
-	ena_buf->len =3D PAGE_SIZE;
+	ena_buf->len =3D ENA_PAGE_SIZE;
=20
 	return 0;
 }
@@ -490,7 +490,7 @@ static void ena_free_rx_page(struct ena_ring *rx_ring,
 		return;
 	}
=20
-	dma_unmap_page(rx_ring->dev, ena_buf->paddr, PAGE_SIZE,
+	dma_unmap_page(rx_ring->dev, ena_buf->paddr, ENA_PAGE_SIZE,
 		       DMA_FROM_DEVICE);
=20
 	__free_page(page);
@@ -910,10 +910,10 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx=
_ring,
 	do {
 		dma_unmap_page(rx_ring->dev,
 			       dma_unmap_addr(&rx_info->ena_buf, paddr),
-			       PAGE_SIZE, DMA_FROM_DEVICE);
+			       ENA_PAGE_SIZE, DMA_FROM_DEVICE);
=20
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_info->page,
-				rx_info->page_offset, len, PAGE_SIZE);
+				rx_info->page_offset, len, ENA_PAGE_SIZE);
=20
 		netif_dbg(rx_ring->adapter, rx_status, rx_ring->netdev,
 			  "rx skb updated. len %d. data_len %d\n",
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/eth=
ernet/amazon/ena/ena_netdev.h
index 29bb5704260b..3404376c28ca 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -350,4 +350,15 @@ void ena_dump_stats_to_buf(struct ena_adapter *adapter=
, u8 *buf);
=20
 int ena_get_sset_count(struct net_device *netdev, int sset);
=20
+/* The ENA buffer length fields is 16 bit long. So when PAGE_SIZE =3D=3D 6=
4kB the
+ * driver passas 0.
+ * Since the max packet size the ENA handles is ~9kB limit the buffer leng=
th to
+ * 16kB.
+ */
+#if PAGE_SIZE > SZ_16K
+#define ENA_PAGE_SIZE SZ_16K
+#else
+#define ENA_PAGE_SIZE PAGE_SIZE
+#endif
+
 #endif /* !(ENA_H) */
--=20
2.17.1
