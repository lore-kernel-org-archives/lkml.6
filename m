Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958BDC64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B2F2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="b7GPugIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B2F2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbeJAHOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:14 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:20832
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729109AbeJAHON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdALoD+RtBL27omjG0SXSOjlO2se1yCeWdiw0VUE7Qg=;
 b=b7GPugIsJM4xYmLQM/efhPj7GchusMZ2AjiryAB46HGmEPD2z6QKLiJyEZ99YrJcRnEbToSDighSn+5WU1caC1M0e64yPfUyza1QXggEJ9gw9u7SykthxTQNtXAW9QpcYRBLNjHfk+wLCYSCT2tBKNuanVWbTYgWGK+6OISR2I8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:38:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 41/65] net: ena: fix driver when PAGE_SIZE ==
 64kB
Thread-Topic: [PATCH AUTOSEL 4.18 41/65] net: ena: fix driver when PAGE_SIZE
 == 64kB
Thread-Index: AQHUWR8SPFr3nQjmzkGdXl5LYfCqnA==
Date:   Mon, 1 Oct 2018 00:38:28 +0000
Message-ID: <20181001003754.146961-41-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:emwZZiWzKITAXcwSxwbndq8jQKxv+nqtgkJEg1x55A9JNDas4v/OwzkxHEgxa/7V5KYzRF8je+UBIMOYVkwA6qMQLIVSjJPn5UZdcZaiQragoJ5/G2jMRPrmxeEoIgBKPafxYoSwsIU8KUHbx7iMzkOPoRRzxrVfCnPI4K6o1Zkr0uQYIJbSPoqVtBkI5FDZROTewBEwIjaTJ+AfuylFm0ApNDPGKgrUKxnl90NmOwgoJf2HPsy4NlZ4yO5zwzwUMs2FFyANLVmhog7hB1WL+Fpv29bDqN9l8TmI5B48uCOZq51EsXEgGlSNeU7WNokgTsbVJxT+dZCE8S+YP/e81XrF5HUuC/5qIkCIUMgakECVmQQFYD+8ekzrPCkkztm3TDcHd9nPwOlY/tZjRYmbVEa1WiEBgTudWeNPhWoAQza9VQn59wa8mZTTHmKKTH20g3g1deEdqfCpoHwEhH5uCQ==;5:5TAQvyttWX68Lco9eNrjJznxjRXixOiYQ+gvvDGrrr0AYRaCU5PgLJJckERCqOsH2IMR1MT3CgIiKNI9EBXk4//ZGAluuOZWjS+c4TYjaUr3H+MfXUn0xZ8ihHm3zPl+QmjwBo64Vw1bq61EMWhi6DAvS+UU0rKvdCjXma7uY/I=;7:RS76VWkihIPJFviITXeJKoNByT01fVwrnwXVdoa2Rq5Q0wlzwXLQQF45LjSUYzlUWdr6eOsKdW9NXvNabYWUFb4SEaRkR5MS5rFR1vuEBZsmck4W5Uh92y/15Sf7IZNeRAye4+RzV4cBCosAEBL3C+HAroTdIu0/2c/V69Er+KSFMa7Psqxj19ZRZGg/2e3jR0PA8GDzyQUormr8z3hZvwtvk8enmwsUOIoiWOY8DdF1wuJC7sE+9i66Gx0Sqmls
x-ms-office365-filtering-correlation-id: 37574f9e-36a3-4bdb-e667-08d6273646b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01819EAF2816D284347BEE31FBEF0@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(47284530071512)(33061846794335)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(71200400001)(71190400001)(6116002)(3846002)(2906002)(6436002)(1076002)(34290500001)(446003)(7736002)(478600001)(11346002)(53936002)(6486002)(66066001)(25786009)(2616005)(4326008)(476003)(81166006)(106356001)(72206003)(102836004)(86612001)(486006)(10290500003)(2900100001)(6506007)(76176011)(256004)(8676002)(217873002)(14444005)(97736004)(6666003)(107886003)(105586002)(81156014)(99286004)(54906003)(110136005)(5660300001)(2501003)(14454004)(5250100002)(22452003)(186003)(305945005)(26005)(68736007)(316002)(36756003)(8936002)(86362001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AxoUGPnv1RVbslX/LCD+A0u6MdjbV1eYwHKfJbURIgHqi0lXSkStzSSyQ9RWRK03RqArIIi0upkVeySgsRoLApIdtYbXVDh4C+TFCl1Y23NGbMEU6ofe1DsJ1fVKRhGwy+8O0Od+nlS6m6h5pFx/7hY8qGstCY++S2gmyRejolONozB1ElqWrs41lXWtDHI4t0TRIl0s0bG8b6IHwXMyluveXpWsqHpPBYZMvTdnDboVdd0n9jIpN7KZliSF78vcs+iKOpdPUzti3k5Uhn75Zlf3OiPKQU6ioi1VD/CVTRipJRgv//NFYmvm6lE0xXmEIrPtKHHt0mEP8bqKeWJEtx1K2vjFGklcJdro5BDYuas=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37574f9e-36a3-4bdb-e667-08d6273646b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:28.1926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index 26686a21234e..e6537d35408c 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -461,7 +461,7 @@ static inline int ena_alloc_rx_page(struct ena_ring *rx=
_ring,
 		return -ENOMEM;
 	}
=20
-	dma =3D dma_map_page(rx_ring->dev, page, 0, PAGE_SIZE,
+	dma =3D dma_map_page(rx_ring->dev, page, 0, ENA_PAGE_SIZE,
 			   DMA_FROM_DEVICE);
 	if (unlikely(dma_mapping_error(rx_ring->dev, dma))) {
 		u64_stats_update_begin(&rx_ring->syncp);
@@ -478,7 +478,7 @@ static inline int ena_alloc_rx_page(struct ena_ring *rx=
_ring,
 	rx_info->page_offset =3D 0;
 	ena_buf =3D &rx_info->ena_buf;
 	ena_buf->paddr =3D dma;
-	ena_buf->len =3D PAGE_SIZE;
+	ena_buf->len =3D ENA_PAGE_SIZE;
=20
 	return 0;
 }
@@ -495,7 +495,7 @@ static void ena_free_rx_page(struct ena_ring *rx_ring,
 		return;
 	}
=20
-	dma_unmap_page(rx_ring->dev, ena_buf->paddr, PAGE_SIZE,
+	dma_unmap_page(rx_ring->dev, ena_buf->paddr, ENA_PAGE_SIZE,
 		       DMA_FROM_DEVICE);
=20
 	__free_page(page);
@@ -916,10 +916,10 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx=
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
index f1972b5ab650..7c7ae56c52cf 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -355,4 +355,15 @@ void ena_dump_stats_to_buf(struct ena_adapter *adapter=
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
