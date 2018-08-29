Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE26C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14539205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Rf5JC0Iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14539205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeH2WXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:23:35 -0400
Received: from mail-cys01nam02on0069.outbound.protection.outlook.com ([104.47.37.69]:40616
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727698AbeH2WXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHTnCaCyYQku3G9QtxRihRo0HvohR6vYT2FmWsYILWU=;
 b=Rf5JC0IqdUwIK8YitIHjVuqHtA1A27sqRh4r/DNCFzjz35ckUj/9h4wts0jZlCzUFCQaOCouajWcvC6WrDhRLp5U7SEP48MLAYzA/yDMsY0tQieC4uKSxlpX+yx31DF0lbMpoAl+iLi3OgwMZL4im+9JL3x1lQlHNgUilMqrCe4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BYAPR12MB2678.namprd12.prod.outlook.com (2603:10b6:a03:69::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Wed, 29 Aug 2018 18:24:16 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v3 3/4] x86/mm: add .data..decrypted section to hold shared variables
Date:   Wed, 29 Aug 2018 13:23:59 -0500
Message-Id: <1535567040-1370-4-git-send-email-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 379e1e9c-6281-4314-a0a4-08d60ddca1f9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2678;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;3:Or3zVSaa0JzY0wG3tX2fBHlgO6SgbYmdIHAMvkYCzd17eca4o/xuy+9y+dY+hbRF+PXHmcLBNqY5e9CupJOZmoJ0Qurk9uUQrsrwLxYaleQPDZsfgruM8KckxOYUcNKt6kf2eN+ke3ZwrYANDWM412dinV6ZyZyNiBNGQiNIXB2XA5dsWoqnofNH0kzlROm5Gprlqfx3l8ChgapkiCKd6Y5LTdpk9JAhYkZo8apkTjnmdjxnW7YETqYO+nGRZUrx;25:2vYISjCNvxMOUOFxfCPXwAXCdkqaGCV+GXx6PS6xmcXgryw2hgSSDfVyXOd8eM+RgqwYJbhJ010+hhHSclCipnKByM2IxMUKHJxlh4aMmPbLlG0HIzQgVby6OoFseLW1M/sm/LiJj0MNUJ53pYNa2FtsNzUMPFLBHeFMg+h5lvEYyLjam/QfhLDuIMCS5BbJJsgrpKPZF/E7eMiF36LdScpZQ693PtchnRYSY1geiuwZHM/CSVyyB/piYThBRKCYcm52nWcfoj/oGJinHbtc3o+E+FhH/0Kkt5UmpjecLBWKbltc+DXAoTTOpcC4IMhpxL4R9U0LcE0zFWnUN7mSTA==;31:uY5yO5jOMVE7VUbuZAK/YIMG9M2NY5eQvvwf9z1D4xq68hbYps9HiL68HHwqBiHJP2QKgXIGiHYDeAhqMN31np/XrwVS/AAneDHC1G18YWi50C3VrmQBXahgZFKxh523NJIsWHhdA2a46EPS6Vr8+ucQ+4C5SZEc/YI/B41TP+QlLXEf/ROVpFmEBmhKpB+iKwZooC75Vq2a9fR1RnLsQZThUBrYqzQjiYTwozHbcvQ=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2678:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;20:1f4BfvdXdN4GsLTVUpV7h/Jb+OjJ1hclbvCc4izP4sCqKg72FAoG+8lK2FX7RTdzYynqlcgcKAIiBRjQJ2hjSYKpwBIj90rxbZJKNv7z7oA2/IXsUC90CslNBTNJIqSot2aflFd3XVM+8CsR5NBrA/mVoyiXD5BpRT3AbihfWeMeuI7FDUtbnvtqcAvKZK6Pt/JtXhz0vCrVrJ+Fb2TPKdbfU/ihmVzdTKFA8EKrsrR2OcteeycHXLupUOLuK44GjIt/fCJeYhh6uNi7xq35E4DEcuWVgIR7wAczS0/Mm8XREKG8BNp8EBXnT+ZOciTb7+koMghjIwnjT7scYJiCCnhNgjmIbheBbQ1itFL0yTSr6XPXewidymuyZFY3LQO2y7SpJNLIWEC1QM0S4yULTp0dU4KaOFN4zAHxZ80eKPOcPN+m0/5Icfyd4PPgGkpSYTB1s4N1Z0IixeTYsb+mbvrSOUVY1kqFNEADm7D2uiNE9hDVe+oLFj1rYzfEWSNs;4:DPngW9Dt8xD5KNuz4HPeAhemQPdXdHSnWJZNjSFexws+Spf108L1isTxi0v0l0V8aHbd8CHTInMXNltYCrQDsEz+tMf+tUoVUGgmLFhvmljANXZa8BWlm6KFBcY+c5kPW5lhtK/JJUa+BUn2FtZW+BHPhE8Lg66wpJ9bH0L/CFRanbfzTZIQusWht6AgOCvsZtNCuChQS72Pv01NZRu/hEhxFRn9ppPsxqTCOOwB1d8OHRglQYYZRgwXRKbk2NRqqbakmti2tLFkDhcZxOaQD1zp3/JAmpGQI+nNlQgNIciWfonpuBwCvtBpnple5nXOcYRX2fDkuhiDarynQIOMPse7y31TmqBkTpD+5YkkjS6ygMJx3/exHtLXsViLkLG9rttVh8rm4WcMj96yPatcjA==
X-Microsoft-Antispam-PRVS: <BYAPR12MB2678BA6453C3E540219A638EE5090@BYAPR12MB2678.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(163750095850)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR12MB2678;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2678;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(478600001)(386003)(6486002)(53936002)(5660300001)(54906003)(4326008)(6666003)(97736004)(25786009)(23676004)(7736002)(52116002)(7696005)(305945005)(76176011)(50466002)(50226002)(53416004)(36756003)(81156014)(81166006)(8936002)(106356001)(2616005)(956004)(476003)(3846002)(6116002)(575784001)(86362001)(2870700001)(2906002)(47776003)(446003)(68736007)(186003)(16526019)(486006)(66066001)(316002)(105586002)(26005)(8676002)(11346002)(44832011)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2678;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjc4OzIzOkRFTjNXVGRNbXEycHFRVENjSzVBd2ViYmtD?=
 =?utf-8?B?aW5vU29yeGZhTW1uSVZabkl0ek1LRmZDcGR1RzJJTmZwZ2d3d29WeHNhMFR3?=
 =?utf-8?B?NlE5a1J5RTFNSlEzTWp4MG9VK0hxTkl4b2EzWFoxV1d3NEhFNjAwekUxUVc5?=
 =?utf-8?B?R2hjV3J3Zkl0TDNwblNLbGs5UzdRekhxSTAxTSsvWHpmc3F1RitKd2YxSDF4?=
 =?utf-8?B?djVTZnQyaHo4bEpqU3J0R3N0QWMwUlIzeE0zditneFJ5MzBUakVoNUxhTDRD?=
 =?utf-8?B?QUJCaVMrM1pnbnVpcUwxUXFCV28wRGVFeEdJZS9kZjJLeHZQekFCZkNBN2lT?=
 =?utf-8?B?bldzbWNlNTM4WlJWZ05Mejh6RkY1WG1XNVZmdUkreHd1eVZwNWFLOE4zTXE2?=
 =?utf-8?B?T1NRcmxwYkU3QU5kejgrY1c2a0xDNTZublZLQ2NzTGtrYVpkMDdYamgrVHRp?=
 =?utf-8?B?bWFTU0M1WU9Va2hNYUFWSm1KTUJuRndsY0N2VzQwWmxFclg0NHVsNUpZVXJF?=
 =?utf-8?B?WEM0ZklXL0t3TDhmVzR6R1lSRHFGb2ZzR2ZyVittdkVPUFowam12WDZyMFRj?=
 =?utf-8?B?YmxSUER4S01sb3h2Y2ljbFBqa1IrSG5mNUpIM3BpWUNwZndFUXQ2eTAyZ3Zl?=
 =?utf-8?B?eFI0NmpuOXEra1B5NC83Z1djZnUyYlRZUzBzQ2FLTVRhbkFOTWlPMXhacTcv?=
 =?utf-8?B?ZUFMMWZhelQvMVkvUUhyVjZQZWU4cStoK0tzMmZiL1hxeTJhZFlVdjY0YXFW?=
 =?utf-8?B?SE1HZFloWEsxekhpTkZoNm1vMU5ZYmpBYzBsU0JIcksvbk5iVDhXYmd1dFJu?=
 =?utf-8?B?UGY5N2JZdEFRUER4WlpSZlhCS1NPVWM1TnJtOHB3QWJvZEpuWHJoK1B2ZkxH?=
 =?utf-8?B?QkxPWTJlQ1EyNEFTQW9iUEpkVDFEM1FaZGxIdlYwOHhKM00xMW1TWk92YW1t?=
 =?utf-8?B?dHd1MHdxYnJDa1B1Mk05dnc2em4wT09aN2hVZ2pHU3BqNEZqT0NrY2NDUTVP?=
 =?utf-8?B?ekl5aUtHSXJtNDVSTzRDRmozanQxdGtsVmpHTzNVWlFJemtVcG1mTlNnUFdl?=
 =?utf-8?B?ZU5uT2JsWnJhY3RTcmo4YVUyYUVrMHViaXVEZkllOVFqbUUvUE9SeTN5TkhH?=
 =?utf-8?B?d2RKNVpxam9jU3VnS2hVTmdCMWxyNkdENlBqS1QvYUlrTVNqU0QwOFJtcGdx?=
 =?utf-8?B?cytIclNNRUExNWF2WEx4VHVoLzBtMFYyOVJ0K2dxUC9TQzdOT1NCNEJ3OWVE?=
 =?utf-8?B?ZkVnUzQ4WVdjZzBPSWNGUEZYTkEwS3BuUEEvSXVFODkzWUFZQWt1MXVaY2gx?=
 =?utf-8?B?NmJtcE16UGlzVFpIckZONjNSR0d2TFB4K1lONkJob3dGbEFzdkpGdzFpZG1i?=
 =?utf-8?B?Mm8wbFloV1hvSUdjS2Q3NXUwYVQ1VXFGVlpxV3NZQXJyM2VnenBCR0dTSW9T?=
 =?utf-8?B?cWozY0xpLzZHQjVJZTlYcGw2L1lTbVRsbUJockdYY1FiYVl0L21LWTZOZWRP?=
 =?utf-8?B?TjV2MWdyTFM1S0dyYWxuN25wbmVWQ0U1enNDRWtVSzRnejkveVZnWnJMaDJr?=
 =?utf-8?B?ZkwzNXF0RlorNnBFbWpkb25YY080d3ZRY25VakNFUTdVTUdXZGU4VnB5TUlp?=
 =?utf-8?B?Ump1OHNnZ050Ujh3NnFva0FNSW9NdDdvdUJ3cHhPR3NVMHI0ajRhT1U5R2pv?=
 =?utf-8?Q?gjeo1wNLwMT2K/GJvw=3D?=
X-Microsoft-Antispam-Message-Info: H6oQsnNBp0R9wU1rwzi0FXNb2T5dTH1yL0xtLwNyg5Wna3YqXhkIHrpiyWToW0MO1wBcgCT1366reQZyiKWEo9fV60sP02Z4PJp09wTJdZOt2806ljjJnHcQvf0m1KfLdIFOmJKqWt83cXbwyok0jT33lCG+amRG3twnS0WIWTtO01mMtKCGAs0+ruoawZ4qllAQCx70vFbSLEEFOYZL+bVckCMiXae+l8T1uqnqcblMk+cVV0SJif7ttQxK6Ui2qObYqSXfptmtraGboqo5rzp3zDkbeX0WBEDB9an88ufvL81eB0b/iCTrAVI6cjx7QYFJLxBGeRb8Jaa5mCfiw339tyKN2oI1pupcGzLHa8g=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;6:2QC3+kE718Dtw1bZFsdatH8d+M7h82mKPNzuZdT27rSDlofRsmk4U6ygjezGJ7lW+iChFUFnqnn+QFeev4D/cTOj0cvZki6LNst9MZjDD2zlPD6tt5EjzE/et0OQCHVHHffeRY1cI2KqSXesGwA+PUmPEe2E2xhhG0GQyv43KJOft1NJKNTQxwdFknG3XeWgSM9jzREBpKyx3U5YwZYX6oVWR8bmkMUhUtSeGixuytJw82xA6BzQ8PaQT7axP71vs/wN6Rd6m1+B0kWPhMAkveKYo9ekzeDZKVRRDT0rgWNruy597ZtBOGNxeSfPF1DRA/kO6MHMJSQ7FRjxEQ535TrZUGW63lLCQqT+JU9n4eqSKoUOEQxiMAGd/O9h66SZwiY2A3iemudIVNFPX9RvUUVpcGI2oEi+ziirzkNifZ5G08nSalcO1VsWtDjbqNHiCwby65rV3DzRvy4zKF7a+w==;5:Qb9LjST0wioK7JamMLNMpXLhX/8rhRJS3DTvZSyoWFedE6klV5Uyadply4jM7YnLbuEnNtFwaGRnWi7exQYs0V4Wnmh7VNE+k0Q2gl0SnCoN0FUo/0nm0LefAIO720v2b/Wo1lMNwWAE1uIg7AhpM6k+R67oTdaY84mB0hMiVq0=;7:K+JviqxSG/PdDqk0lw9rJFGVi2MqfpvJ471zH5HXRS876TAWfTVcv11KxALwxKvwf2BQI4F/6eCtU0ob5tPXU7EwQlybblCIQ+p54aqV00m0PWm04KMH8yQ5hXEFdZtpg8RAJ9oQJqWctZiEkC0qUUhEJS/o7ORSc/i/9eHvVt/bnCb2u7T9Zar6RhmjadF7BCmI9koCTh0pUBSYlc0adF3wta70SvnOBvMi719IP7GtKV6Uy9LolgXXhMjspgtB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;20:co5kvKe5/SJTCyMRlsxMCsYfjYUAkI9edyoKWjRMRi/htquIZO+hbuIB1gtuXZd//TZ2Bfb0WaT6NGTJYvmX+YcN9iOyu4XyC++Uo4hMqfneDbc/r/jAY5YMvhy3137i5SO2Na1dfTfTzZrDPOfaO+Tini/m5J3VjWmDBr4cnvXEVQ83HewTWxvjunGidBEWx2JihOetkUE8g1d4fgB/Aa8XC8DbRtKqVMwX2RL9RQNOfGj1KRy/92H1LPPbMteR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 18:24:16.8617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 379e1e9c-6281-4314-a0a4-08d60ddca1f9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvmclock defines few static variables which are shared with the
hypervisor during the kvmclock initialization.

When SEV is active, memory is encrypted with a guest-specific key, and
if guest OS wants to share the memory region with hypervisor then it must
clear the C-bit before sharing it. Currently, we use
kernel_physical_mapping_init() to split large pages before clearing the
C-bit on shared pages. But it fails when called from the kvmclock
initialization (mainly because memblock allocator is not ready that early
during boot).

Add a __decrypted section attribute which can be used when defining
such shared variable. The so-defined variables will be placed in the
.data..decrypted section. This section is mapped with C=0 early
during boot, we also ensure that the initialized values are updated
to match with C=0 (i.e perform an in-place decryption). The
.data..decrypted section is PMD-aligned and sized so that we avoid
the need to split the large pages when mapping the section.

The sme_encrypt_kernel() was used to perform the in-place encryption
of the Linux kernel and initrd when SME is active. The routine has been
enhanced to decrypt the .data..decrypted section for both SME and SEV
cases.

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
 arch/x86/include/asm/mem_encrypt.h |  6 +++
 arch/x86/kernel/head64.c           | 11 +++++
 arch/x86/kernel/vmlinux.lds.S      | 17 +++++++
 arch/x86/mm/mem_encrypt_identity.c | 94 ++++++++++++++++++++++++++++++++------
 4 files changed, 113 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index c064383..802b2eb 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -52,6 +52,8 @@ void __init mem_encrypt_init(void);
 bool sme_active(void);
 bool sev_active(void);
 
+#define __decrypted __attribute__((__section__(".data..decrypted")))
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define sme_me_mask	0ULL
@@ -77,6 +79,8 @@ early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0;
 static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
+#define __decrypted
+
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
 /*
@@ -88,6 +92,8 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 #define __sme_pa(x)		(__pa(x) | sme_me_mask)
 #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
 
+extern char __start_data_decrypted[], __end_data_decrypted[];
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8047379..af39d68 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -112,6 +112,7 @@ static bool __head check_la57_support(unsigned long physaddr)
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
+	unsigned long vaddr, vaddr_end;
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
@@ -234,6 +235,16 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	/* Encrypt the kernel and related (if SME is active) */
 	sme_encrypt_kernel(bp);
 
+	/* Clear the memory encryption mask from the .data..decrypted section. */
+	if (mem_encrypt_active()) {
+		vaddr = (unsigned long)__start_data_decrypted;
+		vaddr_end = (unsigned long)__end_data_decrypted;
+		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			i = pmd_index(vaddr);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
 	/*
 	 * Return the SME encryption mask (if SME is active) to be used as a
 	 * modifier for the initial pgdir entry programmed into CR3.
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 8bde0a4..78d3169 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -89,6 +89,21 @@ PHDRS {
 	note PT_NOTE FLAGS(0);          /* ___ */
 }
 
+/*
+ * This section contains data which will be mapped as decrypted. Memory
+ * encryption operates on a page basis. Make this section PMD-aligned
+ * to avoid spliting the pages while mapping the section early.
+ *
+ * Note: We use a separate section so that only this section gets
+ * decrypted to avoid exposing more than we wish.
+ */
+#define DATA_DECRYPTED						\
+	. = ALIGN(PMD_SIZE);					\
+	__start_data_decrypted = .;				\
+	*(.data..decrypted);					\
+	. = ALIGN(PMD_SIZE);					\
+	__end_data_decrypted = .;				\
+
 SECTIONS
 {
 #ifdef CONFIG_X86_32
@@ -171,6 +186,8 @@ SECTIONS
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
 
+		DATA_DECRYPTED
+
 		/* End of data section */
 		_edata = .;
 	} :data
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7659e65..08e70ba 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -51,6 +51,8 @@
 				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PMD_FLAGS_ENC		(PMD_FLAGS_LARGE | _PAGE_ENC)
+#define PMD_FLAGS_ENC_WP	((PMD_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
+				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PTE_FLAGS		(__PAGE_KERNEL_EXEC & ~_PAGE_GLOBAL)
 
@@ -59,6 +61,8 @@
 				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PTE_FLAGS_ENC		(PTE_FLAGS | _PAGE_ENC)
+#define PTE_FLAGS_ENC_WP	((PTE_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
+				 (_PAGE_PAT | _PAGE_PWT))
 
 struct sme_populate_pgd_data {
 	void    *pgtable_area;
@@ -231,6 +235,11 @@ static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
 	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
 }
 
