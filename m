Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E0BFA3721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE72A21567
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE72A21567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeIMWdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:33:09 -0400
Received: from mail-eopbgr710081.outbound.protection.outlook.com ([40.107.71.81]:28608
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727417AbeIMWdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M2X7XlZ3Ivm2VxqbFqtRhTEgWstRHvITGztqin8C+E=;
 b=vlb9P7W9wEg1Vd/ycI4F/LD7mGKOu5qwPL5wQMubU5o2swbKeqVLBu00NtlKeUyJSIc1Lxs77XZ5o9d00yMWzzgDJZrjR12V7m9sfKcDuq0E0KyWmzZwEPOk4JQhXePCkUugdD9Q9nazxZlPjj6mDXNO4osOAviGwPLl1NFRM0U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:6f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Thu, 13 Sep 2018 17:22:38 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v7 0/5] x86: Fix SEV guest regression
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1536616151-16738-1-git-send-email-brijesh.singh@amd.com>
 <alpine.DEB.2.21.1809131622180.1473@nanos.tec.linutronix.de>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <43c95311-dd8b-77c7-0949-28fc3f961bef@amd.com>
Date:   Thu, 13 Sep 2018 12:22:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809131622180.1473@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0125.namprd05.prod.outlook.com
 (2603:10b6:803:42::42) To SN6PR12MB2686.namprd12.prod.outlook.com
 (2603:10b6:805:6f::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac7d99a9-380d-4bfe-e760-08d6199d8118
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2686;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2686;3:f4OaxHe1kaYnQs6SeeYUAhBtmoKbghGpbj/htQJ9b3AAdv0PSWadsFrdnRlBBWluJmVhYxpsP+AWaD5jiR1bsBccfh245/aFIB8YDOQC4c93CqcugddUWMVT5BkdUJpzBhA/9qkENjL8uhgTnV7gxOuNs3IgJcWSCm1Ej0gPV98xHHZWnC49KDmvL19XV4r4sZ3uniVKWaDSmmaR60mip606FdI0rEfrbcMIOgv3O1LOxMvjNlONy/Obiy4eoWIO;25:+mRPb1uHCcsKXcd82NswVHFezwaRnuHfxkS0wi9Br4rX0+w/XAQ2qU5M6cceSKq7+scXBkkABucLCflJuAQVbZrlFo7ZW7a6NCyrrMBW2rlLNetmrDMQVLVI65SJgSwkTzKwoDHtXmXxpPsPZsFFKzZ+9ShspfwriCJutBhVW0vQ6Qi4n8YhJtYDc4cyAJpqLlxP5fd+KAkbTt7GfAMSEE8NVnSUcZTs2Cp81JyMf+YuWv237RDlE4ATx1fHSO3RZ6rYze221nUnGVYx7+Fd6e/7Lspe3P8nqAk2odWpg3QMmW3n+nBV6H1P/Nz/2U8thpYcjzhCqp5o64Hdfl1l/A==;31:Doxk0NzWQiEKg81O0gnP4GjpVBiyYPzSg6n3a+D5pU5WPddjAB1bO780iFslwiyNjZAtWFGXF3evioiHvGFT6KWEw/MCBzIEKjKkAEPTIKxCw0b0Qe8t49Y/PDv6XoXCymPnClsps4MbQbmLert2/ZE2RjvRRmTPH2nPcYiCh2dpxuGrCgnVOXhdCsyppkJ3kcD65rqDbh+3YTD2SKSIAgGvsU9gCHW7J/9ZyVs95W8=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2686:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2686;20:T6soZykzKckL+Y/yuCDUpvob6EqaCVXDpUVGlj6kmbyUtlRerW67GrUateE/DIUccFeN+Q7S1zqR3izWI2ntTDptBmmJFJ0cux06CqwmGlxKtGrMcGIaHgHE4sp4v4RvpTiJDzP6BZzjBQ6WssU0EN32omp9ZxkuZLTA41by/FZ0uAbu7IQ6QJYK7umSWerjO6713p11fmyHYEP5rxDZsCG1Puy88l+YXfJ0eTeK7X/JdzD0osQ6V3Jlk60u8+VsBE8HrwF50uJcDhMJT7t9nRC1vr3pDT0db79XumqYrpZAU0wlGA1NtLXuh3VDcAst/a97Vp4+BwYXCC+k+jguRMh6RNPhLCRRPZJ2jcwZcEWxHpAP0+DSrr1a1TJnamIF0lG78dDJ7oYs58xDXS9OniaDY1SkxJb6r3fzvQ4gvw9pFcSj0PhI1HfLWHqzUXTHTbJ87VxoHAw1xhVnOPFjyaPjU9d1fQtaAhrXwYoR1GUs60w0NqwQrdeDSr9VbcOe;4:Z5mgQnhWG19W6sf1dQGagFBxWtYVTFsVRvUx/3u1qHFj48Y8LjAFRJZxkYwQrhWk+7w9TbIeiu/PaSgEtfDRz3D/HU15KRUvF6uSIiYrj4JV4a9svuTYW4IfMxt4TvN7lGsZxNRG9qdlb91/I7EEg7gRkR66ZSk9uem+OrEmsKAFY9GPl2pJSLL8Ab+3/b27cENDyFyYyDrPjRl4+U6hBX1JIKvv5CSLaNw/gGaGXKvPuZ+HLWukTii6dgCrNcoE2dYF8OiphYoW/++YxNh0AQ==
X-Microsoft-Antispam-PRVS: <SN6PR12MB2686D7DE3A0FCF8FE86885AEE51A0@SN6PR12MB2686.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:SN6PR12MB2686;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2686;
X-Forefront-PRVS: 07943272E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(136003)(376002)(346002)(366004)(396003)(199004)(189003)(50466002)(31696002)(65826007)(106356001)(97736004)(6916009)(68736007)(478600001)(561944003)(105586002)(44832011)(25786009)(8936002)(52146003)(67846002)(36756003)(6666003)(23676004)(86362001)(6486002)(2906002)(2486003)(4326008)(229853002)(76176011)(16526019)(305945005)(54906003)(26005)(52116002)(58126008)(77096007)(8676002)(53936002)(16576012)(186003)(6246003)(316002)(7736002)(2616005)(956004)(476003)(446003)(81166006)(53546011)(386003)(81156014)(64126003)(66066001)(6116002)(3846002)(14444005)(31686004)(11346002)(65806001)(65956001)(5660300001)(47776003)(230700001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2686;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg2OzIzOmg0UHhhaWxUYTR6TWFqN3RCRkRick56bXkz?=
 =?utf-8?B?cXJGNlBjOCttUEVqNTBJM3FTYUZTalc4NTBrRWVHNzhVRVJqL2RhWURMQmVk?=
 =?utf-8?B?R3c4R1FsSzVMeUlVeDhWdldUNkc0cEwxdktxSERIK0lOaGF3RG5SNmpBRXNr?=
 =?utf-8?B?SmV3TGF4eno0ZnhQRVVyYkNWcWh3R2l4ckZaUCtpU2NCRVhlaHcxK0k0S21K?=
 =?utf-8?B?N2dzbWVuSFpOQTg3Yjc3V29zWEpsN01RSCs0d3BBamFmb1dTSWhYL2JrdjRP?=
 =?utf-8?B?eFUwSi9CRnNkMWhlcitvVHlwaGlydFJid3NLUDdSMDVMQUxuMjNCNUxiNDhs?=
 =?utf-8?B?OVMwMlZ1dG9nN0VjcnRta0NpUmxwaXBNaEgxdXpETmhvbzl5c1A3amZGYjA0?=
 =?utf-8?B?aG9mdkFjUWhuR1FOalIvT1VwRkFFOE5UNTlSdFkxS3hZcFR0WXp1QU1obnB2?=
 =?utf-8?B?cFpRNEVDS1l6ZnIrTXBhdCs2L1liaENaUk9QaDFqRTF3M25ZSWl4Ukd5eHVF?=
 =?utf-8?B?dUxLWTdjWXlXaHR5M21oRUpMQ3paL0F2RVNMQUdrVE02T0hlWm9ZTC91MjA4?=
 =?utf-8?B?b2lKY3FmdmVaNHA2bTc5UlY1U1h0QytmbExKellWMk5qV2xZVlNjek0rSWxQ?=
 =?utf-8?B?V3NLaVpmbkxMKzFVbG4ydEVrenVoNG1yTytJbjA4eXd4bzRWTHR0UEw4U3U0?=
 =?utf-8?B?Syt2SUNRdlp3aEl6SExvR29aVTkvTXNoczBmMGk4bVZpblNZQVhxN0l5Qjlo?=
 =?utf-8?B?REdwYkZWVTVvZWx3U0h3NWZwWHhLd1AvVm1zdDQreTFvdVQ3M055NzNNRlhR?=
 =?utf-8?B?Y2hVSkFmSjNzQkkwenhjWjNRdUF4QjJSTWU0bVdWekY4U3JQL1hHZUNyb2xS?=
 =?utf-8?B?czQ2elVBT29pc2NOcTBzQjBrK1orN2NvcG1MOTVYSGkraEZGK1dYaG44bWhS?=
 =?utf-8?B?ZUNNYlFhNW1XeTAwSFc1Y29zVGJhVUg4TFY5UmtKM1k5ZUpzbnVLV1dDRUxI?=
 =?utf-8?B?bFRxNEdnWE5obWN6ZTgvNHd2b0k3VXpzUFQ5UENUd2RReXE3M2dDS1BQSFR5?=
 =?utf-8?B?V3A5c204UVJGWHVaZkNZZ2hxUW1idlhmQnVHM002RHVvRzJxdld3QTBBTHZV?=
 =?utf-8?B?alBiNHprdG45bUJTZldIZHFhN3RGQ0hqZ28rWFIzdW4wZDQwTlU5eWRueU1M?=
 =?utf-8?B?K2JhSDJ0NkYvVjFrT3RUei90YmJqRmRSTXE1Y3ozSCthK01sNmczNGt2Y1Zs?=
 =?utf-8?B?ZHFBNGlhQnRHaWxUWG5wTDd3Vi9tSTNhSUFlTTNFai93aDdDQ1JYbk1uenVI?=
 =?utf-8?B?NXp6clBpb1g2UEFnek43cVpXQ3psamx5K29FOTc2MXNKVktOWnBvL0RUd1Bh?=
 =?utf-8?B?Z0h6RW1GdGp2QmRkRngyMEV6U0p6QjdBNEtkSkVGc0IxeUdtbjNhS2s0MHRR?=
 =?utf-8?B?bGRsclh4V0dsNC84dWZxdWpXazE5QU1kZ2l4S2RpNVQ1T05yY3BaODB3QjFW?=
 =?utf-8?B?TWpLdTBrTGUxYk5IblQwVXIxemgybWo1TjBiZTJOYS96eFl1K25CWHIyaFFQ?=
 =?utf-8?B?amFKRHlZNWZ4dTFXTEUwbG5GamhtbG5IMWpKUUdXNzlLL2dVb0dOSXBXVURq?=
 =?utf-8?B?K0RwSDFEOTAzV3ZtektlQUE1aGF5VVpnbnNTMHFERm9oTU9QVUc0UVo1Rmlz?=
 =?utf-8?B?K3o4VGZOQmFkNm1GbkhnMW4zbjFTUDNiWHpKd3N0TENYS01waWU5YVJjK2Yv?=
 =?utf-8?B?aHdoL0plOGNGUWNUdUlIUEZSUjBiU0xCRzlSVnZUZnNzc285WSt4U3VSS0I2?=
 =?utf-8?B?UUZCcFgzaTN0T3dobDlVRFRMa1JPQ2tIRC8xVldMWHlQR0sraHhMdjY5OS81?=
 =?utf-8?B?N2VLcWhnbSt6Z2krbkVrVFA2Mmw0eGI0dy93VnNGWGVvTUZTOXFNWjJaZVpt?=
 =?utf-8?B?VnUyOGg4Nmt6QmUzdnBjR0lNUm92NHlyTG56b0NISW44bmhoQ1J5SGJNYUtT?=
 =?utf-8?B?c3MwM21jUXhSMVZBVTk4ZlpaT3NKdUVoV1Vra01iMGJRdExlTGV3SWdnb2Jn?=
 =?utf-8?Q?Upl8=3D?=
X-Microsoft-Antispam-Message-Info: InwO4GuCAoaTkky9NdhQdgL2UxjQWg/F1uC58wsh7lvuxi+/ztQT34sdkLFvrwLT4vwiKUN/lzMYblGNjwAY91pxd7eoMGME3KxsGfUlneudIXPsDiLpUrq18Xs+4yGg8SSeAfPndlZ1p5GkjUd4iaOQBqKZ2dP8tBak+IyZ1eVrK7To3gg86qUbZqBhoFHqwopSILgs16XyRyGN6G9RjWskJgbqWzrUqbGoCE84LIJfk3QpfXQsrYH7X+HI7d6zWvoxST52wlwxRHe2Za66dnI9DKLgsf/CzBJHhM7POGDi1dfMF+ctt7zHkRIN4YoIamrzCPRP7Dzn/VMAjJkHiE+zbiElMPnwv0uvERalZQQ=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2686;6:N2o6kGDO9cl6xgwFpKrO4WTTkJy1n9O53s//DyOL7EIYzYlxODZCMA32Q0YLLabgT3kBpdIPsxilWcJWrkkx0niYYwqYX7mxNHJabSHs3xGNJUyJsV+iBd/jENWy9JCZm1x5u1IGvWlffpIep/JidgOXVD8pavQRevRDcse93PnMv/3kbRCjSMWNIyIoRGQULdCG78qT337xfHhBlEx56Q1IFEYD8uiwnTxXVVFfHMKPUBpceYAVyO8UbANh6wdpllFts5/S1ZsMX+o7VG9eVxcYl+2/7iE5yxSy5eiFcRxzg3smkT9b7ZPBcnd7Tz2VJ9STW/FjJRxL7eWVZgsAh81ulHsTS0zBEg3/3mLQmrh0qkdA02PCmhx5QkfLmGN5ApMc6FhN5Fo3qB3RixjqhqgywNANJbcXIBDgYm/FiZJPZhe55mOsGWnE2iVddG7VJm15EJF5vvdFoA8/EUmnqQ==;5:+nnTIWsk5Wdy6ya9GatLs9ye6Ug7MVT3hAj8LQuwWj1/p74uKlJyeNghq+Nwqn2ZebFnG4C6+hZe4S+YMl7n9nrq4+TEx+raDYHNIVSi6u/8FF25lbiNef42s4Bn4ADgtJ3UMAGFNUHvn4w7Urd+MbiqqDpvtVfACbzCODSnb6Q=;7:NVVYyA8Ehx6HwEkvn1K25L31kzvVxAlNPZiKo03PINBiA3TdP2hN5K8ft3W2hQakC8VNNAlKZBMMvSOIVNVR7IETap7Mq28Xx0oHatEGF6nxnXoi+6JCcDiWyVAohZrXr4FNWSQdn9InCvoI9rbLTcOP+QpZOdqN7sTcA4LYhdkQU6AIMBzzvx6kZ2cVZ7HZNORZMQw3P0M0AYcvvyf3igV9hmEX3IM5pdH8o06gCe4GHGgYLXlVWGOIYW+iZ5id
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2686;20:I4pS8a5e8tkJ+6vmBiGc/WLNpUL7pEYFWefOKZPXsvSDrBsQhIOHmi9/CNqQOA48f7/BLXwNSSdDyOQCtaZK6sqIPkFAf7JQ2R2hVWLE0VXsxlhRuqpA+y6/vtQmCECaNfHaU8/mtrHWqnCZQ93pKs2Hegd9/XUCW3ZJffVZtP9OganemWd8AllD5YAGYt74bVArhDss4hAgmylh7j1hIUUJSVtXw3JUYBUlvhvheaA9fQPyJYvdetdpquS4lWBv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2018 17:22:38.2519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7d99a9-380d-4bfe-e760-08d6199d8118
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/13/2018 11:22 AM, Thomas Gleixner wrote:
> On Mon, 10 Sep 2018, Brijesh Singh wrote:
>> x86/kvmclock: Remove memblock dependency
>> introduced SEV guest regression.
>>
>> The guest physical address holding the wall_clock and hv_clock_boot
>> are shared with the hypervisor must be mapped with C=0 when SEV
>> is active. To clear the C-bit we use  kernel_physical_mapping_init() to
>> split the large pages. The above commit moved the kvmclock initialization
>> very early and kernel_physical_mapping_init() fails to allocate memory
>> while spliting the large page.
>>
>> To solve it, we add a special .data..decrypted section, this section can be
>> used to hold the shared variables. Early boot code maps this section with
>> C=0. The section is pmd aligned and sized to avoid the need to split the pages.
>> Caller can use __decrypted attribute to add the variables in .data..decrypted
>> section.
> 
> I went through this patch series and to be honest this is in no way -rc3+
> material.
> 
> I really have to ask why this whole change to sme_encrypt_kernel() is
> required at all.


The main reason behind making the changes in sme_encrypt_kernel() was
to perverse the initialized values (if any). Since we are adding
  __decrypted attribute hence I thought it would make sense to support
the usecase where in future someone may use this attribute on 
initialized variables.

Now the question is, do we really need this to fix the regression? the
answer is NO. Since there is only one user of this new attribute and
lucky it does not initialize the variables hence it is safe to move the
variable in .bss..decrypted section and memset(0).

> 
> Lets look at the problem at hand:
> 
>    We need exactly TWO pages to be shareable at early boot when the
>    kernel runs in a guest and wants to utilize kvmclock.
> 
>    No, we do not need the whole NR_CPUS sized thing at that point at
>    all. The secondary CPUs are brought up way later and there is absolutely
>    no point in having the ugly decrypted..aux hack. That conditional freeing
>    is really horrible and prone to break sooner than later.
> 
>    Further the TWO pages are BSS pages which does not require to handle them
>    special other than fixing up the PMD and doing a memset(0) on the
>    actually utilized TWO pages.
> 
> We really can enforce that such decrypted variables have to be in the BSS
> for now and revisit this when there is an absolute requirement to have
> statically initialized ones, which I doubt we have.
> 
> So the way simpler solution is:
> 
> 1) Add a .bss..decrypted section which is PMD aligned and mark the
>     kvmclock hv_clock_boot and wallclock struct with __bss_decrypted.
>  > 2) Fixup the .bss..decrypted section PMD in the SEV case at the end of
>     sme_encrypt_kernel() and do a memset(0) on that. That does not require
>     any of the restructuring, really.
> 

