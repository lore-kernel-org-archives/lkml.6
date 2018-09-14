Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FAFECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CA82083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HHAwrGJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CA82083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeINTBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:01:15 -0400
Received: from mail-eopbgr720041.outbound.protection.outlook.com ([40.107.72.41]:36592
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727640AbeINTBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mmagr4YWhACZSvbAbRnCh8iYcEVsXE+e7zOss2fX+9k=;
 b=HHAwrGJkfCG063T/QfV8TAhFPGF+Av18YQW6phhIZgSAuufyHo1sL3g86Ng3RwGLEWO4dvpwbhQMaGROVqfuehS9Soka37SgbWK7hnVyEs3LwdVr4P+sSj1fiPKFXxD2/lkpA+C6qMDL3di9oPoqtgFd9vNJDKj/sTRiX4XBEiI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BYAPR12MB2679.namprd12.prod.outlook.com (2603:10b6:a03:69::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 14 Sep 2018 13:46:16 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v9 1/2] x86/mm: add .bss..decrypted section to hold shared variables
Date:   Fri, 14 Sep 2018 08:45:58 -0500
Message-Id: <1536932759-12905-2-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536932759-12905-1-git-send-email-brijesh.singh@amd.com>
References: <1536932759-12905-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:404:8e::23) To BYAPR12MB2679.namprd12.prod.outlook.com
 (2603:10b6:a03:69::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c1b24fd-9df9-4815-c009-08d61a487260
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2679;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;3:IiVC/YXfGOxT0oYKhii6LFVDf93hKq0RKTr5XjqoAqcUkqnkFVVA7pBbo2T5cAMOgoF2fU27+6zPSvwwZneWvK1+iWaEsCuhqIH7hP0T+/fi3lm1va5I+MTqPpIfASvksI2MAjYMB1x1MC4/Zgpv3yMPs7bZRVKLyMOBZ73B28Z0U0lf4mxsZUWLv9BvNTi0Im36Wgd1BJJeIxKHPmSiMIRfqAkGkts91ersQXhafCYqbbuo3HYBhUN4Ww9hUQZe;25:lqmvuRbj2e6lGdIxmZH5aIKKhIG+MWZ/1dfZuljQ+Ex0OLXPKuOUDc0ptQN6iDt1XZ5A+R9YQxtVYIag26PckO2PF+MNWjHQgksJARuf0zrpuzJWMp8HABCWD0lLYDbSqy7Rngv3xmRb8OT/yvZ1hbutq+kVpzijK7qENk5oQjeWXHeMy91xQc+5Nv32PkesHkHWwWvVGLM5V6GwpSasYRToNkf2sOb8iXk12vTjdpoXswKxkuaj+CMGnPPwqiponsnhW6mGKP2+59itnnCZWYyLHrY5H68M3ebqbe/Ck78OOf9+YEUEk9WbH+iSM2Cuj/68ghpmczhWJCTM7s6z1w==;31:FaA7jUjwlbu7xdNaXb5zcV4CjtE/4TPZ2Rv/KpQPq611/rOBT2ZCJ5+0ZQL24f8r6gz97nL0b3nyBQH0+KOBMULPwarGtQ97xmPHqAE1XRVqcMGXlVmmNFIdvKSLlVz3hJpEKO5ZRqGi+ycUCV60VlH929oACiFtbke+s9RhgWB8foJM4PxnP+VgrKuPzQ4p/BqWj31qx4ekbhNpAn09zUgwwtbl0AaMWjWxTg68jwA=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2679:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;20:YaZndIvUOQ5lemsyAk9NgvpXtFROIy9ygO/PVtBlopdhOzsWI3Ja0YI4Qwz1MyLsHgImVAc6szt9LpZctdGmpwaLmnzkWHxyPVhbN5QUA/KTND9/0VdbGXNKtrpw2qcx4llGltyTWbHffZEGJ2fxP4iVB3UcpXalwqnOOiyjAT0jzVf1B0e+gDge4gaBuBui68RLPoXJRw9SSJU9mLvjyKatXjlAATXybWLxUykhr9LiFx31S/RSzQs2A6tmmq/n4frCs03KfmvRyfuELGdVxco1hMeUDDGYLc3CtGY1xBW8wI3SHojLwm3We/0v7oD5CcY5/zbhrTFOzLmAXq37cyxQ8NsxAowLFPWX8UU0Ui+ZsN7qf5bCxrM8xjbCG/R2ffRf6oXKb6CiCnSKNuHKjOcjlYQ9fIoJkrfRm71ynGqWA0RhjR8WDYQOfstSh4YBPhqMvmhGGDILNVGBzOTr8lorH1D1UYQxVsoPaQPYYqSKwPuMgXq1z0wVw2KmkTeI;4:4TNeAhd/LIEBwSqWTOz8+0bLMWD/tQJauSpGia+i5xOxUhDZMDMi6+EMYhsCZWR035s/KCSO2mWmvQ6cY87JdrV0ars9j3/Kx3y0cZPfnkQDv8g5HzAmM+WTBcqEz22eFH54lclagd9me06D/YPUvdM3l608NHDXTGNnG3K6mbxv3XnPN0CdTEry5FHEm0uZh2qmVQ6ORF0cmWHsZ/0mmfhE3ihkySYl7iv47RDx7lVXyZHVAqW2rlvGC8l6QV4iTJ+e4xmLlAyIqS7LgttcELoyTFggZeficEJoA3lGTS62vpe4Y/5mdRjOrbOySZexJReggt1z09g2SCi1VUoqWazNyZJYpGhkPVn9kIQ8PrvmJsP0lrNLia93fTg4+X3H
X-Microsoft-Antispam-PRVS: <BYAPR12MB267906E209E3B7B034956DF1E5190@BYAPR12MB2679.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699050);SRVR:BYAPR12MB2679;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2679;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(2906002)(386003)(36756003)(8676002)(81156014)(5660300001)(2870700001)(81166006)(47776003)(53416004)(316002)(54906003)(50466002)(86362001)(97736004)(6486002)(476003)(26005)(68736007)(50226002)(7736002)(66066001)(486006)(956004)(44832011)(53936002)(6116002)(106356001)(16526019)(11346002)(305945005)(446003)(186003)(76176011)(25786009)(7696005)(4326008)(3846002)(52116002)(478600001)(2616005)(6666003)(105586002)(23676004)(8936002)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2679;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjc5OzIzOjA5RGQxNTcyUW01d01VeWF1Nmt3d00xOWxj?=
 =?utf-8?B?OExFNXN1MmdIak5LbjhPT0hlWWZlbkx4SDhhL1haSHlRU1B4YzNTa243WlUz?=
 =?utf-8?B?N3J1L0hVZHNxeTZWR1o5UFl2cHkwN1lqUWFoQXJFeFNuazRHQ2lZdDhQa0xT?=
 =?utf-8?B?MkNJQzBnamhZUzhkTDVIVmdRY0d4bGMyU1IrQlhMRGJ0NmFqc0YwQkJhME96?=
 =?utf-8?B?U1FrajNQVDhBOHhLdE1MckJjMUoyWm9KWC9GcTdHR1FzOUE1bzdBUHhkV3hC?=
 =?utf-8?B?S3ZtRU4rTEU1clhjMDJFa1J6OVpNdW5NMnJJcHNtL1E3anFhekdscCtBL21n?=
 =?utf-8?B?NWZNWWY0VmJsNUM1SnQxUldadEFsbDVuQXRjTFBEMDVlcUZZLzFETEhTWHBV?=
 =?utf-8?B?RFVoaGJxeXAyY0d2a3RRb2JtQjg2eTVKVGhxclorOTdmejlJdlU0c3lqZ0hi?=
 =?utf-8?B?WExzVm5SQzRGdzNTT0Q2WGNCSDRUelVHa2R0cmprMDZmdTlTdUY0Zi9ZVEdq?=
 =?utf-8?B?SEFLRDhndnFGNWhhRjdSMlkyaGpwNSs2c3IwOFN3QnNlT3F1REVqNnZIOWJC?=
 =?utf-8?B?YVh5dzBlNk0rdFFrK3BSSUwzVDFXWkZhbzJwLzF1THc3dWFTeUxRTW4xejhJ?=
 =?utf-8?B?QUU5MjN5cGFlZndFMGsvcG1ISnlWSFZyMHd5WlZhR2NKVjgzWU9HZG5SUzUx?=
 =?utf-8?B?dEFPaGdPTTRmZUlXK2Z3OXo5S2ZsZkhaOUhvODFQbnhQdHR3c0t0b2tYOEJN?=
 =?utf-8?B?NlNueHZXQkc4MEtoS0NuR09KT3Rmb2Y5NnRoUVMydmR6OExaK1l1WGdNL3FG?=
 =?utf-8?B?ZHBqZmd2UUJSMm80NkpvTEtrL0V0U285amxWa1V5MWV5b3ArK2ttODFhM2lY?=
 =?utf-8?B?Z3liRHd6dkFmWVBXVHp3aXo0M0xyTndaQWlCNVk0V2l2aDNpY3YzRy85TEpl?=
 =?utf-8?B?V0hJcjk2WUxJc2wzcmptVWFkQVhKTUFQWWpzVlNLc1pqR0VtZnVqS0tPbVVy?=
 =?utf-8?B?Q28rME9VQU9TL0NnMVlsaFZoZTZTdGpDeStpay9Tb3RWaHk5WmJtZjZMTG5Z?=
 =?utf-8?B?ZG1USmF0Q0JhMnVMNlp2alZxZWRldEM0YnJBTnlXck5HTEJ1Y0R3VkFaQ0N3?=
 =?utf-8?B?OWhXUVhla3BIdjdGZ01Oa0lxVXJHcitwaUVOcE14Uk5rT1REYUlyaWVTeFdX?=
 =?utf-8?B?RFgzaUpIZi9VZEJ5c0IxK1daanNYcWdqSGY2TUNzR2lidmNFWW9qT29JMHVu?=
 =?utf-8?B?NGlJelUrNUNMUDlndStKbm1DNTZxQXpnVWpaK2ZTL0lSc1NBNnJ5aktiYnlL?=
 =?utf-8?B?S2FqanFLMTRaY1lvbG9nUEJzQ3EzVXBzVlpQTXpIVHlzbGpQMG5MdnZrVW5a?=
 =?utf-8?B?Y0E1TGZuS3VlQW9IaWh3ZTN4eGQ0YXVMWi9TdDU3ai81V2NRcVV6SWNCSE5E?=
 =?utf-8?B?dThaUWo5OU9wQXdwSmx4NFZzL1RvSzl0N0I3S3ZUalJTWXNCbGltclphWHBn?=
 =?utf-8?B?MlRCYjNFRmYxOCs4MnhqRVhUVXovOTBHOVRURUxzWWV6amhvd1FNK0tHVGQv?=
 =?utf-8?B?M1R6bHhvTkhlMlU3eFZ2UzJzNDF5WUpGUGN6MjhaQWtiZko4OXdEK0h2Njh3?=
 =?utf-8?B?TUpYM0o1WUZuZ21jaU9qWXhwM255MzZSUUZ5Ym5LTEdKRHFUMzdNTktnPT0=?=
