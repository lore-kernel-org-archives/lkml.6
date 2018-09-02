Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BE7C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6202E20856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Pag5HFv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6202E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbeIBR1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:27:35 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:1728
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729436AbeIBRXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CW9dvdIP1+Y11YGbZOBEuJvp+Iyi5v/lStvyf+Njfs=;
 b=Pag5HFv8yqLu/KoR66nz0RgfAgtZcaOzgwuV+4qovZiYyrW8X4sQBau89e6A56JdgKOwB/ae7dqItuoH9RdsoYiH1fKexY4gNA4wg2Aa5+3oYqQX//R2P/3cCAY5EgtXsmzCVCvBz5pfIUyNdh4pabKJSXuf7zx+4nvs/SdyeK0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 67/89] media: s5p-mfc: Fix buffer look up in
 s5p_mfc_handle_frame_{new, copy_time} functions
Thread-Topic: [PATCH AUTOSEL 4.14 67/89] media: s5p-mfc: Fix buffer look up in
 s5p_mfc_handle_frame_{new, copy_time} functions
Thread-Index: AQHUQr3oXGdkSkna3kmx6S4Da86JXg==
Date:   Sun, 2 Sep 2018 13:07:31 +0000
Message-ID: <20180902064918.183387-67-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:b2SCmuclSspOZP22aWPnrWUFescK8NCHlrI0WoB1Ib1S61pBynYDfej5YdbDTcL0rvGh9XOw0gkWVleGSbFi4ZG3kih0FNADsChxz5Cs5KuxYUJG1K8kOOsdLOsfRNRupIfDQyXBBZifd9xKF0RCtRQQ7+P41X7AFP4YBHn6ZqDZnbtd3PNiV/JssnwNDZHgOEGWWYC0X5Wg/cL8owFs7TzO8OK4rjqZ/b0jWPZMUNiFCTzfjXLhrPxeieiuDXxnv37V9XTeDdsrm8MJDRKWIofAwhqlR3AwLCcfAfvULi3lOPfWbGpOUhQw2i/ZlxAkXu6RXf/mz15me0aul9tOOgb4njWninP7OLWewUWu47dizH/VJJKmOrfuj1J3Pd+6FXlkGkiRACXulFYO1zzP9bULIpU7KpYic+ELNuaH2dmdkD5xH2E3wfTqiB9v/Q0VC/AtFLzFKQgnYfer/jRJvA==;5:eTGTeBqoP+01cpxOFHgEfmN4ve12OrMeswF6VKtjQlms9bF1PDpFN4bGYtcW4Dt0vf8HX0faUWQid8GbNFCLR/8QUZ7vLTnKp1CxUQ/YInr3/mHsPDENCOtY5b7NNQ0S5Vo2A38sNsG2kjv9ZRDltIC7hi9qFkdDYC03+C/p4tE=;7:vHfY/KgERkIxthgVQ3BrT2dhqsBBQVlZHjmzGZrfPHU0iPTyJwzNZOog2N8jgxGIZGhQXX6lQr4QBRO/fwWovSl9AZF9cp59Ox8C40zzDOew4QcRTIYDT/6zKioOJrhaljhrJyGaEqAKV7XgtYAo/Ns0AYGOmSxpH9tbY/RCQ5du9lf536V5+38Q1WGoBPgFblJnkgx6owuX8rJ1IrMevd2D3O775knF+Ly4ZnfrYSuKrZqO9tM03k1h6S5iF1eq
x-ms-office365-filtering-correlation-id: 2bae44e0-b7f7-488e-3de4-08d610d51696
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB014919C298BC50C3DE9F6835FB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(15760500003)(186003)(6666003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(14444005)(217873002)(36756003)(575784001)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +HLE1XJ8YLq+cbVsND2WcZQC6b5FMfZU3mirSiPlEurTFE+NL8D7ttgEFuRU4+W/c+lSvnBaHD6iJ2Im6+H7SspV5YJYI7G34HmNLAZynLcuzFgTJikWQIwcPEg59sR8vTtPLqss6Cv5rnALgUF7oe039+6+lYbmAIbpCj2rUFm1Q4hpVXZb2btbN4toKh57bfDYp6u6WXE3VxX7QHyNcyJUpKf4vmelyji5wFfjVPXOG2mR5HaKunissIzMXl/3blFMsx45mArpAMm4WsnQm317YMK9PNPsGMX+u3jmtU+k6TldrtjpT/PKEfpt3hokA92XBFr3cv0wW7LEAyToIXJcWSjfbxp+TLXOtn6H99Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bae44e0-b7f7-488e-3de4-08d610d51696
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:31.8225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
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
index 8e9531f7f83f..9942932ecbf9 100644
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
