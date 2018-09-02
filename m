Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419EBC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D747920856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NSfwx0P+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D747920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeIBRVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:21 -0400
Received: from mail-eopbgr710112.outbound.protection.outlook.com ([40.107.71.112]:8317
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbeIBRVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feOHDu9/McRRvuR4AY/uUhxpdD8jC+eoJI/qDVf1cxQ=;
 b=NSfwx0P+/AMwz+RThRdWTPh9W8hfsbVK3Wq6Pvk5BRvbUY5QBtUXf1/uamgA8ZvWDUgTahR9TXif1sZrsF+//jyNQ6bmwA9Nog0JseAm05iLYkBDMByy1bWRAlQdgBGeVdyeMVoOjvKGUhqu9jR70+YC48k2qbateXFQcLFrkxU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 096/131] media: s5p-mfc: Fix buffer look up in
 s5p_mfc_handle_frame_{new, copy_time} functions
Thread-Topic: [PATCH AUTOSEL 4.18 096/131] media: s5p-mfc: Fix buffer look up
 in s5p_mfc_handle_frame_{new, copy_time} functions
Thread-Index: AQHUQr2Q4Dv8UDlIyUys0EiokCAlaA==
Date:   Sun, 2 Sep 2018 13:05:04 +0000
Message-ID: <20180902064601.183036-96-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:Rg4j1ZiPa3E7lbamJDe5AcmY8HyVgypFRnNesdvQ3UL9wmlySkHeMyKdvVO8YRZPVTgLhSolrSn/7LFQVDqDCEClDyTJFcqSC4nQpE4x39PWKtzRyiHF8DrnpVutupVEiK9m8b2BXpqE05lfmH7wrsdHnExP/C4wrY8UJo5VquwlgKx+CyZ8H5nDdXads7R2J+4gig6G33NkDKmBV4kvzGux+ASRGlDNFb7y6S1itItFnR++Fd+mFtlIk5Jn+59yX4Na55qTYFpp1+sJzFPGDjV9gUmAQK0U3HIvFeXmfjRh8u0i+6Ov/9PpjWktysHGOnUID7My5hO6Rrk9GEgKdOdIMYISJPdgvl7ykN1EKTWum0OVTgb4nG4y51TsGR5sGiLBCxUDQFtsR+3x3Bcb/IG0JjgQXxwbxLLUQbZVPjdD/BH06FFhlALBRx81WJwP2WAmnLM7qNTt/NAPA6ZuKA==;5:xd2oCGG42luHgrHJJEav7bNYtWiWqs9CFi0ZpKHHFZltXOEIMGG2ejjq/sfOlRr5axMksvPE1T+/Xmv/off0uJhNBVOEkUwqYgxEcb79mhctzq2Z0QMu8d1LwoACjQ9wvRb+IsYSZWAQaZVwtcr1Pkgj8Xct21tn1Q1oF7xNXEo=;7:3de5yWUGJ3QxUXHF2hz+Sqv/vO5nZzNf+4waQAT9F7hShvTyyTUWBL7Exp9x5+EMJBEBq9v5jf/SpI8IZnMhH+egt1G/3U9ivuxhDAEusKwk6XtcieTGRw2f7hUKFxW1Lj2bUIHHemmgnkj5sZigbsuCCoryQmvOoVvanIv2pyKjXFy7WSWMb3VDVpd4D1mPKcVGKxXeGO3b7GuSNIWqewWuUSIBw7HYp3lIqJW9XW4gc8Ox6aN+x68JOH50fT6K
x-ms-office365-filtering-correlation-id: c447cf18-7656-44e2-8efd-08d610d4c45d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184CB0D643A2B53B724FEF4FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(15760500003)(107886003)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(14444005)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(575784001)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +zXnMbvUsDo2gHivN7Ntc0OixnQkalNeucg1QBRc/XXK3JjQXPjNUCB1NdjLAzABs4cZRfMJA1F2RnTTnjIajkbpCGw3KFxYq8/Jc0XNDLgcY/w+2iF0BIb4ol/MzOlPPh7xuA0ZeON0G5bTJsj8OIbdtqoR0JfObk2R+JiWIE767DCYtTaCDUtKQHHAGsHx0HUwWLunidmte22st8f2X9bLP8k3Ir0lQ0W1/4BtLKoPQYt1PhHo9a75nM5CHxnmD3hgQrAc5T0MObmS/u3tgl/Pc4OQF49zH7FWM5RU9G19POH16Nqfa2DMleCcgftbZGlQCu3CUvm13xp0MHC1T+OPNgeCI+5iXn9tQs7WTB0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c447cf18-7656-44e2-8efd-08d610d4c45d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:04.8424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

[ Upstream commit 4faeaf9c0f4581667ce5826f9c90c4fd463ef086 ]

Look up of buffers in s5p_mfc_handle_frame_new, s5p_mfc_handle_frame_copy_t=
ime
functions is not working properly for DMA addresses above 2 GiB. As a resul=
t
flags and timestamp of returned buffers are not set correctly and it breaks
operation of GStreamer/OMX plugins which rely on the CAPTURE buffer queue
flags.

Due to improper return type of the get_dec_y_adr, get_dspl_y_adr callbacks
and sign bit extension these callbacks return incorrect address values,
e.g. 0xfffffffffefc0000 instead of 0x00000000fefc0000. Then the statement:

"if (vb2_dma_contig_plane_dma_addr(&dst_buf->b->vb2_buf, 0) =3D=3D dec_y_ad=
dr)"

