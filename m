Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A69C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7E72064D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ol+63qa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7E72064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbeJAHPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:07 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:2013
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729608AbeJAHPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRnEiqswYXQcQMAijLqDuvQrAzgcseNGmR315yQykV4=;
 b=ol+63qa/fYCbXmmSayyq6PaU6n9R7XRD3qDdh1Y8hcOarwy29hthP32J4pNsTon70JTdGRaVmLJ/FLocxK9GYRKBnQ/MWQSmarmIznZyiBiFOBUMdYjMPZtaWH7IjoNflxruha+YMtCjcZlo+bYeNCYUi76t+PBYvAjn+DutNbM=
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
Subject: [PATCH AUTOSEL 4.14 23/37] net: ena: fix missing calls to READ_ONCE
Thread-Topic: [PATCH AUTOSEL 4.14 23/37] net: ena: fix missing calls to
 READ_ONCE
Thread-Index: AQHUWR8p0X6zwRyywUGSKAfxVZ49Gg==
Date:   Mon, 1 Oct 2018 00:39:07 +0000
Message-ID: <20181001003850.147107-23-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:DIFIwSO3ZvislSs6bRZoV+fZ4qGVz/hk/FOEnXgbJ7xNr4mI+htMIbYsUs6zhcJt8R0dsYEAB0opITrqMM0WsGN6S0PiaiJt0uyPja9VRad1uyGjQFANv6tUmwAQe244OFH5B0Ggj+fAlafFOzh4bV0RLe/wcm2hbGqXQgw4R4iL+5zUahvEa0Xo5+ZjqDAGCL1dZr07bkTXkvk8KDCgXAtGMHeuVsHMS/I/ujOgaQbpzi87fINtzS1DvSaQBx0Pma+tuxIzPyRXER4V5K9T4xKYlKMTFsKoQK+uCaxCiYYAD3GSSyTisUE8Zhm+hom1fKmyuhjI/pebmIoqUcZuk7DVyab8fGNylKTgZp11ND62m3DW4pjRCWCF8cuHCS3sx9++SIC/GJbGF/FOBD+BXb07CTUp3wdejJjqyn7EtmEHI0UkRVs/tqxSXmuiKslbqsPnl8GeaH1FpcUs74zVGg==;5:uZ3hF6wNmGWOKZjQ/PNx53YQusv01u7TSyqe/L0ypZ2tErBluGKT9P3acUY2XGyJ6VJAaW1O1IIv+8mITjja1WFtNbTP6Wj6UyRNtxEvfcay+LSt390OJq3oXN87i22OGIC7vH6/nCxuAQYgvZ4kGytN/S63Lrm9YD8MHzoHQek=;7:kIceAN9tdu8DO8QjdvMhym/URB76e2aBHmYyIB6YINcEaqciGmkqW1naiQrxe0AfgTVflMoU7BZY0FB0f49B4HHXsEmwKK3Ok9T70i53Fb1R52VVcLHlgzXOLoR/n9qrxgE9jODEZMd2S4jFzGltW8/Q7I7l/dGo4ivM6nBPjs29iJfjwgRywlo6mN4yV9qHfkqJotsxWEynDEodzlvVo3QuBHmFaj7sUek0r4QjEzMtmtlGblFTVOH+wSHcQdnY
x-ms-office365-filtering-correlation-id: 008de19e-d312-4c72-90d2-08d6273662cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB0854FBFFBDBAEE40CB2CD813FBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(47284530071512)(33061846794335)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(2906002)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(14444005)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 7hTYvl1+Fl5MpKRwoSNiJ0QvIso/p8ovCf/ye+IsUEmukQBfJMgAIsp/qJVecx4wV/gr7u1uerO0WahBYcdlbYjmzWgqJjxaIRZxBCfU+Rws3IJhHVsGmtelsFlgS2UPJ0rFIHqsFjUpdlfvovoJS51EvygrOgG20XH5W+MRyX1PrcRHi2tUBORF604VzrdjjaVUhcZyNvo+1HFeWIQIxVLVNOlavgWoBGjLQ/l7XXdSJ3eqVOtwCXTROpn6SBdelpXc64yVpN60wSZtwMC+iNFba8C4jhDW7lvyl6P02zcIUXStfB97YLJEh8X5U2ZaB3f0+Slf76P9t39+gr1F0yDpqSg+l+yuIIdytZkmk+s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008de19e-d312-4c72-90d2-08d6273662cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:07.4341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit 28abf4e9c9201eda5c4d29ea609d07e877b464b8 ]

Add READ_ONCE calls where necessary (for example when iterating
over a memory field that gets updated by the hardware).

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethern=
et/amazon/ena/ena_com.c
index e3b7a71fcad9..1a4ffc5d3da4 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -457,7 +457,7 @@ static void ena_com_handle_admin_completion(struct ena_=
com_admin_queue *admin_qu
 	cqe =3D &admin_queue->cq.entries[head_masked];
=20
 	/* Go over all the completions */
-	while ((cqe->acq_common_descriptor.flags &
+	while ((READ_ONCE(cqe->acq_common_descriptor.flags) &
 			ENA_ADMIN_ACQ_COMMON_DESC_PHASE_MASK) =3D=3D phase) {
 		/* Do not read the rest of the completion entry before the
 		 * phase bit was validated
@@ -633,7 +633,7 @@ static u32 ena_com_reg_bar_read32(struct ena_com_dev *e=
na_dev, u16 offset)
 	writel(mmio_read_reg, ena_dev->reg_bar + ENA_REGS_MMIO_REG_READ_OFF);
=20
 	for (i =3D 0; i < timeout; i++) {
-		if (read_resp->req_id =3D=3D mmio_read->seq_num)
+		if (READ_ONCE(read_resp->req_id) =3D=3D mmio_read->seq_num)
 			break;
=20
 		udelay(1);
@@ -1790,8 +1790,8 @@ void ena_com_aenq_intr_handler(struct ena_com_dev *de=
v, void *data)
 	aenq_common =3D &aenq_e->aenq_common_desc;
=20
 	/* Go over all the events */
-	while ((aenq_common->flags & ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK) =3D=
=3D
-	       phase) {
+	while ((READ_ONCE(aenq_common->flags) &
+		ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK) =3D=3D phase) {
 		pr_debug("AENQ! Group[%x] Syndrom[%x] timestamp: [%llus]\n",
 			 aenq_common->group, aenq_common->syndrom,
 			 (u64)aenq_common->timestamp_low +
--=20
2.17.1
