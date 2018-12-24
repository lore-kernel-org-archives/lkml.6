Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72326C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8202171F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="bClDtTiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeLXI7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:59:51 -0500
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:48730
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726883AbeLXI7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39ZjEMPDrziXd/Lb4XIwHGcDmqxRPz28lsxGV5AS0zI=;
 b=bClDtTiqWcyEGFwWdyol8Fp9m5pUT0GD1nIiG67xPCpXckNLY5qRa9N5HGo/by0fY6uO69zIcvl2bBzSfvQDdteikc6+HTUCEBa2a9YWhCfkJPBhJOOeehOywsLRG3zUmPye7NYokLfnVSdxoNFZB6GtECgZdL3o+F0CBdozwkc=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0184.eurprd08.prod.outlook.com (10.161.35.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Mon, 24 Dec 2018 08:59:45 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 08:59:45 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 7/7] drm/komeda: Add debugfs node "register" for register dump
Thread-Topic: [PATCH 7/7] drm/komeda: Add debugfs node "register" for register
 dump
Thread-Index: AQHUm2cErgbMt5A2WEeIsnyxhwSX2w==
Date:   Mon, 24 Dec 2018 08:59:45 +0000
Message-ID: <20181224085716.2325-8-james.qian.wang@arm.com>
References: <20181224085716.2325-1-james.qian.wang@arm.com>
In-Reply-To: <20181224085716.2325-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYBPR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:10:4::24) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0184;6:M4PaxXV29UHFs0m76HTtFbo55EVoVHQM66L2yn7z5odbH/7pSyS7hO29NR224VIrGitMJeFa1zHf6hxFMSDVIkRZFzXGn9jTQhD4uIsc143Zhmc9+WGOCrgiWhGyezsTjtoQ+majZi5zKoq3DMthDcAwXwQFZPfVjwVf7YzTbQcsQw+5DA1xuBoukCRfCZV/lbyDD+JcRaTFJjMCtSGMZRbRtLA02FRC70djPGMNvHX5whY36btjZ7eYPaELQHGDxWzXML264rcUPmMhNVJDCRVL6RvnxBfsKRKSZZtis5nJjCWjlNmgT694Eh8kv9hkYcZFLzQ8wMgyjWTcNWbJApSuxCo+m1eM4FDqL7mvgdedPqY2ULUkv+x8cjcMkgMK81ONUAjXYSEaSgwQHQ8RsyC/MUfRYqEUVTGyasKbwm39AzW6yJB2k6DX2gKBsAkKEsu2H4FL3hkHH/EQTeeVqg==;5:cKWcl3LV4yKrxVsiVIe/s5WLkDM3VCNsoAb02dw928xbrbSWr0B2EPa5ktMm6TC2iSHIy6l+qI2PVJ1hXrMyndYGt0JT/D/2Ft3ei1VRyDctVLeCYB5V8BfA80BQzhUZ/aGqLSgJWgsqU0jVO3QO/bLlkcfveSPEK4VYoWhZ2/M=;7:nFlUmEpDxjSMoOl0WDF5JMksqUuphgy8a5a7CO4+pCM8ycMua86VqlS4uvOApRgMWpwJMhLX2SFRKZHDNH04DiX3kwSbnEj6NZdF4EozUV5YXNuo29+VJH872cEf+nAwj6uaXEPVITECDW+sewrjRw==
x-ms-office365-filtering-correlation-id: 390673dc-b4bc-45a9-0cc8-08d6697e2647
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0184;
x-ms-traffictypediagnostic: AM3PR08MB0184:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0184E0243ABAB96C6324BD64B3BB0@AM3PR08MB0184.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0184;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0184;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(39850400004)(376002)(199004)(189003)(6862004)(11346002)(446003)(36756003)(4326008)(2616005)(99286004)(14454004)(478600001)(476003)(386003)(102836004)(76176011)(52116002)(26005)(66066001)(53936002)(6506007)(3846002)(6116002)(55236004)(186003)(106356001)(97736004)(103116003)(5660300001)(105586002)(2906002)(486006)(6636002)(256004)(305945005)(8936002)(86362001)(6436002)(575784001)(6512007)(4744004)(68736007)(6486002)(81166006)(25786009)(7736002)(8676002)(71190400001)(1076003)(54906003)(81156014)(37006003)(71200400001)(316002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0184;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uBDLQp9ro7WRwQUNQ3mVmn2yA76BAuHYY/6V3UBDtIFP4YBFk9nn0NRpjjYbPP9lI1N+wOu3rcYr1KQE6hg20ywiuRVSWhoqT1Hz9N/jrKCHUSY509YT3ISzGwMqTPcz1hDRUgoGj+G6Zog4C0sZQiiSw+VQnYmW+as0KZFfJ8LnjgPJrCblR0cquv5HtxY0bS21DAi+IPzGQzM5Rlbsb1oQbrRFprjy5Mm86J7KaNf4PsemzayBi//o+YXso/TpP80VXnm76JjEG29O9elSAsK01lpEsZ8AutEN3jb+yMCh+EZbQYdg2fVJnPeNzq+1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390673dc-b4bc-45a9-0cc8-08d6697e2647
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 08:59:45.2363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debugfs node "register" and entry function dump_register to
dev/pipeline/component to register dump, then user can read
"/sys/kernel/debug/komeda/register" to get the register values via these
chip function.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    | 205 ++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  52 +++++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |   5 +
 .../drm/arm/display/komeda/komeda_pipeline.c  |  20 ++
 .../drm/arm/display/komeda/komeda_pipeline.h  |   3 +
 5 files changed, 285 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index 811634ec1193..5b2265bd3a40 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -69,6 +69,42 @@ static u32 get_valid_inputs(struct block_header *blk)
 	return valid_inputs;
 }
