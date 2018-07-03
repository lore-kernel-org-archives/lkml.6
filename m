Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F65FC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF9E24180
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0I6u963e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF9E24180
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753496AbeGCNcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:32:21 -0400
Received: from mail-bn3nam01on0076.outbound.protection.outlook.com ([104.47.33.76]:17664
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753414AbeGCNcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgHIewCUG3Y62T3zF3FpyLNwLAI8EzuEd5TtINPVg+A=;
 b=0I6u963ep8OeOaAAPEnBK/2arBbgmzJf4OiTLF81693ICUJ0EukpX9yJH6Ul9i37nY04ClHvxWpUdSELLHElEuTNTs0GvsREDcfh/z+G31x82BYacsiz6/qtqOSdXwAKVOUpMCoY8+ktrPzJP6ee/72oUyDggUDlYqIMVmt97QY=
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BL0PR12MB2452.namprd12.prod.outlook.com (2603:10b6:207:4e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Tue, 3 Jul 2018 13:32:13 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, kvm@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        "# 4 . 15 . x" <stable@vger.kernel.org>
Subject: [PATCH] x86/efi: Access EFI MMIO data as unencrypted when SEV is active
Date:   Tue,  3 Jul 2018 08:32:00 -0500
Message-Id: <1530624720-32004-1-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:404:4c::30) To BL0PR12MB2452.namprd12.prod.outlook.com
 (2603:10b6:207:4e::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52e3b2bd-25b6-47eb-d1d1-08d5e0e96348
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2452;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2452;3:LAmlgquIHg6GMFOha242NM731zQyXgppeYrjh951ExMydMz0RSckNWzoSn1Os5DaAUK9el/lp0BHA8e9mwYhNNwo//QZB9gvSf/u9nswHGaE8IJaCOAKT01Orcbruk+sa1TO/PXUhkQkyXduC19nBXTsctvqWAs9SSXb+OffX6aHsvaQ2HfVtOwSHcGMxb+FzyAv5FF81t4jFiHw5oXawQXX2aUK7oEFmU0aY9/o/On4swJnWZFMAocYPoT3gM9L;25:6V1NWTd75Ghr7FBG+zKJcl10g3/5WvT/HhIJ5fxTvrP6NzB9zajsUIflVnyzueXs6sWEyinqXiaKyEWiUnNrzulxYBtlDLdkJ6JPDw91qfSjLIKh33a4uTV3RkwCLqpFxe1b5RI3y45D78pm0HvQqlGlScRJtwKXdRRvL26fag48Fje+UzbZ3NqauQdzU4K6mnvYsFsMgob5A1bgrqbhLGOZHSSUZrwSPSvo+Q71s2G2I2wHB72wPnWq5Eh6uUnMron2KTUUcbpvdumhcruiMoJuMkNbIk/iAOGrAVhj+IHa/UIuG5gSvEBZu9Xp2QeAWOX+8PqmJDHUJ/aA4HgS2g==;31:U7L15BFxE1gV5679vJ4wqxpAmwBNsMIsBOLrNnz3DhADogSWhXGPvuLURM5U784QYVgq2XbiNBK4whKc6STG3JYb0LoKbR6BUz9yjAxM7+mb7bG/O/nimeDiHDbuFjFrTcOUl4e9xGya7jq8L/lu7gNNcYwgPAoXxcE8YnvLAZU3C2ys8uTqIVe1V2EhvJ6l9K7I+2Yehx9o6ptyfAznPa/umeFkxOlysGFRGBr7syQ=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2452:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2452;20:dYivhKPRKyTaHpS7SFJ+J+FiCijBvIUTP12GZJJunimmatTcy083eLQRm2mKLQQ8FpFZxS6hQyW2kWgm2qWgVomGRlQk0CtP7j7e/CuBKqtcxiFb7z098ymD9XkTPmqdPiXxoWMyOjRxZ5RnWMAEbWiBgw6StTHBSOosbW5/fjFRgPYVeBE1ir/y5uSXWT9mTNkkP2apUs5vMhK6b8fEICkUL9M/G4N52K5+1eYz1Ad4We9p3/XSFnLqDcZujErPepgV+aF91S5oKoyv1NZ7UUBnStfgNIQZ/vvuprGN5RG0Af3sMVkZBSBWBCk9C0D4mEtdbmpWV9R47+pPY0RZ9SxOtEmJjc5Iw69f7tDug/6BRjhzDi1GLq6ry2+N/O+fzyFUxcFCZf41IGS+yhtAdjU90yN4J5Bmatdvtfo/d6St50t1owxl9C5MAz6L1JhJ7LcVoOUVV71IWzwngtLxanB02nSoc2DKuOyuLn5/PsOCE7VAEV5EjkFZLuhfIbNh;4:oB178bJIO5g5Cmmx4mtJj2HMvrFC/rJ0C1S7D006eCVAT8j1uWIhBQWxvLntarj1z6eUeXYFaZ+ZN+mUp7sBzVW0D5ceXDKvZEzsYr8aii4e3WbJlufhZnGBG5mdC2W1ozYQxqshhG08jBP1S/9jCSZ+e39+GKlMCsiTzW3Ok0N1X6Y766xDNL31RguL7H9tGn2MlQs9Fbn6UprDYAVxQZONcR3ZSKzaV+OoQ6J/64+k8jbIqaTXOXCT1iO/wWAkZ3decAffDJs40Vd2AXVlTuMUmWonUVoNRWOqnlbYuTivXuAM46rNdobiAB7r6uzLektFxwLT27B68yiooaxRIQ==
X-Microsoft-Antispam-PRVS: <BL0PR12MB2452597FC0A6BA590F9F103AE5420@BL0PR12MB2452.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231280)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR12MB2452;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2452;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(186003)(7416002)(4326008)(25786009)(51416003)(7696005)(14444005)(53416004)(52116002)(106356001)(386003)(305945005)(53936002)(7736002)(50226002)(6486002)(105586002)(2906002)(5660300001)(2616005)(478600001)(6666003)(54906003)(48376002)(956004)(316002)(66066001)(47776003)(476003)(26005)(486006)(68736007)(81166006)(86362001)(8676002)(81156014)(8936002)(44832011)(3846002)(36756003)(50466002)(16586007)(1857600001)(97736004)(16526019)(6116002)(6346003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2452;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR12MB2452;23:+qUZKyxojAcQHiZrHgjw94POwmKxX4tFoSGTeyayn?=
 =?us-ascii?Q?N0Q6elb/fnjTURqldH3YQnnm8rEMEGvuOw2H4CCA+ZSmhlzDG9hYWo773kOo?=
 =?us-ascii?Q?P2koZyaDmDxDOoZN43DU4xKARaGSdtjELRQoBmrce0StNY0JPb4lo66QTCqY?=
 =?us-ascii?Q?NY0lWTzvQvqKs5Hy+DZOWCIuufHjWTZYy3fd7qg6QQKtF0q7vHQlKccdyGQF?=
 =?us-ascii?Q?8eUWJtcEg6zvrru0IwSiPFtm6dXqt2NS1nZyhc704p1SLpWdY1plDCfRXDZy?=
 =?us-ascii?Q?uSEvcsdI98N94mClAL54C/oyvJPXXTEN8DthDmMsOSj6KUUDqVZSFLh6kU4J?=
 =?us-ascii?Q?MYmXAhmkly6P1JrKbX+cGFJfLh3KbtUi+Wde8LbNXTwthaqnmMIOjVGpYfGu?=
 =?us-ascii?Q?y+niMoh/WLRh13APJUOPYpg5lUSCps2Kh9Xd9f7ejZU/rOohhCuNzsXLGPDP?=
 =?us-ascii?Q?K0lvs5nvVYEethMYFr6rET/azlvRj9rY3sp9mEuBvHfoZH8St9A5R020pK1t?=
 =?us-ascii?Q?drxhjdmmLbTQS5SjF3M/uGdEaMaPfzP1FT4EmsZAoNkDRR5OKFfy3HVFap1N?=
 =?us-ascii?Q?io2y+5ESFAHQuUMryT0/AscaH0TNtX/tgHiljxN73Mx3USCiCf14J8IWG6oq?=
 =?us-ascii?Q?h3Xnq6CPC4xIt5ZmmeTKE7DQOg/CpcYAUltI+pz4NU0h1X37Hs5bkIAyd5kP?=
 =?us-ascii?Q?8D7AQKegJ9r69ypnsp26zL1bGvrSf2IxHdMf01FURK2uFl0rmQjKzPlujwIB?=
 =?us-ascii?Q?+nKlIF5UZZkU03W6SigAG4zVbIeNMateZ2aJJyItyqjFnxEu2sMumTbmvGCn?=
 =?us-ascii?Q?GtZ13EnpkRPpFMJpKhQfUta+xd2+/mUxtydsFZte3Fzp5Un0nCoRl38rrTVD?=
 =?us-ascii?Q?afRAcX2unpevV8sHgtJW79wlLE0Bg8KgXKrTNoPnnsiLyapfeO6jwAWykVyT?=
 =?us-ascii?Q?qJdaxuO1k26NcwcILGU7wcDwk3NXgzhoemqh+rT92aWsAGY/GssHghaBU03H?=
 =?us-ascii?Q?pMkVKhFBPFNr7gzATyZtltEENrqf8Dm7mZWOsOdaYx5em0zTaTeo9wLxdLNe?=
 =?us-ascii?Q?BBD8WhgLyhILxThgB44N16LvUaAhokyCBcRKYiGFvDxMVZHySSAUCK0VmRls?=
 =?us-ascii?Q?LM57wDsQsqj0+RUj2O/AMm7a92F8FlwgYzJ0myFBjULWlGmTb0L/jBVosZZD?=
 =?us-ascii?Q?NEy2VIV+BUUTL9gU9yWSdKLru0w8Frc/ZSn9TkCXD4wGuRGWRs8DYmAdwPXG?=
 =?us-ascii?Q?QhYPFZZWHy54PB7+R8=3D?=
X-Microsoft-Antispam-Message-Info: ZXddWvS7ahuD2kak8+eZWgUGQq98cYBkovY8EmHSfySGKlQezMRYi4baZUHljB37jIpsZD2aZEgjjp64fxqOtvHm1pVRcdjkAZ80/lNfpeYJP8hPg3oOTjLpaWvVM2LW1/VOxqbHRqKdj552T8fl62MwsUvxXnEFdR7c5R13XFmwmWlumgfMAqcW00gH1ftjjGlW6RDdiggppQ1n7+X1sLYfOob24Zf7m/VEKoZYRvF3bHsC+ks69HyPWDy6YoXjv+vBorKS+GOIG2NeZij1WG3SUyPhJf6nyvngoVvq15FrraRkafo8ob9Z3GUi1Pqi7Sv4sDWVbPf5nAjPWB+OOabrRCCntHPu/3+LN6QP5iI=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2452;6:HSimJvQcoYhlt8wZX3uJhllQPZU4qctcFCoDXcVUw6lp8U1tjUdA5UFwkxRGMii+Hr/ApJRfBjyD6zzdS2sKhnywc3/oeJ1RlbVjsKg3ThsiF1eE7wp9jSXPFFWZv6FtcMOyXPYHDtAAHt7IzufSmzDKlNeruuogk67BCB7B8i9JdxcjwbEjq7JP+NCm/pPqSxke3N23vchfSlxqYA4yhcL+6uUEOYoQ1ZmsFUEF54v/xYX8Jz8SKRCDIEeYU51DCPVHGepaS1RpyEBfWCAo+OSeggDpimDZaGKLsgdM2YDzrmX4gY47fkminSgNuo2JL1I5Sbtp17UO1OIaV1V0CiJsXwXXxYwFEOOproZmEmkAjmQT5nsLZj4Vs06Yrm8C7hfj7T+pUapjD7ZcRN906MT36mRy5zIc4UI1bYZEkAd3vFDGO6GiwqwhCdLSKHWhdt4sjhZ5E7fYkinm/8l7gw==;5:aC68JJsUbVFc4anmv9z87a2vkcEnoYR+LnJBtUAZYCdB10A77gleN3TZsuyA+d0RZPKfdBjxcjig5NGalaXguKLKvA1XOUff66hNl1wvNNtau5GO3cTehdm//JFYLbbqxaNwZuwrG4eN+5AyfqmAQZf7HnCgkGUXc76FfXkc5i0=;24:xkRmIu4zNvwQR0w94NGdnjCyde8b0T3V5iXy3k0U4j7z78FPo/hCnAy0iiRk6NYCqcEYnQICTwcNpcOl0kIKCIAXkJRv8ANonuU6M7CVbGk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2452;7:AwR/TTm1E8rNbpadhqiyzhfbqaTLmrJXVeN3H+dLCfw2cZZxp1KvdkHqe7pjX4OKSNTHd1kcYiqpiVjrb4aV/TC1ZwtL3XEEStJGK04xa7YSAkSKfVPbXTucGKuZs6ylqcS323eDV6R8jyyznE/fTHdarneKVwlyDnNmebM4tDP1S9KRrTBV5CGIbBFQoZEaK5UJYpLUmiSq4WMZJqMepaGT+JbX9vFkKRl7JC0fi3yd+KWjoLFio9etHSwZeZ5H;20:aaidsi9/593j0lIxgExB0RWBg3KkAE91ftJpWMg8fU/G83p47UXNZpZjJ6kDS/1HeIFYmvd255TsgPFc6iMgp59qjypRC9/6Ot+FSKwm3Nwg/yhFXko3JmdFuOITa4EKrM3svozPcYRxl+bdhAjh7iaXA68/L7J2iTkk3WWKEnwxfcjsxAJqFLqARS5KCs7EQ3m7G+Os2Q/HB+u8gtcZQSOd3FNqCT146E5Cju0Zf07l1fjWqLDg4kL09TSIOnJA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 13:32:13.3324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e3b2bd-25b6-47eb-d1d1-08d5e0e96348
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEV guest fails to update the UEFI runtime variables stored in the
flash. commit 1379edd59673 ("x86/efi: Access EFI data as encrypted
when SEV is active") unconditionally maps all the UEFI runtime data
as 'encrypted' (C=1). When SEV is active the UEFI runtime data marked
as EFI_MEMORY_MAPPED_IO should be mapped as 'unencrypted' so that both
guest and hypervisor can access the data.

Fixes: 1379edd59673 (x86/efi: Access EFI data as encrypted ...)
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: linux-efi@vger.kernel.org
Cc: kvm@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: <stable@vger.kernel.org> # 4.15.x
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/platform/efi/efi_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 77873ce..5f2eb32 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -417,7 +417,7 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
 	if (!(md->attribute & EFI_MEMORY_WB))
 		flags |= _PAGE_PCD;
 
-	if (sev_active())
+	if (sev_active() && md->type != EFI_MEMORY_MAPPED_IO)
 		flags |= _PAGE_ENC;
 
 	pfn = md->phys_addr >> PAGE_SHIFT;
-- 
2.7.4

