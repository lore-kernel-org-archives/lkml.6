Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755910AbeBOVKK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:10:10 -0500
Received: from mail-bl2nam02on0077.outbound.protection.outlook.com ([104.47.38.77]:8944
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752361AbeBOVKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:10:08 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-edac@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de, tony.luck@intel.com, x86@kernel.org
Subject: [PATCH v2 1/4] x86/MCE/AMD: Redo function to get SMCA bank type
Date: Thu, 15 Feb 2018 15:09:40 -0600
Message-Id: <20180215210943.11530-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:404:8e::21) To MWHPR12MB1917.namprd12.prod.outlook.com
 (2603:10b6:300:114::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da4a028f-162b-4aa1-4791-08d574b87be8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1917;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;3:9EfqgfxeUnsp1uY8V7GfpBoCddowcZagdC32jXVi+JBNhnRiGp1/52IaXlXfOZiqg8HsJhni28KWGQVZDs6+3Py6QZWoXImIg/jdXFQTNQV4hHPnmDKbGjEF1xBSIDv7RjwFJZ8GTgbYk2rfhuuOitmugMhWDmZ8P/PNejDRf2FZetSCre8u1aovq2BfRkq09j4zkJEkX1yer8S1ohe2ttJ5tIztPjqygnFLozuB/FFmADooacopCPf15QsAzHmS;25:d+938N5qlBpYpdBuGDJW5MaTHXlMYeCAfI1Q3bHGyhj1LyfDY68xEKGi+OVgMw9u4rG2p0BbijleJhE1dbSVaBYmyf7vng7bceinbCrJO5rRdQAiCAZ3OKpxR0EDa0Ndwj/ElAxIeY8+1KiE6fVnGi8jJkAmrs/QWCEalwOnv52AoEgzU0BkFt/iqtEb3pNtjrif3vt4dzX0Ll53x5ASYhG5jjeGU9+HosD3mAIY1BfZ0ijjdoRUFnTDnb/06fYmitHgPkUD1cmHoMA6RyQk60ldoItvfxS9dPWCUx6DBcL00o09fLXvTLy4TJ+tLpKMPeMG5XxDIKlfbC3qFSG2xw==;31:yqosfgYG45m1Tx6gFJYnudui3xLeoZyoPQQk3IBuE0EOAu4S08/E1zxTu52Kfvn0vbzU08B04HRTuL13TVQwkNC+vPin7SSw/PXUwaKc5SNDXHzBMsqgUCfq/H3H6VavCKLN6yIZDt8TDvIpxYzyNtNkRSzMrDlNfcibGUYzXKolwKqLjesVFjJhqma8mbxqkImoRdt9lZGdJIb/EiQ472BRDe5VXwFL4q2ps2TwCQM=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:j0yUMm0vlDlR1KEtilf6rLfqm49hW2cKdM3DgAJRa0ipJH1T+UVw03Y2VEXDUJJwRvyxoxjU9i645jZlpOIyeft+P79KFLzAiHa77psr9yisuwlsMqKCNJcXwgi/QlayC38g5nujz2h/cMCy7z4BSeBu6JeVCeMAcQN2AQltzG1mwbPkaxSyLttlGuVQEVuRudL5hhEstGPZcBTbyjbjjBZrgbrhEU1Cr0BpYWEz2vO7cau6qnDHsalAJ527zhH1dl2dNCQlriNdiXx0hvJzgOYEILhCCPFLmK9LJ6+hxUTgNk94UsCKXzUenzi13JSTpJS/tsvU4p5Fouc3LLGfot/BiHnB7/xCpgVCwT5RwAgvt+KxCVhD0TxasMZzY2h3alYMqkz7dQXgONbVuRAcKIdH8DaX4GM3A6Fs72jFHeWPYtFDar2vjkYU8GaQAModQSRL1dQrck0Xiwd0Q/li/wZ5DNKH3unyt3taApQZ1P+9RleRrQax0PilqNvs3htT;4:h44rDNnE+TUtEup8CtzT7DXs2DSlCwhGWeBJIW8DUr8bKpxW/S8Sl8ZRgvGubQR3bUZltTWJvNuHB7ipjlVXuV5I61CsqkhE/gJ3doG0ntZLrMVvG0B/rKIwykGODdE2xRhM6RfXd0dpQil+SVhXcAML4zNrqloy4oI+vEQgzkooMdiksedDVdB16TqLHobGLoRgSDRM69lB6/nwz8+QpktnWY5tEHT1VRMZdtrU0LMKqKD8FpM+QNFt33p8LFs6w19t9oRDYMxsePvsgtvr/wO3yifgJqL9HdaENjGHerAv0q2s3rNER/TkHuNumaje1DxdhsZg46P28vciCXLFZkOWQlM61KMXuAZFcI3m8BWi9S11u2NN4YgTqIuIw62M
X-Microsoft-Antispam-PRVS: <MWHPR12MB1917E34E4B58ACE5D1DA88CFF8F40@MWHPR12MB1917.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1917;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1917;
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39380400002)(39860400002)(189003)(199004)(50466002)(5660300001)(2361001)(97736004)(6306002)(48376002)(53416004)(6666003)(305945005)(6486002)(2906002)(4326008)(1076002)(53936002)(966005)(6116002)(7736002)(3846002)(2351001)(106356001)(16586007)(66066001)(47776003)(86362001)(316002)(478600001)(7696005)(51416003)(50226002)(15650500001)(386003)(72206003)(6916009)(105586002)(26005)(8936002)(8676002)(81166006)(186003)(52116002)(81156014)(68736007)(16526019)(25786009)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1917;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1917;23:FQSWMLcf32hXNfOBPFK5eriro4WiT+0LKP6gYcfTA?=
 =?us-ascii?Q?J5cUW5zawlaNiSLypl0tnNKIfaFgEqcEIwF0WyEStweJGAvyHOy/RW0Em7G4?=
 =?us-ascii?Q?YaaMRaYdnnWzS1zOvaP7bU96EuxqugLwjvq1tkaUnjy1UuFX+PsCe0ntqM3w?=
 =?us-ascii?Q?+Ou+vLhhoA5j91WN1U1clPoy3tllCmw6EAdv8b/y5TNywWl4V4BoMXWZNEKK?=
 =?us-ascii?Q?s9ONbuksvV86tmJV1CjH5Q5QoBksHidiLicU2idDDVHUtVRoTxUliiRmfGRV?=
 =?us-ascii?Q?S1cVWXkaiyTmqC0e4ZlI3s7Q3Ew9zz8PtpBJmLCchP9RuTUMPuNK/MLhPTVG?=
 =?us-ascii?Q?LBMbrfCW3+cIrmYPoH3+m1VbCiftbBI+nD4pXmuN4znIkHoRNdf/zpRSyf77?=
 =?us-ascii?Q?Y1ESG/8xNky5H+2GcN1LyKSaAFL674+QAJ4kyOo+0ANwmCBdZIFLe6Q+a23N?=
 =?us-ascii?Q?GFYhnWh9vhok46D4nL/AYRb9rp0Api3XWcmcqv75G5WWlWIPBQTkJ/R496xS?=
 =?us-ascii?Q?KA4ZPGG6O2e/DhkJ8zCHyN+Luw1lkYhNKxA8cECdGtcQbTkdPxV4SkxSf8de?=
 =?us-ascii?Q?ou1H6CIi63c3/GkvIJNM8GXOu+wDG2PsdxX8rWWnc19mStIAYz5fjNn05pEN?=
 =?us-ascii?Q?+AMEBNf9pkXgN6n5upVlRWRubIuZ0Xp9tOH1p0BQcTxkn569Bw7lqL/PeAP/?=
 =?us-ascii?Q?Jdz5vSr47As+Zgctw3LA21k6shjStE/ULG2AkwlSoAvfJe9BE70bLCO5y49x?=
 =?us-ascii?Q?vIyJjexIgh7fmiGuwsa9p3+5UC87YvTznTHlYaKH7zORLHRA1O4H61ZrNRjE?=
 =?us-ascii?Q?VCo1hu+yplTAEMc0nda8DpSfv/E4icUf2+VzpHcqpbI8G+x2wcKQAlBmtukz?=
 =?us-ascii?Q?vFRJ5XcOPRx2pPWt/ppDMrKMiR0dXcZNm8dNTs5WfPE5XcbSMEIQpMMMuJBL?=
 =?us-ascii?Q?DyPYXPmdms4B7v3/Hlf/XLKol6xIvbgzFvRUsRl9Vkl6yrMExT7HcYCfuMPH?=
 =?us-ascii?Q?84qRmSKECsnrThkOEbvZ11CcuBuSUXFGJpH5lOsYapjL9ap43l5jyHpHVf6M?=
 =?us-ascii?Q?HAjtAPvU98q8MhnZL9hakraUrGNC4+56wQOT6CjPjUPiulnW511NgaYcSgiS?=
 =?us-ascii?Q?SOFgkC+AMUUIWiD+i7eAan+kKWHQ3hrMXZzLF5luACWNZ/whb18iRXJ7khLz?=
 =?us-ascii?Q?5iWnbdBkhZkgwSfMPvUC8OwFceNYIl7KW/B?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;6:68nTf5CJt8GvnXQrVx42OLn+f+5euR/96RkMx9LXYseppDl8H7GFsph43wt7CNt4JCMqG+yWNE6VtHZ6pE2KoHkqCLsA3kmbGKvL7mGMUcjDxiAyDG+9CHQsDNB+EMhca9dmO2Ffe0uHlIVZhBEuWCSMwQ9JFW5zn8IF8PBH7g5xklEilDSdiq0lwhB7qt9v8LqALtt3m1SSNj1ZsIefAXoe1HYf9vkVI9dK+KVW57e3JewKJHFtTQucoxuscZobMuqHIBFoxid8B99LTPE+ugl9XjDvCxCHVOBE6YuPjwclGC8Huy42iA6eCBKTk9xubS86gOaLaP74jdRmJzrew0ZCWR8vVYkOtklYE0j9RoE=;5:6MhQpXYGPc96poeR6LzxqXYc7IvVYRC/fIeg7NnSOfpLW/ulKVpgun4Dy0B9oOsEzNeaKNbs6ZRphHL3WigkPV1UFdE8jgikrLe/pA7K4m+dpeQVrXtbEEh7syEbsQulJ/jh2GsJzbFbjdu6QWLH/+AtA80pARsRg/8CJzSowbQ=;24:iUpyZVencAU52dRXYwux1s9zwOERpDnmm44ygo3RDmjb4BkiANCU6iyRRNhpHex535wyIWsyIFM0cKj+EyzwIqiDIOy4HgsKw7YWK/N/XiM=;7:8mVMqXtOWR6QZAhP4JkgpzGB+ccEA9SOY6wVIDkhnzZVZQkIYno8NHylglVWsreiSd8WYolVwQVfRe3esjzaw2q7e+2E+vfTYJtGMSaJ3wBohmMvOuSHc1o1GUrtYKbQ+8Ic14NbUmP2C2/t0MiI5Y0yhK9pf6avwIi1ut2PWK7m4e8jqd6L620IHSNErLRdhSitq5HOrssCBqCuA2EVb3cs5dB+yYbPJm3JocHOkkine8Xx7Mpagh8IIBv3Mley
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:N3pA+YuSXleGdPwK4LqayzmE2oBqwAdeg8BZ4DKCjJQi9ERQ1s4ILuFPgRUnGNRUUhcxNNZQDd3VtxANP9bDj23Rr6Q3o8EwIjF44lzSJ3rADSBqSUPI9uhmizonM6DCVopTFGcHPutszCP9+9qfpzYxg+Ajd1J5vdikLca4TjY2p2rvUqN3fxNEypXG0+szAb0ZJj0IqaAfGIMQJTdB9H9TF/m9qINCITDwo3WfXKOjDRvVNkjHD/OFbO4yZ4FE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 21:10:03.4418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da4a028f-162b-4aa1-4791-08d574b87be8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Pass the bank number to smca_get_bank_type() since that's all we need.

