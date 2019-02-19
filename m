Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9B0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFBA2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qb677HHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfBSU0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:26:22 -0500
Received: from mail-eopbgr750053.outbound.protection.outlook.com ([40.107.75.53]:47064
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729411AbfBSU0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51yNUNU+4Tk37ynYcMmxk69DWY9UseMP269PJgUmZS8=;
 b=qb677HHJDVyvYftMpli+f7YccuBqs6Xrl/fbj9bZfll8QqbB1N8ZXh+MJB7LqtO97ER/zOQH5PCSrQriQH6/avTxawI32tnyxH6Ti/CxanXrRi92nlNQ8WUJhWr6PuPtaXTOcRQ7zUs5EwmbV+EndpxYsaq0odU0aV8gs83YLB0=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2829.namprd12.prod.outlook.com (20.177.250.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 19 Feb 2019 20:25:55 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::35e5:6f95:dfe:efe]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::35e5:6f95:dfe:efe%2]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 20:25:55 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 2/5] EDAC/amd64: Support more than two UMCs
Thread-Topic: [PATCH 2/5] EDAC/amd64: Support more than two UMCs
Thread-Index: AQHUyJFP/G99YgnJFEC3ZJUtrH+SeA==
Date:   Tue, 19 Feb 2019 20:25:53 +0000
Message-ID: <20190219202536.15462-2-Yazen.Ghannam@amd.com>
References: <20190219202536.15462-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190219202536.15462-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0031.prod.exchangelabs.com (2603:10b6:804:2::41)
 To SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:6f::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1523f2a6-61a0-49d4-5f92-08d696a871d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2829;