Somewhere during the discussion, I was asked to make sure that
  __decrypted attribute can be used by others in future and don't tie it
with just the kvmclock.

To fix the regression we don't need to have this complexity. I am okay
to implement your proposal. I would like to fix this regression sooner
than later ;)


> 3) Have a function which is called after the page allocator is up which
>     does:
> 

I am glad you are pointing this one. In my initial patch I was doing a
kmalloc() of page-size, during review we did discussed to do allocation
once using num_possible_cpus()[like what you have proposed]. But then
discussion moved towards saving memory and that when the secondary array
concept came into the picture. Since .data..decrypted has some unused 
memory hence we were getting creative in reusing it.



> static struct pvclock_vsyscall_time_info *hvclock_mem;
> 
> void __init kvmclock_init_mem(void)
> {
> 	unsigned int ncpus = num_possible_cpus() - HVC_BOOT_ARRAY_SIZE;
> 	unsigned int order = get_order(ncpus * sizeof(*hvclock_mem));
> 	struct page *p;
> 
> 	p = alloc_pages(order, GFP_KERNEL);
> 	if (p) {
> 		hvclock_mem = page_address(p);
> 		set_memory_decrypted((unsigned long) hvclock_mem,
> 				     PAGE_SIZE << order);
> 	}
> }
> 
> 4) In kvmclock_setup_percpu() do the following:
> 
>          if (cpu < HVC_BOOT_ARRAY_SIZE)
>                  p = &hv_clock_boot[cpu];
> 	else if (hvclock_mem)
> 		p = hvclock_mem + cpu - HVC_BOOT_ARRAY_SIZE;
> 	else
> 		return -ENOMEM;
> 
> 5) Unconditionally free the pages after the used .bbs..decrypted variables,
>     so the unused rest of the 2M page is not lost.
> 
> That should be a halfways slim sized and non instrusive changeset.
> 

I am okay to implement and test your recommendation, if anyone
disagree then please let me know. thanks