X-Microsoft-Antispam-Message-Info: bUd55T9bKiu1qFvSQj2DQXdJm1v6ivucCIbTAdkYtJi1j/fw8JLF0CD7+jRZMUcMZGv3PaFNfeNeuOBWrdUGB9e9nFvKFmApojdvQ4TmUJ88OpWkTXQoD4gyAXwcyxLGTi5eNBU9/o1Wn8MySpyey6ZM+oyTc7DPfqW18hQemp3TuLwNKvypbfWxIz6K8N/hP8PW8Kr54GChWXI6Sg/XAtR/dCQOa3gj7OV5cw97jlFJn3Q+N2ScBhmPuqOtfXozAuIU7l2KKqGaaXlVmueT00j2q5C+RWjSAMR2yQmst1iyHl9iXkMueOlmcSxYOAskQv7ZvarMZrZiqN/AbZ20su5TUjvkdPP2V/H+jG+zGqI=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;6:onfzS90zH/mCCcWIOu6cBpGQkt1e47Tp+aeNj+ySsXBbKbuUqFVT5LZQclizjeVUKB6H1FkTFFhwFZ9uFod37t2nFzXLJmtxfAbovD6T/mlzZjVC7rUGb1z3TyLtcT03LY+hdDcMw03X91a/9G5MKpJBdj4dv7/fay88dLWgpGcep8y+l6U/h/AzA7TC96rByyzUSB3ajN2pffygN8hOZc0c+LJuEP5gwR86ew/A3sDltY4qcDfJbo+JhKjl2OMLjPhJV2BGG+dbVlyjJg4N7JsRVE8ajMLPOIEk9/pBpUYhI4TtJFCtAAaGjhODRh2tEOWISlwtmy4r3rG5XQA4JERZqkx9y0TMHpuYkUleLdZGbKYC383L5ACoVBPmNXqJIiml2zUjiIMeHdCctIndfuROBq8wgZalXtqdYlq/OwFTiLGmkEKemHzzxPVrjrhxReDTtql+qdZ+u/J0S/kgwA==;5:qreZLQP51sro//Pjd8tNKrzeHjbb+mVOW/Qb8zHXou5iX8Z30KPO4AuqwCBncTdh6POD3I3uEedqvL4AdKhswgG1CyINPD9ydWxikyrK0fJ5rdv931X2/yYTHpJFCg6Hq+TDWLwwqpNeUtvFuXEAxBYkQbq5+yCttvYwaOP5tQA=;7:wAOQV3ILnZ3LqzPgZyD05nb2LFDVENyRJz84qegDkMmccjjQajjEKBmmnAcyUZZxHjOSNyBU3y70dqckIpbw8DrUWVAQQ5bn5AtjjvO47WWeRA9adcz5tms/EV4bzkG2xUKCDU6qWBPiK98Aq735xF7lrAF3v8d7eQBYe9zZE7HIC6SSfqhFx9+3l0FUMoWXpJ9aYpi8nT3oaoY1xvU3lMRaifSAv9XDT+BP4A6yBXPeIPqI6sL92gLIygiBSckk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;20:CzJNeVNaFVfD9caYZ1VvOI7GBDyoMjZNnLb7/BGV29gRBEMx92TMXe2GFLf3T8BAhDoKa3k98nYQdWXcz80r0IWFnjHthITe4qLyXOAgwUO9FPcEnBKJV8s1UNDpwwLsjgZpJzaQry6GWcS5GXDqUGZnmQ0jhDOrewZsmxiH9DZ/2l3UHZPdmyEnA1+bxbSTl2vCiTDAC4HpNMdxMPXmYxCZwBnKOetpqTonOJWCj9GSucBa+3jYzqtrBiLx6s7p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 13:46:16.3102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1b24fd-9df9-4815-c009-08d61a487260
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvmclock defines few static variables which are shared with the
hypervisor during the kvmclock initialization.