+static void __init sme_map_range_encrypted_wp(struct sme_populate_pgd_data *ppd)
+{
+	__sme_map_range(ppd, PMD_FLAGS_ENC_WP, PTE_FLAGS_ENC_WP);
+}
+
 static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
@@ -378,7 +387,10 @@ static void __init build_workarea_map(struct boot_params *bp,
 	ppd->paddr = workarea_start;
 	ppd->vaddr = workarea_start;
 	ppd->vaddr_end = workarea_end;
-	sme_map_range_decrypted(ppd);
+	if (sev_active())
+		sme_map_range_encrypted(ppd);
+	else
+		sme_map_range_decrypted(ppd);
 
 	/* Flush the TLB - no globals so cr3 is enough */
 	native_write_cr3(__native_read_cr3());
@@ -435,16 +447,27 @@ static void __init build_workarea_map(struct boot_params *bp,
 		sme_map_range_decrypted_wp(ppd);
 	}
 
-	/* Add decrypted workarea mappings to both kernel mappings */
+	/*
+	 * When SEV is active, kernel is already encrypted hence mapping
+	 * the initial workarea_start as encrypted. When SME is active,
+	 * the kernel is not encrypted hence add decrypted workarea
+	 * mappings to both kernel mappings.
+	 */
 	ppd->paddr = workarea_start;
 	ppd->vaddr = workarea_start;
 	ppd->vaddr_end = workarea_end;
-	sme_map_range_decrypted(ppd);
+	if (sev_active())
+		sme_map_range_encrypted(ppd);
+	else
+		sme_map_range_decrypted(ppd);
 
 	ppd->paddr = workarea_start;
 	ppd->vaddr = workarea_start + decrypted_base;
 	ppd->vaddr_end = workarea_end + decrypted_base;
-	sme_map_range_decrypted(ppd);
+	if (sev_active())
+		sme_map_range_encrypted(ppd);
+	else
+		sme_map_range_decrypted(ppd);
 
 	wa->kernel_start = kernel_start;
 	wa->kernel_end = kernel_end;
@@ -487,28 +510,69 @@ static void __init teardown_workarea_map(struct sme_workarea_data *wa,
 	native_write_cr3(__native_read_cr3());
 }
 
+static void __init decrypt_shared_data(struct sme_workarea_data *wa,
+				       struct sme_populate_pgd_data *ppd)
+{
+	unsigned long decrypted_start, decrypted_end, decrypted_len;
+
+	/* Physical addresses of decrypted data section */
+	decrypted_start = __pa_symbol(__start_data_decrypted);
+	decrypted_end = ALIGN(__pa_symbol(__end_data_decrypted), PMD_PAGE_SIZE);
+	decrypted_len = decrypted_end - decrypted_start;
+
+	if (!decrypted_len)
+		return;
+
+	/* Add decrypted mapping for the section (identity) */
+	ppd->paddr = decrypted_start;
+	ppd->vaddr = decrypted_start;
+	ppd->vaddr_end = decrypted_end;
+	sme_map_range_decrypted(ppd);
+
+	/* Add encrypted-wp mapping for the section (non-identity) */
+	ppd->paddr = decrypted_start;
+	ppd->vaddr = decrypted_start + wa->decrypted_base;
+	ppd->vaddr_end = decrypted_end + wa->decrypted_base;
+	sme_map_range_encrypted_wp(ppd);
+
+	/* Perform in-place decryption */
+	sme_encrypt_execute(decrypted_start,
+			    decrypted_start + wa->decrypted_base,
+			    decrypted_len, wa->workarea_start,
+			    (unsigned long)ppd->pgd);
+
+	ppd->vaddr = decrypted_start + wa->decrypted_base;
+	ppd->vaddr_end = decrypted_end + wa->decrypted_base;
+	sme_clear_pgd(ppd);
+}
+
 void __init sme_encrypt_kernel(struct boot_params *bp)
 {
 	struct sme_populate_pgd_data ppd;
 	struct sme_workarea_data wa;
 
-	if (!sme_active())
+	if (!mem_encrypt_active())
 		return;
 
 	build_workarea_map(bp, &wa, &ppd);
 
-	/* When SEV is active, encrypt kernel and initrd */
-	sme_encrypt_execute(wa.kernel_start,
-			    wa.kernel_start + wa.decrypted_base,
-			    wa.kernel_len, wa.workarea_start,
-			    (unsigned long)ppd.pgd);
-
-	if (wa.initrd_len)
-		sme_encrypt_execute(wa.initrd_start,
-				    wa.initrd_start + wa.decrypted_base,
-				    wa.initrd_len, wa.workarea_start,
+	/* When SME is active, encrypt kernel and initrd */
+	if (sme_active()) {
+		sme_encrypt_execute(wa.kernel_start,
+				    wa.kernel_start + wa.decrypted_base,
+				    wa.kernel_len, wa.workarea_start,
 				    (unsigned long)ppd.pgd);
 
+		if (wa.initrd_len)
+			sme_encrypt_execute(wa.initrd_start,
+					    wa.initrd_start + wa.decrypted_base,
+					    wa.initrd_len, wa.workarea_start,
+					    (unsigned long)ppd.pgd);
+	}
+
+	/* Decrypt the contents of .data..decrypted section */
+	decrypt_shared_data(&wa, &ppd);
+
 	teardown_workarea_map(&wa, &ppd);
 }
 
-- 
2.7.4

