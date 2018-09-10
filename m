Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBCDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F1920881
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="stHojf4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F1920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeIKCpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:45:36 -0400
Received: from mail-sn1nam01on0063.outbound.protection.outlook.com ([104.47.32.63]:25492
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726217AbeIKCpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGUVvpEV7A1XxRvQx5puWKxpATn3X/CNG/cPWyvqPaY=;
 b=stHojf4kBLB8fhTKLQOdAil1rlDrSWbseJfjtXUJ0BOmZXf0xpAi30U4b/9NapaRQX1BUq/3ISHCwrTwY5Zt5E7QyiMZ/5AXjyfrIF2sn7PQRc0suz5uNZ3jexx3AvcQXPHAMkZjMGPIEHCPKl4ppYkD18+JZcxKLF26pLSZXJE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:69::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Mon, 10 Sep 2018 21:49:26 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v7 1/5] x86/mm: Restructure sme_encrypt_kernel()
Date:   Mon, 10 Sep 2018 16:49:07 -0500
Message-Id: <1536616151-16738-2-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536616151-16738-1-git-send-email-brijesh.singh@amd.com>
References: <1536616151-16738-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: MWHPR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:300:16::20) To BYAPR12MB2680.namprd12.prod.outlook.com
 (2603:10b6:a03:69::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76de70fd-6508-46b3-52b3-08d617674829
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2680;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;3:G7QRfyE9rcLhHJp+kbW6NbeqGci8hAHHrsUvDKRlcIdu/kaoKHGIFFzVuoIA5XPtVoeMp4vbMb/dUK6Z8QGGPrTLQrWGmhdu/nxOfPdK1/0a0ejdCuVV3CX6w/z4a5gljuDp07mD9a6h/jbDbw6F09Yp44jogG97ovUnLd0+KubQQ34fc5suRR+sEYwKbeuwkipSB/4JULJ4X+8FMNrOkXmc9wVGqx1613a/DhQmURYP6FokUUYfef9b1gBZzeJU;25:GFbw/RfJuVLvAcqoxPgrbCPi6h6xW8G3cUNWFiGY7bBCBkxFrTARpX6B/1aU6WxTcTrB2n/+UqJ2JwahQXiGhNWpDaoFmwHI/sr1QkYQu62klcl6owY+3Ml7CyrnszfgAPpwoAy91sEGX0jwaWvblHaRhNlyBbmX/54TpU7cGu1VF4b9vNnlxH+SYIqisk+OtcUWAeG0wk0EMXINmJH/q1lMmxdHB1pFo8oLzI3+qDoyzkVK+X/Yr3ZoLgdZANEzlE+gqEUzbb+or4W1SU+144VlQQIWeWjyCTOEZg9G2eCYM1oKbH8smYra5+nVgoJluR1Rguo9XvPIEyMq+kBENw==;31:vAuoOKOQva7Dq7Yu3liDSZFEH4kPBiVgp1s8Ue1cZjSvDcETEFrZXpV+JemTnqry1GQAMfLhOo1FTrJEPR3J0hehzcw0Sgc1yKrNElkbjnHIxWRwmzKe3ez6lwSr5Xq49lJ/KCGa2MFvsmnMYKwjKeZTIlwzzs/TAhGQDXWYEl3uPIX3xSfsp/rFDDaw583g5C0wRYCkY4Ct5OWT4xwCtuGyAaQkLk+chvFTUp0q0K8=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:/PbfnZY1J7hISyWefcvoro8xXjAdx9lumXGOr62KJAGO9axR6GgkWaGAkA2Q5rMB1Uq1YBlmEvVr5nfbemtaBfBRmfCEn+o8KQ6yOs9Vro4LidkA2QrIHs8GDLJe0mfnf2jmxBZVqjCCAfisjLVO37nLqsJAC+aVv9yBiIDHjnG3PUBB+E8yEAJDRUjTCqJ1sHu+ap7dXZKeAG3HgWO/8ijuxEgCJkCQBW76MmK8ivVt4BxVzsOnhpGdRnqBsvAHjF1euP4W+H6kOESFV6KBd4vWjLwlrqoVrumbmNyaG9Rwn4H11jmgLMkI5cn015DxdQLMRASTFwo3NvhVMRqUqKnQixtWWozmfUYI1VlIHtginsa3vnt72UXt5RmAyCzIsgx1qiuIUd/Z5N9ZfPlimFFErUJqK/2K8jTZ21+jmJ7JcDmsjwfGjLbu9ZygGU9TJaMBCl0pT/x6zzs8Cm5i55mVLHkDZNrSUqhHmq9I4wG40oAcfEjHkVWDwQODHkzu;4:pappFMAt2qficBcF0L6whIU/srE+r+59f+0p81DLfZEfLYkp24tj7juqfwX2Lq3BklQvyUhhHiCW1jLJcCnZIFvwseIt29pC4CuOgZ/DWWyB3t3s6qEV7Q9zAHXus4u0XB1EiE+8TF/wJsnrHyHcEO5PZygijCvP4ezPfTb48X/VWedIeBrYuNk0yMksmz5yppBjSSdWmLjXpkpOPiEAxe9Vp/cCb0N8USKf7GFRBsgqG8+NPqquzk6kAR6IdmKDXBMwAfvHeyM63t/hN/eI5W6/ZrPUfFZ8t7k2cX4+jExHSFfSRFfrX7V7PzmzhnsUbhTot6dcLFmuaLA+ybJko331CW9t1vl4OIIBo+NE5YtZWu59V38aAs/Z7lm3TWSM
X-Microsoft-Antispam-PRVS: <BYAPR12MB2680C995EA287A3E9760120EE5050@BYAPR12MB2680.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:BYAPR12MB2680;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2680;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(366004)(376002)(199004)(189003)(6666003)(386003)(8936002)(53416004)(7696005)(52116002)(25786009)(23676004)(76176011)(105586002)(8676002)(106356001)(50466002)(50226002)(26005)(186003)(66066001)(16526019)(6116002)(54906003)(3846002)(47776003)(2906002)(97736004)(2870700001)(4326008)(316002)(81166006)(36756003)(446003)(81156014)(476003)(2616005)(11346002)(305945005)(7736002)(5660300001)(956004)(86362001)(44832011)(6486002)(14444005)(68736007)(53936002)(486006)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2680;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjgwOzIzOnZTazRabitzMGpycllOTzlQdmJsTjJKdWlX?=
 =?utf-8?B?QUg2T0FuRTdydHhYTndweGh1SnlQLzlhRndaems3Qi9Bbnk5WkR0RTVYSmp1?=
 =?utf-8?B?TGZjTmRiZ0plc2tJZnJIWGJjcVdUWU03emV6TmVmRzljbHNxcGRIUWhSR08x?=
 =?utf-8?B?dlV6YXZZMk8yYk11TXdpUEFTMTBoRThLandON0loWlF6VGlHK1hvQkcwNlVR?=
 =?utf-8?B?Z2t2ZWdJU3dlNnR3aTFSTGZId2tkMTRtTzEvRGtBMVkyWmo5eVdVcDYvRTBP?=
 =?utf-8?B?ZWVpOE9nUTU1YUg1bUtFOUl1ZE9WTjNvK2J1ZHVZYW5qdmswZXlFQzJSVHJL?=
 =?utf-8?B?RDAyVjY4NEh2NkpFRTd6TmdWWkJRWlNEVE5uQjVOdDZURHlZOE9oRldaU3Uz?=
 =?utf-8?B?RnkrYU9UOEJWallkSm0xalVwa2t0aG0wMk1lQWJ0S3l0YUV3M29uMDNZdlZ6?=
 =?utf-8?B?WlBMVERpN1FRU2ZOTnROaEJnVGRDYnB4VnBhRTJiQXpSeUZ3a2FaVCt6MnlW?=
 =?utf-8?B?Tm9sZXZvWWU0Y21HSEFVV0UzTkdNbGNYOHVGWGY2eTFDTkMxemdBdXJYUERV?=
 =?utf-8?B?SXZxTGt1L0RGMHQreEdvMXZQeUZEbEtDQTc5UUxCcUdhS3EzbjhELzZWTEQx?=
 =?utf-8?B?S3FYdEI5QmFLUnBqdENZWHJoU2JGTEl1ckNsT2dqZDM4NG80V2UrNGhkNXR4?=
 =?utf-8?B?WHlOYVVlOUY3ek9jcVNQT3U2TTBlU3cvM25FYVJ0Wm5RdVhsQ1RtS2hwNjNZ?=
 =?utf-8?B?czJDaWdpbHV0S21MZXJUQyt0cTdJRzloWjJUTXI3ejN4cjc4V0dvYmE4U1g5?=
 =?utf-8?B?QVo0SjJoL2FZSmtEN3pubytSUUFwU1ptd3NtUnFjcFBFWGRUZ3hWK1Y1VmRV?=
 =?utf-8?B?bGdwMTAzb2hNaHhxRFB2cUl4M2ZnM0haTFdocmNhTGhJcGxERFpqNGZGdkFx?=
 =?utf-8?B?eDJzbVJtQkRpRHVRTit2QjZOMEExQXV5cGk2dWhRZXRhaVh5d2xseEJ0TWdW?=
 =?utf-8?B?eGV5bGlTTzZ0VHZwSjV3VmpTQzRpY1g3TGptb0JYZW4wWU9lNmlWendxbytT?=
 =?utf-8?B?UTFDTzkrZktSekZlYVJTcDJLR3E0NFNIa1Ftc1lYcmFLL1NMbW5lamRUY1JV?=
 =?utf-8?B?emhJNGRxbExldWZNZTJGT0ZHNTc1M2tZbUdQWGZpNEM1b0FJcXMzdlV4L2NR?=
 =?utf-8?B?YmE1LzVzYzdTNzQvKzI2dng3U2FNd2U1N0lnV1lWNGVWUE1INXRoMHZnODFB?=
 =?utf-8?B?cEdrOGE3MEVNRjJZbXpuOUx3Wm5US0JqeVZYcml5Z1JDa0sxOWt5WEJhd2Iy?=
 =?utf-8?B?enUrdHd1M3hvdUg0S3JaUnBYREdHRlhhS3p4TU45TFBab2FLZEF2ZkY2eE85?=
 =?utf-8?B?M3pCSUtrYnc5OHhkcnpFQjNzcUtoOVVRdFMySzdTWk9NVEs2TVhrNEsyeDZm?=
 =?utf-8?B?a0FCWW9Hdm1ja0lxdk54N2ZXK3NRTEZtQXZka2hMYkU1Y2Z2b0pTSXRzbGRG?=
 =?utf-8?B?dEVDdGJtanNaYitFS3dlS1NFTG1rZmFJVW5ISFJPRTl3VVF3ajFVU2ZVTXor?=
 =?utf-8?B?MHhMUmxXbHJXNFdqVC8yYVdWMnVsbTE2RWcyaVl5bkE2REIyZ0o4TWdpcFFt?=
 =?utf-8?Q?Pv983i78m/hxCBIyRmGi?=
X-Microsoft-Antispam-Message-Info: oFF3C+4fwch8zBbAqEEZpsCwKfVBcNnwWr4ilwhWUCy2r2SibbR9jJlrOiutKDb7SCElA6t+LBKqrpg8kGW4V/PmIbZZpaHSKu22afViNVGACFKPNC6xg/ce1Xw0hssPlFaFM/JS2z/2JSz7n4oT9hzb+UycdV+U2jrmAdFRSOnEH8XGlmWBlWfolVXmNfzyP7iwnS5EUZYb+w6JhdttgUTWD+nePzIL1lSGY4HOFbORmSmOhozVRfx/7kJXdlB7yJutpDzVCzxwuJ4KyPDwtlQGxvZHXI3RfS3UCLFPg77F+9CBEO2RBj6EHrjIQenKq1cQ+vTmqwmgfOZ1sMqMzV2gPHSL9XU4hR3IIo4QMrU=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;6:g7yk+IsAus/TMklWqF3Av1AlUazs52JMQkgDHUJl4c0Nn1Revb5gHT5bkoaZOgSeMdy2SI2k0sBVhpmYjyszzOFGlbQBt6cO40DSvU31eXRpryUV457F3ZlSquU01jNcUxLavKvobOg3xgC386kbYfMLW7Esu8rLjD0jKG7EXMOV8BerQoXaghMk0OExNKXPIv/Q8Wn91dsggosd0Q6IVu7MRT0lg78MOYho25UHI2GK2ehpFls2JK+Uq8KWZ3lEChDGrC8WgM/ADdbD0mSos9B8/EawIH/TybA1FU0shcYjsH0ZbtWizlWkuA7a9zx4wDhlqdaBChc3pgL3RsWo3fySBtE/grGx6e0NV6ipfGQkmmPL6f2oiObJuk/pI9yQtIy5lhgD7tmjhDECRlr1UyL/3b22fOtBAZyLvHF9Hh8Sm/liT85/ioubaOjHLbC9nPGgGrXZyGIyKOnWRgFd+g==;5:xdG3QRwtrn04bB4Wc12OuXJ5xl5QZgeMcsDxitK+J//YHzfO2LE8689XJpuOOMoEh/XtxciB5cWh1E5J19ZMC+A+7raxt4ol1yjCarAKVeaU4zu2fg7F3nRl379Bfw/KmaUzgIXlA19YLtFb3V3Rw2CP63Tigxl7lq48XlEUuMk=;7:kZehIrmFYj5vzoA4oO1FNdzbEGQNR5Aqg2Y+4bOAKgjgXL+M9aNCw4ddObppApfw1WAocg4y/1fVw3ACXMqEc4R/tbOtsYoq7eepohQQxXqKHXQmpXMMec74IzjWXXlGlXDLMlnwV+j3n65fqJlpRoDyBj2sJ5LGICcRn/k0n+qM4KRgWXRFlgsoPDSwgzMaorNGcmZSPtoijaO3jZvIgncjMMn3SWu41uAJNgHRIjtX5mI1GH++iCJ/jakEpe1c
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:mGEjOeExKmdxHrQ9voNetkUFigCEcpnMCwdmss/YQcE5fpSAS+KyRTuCTWB8XuaYkpxK+Z6yzHu5YOdO1vKvDl1/jP18qx8aqXPWQFB2Ck7MybHNERJra+npgSE39Z/BEFiXtoCsHRQ8+HzEW+4oD/3G3+APPoZ6fDcD31I033a6Al48DTaKqS6hge6ak3/YROJLz77571FDUYEajvKemDXl4a6yt2XUecw5p9KZyBYW3R7RgE7+wFxlFA4i2NaL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 21:49:26.7483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76de70fd-6508-46b3-52b3-08d617674829
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
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
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
---
 arch/x86/mm/mem_encrypt_identity.c | 160 ++++++++++++++++++++++++-------------
 1 file changed, 104 insertions(+), 56 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index a19ef1a..f488d46 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -73,6 +73,22 @@ struct sme_populate_pgd_data {
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
@@ -267,19 +283,17 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
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
@@ -359,17 +373,17 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
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
@@ -380,9 +394,9 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
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
@@ -400,75 +414,109 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
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
+					 struct sme_populate_pgd_data *ppd)
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

