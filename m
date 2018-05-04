Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeEDUJN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 16:09:13 -0400
Received: from mail-eopbgr30105.outbound.protection.outlook.com ([40.107.3.105]:63008
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751612AbeEDUJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 16:09:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jane.wan@nokia.com;
From: Jane Wan <Jane.Wan@nokia.com>
To: Boris.Brezillon@bootlin.com, miquel.raynal@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at,
        marek.vasut@gmail.com, yamada.masahiro@socionext.com,
        prabhakar.kushwaha@nxp.com, shawnguo@kernel.org,
        jagdish.gediya@nxp.com, shreeya.patel23498@gmail.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ties.bos@nokia.com, Jane Wan <Jane.Wan@nokia.com>
Subject: [PATCH v2 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to recover the contents of ONFI parameter
Date: Fri,  4 May 2018 13:08:13 -0700
Message-Id: <1525464493-5006-2-git-send-email-Jane.Wan@nokia.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1525464493-5006-1-git-send-email-Jane.Wan@nokia.com>
References: <1525464493-5006-1-git-send-email-Jane.Wan@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.32.160]
X-ClientProxiedBy: DB6PR06CA0009.eurprd06.prod.outlook.com (2603:10a6:6:1::22)
 To VI1PR07MB1616.eurprd07.prod.outlook.com (2a01:111:e400:c546::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7193020);SRVR:VI1PR07MB1616;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1616;3:h+9PrOz5Tm9UJYnKtgcDw65dpR+9n6Gs3BumrWVoTqHYkTuFwB3WiVSZZtqCW9jYcyWTzeu7Khm1c2k1krIvj6U+RPPHvbzehDBXnNCcO4lvyIOGzMPDHo2rlLleIQ/WPqVUGh2PP2g6DLx92qEz07SSG8aVzOcjINvM5+yLuySu97CV20hIwco+iaAer61WRyRmD0j7BI+LkS/Xl2EI6Drk29tb3wQ2vxLxjksfazCCx6aaejtUaG2YAWMlJHbFNFwUpgD0y9FkrQBv9tpXdHHBF86D6I/Ci4vbUfGqWl8=;25:lnMl+axz/nIDY+bIMkG/EHY5TLdrzut8IC2i9CQ+knIwtudm0CEFIrDi0t05D95pDpSUQxVtOkS4nFT0j0YtCvnnOPbePegcqr2dAHcq8j4fAc3FQIERvPkxrCtltedwy1arT0EKuj6+RlG+FjccRp2d3QZOOSeCYiJrUl9UoKoduRtiwUtxcam8kwMggwKWG3petAWCDcZAg/7P46khdS9xuNs+a1FVE+xQBxNsH/jQfgCgMAd+U+xmK/V2BYuSqBRGi2jvtKfx6+FzMHXT9VYnfVWYa0ARdAXtI8vr9UFeO11U/zpWakU2BeQhxrpbBawTeWsUt0zmkOcJb7xSJA==;31:Ky0XxILMSB+ERn3JTJLfheWlrJo0/7keaL7dWjMWeWy5yM+//lCCZgekQSjP7odDyk+CotMnP4QUWu046bVCuLfCqX1jMg7bZW4SrWDFIOx4XWHZTJWD6BUMd+GuB9i+Woy71s1WLFVJ27iS+Tk6AwObdA9ALYhUJpDOeeP8w89FhCd5Q3TUDCEcOL6WCme3mhewOvn9Lb+91U85vUu2laY2yvfTRj10ZHv6vx4erwk=
X-MS-TrafficTypeDiagnostic: VI1PR07MB1616:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1616;20:RuDKzRlO1VPe0kWhj8gptkr2C99p4nMhibcDQcEOLqhxbcE88Rex8cIuqI6ZWYDh9vxpn7lClER24Gz2YBO8LWEDjLqqGppOhK34GOBn7O9zaxibKMxAzNUgdrwRQRC8FfCHEpL5MGPlBF/f/IWSG2Rq60VU55u8a7/ijIPrwMS9A+p/siYjxlnGHXc55vDTlekLaRFxk4EcvOz6BmlKImGY7H/sMMeODfxHVcjgXoz5PM+jvgpI2+ZzNMJU71xSqcG3p08HJp1ZhIgvEVMiQ8905YcoW6S8pn+QofmTBZbGg2ytNTzMoTPboVIF2uogOMMGGjGm5+GysE9PTkG2qXyI5d4pdw8BH2ZE9D+Iv1O1i665sC3XzlYASF93VH5RmKSXTwKncNCL1/mWw/24BOoSOk5nTxLU3oiOTGt8GfAxT1X3BAVDiMsCYycGYHSFiKI2ibWQ8V6UycpHHzJeaMfD+kyf15b4+v4II1DYyUiR1f8FyAFbOHHlRD4wEDKS;4:yNYC9TuRNCt/0Af6qKzVgeP+o4xk+H4WgjFTdMUX8tWn43rKc5x8gEs1K6Ovpjl6UjxxHHPpy0FBCSg5LDTtKY/++3F6yyZ5ai/9ETh9TKgNYfK4GsOHZggwYqdUlMp94PLx2UBDhBH1K1kninipYXODhqQsVv+e6LRBkDlYnt/IR+cxabQrqgJFW5NfFjHkLUjId0JVz3DCiblZk3cWzcQB2ELyjQ7YRAKNajqeWTV2f/747t2Iehq8bzUctiHlv+Ep9nE0V9m8auWd6psjIcoMoeonaBOU+svvS/v+OLl1mwbNIzu9C1JgiGjgoaJBbWjBsgtnQu1hR8gShxa9Vu5iHMAkCRtojZ1jZsmiEVA=
X-Microsoft-Antispam-PRVS: <VI1PR07MB161663B143EBA5EF02EB64F581860@VI1PR07MB1616.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(11241501184)(806099)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR07MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1616;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(376002)(396003)(199004)(189003)(86362001)(25786009)(4720700003)(105586002)(2906002)(16526019)(186003)(68736007)(6666003)(5660300001)(106356001)(26005)(8656006)(6116002)(3846002)(39060400002)(48376002)(66066001)(107886003)(47776003)(53936002)(6512007)(305945005)(50466002)(36756003)(7736002)(51416003)(8676002)(81166006)(81156014)(76176011)(52116002)(59450400001)(6506007)(386003)(478600001)(4326008)(8936002)(16586007)(316002)(956004)(6486002)(11346002)(2616005)(97736004)(50226002)(476003)(7416002)(486006)(446003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1616;H:cobuntu-jwan.gainspeed.nsn-rdnet.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB1616;23:eWZAgEwmekToJPXIumN4YFccSOMeGLrPOrdGOFsg8?=
 =?us-ascii?Q?fK55UXzkutTdkcVsXw83/Ar6L8uBU48QnuMrixkqz86+caGLnkTzgNcnoitX?=
 =?us-ascii?Q?j2nOi8RoVqi/Qu0gvmjtmoosM84qU/5QbKoyIvoget/vCjxJd9ktMMtSjiWN?=
 =?us-ascii?Q?LPf1TkWlb2GCDUsm0oLoDuyNLvCt1yYKORQIPm+ck8zGqPrz3ikZjCKlVlbH?=
 =?us-ascii?Q?jhVR+xGRZd3rtaB+ytpXGarwGpKYPHaz0SsAW1LyUGZ+B3LN/Cb209s1W6hu?=
 =?us-ascii?Q?Gzv8M/oxe18aDCeM7E1k9gWRAdBidhrtlplVX0vS5JPtnBH/cwgLu6Hje8n9?=
 =?us-ascii?Q?3p+epB0VFEyGRDlM9aJESJZLLVcWc7IbOXJv13gAgeH1mi6ih3huZqigIyL5?=
 =?us-ascii?Q?/sylIJWGJ4z+W7GloBC7THC7vJz46PgcJDPBdAC+6XkBfsT1AzJnV9uRVRop?=
 =?us-ascii?Q?sRb1U1UzwzF83SiAeC4suVqwAZmILceejGAnB+OGmr0rGdn9s9aq1CpTKpjv?=
 =?us-ascii?Q?GI0wVDH2p/dZzPcVfz60EyAWnsxvDrFcshpuvbvi2HxRp8BGRADpeDuRYij5?=
 =?us-ascii?Q?fk0vsYMTZptcsVF4X2cV9y14qB+dkgDidepW4ow1ifNzMWTnQtIBZuukMfS3?=
 =?us-ascii?Q?00VxNxi4ZN/+r5/nWVXJfaJOT+06342aEvwLj1tVZNW3HmDbyfEs61JtlHKy?=
 =?us-ascii?Q?em4aDdgWEXATETRlJobfc+hrQMDLMpCSIqSzdKZ61wOb+nKuDevT7x51B5GL?=
 =?us-ascii?Q?Ex9ANsKM96g03cA/3OOB3aJxlN79sUz5lOJI/triocak5XCyYxso2PFhklbn?=
 =?us-ascii?Q?gZ7F+Bo6n0XNfituGrVi+NkgTbpzWKUlGZ89TYxRAAOxcOz/GFbHZuLD03uB?=
 =?us-ascii?Q?7RLILN/g2W/V9d9paGWsmGIISLJjFp8UbckzzUaDkM0Qyd3+tYVVr4bi0wVZ?=
 =?us-ascii?Q?+ReBoE2MHgAZsWzqPJBfUmd0TzQznW9YMOhCvHE9BdrCDUDgAWLVqQrlThSe?=
 =?us-ascii?Q?60UDzpDGv2PAJYYcyOWLZKEcRz/g765moFLujAv3tdzamUoDfiP9fQ2IIPZ7?=
 =?us-ascii?Q?0O90XKRhZsXsOrypjx3AxPOAOIrw9vBmVnxO1lLSvuyo/kQm/8fNZjksy6j/?=
 =?us-ascii?Q?pac+3gl0y4khCfAbqS9uB1lKcv86uD/2a9pTyoR5ClNpxdv9tlz9LczOeqyB?=
 =?us-ascii?Q?Vs5Z7t/TDXlhmI9uzXm21EGHUXKmYo4elGBNoH9Y2qNjj/Pb/yj/oOEcVPos?=
 =?us-ascii?Q?BK9RRDmnCPhjCefTRN2T45c/O9X6qTcGajNcjnfiVjiy3Ie050TlflMKrjEz?=
 =?us-ascii?Q?uCCT1imIOSJC/NtlQ2iRieAzpMflDR/ru4NB0CmwfMN?=
X-Microsoft-Antispam-Message-Info: +rzUJfqI2kSpzDnl1hGh8BtzTUD9pcEMl+cz4n8qmVncAqWb9yWFosC6FLH9Q3vaCJAgdZwwgkf61zYp1a06vbrP7nUijbKiL92vglo+9n491FwFUAdPPZTKr0IxWW4zpXtRfFzphDQQz2D30UzycSQXjzGbVxolwOWZ+jCIkFJLM0zFyI1LtMdc4u6Rb0sWkgoKbgyKuqLfcfGTVyhaHlBJI0D9iHcHE11e7DO/LTA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1616;6:wbBIICst2ubAzZ0S6B9VSGjeoKwjeiCGWlS/McpUp2tvEuDM4MWVa2SF3davZH5xyhKOlw60gHC9n5f2i8+Y+k5Weq4whTe12Bo9ZGlPETAb4bPp1OaJf7sXJnULQTkk+cYOpf9FA2nzftUoiP92C6jpfoUjy92zLvvmepjkyHPgyhRlywe+oX7fU75P7xX2LwJVSQi6GL/e4y3PY6Pk1q5VLxgot24W1vKX4VBQMqxcWhwix0xsuGWILYAQpWqMEhVMKHqex4Tk9iyoD+2LWx8d/OPVYh78W5YJp5XrXIELxXQl4Wt9TLsoW1R4DxaHXmb+FDIoV40YztQDzqyjnMlbVc99O0ylWURbkFYqnRv2dZTqp2Udkvvd2IcA0VWk98d3GCSipif0v6503ISH39rb48C8Ktg8Yjidi2OwW2KV2hAp51vBzZzm62ofOwVHTff9Z8ZTpcFUW0LZ1YOdMw==;5:RqC57Tlg+G3MB8ioFc2EtdIJ+8hupqyCB9+KlYXyRl74LD4ce3fIQlhYtV327OvWXVBRty6Jwhh+XCrrQOz+6oh9zZrCtMjQ21o66ha1JhcsggwbJeZG9TV9ILpZV9TVPAUNeoGBLgVTJKi0vzrNw24n1UesatvIrbQ29q9R5oE=;24:KcZsMoSXotpoamYIr0mr7U2pKKPgPOZ5oQ26+PLFi3blmYtjaWPO1iPYM/4KvpBOgviRjGV+4uZkJ9H07sowJiS2iROlOyGOC7EJXnDb7lw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1616;7:OmYEAOTuv2dQuTwn+1ZdJsM3DdYJHwpB/8t+KIZgOwOMuFcJ2zhKcZrpE/RdD/utbc9i4xuETXK+nXc6+/rgoBweVpG1r798lWYrZfb5Oy7PhEv74ibJu217ZKwknLj6LwEtc0GjrxmbI5a9OkSGkK1UTbaw1O074O1u58j4dHslzrCdQyMJWrYWidJkP15+9NLOzBaSltBAPo3DQworYMqzM1U49IHBEn7LQMm2KYSWveEfeDuV46Qg9DdcwEN4
X-MS-Office365-Filtering-Correlation-Id: 7e72a17f-61ba-48f2-880e-08d5b1fae290
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 20:09:00.6546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e72a17f-61ba-48f2-880e-08d5b1fae290
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1616
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
CRC values, the bit-wise majority may be used to recover the contents of
the parameter pages from the parameter page copies present.

Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
---
 drivers/mtd/nand/raw/nand_base.c |   36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 72f3a89..464c4fb 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5086,6 +5086,8 @@ static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
 	return ret;
 }
 
+#define GET_BIT(bit, val)   (((val) >> (bit)) & 0x01)
+
 /*
  * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
  */
@@ -5094,7 +5096,8 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_onfi_params *p;
 	char id[4];
-	int i, ret, val;
+	int i, ret, val, pagesize;
+	u8 *buf;
 
 	/* Try ONFI for unknown chip or LP */
 	ret = nand_readid_op(chip, 0x20, id, sizeof(id));
@@ -5102,8 +5105,9 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 		return 0;
 
 	/* ONFI chip: allocate a buffer to hold its parameter page */
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
+	pagesize = sizeof(*p);
+	buf = kzalloc((pagesize * 3), GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
 
 	ret = nand_read_param_page_op(chip, 0, NULL, 0);
@@ -5113,7 +5117,8 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 	}
 
 	for (i = 0; i < 3; i++) {
-		ret = nand_read_data_op(chip, p, sizeof(*p), true);
+		p = (struct nand_onfi_params *)&buf[i*pagesize];
+		ret = nand_read_data_op(chip, p, pagesize, true);
 		if (ret) {
 			ret = 0;
 			goto free_onfi_param_page;
@@ -5126,8 +5131,27 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 	}
 
 	if (i == 3) {
-		pr_err("Could not find valid ONFI parameter page; aborting\n");
-		goto free_onfi_param_page;
+		int j, k, l;
+		u8 v, m;
+
+		pr_err("Could not find valid ONFI parameter page\n");
+		pr_info("Recover ONFI params with bit-wise majority\n");
+		for (j = 0; j < pagesize; j++) {
+			v = 0;
+			for (k = 0; k < 8; k++) {
+				m = 0;
+				for (l = 0; l < 3; l++)
+					m += GET_BIT(k, buf[l*pagesize + j]);
+				if (m > 1)
+					v |= BIT(k);
+			}
+			((u8 *)p)[j] = v;
+		}
+		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) !=
+				le16_to_cpu(p->crc)) {
+			pr_err("ONFI parameter recovery failed, aborting\n");
+			goto free_onfi_param_page;
+		}
 	}
 
 	/* Check version */
-- 
1.7.9.5