x-ms-traffictypediagnostic: SN6PR12MB2829:
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2829;20:EEg3dqT3WDcfsumHlXujE7ChIXDa00xSsbD0/DCtAzV2jJS0398H7Ch1Cgcm0SMYpZznmT1PjpoV4Mv5/9X+AjBFBAotyDjoAg0iLsUg5K9ZLhDWacYYf5w/3AQvb4A1mnvV5LHCr4OIjfuGbrLJLQVtJXYDFneZZ775E0Bsh2xsLXyE2ja6bQCwqv+VTFTMeypQBLryOOgT4RYBeJgfd9Aj2VjSzILXvPISVZIPGAPlTqnPKyvXEMdcbAFrfhHF
x-microsoft-antispam-prvs: <SN6PR12MB2829862E761442762291D2D4F87C0@SN6PR12MB2829.namprd12.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(39860400002)(346002)(189003)(199004)(36756003)(476003)(68736007)(86362001)(486006)(6486002)(26005)(14454004)(76176011)(72206003)(478600001)(11346002)(3846002)(6116002)(6512007)(446003)(6346003)(6506007)(102836004)(316002)(2616005)(114624004)(25786009)(6436002)(6916009)(54906003)(4326008)(186003)(2906002)(5640700003)(5660300002)(386003)(53936002)(2501003)(99286004)(97736004)(305945005)(105586002)(52116002)(1076003)(50226002)(71190400001)(66066001)(8936002)(106356001)(2351001)(81166006)(71200400001)(81156014)(14444005)(8676002)(256004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2829;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hO8gyCuS0qrVNV8P3x0ToQjqn3N8oj2Uep9lX+jGWHagUYbafZNMaeI+ag/6Lq7O8ejWXoLt6kLLFxYGyo1kGztqovC5UoVwYsbpkQ5O7nJv7YeU4vfXMYB8dxg7FSiV2fJ9Dw+Qa0cPCFU2+ye1X5ewOVcvauKDB+RW/QwQJmIBu5jfkLfW+iMANCMMqQScJeLv+EzmL3fnmaLZapwf7xS9cdtOGsjY1+bjjWPD5FaidNVcfh3eAmDRTXgFj8Uo8AJEsNJXoDO/y3lFg+pexxF9KWmd6OYvBDd0elYg/iNTMlLGf7GeKaBEiv5uX017YL3Bo0JZy8Qvbl1w0Y2t3TwXgO1kKxJSU6ePnuwF21jSVINAlKS2qz8PPv9GlQFDWZoPTeGS5PxrNRXKtNE9/jeN+fuf8LkofQOz0Ym3hWs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1523f2a6-61a0-49d4-5f92-08d696a871d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 20:25:52.0676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2829
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The first few models of Family 17h all had 2 UMCs per Die, so we treated
this as a fixed value. However, future systems may have more UMCs per
Die.

Related to this, we were finding the channel number and base address of
a UMC by matching on fixed, known values. However, a pattern has emerged
so we no longer need to match on hardcoded values.

Set the number of UMCs at init time based on the Family/Model. Also,
update the functions that find the channel number and base address of a
UMC in order to support more than two UMCs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 42 ++++++++++++++++++---------------------
 drivers/edac/amd64_edac.h | 20 +++++++++++++++----
 2 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9947437d9574..507d824fe45a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -449,6 +449,9 @@ static void get_cs_base_and_mask(struct amd64_pvt *pvt,=
 int csrow, u8 dct,
 #define for_each_chip_select_mask(i, dct, pvt) \
 	for (i =3D 0; i < pvt->csels[dct].m_cnt; i++)
=20
+#define for_each_umc(i) \
+	for (i =3D 0; i < num_umcs; i++)
+
 /*
  * @input_addr is an InputAddr associated with the node given by mci. Retu=
rn the
  * csrow that input_addr maps to, or -1 on failure (no csrow claims input_=
addr).
@@ -722,7 +725,7 @@ static unsigned long determine_edac_cap(struct amd64_pv=
t *pvt)
 	if (pvt->umc) {
 		u8 i, umc_en_mask =3D 0, dimm_ecc_en_mask =3D 0;
=20
-		for (i =3D 0; i < NUM_UMCS; i++) {
+		for_each_umc(i) {
 			if (!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT))
 				continue;
=20
@@ -811,7 +814,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 	struct amd64_umc *umc;
 	u32 i, tmp, umc_base;
=20
-	for (i =3D 0; i < NUM_UMCS; i++) {
+	for_each_umc(i) {
 		umc_base =3D get_umc_base(i);
 		umc =3D &pvt->umc[i];
=20
@@ -1388,7 +1391,7 @@ static int f17_early_channel_count(struct amd64_pvt *=
pvt)
 	int i, channels =3D 0;
=20
 	/* SDP Control bit 31 (SdpInit) is clear for unused UMC channels */
-	for (i =3D 0; i < NUM_UMCS; i++)
+	for_each_umc(i)
 		channels +=3D !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
=20
 	amd64_info("MCT channel count: %d\n", channels);
@@ -2473,18 +2476,14 @@ static inline void decode_bus_error(int node_id, st=
ruct mce *m)
  * To find the UMC channel represented by this bank we need to match on it=
s
  * instance_id. The instance_id of a bank is held in the lower 32 bits of =
its
  * IPID.
+ *
+ * Currently, we can derive the channel number by looking at the 6th byte =
in
+ * the instance_id. For example, instance_id=3D0xYXXXXX where Y is the cha=
nnel
+ * number.
  */
-static int find_umc_channel(struct amd64_pvt *pvt, struct mce *m)
+static int find_umc_channel(struct mce *m)
 {
-	u32 umc_instance_id[] =3D {0x50f00, 0x150f00};
-	u32 instance_id =3D m->ipid & GENMASK(31, 0);
-	int i, channel =3D -1;
-
-	for (i =3D 0; i < ARRAY_SIZE(umc_instance_id); i++)
-		if (umc_instance_id[i] =3D=3D instance_id)
-			channel =3D i;
-
-	return channel;
+	return (m->ipid & GENMASK(31, 0)) >> 20;
 }
=20
 static void decode_umc_error(int node_id, struct mce *m)
@@ -2506,11 +2505,7 @@ static void decode_umc_error(int node_id, struct mce=
 *m)
 	if (m->status & MCI_STATUS_DEFERRED)
 		ecc_type =3D 3;
=20
-	err.channel =3D find_umc_channel(pvt, m);
-	if (err.channel < 0) {
-		err.err_code =3D ERR_CHANNEL;
-		goto log_error;
-	}
+	err.channel =3D find_umc_channel(m);
=20
 	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_a=
ddr)) {
 		err.err_code =3D ERR_NORM_ADDR;
@@ -2612,7 +2607,7 @@ static void determine_ecc_sym_sz(struct amd64_pvt *pv=
t)
 	if (pvt->umc) {
 		u8 i;
=20
-		for (i =3D 0; i < NUM_UMCS; i++) {
+		for_each_umc(i) {
 			/* Check enabled channels only: */
 			if ((pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) &&
 			    (pvt->umc[i].ecc_ctrl & BIT(7))) {
@@ -2648,7 +2643,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 	u32 i, umc_base;
=20
 	/* Read registers from each UMC */
-	for (i =3D 0; i < NUM_UMCS; i++) {
+	for_each_umc(i) {
=20
 		umc_base =3D get_umc_base(i);
 		umc =3D &pvt->umc[i];
@@ -3061,7 +3056,8 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid)
 	if (boot_cpu_data.x86 >=3D 0x17) {
 		u8 umc_en_mask =3D 0, ecc_en_mask =3D 0;
=20
-		for (i =3D 0; i < NUM_UMCS; i++) {
+		set_num_umcs();
+		for_each_umc(i) {
 			u32 base =3D get_umc_base(i);
=20
 			/* Only check enabled UMCs. */
@@ -3114,7 +3110,7 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci,=
 struct amd64_pvt *pvt)
 {
 	u8 i, ecc_en =3D 1, cpk_en =3D 1;
=20
-	for (i =3D 0; i < NUM_UMCS; i++) {
+	for_each_umc(i) {
 		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
 			ecc_en &=3D !!(pvt->umc[i].umc_cap_hi & UMC_ECC_ENABLED);
 			cpk_en &=3D !!(pvt->umc[i].umc_cap_hi & UMC_ECC_CHIPKILL_CAP);
@@ -3273,7 +3269,7 @@ static int init_one_instance(unsigned int nid)
 		goto err_free;
=20
 	if (pvt->fam >=3D 0x17) {
-		pvt->umc =3D kcalloc(NUM_UMCS, sizeof(struct amd64_umc), GFP_KERNEL);
+		pvt->umc =3D kcalloc(num_umcs, sizeof(struct amd64_umc), GFP_KERNEL);
 		if (!pvt->umc) {
 			ret =3D -ENOMEM;
 			goto err_free;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index de8dbb0b42b5..435450bf8684 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -274,8 +274,6 @@
=20
 #define UMC_SDP_INIT			BIT(31)
=20
-#define NUM_UMCS			2
-
 enum amd_families {
 	K8_CPUS =3D 0,
 	F10_CPUS,
@@ -399,8 +397,22 @@ struct err_info {
=20
 static inline u32 get_umc_base(u8 channel)
 {
-	/* ch0: 0x50000, ch1: 0x150000 */
-	return 0x50000 + (!!channel << 20);
+	/* chY: 0xY50000 */
+	return 0x50000 + (channel << 20);
+}
+
+static u8 num_umcs;
+
+static inline void set_num_umcs(void)
+{
+	u8 model =3D boot_cpu_data.x86_model;
+
+	if (model >=3D 0x30 && model <=3D 0x3f)
+		num_umcs =3D 8;
+	else
+		num_umcs =3D 2;
+
+	edac_dbg(1, "Number of UMCs: %x", num_umcs);
 }
=20
 static inline u64 get_dram_base(struct amd64_pvt *pvt, u8 i)
--=20
2.17.1

