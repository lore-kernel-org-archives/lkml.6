Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB92C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9744020865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Nwlyqlo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9744020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeIKCsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:48:50 -0400
Received: from mail-sn1nam01on0063.outbound.protection.outlook.com ([104.47.32.63]:25492
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbeIKCst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF5hpALd+4lw9cJPYuzM2DzA8EeYfMNYNZwx8a05Pno=;
 b=Nwlyqlo/qeD35mCpmO/7vcyIm3lRIA15+f+oClTOzGRaDkzksZ5lN2V4VtOdJPAlDiJyEccQrnqFRBriNWTMAwTQjKD1A5GFXKVrCmIBJcJOXvdoPz8MADsH6yhBnY2PcRoVOv7+JY3wfqvtA+Y6OT8QaxuNee3KAw9pOzJngLw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:69::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Mon, 10 Sep 2018 21:49:31 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v7 4/5] x86/kvm: use __decrypted attribute in shared variables
Date:   Mon, 10 Sep 2018 16:49:10 -0500
Message-Id: <1536616151-16738-5-git-send-email-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9c238b46-cc54-4ea0-fa0b-08d617674b2b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2680;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;3:29rFl7bO8TZQOg9MHuSzm/jGMOSsnIHJ52uErHuJZsVqXyA0iauGGVrmTdWWa0GIYUS59af3zYBcvWkFEYN4KekT4qzR35DsOadrGtQownrzafNUiroDqL5yjAFXkRZEefDggI2je/J6CvHqH7K/Y3uaLYmDs7XfDgIGL1xPHdG5I7+9cp5JfXVg1KHTB76jKzg9wwc7GyRnbNUh+xIzcFXM0fvcCvGuPipZSg+AxyTARYiGS7pdR3JRFcrP9iIU;25:x8d1SXN04TONjoe/CcRz15rvV+6XRKvR1UDfE5FA2dYATFi88DLw/v9lPAM9Km+B1bEYlewCv0t88XQ8QVHn4kQDdHzgfxLZ+FtmFXN+RCKsbVG1kSslsi5WeyDIGc9svk3vDVwNr3wh6N2jFAfWhpqBX3lIGQrsHVA4Xyp9vdkefvPMYhLUQDJYs+RQ8xyituZkCTdUZDgmHZF1N+2BSVBbR5+i3JPtBCFJxBqmuo8aZLWtx6Dta7Tkex6PIMf1BqZaCQXiPw2T8IIP/+g/iEg+VD+q9EjJAdkcWuadubDz1b9DbnAwEMpPikds2XHktCGDUKBQ+PPE6wL5lpA5Mw==;31:s7G/2dPyusJteqo2ya3qP+xgDvyEcoePI+0vXKWSHv4RpJUo1pODiUABqtuJPl97OP/UStTPVUsrJD7XhWO9YY4g2Ek8dd7p6OCwT8gkoFNH5IvRjB0Pe0QOTXh2c0iEdwYxNEjAaTmOeTo1As2//97S2kLrKN7aMDvk4ztZsILz2bPMP0Th/Mq5DrEDF+yffgnuW/kfEu1ZuwXkbtrlIGpnCSmaWvsZ9V83OoSXPfw=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:QFzeBk+tU+2wDzl7Vg1WZBa8gBUFl/EH/tZKWa4nNc471wKNVhXG0plAksm7rdFa1LSqEiMMOXyOlWMTA0hdkJutyQh87U2zeZS34o0BPcza9m5eGvstIhLwkbXLGw1eFuLZgg2vH2aqvJ9ZCcmzgNxpt5yfpgOyY8rpqb2Kr8CYvanM5Le3VfjldcAl+rLNjrs2yyoZwBNqiyODk5oVZ2zHq6yKkgNOzvpeWT6fIynqfy8bKoVNLVSjXrtqt1dilgypZd4PsSjHntjXBgcqmZKXxkkgSAqeuiPKs04ew4tVZCwML/bIv0uj7UQvNUPwMDkL3tzjtc5MzkmcGLFPL1OaehlGTaefl/9fSSDFnq82v81PtVLYHANMs2WQEZJ1DVcKvINNuWcoQ8PwkXhiEAh+jqwMTqAu7OVOAI+ZlxmrunUdr+OUKqE5w3G9q6Fx+lqextxtquvmBBnI8tvn1Ldv2abYRhTR8ru2sZVLLEEANxqpyUJ9OTo9LwGn93Mf;4:XdBKY0yRFV9+EByhava84bRGVRwxreY4gjxMWf5ukTnNDPAqR3I74Mps9shlShqrP2Cdi8qV/mcTPGhPv6vGyyWusHRAKH21HL+rCCDZbCkvxENkH+cDxIyfzVoD1+t5TfOwZywNv6odxgsBXAbf5nSwxMgFHfm8CFu2ueOw1fCrkbJ2F0lJexDjDTuct7iWqW/2g9WGK86jomNFE0iUdK+b2PlcsmdOuR+sQyxNnmXobzvluooN5uJ3wkIOSK89MwfHhBHhDojR2fgYDWG4qiaT1YrVh4w1EWnHnRlktprIIibs4hbfLCLSWLGCT6oZ8Ce9kTZnRLnw5LC8r+oqIIVAyNZzNpj7tdn7X3n8Py/S6pJg/mL2y0p9Qk0Aq8Yi
X-Microsoft-Antispam-PRVS: <BYAPR12MB2680CBC030A37A65B6F9656CE5050@BYAPR12MB2680.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:BYAPR12MB2680;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2680;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(366004)(376002)(199004)(189003)(6666003)(386003)(8936002)(53416004)(7696005)(52116002)(25786009)(23676004)(76176011)(105586002)(8676002)(106356001)(50466002)(50226002)(26005)(186003)(66066001)(16526019)(6116002)(54906003)(3846002)(47776003)(2906002)(97736004)(2870700001)(4326008)(316002)(81166006)(36756003)(446003)(81156014)(476003)(2616005)(11346002)(305945005)(7736002)(5660300001)(956004)(86362001)(44832011)(6486002)(68736007)(53936002)(486006)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2680;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjgwOzIzOnJmbHFYZ2JxVStwT0dsZG11RjlreTdGQStB?=
 =?utf-8?B?Ui9uek5FL3FTaVJaQXZNZUhJYmxxaGJoc1k3TXRrL0lLRG9mMTc3UjVYOHhy?=
 =?utf-8?B?MFY1Q0I5RjVnWWYyMW5KME5XVFdMZkdwZ3UreHg2SUxWdkVzTzByUkNVcFVm?=
 =?utf-8?B?dk9KYzNPZ3RzM3BZUVowOU5XUVF5MzB4bERCQzByWlVtRXA0YnF2aUVwRmw0?=
 =?utf-8?B?bGJ1V0dxMmMrREllYkpUcEdzalgyK05GTy9WaThOK0JNZXdTYndsaU1qOFpr?=
 =?utf-8?B?WEE5QlBRQXV2OXI1bU95UGJwSEx3TGNSU0xySllXS2R4UHVMK0dWbVVtTEdF?=
 =?utf-8?B?bzFvNUMzNjN2ZkxYYk4zNitveDZPSXpPYkxxa3RoUk9ZdVpiOHp4RC9WQXpr?=
 =?utf-8?B?Rm9KTXRhNUNlZ09Za243S3BUeUt4THFJZGFzZnhIcnkxK0ZRQWQyTHkxcjV4?=
 =?utf-8?B?bnk4ajRJbG1FbzNDdmlKalVHWmFFek9ncWJ6a2FyVzd1MnJtem1YT3ZUZkc5?=
 =?utf-8?B?Y2Qrc0NpTDlkWk1YOGFhUDFlcHI4dEs5SnBHTm9Ha3htVFlmVTZlNVIxUHNL?=
 =?utf-8?B?dHdZd0ZLTUZuY3VRaXBkbWhTbk1nTEdybHRwd1pubGJFRTZDSjBOTkJKMTk5?=
 =?utf-8?B?SmlYMnl1cFZ0RUw5TVdtVkt5aWMybFgra0F0TDlUWnEvVEJrNkM5V0ZWd1Bp?=
 =?utf-8?B?cWdmSWtuczlMcnVoYVRscW1VdlhuYzBHYjJTMksrTlJibEpzSm93VkZJbDZa?=
 =?utf-8?B?Z1lxbkFSVUhpSmVYWlVQQjlQWjRkVmZpQ3JLQ00vbDBjYmlXZzEvRUo1ZC9q?=
 =?utf-8?B?UTh1N3g1amkxcjlmZTBTYUZXanhVYnBHc0RaNUM5bmdFcldzQ3N2YXVUaHVm?=
 =?utf-8?B?SVZmd0p4eGFaZVVBYzFlalVqbENwTEwyZDBRT3Z1S0VsZkxadEl5aXprRHN6?=
 =?utf-8?B?UDJLdjdmdjVocXQ4d1hMWE96MkZCMWQrdEZSRlNBSVB6TlpDbEtBK0lWWWxr?=
 =?utf-8?B?YlpIOGRUSmlvNW1ldndKVlN6NkFub2FiWUJubW1QTVh5S2taSWVIUmdvdHpI?=
 =?utf-8?B?TmViMjZZeG8xVlE3OCs0aTYwdC9BemlZamZXV1NzLzV2RHQ4eW9yVjBFVWVL?=
 =?utf-8?B?ck81Vk84KzVRSWlMNjVLRlp0Qnd0azBBLzhJMkJLQzRVenpPUWlMZExlQm14?=
 =?utf-8?B?Z0t1V3pLNUtpZE9YUFpnNE5taEJkL1dzRWdwaWphc2NXS1c4WU1mbEs2Rlg4?=
 =?utf-8?B?ZzhjTkJXbG1PYjJVSUZPZ29sNmZlR1ZSa1J3bHpMVnlzVmxZc0Ivdk1oMis3?=
 =?utf-8?B?VUY2WFVJR2ZRZTJWTE1yS0FqZHhidVV4eVFtczI4WGlaVjMzaTZsK1p5cmZy?=
 =?utf-8?B?dWVFUlB5WDlhelE2VVo3eW9hR3BLeDNDWU9LKzRQUUJ3ck0yTms5UmlkUi9n?=
 =?utf-8?B?dWE4U0dKS1hTbVpHRE1QTnpxTDFMVWVXMC9qUjE5djNDWG5ndzZET2pZUlN4?=
 =?utf-8?B?UWFnMkx2ZGJXNjFWY21NakFkN0VmeVNHSnNQTmJPc2JxTm5HU2p1Y20vK3VS?=
 =?utf-8?Q?b00+1zvBf4lKNk/VatsZmfYVIdEfvafL/9M2EXsshGl8=3D?=
