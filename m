Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED64C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350F2205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1mEvI+Bl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350F2205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeH2WXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:23:37 -0400
Received: from mail-cys01nam02on0069.outbound.protection.outlook.com ([104.47.37.69]:40616
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728379AbeH2WXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vp2bp9U+wsXTL0boWlK2FCenSlIPJSAoYF7atEFIkQ=;
 b=1mEvI+BlgwE2tPRMk3n0Tu7X9JTSVh3Sr22KSODlei3tFdg0yJ3/0gmNqutRs4GOLGIqMFMQzwS3DpVhHuuhNc2k0wpYkMeTleSNsSPwAm/N+5mE8itV5bpdLmLkuLybpm9cmG9nIxO29BxThN2mKZpC5Hx7+prZ5ZYc2iAC6Ec=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BYAPR12MB2678.namprd12.prod.outlook.com (2603:10b6:a03:69::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Wed, 29 Aug 2018 18:24:18 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v3 4/4] x86/kvm: use __decrypted attribute in shared variables
Date:   Wed, 29 Aug 2018 13:24:00 -0500
Message-Id: <1535567040-1370-5-git-send-email-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9b9d506c-300c-4865-fa87-08d60ddca2d4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2678;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;3:yFokDj+nhOcpXwr3KwGgoLXAPq3J8qTp7zmctQkyHyL4oALN1ZrL4eKPm7q6OdzabTAmO8cOIIbxr0ERx7zdhviTuirJfZSZ/EgA6tvVyzEk1N0SDxxhubX9XhiOBBIxHrbqfxDCRq74ZdQJ3l3PFijHqsUMIlhN7Po1w+weAq1i8Cd+g1gmGgtWJj6g0pQBU6bYPB3rG9c5g9cn+mO+VdI8N6ib0I8v6Lo7FFv5KBNRkAOYtwAjrGkT8Uqw0m3Q;25:f65UcnMvsHcfPVN0CuCvSjZhAKLNtkSXzlbLT3/fV0JDEiUR1wEkYdcO5g2XBJsrXdfZR8u2pxxFiYMt1cbJGwZdO3PXmWjvc1vzB+b7U8s+j1CUPJ0EQd1/6heiTFyvNM0O7X+9UcjbUSrZGIZAUmsFqpmYU7qfikLoohDO+FkiElt6JMLtUMDz6Es+O7S1xazG2fWFzee6Cn9fE1gRj7/LdZi82zk+qCqBXOWjMizGfH+NHN/rdkjT9otCkfpfjkjDaCEMCWcBnmCtz2293uJcpKtm+Nlr6WO5DjvufF7o3ueDKIo+Vs2WgzyOGe8HGkbSm2bKOt6oNAK3TgaMEg==;31:1zQXj1bqnWc2p8yP8ghfKiLmqMFbVbEuwfJu+T1zGHTxef6E8lQDS/t7RvWmniOiH9CAIgYQhKNG4Au+Lh4sWxKsHKf73l8n2YEF8EdkQYcI6cnSG+KsnKghNe6qrocXnFvGVwgGEVw9j0UAeLMSkWvvEUhzQxXJHEZ4jmPCdSGI8rzvNVXMhkYyzpKOYOtd8qWk4c7phrA5Z1I1Rsh+b5ooiDlwDTCouF19ZDkcRd8=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2678:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;20:V2UapbiP52ByTOT+JpiRQTj+GLEltu+6uPlFLLWuWVQ0mdjpd7nWDEcjBYIrSvxb/Nt7WjUdjXCDpsJhg3K0UKhCBSjiPBLwqTX94OPY6dqBhSEVH+D7dHfz2Rn+93bhXIttHdVZ2lmekIxhKgTqyT7ugs3uQr69iJUy2opWy9uH5Wj0LiKyhOJFwHIf1ysUIKMUPdDm+0B1TjmSJ30BQY4KTQvwGWeLosxJ9z+jkUtQJjszW4SvgZYwXmaXBuq2nsSjtkPCz3fa3HsYbDCkpUmDmIAElrZujvndlMlynDBvlnQK/rEyC4SX5Nrh+HtHTIuCyqZ8q2tfho2IeleAYSfSG+8vj6xNOgH4atvGaFVaRpxxgpvE8vS9WRMa5Pzr10JHFa7+tbAkT0ShsLGTvyS9m5rGj0M1EzH+ESUYy0ZZhIuv0s5HJHm8DBS/wNLhuYtFJCipvl8QzuH94SjbjYEEouAr9P2DkiFuLNy0k8Agy5jYPKvpJ6kPKTGXoBIM;4:ai8bqPGlPqMDGfJBT+11DxK4mIvyshJWqyo5OzKrWOwADRs+xOAoxxxs6UMVQ/mPfJlZNP/UB6jA86JMbycMAK6HjBdWg6a0TwTpsElnG6/SUGHjiwPnOvRC69bzkixko4yimOL/DPR7/ZxYVcwyX8/mIABUhn+/89pzuLFUCtraJmXf8CgJYUEwqtEaClqw84SNo4/IRUBNkArUNu36IrmrtvIikAVnMbwbSUwpRtxK65Ql5rjp4MD8Wy9KkhFVlQvCSJ8zb+qJV5MyNrTivZuL7bFDKFBpU5pYhwnGxDYaKRO0QtbH/SzmZraQXH6FLBhYQhnP/Zbp6wAhR/0X3uHNPUOtdCz2eyR2ynp1BAp7TuHE+oJ3tZV//6z+oTMq
X-Microsoft-Antispam-PRVS: <BYAPR12MB2678638B2CD381282A8A6DCBE5090@BYAPR12MB2678.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR12MB2678;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2678;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(478600001)(386003)(6486002)(53936002)(5660300001)(14444005)(54906003)(4326008)(6666003)(97736004)(25786009)(23676004)(7736002)(52116002)(7696005)(305945005)(76176011)(50466002)(50226002)(53416004)(36756003)(81156014)(81166006)(8936002)(106356001)(2616005)(956004)(476003)(3846002)(6116002)(86362001)(2870700001)(2906002)(47776003)(446003)(68736007)(186003)(16526019)(486006)(66066001)(316002)(105586002)(26005)(8676002)(11346002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2678;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjc4OzIzOk1obGllenJUQnNzUXV4Q3BmcEFNMktDSzV0?=
 =?utf-8?B?NUxZVXZhMjBmWVc4R1NQd3I5Y0QzZVlCOTZZc2NCYjk3UlBUemhPeStUR0hP?=
 =?utf-8?B?L2Rwc1g3dWNvSldia3VpZllLVDhTMzROT0hrREVxcVpDNlN6YkErbnM4TnJK?=
 =?utf-8?B?VFhuR0UvdGxrVWtEc2xKM2E0amdrUk9VQlRNV3FMVjgxN3o0VzBvc1lGN21K?=
 =?utf-8?B?Q1Y2M1pnSnhJelBxWnNxSFJvZ2xPelY4VEtsUDh6TG0yZGxKM1V3bU1oWWtM?=
 =?utf-8?B?OG5OVHVKaUlZN2lXdmkvK25YQlE1NjNEREh3Risya2J0NjB2VmNxZVBGaFA1?=
 =?utf-8?B?NENmRzdXUmRFZG1uNFAxeVprbTR1cmMyeFRiZE56aXhqQitnL0ZOL2ZQQzNm?=
 =?utf-8?B?ZWhBWnMzWDdubzcyV3dhNGdlQnpoSkRqdksybWg0bnVQQkpTWTJlMC9RbFpt?=
 =?utf-8?B?OVhub01BeC9DUWZrZkg2OFdCUzBESWQ5Z0dUYWc5b2gxMzRRMnZrQVE5cHlL?=
 =?utf-8?B?M1FieFhjMXpjZVFFQUJ6Q2RpSEZDanRzY3lmSG9DQVpaa1ZiU1Bac0RsNWEx?=
 =?utf-8?B?RTFVZThHYTBSMkQrdjFvTFJpZ3FCd3VDTEgvdVp0MzZ4UUxSSExtM0JYZFdn?=
 =?utf-8?B?cHF0OHVSMkFvL0wrR3E3UTdQd0MzU3ZDWTNJOUx0eEczS0M0WmFwVE5kTmF0?=
 =?utf-8?B?VEdNMlFHV1dkL2pocHFGNmVZSW9MTXR0eDhNejhYM2EyUjVvVVZoT0toVnp3?=
 =?utf-8?B?UlJmRkZVSmhsVm9ZdjV2ejNDNit0YVpBbDZ1cjgrSlk4aWprOElqR0VLN0l3?=
 =?utf-8?B?MHQ0SUxMYWEwcmI2bXFBUFIyRENkSVh4U2xyUXE1S2hsZGFIZTBDTldUTEhZ?=
 =?utf-8?B?ZEJnQXM0ZFhtNGVIZlJXMFU3RVg4cHduRmNacXYzMlBZeTRmY3I5Mm1uMytW?=
 =?utf-8?B?TGFWNUVhd0NyVEUvamFMQXRQS3hyWng5MDg5N1BlblBxYVBxQnpTN0JlZFpU?=
 =?utf-8?B?WENVdjV2VEZ4RjJ2d09KUnp5bWR4aEppd2E5VEhqNGRyOEZTRHQ4NEczZ0Z2?=
 =?utf-8?B?ZjJ0ZDMzU3BtNVdVclZnR3V3eTQ5TlMwTlkyNVJIWnYrTHgrR3VWMVZlUVhZ?=
 =?utf-8?B?NVFsR21wWkxvclpnOVpUOUJQRVVrUy9DTXRoNS9SYW1SMFhEVUpFQWRmVnJ4?=
 =?utf-8?B?amFQbkVGUEVKRzFLOThsUmpEV0piQW1FVEEzcWNGVFFseUVDYmdVMGhxd0dY?=
 =?utf-8?B?eWhwR3d5TG9PVmJ5RzMrNm52SnJwTm1XcDBmRFdzK1piVFlsclIwT3pmYlg5?=
 =?utf-8?B?Z0hEeVU5dFZncTdmditJMnEyMW1US3lOSURQc3VPZkZ0Q3RpbDZWYmxjZXVH?=
 =?utf-8?B?N25IblpMUEorZFhBM2w1a2lEVGl3aWNFbkozVTZod0UwaFVQOCs4NUFUL2s3?=
 =?utf-8?B?NVR1Q1d6UXRSU01UM01TcWkrVkRzYStSWXN4d3RCQkJpVHZpTEFubmlFcFVq?=
 =?utf-8?B?Y2p5dUVKNll0QXRtdkJBejdPZGI0QW5oTk1yOGpZREpmc2t4a0RsWks2ZzFi?=
 =?utf-8?B?TU9Wc1FkTTF0cXV1eWNSSWtLbGFFMWdxRVNRaWYvT29iWjdwUjZSQTBUeVBZ?=
 =?utf-8?Q?pzmHeBWWGYBc9h3RryLo?=
X-Microsoft-Antispam-Message-Info: 6mjp0MZW/Ig9uCwapv8IbyeXHe25STEaBvbaiuSb3MrV6+Qldnpxtc50quwe2Bcwq88hsRWeURHq63ixPHpsYxYGbBHGKDIl4xNST0i5rVITDWkqGVqA12gf9Mk7hO9MQYJXFlDhG+U6BM5v1ChPIPUqbN3w76IrzmlsWdGL4IvTyYhgyElLMm3fpICyHiY+m0ENGnTRUcXM4KW9RZ1IEGBX3MKQk9OyHQQdVxWV3KnrA/QdH323iGEp/3QqPzB7hpupa9wi9YK+qfcajarqFP/cGvc/CEiYr146vRiGIzeIzdIKyuUhXpSj9KJTIOB4ggYKZur7356G7KlldySvAT65S21wSEZG7flX3ppnUIg=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;6:A8EulXeeV2/mhkCswk7++v7j6J1Oi1hvr55+fGczl+0E/MVxhtprozy9hVZu0iTeQOrutiW3eaoOSd2o+eEjmp78/TuelnLUCoWRbyY0eoHgknW9kbLqM7FpV8XPeayufAq/+LAtOSQi9f8kb8bkYeYwgsLgobhDuTdTgVkrgMb1HnKpV/JIED2/KVbyH+sGGDuP1i2NNHy2yqyMfCbvhj5YRMHMPI8hchJ6vSEsGTWkHHMHrKsSa3WYjMc9bY1yCvSPfyltr7b/pQIG45CKlhxHejSwX4Ftn97J64Vth0DjvKTYkje+oJKq7VH5qMifcyxVfrttAA3xuSI7MIJkX4KWH3BpICU6jt7DcYb2HQ3cehVrx3BVAZTgdKMrX9YSfSB8rHvRKf7BcK0oJH7G+/fjwfhkRBrcqmM9HF3+s5wD0XSDAI1ZomwCojGkCX11Idq6H+hh5KUGmNDrNJipcg==;5:apv9ZXx2SmpyueocIFzMqFgty0qlXSyOf4IdQacG5R7ywcfUvvY8PhrR9X+mthYqGto2aJA4J+N+IMOEVxyb4y2g4WM/sLk1O+rWYJGfyRRa19It9c5iahwVVbREl5ysleRjmEcz8STOAkH7YGDJuJgLvxhZdyMNZPxTJuTyTLY=;7:iworNDA77F29cj/KCfYoluiCPumiTmC4hBwBtlfEmrZ9k08iM+G25/ZZ/Wfl9Y84971Bu+Exs7rr0xJKX1eMAy3fSAFLdIklZZ6h2lUYc7nZWrwA8c8yhP6dEMSYVkgovOgwTGbzWauJdvlPs0EsP4YwoC3G8ZIIVv3jG/GYuU5pQkCxDYvaW9QkUwF/RqCLwG+rPlDdL40K5zffdB4vRvE4Z8BNwfiu9LvkcXCVjm4vXBWdgumw4QVf8KnXvSyJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;20:vZhNwF4wk4aH/aUqeqaZ75dp4+ARRIpsXbMjvUgDl13Li+E8JrWpvJU/KT4iLp8+/rtx5VC6Sqs0BtBM3RfAp8CHsRE04ACIx5p6ifbEcMtGaXf556INTjq2BK2HHWV87bqB2aprH/uuJQhkKY4kZ7VUj2WolMSjNNud9HIk2U5K2UMEsjqN4WIl3JTdDi17OntBzDJydMGznKuyU1IGeskEy25QDK/Zkq5acvDSZMSV0mF49EjT2rz3PfOpaP6u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 18:24:18.5805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9d506c-300c-4865-fa87-08d60ddca2d4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2678
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
but now its called early during boot.

Recently we added a special .data..decrypted section to hold the shared
variables. This section is mapped with C=0 early during boot. Use
__decrypted attribute to put the wall_clock and hv_clock_boot in
.data..decrypted section so that they are mapped with C=0.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Fixes: 368a540e0232 ("x86/kvmclock: Remove memblock dependency")
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