=20
+static void get_values_from_reg(void __iomem *reg, u32 offset,
+				u32 count, u32 *val)
+{
+	u32 i, addr;
+
+	for (i =3D 0; i < count; i++) {
+		addr =3D offset + (i << 2);
+		/* 0xA4 is WO register */
+		if (addr !=3D 0xA4)
+			val[i] =3D malidp_read32(reg, addr);
+		else
+			val[i] =3D 0xDEADDEAD;
+	}
+}
+
+static void dump_block_header(struct seq_file *sf, void __iomem *reg)
+{
+	struct block_header hdr;
+	u32 i, n_input, n_output;
+
+	d71_read_block_header(reg, &hdr);
+	seq_printf(sf, "BLOCK_INFO:\t\t0x%X\n", hdr.block_info);
+	seq_printf(sf, "PIPELINE_INFO:\t\t0x%X\n", hdr.pipeline_info);
+
+	n_output =3D PIPELINE_INFO_N_OUTPUTS(hdr.pipeline_info);
+	n_input  =3D PIPELINE_INFO_N_VALID_INPUTS(hdr.pipeline_info);
+
+	for (i =3D 0; i < n_input; i++)
+		seq_printf(sf, "VALID_INPUT_ID%u:\t0x%X\n",
+			   i, hdr.input_ids[i]);
+
+	for (i =3D 0; i < n_output; i++)
+		seq_printf(sf, "OUTPUT_ID%u:\t\t0x%X\n",
+			   i, hdr.output_ids[i]);
+}
+
 static u32 to_rot_ctrl(u32 rot)
 {
 	u32 lr_ctrl =3D 0;
@@ -142,9 +178,76 @@ static void d71_layer_update(struct komeda_component *=
c,
 	malidp_write32_mask(reg, BLK_CONTROL, ctrl_mask, ctrl);
 }
=20
+static void d71_layer_dump(struct komeda_component *c, struct seq_file *sf=
)
+{
+	u32 v[15], i;
+	bool rich, rgb2rgb;
+	char *prefix;
+
+	get_values_from_reg(c->reg, LAYER_INFO, 1, &v[14]);
+	if (v[14] & 0x1) {
+		rich =3D true;
+		prefix =3D "LR_";
+	} else {
+		rich =3D false;
+		prefix =3D "LS_";
+	}
+
+	rgb2rgb =3D !!(v[14] & L_INFO_CM);
+
+	dump_block_header(sf, c->reg);
+
+	seq_printf(sf, "%sLAYER_INFO:\t\t0x%X\n", prefix, v[14]);
+
+	get_values_from_reg(c->reg, 0xD0, 1, v);
+	seq_printf(sf, "%sCONTROL:\t\t0x%X\n", prefix, v[0]);
+	if (rich) {
+		get_values_from_reg(c->reg, 0xD4, 1, v);
+		seq_printf(sf, "LR_RICH_CONTROL:\t0x%X\n", v[0]);
+	}
+	get_values_from_reg(c->reg, 0xD8, 4, v);
+	seq_printf(sf, "%sFORMAT:\t\t0x%X\n", prefix, v[0]);
+	seq_printf(sf, "%sIT_COEFFTAB:\t\t0x%X\n", prefix, v[1]);
+	seq_printf(sf, "%sIN_SIZE:\t\t0x%X\n", prefix, v[2]);
+	seq_printf(sf, "%sPALPHA:\t\t0x%X\n", prefix, v[3]);
+
+	get_values_from_reg(c->reg, 0x100, 3, v);
+	seq_printf(sf, "%sP0_PTR_LOW:\t\t0x%X\n", prefix, v[0]);
+	seq_printf(sf, "%sP0_PTR_HIGH:\t\t0x%X\n", prefix, v[1]);
+	seq_printf(sf, "%sP0_STRIDE:\t\t0x%X\n", prefix, v[2]);
+
+	get_values_from_reg(c->reg, 0x110, 2, v);
+	seq_printf(sf, "%sP1_PTR_LOW:\t\t0x%X\n", prefix, v[0]);
+	seq_printf(sf, "%sP1_PTR_HIGH:\t\t0x%X\n", prefix, v[1]);
+	if (rich) {
+		get_values_from_reg(c->reg, 0x118, 1, v);
+		seq_printf(sf, "LR_P1_STRIDE:\t\t0x%X\n", v[0]);
+
+		get_values_from_reg(c->reg, 0x120, 2, v);
+		seq_printf(sf, "LR_P2_PTR_LOW:\t\t0x%X\n", v[0]);
+		seq_printf(sf, "LR_P2_PTR_HIGH:\t\t0x%X\n", v[1]);
+
+		get_values_from_reg(c->reg, 0x130, 12, v);
+		for (i =3D 0; i < 12; i++)
+			seq_printf(sf, "LR_YUV_RGB_COEFF%u:\t0x%X\n", i, v[i]);
+	}
+
+	if (rgb2rgb) {
+		get_values_from_reg(c->reg, LAYER_RGB_RGB_COEFF0, 12, v);
+		for (i =3D 0; i < 12; i++)
+			seq_printf(sf, "LS_RGB_RGB_COEFF%u:\t0x%X\n", i, v[i]);
+	}
+
+	get_values_from_reg(c->reg, 0x160, 3, v);
+	seq_printf(sf, "%sAD_CONTROL:\t\t0x%X\n", prefix, v[0]);
+	seq_printf(sf, "%sAD_H_CROP:\t\t0x%X\n", prefix, v[1]);
+	seq_printf(sf, "%sAD_V_CROP:\t\t0x%X\n", prefix, v[2]);
+}
+
 struct komeda_component_funcs d71_layer_funcs =3D {
 	.update		=3D d71_layer_update,
 	.disable	=3D d71_layer_disable,
+	.dump_register	=3D d71_layer_dump,
 };
=20
 static int d71_layer_init(struct d71_dev *d71,
@@ -251,9 +354,46 @@ static void d71_compiz_update(struct komeda_component =
*c,
 	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
 }
=20
+static void d71_compiz_dump(struct komeda_component *c, struct seq_file *s=
f)
+{
+	u32 v[8], i;
+
+	dump_block_header(sf, c->reg);
+
+	get_values_from_reg(c->reg, 0x80, 5, v);
+	for (i =3D 0; i < 5; i++)
+		seq_printf(sf, "CU_INPUT_ID%u:\t\t0x%X\n", i, v[i]);
+
+	get_values_from_reg(c->reg, 0xA0, 5, v);
+	seq_printf(sf, "CU_IRQ_RAW_STATUS:\t0x%X\n", v[0]);
+	seq_printf(sf, "CU_IRQ_CLEAR:\t\t0x%X\n", v[1]);
+	seq_printf(sf, "CU_IRQ_MASK:\t\t0x%X\n", v[2]);
+	seq_printf(sf, "CU_IRQ_STATUS:\t\t0x%X\n", v[3]);
+	seq_printf(sf, "CU_STATUS:\t\t0x%X\n", v[4]);
+
+	get_values_from_reg(c->reg, 0xD0, 2, v);
+	seq_printf(sf, "CU_CONTROL:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "CU_SIZE:\t\t0x%X\n", v[1]);
+
+	get_values_from_reg(c->reg, 0xDC, 1, v);
+	seq_printf(sf, "CU_BG_COLOR:\t\t0x%X\n", v[0]);
+
+	for (i =3D 0, v[4] =3D 0xE0; i < 5; i++, v[4] +=3D 0x10) {
+		get_values_from_reg(c->reg, v[4], 3, v);
+		seq_printf(sf, "CU_INPUT%u_SIZE:\t\t0x%X\n", i, v[0]);
+		seq_printf(sf, "CU_INPUT%u_OFFSET:\t0x%X\n", i, v[1]);
+		seq_printf(sf, "CU_INPUT%u_CONTROL:\t0x%X\n", i, v[2]);
+	}
+
+	get_values_from_reg(c->reg, 0x130, 2, v);
+	seq_printf(sf, "CU_USER_LOW:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "CU_USER_HIGH:\t\t0x%X\n", v[1]);
+}
+
 struct komeda_component_funcs d71_compiz_funcs =3D {
 	.update		=3D d71_compiz_update,
 	.disable	=3D d71_component_disable,
+	.dump_register	=3D d71_compiz_dump,
 };
=20
 static int d71_compiz_init(struct d71_dev *d71,
@@ -301,9 +441,37 @@ static void d71_improc_update(struct komeda_component =
*c,
 	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
 }
=20
+static void d71_improc_dump(struct komeda_component *c, struct seq_file *s=
f)
+{
+	u32 v[12], i;
+
+	dump_block_header(sf, c->reg);
+
+	get_values_from_reg(c->reg, 0x80, 2, v);
+	seq_printf(sf, "IPS_INPUT_ID0:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "IPS_INPUT_ID1:\t\t0x%X\n", v[1]);
+
+	get_values_from_reg(c->reg, 0xC0, 1, v);
+	seq_printf(sf, "IPS_INFO:\t\t0x%X\n", v[0]);
+
+	get_values_from_reg(c->reg, 0xD0, 3, v);
+	seq_printf(sf, "IPS_CONTROL:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "IPS_SIZE:\t\t0x%X\n", v[1]);
+	seq_printf(sf, "IPS_DEPTH:\t\t0x%X\n", v[2]);
+
+	get_values_from_reg(c->reg, 0x130, 12, v);
+	for (i =3D 0; i < 12; i++)
+		seq_printf(sf, "IPS_RGB_RGB_COEFF%u:\t0x%X\n", i, v[i]);
+
+	get_values_from_reg(c->reg, 0x170, 12, v);
+	for (i =3D 0; i < 12; i++)
+		seq_printf(sf, "IPS_RGB_YUV_COEFF%u:\t0x%X\n", i, v[i]);
+}
+
 struct komeda_component_funcs d71_improc_funcs =3D {
 	.update		=3D d71_improc_update,
 	.disable	=3D d71_component_disable,
+	.dump_register	=3D d71_improc_dump,
 };
=20
 static int d71_improc_init(struct d71_dev *d71,
@@ -375,9 +543,46 @@ static void d71_timing_ctrlr_update(struct komeda_comp=
onent *c,
 	malidp_write32(reg, BLK_CONTROL, value);
 }
=20
+void d71_timing_ctrlr_dump(struct komeda_component *c, struct seq_file *sf=
)
+{
+	u32 v[8], i;
+
+	dump_block_header(sf, c->reg);
+
+	get_values_from_reg(c->reg, 0xC0, 1, v);
+	seq_printf(sf, "BS_INFO:\t\t0x%X\n", v[0]);
+
+	get_values_from_reg(c->reg, 0xD0, 8, v);
+	seq_printf(sf, "BS_CONTROL:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "BS_PROG_LINE:\t\t0x%X\n", v[1]);
+	seq_printf(sf, "BS_PREFETCH_LINE:\t0x%X\n", v[2]);
+	seq_printf(sf, "BS_BG_COLOR:\t\t0x%X\n", v[3]);
+	seq_printf(sf, "BS_ACTIVESIZE:\t\t0x%X\n", v[4]);
+	seq_printf(sf, "BS_HINTERVALS:\t\t0x%X\n", v[5]);
+	seq_printf(sf, "BS_VINTERVALS:\t\t0x%X\n", v[6]);
+	seq_printf(sf, "BS_SYNC:\t\t0x%X\n", v[7]);
+
+	get_values_from_reg(c->reg, 0x100, 3, v);
+	seq_printf(sf, "BS_DRIFT_TO:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "BS_FRAME_TO:\t\t0x%X\n", v[1]);
+	seq_printf(sf, "BS_TE_TO:\t\t0x%X\n", v[2]);
+
+	get_values_from_reg(c->reg, 0x110, 3, v);
+	for (i =3D 0; i < 3; i++)
+		seq_printf(sf, "BS_T%u_INTERVAL:\t\t0x%X\n", i, v[i]);
+
+	get_values_from_reg(c->reg, 0x120, 5, v);
+	for (i =3D 0; i < 2; i++) {
+		seq_printf(sf, "BS_CRC%u_LOW:\t\t0x%X\n", i, v[i << 1]);
+		seq_printf(sf, "BS_CRC%u_HIGH:\t\t0x%X\n", i, v[(i << 1) + 1]);
+	}
+	seq_printf(sf, "BS_USER:\t\t0x%X\n", v[4]);
+}
+
 struct komeda_component_funcs d71_timing_ctrlr_funcs =3D {
 	.update		=3D d71_timing_ctrlr_update,
 	.disable	=3D d71_timing_ctrlr_disable,
+	.dump_register	=3D d71_timing_ctrlr_dump,
 };
=20
 static int d71_timing_ctrlr_init(struct d71_dev *d71,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index ccadd6c23915..cf3c8d5f5d90 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -10,8 +10,52 @@
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/version.h>
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#endif
 #include "komeda_dev.h"
=20
+static int komeda_register_show(struct seq_file *sf, void *x)
+{
+	struct komeda_dev *mdev =3D sf->private;
+	int i;
+
+	if (mdev->funcs->dump_register)
+		mdev->funcs->dump_register(mdev, sf);
+
+	for (i =3D 0; i < mdev->n_pipelines; i++)
+		komeda_pipeline_dump_register(mdev->pipelines[i], sf);
+
+	return 0;
+}
+
+static int komeda_register_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, komeda_register_show, inode->i_private);
+}
+
+static const struct file_operations komeda_register_fops =3D {
+	.owner	=3D THIS_MODULE,
+	.open	=3D komeda_register_open,
+	.read	=3D seq_read,
+	.llseek	=3D seq_lseek,
+	.release =3D single_release,
+};
+
+static void komeda_debugfs_init(struct komeda_dev *mdev)
+{
+	if (!debugfs_initialized())
+		return;
+
+	mdev->debugfs_root =3D debugfs_create_dir("komeda", NULL);
+	if (IS_ERR_OR_NULL(mdev->debugfs_root))
+		return;
+
+	debugfs_create_file("register", 0444, mdev->debugfs_root,
+			    mdev, &komeda_register_fops);
+}
+
 static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_nod=
e *np)
 {
 	struct komeda_pipeline *pipe;
@@ -158,6 +202,10 @@ struct komeda_dev *komeda_dev_create(struct device *de=
v)
 		goto err_cleanup;
 	}
=20
+#ifdef CONFIG_DEBUG_FS
+	komeda_debugfs_init(mdev);
+#endif
+
 	return mdev;
=20
 err_cleanup:
@@ -171,6 +219,10 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
 	struct komeda_dev_funcs *funcs =3D mdev->funcs;
 	int i;
=20
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(mdev->debugfs_root);
+#endif
+
 	for (i =3D 0; i < mdev->n_pipelines; i++) {
 		komeda_pipeline_destroy(mdev, mdev->pipelines[i]);
 		mdev->pipelines[i] =3D NULL;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index a760bc465465..5f96d2f57c4e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -103,6 +103,9 @@ struct komeda_dev_funcs {
 	int (*enable_irq)(struct komeda_dev *mdev);
 	/** @disable_irq: disable irq */
 	int (*disable_irq)(struct komeda_dev *mdev);
+
+	/** @dump_register: Optional, dump registers to seq_file */
+	void (*dump_register)(struct komeda_dev *mdev, struct seq_file *seq);
 };
=20
 /**
@@ -139,6 +142,8 @@ struct komeda_dev {
 	 * destroyed by &komeda_dev_funcs.cleanup()
 	 */
 	void *chip_data;
+
+	struct dentry *debugfs_root;
 };
=20
 static inline bool
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.c
index d0f2d556fc6a..611e8c53e248 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -275,3 +275,23 @@ int komeda_assemble_pipelines(struct komeda_dev *mdev)
=20
 	return 0;
 }
+
+void komeda_pipeline_dump_register(struct komeda_pipeline *pipe,
+				   struct seq_file *sf)
+{
+	struct komeda_component *c;
+	u32 id;
+
+	seq_printf(sf, "\n=3D=3D=3D=3D=3D=3D=3D=3D Pipeline-%d =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D\n", pipe->id);
+
+	if (pipe->funcs && pipe->funcs->dump_register)
+		pipe->funcs->dump_register(pipe, sf);
+
+	dp_for_each_set_bit(id, pipe->avail_comps) {
+		c =3D komeda_pipeline_get_component(pipe, id);
+
+		seq_printf(sf, "\n------%s------\n", c->name);
+		if (c->funcs->dump_register)
+			c->funcs->dump_register(c, sf);
+	}
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index df82f986f9c9..4f98fdb21557 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -369,6 +369,9 @@ int komeda_assemble_pipelines(struct komeda_dev *mdev);
 struct komeda_component *
 komeda_pipeline_get_component(struct komeda_pipeline *pipe, int id);
=20
+void komeda_pipeline_dump_register(struct komeda_pipeline *pipe,
+				   struct seq_file *sf);
+
 /* component APIs */
 struct komeda_component *
 komeda_component_add(struct komeda_pipeline *pipe,
--=20
2.17.1