When SEV is active, memory is encrypted with a guest-specific key, and
if the guest OS wants to share the memory region with the hypervisor
then it must clear the C-bit before sharing it.

Currently, we use kernel_physical_mapping_init() to split large pages
before clearing the C-bit on shared pages. But it fails when called from
the kvmclock initialization (mainly because the memblock allocator is
not ready that early during boot).

Add a __bss_decrypted section attribute which can be used when defining
such shared variable. The so-defined variables will be placed in the
.bss..decrypted section. This section will be mapped with C=0 early
during boot.

The .bss..decrypted section has a big chunk of memory that may be unused
when memory encryption is not active, free it when memory encryption is
not active.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
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
 arch/x86/include/asm/mem_encrypt.h |  7 +++++++
 arch/x86/kernel/head64.c           | 16 ++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S      | 19 +++++++++++++++++++
 arch/x86/mm/init.c                 |  4 ++++
 arch/x86/mm/mem_encrypt.c          | 24 ++++++++++++++++++++++++
 5 files changed, 70 insertions(+)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index c064383..616f8e6 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -48,10 +48,13 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
 
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void);
+void __init mem_encrypt_free_decrypted_mem(void);
 
 bool sme_active(void);
 bool sev_active(void);
 
+#define __bss_decrypted __attribute__((__section__(".bss..decrypted")))
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define sme_me_mask	0ULL
@@ -77,6 +80,8 @@ early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0;
 static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
