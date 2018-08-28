Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7969EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278AD2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zFwZlcaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278AD2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeH2CG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:06:59 -0400
Received: from mail-eopbgr720084.outbound.protection.outlook.com ([40.107.72.84]:59200
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727261AbeH2CG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZgnPZK5SxDMO8Tslr/4np3uWaGszntWO/0fjBHu7oU=;
 b=zFwZlcajNyYr4gcxzx+ztE8q7RGEo9v8KIDdYaYoU6QocGFqnQEp1Dq7tDZYXl4A2fKpac3hlrrzdPSlDm+Lu9gt0BFZ3tDD+kqdTiVDmp7ewktoZgVzrXmgvYU+pWnjdInX5EzQPhEm2rqoaA2pH1qTI29uLMcwEfJtSv/2HNI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:4a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Tue, 28 Aug 2018 22:13:13 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>, stable@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v2 3/3] x86/kvm: use __decrypted attribute when declaring shared variables
Date:   Tue, 28 Aug 2018 17:12:57 -0500
Message-Id: <1535494377-25600-4-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535494377-25600-1-git-send-email-brijesh.singh@amd.com>
References: <1535494377-25600-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: MWHPR19CA0010.namprd19.prod.outlook.com
 (2603:10b6:300:d4::20) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da898402-e00d-4e8f-8f21-08d60d33732b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;3:voqEQ4a2o3uip8w+/WnjZ70Fcc38Kj+1nKGQM6wYlpWKj438bENHXCRirTK79pR/YEur4ayqWJkfWglWBHDwetrUKmixLhZMimAugWQ8+WIAEhhE3V3UH5+QVwsaXjW1Je3CqMx5IwZ3e3KMZuE7nmH57l+DAsbTfTZ4zMZtCbX0Ma/76o3jC68WzzbWNXJrA8OYUYjM2RmbxDBnwRhMkLA7fKT5pTArw7Z0TB84vP48taQ/g2vTCVElxZpMCXEU;25:3HlzImtDCzeWkLOprPUhY/kEGatzUIJIzlmDf8Au0mnhh81/PIoVXoF9Gm+TtgD9tFgXVkel2hWWkiIomA92Vr45KlpdAhaUaR2DNwUTkr6OkwkUSBInGxJWCQD0NeYnDGcLuXHcjeK3/zZzmmLGBKGzSYvEGShti1+2xNQzLXeIVwQn0xtof3ceFHmruBWOQoonjoxxsNM6fJGDQlJGyNdorjPd2O/XE0gW8DsHcf6O5UO5Ct70J5cakK0Jex9xxuDLRLbkUZAEPsX1+BE8Eztwy0QrZXEDNOKID2EnCG/wtH3GQCDU2+WYpsl8tGhSI7uaeVgG1suEO5wA/Woriw==;31:xqLmTCcQ+BRZvhiA2RGGpBu/C17+voBI0OYpSnlxfaRhc+3ogzT9GTv0zcVer33R0kU0lsZcRIbx4q8aiCd7IQDIFGEADT1HSty1xhWWdH/tudkoFxfDZu2FxpCkA/C/6kazGgnQuOFd0PfndF3QNrRXwIwaQuXwRsu0CesiuNYmvERuaeHmudoZGLCY0WRIOcFHWTGhFSfrjN8i0NuksFTasS8pWNOifD153A7OiCo=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:OX9wsLKhGRAsOFIkl3tzEqh3cP3mmXPYSof3fF6fy/GmP2G0zJ9Ei2vvKT/aGuylkn7YUzELdlHvxI3L/tniB8rFSD1w16UfNs3qoIojQZaLGp+f/INSoXId26KPHqT/u1uJuHbs2r5dBZ62kZ9WTSP4jtjqENaGJQiEcFOo+MQfZHLKzjYiN9G8AjPnGWqxr8i0HNNeENC9/0tx6ALDqgGzGTWJzAMd1j+KSDbiQuDVAfCH7BaZNgPec1clL4gDyKy0bSWGyC9hkfF3LuSjqCRpCQkFlVgvVS6DwQiX6OFWXmNYzH5sx5bNEbI0IhhsCGuKVJMIkL9kgYGGyaRbmjYbzn/ggFMuOiadPZXksBH7dsvQbwUz/uH/u9pfbXySkJOHwTyQFrdzYxgBZiNtv503bOrGMnJTGQcXcPRY1EU7Kf5IGed3fIzHZA8fH+R/PHiWwnqK/Dkt2VYbW5ml/K5jknK5bI0SJQjLvU+em4aOkWkwYgA27qYir1A6NHKR;4:7LqWbL4YzFsiguxvw/0xahVLTOtz1L6L4RrzL0bPCCMOvQxdl52J1TR5smY8rLJgCg6u66tt3FKLaHeBjDwjZYhEdvKDgBWJ2fXc7S52goSwZEbdEgnLpn7bARy9vEZ/Ws9SypZpkh1qeYK+Jeds+7EExpfLCN2ekdFThBYYej8IRz4B0jJUe6zjBLdXKFV6z5N86QLw+NzecSy9dAtyN5HwqYfqDDBAcyMMCiuGAZjjuiCyYaUnFR/KA1IOzL0IxYiltcFtOtpJqhF4va22z5dZHAA3ZOQBsHyr/WHPKNXMxhcK0myIUto70/5FcrkZ9tYOofX8+i2hZHYX0u2vMixyzN5Sud20Qs0zz+8O8QIJ2q4MOdHlL0ec/Dr0t5pH
