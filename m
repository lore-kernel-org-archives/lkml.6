Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D82C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91952088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TcML5BTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91952088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeH2CGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:06:53 -0400
Received: from mail-eopbgr720088.outbound.protection.outlook.com ([40.107.72.88]:47232
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727258AbeH2CGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAfhLatyIgt7uEUFk7/DLwUEHofvMUmUvVMzU3la4eU=;
 b=TcML5BTX+eSsLNJMEot7ju2/FP/Do+y5YTG6taUGK4bBYeeqYc4BwsdDgOpwefIS4sFJVhCj/evgYe5fvSoDUg7kuad3HFBhvYzJCz1G3g/Kkasosdf3NnWr9FNP76avg6+KZsmIju+ksXyL2lW3ueJcmussbnXKNLKJzITvJm8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:4a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Tue, 28 Aug 2018 22:13:07 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v2 0/3] x86: Fix SEV guest regression
Date:   Tue, 28 Aug 2018 17:12:54 -0500
Message-Id: <1535494377-25600-1-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: MWHPR19CA0010.namprd19.prod.outlook.com
 (2603:10b6:300:d4::20) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b430fa2-6b2b-45db-b694-08d60d336f89
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;3:j/3p+O+TVrxNN2W6X0ondJ2vXFOpuChNR4VDQn6wb1AF98Tj8XhlWvDuQ87d5qyu8dxqVoSRSNJ9v7z4xTJHGW0OniHuhXcw4J7LNoGHjFRS+Gh+nURytYbErqsImM3oPwNK+MELlFAIh0paQ7xcj01y9cBlvD1wvb2oLebbOrckKRurD2ACsCggopewxJC1vQnHAmnuT/iREDQZk9E7Z2U48dlbCfzWKDUefPBier8FYrOF/cmB0vfqf0pcm9wU;25:T7U3n0IGbcZ7QqK9QMLv0tAdtrfl5Foe/E+81GEg/2o9T6NgDVJfeSBGq4TLOJylGWh2TySYKo27LnHOiyBcgH7PzXA7OZasIF6qPgWrz5Admrtpi+dFM9VWmmw1kgAljWcrACB7JKCUn5B64n2p1GimHxYv9xLM/AhEsl8jQyTj8vvsc+BrklhZPWaHdM2eoi8c1148uwUhDgrndxGORFQlJ5vnFAzsv6OQChlGWTRAWbpR22mkQ+J/7OfaqTfrn78mgep177eN+f4PtnbkGj3Z75HwzEfXqHGruHZmlJzBbgHg6dFI8gLKPqWIzALXSA1lamzrywfy2UsIKzxhIQ==;31:qk6Yceh1gL/iBLM+Sh0y5ImxSyYPUBLrphgGxw6ngYrWXhXFytiiydQnJ/BJeX8vBlrJDiBDT+C/kYumzXY9b0Tn74bYlSZEWMvjdgnvhW39RRvC3/Bzi4fVpuRuQvoJ3MtnZ/rTzFahqsX7EWuvSU9KswCWVMKfYpgZMSR9D8JOY3/uyK1tsYczvkxKh3cjng3looH256sgaS0Eh10eXrm/aMsgQKLM5WLNdaxpRGk=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:NwXWnnNx4iRQ7GgxxkrDso/LYgZwLq5KT6suAvXPKXuPJXSzhyTLESXKOOs42VJhGekPMuAr3AcLzAtJgAgzHHs/m5uZm+nplIUx5M63kYrUxU5FifYLRufDfoLmDQKo8zIMC83g7qFN/FgMVo2yzFO3OJTPIlu/bghGICdV47KvhdBgNKlpzQj1jZ0YZL4dKr8EVPSk1xzHltmbDOWsdbfUmq+8PAdUlgB3YLyd990rrCeTaHir8SnW0b/+65vW65Jt2SZHlRi1VXi6IzZiPvz40jsVS7murqlo+xOspFQw3Imfqqczm5Q1h6iGClXcc/zQLnJSEtL4nV93nTQC27c/29ot8bmsuTYJCa0uisgKn+c9GMphhnOffKBCNp24f56YYLY2WtvCPyg/9H/03YlUM6+2nl8LHxAvspvWVufVFif8M1gzmepSnJXR6bYPPQZTuWLuEMVVRyvrwgMdf4JbUdnt7KU4Y7Dl9LNE3JmYDkY1+EFDX+wFemAO1Q2+;4:v6JeO5CsUCv9SlD2FSVYWW8pmTbTBbCiYnr1m3nJhOlGUTz5nGl35gRYUmeX+VKurZw/FJeynOPYahROkSgHU7OPG11vq3KSECWQUQiAxEXQFBCop7O3CL2kz8VkA2LXgkoyXEGSXJ9XJjfvnjPk+OsI7eIQ2LgZAJoo+YoTpeNkKWMhpcTdtZyJR0Fwi/8m41BsC6KzExYxCL6ChKqkX3Yc/hmFttfp64x3/b7UVTxaFVO4AUhLf0I1hptQQa1xruSRD8J0e/btTppzH1fQeZ7q3mQqO4tcZ1aau9smsVkw+GaU6zOO2zepNB6sLQAL7wc1Vyvq2KdZlzAW1Thz2Dyk3nhTRBc9WshxoYp3z7VJhLp8Emis9jSVhWMVEJcJ
X-Microsoft-Antispam-PRVS: <DM6PR12MB2682F049A8C6B055297D2D0CE50A0@DM6PR12MB2682.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(84791874153150)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:DM6PR12MB2682;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2682;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(189003)(186003)(50226002)(52116002)(7696005)(4326008)(305945005)(7736002)(105586002)(8676002)(106356001)(478600001)(966005)(97736004)(23676004)(386003)(316002)(53416004)(16526019)(68736007)(25786009)(26005)(54906003)(2870700001)(86362001)(66066001)(36756003)(47776003)(6116002)(3846002)(6666003)(5660300001)(2906002)(81166006)(81156014)(956004)(50466002)(2616005)(14444005)(6306002)(486006)(476003)(8936002)(44832011)(53936002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2682;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjgyOzIzOlpIUE5ZWnBBNXMzeHd2U24va1dEUEpXeVlC?=
 =?utf-8?B?TkdzOGl5VnRpRHBZbEJKS1ljRHVTT2hWOU9GQWphWEVJS1pUYXFvc0tEMHg2?=
 =?utf-8?B?QTd3MzNWa3R2OGk4WXV1dDUrOThIMEFIV2QrRGwvaVRhNDExS3lMV3VWcVJm?=
 =?utf-8?B?cU1UaVhJTzdYNWZxWmhPYkc2Rzc3L3FsS2dKU1Vqc205ODZySEdxUW5PNzRq?=
 =?utf-8?B?bEZuMzRhWmxQZTgwRURDcWdkTnEwZnI3QzZlVHMzL0s2Zlp5NHoxenpKRTBJ?=
 =?utf-8?B?RTFXRUFEd1NNNzRhbk5mRGMxbHVGb3A5VEVJM3drakpjWW53QkxsNktUZ3dz?=
 =?utf-8?B?MXp6U0h3bmhFR0x4Y3pqelVuTUt2T2NsRE1uNndOTElEWjQwcnRaMSszV1Iy?=
 =?utf-8?B?WklPTDFxdk1oSEVJSzhhZXFWVGJHbHdDd29JbjMrMlhlNGdWYy9KMDZraWxa?=
 =?utf-8?B?aTN2VkVTQkJHbGt2L2VGOVlRSGtjOVJHY0NqcFJQVkZ3ZURaeGJPQ1Q2TlI0?=
 =?utf-8?B?WXFMWm1rTzFpK2VvZUQwK1o5WHY4dWtyeUxJSXUvTS8vbWtqSHJTejlIbFFt?=
 =?utf-8?B?WTUraEtoNDNkeHlNU2RRTno0Ums0ZE5qNDBqbVVqcjZxbURwL3loekd1NENX?=
 =?utf-8?B?S3Avazdwenp5aGdjcExjekhQK1B2NVNjVkFLUXpsZmZmajJkR3ExclQzeTBY?=
 =?utf-8?B?eGJqUGxZd2h1RUwrYzU4MzEzcWRsbW9yY3NybEFtSVdUOEs5OXY3ejhnYjcz?=
 =?utf-8?B?YlhIT3FKQmMzOUpMdldJOFBIZ21US1RPYi9kZFE5d3RHcVN4bmU2Z3dZaS9s?=
 =?utf-8?B?WEFWZkRRWVpDV3NjcUZveEhYN0d6eFN2ZEUwYnFiWTIvZHpyOW9QYWx6bW9P?=
 =?utf-8?B?QzZiam5CaGh1N2RiQk13YVdVeWdwdDJzNFJLajIxWDIyNEVZamZwQmZ6Y2xu?=
 =?utf-8?B?dXVuc2Vib3VaNHo1Z3doM1FUdVVEQmc4YlFsNkd1N0tIcEJJZ05JMHN0Qk1q?=
 =?utf-8?B?bkwySHAyU1FRN1FWNnRLWXN5b0x4M1NDMDd4cnYzMUxmbnQ0dTlEVTR0Y0pL?=
 =?utf-8?B?MnhQdXN5UXZENjhubmhTcjVWWXlBMm1iOXlrYmNNWkd5ZG5nSkVzTU9Ccnp5?=
 =?utf-8?B?T3pncFhOY0ZCSXpZWldIV013SWxsdURiK202bU14WWxOZXdoWFA1bTFKWXFI?=
 =?utf-8?B?cEpvNmE5ckt0eFNUUkQ5ME1VcFU1ZXMyY0tPRSt2Yk9laFhYa3lQUmRUVFVx?=
 =?utf-8?B?bkZ3bExSZUJKd1hsc2xGWEI5YlFFOXpvcVFLSENnOVk5Q21CaUN5cUhUOTFm?=
 =?utf-8?B?ME90NHhXdkFWaitSejJwZ0dtWVlSL1Jrbkt5ZzRwM3NzaTA5NjFUSytxVC92?=
 =?utf-8?B?Q3ltb25UQmZoVWdISStEbFRpVWMvN0tHUkx4eTJQVnM0eDA1NmpWcm5hQW5Z?=
 =?utf-8?B?RUJWWmxzZ1BONUhnRysxVmJJT1FzOHZUYmJ2MDVtQjhQbGJkdUVVSzJXd1pj?=
 =?utf-8?B?VG0zZlBvSUU1M3pMcWN6aUE4aEhJVWpncjhYTlB3ZWhCUlRHemtaUlNkV2VK?=
 =?utf-8?Q?Q2mZBjrFk3VxFQ3geTq/j8aNRW2rECOACbXvTIPvyIQ8=3D?=
X-Microsoft-Antispam-Message-Info: 0rHxyvpvBr6tGGtADum5uKJcrEh4BKkGzeNBMkQX/gEpqwOdwdmazZlYB3/9jx2ErFYqeHZlQmN7VlOBDvxPms9WqgtckVr1oBXw+oTaqy07hIwY1xYEInWYI82dyzT2KqtrtfbIQIw+p71DZDey/YufHuYn7WkyIx01uzxti/cWmu0N1Q65nR08LUohc5GKIM/V6yNrsYwTeIABut/0Ip7+7pMl728+4Kl52waNKQhVKygP9/gqwKlTXU+tj1OHwL3vIAyFTCq5m8iTR0vySDDwHIdhjmbvrMTc3PIFWBL1UK0XUKLcSraQoWdJFMHw04+XKve3q0HNWEXuPJV1//Aee0Ldc04MlIUmBWTdaWQ=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;6:+41GsxhObUQpv85FdgBz/yrxXEWVxFiFFMmVwhkncqH6wh05ZgaSCk+HjM59UiyNRrxeEkXyysMw2thKA+5S+6UvqzvVD7wY6hH44i943bG6Ggm54or1yjlSQGj+1J+HBbDOMIrn+9MmzbdnR7tJFF6GIKaHi7kiV7PwgXv/Wz9OXOpqYwSfkO9h0wdZA4VH1HigX9MFrAx5Lij6QUPrY4AM6axAhNaV+oyG7MMZp8zWfO11K1vQWeKhpl4VpDZXS/xnhxv5b50gpo0VCZwtO56opvMIp54+HCSdzVIANCF5ZhOff+IO4HUPrbnfaCwQBPbwfvX93YLSvBmQoyQGoABkSM4yzLOqtMEklyHUUOP9ZK7trj31Va47NXTPwgJNHUgH/a2lDwgXsmDzLViqGmD0RKNolDqCaFveU+EiCE1a+Kfet1GUwfT72Gf3VDt6WgUt77o6yeRR88mNm3Nbkg==;5:HY9edOanX9yRE0YPsBbiEzkbwsKqDVvcsp0jKcPnHrOtUg6cmJzR6MRCIjraW/t0o0KRyWn6tcMcw92IFsJEhz3EV44FFlXsVbQNzM956sWnEc0Unqd47A5v1aWK4hqXZjdZa6JySGpgoXtXIQzJVL/zhR050VVMlWtNSmsahNU=;7:WUJYUMEMzBVXJktHvyIo7LT9+wuamSPYXyJc0bjSwET2yh5U1a8dxcSljESnPBkZDSDgHuHCY2k2QtS3UJjpSN7mgoFLKMvXtCiXCxvmqxP/d2XJ1D9knVR5j8Lqfpe/XX0I8Zg1jTRZyjH5V+qhHuFNB9Kdiw6V5ljvXYE15PnMFXdshoRoSSI8FEFA0FSSAE2FDJmb/PQ82Inx8QcwXfB4rhI0z9ae6MmPRsjFuOdqpM+6gwSUyoqA7KNFAiXL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:GkbttOt4WdOClpnwOUsfbhfuhtTKgIAymBHUfA852Ryy0pmYoKG/bYyr6jNq+HLE+wbW9O9wG6ME2Mi+lLNHkJNYaLOY8dE56kMQzhjbLIQfC/RCWZPLFpn1smg2XoDXcAAJqInvZ/PB466bSmMwCFthCZnu4lo5ali49GUaeI13hDutAh2q4aFlwiOJEUOvkyMrBTI99VnPz1hIZnT9sT1Ol4x45vXSmCryyPjhc+eadu5aBHB+9CIatPZNcz+i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 22:13:07.3418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b430fa2-6b2b-45db-b694-08d60d336f89
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit

"
x86/kvmclock: Remove memblock dependency

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=368a540e0232ad446931f5a4e8a5e06f69f21343
"

introduced SEV guest regression.

The guest physical address holding the wall_clock and hv_clock_boot
are shared with the hypervisor must be mapped with C=0 when SEV
is active. To clear the C-bit we use  kernel_physical_mapping_init() to
split the large pages. The above commit moved the kvmclock initialization
very early and kernel_physical_mapping_init() fails to allocate memory
while spliting the large page.

To solve it, we add a special .data..decrypted section, this section can be
used to hold the shared variables. Early boot code maps this section with
C=0. The section is pmd aligned and sized to avoid the need to split the pages.
Caller can use __decrypted attribute to add the variables in .data..decrypted
section. 

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>

Changes since v1:
 - move the logic to re-arrange mapping in new patch
 - move the definition of __start_data_* in mem_encrypt.h
 - map the workarea buffer as encrypted when SEV is enabled
 - enhance the sme_populate_pgd to update the pte/pmd flags when mapping exist

Brijesh Singh (3):
  x86/mm: Restructure sme_encrypt_kernel()
  x86/mm: add .data..decrypted section to hold shared variables
  x86/kvm: use __decrypted attribute when declaring shared variables

 arch/x86/include/asm/mem_encrypt.h |   6 +
 arch/x86/kernel/head64.c           |   9 ++
 arch/x86/kernel/kvmclock.c         |  30 ++++-
 arch/x86/kernel/vmlinux.lds.S      |  17 +++
 arch/x86/mm/mem_encrypt_identity.c | 232 +++++++++++++++++++++++++++----------
 5 files changed, 227 insertions(+), 67 deletions(-)

-- 
2.7.4

