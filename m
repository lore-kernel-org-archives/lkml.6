Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B593C43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0649820865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vPdJ/A58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0649820865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeIKCpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:45:38 -0400
Received: from mail-sn1nam01on0063.outbound.protection.outlook.com ([104.47.32.63]:25492
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbeIKCph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42yVdvoyIC1InzIoKeYQOpTIGg3B1LvK6y5816cXV2k=;
 b=vPdJ/A58hB8GEBVx2+nNXFvxCAsXvXoHmpldA3260cYjbxUFSmSFQsNJg4RZ4qnSaJkPbeuPDzH9jVHMYWuAEuq9+31y5/y0mW0sxhINladLhe/wfMUfEw3Oy+hz1Z6bepzns6dL7min5q7drSBcpuZtLZvc8eW9uS6bDuUwYmU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:69::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Mon, 10 Sep 2018 21:49:28 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v7 2/5] x86/mm: Enhance sme_populate_pgd() to update page flags
Date:   Mon, 10 Sep 2018 16:49:08 -0500
Message-Id: <1536616151-16738-3-git-send-email-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: acb69080-b80b-4a13-08a9-08d617674926
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2680;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;3:Ja80zGwHHSWqqyNwsGL4xU2JxgyHKbcPdmfPFObR61cqNZMd7rwFsCwAfvo5R5PyzFrTygA3iPoH8Jv7ALBu77Phw/Mq4SWBKwz6MA2GaaZp2Q58svnZ9TXCRvK9ijhxMyHIC1CoNezAHr5f9l9GR8XReQmxIJpSLKgRmsvEG6Gk+PoAVmlDax2oR4bxuqXqZdkFAqCdFNLlYq94iciEnGJfBPhlJde0amClFXcGARu5Bm6fORBJ8vZ3QbKKWepR;25:clCkFtEEyub0e7VE4GGZQ7Zu5y1TXUkRV8f2+4mwjNwYGOiQ8RTD66lJC8akesu9sJUz/bfSR7L4oclvm7rIbPk4Nwm6RWuKzuvFGG2hIqU2jCWlVfSqYmDuEKOl7quEuxDdebdIgfxga8N8e9RvrOxhEIVoiUyw1Ydt/hcy2xciG4Y04TA4IPdSAoKDhSgUq09ci0EUUX2j/Ku6/J+BGaGBDxKMSLuBW4uO96++WImNryjDy3xYfqnyq6ILbqXFQdkzwlQe4m6Qtp7VlybAPCur2CKITZsXjyu0tHaHLJWzjoAGOf9UCXZ4C/s8PkYrN3nMVVFi/1nftbc88+gZBw==;31:sXLEDb6GQ47K66jJUTTDl7ejVc4GRbUWHsBAeggQL2BQJnySZJtxJrz3clJZxIREsCDRRmyupVqrdYrKoa8J5MxmnElBJ9MxPbOBzkSRGe2YfQrQZokSUrqeScZXMk4VwdDGPZsYNqqgL+l3GYoDLT/qkkg9VSWJ8+L9qyQ8/kxDVD6eRsyQAHLgeMJw6WckDGf0xdU+07G1mApltxBBxxoLT8v7SD8OwGjjQAWpB0w=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:S2cQ35z1pCUq8XmXNccXNs7/cBQ1GJ0JB7w/lN7v9ERpdbkQGjvdMK7IjJ6pRerEeN1Hm3VvtDTMs3sXfL6TlfWqFQ2B//txntG79yYLnBXlY7fjpq0MKJG//Pn5YxsZE60pH6R7f5nfzPHIbPQXZXS5s7zQtcXKKkMpNj0NZTfy0qgRtamHH+GTFMsTv3n1hkaKaT5RmUeRrZZy5VP2IQHc+zlU10jCZhvegoel88bML00ue8h7S/FDPxTcunPospMlI5FhBznbxV+rNpDeyXdIkNj9sg+Gbo6upW/d0t7R6G5uUmWGm7fBXHaF+BiMDnWuLRcSZZhdgoiIGDfeuIhs9yI8VTnSKz/lp29j2fGBwy5Kt0Lvbap+SfF01+6NlbUj1bIXSrUBmOQmg0Uh9rsKKt0dP+BPRGVVWv5IV7D/wdZcDCUf2fDkTcfeH6syOPbSjN0LevQaTXG20tOTbwOFpk4FOYerCD7W1x0M2/lMc8lCxgS/2t5b0k0zhTp7;4:nwru5Vqaer4PCTJVAlgPMXMcLWS1rP3Fw0/y+z7hhBPJjqvx3hwW5RopKzttX0XaMYuvfjd5tbu98kg13VGx8n7860SZs/yGVLT023blSRHQRbIZR82Nanco4MDejne9/PPRAZQEvnHRaBIs5ZQQ+Uu/VsNOnR6/Hq5COUQ50KkCHhcXcLOwAIRgjTKJpbnOeX7Li+GK5BqAFDYuz+686QMKqHalyYXUyKKhaLL3FYRrf2l+ZTwIFf28bec3F4zHZTHogem0v1S63MdlmMk3H5ZcF1sjx55kj/PAOg2hKt1RrfauDUPX5CSwo+WdF7Y31A6fZ/f5qQl+DXj65GRyguATu4Sze+2Q3JUeVYqNw5l2DhcZ81+bNg7CIVK9z9qz
X-Microsoft-Antispam-PRVS: <BYAPR12MB26806019F0C98993CD568DC3E5050@BYAPR12MB2680.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:BYAPR12MB2680;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2680;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(366004)(376002)(199004)(189003)(6666003)(386003)(8936002)(53416004)(7696005)(52116002)(25786009)(23676004)(76176011)(105586002)(8676002)(106356001)(50466002)(50226002)(26005)(186003)(66066001)(16526019)(15650500001)(6116002)(54906003)(3846002)(47776003)(2906002)(97736004)(2870700001)(4326008)(316002)(81166006)(36756003)(446003)(81156014)(476003)(2616005)(11346002)(305945005)(7736002)(5660300001)(956004)(86362001)(44832011)(6486002)(14444005)(68736007)(53936002)(486006)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2680;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjgwOzIzOjZRRXVqZHdJRXRaTGxva1d1WHU1dGhXN1Rh?=
 =?utf-8?B?T2xpOGJ4Wm5rdTdNZk1TekswelZQV3ZtaER2R0tXTXNMbEtwRFdTbC9lTHVq?=
 =?utf-8?B?ZWNLVTk4L3V1UE0veU4wV3UycTIrcVF5QU1hbjRjeWtMaEhzNGdNaHZaY3lp?=
 =?utf-8?B?c3B2dG1rdG1hUmtDbk1iK3VzSEJlUEd2bjZ6UEQ3YlRQMDhXSkJSd2lFb25I?=
 =?utf-8?B?enlDOGFmajVLUWdQMkpSOHpVektVU3NNaDExZGIyeHRJTzNRdGwrdUF2MXhP?=
 =?utf-8?B?dCs2Rm9kYUkwNFIrYi9aN211a00wNzNRem9rb0pmYXN1NG0reXYxTjFLa3lx?=
 =?utf-8?B?VzFGWjZxRVpObnozOWk4WFhmaVFwNjBxRWZVVGswQkl5ZFNWUWxsc2pYMU0z?=
 =?utf-8?B?eG53TTNpaDFyOWRnNERJTWZleTd3Sit4V2E4OU9IZzdoeStzNmxBd013Q0NH?=
 =?utf-8?B?OS9xSUNVV2FZZ09WTU1rU0FmWTBLbzlGOEJGVlorbTU0UHRwOW5OekxHemJi?=
 =?utf-8?B?ZmxROUl3SW1RS3l1VmFhQUNQY2MyaTRScjBYRTFYWUxjOVhVeXNYS3pOVGxJ?=
 =?utf-8?B?UkRDaWtpMnlGaGZFbjRLWXY5QmxpakJZeWttMHNnRWlxY1ZQd1p0Q1g3N0Y5?=
 =?utf-8?B?NW9NbGJZQWRSVWtZSVorNEc1VmFqNkJvZFE2bTJPbEd1NTdSSTVybXZZY3Ny?=
 =?utf-8?B?T2ZOVUhFYy9rbGJCZkRXcExCNU41dDdyNlJ6cHV0MWRTRERDTG5Ddmd5Mzlv?=
 =?utf-8?B?N3l4STFMSXlkMkpZRmxORTNsRHA0WExUQ0VkcTNoSjFGdDluaUtpdHluM0RZ?=
 =?utf-8?B?SFQxUzM5RHhjaGluVlJJYXA0SVpLLzJFQTFXYTVMaTJuRGNZMFJSa013NzFL?=
 =?utf-8?B?Skl4a1J6ZkdCazRVVUVFZjIyM3hoWmVteEphSWlDUll1dGE2SUVmRWRNeW5n?=
 =?utf-8?B?UlA3Qng1amJTWTA3QXVnVk4zRjVuUDk0Y1hjU2thQzVtcFdXdytOMW5JMU5O?=
 =?utf-8?B?ekxIbXFGelpIK09pVW9tS3hqa2tLNlYxL3JteTZSSlIvSTQrd3NlMmorMUVs?=
 =?utf-8?B?anJwSlRXeFY4cStMem5WNTFPOTVCbmp5QUpPUi9NWEdiWFk3VlpTR2llNTlx?=
 =?utf-8?B?Q0ZRT0dKSGxGeDZQMmE4WDdTOGFaczY5QndpampwQytRVFZJTmJLSjFGQjJj?=
 =?utf-8?B?dm9RQWdRWERpQXJRcEhMcytLQjZ4bHdJeGlWRWJnclFQN3IwekdmVFhGQmh6?=
 =?utf-8?B?Y3dJK1V2cmkzeXkxcE5uM0lRSkZrVEhkM0FjWFZOTUlRTjIvM09XRmZrUmxK?=
 =?utf-8?B?RUNob2dJMm5CZkdNT3dpWXgxM1V3UDRKWDRaOSsvWjY0ZGphaE44WXhGYnJN?=
 =?utf-8?B?M285RkM5dkNWUHNMb1EwTUUreE94VTA3NUVvMWF4STUyb2toSkVQRkI5RGZO?=
 =?utf-8?B?VGRDTEgrdUlScUNuQ1N0bmplZDI0Y0lqMEllRVppWFlEM3JDV2pQRHZWZE5L?=
 =?utf-8?B?Y20raUx3Sjd1TDJpYURHVEpyNzRMWG1wRmpySUdsNjAyaHp4RnhzSUNQelRW?=
 =?utf-8?B?WnN0NTJMY3JMWmtqQkY2TGdCcnFROXovNW53b0JJRm5hSkQwckxIdENRQkEv?=
 =?utf-8?B?QXNUNHE0SlMvY0JaaFpIVklOWitLbmNxQmV0T2s4TS9id1c3cVB1RmJBPT0=?=
