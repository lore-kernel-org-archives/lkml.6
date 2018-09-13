Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DD5FC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1484020881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kdQgOITL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1484020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeINDCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:02:45 -0400
Received: from mail-eopbgr730055.outbound.protection.outlook.com ([40.107.73.55]:51200
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728318AbeINDCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElXPdIzRry3jefJKe3SXomk21P4Ws/f+sdmwk0l0aK0=;
 b=kdQgOITLn1UE6XeUN9MZFzFS7qe24z7B0FS17O/XMrxKF+MMUceydLKcfvwRtuaBV4BZA6FvSA296k/D+Ui7dMnxa9R6KBj6HcwwKWDZlbaG4EcNNrjtOgps0MsyRBFDdh4nUNCKqVAXhuGgTgQT3cKsBVStLGvGxPEIuIer1OE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Thu, 13 Sep 2018 21:51:21 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v8 0/2] x86: Fix SEV guest regression
Date:   Thu, 13 Sep 2018 16:51:09 -0500
Message-Id: <1536875471-17391-1-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN7PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:406:bc::32) To SN6PR12MB2688.namprd12.prod.outlook.com
 (2603:10b6:805:6f::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83475af2-38dd-4a41-7051-08d619c30b84
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2688;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;3:eN5mCDMvkVTSypEMT8jP4RnN0arzNfx+Ip1VfYvkc92nFEcSorDnJQkIN0qN0EDFKZ4QbkbV86By7anJnUmgXLlqKKNPghka/LxG+yfAHkOWq4cKIJxeJa5RcL4zzgluc+LzViqlKnXlm4aW9iW1U4cvLPFdCPVrGDyf9CGvXzEpkXfYO5Xy4GcLXxXQu8cjgElkvxw4cjU3EGulko4lod2Djxt+zhf4OKFhqMhPVQ2g9H7vcVYRKIdlsjf11FTt;25:7MednQH6Rp9UXXU3viHiEQ3l7O+YtnDwpyftAktsR4OzD0Iu+Ib/rPmnZwXFx7FJGO4fLXCEsQMvU//BRdwGo22b14xDo5sV8nPjXGAzv6y2Lh3ecdK4SpRtXy9OnocFQ2BUhlZvDbYyHVJKPVrygVhcqdhq/JJDkTCTZ5ryYcbvmJNkZjI7EwiFu51VIn/3QwwKZWD2AuK2n2t/QARLeeBKWcHqwME4ho4y04m+fYT/KMmPHwFoi/ejRO2AeQLCTw2cKKaA6SvHMM+KWW5AREyq8fG5dP4MAU4dAYE3k+CQvTFHQrFBMbMsP6lBB7UC3rrqtuLeIfj2InwZNRZAtA==;31:uaIl8vlhAJChpHAgpubVUEUST+wfKHnNxdjvTNMxtoyv2w2Gie4AI9BESQrKd6qXNQM0Z2bZXOzPzKkGytIA8IN7bFuBxVEgI7a8wey772w0fAA7SYRgrq76ASfNSwfcAvBQBVo1qi/hPZqA/iGEcjv0VOG2qei5cC9vvHybEKd+VCX7Zo6LoKMJZKtmsEZZDhpK1haI1TvvxFMP8OE9KJJHVYW+tyCr/gaj7lGh0nA=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;20:ibgxXvWexq8MULH5oZtLz527d9Hxv/SNmGuxGv4lyGbxWFnau+hngCvvr234hHejOkmoGDDQ9w2zxeXEBYAYfKBTduQFySph8cphjsuHE6jFAaC3nVA896KU0mq7hHecc4qo0PisWJoZMtX4Wzv4NyravHSGWahe1qjx1zl+VAtWwBmKT4vLgg+AEbWuOl6EHIPWNWIFgQv2Z0R5GUZCr+LP8gONNXxDMkpXPLYaRwG5HQo14K9APsb4+uMUmAW2QLt2zdUywXrSCc+/wDdNsjDbSx0LKvVV365MAuDATPRyK8nrcXObpmwfTa/65WYUFqN1Hwwf5onNrKHRIysZwriSLi0zVIjZBqIbcG5xMWFWXWqKy5L+qCj+bmBY5Ax/Q2nYC/WJRNMLd+oZA6IJN11Pk+oXcjJ8qcFZbvL/NmIWTno1aY77uFqb4QzlFUkZY+crnkNTxqFej0WPNp/ma2Xw6Xa7hUG2TWQ0PgbSIrWj15gvVmUcs8gpmRdZ+i/e;4:qC64J0jKsxKSaE5YTgoFcWKL4I8C912V8woWuFycbJa0ystC+zeS1+ZXR2j2rPGOU5zaKokCnkc9A3Tg08hW9tzy1QXzMs30gpuVeaBU2gua0LOTJroA+SotJFm2B371ZfDzPumj7mQYTkSGp2wVOqJ3I24sEzgRFb62JHB1CHDUA5Seu3FTcPiinhWxo1WAW+jRM8SH7ehwCeqfpNUm5WPOR8DWeQ/xhyYwqBT9dnSWLGqYIu7bTYRwK1vdJXJPodFfMa4Fps8LKwaixRVqvitIwGztvUcuRqPb4coJHhWfYJ8f6hbuCs7TJKR/pBMmYV1tO4V9jc4dEagTz2Uh3twjTQEhf+QO/5uKK++v89C5EZRRkN/QZ659cKxWIg0UcwMLrRL6i/Ma69ca9nhB6f5OQM+Oj4FAUPfkXERJEQg=
X-Microsoft-Antispam-PRVS: <SN6PR12MB268874A8BF479734F95369A6E51A0@SN6PR12MB2688.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(767451399110)(84791874153150)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:SN6PR12MB2688;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2688;
X-Forefront-PRVS: 07943272E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(376002)(346002)(199004)(189003)(966005)(26005)(8936002)(81156014)(478600001)(316002)(53936002)(305945005)(16526019)(23676004)(52116002)(7696005)(14444005)(6306002)(7736002)(36756003)(47776003)(3846002)(6116002)(50226002)(66066001)(186003)(6486002)(5660300001)(2906002)(486006)(68736007)(54906003)(476003)(2870700001)(8676002)(386003)(25786009)(2616005)(50466002)(956004)(81166006)(44832011)(53416004)(4326008)(105586002)(97736004)(6666003)(106356001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg4OzIzOldFMW5UK1ZQdnFuUnV6UU9uc3JxVDBtbmJ1?=
 =?utf-8?B?U3l1RmtGdUJWVWZOK2NMUlZOL1J2NEpUSkZSYStvUTFwd0VLVi82S2pYakdr?=
 =?utf-8?B?VGlSeFRINHROYkVJQVAvUHRjZVBqU2sxVTBtTWVSTmFncVpxN09xYTlSd1RI?=
 =?utf-8?B?R21MNGVyRWdUczRNWjJadTAxbjNvK2YrSnFhMHlIRHRVRHFVSWJJU1ZhL0Zv?=
 =?utf-8?B?VU0xTmRLZ0UzQVB0ZHZuMFBkeXJCbkwwemJsTnBNOFlBL0RjUW8wUUM1V2tV?=
 =?utf-8?B?TEdaMFRKTHFWaVFhM04zejFiN1B3SHFEZnF5cEx4VlVnVG5oUjJkaFMwbURZ?=
 =?utf-8?B?OXRxeGdpYnNwQlBTdlZQRng2dm40eHNRcWprZy96SVBmQXJWSmNHVFkwdUJY?=
 =?utf-8?B?bFE3ZHVOTlMrYnNCQU1aZEFkTE8vU2FmbGtlcW9uTjhLeFlUeEpNVWRBZktF?=
 =?utf-8?B?RzZLVXRKV0tTaWEzL3l0QlhTbmJNUjR0dG9IN3B3NmdhSDl6MmZlaUF5QkxF?=
 =?utf-8?B?WEhQb1dCc0VEWnR0ZlgxYzdySEFZTUIyeHpOUmc1Ync1Ujg5RlhqcS80U2p4?=
 =?utf-8?B?bU9FMXc3dkU0RDN5cWxsQzlSa0ZpbzJ1R3IzTDM0bUR2QUlmZEdoM0hTNTQw?=
 =?utf-8?B?NHlPbmc3YzQ0N2tncmkvdHkvOHdvR3NMbnUyRlB3QW1VZGQzN2JvNk9SdHY0?=
 =?utf-8?B?dkhPZElaeDN6QWVTcFZ6dzlwb29Bc2FxVGxpU0MxaVE0Q1lPS01JOVJPc0ZQ?=
 =?utf-8?B?dmRFbjFhUlUvUnkzMGRRejY5UjhJZ2xyd2dhMC9na1ArZlUvZ3Fodkx4Zi8y?=
 =?utf-8?B?QjR3SkRpL0tYTzVNbU9JSWtUT1g2Si9La1VVajA1NDEwVTlTOHFRTEFvVDBJ?=
 =?utf-8?B?TXFvRS8zeDlTQzYwN3hWMURvT3ZCVDVIVWsyMnNBOTNTdW9ocmltUVF2V1hu?=
 =?utf-8?B?WXFrYmNnVHdndkRjeG9zcEVKSkthcXBYekY1QlFzRWRTTURWc0R2T1hJcXZk?=
 =?utf-8?B?cEZEemJKNzFBU3EzeEhWSjBldnA4TXpyZHlGUjAwSW5KUGFCTHdXdGlPbGFY?=
 =?utf-8?B?djhrMzFVQjc3dWZGOU5SZDVZdDliM3RycVNsaTZTTENzYjdTVnpKUjNBS3Zt?=
 =?utf-8?B?d0R3VXR4MnNuOGZvQTZWWUZzcGxJWThIUjJNTHRwUjZTcHU4dHQxNGc2eEtX?=
 =?utf-8?B?L1RjaDNIaWtTNjBIVjJZa3pWQlVEUTRGMldJZzIxL3ZrWEVVUkxZU2s0SUc1?=
 =?utf-8?B?MXNpbFRpdSttT2JVekNNTW1Xb2xQM2Vra1l1M3JXN0J2T1A4NHpJc1ZNWm54?=
 =?utf-8?B?K3dBRlRlQUMwZmx4UEdnWWk4UW5UZ0JjY0hJU1BLejN4K2FQTVhKcHJmNmxU?=
 =?utf-8?B?ZFpXVWE3djZVam93aGk4bE14MGRvQjd2MUxDWWJEbU56U1hGaFN3YlBlQVNw?=
 =?utf-8?B?T2JlZzUya1c5VVprMG5Lc1NncjNHb3lRMmFWSGo2OFRvY3JQY2I1OFkzbGFm?=
 =?utf-8?B?SkNVNURka0gyWGNka0YzQStHbFBhMDFKc2trZTNESTViSUhGNVpTRVI0Rmx4?=
 =?utf-8?Q?DA/nWR12Zf8nzUV3y4SCcICjvKih9uLO1/YQCTFGqtb8=3D?=
X-Microsoft-Antispam-Message-Info: wanlMvhLoAfnlm3Pjw3cQZU34u/KJEhyVIVsw96/QudDrXz/oTida+E/yrdatZLujHjcuwf+XDX91kOMdj/hrvBzj4tWW1qr2dngxEs4/E+yK6oPwDujceybcGDpfH2dnjQQRSBQi2qOauj/yzZsRCGQLv0/8ndTkPcXcyjFpV8wftgU2gqZnGmepSoM+DBqGa39VbVEy4eRL+kA0Kvk4MQQSzNgxxt/LNhhMnhB5ajk8M/YakWd55a3spupkizu8+6ig886BlZhtvVckOlAqJF1IENUaycatwB+gGaxwwHE4PAyhe/m6l9fzym+/Qf6h2IL5Lm4Kg2/1hbhk5Zu9l9b/X3oqCWucNiCVsV7gN8=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;6:zl2PAfqY6f35T9xQk7jnrs/fstuw2jQkWGi/n23Z+NFLmMV4N1a75iEy0ON+UzME3glbk8ZlFzRqjhu270ZzmIHb9M/UAkihdp1DgY73ZaDpLQQtobqYy4fXH0NhiBrHRlz979c8Xjneyr5GQIloLcYYXOzlE56T3x56EcmDQ6LOAkENzPOF7KIQCoinRchOoRfQTe21dvxY7qqJF6CWob8ZCZpGaIHz+b7x+OxNtaCBmdfUWsnfpffE7ryYmcCkkyiuuCWR8akxlX5lZgmBqCxBWVyuDllm4CrQOiuWFP+yC8vkwuDxSh3a4FmGuR1HaAXzOQWo3JH7RzQFNoOtEuqU8ljMST8TRKcXgo3Igx3K6FZ0Z02hZaiHWcagWtx64572uEiD+Gj5Jf3GsC5KlzYfhmlZKRVhyWQpJLdWbvDOWKYv7TqI5DsGbD35tpJSE4ndPLWiSKOFPlFBw7Bqhw==;5:jEWuyk+tqrz35h8z55O98enLPSInCeum29xQfImkTCZIbyCUORCmm2KK05Be0mJNdvb6stJQI8GQ10+Bn0v5RGK8UsjyDxcJT8G9gZyooKauLsrPudbGybqBh7lPXoBeU8wmp0i1rAWIAeSWOvY6unbZFB7MpBFRfmAhaWMo2aY=;7:fubeYM/48kyub3ue4pNyVGniCl7phvXJgq6YaIUyAhzqhlp8iUwEHxYtq0vSf2p6MglQ0SBCKrglRVBqRNVI6VAS3I1+7QdAueG6zO8v1BW+zVaRrlCkbk2OSjIiJiUYaXqADuz8rKiU9JoH9XGiSEi5Oj4jHMKXOBJ5dagxOOFelKVlOcI+iujFo+R+ZrcZxAzuQx1cnOisomeQuk0JYN8ZGsQo+y1Cb/nzxItwJOnNc8CagySoFJcnkf94reOo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;20:PxoOYWGTgNaUye2n8Tz178MdmeuhFPvndwRAJb6i1UuhTGrC7WOQljYLsap0JNwKYE6VH2ie7O8AVgcsoNOVTNjaRhwsEmrxFeK9BSRILTy6d/vwNRFntuMVxBYnABxL33Fq9gQ0Egy2eGnU8pY6LXrrrS3Qkk7sAwl2D03yGUQFNyOwNe49q1qMiYawLIi9TkQs7GLob/vF83ca2M/iI663xyfKGSO5BaxvYldH4ICugqX7UI4cPBtH7DEHZmAp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2018 21:51:21.1722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83475af2-38dd-4a41-7051-08d619c30b84
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
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

NOTE: Since there was some design changes based on Thomas G suggestion hence I
dropped Acked and R-b from Tom, Paolo and Boris.

Changes since v7:
 - As per Thomas Gleixner suggestion move the decrypted data in .bss..decrypted section
 - remove the second auxiliary array from SEV case
 - allocate memory for pvclock data pointer early and map with C=0 for SEV case

Changes since v6:
 - improve commit messages
 - rename free_decrypted_mem -> mem_encrypt_free_decrypted_mem

Changes since v5:
 - rename hvclock_boot_dec -> hvclock_boot_aux.
 - rename section from .data..decrypted_aux -> .data..decrypted.aux.
 - use NR_CPUS instead of random number elements in hv_clock_aux variable.

Changes since v4:
 - define few static pages in .data..decrypted which can be used
   for cpus > HVC_BOOT_ARRAY_SIZE when SEV is active.

Changes since v3:
 - commit message improvements (based on Sean's feedback)

Changes since v2:
 - commit message and code comment improvements (based on Boris feedback)
 - move sme_populate_pgd fixes in new patch.
 - drop stable Cc - will submit to stable after patch is upstreamed.

Changes since v1:
 - move the logic to re-arrange mapping in new patch
 - move the definition of __start_data_* in mem_encrypt.h
 - map the workarea buffer as encrypted when SEV is enabled
 - enhance the sme_populate_pgd to update the pte/pmd flags when mapping exist

Brijesh Singh (2):
  x86/mm: add .bss..decrypted section to hold shared variables
  x86/kvm: use __bss_decrypted attribute in shared variables

 arch/x86/include/asm/mem_encrypt.h |  7 +++++++
 arch/x86/kernel/head64.c           | 16 +++++++++++++++
 arch/x86/kernel/kvmclock.c         | 42 +++++++++++++++++++++++++++++++++++---
 arch/x86/kernel/vmlinux.lds.S      | 19 +++++++++++++++++
 arch/x86/mm/init.c                 |  4 ++++
 arch/x86/mm/mem_encrypt.c          | 10 +++++++++
 6 files changed, 95 insertions(+), 3 deletions(-)

-- 
2.7.4

