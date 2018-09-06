Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6099FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E636C20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SllQmrj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E636C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeIFQSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:18:45 -0400
Received: from mail-bn3nam01on0067.outbound.protection.outlook.com ([104.47.33.67]:46448
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727851AbeIFQSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2txtTs/dKgYSLSmfQ6fmp9U7m+Xsj1BFCJl0Pp9LE0=;
 b=SllQmrj2cqfiho6VQvxc/KjBEwZMMrTDuNI1XqC6BnFAHIb0zJqg25173XQnWPFlBN+i6XU7HDyERJf+a6ABqWmj8wY7JTifzqqSw4FwMOSPr56kYL9Y59UZtdgH5uLPpQqwlc7mHNYUtkdUQMe246ySIADKxra4yaMNHip51fs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BN7PR12MB2675.namprd12.prod.outlook.com (2603:10b6:408:29::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 11:43:28 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v5 1/5] x86/mm: Restructure sme_encrypt_kernel()
Date:   Thu,  6 Sep 2018 06:42:58 -0500
Message-Id: <1536234182-2809-2-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:903:33::12) To BN7PR12MB2675.namprd12.prod.outlook.com
 (2603:10b6:408:29::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 730c220b-285d-40ff-7b15-08d613edf783
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2675;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;3:A+ZcI1gTIznYNvosDyqVH2sjNU95eFPBlto4lr4WqyYj2Ev6yI5keFN6zh9P7dDoSRBdzzU+hRkdMR/91bE8+CM9Wr1q4gZEvJSed19751wYGFk161gfMmJdov38Wf4yjLRM814VWiXLHSgn07VPUvbIZVlCjRDufQ47JqxZybFdAKPEerQVCkHdZQoL2B1iIEh+0XYHE2OBpteSDqLuz+EF/1YHCH0RDvn7IdQnNHchQEbO9XGKxQ76nw94KEHa;25:cYMrUSpgMkcqtO/JcmBiunOxbfDGBm57QJvvz/n42RgUzHwf+50NmTBwPdJ1P88tz9HRxCkiNpQIQiemrbW+k9lnxbHfYbH4NjouVxUX46Z6TGOoWsNTD+wld41yYsY5KbDpIdboOtGhIV4tdmwc3z3ycaF+cZf8E/L/ZNBh0EGtDZR2m5VwCZl/B3F2t2xP7TKCkQZgvF2QeQxTXMFDilOXZZmD2FQKCnppgavJLviU4uJiG7fSA0348FtP3ofdmDXiHuD+VivPq2QcSf23yF9cTllR+kPBWjt6WFm4BTtorbCygd/yMrks+BCdzQhHcWELvU60fsNmw52hI/mPBg==;31:5FeL4EUdkTwGt1ko2r4Wv0HfyPnQY06LReGi5LpWts5nmSmd9Ut4UsRHLyKCMPQcoBNQDK9NHgm9GpaJc/VLrIeEhkkR+0oBIDRM/F5WaKuVvEeOGEJ94x2j82NpPBD/biGBllQrOzUH10A3SrJeShO1JAhJVvGjeVOw5qMQhrPqChAfWorSdQ2Ooe6yBBbYe7RIiKx+yJK6NqwmZxrL7xOwSRWF5v2Ymrz94lQhtlE=
X-MS-TrafficTypeDiagnostic: BN7PR12MB2675:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:fJ9+n/bh3WykpelawsNGdnFHWF5YSuVtvHtTprsVznZ6QFwIrg56X7rhw8YFUQO9e7hk6qfhfF3pjFIK2B7PdXwdM+knqEdZPpLBx2xiFTOwuIz5dQVALXSWA5INLjTonQvKzVtyt0aiVAXAO+4nZQGnPRTwa4Oium91Ofo4d+8NvwTGODti7d3QSG4t0/NAdhEMe7xAZl9f5jvUYPG4Gb59crkqZ8HCtrurcs3s27y1IBrK5UP18zUdxzRd7DCTINMbDZtoDli3vM/3p8g0YtQUU/c6aSeSDhfrDbdTapASfv1bTNXel+/koPfHfR2CiF9k6GINreUtFHJdXtEoBSr3m901kb6jALVPDP3bHHvGjSTT6qVAt7zNKNp8CHNISka9PpfDVri6bx94GFQJz5D3DJZlc0fep8TUmgjB8JnfHBQJ9IDOVBNwSnTHC8MRDmZXpQslkRsMaSIYM7EsOHZz7aPdmTgwJFPA8lA34Oj9FNWzroAzG2bOI8Gs886I;4:Aa9tZr10vLsWOKL508jFGwELbzEFIkuy8QEd11zkLPVP7CNEiDciJgyeLOCnJKKslA+31UX7FO4ciBcOr6cdow6Rw6pvulaZiw4jz+/SeOCK171lH2lfj974Vyxcs20QgSMaJzmengDmRIiTC12Zs8YLmBB8jlaSqhyqzqTTOcwRxPRRl+TojOFde1SoejWXBHVlnbSjf9cNaJg4WQCvDSLH3Pi1ciDei1dGL5XdjnCAzOZbRkb8MLiV4PlOsvhm11k//EQziaNdY/jUeviLjjQmf5NdoXnle4p3xUBluv0vzi/S60k5cs6VLIpjaYOuWkyiLty4qPxBD/c3tdLWbF549o3gN3hAktn31EboWAIn1dFLUj16bj9vSbm2TWRQ
X-Microsoft-Antispam-PRVS: <BN7PR12MB2675FD3EC84D1816566CCDFBE5010@BN7PR12MB2675.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BN7PR12MB2675;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2675;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(136003)(39860400002)(189003)(199004)(25786009)(47776003)(86362001)(14444005)(68736007)(66066001)(7736002)(6486002)(53416004)(106356001)(6666003)(5660300001)(3846002)(305945005)(4326008)(6116002)(36756003)(105586002)(26005)(7696005)(50466002)(52116002)(8676002)(11346002)(50226002)(956004)(446003)(2616005)(53936002)(2870700001)(97736004)(23676004)(478600001)(316002)(76176011)(186003)(16526019)(54906003)(81156014)(81166006)(2906002)(44832011)(476003)(386003)(8936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2675;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjEyTUIyNjc1OzIzOjdGcWQyR21DczRsSnU0My9yaTJUbTcvbjE3?=
 =?utf-8?B?RFpPU0tXRkxyVkd5Si91ZVRJYmhHTURKTTNPNGZkbWJEQWZ5Q2ZROUxTYXZt?=
 =?utf-8?B?VW9tRVgxQzJOT2wwbnRnSXhqZE4xMkVmVHdnamVwQnhBWThvayt6Y3B3ZWxp?=
 =?utf-8?B?OUdkYUQxQnVMZzBUOUluSXJqeTJMVkdVR0N4QUViWFVNbHg2cW93NnhlWXdT?=
 =?utf-8?B?M1JtcGdkdlRPUEtXUDYvUFZRNjZxWTVNUzU2VVVqbFR4ZE5LdVFrOVNoZkhM?=
 =?utf-8?B?QW9yRFBSM3loMmVBZGhyM2hMOWNYQmpsTGtEK2xDMFB1UEZUR1htUzloZHgx?=
 =?utf-8?B?ZTUvcmY4VCtub1AyRFJOdTlhcFJSRlBOanZPV1VuUTJwN2xrcVl0SkZNN3Jl?=
 =?utf-8?B?SDd2QUthU0FyT2cwbCs3NjlzSzZqNXUybjdQV1ppMFc2SmtKZzJDY1g2VzdV?=
 =?utf-8?B?Rm9kY21iS1dtMlZHM1ZFRTFUV2lyb1B0dVozckd2SW5ZdUFzVm9KZUl4cFVJ?=
 =?utf-8?B?Yy9BQlcyR0tCd2JEcVhRSzREcVp6Wm5hQ3l1QU5maEJvZENoeDR2MHk2RGt2?=
 =?utf-8?B?TGJsV3RVUUwrTVdsY3VDdHRNc2YyTlVWSXpBOXRxek0vb2ptczV2cFBydmlL?=
 =?utf-8?B?WlN4ZUpEdGt6N1IwUTNWUDRRU0xoVG42TnNpa2RUei9EM0N6eUtUdUdUbDZi?=
 =?utf-8?B?cTh0Q1Jocy9UQWNkNXV5YU1SbWRmalRmOXRGS0lIdFhsYUwvSEtHQkppUkln?=
 =?utf-8?B?U0krejR2QVNPdzVZQUVUT3lnOS9YN2RKL1VZTFY0K2FTeVBnTlNyWFQrd0d4?=
 =?utf-8?B?UWZ3SEhPUStPcG82dFJLRkFoOXBBVExBU2xseXBadEhZK1VyaEFKOHNlMi9t?=
 =?utf-8?B?TFRZdlM4ZENNdHFiM20yWnZXbFdJVzBpYWt4L0RVVm5oUzhhTGZJRW83Nk1s?=
 =?utf-8?B?VkJRZTltL3pyS1VRbDJ1U1M5UXlxUU0vMURxaG9HN2JEeHl6N055aEF2dmxK?=
 =?utf-8?B?UTVNNy9CTVg2K21naGFyUTZDQjNoT1h4a00yVUFtQThTdi9icXhyTUZ1TDJn?=
 =?utf-8?B?ekdkMythS0d1R29TTUE5WFpvR0Qxa05BZEhIRldJSFV0bTZvRzdZOWszcko3?=
 =?utf-8?B?bCt5bU1iTCtnQ1hneThwc2tyZjlQVHJkaVdFTVduTFF0MXVJZ2RDUFk3bVpa?=
 =?utf-8?B?ai94WDc3cHA5c1FLMjEvZVVqTk5rcHd3YTIrVUwzakxIS0s1UXRwY2FZcS9S?=
 =?utf-8?B?eEg2ZmluOEMyTnpzdUtVTGtlZDAvcFBVOS84UGlIOWZYK2IrTFltbmVYNW83?=
 =?utf-8?B?dFRaL0lXMnRXUnJTNmlBN3hVR0x5RG5jREVyRnNQWnVDN0dqaVd5N1owMGM0?=
 =?utf-8?B?SGY4MXUvTCtmbm0vOHZNQ0IyUWRlOS85TE9IK2FNbWtsd05sODRkOXhRSGZ6?=
 =?utf-8?B?bnZmYjAzeTJXN09kTFA1TGZJN1BiTk5XV0syc0xEZnVEV2JuWk1NVDYydVJj?=
 =?utf-8?B?K0pEZ0wvM0RrZ0JNZ2pWRVYzOS9aVENTVVMrSUlDZ3BId1pPcXhLYXhiamhr?=
 =?utf-8?B?d2FrQTFMNEU1U1pva21OU1Y3V0wrV1RzUXlES1JYUytDVGNvaEdpODZlMDYy?=
 =?utf-8?Q?TQRL0WW/iSJG1FrpvujH?=
X-Microsoft-Antispam-Message-Info: 6aLEOzzODRfdHT4dHpMbT9JDUQ+NS5d1+Cf3JNGChV6UfT+kjKn+PuX6oGzf3JxAYkN0eFib/gzsErxCbCsQSygxgAYEqapEoxTfO1pgaxPgkrJLiQTKwPrtQdZUM0gIvd8ffDVJ2IhHSXJ4BFT3xbOXphbmZrl+sCRotbmqgItMXCfu24fcpXG2nR/1ZMWIcLPzqyMexVD+LE8DfLoCG8V61Ipln3ttK8j07HwxBxn9iMOiBAkuy5VcFc0ybgvb5pAknMW9g8dh0rX43WW2UP48pcnYXvfKUROCbAXx9V0VeNky7Kgmv/n/TJZ+Lp7s/Ol+nVihTHPlZgAq1svrn8/bHDkR0pfqPDkgB5ctmeY=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;6:krx7XcBvOBgbib7nFWxqzOcZg6yrLGtHbtAvfx1u9NWQCF2TlAZeuvWQvC9dE5iJzXRFs+k5p0VxWuUO4OUo/zdcf+3Vl6rlCa0DoGSTj5wEHSHyeKdCudrUnvKKl6CqUdrK1XYrbey5dYiMymEJPV567GVRDpHE+zMOasqIFkInLMAlbSIYM/NSuOfz0EJr9KknJ5RCMpFsj4kLnt0RSKZFc8AqaUeNxiKyHPc19vSf/vT0M4yJWCvlvfCHCl2YVIrLb0CeKsqejW7/ioFcDtvnI24BrflogdVDliXrGK0JlcLVfS+kM2FbV0ydlFAXpUcpNLRKVIU5XfsD1z4mrF2QRismQLy3zoQO5uY3IaELZph8MXkUWru0ezwXT96TAUCP57PsDjlX+3c8m7Bkx1e3s78W8YjzmKzf6hqM6yf2Vj/E6KVQREhW89KwYONUPRGF87b6KFHK6DdWyKd8zw==;5:rsRI0KDZ8qVcBdfR+AFJ7+Rn8DEa7iwwI4TdUYEkr2my3uSEWTDCf/4qi0yxZkPL0/+n0FAdJ3ptHxHqYe79Qi47q5UjAyP/j2Vgc4i+e/gQxyssWD7pLkmePTXAJ7Da/ZzBXc4E8/V39CjzPTjuCvi3lFBnkofmNi6/TvUD/2E=;7:jFMgQaVrwwvB9mbhfwFWvHfn7Dsgrc2DaMC5cnGP1TfWtlyelyJ4R79M7rUC+FwI3Tbw1/00QTNKfUr/8Q6K5mtELZ42e/VY3+OTrkOBfbdq6+WjoqAYvnwDIFJT6PqpMwXCJNj1/nOE4pZ+okGJuWaMStFp1ummTBG7VMw+MCMk+WwW6g4oyKXk/ABbmCm97aktYdZFhmiGcPS/s+uw8aMhQ6KQinuB+XIYXMjUgJxUmRXS9MM9s7hfDOETwVZP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:mRyajanan8VKY+TD80s0ItCT3Knypy3Oi//LsLZAqlhW2Ef0or9QA1QdZ+qJ30LK2M1LimqsbPO7gL0KtmSgcnYgdL1Jbr7H6/5VebXWNhdZCQrQieeuSA9LukquXXxiMNcg2nes/KbUBoTZSwN4NOJ4eWVASw1e+5NDsxKkTowBG9q6RmL3pBfB4gcEx8Ga8E0VsdERQdnz4if6+rtD4eaqcJZDvDyyi1Pg0QXtAH/EjwHQ2VbG9mf9CzW4sF84
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 11:43:28.7613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 730c220b-285d-40ff-7b15-08d613edf783
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-arrange the sme_encrypt_kernel() by moving the workarea map/unmap
logic in a separate static function. There are no logical changes in this
patch. The restructuring will allow us to expand the sme_encrypt_kernel
in future.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: kvm@vger.kernel.org
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
---
 arch/x86/mm/mem_encrypt_identity.c | 160 ++++++++++++++++++++++++-------------
 1 file changed, 104 insertions(+), 56 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7ae3686..92265d3 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -72,6 +72,22 @@ struct sme_populate_pgd_data {
 	unsigned long vaddr_end;
 };
 
+struct sme_workarea_data {
+	unsigned long kernel_start;
+	unsigned long kernel_end;
+	unsigned long kernel_len;
+
+	unsigned long initrd_start;
+	unsigned long initrd_end;
+	unsigned long initrd_len;
+
+	unsigned long workarea_start;
+	unsigned long workarea_end;
+	unsigned long workarea_len;
+
+	unsigned long decrypted_base;
+};
+
 static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
 static char sme_cmdline_off[] __initdata = "off";
@@ -266,19 +282,17 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
 	return entries + tables;
 }
 
-void __init sme_encrypt_kernel(struct boot_params *bp)
+static void __init build_workarea_map(struct boot_params *bp,
+				      struct sme_workarea_data *wa,
+				      struct sme_populate_pgd_data *ppd)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
 	unsigned long kernel_start, kernel_end, kernel_len;
 	unsigned long initrd_start, initrd_end, initrd_len;
-	struct sme_populate_pgd_data ppd;
 	unsigned long pgtable_area_len;
 	unsigned long decrypted_base;
 
-	if (!sme_active())
-		return;
-
 	/*
 	 * Prepare for encrypting the kernel and initrd by building new
 	 * pagetables with the necessary attributes needed to encrypt the
@@ -358,17 +372,17 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * pagetables and when the new encrypted and decrypted kernel
 	 * mappings are populated.
 	 */
-	ppd.pgtable_area = (void *)execute_end;
+	ppd->pgtable_area = (void *)execute_end;
 
 	/*
 	 * Make sure the current pagetable structure has entries for
 	 * addressing the workarea.
 	 */
-	ppd.pgd = (pgd_t *)native_read_cr3_pa();
-	ppd.paddr = workarea_start;
-	ppd.vaddr = workarea_start;
-	ppd.vaddr_end = workarea_end;
-	sme_map_range_decrypted(&ppd);
+	ppd->pgd = (pgd_t *)native_read_cr3_pa();
+	ppd->paddr = workarea_start;
+	ppd->vaddr = workarea_start;
+	ppd->vaddr_end = workarea_end;
+	sme_map_range_decrypted(ppd);
 
 	/* Flush the TLB - no globals so cr3 is enough */
 	native_write_cr3(__native_read_cr3());
@@ -379,9 +393,9 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * then be populated with new PUDs and PMDs as the encrypted and
 	 * decrypted kernel mappings are created.
 	 */
-	ppd.pgd = ppd.pgtable_area;
-	memset(ppd.pgd, 0, sizeof(pgd_t) * PTRS_PER_PGD);
-	ppd.pgtable_area += sizeof(pgd_t) * PTRS_PER_PGD;
+	ppd->pgd = ppd->pgtable_area;
+	memset(ppd->pgd, 0, sizeof(pgd_t) * PTRS_PER_PGD);
+	ppd->pgtable_area += sizeof(pgd_t) * PTRS_PER_PGD;
 
 	/*
 	 * A different PGD index/entry must be used to get different
@@ -399,75 +413,109 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	decrypted_base <<= PGDIR_SHIFT;
 
 	/* Add encrypted kernel (identity) mappings */
-	ppd.paddr = kernel_start;
-	ppd.vaddr = kernel_start;
-	ppd.vaddr_end = kernel_end;
-	sme_map_range_encrypted(&ppd);
+	ppd->paddr = kernel_start;
+	ppd->vaddr = kernel_start;
+	ppd->vaddr_end = kernel_end;
+	sme_map_range_encrypted(ppd);
 
 	/* Add decrypted, write-protected kernel (non-identity) mappings */
-	ppd.paddr = kernel_start;
-	ppd.vaddr = kernel_start + decrypted_base;
-	ppd.vaddr_end = kernel_end + decrypted_base;
-	sme_map_range_decrypted_wp(&ppd);
+	ppd->paddr = kernel_start;
+	ppd->vaddr = kernel_start + decrypted_base;
+	ppd->vaddr_end = kernel_end + decrypted_base;
+	sme_map_range_decrypted_wp(ppd);
 
 	if (initrd_len) {
 		/* Add encrypted initrd (identity) mappings */
-		ppd.paddr = initrd_start;
-		ppd.vaddr = initrd_start;
-		ppd.vaddr_end = initrd_end;
-		sme_map_range_encrypted(&ppd);
+		ppd->paddr = initrd_start;
+		ppd->vaddr = initrd_start;
+		ppd->vaddr_end = initrd_end;
+		sme_map_range_encrypted(ppd);
 		/*
 		 * Add decrypted, write-protected initrd (non-identity) mappings
 		 */
-		ppd.paddr = initrd_start;
-		ppd.vaddr = initrd_start + decrypted_base;
-		ppd.vaddr_end = initrd_end + decrypted_base;
-		sme_map_range_decrypted_wp(&ppd);
+		ppd->paddr = initrd_start;
+		ppd->vaddr = initrd_start + decrypted_base;
+		ppd->vaddr_end = initrd_end + decrypted_base;
+		sme_map_range_decrypted_wp(ppd);
 	}
 
 	/* Add decrypted workarea mappings to both kernel mappings */
-	ppd.paddr = workarea_start;
-	ppd.vaddr = workarea_start;
-	ppd.vaddr_end = workarea_end;
-	sme_map_range_decrypted(&ppd);
+	ppd->paddr = workarea_start;
+	ppd->vaddr = workarea_start;
+	ppd->vaddr_end = workarea_end;
+	sme_map_range_decrypted(ppd);
 
-	ppd.paddr = workarea_start;
-	ppd.vaddr = workarea_start + decrypted_base;
-	ppd.vaddr_end = workarea_end + decrypted_base;
-	sme_map_range_decrypted(&ppd);
+	ppd->paddr = workarea_start;
+	ppd->vaddr = workarea_start + decrypted_base;
+	ppd->vaddr_end = workarea_end + decrypted_base;
+	sme_map_range_decrypted(ppd);
 
-	/* Perform the encryption */
-	sme_encrypt_execute(kernel_start, kernel_start + decrypted_base,
-			    kernel_len, workarea_start, (unsigned long)ppd.pgd);
+	wa->kernel_start = kernel_start;
+	wa->kernel_end = kernel_end;
+	wa->kernel_len = kernel_len;
 
-	if (initrd_len)
-		sme_encrypt_execute(initrd_start, initrd_start + decrypted_base,
-				    initrd_len, workarea_start,
-				    (unsigned long)ppd.pgd);
+	wa->initrd_start = initrd_start;
+	wa->initrd_end = initrd_end;
+	wa->initrd_len = initrd_len;
+
+	wa->workarea_start = workarea_start;
+	wa->workarea_end = workarea_end;
+	wa->workarea_len = workarea_len;
+
+	wa->decrypted_base = decrypted_base;
+}
 
