Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D10C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA02A20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CluPZX2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA02A20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbeIBRat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:49 -0400
Received: from mail-co1nam03on0110.outbound.protection.outlook.com ([104.47.40.110]:15904
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729355AbeIBRas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb5xTQdki6owloRnm71486aB7vqIkL6SWyG1FQ/Ffz4=;
 b=CluPZX2xAPWBg6RbL5MtgDEg7n+wOiOLYAfuFrlVemCeLTM1b1hG733+8nTb7RkQd/0i0ofuNfctd267rq3kbzFw+MXCq1R/f5ZgIc9rwzAyUpK3UEE6mUqrmi+htWrG1eBY8xYmeP6G3HQ5thAg5I7CX5+yJJSaLz1+w6sxjKQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 42/62] media: s5p-mfc: Fix buffer look up in
 s5p_mfc_handle_frame_{new, copy_time} functions
Thread-Topic: [PATCH AUTOSEL 4.9 42/62] media: s5p-mfc: Fix buffer look up in
 s5p_mfc_handle_frame_{new, copy_time} functions
Thread-Index: AQHUQr7xQDYvkimviUCKNZvMTiclaQ==
Date:   Sun, 2 Sep 2018 13:14:56 +0000
Message-ID: <20180902131411.183978-32-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:EALI8HMcr3LNlQ5M4x1Imt0JY7Q8b/LdPebRoi6hJV15obmJBxa+WkzO5ADJ2glJG4qcNjwB0OjPH4qQVcNvtLKeS3BZKqTKfIsM7HO3zWPaR8TeSFGgcHgBHyQ/SZVVuQum0r2KWqh7GOJJE0quw8fLp4ht05X8E7NBj/Sfn7SM9BBSX13PHmP9iiK74AWY2622duJLvxsKM7KAWSyN+s/S/9aFEbkVbKsIlJYDgXzveT6a981MLCs2sPNZr9xsUHIowdU+Yf7Tkv/t/lcEpfjgtewVzajqd0HBSWd3Yc3iZzesk8JSXT93q2vC6XxHS5okFifi7kfZYNtD4QBYGjVqjQ8EVgtKN3k1A7R4Ci53PH6Y8DehXU+ZPrYfhkZaOqzBPtmOYN/h4e9+KnEPmqyH/GNgIejHpsIaBXSVlFpJZgYSYZHNwnHI9vdU/ZUeXC23cLUxiii6/wVAp9j+kA==;5:jq66qmCiINB7wwNQkv4AuE3OatT6LLdD4wo0GeQnqix9mEhwv/vLQ6zJ9ExHkdB2SC9rvnTQP5J9N8D1snfHGxmOhAU+mGhkPUwHiPH9qCLBp4NghGoG1LMTRJYD+yLx8I8/HOiQGFOeVh7jTDwmZ3Hz+OKcwa6snHTwXgQLOeU=;7:1JyphkP0JEnYCM9Hg8FdEeUmZWMdT8B6LRGy4yNqL3QrVA5zDaa/+NrVxxK6WMlfjw5fEZtgbiZKjgD1qeGfbrKtW6rhzy4eP8REwYB+S+tdbxkSG5vE089dLYaNwtLzwRxdNnRkkeS0f5rFanOJGvLSH6XoXQMCnveaoo08Rj18kHS8KW/bvUUD6FGVa2a3MvQrdA/jYRHUaV8E6/hiXU9KRjJUNVF9WApmeolYub0EWBspQVY6Iv7gzqG9c+UJ
x-ms-office365-filtering-correlation-id: d7ed5340-a742-441c-3b87-08d610d61421
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB074153B772BBB6D03DAD8A9BFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(15760500003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MY3/TdwPrfUeQq8wZbBhDReHCp/BekmJQOYFuBcOCCrOCk/2EMcuxqJvRZP4TiELd7XjykpJOei+eN8CeVtqTXOa5wXyTR8wXRn/T7l62PD/HPAxsf1lpsXM/6NjqqO8iZRhjyDnG85g5AQOiioQQwX2l6HtJYOEpzFOjpV0cbzzGbfQq4NFajKkjBXqA0Kmy8Yg7n2qIVYHvEmpBsM5KPQixPNZXU1nvDb3eVLsSUOkmZlVbDBOVfEop3AsmMER06nY3fUiloV7PG3OBfJpET/vEvUxkIkkZuAAopyhWH8E2MX5jQnlhb2usJuctmzOTL2LnC5z/loT/B3IYmEfKvigBey/s3JGye+yR865USw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ed5340-a742-441c-3b87-08d610d61421
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:56.4380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
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
index 7c24da51626c..8051c1345692 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -249,24 +249,24 @@ static void s5p_mfc_handle_frame_all_extracted(struct=
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
@@ -302,10 +302,10 @@ static void s5p_mfc_handle_frame_new(struct s5p_mfc_c=
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
@@ -324,9 +324,10 @@ static void s5p_mfc_handle_frame_new(struct s5p_mfc_ct=
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