+#define __bss_decrypted
+
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
 /*
@@ -88,6 +93,8 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 #define __sme_pa(x)		(__pa(x) | sme_me_mask)
 #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
 
+extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8047379..c16af27 100644
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
@@ -235,6 +236,21 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	sme_encrypt_kernel(bp);
 
 	/*
+	 * Clear the memory encryption mask from the .bss..decrypted section.
+	 * The bss section will be memset to zero later in the initialization so
+	 * there is no need to zero it after changing the memory encryption
+	 * attribute.
+	 */
+	if (mem_encrypt_active()) {
+		vaddr = (unsigned long)__start_bss_decrypted;
+		vaddr_end = (unsigned long)__end_bss_decrypted;
+		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			i = pmd_index(vaddr);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
+	/*
 	 * Return the SME encryption mask (if SME is active) to be used as a
 	 * modifier for the initial pgdir entry programmed into CR3.
 	 */
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9c77d2d..0d618ee 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -65,6 +65,23 @@ jiffies_64 = jiffies;
 #define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
 #define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
 
+/*
+ * This section contains data which will be mapped as decrypted. Memory
+ * encryption operates on a page basis. Make this section PMD-aligned
+ * to avoid splitting the pages while mapping the section early.
+ *
+ * Note: We use a separate section so that only this section gets
+ * decrypted to avoid exposing more than we wish.
+ */
+#define BSS_DECRYPTED						\
+	. = ALIGN(PMD_SIZE);					\
+	__start_bss_decrypted = .;				\
+	*(.bss..decrypted);					\
+	. = ALIGN(PAGE_SIZE);					\
+	__start_bss_decrypted_unused = .;			\
+	. = ALIGN(PMD_SIZE);					\
+	__end_bss_decrypted = .;				\
+
 #else
 
 #define X86_ALIGN_RODATA_BEGIN
@@ -74,6 +91,7 @@ jiffies_64 = jiffies;
 
 #define ALIGN_ENTRY_TEXT_BEGIN
 #define ALIGN_ENTRY_TEXT_END
+#define BSS_DECRYPTED
 
 #endif
 
@@ -345,6 +363,7 @@ SECTIONS
 		__bss_start = .;
 		*(.bss..page_aligned)
 		*(.bss)
+		BSS_DECRYPTED
 		. = ALIGN(PAGE_SIZE);
 		__bss_stop = .;
 	}
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 7a8fc26..faca978 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -815,10 +815,14 @@ void free_kernel_image_pages(void *begin, void *end)
 		set_memory_np_noalias(begin_ul, len_pages);
 }
 
