Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50491C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7202083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SVcfwb25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7202083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbeJAHZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:25:31 -0400
Received: from mail-eopbgr680112.outbound.protection.outlook.com ([40.107.68.112]:63837
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729286AbeJAHO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFuF0gd9FwMRdA42D+R+VxS4/ylYPCWKto4Iao2i3Y0=;
 b=SVcfwb25XIHWVRPnSO/X9TXHWp59kyk9vxnnOouy2GENf4xOfiF0dbmlprbTc5ZiJxhcwq4qHRjJ6ycg2gc5qRJ9vVvOiEaCGAOeecRn4QwR1jRvlyVmCNiE/hvWppSSzfSFrdX/CV7lJwD/QCVRZfgPtcTqsYmJtPUac6yeXNg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 44/65] net: ena: fix missing lock during device
 destruction
Thread-Topic: [PATCH AUTOSEL 4.18 44/65] net: ena: fix missing lock during
 device destruction
Thread-Index: AQHUWR8TZ924YzMbv0eZJC9NzCuSGg==
Date:   Mon, 1 Oct 2018 00:38:29 +0000
Message-ID: <20181001003754.146961-44-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:NpuZbB5n7iRU26I6TgQ2qkMHu6riO2uws4iQbbcYOgwMKeIbSi8lHJnZnhlvXajVQIqNCT0PFOvluxhDQPQIidizt6XymuL3yw33TEEHVNnku1x2nYCHYgBdm6apietgc34jd0G/fuXZ8jf7ttv3QVEsrHjPK3pjGgg8QREaWLZwC1ATTeArJYaabu+C6S+XHQmm2QiX1akWwgJ0nKI06ULIkjLwUKvDZydOXg3gn//J6Mli7eQxafYSy7Clv6UxuKm1oeYacXG/o9DDdrycCk7dil1SC/DoSjXuD16NGbXIyMtnIqSNyZf4RiM+hIcM3mvpO5tU7fqPUpC9y3ZPwu0c1ZhISfMdfy+mxeGzXHAIr29QbKkV2Ec3gdM3d8tyKRjTLArOcKamEYuwyDpRMHuveg/4ivZDLOrDhORzXBqZYr2ne07+G67ZRoOnbROeiZ45pqwARYHFBNwQibcKTA==;5:NsczH73f8IJ6HvLAm+riEUCX2Bce9z5wiDtZNhxTE0kTalLQyzAAs9+b+IJqbZZStoJ3vH0untsnvXRSuxY4s+BY99gvsW3tT6pku+PkLLgXFLH0r5YPqhJmH/rhvkm8myujVzZfmegYZp08V5F4TAs9H3R5raHdrUFwIEsyQOw=;7:Cr3s3TWEBV2MAwQXBazyuEs3zsHOzV+3xTykBClIedsyAoUGy8MbmH5lq8rokLL7tHA21Syagljb+oBb2jbmFUnJkv0hPB6XEYbfm0q5MxqoMiCrfzLIurL93SwmuC2F40JGZ2iVuW5mRwCVXRCvGzKd1xyXtLAF8N9TINFWC+6SqrVc7WKwHvooT4gj9Tsj8ZQdNyh2YYFUSPJX+7/Cby9mmngePk/g7MrsIv3eEOaD5oD1PTE7nYaVt6bLsyFP
x-ms-office365-filtering-correlation-id: 52dc2e24-f1c3-4c43-f46f-08d627364762
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08248BC6DA27A4DD1AF291B6FBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(47284530071512)(33061846794335)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(14444005)(26005)(71200400001)(71190400001)(186003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 31o6nN61b6Ek+La2KXnl6P0gDOk6ME8h+JaKKWWtcSIXw7tA4yLcdFKCix8a1XWCDC2CyBF/QgHTgfsnamrg8MPzV1M2nqoGs4e834Q4SI3EEoS5uk0vxQcgSyL9r4+LyBQMaaDtQgzoJ3xv1yM0jWPNuu+fdmoc4RZxZlku/o2iFRURZAPvzVomEBdabZdnL4j2uVmK3fmxOlYSwUvMn2QzGG8KVgH8t8WVcyp4nFcJ0n8+VlCnjT+CvlDpWHwn8FbO1/OTTTAfbiVipoFCtOex8UFe4+90WylK1aJUVy5eG5hsTwydDZvpzOetGJAoehap//AoJpUwQjEa+GNErHcayqmia7YJlGEZ/zl0msc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dc2e24-f1c3-4c43-f46f-08d627364762
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:29.8519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit 944b28aa2982b4590d4d4dfc777cf85135dca2c0 ]

acquire the rtnl_lock during device destruction to avoid
using partially destroyed device.

ena_remove() shares almost the same logic as ena_destroy_device(),
so use ena_destroy_device() and avoid duplications.

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/eth=
ernet/amazon/ena/ena_netdev.c
index 50d10820ef89..1b01cd2820ba 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3420,24 +3420,18 @@ static void ena_remove(struct pci_dev *pdev)
=20
 	unregister_netdev(netdev);
=20
-	/* Reset the device only if the device is running. */
+	/* If the device is running then we want to make sure the device will be
+	 * reset to make sure no more events will be issued by the device.
+	 */
 	if (test_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags))
-		ena_com_dev_reset(ena_dev, adapter->reset_reason);
-
-	ena_free_mgmnt_irq(adapter);
+		set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
=20
-	ena_disable_msix(adapter);
+	rtnl_lock();
+	ena_destroy_device(adapter, true);
+	rtnl_unlock();
=20
 	free_netdev(netdev);
=20
-	ena_com_mmio_reg_read_request_destroy(ena_dev);
-
-	ena_com_abort_admin_commands(ena_dev);
-
-	ena_com_wait_for_abort_completion(ena_dev);
-
-	ena_com_admin_destroy(ena_dev);
-
 	ena_com_rss_destroy(ena_dev);
=20
 	ena_com_delete_debug_area(ena_dev);
--=20
2.17.1
