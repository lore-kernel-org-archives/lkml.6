Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC5DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0740020844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aCL8KXFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0740020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeIGIgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:36:20 -0400
Received: from mail-by2nam01on0080.outbound.protection.outlook.com ([104.47.34.80]:5760
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbeIGIgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdVE+E5IM/oD0LnUr07/9yg51nMCk4WIbgvp94tnh/s=;
 b=aCL8KXFE2ZfyMhWrG6FgqttyaNDGtIZCcwx3ufooakP2AyM6xGuMlZhlBCP9jPtqPYReqclCWSL32+CyFcQajx675N+MZ6xJ+1D3TAsKBkpe+uL+ahlXhQeyO6IIH0Xvy9GKj0OLAeqhjdOVzaWOF2x9uAsV5rfzL04RzDIphzw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from Brijeshs-MacBook-Pro.local (165.204.77.1) by
 BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:69::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Fri, 7 Sep 2018 03:57:20 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
To:     Sean Christopherson <sean.j.christopherson@intel.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
 <20180906140738.GA370@linux.intel.com>
 <9b7ba5a6-5b2d-206d-46f0-32e0dbd2af70@amd.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <db1419dd-97ef-fdf4-0ab1-7831c80aec78@amd.com>
Date:   Thu, 6 Sep 2018 22:57:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9b7ba5a6-5b2d-206d-46f0-32e0dbd2af70@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:805:a2::20) To BYAPR12MB2680.namprd12.prod.outlook.com
 (2603:10b6:a03:69::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afe5f921-1284-48c9-0a2e-08d614760356
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2680;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;3:/AMfujSDUqANPJivbrctAFes6LdAXwul0CIkfxEnAKL4WfCxhf33Dkm+0Mb3Cz5RzEwQpuQnSxlDVOSDGB1bgnR1N8Sewpr2y9wc2qce5PCAtA0gxK7aUYSnc6zH/8ozz/HEq2ohbuDqx/fSJqZjoH5w7itFsgE4zx/Rzm+uuhoX5dVnE4IlhEkAv90QyVe5/n8+mF5dEkDD+2Xj+Kv7UgPae+EX3kCZ6IIvSgr02yu/xiDkYXRq0Rc7C74XzrmE;25:MC50x4BXbzcqg+boEyhiD4JVTKf6HzVq3nCdFQ7az0kREeTO4pKKYSS5kgauEiGrMjDS6yn3uyfaZfXXIyqaoGMDkksVPyn5uFrGOtP2DQp8ikd24kJNfYhqjeMdoQP3oqrWKvGoIGHdP33H8/TMMF1W0bage2e9QvVC+7b3pXEOwXC9yWjU0l57GjAn87I53K1v6yr6LWRStT1HMw3gwcKnEClQDXApXUxR6wkSFZUPzexLg2+prfw378HJpHd/8QbCu9j4lNzEN42vs7/S6Q69Q+gY0mMo/wjQUKX9g0G0arXtEsl2DRIFZE0/FIVkQ2mxi+aoeDJacbRjkZzXAA==;31:TrYm+2lTr1Rw6Y/M0erhikMtUkF0DXPdWVBoyZYMnGHe+oTsIx7Sg1UX/BJ1KxnxrmKGWWQM8pId5SWfhCGGTp7GY5NSeLh9BQfqoHCnamLDnNXzch6YHhvtYy7/rmn2iljISdCzf4bh1Bvt4hG2JB9FGYBz1/CnPlzAIMU5F3JLG6mijYKDqzQv/KWJMi6lr1tPdfHCUUkqCWMoQL4u3k1ODNV7EFKqDqggRoV0eu8=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:qx3S0G83LUuOxBcfi2Okxwt/l6hFYcdMrc7BIifmUZ8lLF6+cNqn0gVxWZeZkqeWT3QGRNC0QNMDY3b27gziY1RUduKITzXhbtdy+NQwiwWRFH2++zjHs7eU3hFLs+J8WJtbF7BNmtdn5dbZkts7xKSjwvaV13A/KxBEbIqxV7dqjWhf1g1jI/RWVAENFVMFtU1+hky7gOWWDrt++e6OtdkA+vmYCAlQsAM8QCxuM1dmeh2Eu0ohSHafUqaL+JQC6jjjOhdkK/U3FFM4u8+coGbvubt7X8af4j2NSdUydcBAyUPkT4jQC7QZC9IvkfxK06jtKlAxxJQIe1VixYDvPQoNrZIiGBvEpwTyZtIEyHWmy+6mh3ATDhrSG+DY6OJjfDEyzJsvC+NrIqGbdlGaoE0C26FMhAR/B8yY9Ie5fL8NDKxdU32h0+MomlTOyiY442vS8JKX4Li/lI0mCFVro2f0AeSxkzTUMceGzKzS408BQ48cbpxb6ytDe+xHyK/P;4:qxucEwoCyFQd5TVpUYXiRUMaSiW8+3RvPTkea9q1Ik9Zmt2gl5+buFgf6GXTft91ZFEtE0FEkUidwF4LMRNn7bzcj5vjkHp3KYsijPrWcC76DZd0M2fFbLuqpwARTws1Hm98bgud3F6O1/e2AG5bX8p7VgYNs3LJ2ua95rX084WCtt1bH8F5QEqcE2bsuRVoJ0mJ0fpbQELPudEcovwhZGRU7pSGppzGkE2ovMMSwdjl8+zQRsxKMhB/ZbpMpfvNBOhLAfCyd1cUkyaErmRFUS77qmtnwdh+6kibtCuZjfYiHdFOTrZ+RGSUH5L1ePop
X-Microsoft-Antispam-PRVS: <BYAPR12MB2680E296227E9173E86DCF60E5000@BYAPR12MB2680.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BYAPR12MB2680;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2680;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(446003)(64126003)(53546011)(26005)(8676002)(186003)(16526019)(6666003)(31686004)(6506007)(386003)(25786009)(68736007)(50466002)(316002)(2870700001)(4326008)(81156014)(6916009)(54906003)(6512007)(58126008)(105586002)(52116002)(106356001)(36756003)(81166006)(76176011)(23676004)(2486003)(97736004)(44832011)(5660300001)(229853002)(486006)(52146003)(6486002)(8936002)(47776003)(2906002)(53936002)(65826007)(93886005)(65806001)(65956001)(66066001)(478600001)(6116002)(11346002)(956004)(7736002)(2616005)(86362001)(31696002)(305945005)(6246003)(476003)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2680;H:Brijeshs-MacBook-Pro.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjgwOzIzOjdOV0UwaW95d0hjbDh1bG53ZWJmRU1WeGV5?=
 =?utf-8?B?VDA0SUtzcFFhcTV4Vlp4eFFWMm93U0c0azVuMHNaZVB6Y0RkVUZPVlRiQTRw?=
 =?utf-8?B?KzIrdGZYWXdSZWgxZTdxdmV0YVcyVTJiQnNFNFgwYkJES1JPNm51SjlDNUt1?=
 =?utf-8?B?MERmak1jZUFRaXloU0hNazhtWWVaUFljdWkxQXpraEJMZzArc3dJZnZjVm1G?=
 =?utf-8?B?UGRhemFlMTZtcVUzZnNhSjM3NXVKMmZ0MnV6QVQ1YzN5VWhXUk1kZzJVS28z?=
 =?utf-8?B?ZUdBVFhRRU1OaEhHanphQmRUN1FKbTlHRDh2R3lWNVBrTzVtQmFBQWlpZEph?=
 =?utf-8?B?Z1dnQmtsaCtjUnZqUGxSM2xvNkRSRENFM2JMMWxhMFZJVHZOK29QVlBwRG5Z?=
 =?utf-8?B?RFNPVmVtRlV0M1pKd3R4b1RiZ1UrMkxqSkloUTlVWE95bHdHaDlGc1l4eDl4?=
 =?utf-8?B?dlJ2ai9jWVdGYnFsMExnN20vT1Q4c1ljQi9JNnRIbFgwRTVndjFQZWQ3Q09v?=
 =?utf-8?B?S2QyWjNTeE4xWUZKcktybWh0VDRQc1ZaWUVXYWNXRnYwTHd3ZzQyMWhTVmp3?=
 =?utf-8?B?dTlGSzN3OERGalNkZTJtek1nVDRwQWVOcmZQajNZSklOUGRJYWZGZ2V0bXVs?=
 =?utf-8?B?OHlHRUdLSjAwTmQrc3cxL2U0eHc4a2p5OVplNTRKZkd1Q014cUVMd2ZyZFBC?=
 =?utf-8?B?eTQ3NUVZU1FmYjdRcjBqYXZ0RS9MeU9MWWZiRFoyaVNhOUtnUFlaUnBEK2Jw?=
 =?utf-8?B?VEdTeUdSNzdHUzNmcy9hdW9lN0J2eG9EM2R3dHlrczU4ZG1HR2w5Y2QxUUxI?=
 =?utf-8?B?RndPQ01yYlJLRyt6QjM4VVA2dDF3OXhVNVFQc2pOMjZ4L01ma2xuVVZ5Vmlt?=
 =?utf-8?B?TVNHcnB2eStKVDNxdGhYVzdkbUo2SVp6cXEvUkdNV2lGN0pGaGZwRTRxV1FB?=
 =?utf-8?B?MllSV3hPazdxRTc5cXE4eXdWMzF1TEdLQjVFWWpqcm9BZVhSdHhMdVpWdG45?=
 =?utf-8?B?Z0xMek9kVkVFWGt5UUZ6ZTZXeWR2MkppQjVVYmF1NWo4dU9MUDBBejZYQS9t?=
 =?utf-8?B?ZTRmVkE1WTU5bnhocUJuTjFCSGNOKzF1NDVJN2RPU1hCMmtibks1QXRlcFJT?=
 =?utf-8?B?YVcxbElyZFNRN3dqZFJzWGRzVDlwRzZCelJaOW9aTUFWYkxSbzM2a1BSWlk2?=
 =?utf-8?B?RVpQWThRK2kwU1p0Mi83ZHdkc21mMEl6QVBVblUvQldHNi9nWk1lbTd1WUl5?=
 =?utf-8?B?Rk1sUDdpUTNrblFKaXl1bEFHalFGbnNXbHo0Ym9aZEVORlgzUmp4Sm5UazUr?=
 =?utf-8?B?ZE5hMEl3MWluRWlOZ2JxMDJUV1duK3hCb3VMeEpaYWRxaXdUU2tDQVQzTXpn?=
 =?utf-8?B?dnoyVTNxZ2NkSG9GRTRpU0hzd28rTzRQMkIyRVUva0NWWHpFUUNEMGRZcDJS?=
 =?utf-8?B?WDhRdlZRSlIxcXB5VmdXMU5sVDBGTXJtam5Yc1RzMHk3bGcvWFZQcm9QcHIv?=
 =?utf-8?B?Z1NCd0x1RkdaMUNOYmdKWHl3bWtDMUVlbTlEL3BLQUZJUmFVUUllR2U1YjIw?=
 =?utf-8?B?dXdDWHl4Njd5R2FsRWxDREdXa3I4aW80dVFockV4K3pEZzZKeEk2bVhqVllH?=
 =?utf-8?B?bmxJU1pSQU9lOXlPdGVkZXZVVUZWQ09PM0JCRHhYaFpwS3RxUjI5RjBkbmpW?=
 =?utf-8?B?Y0hhQlZEM2hIaGRVN1VabDNmT0RHQnFEUk9Pdk9IZkt6WkJEcmVLSFFFc1dZ?=
 =?utf-8?B?R1p3WDIvVFlKd1o3ODhUWVFrZ0N6TTVabjFWeUhUbGZCc0pQc0pMeDQxWnZu?=
 =?utf-8?B?bGNtRmJCUDA3VlM5aEh2UVhqTnBzOHdGMzNFbFdDaDlNdTd4VThISWl4dmw0?=
 =?utf-8?B?RVJFcWVFRFhIeFJ0WFM1N0ZUU25vN3E5Zk9JaFFBRWpNVDRLMmFJeFUvSzF4?=
 =?utf-8?Q?mJDaJF++iX+L4gbhzfX1LNPfaAsvEg=3D?=
X-Microsoft-Antispam-Message-Info: TjuWQpEWnn9ltGMc8Fdp6LxwmnWO2IFaS8A+WBVm4BOhhuJxrKxMH1qUjjof3Ei8KtRVH0cho/L0LFrhC9OKIUxVg3wuAVkS74WwW3QfRnrEoRL6hLDWplzsSUNdIFqf5R5gUCa2ILZ0UJYJrZ9qtz2k60XfLepeu9KBoAvSdh5Vktoal3asIa8MiUCraOUHAgbiifADvYslLbv/iejCmq29XPsELUyDCdtxBLsO/Jx/jVyIHQt/ZURTOfJ/Q4KBBMQekbs3B3YbF9btW2Y35vr2OmKiP5eN+8vOpY2qETRKUkZOyASlcNVAoC4cMgqFAtsB/S84AjFz9+B/AtjSX1kCov0xqp9E8cAa1PCjAME=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;6:h/XkiTIzEwG85pbgEGoGB/w7dZ65fmt34fbL1bETnOAXtaz125NyBXT0gXz9poCzqChLNtGK/oWjrZkbhSGEMrsw/ZFlu7Mr1QrZAOoaLXJyQxZNfAtFHGm3oGAOlbQc9+8JZkCLvujSrJdD6nwbH2NHdNrmjRtHHYAfC7RJRjLBvC9X/I4FFIggd3qMuZgAQmHSWaK7uEvsAk5z5e/njEZjV1zZVmpVnHiUSabXe9qPkZGShsWVj3+YTZK7wHkpA67+AFUyGzVbNMKsKLCs6ZhGXZdEQEB0Q3kHrAb4H4EfSCsdwEFLCbKcxJrTlhcSGAXVZ39QIhH8cooo2+xSdTNuAco8VF6mqgDjPjlbuzTyrxvDPTMq2Qn6mUtagamtURGVrO45aZ4ItFkXjjCioZTabnc3AcnlHdLDVAqAOJcxcpbhA/TdvToFhN612IbaHHEqMKoBOUFpj1+7OHuV7A==;5:4Tk+oS1goUcJ/NFS0R0cWhU2DacIb+J8Ie/9x+vcgFhxhQ9qFFaww8RrDm+2heq9hwWhBuNhcEbURLbd1wMl6Xz93L6KyhCJJ07E4MErmVsIpdGIGPbF/vukyBzhpI5ClOZxiEHZSxTcyaSDfNRS8ZfJ56+z4wbcVoNX/IcQ6wI=;7:SKCdn7hfz2OdEc5C7h0gx9Rb+hAbs6CUaUP1r5DFb+RFR2+3d2mTlzqmuoFs5L8FHE/p60xY7xb0Ib2/IS8ilF3VypVVxdzd/19o9jurT9AWOk0oOeQmrYqV2TfueMibgDtqHUGmX6xLbrHXXqeRThr8eK9Ed99zxgV3+e0gT+NMcknsEe7IOE76eU2hcQBu8l2CWSIgwEzBAomE+MxSXToKEWcw55Zcb1+F7NDatKBepKVTTPju+GxzxHp3wUWQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:3QL/I+ETzEp3YSD6TmUhC/pmQ5fD7MA6WKh3egwKJqIyvUdMy9dDMCmRP8R6lj4ZBvO1RPQjVJLVk8aeqFui5zqC8GXwVvhY3m6eLDP/iaTiKIZ6/UEKEWVjY3bao7jNr8IG7/MbM1ArsjFcrox1bhxMD2fNesMdp26u1mgHYLB+BThVbWO07zhkSAlZJ49SEIxIq7mYX5OmZtJrs2zhEuRVcDIvvHuigQSPY7YU5bnzk3z9gU8MN/es9jPfm8yr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 03:57:20.2222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afe5f921-1284-48c9-0a2e-08d614760356
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/18 1:50 PM, Brijesh Singh wrote:
...

>>
>> #define HVC_DECRYPTED_ARRAY_SIZE  \
>>     PAGE_ALIGN((NR_CPUS - HVC_BOOT_ARRAY_SIZE) * \
>>            sizeof(struct pvclock_vsyscall_time_info))
>>
>

Since the hv_clock_aux array will have NR_CPUS elements hence the
following definition is all we need.

#ifdef CONFIG_AMD_MEM_ENCRYPT
static struct pvclock_vsyscall_time_info
                            hv_clock_aux[NR_CPUS] __decrypted_aux;
#endif


> Sure works for me.
>
>>> +static struct pvclock_vsyscall_time_info
>>> +            hv_clock_dec[HVC_DECRYPTED_ARRAY_SIZE]
>>> __decrypted_hvclock;
>>> +

