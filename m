Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831AEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADB820BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fbtBJzj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADB820BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeH0PLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:11:34 -0400
Received: from mail-sn1nam02on0085.outbound.protection.outlook.com ([104.47.36.85]:53246
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726825AbeH0PLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZVn/LqAcr1tfI3v3ahAi7q1Qb/Ixqiw6dXCZ1qizDE=;
 b=fbtBJzj7YjxSLSDCUp5eouzzkD0yzHHQYdtIvGQbX5ce1opgcalRVul1XHNil5YHpOq87Xa7dg/B0TXrEmpg//XJv52HL1uaoRWn1wd020p9MWp1Nr8b/oaw/7m3sgWRGZXCEJFUybPEOkw7C7PIdrCkMzm+o3m/KgN23MR5Zrc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BYAPR12MB2679.namprd12.prod.outlook.com (2603:10b6:a03:69::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Mon, 27 Aug 2018 11:24:58 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>, stable@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 2/2] x86/kvm: use __decrypted attribute when declaring shared variables
Date:   Mon, 27 Aug 2018 06:24:40 -0500
Message-Id: <1535369080-20290-3-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535369080-20290-1-git-send-email-brijesh.singh@amd.com>
References: <1535369080-20290-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:3:ac::21) To BYAPR12MB2679.namprd12.prod.outlook.com
 (2603:10b6:a03:69::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e15e006-dabe-42aa-c267-08d60c0fb9c2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2679;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;3:hU8pkNBTWKhOYMV7BB4HgXRxI7z2BvKMkjAhyQTIApKcWAiwISI4UpRJ2h118mffnXfv7NNTfiIzQDq/fmWFYef5yzeJYJlUrnp3gXNMsXHKM1wbqAT1F3qoU7Jsr0iXZqFqxlLvf8Lp4nkctX4NlsphxyxfahqrRiISQH0ej41WbbtcmfQ7NLA4j+9ckhJallU7/DKDLdoYUdBeHfynAIS/ogp5OhnpqRpg8YlMdk7Ik1jdpMxXLgJLQLV2Kb7o;25:JsZYnGPuNw79svDGalLWd8yR3gSeXcbKZxlmrCA0b6CcsccGRaGMV6iong9eo1ZPUcFyd0qwMg/2cOlYfJny+u/KJXG8H10fs22q6qoHbLoXRDZGiu4eVES8BvJ4S8t13cZ3ecdXhoaby+yeXi6u0/ehe+S80TYVCrEg2B92teLE6PfnrIPHP0tOllB5wxpN1nrQdxXIxuJ2u1Rzh8HeE/RtjhGEPSpQr8KZNrW8PWKj/r0EjGe3s4MKkZu4iaHufaoRJp7YmPJFQVC5Cuhk7noi8ZkLfrMLPOdf6nZTkRwijdz8XC6LyZDvdlFCaGJG7TPhq2tBnXupzrH9GSOCxw==;31:wllxjKWv/xc9H09lxNHLCWkuGf0E02Gix8mQwOh8r96P0AV59G0X+qBRf0ekGRnthMeYx9GGKiMtxVk7b5s0wxCGhgAc5f1yHz51TCEN+DZu4GdCnPENjX9TXCvKIONNeAz1k3XwH8150URv8ZukFjBWwO6nBDcyO5jr49me1JkGZWIBmyNqdYGv+RgBUo1zwhK+3C8zi0P1bcdVEjVYnpl0HiGnWD9KFq6QlpAXots=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2679:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;20:s8DOkRvqTH/GtAXGvszFub4Q1RTEJGmfVAZcg2rDYfixt5jcU9v3leXpoOp5OBkc97DkRtpCF59Fc8cyNSsyBOqq7B/A7wyf9YnG0Go9lehkYJQPUmdjfDiKMlJbSSfbWn2NZsFOUETD1qYSvU4C8v3QsVcCNY5A+TTrBz/7XePIWqdcSAUka0IabfWIlMlfyuuwxKns6wiX2xhPX0009priGKqwmCh9erY8Nk6/SkBDk2OjSnCOt/LyiKzWVl05nLTLMrHd22iJGTqTma7rVKryvU3qnu8ITOR19lCP8gwd4ZKHcChoaeTNQDKGybZcNb5WKCjHTU0dCyzsQXTN/kENnO7W4H3bueSbHA03IPk9UGvP0hrplZSjeAbLJ0mh063PmJkyuGOO3jzc8VE9XJz+jJcj+13avMSy96LJVek2Vzw/hEPKHty1inDhfHEbWVA+vx85S6IAZojdwehb2jVLspIJfsq3rPZzWVbx87oM9IJq9VKW4c/rU4c6wznd;4:khGIYuew1iDgwXikdsF3PkPlFTa8LLb6ouI+eCPqaQvBltY8IN9Rm+xIKVUFIZSZE2JlQ4FP6K9V3d6Uo9oSr8EZjtLGo3WWgpIW6hY8kIVHPQNlHCCH0uzTWxTMbpQK2oWUxwIkSbPDvFUPrp1KbEsXrB+A1kei9CQZmKPUi9bLulqtsM9bomK/SSaZNsdgAhCqdfDW7G7gNcbeig4vSbWWicN6/UKUASXTI1ZaySWqY8CWqPNpQndKM1RPGJVTYA5Ed3iEpItv0xCMABM2E6XMS9S7xxGNmMouB7jaK3fP+DJHQXx2s+zYVq8F//sZi1y/KmYh1zc+vJVxQD1Tt+C2cxOF4u4MjhqxZ+Pyej7E8rh2j9YpJc6p83uwzig9
X-Microsoft-Antispam-PRVS: <BYAPR12MB2679F0E71565386B09DCB1FCE50B0@BYAPR12MB2679.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:BYAPR12MB2679;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2679;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(189003)(199004)(14444005)(5660300001)(8676002)(81166006)(81156014)(25786009)(6116002)(4326008)(7416002)(23676004)(47776003)(316002)(54906003)(86362001)(97736004)(53936002)(44832011)(76176011)(7696005)(52116002)(305945005)(3846002)(7736002)(50226002)(2906002)(8936002)(16526019)(186003)(6486002)(105586002)(53416004)(26005)(106356001)(36756003)(68736007)(476003)(50466002)(2616005)(956004)(11346002)(478600001)(2870700001)(66066001)(486006)(446003)(6666003)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2679;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjc5OzIzOmZzQkhHMGFTS3RpbzVaMVRrTEpJbnFPV044?=
 =?utf-8?B?SVM4ZCtXSEJ4QWpNZHB0eFlNU3MzbjRDVnlRZCtlMUxuNGRYTUpaRE1yclFV?=
 =?utf-8?B?RExRSWlpajdmVHhnSFhnVTdaVU5PR25udDI3TjhQZERNY1dKR2UwV2ZpVGcw?=
 =?utf-8?B?TFNTcGozUE1BRkh3ZzM3QXlidENtVjhFVUw0WGdYajJPREgyZUJPcjZUeVlw?=
 =?utf-8?B?Qk5qRU45Y3NrOFlZZC9DZ2RCdm9OZjBjdXdSS2RDNUVXYTNLWk1Nb1lkdDc2?=
 =?utf-8?B?Q0wzMytRRm5FSXN0UlZ0RDFOOHBycVVmUW01V3dNWnEyTkRNL1dOYnZWTEpr?=
 =?utf-8?B?R0kyZnVVZVhrT003ek4vUjVsbnFOOWtWY1hUM3pDeHNESHZXdWYvbjFLbHFI?=
 =?utf-8?B?Sjl6ckNWekVGcS9xVTJXTkh4bktTZTdyWkxQK243RFZsSUtXM25zcDUremJK?=
 =?utf-8?B?a2c4NVZmS24yUmpvRW5lQUNlTXhiYzFCNkszOUtnMTFaZXdNa09CZldOQjd5?=
 =?utf-8?B?b1l1MXc1V25YNTNVQ21ra0ptNGYwdzNxYVp1a3FuZ2hwZjFXa2lGVkhmRVll?=
 =?utf-8?B?QnkzaXpQUkF2N00rS1ZhcHlBT1Z6S2FMSzBFYlYyZlEycGg1ZnNJSWpFZEEz?=
 =?utf-8?B?RlFqZTJvbVFRbWVjYjhxT0lVc1oyVXhsbjFaUE52SGtsL2FmSGI1ZDF2VGZM?=
 =?utf-8?B?MTF1Zld4QXFoK29EMWJTaWg4Ry9tdmo4Z1RPRVMwQjh0NzhNZWxta3liOG1I?=
 =?utf-8?B?L0R6ZDZKZXhBUE5ISS84QThaMUxOODlaT0VpemQwelBRWUhTbi9LOHhmMVZi?=
 =?utf-8?B?MGIyS3pMVW1oZ01BQzRRbWlKbjAvQjN3MytvNnhqMU41VTJ0NEFhMWpTRndl?=
 =?utf-8?B?cW5zMncvREdXSTJJbnJneE4xOVU2N0t3TVlNaXl6alJaRjBNMTJaMzFEcitn?=
 =?utf-8?B?SkdvOWNONFpjWERzbDVqRFhONkFSdTVnU0t3bE9FcWI0TVRadHZjYWRTTU8v?=
 =?utf-8?B?WU9SbmFiZ29vL0libzAwMk1vVVZocUxNby9OYXFZa0x2NjJNRlMxTXA3clRT?=
 =?utf-8?B?ZWdackVtVzdDZFpBOEViVC9JSW5za2NVbWlIZWtXWlJWRGRnVXZlR3lMSi8z?=
 =?utf-8?B?MGNkeDBzVWwzZDBldExnQndVTEZtcXpZbXpEYWRNVXlxVGJTZ3FNcis0TU53?=
 =?utf-8?B?YlhKWXNGeThFWTBUNXY0MzBQMkhEWUF2YXFsc09zOUNmenhmemlSWUFHQmdK?=
 =?utf-8?B?MWJUUk5FTDJoTmRqVHEzRDEzTnFQa0ZycU9lcE5PRmtHUVNOb2RTdHZjZlJy?=
 =?utf-8?B?SkxSeE12c3djd0pXMnZJQTlCb2J1WnpiSWpvUnphVnoyWXVEK2hnTEtMdEtY?=
 =?utf-8?B?TUZYelp6M2tHa2k3RHU1QzNWT2lNQ0JPczJDZ3k5YVFacStqdnk2emNpUmpR?=
 =?utf-8?B?Sk9vWnhudTFKMUoySkdZNmhHT0VxRk83bmlLY0IreVFyYUMyNVozako5QjZW?=
 =?utf-8?B?Rmt4WGs5c3FFa0xVNDVkL2E0ZGVreEVKUWhGanBHcUJ0a2x1cmI5NmY2U1lj?=
 =?utf-8?B?MGtOc0FTYU1OOGVQZUkxY0V6T1hZQ3NHdTJLQ21kTHgrb0EyUnBnWEVZdHkz?=
 =?utf-8?Q?W0PWKfJTc8xvGZKExA9o?=
X-Microsoft-Antispam-Message-Info: bl74Cl+jCSgGSzZiMppEvn/u2T1ro0f4vBgCfftM8Zo26MNcmKmLk85t620i+AgWW5itV2/Z/wE0wWkZDlkypE3xrGOmz/INJ1KJEI+XNtkCGIffxBfG4PBuLG1ttHJZdBh2GxqU0wKKMjO4YDUzXXtmj4eVrAS/jkDbeu93401AFTWoq3T0eMBwdyctJav52JZ4mN0YQE83v9ge8uqGtZWTJGGrw1d8FddbTedCEoV2Zm3FYE+ku63vOPK6v8c1h1fVrffB4VQCmr99KKcG2p+J+Efa2FV4ttqm/uETDSTaYUOSzuDZey7igTU96qp7vvu6jiIadM3GwpC/oQq+Eqf8ieOUJajjWG9viEqk1Ls=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;6:vnE867RCWGRnJpBg4ZzvLOw3z+4UCn+lshdBlW8FWLJpgfrCYEUtYnkecb6u0HJqzszLAMeIdDSfx13MAhtSpl2yFNrOPS5HQSj7asxhFEb7xcXBQNIekVilN2WUM61ZggJ+/wV0765ASpWCdaNlq5wap0ipuQZN5s+8lDIf6917huCbHc+1SkdXELOy4sA7pALKaNrFEEQYIm33YovIc0V70hp7+zTzJyz9ix5OKSeYYkADqzO+ekuE6WgzPV/0SK3f4bct4jlglL59cfF4liG+Jjcv7VQHBXCl0QrGKYU3yODei0136BXQbVjB/Ya+AhU578gBWcvvM/U6tQMbK207ZrcC2oUXKfSJk00N82H0qAS9PEb3ZgUyO6+vDGdAxAkBHgNORuzJvDqtw5pz6O9KH+GOR+js+N2liTGKF39QDdP5tTsvZ+3usqUD13zrUexvecDpXCi72bAPDqml2A==;5:D0c7S7Jlk4zcms/z1dcZZqfQV749lixhDn2aP49PrsWocMvasw6Nv6g48vLyrqYOYFYUVCukqs4JQczuDCmAQS4r0bXlKEpgVLBuwo29Ic9jufXczIOnqZzoWMHqNlIZxaOd6aPkaGZOt3Yl5CfCq05bm19tyO9xeoyx+Dq97W8=;7:+3Q9AOaG/bNj1MGn/0O2QAFwk0Y4jpx8XqZD+XIGKJklqG5v3gDojrD/tzAwdApTHKc6BEydc0C8gPvXNRFytPnKLrSv3ctSKUoLEgDAl+17hID8BolQXayiWcLOydaEz1C07zDOJajqnZjMDrJNHWUgyzA/FI/u+1EfFk91YniBdzYcH3ffmIVaGz3PAdgBXBcwn4dPe8oItcORS3fi9KlnykHRdFVRtyFGL3ChwuEFLd+DuiaRALR5Khi0Gfop
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;20:dTqVDB4h+SGAv/lcjKVfYPudFYgrm1RkjWikjXxV6wI18Ivm/D1bbXhZs3GOVuVMdpyimFAnvTmQVAnyoYIvnmImPywBF4L+to2LGgxgzdMzn0rwYl1MrQ0T/CziS1tVAx5LqHmuC8y6LeUuGxu5fiY4Roh+buyBQE0fAI+9YmdORgL0Cnur0Sx+xZwiNAwr47yD+CbOioCXFcva2/9u+hQZwbFX1hKWhCmbcsOGQP+VmfpaXZKs90esX68qoqmo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 11:24:58.9728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e15e006-dabe-42aa-c267-08d60c0fb9c2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit:

  368a540e0232 (x86/kvmclock: Remove memblock dependency)

caused SEV guest regression. When SEV is active, we map the shared
variables (wall_clock and hv_clock_boot) with C=0 to ensure that both
the guest and the hypervisor is able to access the data. To map the
variables we use kernel_physical_mapping_init() to split the large pages,
but this routine fails to allocate a new page. Before the above commit,
kvmclock initialization was called after memory allocator was available
but now its called very early in the boot process.

Recently we added a special .data..decrypted section to hold the shared
variables. This section is mapped with C=0 very early. Use __decrypted
attribute to put the wall_clock and hv_clock_boot in .data..decrypted
section so that they are mapped with C=0.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Fixes: 368a540e0232 ("x86/kvmclock: Remove memblock dependency")
Cc: stable@vger.kernel.org
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
 arch/x86/kernel/kvmclock.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 1e67646..ae9188a 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -28,6 +28,7 @@
 #include <linux/sched/clock.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/set_memory.h>
 
 #include <asm/hypervisor.h>
 #include <asm/mem_encrypt.h>
@@ -61,8 +62,8 @@ early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
 	(PAGE_SIZE / sizeof(struct pvclock_vsyscall_time_info))
 
 static struct pvclock_vsyscall_time_info
-			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __aligned(PAGE_SIZE);
-static struct pvclock_wall_clock wall_clock;
+			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __decrypted __aligned(PAGE_SIZE);
+static struct pvclock_wall_clock wall_clock __decrypted;
 static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 
 static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
@@ -267,10 +268,25 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 		return 0;
 
 	/* Use the static page for the first CPUs, allocate otherwise */
-	if (cpu < HVC_BOOT_ARRAY_SIZE)
+	if (cpu < HVC_BOOT_ARRAY_SIZE) {
 		p = &hv_clock_boot[cpu];
-	else
-		p = kzalloc(sizeof(*p), GFP_KERNEL);
+	} else {
+		int rc;
+		unsigned int sz = sizeof(*p);
+
+		if (sev_active())
+			sz = PAGE_ALIGN(sz);
+
+		p = kzalloc(sz, GFP_KERNEL);
+
+		/* When SEV is active the hv_clock need to be mapped as decrypted. */
+		if (p && sev_active()) {
+			rc = set_memory_decrypted((unsigned long)p, sz >> PAGE_SHIFT);
+			if (rc)
+				return rc;
+			memset(p, 0, sz);
+		}
+	}
 
 	per_cpu(hv_clock_per_cpu, cpu) = p;
 	return p ? 0 : -ENOMEM;
-- 
2.7.4