is always false, which breaks looking up capture queue buffers.

To ensure proper matching by address u32 type is used for the DMA
addresses. This should work on all related SoCs, since the MFC DMA
address width is not larger than 32-bit.

Changes done in this patch are minimal as there is a larger patch series
pending refactoring the whole driver.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platf=
orm/s5p-mfc/s5p_mfc.c
index a80251ed3143..780548dd650e 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -254,24 +254,24 @@ static void s5p_mfc_handle_frame_all_extracted(struct=
 s5p_mfc_ctx *ctx)
 static void s5p_mfc_handle_frame_copy_time(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev =3D ctx->dev;
-	struct s5p_mfc_buf  *dst_buf, *src_buf;
-	size_t dec_y_addr;
+	struct s5p_mfc_buf *dst_buf, *src_buf;
+	u32 dec_y_addr;
 	unsigned int frame_type;
=20
 	/* Make sure we actually have a new frame before continuing. */
 	frame_type =3D s5p_mfc_hw_call(dev->mfc_ops, get_dec_frame_type, dev);
 	if (frame_type =3D=3D S5P_FIMV_DECODE_FRAME_SKIPPED)
 		return;
-	dec_y_addr =3D s5p_mfc_hw_call(dev->mfc_ops, get_dec_y_adr, dev);
+	dec_y_addr =3D (u32)s5p_mfc_hw_call(dev->mfc_ops, get_dec_y_adr, dev);
=20
 	/* Copy timestamp / timecode from decoded src to dst and set
 	   appropriate flags. */
 	src_buf =3D list_entry(ctx->src_queue.next, struct s5p_mfc_buf, list);
 	list_for_each_entry(dst_buf, &ctx->dst_queue, list) {
-		if (vb2_dma_contig_plane_dma_addr(&dst_buf->b->vb2_buf, 0)
-				=3D=3D dec_y_addr) {
-			dst_buf->b->timecode =3D
-						src_buf->b->timecode;
+		u32 addr =3D (u32)vb2_dma_contig_plane_dma_addr(&dst_buf->b->vb2_buf, 0)=
;
+
+		if (addr =3D=3D dec_y_addr) {
+			dst_buf->b->timecode =3D src_buf->b->timecode;
 			dst_buf->b->vb2_buf.timestamp =3D
 						src_buf->b->vb2_buf.timestamp;
 			dst_buf->b->flags &=3D
@@ -307,10 +307,10 @@ static void s5p_mfc_handle_frame_new(struct s5p_mfc_c=
tx *ctx, unsigned int err)
 {
 	struct s5p_mfc_dev *dev =3D ctx->dev;
 	struct s5p_mfc_buf  *dst_buf;
-	size_t dspl_y_addr;
+	u32 dspl_y_addr;
 	unsigned int frame_type;
=20
-	dspl_y_addr =3D s5p_mfc_hw_call(dev->mfc_ops, get_dspl_y_adr, dev);
+	dspl_y_addr =3D (u32)s5p_mfc_hw_call(dev->mfc_ops, get_dspl_y_adr, dev);
 	if (IS_MFCV6_PLUS(dev))
 		frame_type =3D s5p_mfc_hw_call(dev->mfc_ops,
 			get_disp_frame_type, ctx);
@@ -329,9 +329,10 @@ static void s5p_mfc_handle_frame_new(struct s5p_mfc_ct=
x *ctx, unsigned int err)
 	/* The MFC returns address of the buffer, now we have to
 	 * check which videobuf does it correspond to */
 	list_for_each_entry(dst_buf, &ctx->dst_queue, list) {
+		u32 addr =3D (u32)vb2_dma_contig_plane_dma_addr(&dst_buf->b->vb2_buf, 0)=
;
+
 		/* Check if this is the buffer we're looking for */
-		if (vb2_dma_contig_plane_dma_addr(&dst_buf->b->vb2_buf, 0)
-				=3D=3D dspl_y_addr) {
+		if (addr =3D=3D dspl_y_addr) {
 			list_del(&dst_buf->list);
 			ctx->dst_queue_cnt--;
 			dst_buf->b->sequence =3D ctx->sequence;
--=20
2.17.1