X-Microsoft-Antispam-Message-Info: Es/EH202RIU2TyQ4OCZ43oyvgxqj+LPQOqOaLapREwg6LJ1uGnrZapi+JXOkLLWEQsn6lOm29e8yKbU97OikFNSviwzR2wqX3zVGfbMHR6Yh1Rq60M2Grk+mm2k0qi30PVXRn9cQFPwHP6GnZSXpUj398zr7gdrC8rtgVofykLTur1HKO1yCGrbZHBHisQ+/If7GSSLfw6137gQBTi6mlcluTfsQHUeZJZTalhmD1euCfT5jkFc3HH7PRSjzD1/ejGmWzU5zfLB9ZRnB34blY6jDrKtqwHq++ZUQI2AJKUr8OjizgWRv7aqh5v8Wayara3b0eAoXGVdJ+RMg/UMNi9nHgYrbWL42oKKTV2po/6I=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;6:Z4pdOcenn4cVfMgTFJ1L/d1lbugQIgeScCU5T+ai74PHN0u9QjDqfbeyx3VA4mOs5Swn0HsjNAgxVoMjkw9C+Y1vfWFDSvKPkHdfktwGBcsvrSk45p1v9Kc96slV41b5XtYmwaiXg2F8VqOiHXiWKTzO5VK8PfQA9XZEugL1RrLt1L4JRsTu8k9x6oieb18zkzFl/sXqa3AL9UJgq32FfAIHL3RGGNHG9o5PFlzWTxT9pr/ZfICEr0o5MoqTcCh22gwvNhkhjRswerth5rAc89hy5yQE8diJ34Nlu98/v1MacXMc7kTH9nN1gKyF52Gn7v3uJ6P+qDJO3B57aRcMOpiFzq7Vy1V0/zBKhrHEgcRdnPDPY07H4ijNoP6IP/MmY4CDdlqS1Ds1TtPFE+QVX6H1qQPl2C5Vlua1ByCYcVnx4n8zDqPE8uZtujvwusmvS7lohq/4EsT4ZD5krURN7w==;5:lH7XOZwQpggLoKG2egZehduXuRjIYGMsukBP8g0HWgPOoEfmhQNQqBhqn6U7T7sMaWn8mNR4V49GpLOZaYNgVeYAi2Y1rmHbAy9TJNssx6Lk47hDRJFscoyjrlYKoYG57kFSs/nWF/rxNghDgg/0uH6tfFqzABoOlQ44UQ3yT0E=;7:7dghmkcG+zJlBjBjSS7njqZBGTJv30GuwUbkPYsoc3RDwPhHUXT1c1OX6sh0CxjZ0g6jPvgHikFkYaVRWlSCADZ3TNDZc7Sqq5kkRJtU1A1uXnsSPWOzzGgZ8eJusgF6ZE5zHBdvIES0eAkWdPXU2y2gvUAa7XIOxI4f+4awe5CW4/+FGVOu9sYXHCQt0eNYz7xZsDslvqxz6ySLOwwAOpyWHDKlat4L0uG4/un0zSL5J3YDDXPx2S9N5AmMsCQ/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:1lg2yYO8JLTHH4NOvr2961fOmeA0149NOh3SPKlgdNSEvMkpY3a704YvO0igqKCkbwYcB4cFEPNLD/aNa2Et/lo+u8Y6dzOLqDa+jvGzmLnz5lmF0qrSLgX/filF9kb/Pw5UKt5q34cuhJUkIFJVCeyM8LNhWN/M7dAROggekUpDQ5vfFvpx/5K/zKuoyJfv/zAlbTTnYKZobpxj3Tw2Z0Tr5CktgyFh5cdvsqGoY+I/ORtc9nayhVwk+0iDEr90
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 21:49:28.3564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acb69080-b80b-4a13-08a9-08d617674926
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance sme_populate_pgd() to update page flags if the PMD/PTE entry
already exists.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Fixes: 6ebcb060713f ("x86/mm: Add support to encrypt the kernel in-place")
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
 arch/x86/mm/mem_encrypt_identity.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index f488d46..2b245af 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -155,9 +155,6 @@ static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 		return;
 
 	pmd = pmd_offset(pud, ppd->vaddr);
-	if (pmd_large(*pmd))
-		return;
-
 	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
 
@@ -183,8 +180,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 		return;
 
 	pte = pte_offset_map(pmd, ppd->vaddr);
-	if (pte_none(*pte))
-		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
+	set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
 
 static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
-- 
2.7.4