Also, we should compare the bank number to the size of the smca_banks
array not the number of bank types. Bank types are reused for multiple
banks, so the number of types can be different from the number of banks
in a system. We could return an invalid bank type.

Use smca_get_bank_type() in get_name(), and change type of bank_type
variable to match return type of smca_get_bank_type().

Cc: <stable@vger.kernel.org> # 4.14.x: 11cf887728a3 x86/MCE/AMD: Define a function to get SMCA bank type
Cc: <stable@vger.kernel.org> # 4.14.x: c6708d50f166 x86/MCE: Report only DRAM ECC as memory errors on AMD systems
Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180201184813.82253-1-Yazen.Ghannam@amd.com

v1->v2:
* Check bank number against MAX_NR_BANKS

 arch/x86/kernel/cpu/mcheck/mce_amd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index 0f32ad242324..7fbb19cb1859 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -110,14 +110,14 @@ const char *smca_get_long_name(enum smca_bank_types t)
 }
 EXPORT_SYMBOL_GPL(smca_get_long_name);
 
-static enum smca_bank_types smca_get_bank_type(struct mce *m)
+static enum smca_bank_types smca_get_bank_type(unsigned int bank)
 {
 	struct smca_bank *b;
 
-	if (m->bank >= N_SMCA_BANK_TYPES)
+	if (bank >= MAX_NR_BANKS)
 		return N_SMCA_BANK_TYPES;
 
-	b = &smca_banks[m->bank];
+	b = &smca_banks[bank];
 	if (!b->hwid)
 		return N_SMCA_BANK_TYPES;
 
@@ -760,7 +760,7 @@ bool amd_mce_is_memory_error(struct mce *m)
 	u8 xec = (m->status >> 16) & 0x1f;
 
 	if (mce_flags.smca)
-		return smca_get_bank_type(m) == SMCA_UMC && xec == 0x0;
+		return smca_get_bank_type(m->bank) == SMCA_UMC && xec == 0x0;
 
 	return m->bank == 4 && xec == 0x8;
 }
@@ -1063,7 +1063,7 @@ static struct kobj_type threshold_ktype = {
 
 static const char *get_name(unsigned int bank, struct threshold_block *b)
 {
-	unsigned int bank_type;
+	enum smca_bank_types bank_type;
 
 	if (!mce_flags.smca) {
 		if (b && bank == 4)
@@ -1072,11 +1072,10 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 		return th_names[bank];
 	}
 
-	if (!smca_banks[bank].hwid)
+	bank_type = smca_get_bank_type(bank);
+	if (bank_type >= N_SMCA_BANK_TYPES)
 		return NULL;
 
-	bank_type = smca_banks[bank].hwid->bank_type;
-
 	if (b && bank_type == SMCA_UMC) {
 		if (b->block < ARRAY_SIZE(smca_umc_block_names))
 			return smca_umc_block_names[b->block];
-- 
2.14.1