X-Microsoft-Antispam-Message-Info: sZhiqu3enM/J0GbQcry+sjq8UZ9EMHQiMSK+fEZfFUSyv0MVWZY/N1OBbKpiu0Rj+IbGxnG6xIi85KqzBSGIZHWrWJJVb4Rwk/8PKXjkCd0fgM3eAnxNA/gtWmfZocwYzdEIy04W+3LpoPggvyAgxFcHR6iVkuZCS4VKUMDMDSpJFEw6KVd7ktYblqUuW6rrU94rZqbiltLf+xpNoIhC7aHRgXiailesGSo8gsXk7BK22HmXaCVqaxuH16H0vdvKK0NFa0ce2/WydG/hQDhOFKFzOQeZhYsJKSQs2kP89hgiSzhOnXUqDeQaa/y+Pw29CfQ1Fgus7sxWonQl32XKsqjtwFPcaIZ63BMyNSsr9iU=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;6:t9JfOKf2uBN4wDQS0pEf0yXtpdBjqOW9cA9D0wF09wDGsLH5tdxM+C3ozSEF05C8FvJIGNU8yQVjshsfJzXFK5Y13grAbEf2Jt7WpSGT/j+YSKeIys5mvFXBp49QCQ5/lMXE4nnTGcbHZQHFWY6GuIS7+dqidiNdTl8CtvMfGZSsG4puzF53k7aQvO/D1TqB57tdnAuetMRXWbX3XzhqsYt9inuiT8MWBEYc17HwSi5TnKlhqqB2/D+m7WbC//W5N/BYMzuMLe048DqF8aKQQScXyywjJxSG3CStQ/uCmYquBntapy5zHBztjFE0JEl/BOUl4vn1hUODww0XvgJ1uXhDwwuZ2Z4SWtn9/ZmueNcMIhYs6zGArhPwBmy6oZidTwcNfgmR1dwCqc3rTPqDMM3eJUNGvOpndH1iw9OJIgd04hGVEAv9r2KOWKOSPkusAxdgBFEgNY7+OoRh7So6KA==;5:PcppY8RFSmjsnyNO7+GJonaOOBmQzwwAoaHQSNE7B/Izmxm4pMrWA3PK5oTZZFxPsnFZkluC2PSQuzxUvEvZjR/Zo1rN2aKISLuQykRAVI9CtnC1xkql0SUWfITJGuyHgbjfnDZceNuIyT4jvSdWMUWQ34PPihng3pWti2LNW4w=;7:BkbxOnVlSqvFE90wWX5eSiTvntDXlvdVVnxRsUIMjYlyoaY9Bc/VgHcr/nUjyJS1NlQEMpwkw68xPGmubR3tI1CtgOx92tyHpnei4EQGkixlp2xY9ECACwEFXYFQEk9jfwHtWNSTfPUB3fEWRVCaVLJbF5U+EnpSuhgSm4KxwLFje6mC39X67WbtSjnchX8sjxe2ksJGVdP9G2baVmbmjBWnpITZwj56TTHXlotIeq4HpQ4zTHZObVhSV6CE2JgV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:7ii8exZZW5nb/zknT6Dmq/FdtdnQdv0DoMdztNzUdv3slo9wj48RUmc+TrLOd+kSuu3zfvlZB3iljmiWFJdoDR0Zg+LEEzynlXsBZqtNLh/GkhE0+L/j6AxbMR/N8kWk69B6fZ8kdWIBfX/+SUjAytI9ZLH4KAtCCNEtm2QaJ96WXuAB/99JXOefDT3wT+9pBrgcIQxNb1gMCj/Q8iC04FVdp81zEHaA9JYAEr/MAnNvtyRufoM9gbItV8BcQKvI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 21:49:31.6878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c238b46-cc54-4ea0-fa0b-08d617674b2b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent removal of the memblock dependency from kvmclock caused a SEV
guest regression because the wall_clock and hv_clock_boot variables are
no longer mapped decrypted when SEV is active.

Use the __decrypted attribute to put the wall_clock and hv_clock_boot in
the .data..decrypted section so that they are mapped decrypted during boot.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Fixes: 368a540e0232 ("x86/kvmclock: Remove memblock dependency")
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
 arch/x86/kernel/kvmclock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index a36b93a..0b3110b 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -61,8 +61,8 @@ early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
 	(PAGE_SIZE / sizeof(struct pvclock_vsyscall_time_info))
 
 static struct pvclock_vsyscall_time_info
-			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __aligned(PAGE_SIZE);
-static struct pvclock_wall_clock wall_clock;
+			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __decrypted __aligned(PAGE_SIZE);
+static struct pvclock_wall_clock wall_clock __decrypted;
 static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 
 static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
-- 
2.7.4

