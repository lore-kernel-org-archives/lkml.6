Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAB0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138EC20652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hz6KcMqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138EC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeH2W0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:26:53 -0400
Received: from mail-cys01nam02on0068.outbound.protection.outlook.com ([104.47.37.68]:16160
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727399AbeH2W0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6PW9E0NX+svtefZx6/rCifZcI4kR5EN7WimzZP/yVQ=;
 b=hz6KcMqADc9KYJ8AmYMZAqKkajDTh7u3nCofgSDN8I67DvafBFj3hDFZVFFCrx6yUiDfW0xowDcCcSh6kGp8WpPL2GQC7tVG/MEYyC1+HOJcIjEDeQQqtwQa+FZmJK/XYTNzQGICgZ9mt2qOnfJc93uZRbZaLnYWbbSl4gHOKe0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BYAPR12MB2678.namprd12.prod.outlook.com (2603:10b6:a03:69::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Wed, 29 Aug 2018 18:24:15 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v3 2/4] x86/mm: fix sme_populate_pgd() to update page flags
Date:   Wed, 29 Aug 2018 13:23:58 -0500
Message-Id: <1535567040-1370-3-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535567040-1370-1-git-send-email-brijesh.singh@amd.com>
References: <1535567040-1370-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR1801CA0020.namprd18.prod.outlook.com
 (2603:10b6:910:74::33) To BYAPR12MB2678.namprd12.prod.outlook.com
 (2603:10b6:a03:69::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9674059-9b18-4ffa-aa57-08d60ddca101
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2678;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;3:PHPA63FKSOotxPxRnU+KYV9UL5D2aD6g4K9RjWnJzn/j6NmdPOTO0SnzCCPWd4wn+6AzRfgelpV+VZtVnm3+2ieasslFqTxdoZtEw5D0wu1Q+Sqd8VcLACayYH+48olM5M+480JdQyDIHZdUWf0a2K+kApwP+FPApBzd2UMhaLE29vZP7ToBrbeusAtwfcdkJBr5kHj5k6/mgZc9NuC0RG9e0sOxU/M3JOtQe4JVTa9kv2hG48lgFmHGivVAPPYW;25:QUbc++g7/jxAsHyfmUGqBdzsTIlJ7KKdIlLSTVhxMUoEnJEoNlgqnRLPzkTwFxg+qbjPVvylbF9yVfjlbNgxqFUByqvlAL2p/zkuy3Zb1RjfYJaN6Mqz8oEQaFSOJCGVH7spPe8Au6HujRejFfogM1wjSbwgSLtMfkoOFJsm8wyftpdpPTczntIaXqjYcY1crZq+jOaqH3b8rRK9P9RpSCyGpz5UlzP6bTINwFPRcPOlAngFUVz3CQDQR5IjoGCBwT4Mp2d+xyoKM8sAHDjF5Fm19uJeC4Mds0QN46+qVCvsl3YRwp6Ph5Mjm5NNyqziOnIy6SlsYYninIebsRWNNQ==;31:gAMb4oVRPfeRaXjtwerIw6vSYQOHkBX4AW6TwQVR26TzjBw0bG+WCO8aRR1nkjr5Db/MPQWEOQckQKhPEXm76Eu/qve5O9Qu7GdNSRxc+VI0MMNI94DhvJOuyYrNSkpa5XxqSFQCGnidqVVpSzUOR3IkVQZujZw2RD7zQ4DcAtBS5Bu0VDrdnI7V2/ugK89PwZ5aa/hD0tBHtt0YQRWNHBqymNmioHS4fn3QTAe1HRM=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2678:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;20:N8LXYy+zd9JE+7RZhZCHfre6adQYJ1gSiGg62hniWVHyk8af0AdFeouhk8jgflQ/hw46FzheVUUdO1N5QrKi3eYogdOKZaOHajE6NhUgV847mJOoSCIQ1bET6jn+CoVaXk0jpI+UYfKLibFKk8pAp3PQecNDGWS7elbGaTiNm1IBZsohEvV57r4ZEeZ0IYvMS8STSjja364grVFs0Y2V66djMkswvDF4zt8A/YlUGx7ytqV20LbdQ41I6c/nQdh0KOkS9GhdniEHmviFauJmzgG2RnhQ+OUzPiOgTPkc5P0QzfofnAQXu1NaIDBzF3+iKdCm3EtL9pUG8k+TnuxDs/k2JbCjND+z/76nh1F+vl9ROVCnFdTRz9OPa9LT2XebdzJnSkfsmKO2vb3efTTUhJZC/AEvZ8OGKDfih9d3tV/NGe8eEPLUeugoFxvvrFc71ddh3+BfCIKafHSnT8Jn3Vf8MJ5eWsj8FyYaDziYt72lvV8D/1nEVyuu8TxsiOiT;4:0c8ra8xzGMSORGTcsVngQ8IVulxsb3Ep0ixpA9nqfoagsNhLyovyPKhyMb9O8yYhrBkic/uxOLu9Sfurr88PRGI8pt8wvsezsKTCbJ1rxxtYUAzuxKoAz98SAoI7fBsmuS1Zh5ka/mLkB4pV2rdcDNBaSoDOSg8EDZKcpltkJJX6qOJwTKJJMMZl8varLIDBWkFCdlJYPf2Esqu95DZfqzuuOBv6gvqTLUIbEowj2aXMSIU9qIyIN3LEoyrzhvGJd6QrtMTnurDlhRh4Z6T+Xf8LZQKt3UTsjMr6H/5v4umI2CVz6PPu0IOqOX+Q83roNiu0TR5abcD3w2cnTS0NfOY8MAyYA8fhjWF4DaOKndU4pFP2VK+0chvY+SDTWO2v
X-Microsoft-Antispam-PRVS: <BYAPR12MB26781B0E728C987F2BF38F9BE5090@BYAPR12MB2678.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR12MB2678;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2678;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(478600001)(386003)(6486002)(53936002)(5660300001)(14444005)(54906003)(4326008)(6666003)(97736004)(25786009)(23676004)(7736002)(52116002)(7696005)(305945005)(76176011)(50466002)(15650500001)(50226002)(53416004)(36756003)(81156014)(81166006)(8936002)(106356001)(2616005)(956004)(476003)(3846002)(6116002)(86362001)(2870700001)(2906002)(47776003)(446003)(68736007)(186003)(16526019)(486006)(66066001)(316002)(105586002)(26005)(8676002)(11346002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2678;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjc4OzIzOmNRbjAzTTI0NU9uRmJNMFM1cENzLzZsK1lP?=
 =?utf-8?B?dndBV0lDWEZJdzdzZ3AxTlVJU0p4YUtBWUNHdnBkRGk1WkphYzJvSmduZzUw?=
 =?utf-8?B?eGpjb0p3UlpKeWMwdHF2ZkdTTlpBZCtKZHJaVXlrME1PR3h5clRIRXBIeEN0?=
 =?utf-8?B?MFllSWtGTjhBLy9RbEVFV2pkY2ljb0dMaXZFRnR0djNQektGR0ZkdXdpTWJv?=
 =?utf-8?B?RVlUSm85UkppYThhc1M4elVBNW5obVlxbVJpWFZmclR2ZWVGOWM4cDVBMGpM?=
 =?utf-8?B?ekQxY0xpYnY3OTBqOG5FRGo2bnFjd0Njc3M4cHg5cDJKTDI5d0lPUUQ2T0xW?=
 =?utf-8?B?MHkrWHQrZkxHc21FYkt2Qzl6eTVGN0JwcUVLRXJnSDlselAxYnJCYWt5aGJJ?=
 =?utf-8?B?Z3lnci9JTjAxRXhUdUxhUGtFTWI3U3FzbmhoTnFvUzlreEV1ZTZLZVRUTExV?=
 =?utf-8?B?M1VWVjN6L2NiZVRVMFhCbHhuSjkrMTRwMXNJUXhpMjczaWNDRTJsN1NGUTFQ?=
 =?utf-8?B?Y1VDeENWNlAzR3NGQSs1ZHRvWFZ1TGN0SzJSSTM1NGV2SUd1cGg4ak9PZWN4?=
 =?utf-8?B?NjFQTG5CeFpMM05JSUU4RS95UU5XMC85ZTBtb2Zwd0pzSnhUSzZhRUNYQ2Nq?=
 =?utf-8?B?LysxU21ubStvVGJJbzJRdzdmWWJVK1FYNzZJUmxrQjZYNUJlRmxwUmN3dW9J?=
 =?utf-8?B?RjNwRUJ2Z2cvQ3NUaENLdUxBbDJrbi94b3hNQzIrV1JocFVMUkloaGRkUWR1?=
 =?utf-8?B?ZC9McTc0aDRLbzFkRmh0a2JRekllSmNpQXdzZHJzTmZWOGJJUVZpN2dPdjd0?=
 =?utf-8?B?YmdwUVhXQVM3RXY2dDU3QUhJUHVRcE5NeGY2SVpZaDJRSVRLSENleG5ielpy?=
 =?utf-8?B?ZFpxNnEySXF2TUNISnIxNUlpQVNTVDA1TU9Hc1pGQk1wUXRzZTNzVWM1SEZs?=
 =?utf-8?B?SVlTeHlQajM3OHQrNE94b1dzWXgzSGZjY1dQQVpRVnpDQUxuZGNXenMzb3N1?=
 =?utf-8?B?OWNmaVBtYTZpQk5sZkdrTlBXQjZoUkluMHFCRWU4TnRIWG44Z01kV2lMdzlP?=
 =?utf-8?B?MENWSmJCTFNYWEhqck9CQW9id21CMUR3R2JSTGJqaTJzb3VKWlJSMlEzUTVt?=
 =?utf-8?B?TEdMTEhwU0hHdFExRTUxSytYRmFEVXYzT3BLcjR1Rkoxd2gyclNSQTBGQkVW?=
 =?utf-8?B?NU9vRWlIdDFlTm5CRjJaeWRXOXNReXI0MDc1b2l6ejNvdngrMlZacVk1ajJD?=
 =?utf-8?B?WnZ3TUoyTW9CcWV1OTdqR0NseXRFdW4rY3lRZUdaOUQ4ek1XNzBvSnMzTGRI?=
 =?utf-8?B?RTM2VlBGOXV5V3R5bWNYVlczMkhtWGdIc3p4TDFPSmJaRHRpNmdTTVhaRGw4?=
 =?utf-8?B?SXNmVTIwZmdIdTFZUmtaWEtEVWxZcHNlRkQ1bEJMWW0vMTFRdlpSUnBERGdB?=
 =?utf-8?B?VS85Z3pOWXR3RTJ0dEJJc0ZTd3ZsaDZ0cHYxQ2ZFeGRkdCszSlc2K1grU2h4?=
 =?utf-8?B?clhmYWN5OXh5dE5HelVqNUFDQWJqUWN2YzU0NUtaYlBHMWpJem1CVkt2aG1y?=
 =?utf-8?B?Y0ZCSSsxNTRxU1dXWVYvK0pGUlVpUEk4anI0WHlrcUFnOVd1SjlVZnJka1U5?=
 =?utf-8?B?aktyNWdBamtOdHppaCtmaEVISGlTaCtOM0loSVJ4OVlEZzBLMmNKaEF3PT0=?=
X-Microsoft-Antispam-Message-Info: WpH0h2pRsG8XbZbXsaTdvQnLWyYDoZR0DQEHxM5zlejdmzTaIByMZ1ppAeIICRK2u5EUJb+hYY7Yz7o3kkrjIxjprVY5nfAaY4kTEfmJ0b32cK2wghlCnyX1iAli0l5Qixy7vEM3TaUfdVNUPmWja3FZT79f05P2dV/XTYPs301+zbpsSY9AMt5SJ60fj3AjphlQuu4Kl5iWgky5EjGR54qPNzLgMfj3CB1H0haEa9tJcMrHto+7YLCHWOgNVhowSioo8en2y3NuIZqZyutH4RcVqCJ7nun0OYbb6RTrkCHwRb+A/eCyHRn4Kjo/VThlDNY64JrCgyv0AVv8rhiztWXHQZj0ybI5k88ubjLKVQo=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;6:lxgrl/5UQVXqJLbqrP3HIDKdFMInbAGHZIZ+aGSO2wyn6Ip3V64oWs3saq60ep9IFPgVjyyL9JtYenYwM+ZwMhuVX2QwdfuVnQNG6x6JGCw6pMoCAziFVGtzRh8LspK7qP1rAs44Ir36o0uQuEnDMdHxaJbRkH7TQIRF+ImTqOo8QZ2rsl6xy5NxxMOnN73dzC5+Q4SU7BbR+OVHfjJv21M/nXtpKQa5WSvneZwvCWhPhChPKqEffm1xNgVsCm7IV+CNIPE6kjTyc4Ox14YQlA1tUqDXUjCYDt/oEWGSUZqGOcDVHcvM/UOS5tsp8XW5Tp3/6plcYT4dl8KlPPcGB/u4+ta9wy4Hi4cAOo4NX6YeJRf84RN34yf5+6j15UFL4J56QZbHZaFyYU9f317rVQRYlONwA3TQQL/nMYXqXykqCmgLN2Uq+vTluDi/fMQmlJEL+xF3YQFjt4AlyVi8ag==;5:aTCBA5H92EzGDHDTMBHc/HINXStKxkUhVybDvJr5Sgd8FhzecVz05cGkfwOMlU9CziJD03iaTy1TwGNNSQaogG+qY4ZbAyD8aXjrhfYi9+nrlHi8TrtYXVqhWw7XOvA0cLVDctMbMRTr+izTwQDf3TGSuu2tNmsZxJXLjmyZLjk=;7:IzNuDdUpYN7eaBGQ4TuB4xbY+9Tc7+rPn5Uj1S+CLDAaisboml08je8qMa4cwTEYl3Jd4wAFNNN9SkQWgE9z6J1b3s8rcEWUPs1G9oeo77H8nSQdP/t8zNDdGvKTs/0EPNcJws0Ejf98cZfMF3SxXh9aPSFjVZG+eXDmOtL2kCpI4lfLZQDuq4Qw91SHWqEeHoNdp8KNX80nIa/3Ujgq3PL9VISTS+IZP0CalX0OaAi1vO0vqgvHeto7bk+NhqJ/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;20:3AUTPYXum7j8DeqgjjeL/j5khX05OJrQxiEHPFCrh0MgQYaQMbET/JaqhEZl35PMimeimx0shLsnnBS+i9xJeJSlu3r876kibGNq+fvTg/k7lidWLzQKoXn6mBYuYntItNBBzm9uo8XXyx+lQezCIBcmAD4iKWkbI2o/E3h5Gth/fcsNDZWlxcJA2gv0ZACJchx5BBix+XrLwAdxZQEL8VOnngPBU/4QHMlRaVJHJCDyziGAdOfsBzAVcjKK7NPf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 18:24:15.2366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9674059-9b18-4ffa-aa57-08d60ddca101
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sme_populate_pgd() to update page flags if the PMD/PTE entry
already exists.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
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
 arch/x86/mm/mem_encrypt_identity.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 92265d3..7659e65 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -154,9 +154,6 @@ static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 		return;
 
 	pmd = pmd_offset(pud, ppd->vaddr);
-	if (pmd_large(*pmd))
-		return;
-
 	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
 
@@ -182,8 +179,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 		return;
 
 	pte = pte_offset_map(pmd, ppd->vaddr);
-	if (pte_none(*pte))
-		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
+	set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
 
 static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
-- 
2.7.4