+void __weak mem_encrypt_free_decrypted_mem(void) { }
+
 void __ref free_initmem(void)
 {
 	e820__reallocate_tables();
 
+	mem_encrypt_free_decrypted_mem();
+
 	free_kernel_image_pages(&__init_begin, &__init_end);
 }
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index b2de398..006f373 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -348,6 +348,30 @@ bool sev_active(void)
 EXPORT_SYMBOL(sev_active);
 
 /* Architecture __weak replacement functions */
+void __init mem_encrypt_free_decrypted_mem(void)
+{
+	unsigned long vaddr, vaddr_end, npages;
+	int r;
+
+	vaddr = (unsigned long)__start_bss_decrypted_unused;
+	vaddr_end = (unsigned long)__end_bss_decrypted;
+	npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
+
+	/*
+	 * The unused memory range was mapped decrypted, change the encryption
+	 * attribute from decrypted to encrypted before freeing it.
+	 */
+	if (mem_encrypt_active()) {
+		r = set_memory_encrypted(vaddr, npages);
+		if (r) {
+			pr_warn("failed to free unused decrypted pages\n");
+			return;
+		}
+	}
+
+	free_init_pages("unused decrypted", vaddr, vaddr_end);
+}
+
 void __init mem_encrypt_init(void)
 {
 	if (!sme_me_mask)
-- 
2.7.4

