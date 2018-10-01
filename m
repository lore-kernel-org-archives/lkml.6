Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6992C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29EB2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gWCOyFAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29EB2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbeJAHUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:20:34 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:28569
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729907AbeJAHPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAwkcAsruMVVhGk5C8FdX4ZuZkWCjuwMkSaZmDMogdo=;
 b=gWCOyFADotE0PxhkKre3QYgaPSQ8k/NEc3xs4DbjAvfiRSuQLMI+xWQ3n1ZiryuJr6947KbcJvp54zvP2HciJHLG5rCiMGwyApWt5UeEok20fM3brkWYwZ/8rlIJdg/G13wYgVJ/iF8AyDNxfq44p34Oil9CRe2Pbebe/PfyL9o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 14/26] net: ena: fix driver when PAGE_SIZE == 64kB
Thread-Topic: [PATCH AUTOSEL 4.9 14/26] net: ena: fix driver when PAGE_SIZE ==
 64kB
Thread-Index: AQHUWR9fvrHB/784lkOP3iBD0D9m6Q==
Date:   Mon, 1 Oct 2018 00:40:37 +0000
Message-ID: <20181001004026.147201-14-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:ZzMGCDpZsD2xdumuPhnqRDFlf9vuG/pfuqnedjbkG8/Y5I31gxZnfe7Jwq57F30emWbYqNQ3y53BCLDscZSRquuel7SnjCUvkD6JDSlMJWi2YFMgAUokK4SGnZbiipkZRDCUrdGWPMyfGuhmsTfHIqvYPBKknlJGASSmdfw1Mj74nEtPCi6xK2yZbBbzDDxn40Yk8yvRghLyvebOMGPJROfDh3pZ/57kHOuAOiwc7WRBFPgZ6jxCHOF1YDcYs1skKfd/5aLRG6Ui19IbF25aNcAP0yj30swXAxwLsEKOvgrsxiymYf3YUpP6er/IaLHV+nS/xhc7ikiB8YYAXSS80PA82MVADGaHTyPNX7VyOaiZyTsl+tHTuLyF2/hDTuEz6Jh5f58nrbCrGcGeTjSWmBPdHGJgEXxjkLTs0mJQqbJh8F5gUUSzYO7GZzCdBgRB6X4hc3NiezUuKJte3pBGVw==;5:0IYqch+6fhDn+XCO3XIbAL9gjXejmnIK+2KjAPFNuLTF2V4rLsKCUJhtgKutjdmwLF8LFevIN/mCh3EafO0vul/ocEp4R6oQLsvASF6Yz17R66OgueKHr54Xda+p2hhX11ZlysebAnfA4pvj6rOGBBIJ5v06wN9QtprnyFVIvKc=;7:a6uiycvL8DRRUQG49EOSIduC6ZUsUUgcWMW57TUyWIL8AQGD46T0bF1I8XMVkT1Xe1Ef+XGymf2yCU7ZGfbARcSB6Q6XeG+pCJdAaW4vwyYBkDOtLZAlsd+L+8W0qXlkd6xv9vsEn7FSvXBBoc9W/Rve6MZSquEv/XfqnfysbKUaMIzfyvB5QquFjemg1s2VsG80U7cpycG5CxleMoYzABWJ0lrt6iwgjk90oyCmKzFebj7HbP4l18rpK46mQJfT
x-ms-office365-filtering-correlation-id: 7455a130-9e1e-49ff-c984-08d6273681a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB0120628ECD73EE3DE5CD589CFBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(47284530071512)(33061846794335)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(2906002)(486006)(6506007)(2900100001)(4326008)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(14444005)(256004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: DJreYGCxyYwcgDvULz/2HjvyuDIatux5505oxgZTxxi+5TVGwS9j3sBQQWtedaDE6N1yvlZDtwyDEPaE/b8UqqRhJq8/eaovAGyLRsjPEe/zr1m2SQdUseiDeh+y39+CNhtofQlscvtmXmlZJKO3uUAEkBLlXML8agPUxgxryiGH6yBEOiKL6MOKl+TZGtzpPAXeUVQakYz9/4+219nSINhhFKPFIFOPCd9mIywxvysS3gYieksT3Q0skrEk/c7fAg814RpYNZvxKj5uCGM/CYzrePVOw2vSQxeDPtT/EhFSgQ4XQU6YYmIDsGEVEbzBKjkwjZynTkvygRKst4ZSjWsZiqwAMmgNXWokvqJLT3c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7455a130-9e1e-49ff-c984-08d6273681a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:37.4975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index 0d9ce08ee3a9..1d92e034febc 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -422,7 +422,7 @@ static inline int ena_alloc_rx_page(struct ena_ring *rx=
_ring,
 		return -ENOMEM;
 	}
=20
-	dma =3D dma_map_page(rx_ring->dev, page, 0, PAGE_SIZE,
+	dma =3D dma_map_page(rx_ring->dev, page, 0, ENA_PAGE_SIZE,
 			   DMA_FROM_DEVICE);
 	if (unlikely(dma_mapping_error(rx_ring->dev, dma))) {
 		u64_stats_update_begin(&rx_ring->syncp);
@@ -439,7 +439,7 @@ static inline int ena_alloc_rx_page(struct ena_ring *rx=
_ring,
 	rx_info->page_offset =3D 0;
 	ena_buf =3D &rx_info->ena_buf;
 	ena_buf->paddr =3D dma;
-	ena_buf->len =3D PAGE_SIZE;
+	ena_buf->len =3D ENA_PAGE_SIZE;
=20
 	return 0;
 }
@@ -456,7 +456,7 @@ static void ena_free_rx_page(struct ena_ring *rx_ring,
 		return;
 	}
=20
-	dma_unmap_page(rx_ring->dev, ena_buf->paddr, PAGE_SIZE,
+	dma_unmap_page(rx_ring->dev, ena_buf->paddr, ENA_PAGE_SIZE,
 		       DMA_FROM_DEVICE);
=20
 	__free_page(page);
@@ -849,10 +849,10 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx=
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
index c5eaf7616939..008f2d594d40 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -321,4 +321,15 @@ void ena_dump_stats_to_buf(struct ena_adapter *adapter=
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