X-Microsoft-Antispam-PRVS: <DM6PR12MB2682D771B41582ED58AA6E88E50A0@DM6PR12MB2682.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:DM6PR12MB2682;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2682;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(189003)(186003)(50226002)(52116002)(7696005)(7416002)(4326008)(305945005)(7736002)(105586002)(8676002)(106356001)(478600001)(97736004)(23676004)(386003)(316002)(53416004)(16526019)(68736007)(25786009)(76176011)(26005)(54906003)(2870700001)(86362001)(66066001)(36756003)(47776003)(6116002)(3846002)(6666003)(5660300001)(2906002)(81166006)(11346002)(81156014)(956004)(50466002)(2616005)(14444005)(486006)(476003)(8936002)(44832011)(446003)(53936002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2682;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjgyOzIzOjc1QnVjbVRQd1Zub1dta2tmeG5zSy80bnY2?=
 =?utf-8?B?dDFSY0hLNTdmQklTQ0hRRE1xck9mbHNZVkQ4NjAyZ0ozMmdvVmNNNXVRajdp?=
 =?utf-8?B?SXlnSDYzWitNU0RST0sxa2xwS3hCeGJNSjNYemdsNjQ0ZlNxT0hJNHFjeHlu?=
 =?utf-8?B?UzZSL0llR1JYbXcyRU40Q1lVRE1CUFVqaE1DNGVxcVV5NjlmR3djS0o2aFZk?=
 =?utf-8?B?YmhOOFFoOWFQOWRxRzZTVlVDU2lyemtvMnp6S3U3OFQxcU12azR4d0Fnb0pB?=
 =?utf-8?B?QjFSUlVxaG44K0t1QlVTNnJjWkpTc0NHQlVreU12WDlBUE55cEs1SDdIVlo5?=
 =?utf-8?B?aitnTVhRZHcwZG9uVHlLUG9Ka1E2WnlSZDExcjN6SWFWeVpQdXk4UVV4TzBG?=
 =?utf-8?B?K1R0YU1Bdjh0cG5TSGZpemUrbXlIMUord0Y3Q3YzRzdyTXp6SjVLWlVleThG?=
 =?utf-8?B?Yy92cjJndGZ0TmZPTFhDVVpZaFh2NjBpcEFPdU5YQi9WeUc1ZDBpRERiUy9O?=
 =?utf-8?B?NDZtOFhZb0tuaWloZTUvb1hqeVJ4UGRSa2I3L3VSeFdMUC9aSXhqUDlZaGF5?=
 =?utf-8?B?Tmw3RWpNRmNlNmNQcnRzbERuSUxSeGs0NmVZNVZMeUN4WS9xQVVNS3ZsS09U?=
 =?utf-8?B?Y1lrc05KRzRYbDh0bmZxYmlpRDNRSmJRb3ZBOHhnenUrNjM5MTZYQ3RmdlRZ?=
 =?utf-8?B?ckg0UGlhZEtTcWRNZlRxQTJJKzg0aTAxWmJ0TnE0STRaMXVNU2hvYzVMZjVF?=
 =?utf-8?B?andMZlkwd2lpVTdlam5LWW5QN3BuNkpaRTJDOEd5RzRJd2QrdmJaZG5hUy9L?=
 =?utf-8?B?dmNRRGxoVnNZUHdrRlloZjZWV241Sktma0hJRVhVaVZTVnB3ZWc5U3VteXFE?=
 =?utf-8?B?ZnNzSGtXRmpmN2o2ZWZGNzZWcmhCWVc1TGg5Yis3SUQ4NUhFUDZwSDdFUVdW?=
 =?utf-8?B?SzYvdHB1UWhDRndmbUVzQ2h4a1FUbmxHKy9PdHhKcTNNSUNVZGVmb2JNVEs0?=
 =?utf-8?B?WlZabWdkdU5MR09QNmY3Ym5tbnpyNkhkQ1lqRjdlWlRxREhaU2VqZFpYdmRD?=
 =?utf-8?B?dzdMMlJZZjVJY3ljQTJKNk5GOTVtemVZUUx4MmJBdVFsdERUSkF4dUxPL0ZM?=
 =?utf-8?B?c2N5MXZ1eXV5dFBEL3ljcmlKZ01GY1B2WW1PcjQyTXJQbUNMc2ltQkNCYmow?=
 =?utf-8?B?Tk5pWnlyNkk1eEExOEQ1a1A2bmJvYkwrZEZtdHlzdjJySWhSY1J0TVVxZ3M0?=
 =?utf-8?B?V2dPelVjTy9YbzROYUYybFNEMVpVanN0a1NNR2pIZjZ2L1JESlZCcnNTWmlm?=
 =?utf-8?B?T1FmdkFMZDdtdmdyaWNPYVRmckpZTWZqejZOTkxCeDhiYlVaeldJQS9HeGJI?=
 =?utf-8?B?MWlLS09UUWZjVFZvSGtVYUhEZXZHNG1IU04waGZyNktOc2FkeUFUZEtTcmQw?=
 =?utf-8?B?VWIvZXU5ZGVYaWxrSE9XZTZpb0ZnbXZzL0M2YWV5dDROUG5NQnpKOVRneGor?=
 =?utf-8?B?MVQvM1FmbVd3eVl6UW5LY3NFaVBVR3pTV1JBKzIwbWhYS2xGUEhQalRwN2tm?=
 =?utf-8?B?NG5oQmFaMW1wY1FiMlBFd1d3NVZ3eVBHKzcrT2Jod2pRZjd3bkZOa2dSWUVa?=
 =?utf-8?Q?4D+2WZJnEfp8wPoeZtXI?=
X-Microsoft-Antispam-Message-Info: o6G0tWOQRVLG+8Nk4p/yovryEEC5JW9aJ7UE1j6tIgUFaSFh80GxjMy7ewCSmmntMFP4+nuE/Bhre2gD+skgA7dfCHk1yVVvXYPk/kwkeikweGCB5lSntEzgEInWL7elArPTAbWGfyfanrhIOtUe75B/TS755Iw1UArk2ySgz7CqThP07pQGSSHL7b2CvotM9TsTGvOL0R7Hlous8KUbt5oFHb2xxaxi/0SAmkHhwneX2xJtDQnP63wVK9euSLxYGfWesrbuwVdcq9jO30R/oCUUpE1vJlk/RREuSDty2+79SYUftmMwt0vYUGZkz/mZO1X4vaH3O3WnJMUJj2n5iuuYbXYN8/TrLzXB2vE/kBI=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;6:IQbD/WyW6gKNLMJoNT7woqMw5/TyP+f3GdP/RHGV5gZBhaGFtW40zPv/ImdeanVf1O1KPHYF8AiKPkQKrA3USHFWEc9cHUI8i7a1iTUE4krGFrgi/J7g/Lg9LP6uMsek4Cq+lJIHzEKhd/Tg3gP4jyXEqAPDJMruU4/oQje82kuujpEeAEaNhoNu/gH83oYLwu/tVFslWzip5fbywTVAcLMZueaprrwMHGujNGLv6ujYu0ZJpdKpfzS23wBsEPvoqGl0PRrTb8Y/IQSqo1ulnPkVbmrfQSrhuBUAvjKLIHM29j7dZ+6m20KTR09EBcrmJkTJTPfI+HYZcep+hVY38QRtmmIs2qzq8j8TrR69eIjCQekZWGPH7BQH60Ln+AA4PebVcblcnr2t5mF/6JFkTUtKpQQf55QsAVZyQAal+u0dCT8KNzHRqs1uhuryB5s6s9aqP2IziWuig5go34ZoPg==;5:5MMnMWLjXfG+Qm/dkLC/F+KwgaKvd4qT7nPzWsK27YDyGBzPtutvsSgtS464EZYpN36a8LuU5vVJnTfDHZgf5f+bKflksiVEHHBVlfy5OWE91qI2XnwaNPGXnXDGAaJNVm4BGaMw/12x0fQe7SWDusS1TFFhfhkhlqfX7+1YUoo=;7:E7px4SGx29L9N4094yEqGeZ758PaBqx06XixWWB0j2egfyb7pPG1EQdX0RRts014W2e9SwfEJq2xR5M27fCXgHf+/HpxapJ22NpTQmv9JrzN8M3VeJCcxubMlEaJw0b5gENfMk99WGLzbHW027FqXmqPmC9ph9wGvNf2zD3VuUySmyPkiG48OhspdJlJa2U+aOOSbIZnN5Yc/RJY8RocPrR0gDjyr8YIFVR7FMATgrGpIZplIG5qCs+8+OCM/Bh4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:UM7sFXjYIIMgUI0fCUnppH1Iy7dvOSsp3vot+v11ovmr1SSVMBkHVjofGChJaIh34H4Cm50muXSFqL2B3C7raelGI4gNcrZbfHlWAij1TayO6MpJuQdRo4W94EwPv1n/zF/RK2Ucz+0HYtZgA0H2dJy4wwX2j5THd8p0f4DsJCZ5huH8nXZTqzd6HXt6b4XUxSNvf8/2uLxPAh6kwJnLER/YuZ1JcUtMnXLi31IhqW74q5+wEpu6CVFGBAAmrnUk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 22:13:13.2325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da898402-e00d-4e8f-8f21-08d60d33732b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
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
Cc: kvm@vger.kernel.org
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
---
 arch/x86/kernel/kvmclock.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 1e67646..08f5f8a 100644
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
@@ -267,10 +268,29 @@ static int kvmclock_setup_percpu(unsigned int cpu)
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
+		/*
+		 * The physical address of per-cpu variable will be shared with
+		 * the hypervisor. Let's clear the C-bit before we assign the
+		 * memory to per_cpu variable.
+		 */
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

