Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3B6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91EF20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="RIW/qr6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91EF20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeIGXhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:37:17 -0400
Received: from mail-eopbgr700102.outbound.protection.outlook.com ([40.107.70.102]:48769
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727223AbeIGXhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8OY+/OCATD2IHHwRzbw5BR0ovos0s1RjYSg68UBPiM=;
 b=RIW/qr6D2EplM1aRTTCHsAn9YhsYu64ozg2ss00eauksgwHAU2SVOHiWvgqj0lJzkIXjlcXSuyqKegeoNDiOGrcemaahe02UxuW9KbsLPYdJ4+M7+NEssNf0sx/O5VcCeW2NJyXB6j2cHk1mv6yt94BYPFZGifKRujzrzte+M7o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4929.namprd08.prod.outlook.com (2603:10b6:408:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.13; Fri, 7 Sep 2018 18:54:52 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 2/2] MIPS: Fix CONFIG_CMDLINE handling
Date:   Fri,  7 Sep 2018 11:54:14 -0700
Message-Id: <20180907185414.2630-2-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907185414.2630-1-paul.burton@mips.com>
References: <20180907185414.2630-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CS1PR8401CA0027.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7503::13) To BN7PR08MB4929.namprd08.prod.outlook.com
 (2603:10b6:408:28::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b76b4d96-882b-45b4-e987-08d614f3657f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;3:hzTR9mglvKknUOV1PctVix1FOtkRW/RY8VRDss29S+mWaggUA4eXzmi0PpnhkTdwU+k6qfc+jDrDOn9zqtV50w5v3rnMYhNqcX/wyUTiQWyOdX2f6odUYT2x8RD7zAItpLLE89wTd+VFBq5BhyPq6aASsBmVu54Wq5un5lalZ5Zk3ET1EuvZ1jnOuljC5L7AWW2SPNMllF+BYzPqSkZl034eYhb8aGyfBZMQW5j+jJf99JlJlPxm31VLGs34V1Z9;25:ImrWF6PG/Nh30IvZuWQcZa+JV4+0/qNkzLoTQu/K2nQQ8SF6mR9nVIb70FDRqxmgd0Nr0FuVEgkX4y3MDnmp3EU1tcGIqKoi0rRuf0RTbDyJ+7uwzEw0wZlitSpj6zbBC6tbBmPXlDgGDZrl6SBAzjOXiCxZpC3IK5Y+2nMij9dqQ9wuD+Cc+Xuk0IQScJms4aMm/F/7vglsysZIJoOG3RwLd6Q38fUFmvYG/oPDgc4KRujAbWSbX6gxCxQ0ITlDnSlgdcXw7gnva9GkBLhsoGdA80QtS0Ai+Fv3kjY7WFPJVV4KZ3wtnrvPMg2vnG1ZQkHIxf4S80/PvThFp1KFkw==;31:n7lBZNbDU+CuZXxEgCoYB0vLsAXMrVdIm0Xp/nDd46FF3W7kclwseG/mIUO9Fgibk4J9euin3BYoKT4L5AINNCgUUTqNY7bmGEGbOHmQqb7Hpd4GCIe9m6/j534hkjraS1CM5SNaXD9kaJII00AFgG8bA67UKTPFvUIUwq/WCUArSEbXrt+/RG2Trtg+s/Beh/jSVHXUMUTCsaC148TZH4tQegrnzHQYnrCSArcSnnM=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;20:ucYh6Sc0tJjJz946CItV4qnmRgb4aoqj6n3l49m3d3Hp1tofQTirdGC4urxG5sTMWKL3+VxVpukbROR8tv1De5RiyNcg5iGryO4XKu4JbQOHTXQnPmu4dTLlTQncmoVDmG2xPdoB0A/Khgwa8AKXr7X7y3tNqIF2usov0alA0E084x7qdu22caEN0SdjOLIOliot5nZsw4eAOzuET3zUNVYgT0/w7I1vTRgJOF/vp8jlHE6YN20Kzw8LWe0tvIyY;4:bzzjWYk0gp4iG3AUhIfSEDZmxIk2tkp/JF3EwS8MtFvfJmDZBkmzySVLq/l7N/m/S5pQh6EURMi64/szMITDqiIzhqDuEbR7o30Ko4srsdzOm4Uk/ql/FdoQdUGU72zP4t1lV/4DmtLs38tWGfd5WEA7c1FA/BR1D82ub9yLStfid12Xfc6BcSWW8osEEVLOhRA99Imlfaipe7F6nx5KdyjWENwmR2/MowtPy7MVLC+4SLZb1miu/vwQVtBAHcWC7IXVyXym2Yr7Iag2WfTL0Zy4sc2S/LNWSx3USZFWZ+wO43JkbKhZoNoTBYGh9RCtiIB0LsMUsaXkFJpVpVDHEcznIZXElGR3ml0A08ODq9U=
X-Microsoft-Antispam-PRVS: <BN7PR08MB492931AD2A05B54BCA3EEF43C1000@BN7PR08MB4929.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BN7PR08MB4929;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4929;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39840400004)(199004)(189003)(14444005)(42882007)(39060400002)(105586002)(305945005)(7736002)(476003)(956004)(2616005)(11346002)(446003)(51416003)(52116002)(48376002)(186003)(76176011)(966005)(6506007)(26005)(386003)(478600001)(36756003)(6486002)(50466002)(16526019)(81156014)(6512007)(486006)(6306002)(44832011)(8676002)(2906002)(8936002)(1076002)(81166006)(3846002)(6116002)(106356001)(4326008)(316002)(47776003)(54906003)(25786009)(68736007)(66066001)(50226002)(16586007)(53936002)(5660300001)(53416004)(6666003)(69596002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4929;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4929;23:dMhkmdKuhYxWQVikRI/bGlIK3dVl0m9N9e2C7KgOE?=
 =?us-ascii?Q?/JegClZozhzBOPzgwQjVPbW4O1dmD9K7jxmY2dyVKMgTT6IFk1NYl162QytK?=
 =?us-ascii?Q?xC1u9L16Trl4eIU+TVQliwUFMWyl6gD+yGTrwGQh7SK/DGVwYV7ilycCwsPs?=
 =?us-ascii?Q?oNoQlzM2GFMjuUFsVSM78jDTn9D+Js9xnZhLaE2V4UJOqZsBS0H5DuotOk9k?=
 =?us-ascii?Q?FfOHEsopshM8y81qBaOoaHDJmQMsrWB5Lzx7JuZBcBZmXfzZpx7B4xQdhBYm?=
 =?us-ascii?Q?0fcSqfiJHWSwMCq48i40Jv4+ChVQNVwHpmiNtJXirvmHH0HSXwhd3Tj8+kZj?=
 =?us-ascii?Q?96ojV7IkAn3MdVNMgYgZNZ3FFcGFmmreEC+Q2fXaG6xRdMapUEDfpTFfT+Ka?=
 =?us-ascii?Q?HtEn+Of9F30HMY8cYwE/sjXjuhvxCfRQyDAMc6sFvpvNZtUjgGJ8ml5Wr1Oa?=
 =?us-ascii?Q?cV1TyjPOk+M1wr5utx4HPlmkQas1V4QN/CSyMwpzodS1+fBT3fFZU93H/n+P?=
 =?us-ascii?Q?y5oG9cVc1XSLenyqOw6btoKhaCeUebASM5Y37shxJkv307sHXAuoTxd5bWGC?=
 =?us-ascii?Q?vY5QbH4rdsPLp2AyOS2MX3EbV3wPuejN8kJydQ0iuw/JjcN+6lnOlPBUSXs0?=
 =?us-ascii?Q?76sjSUVlrFRLbYdsQ9mNnjbOAntnG/aUHRRr9duzvtc/YN5ah8+YjO0k4a7i?=
 =?us-ascii?Q?1sWUnFDGNbiv9vRJb1V9rnUS+kd7tKwk777jq7x0Xl1/evT2uWFeBg3YLt7F?=
 =?us-ascii?Q?IZhiwmuerk82onXzKpyK1HFg+bB/zf8OmKbIsYUKbYqPf61cPm57hIiNuCl9?=
 =?us-ascii?Q?OhTQcl6DgdRY/wFNwLhZoy4072FMQEhhEiusr1BA6aY7vINDZmuGAkUOkH7a?=
 =?us-ascii?Q?GQzW0TcTkAyiBI2GWWx6oUbyYFPU5fRnp+AuVud8GXARYOWM9ufz0SmCxlry?=
 =?us-ascii?Q?tGexDK7rnV2XDQrrnEwdB24GaFFiyAJWKEbR4jhqd/QGGRHeIJiQ5GS9yfgW?=
 =?us-ascii?Q?8bpaZPu3EgGGozS4IfKGI/R581NVIL1jwcFCoa1uc3575GgHnmzVAD01dQQD?=
 =?us-ascii?Q?fFhtAZyybW/UE8HeJ+RaTfvoJXT6fEo9EjtPNe21I04yecNY++8eleTEAXGq?=
 =?us-ascii?Q?tpD93MPdW7Gwm1OXjWh5nE2r7UZFeJ4wsmGKiTIfCIVW24lrs2/i0u8E2XS/?=
 =?us-ascii?Q?MujHsT3ue9AXhI80R8DZYpU+yHRRSUChKymHMRSNjcq24EFAFYLnVCZxyPYm?=
 =?us-ascii?Q?enwEYajLkYpfZyLit+B+vSbzbJwoYTl+VnxqHqq5LrZn+DG1fXFUUbpPqVK8?=
 =?us-ascii?Q?FU63gm/6iROSfx/YuQaCocQId/RlZRNqXQDQq78y9Db?=
X-Microsoft-Antispam-Message-Info: pEUIJEecO3+6y3qUJrRi47bGbXs9/q7DcbY3KU1r1eGa3wIRnxQKS+ZUokvUZcp/vlht+b5Q+1ijNpntZnLENZmaFqKelsIIrQIxMKECSykix044LJNUPlNmk+G253kX4Euzx9bgebs9DYFj9DYzK4rF6gES/m/R5X79qgwLABMXoTwZnO6vfF3yCmnGlpK0UpUwkm6wTihG8u4ZQLOndbI0NzM68OQTGS/I1nc9vz/wewrtx+hF3dVCwdJwctAb6J+47H7HK7ruB6ExyZ+LOPfiH2C8xbBlPfv8wuwk9KDQQaAzpqI5GL0rXUOsDK37WDPxM8Zm1RXoNQzZ5bxIvQeuNqft0uLL8O/MsBp7Whw=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;6:0Ui4uKbtSN9HmY/ZIYxleOKCeoXDHH/cM8YrGb+SeJZyNiR5aet9iHtOGDMT9QY5LHb59Blj05EH3uwAFNmVvRaUPHPRpY9E/ItmCzeugifjrR9eWWL4/czO0fQ42C02MQbwKQrMMDhx/9F6wehgtuObNQcwamLLsewMxEjLXM8jzymiFaSnC9yfFO/NQzF8AdXYRctsGnnnrNbRmFF3CHV1gMAeP4SrSDIzwSNxMwi02+yaoZIAT2GK/TLErGiNIZODCKTo0G1OuYZUJRVwABFC8Jbm8HC7wsiqjmxpsMtCIxzlxNRurUyURDGfxosOKiUpEIRlcltLvH80J2od4sBlFfFcmKml5pr5q2l+r/Y1+qVoW7y3egHQafXl15L98u9U7wozDZnbg/jZYqwNoRQZ/ovJxpHQXib9pl1vUyV43Fgd0jAHRdcv459szHndjgxskwOGXHo3OppwKHo2jg==;5:Iqn1XouZy/p6mYTRCFueLIF8Xt5zdrQ2r6RFVkK2sHTwdIh2gAmW418bCeU70Qx1vn8A49xXVy/lrU0xqEaurAjtg5SR9aDxncRzdW11O6tPkDytN2SNyQ965HTnNLR3dOyd3WlqXsUG7/2JY4uHQejIDbdZo3wQMK5giNgiDTc=;7:yXivW0jtxcuTnt62QJbSPVHkDEi1s7eYIPuweP/V/yO3d/DR+koQCS+JOMUSZqq6SfguuV02UAfypYBFTALd9ut1A4ZkJkt2202NqMAZx5B/rfqlb9L6gTkXPUBjkEC07KeC1zzLst8B8LydhlGpi/nGdSH5zyZHsZP40q2XaUjCZB3KfkkGVL1dRqAMrmW/6FOEUkyzYuJucpU8PmDlOjA6smCz/IGPRUnLbZEJQNThdLRGnGyW+82aK1ahOAjt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 18:54:52.3087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b76b4d96-882b-45b4-e987-08d614f3657f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8ce355cf2e38 ("MIPS: Setup boot_command_line before
plat_mem_setup") fixed a problem for systems which have
CONFIG_CMDLINE_BOOL=y & use a DT with a chosen node that has either no
bootargs property or an empty one. In this configuration
early_init_dt_scan_chosen() copies CONFIG_CMDLINE into
boot_command_line, but the MIPS code doesn't know this so it appends
CONFIG_CMDLINE (via builtin_cmdline) to boot_command_line again. The
result is that boot_command_line contains the arguments from
CONFIG_CMDLINE twice.

That commit took the approach of simply setting up boot_command_line
from the MIPS code before early_init_dt_scan_chosen() runs, causing it
not to copy CONFIG_CMDLINE to boot_command_line if a chosen node with no
bootargs property is found.

Unfortunately this is problematic for systems which do have a non-empty
bootargs property & CONFIG_CMDLINE_BOOL=y. There
early_init_dt_scan_chosen() will overwrite boot_command_line with the
arguments from DT, which means we lose those from CONFIG_CMDLINE
entirely. This breaks CONFIG_MIPS_CMDLINE_DTB_EXTEND. If we have
CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER or
CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND selected and the DT has a bootargs
property which we should ignore, it will instead be honoured breaking
those configurations too.

Fix this by reverting commit 8ce355cf2e38 ("MIPS: Setup
boot_command_line before plat_mem_setup") to restore the former
behaviour, and fixing the CONFIG_CMDLINE duplication issue by instead
providing a no-op implementation of early_init_dt_fixup_cmdline_arch()
to prevent early_init_dt_scan_chosen() from using CONFIG_CMDLINE.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 8ce355cf2e38 ("MIPS: Setup boot_command_line before plat_mem_setup")
References: https://patchwork.linux-mips.org/patch/18804/
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.16+
---
 arch/mips/kernel/setup.c | 47 +++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c71d1eb7da59..7f755bc8a91c 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -841,11 +841,38 @@ static void __init request_crashkernel(struct resource *res)
 #define BUILTIN_EXTEND_WITH_PROM	\
 	IS_ENABLED(CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND)
 
+void __init early_init_dt_fixup_cmdline_arch(char *data)
+{
+	/*
+	 * Do nothing - arch_mem_init() will assemble our command line below,
+	 * for both the DT & non-DT cases.
+	 */
+}
+
 static void __init arch_mem_init(char **cmdline_p)
 {
 	struct memblock_region *reg;
 	extern void plat_mem_setup(void);
 
+	/* call board setup routine */
+	plat_mem_setup();
+
+	/*
+	 * Make sure all kernel memory is in the maps.  The "UP" and
+	 * "DOWN" are opposite for initdata since if it crosses over
+	 * into another memory section you don't want that to be
+	 * freed when the initdata is freed.
+	 */
+	arch_mem_addpart(PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT,
+			 PFN_UP(__pa_symbol(&_edata)) << PAGE_SHIFT,
+			 BOOT_MEM_RAM);
+	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
+			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
+			 BOOT_MEM_INIT_RAM);
+
+	pr_info("Determined physical RAM map:\n");
+	print_memory_map();
+
 #if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
 	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 #else
@@ -873,26 +900,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	}
 #endif
 #endif
-
-	/* call board setup routine */
-	plat_mem_setup();
-
-	/*
-	 * Make sure all kernel memory is in the maps.  The "UP" and
-	 * "DOWN" are opposite for initdata since if it crosses over
-	 * into another memory section you don't want that to be
-	 * freed when the initdata is freed.
-	 */
-	arch_mem_addpart(PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT,
-			 PFN_UP(__pa_symbol(&_edata)) << PAGE_SHIFT,
-			 BOOT_MEM_RAM);
-	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
-			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
-			 BOOT_MEM_INIT_RAM);
-
-	pr_info("Determined physical RAM map:\n");
-	print_memory_map();
-
 	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 
 	*cmdline_p = command_line;
-- 
2.18.0