+static void __init teardown_workarea_map(struct sme_workarea_data *wa,
+				         struct sme_populate_pgd_data *ppd)
+{
 	/*
 	 * At this point we are running encrypted.  Remove the mappings for
 	 * the decrypted areas - all that is needed for this is to remove
 	 * the PGD entry/entries.
 	 */
-	ppd.vaddr = kernel_start + decrypted_base;
-	ppd.vaddr_end = kernel_end + decrypted_base;
-	sme_clear_pgd(&ppd);
-
-	if (initrd_len) {
-		ppd.vaddr = initrd_start + decrypted_base;
-		ppd.vaddr_end = initrd_end + decrypted_base;
-		sme_clear_pgd(&ppd);
+	ppd->vaddr = wa->kernel_start + wa->decrypted_base;
+	ppd->vaddr_end = wa->kernel_end + wa->decrypted_base;
+	sme_clear_pgd(ppd);
+
+	if (wa->initrd_len) {
+		ppd->vaddr = wa->initrd_start + wa->decrypted_base;
+		ppd->vaddr_end = wa->initrd_end + wa->decrypted_base;
+		sme_clear_pgd(ppd);
 	}
 
-	ppd.vaddr = workarea_start + decrypted_base;
-	ppd.vaddr_end = workarea_end + decrypted_base;
-	sme_clear_pgd(&ppd);
+	ppd->vaddr = wa->workarea_start + wa->decrypted_base;
+	ppd->vaddr_end = wa->workarea_end + wa->decrypted_base;
+	sme_clear_pgd(ppd);
 
 	/* Flush the TLB - no globals so cr3 is enough */
 	native_write_cr3(__native_read_cr3());
 }
 
+void __init sme_encrypt_kernel(struct boot_params *bp)
+{
+	struct sme_populate_pgd_data ppd;
+	struct sme_workarea_data wa;
+
+	if (!sme_active())
+		return;
+
+	build_workarea_map(bp, &wa, &ppd);
+
+	/* When SEV is active, encrypt kernel and initrd */
+	sme_encrypt_execute(wa.kernel_start,
+			    wa.kernel_start + wa.decrypted_base,
+			    wa.kernel_len, wa.workarea_start,
+			    (unsigned long)ppd.pgd);
+
+	if (wa.initrd_len)
+		sme_encrypt_execute(wa.initrd_start,
+				    wa.initrd_start + wa.decrypted_base,
+				    wa.initrd_len, wa.workarea_start,
+				    (unsigned long)ppd.pgd);
+
+	teardown_workarea_map(&wa, &ppd);
+}
+
 void __init sme_enable(struct boot_params *bp)
 {
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
-- 
2.7.4

