Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295FCC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056A82075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Xd+/NayS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056A82075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbeIFXUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:20:52 -0400
Received: from mail-eopbgr680050.outbound.protection.outlook.com ([40.107.68.50]:17664
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728890AbeIFXUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsWwslg9shD26Ild5A2ZQXcujHEXhf0St2/OTOM0u6k=;
 b=Xd+/NaySI65eF2Hb72TUmgPCuqvUsOi46a02PKZF0EPEmz3kzQgmIJpk5wH6+N6vnZtSkeaDyHCy9x6fSaU7GKilEakPGmZTFdVfZ9Cw4FKb8HbgvHodHSQwq13Mc5hvruxsefWWJLoVrBmQSt1BUUQwy+vTiCte1madBjHxVIQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 18:44:02 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
To:     Borislav Petkov <bp@suse.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
 <20180906122423.GA11144@zn.tnic> <20180906135041.GB32336@linux.intel.com>
 <20180906144342.GB11144@zn.tnic> <20180906145639.GA1522@linux.intel.com>
 <20180906151938.GD11144@zn.tnic> <20180906155452.GC1522@linux.intel.com>
 <20180906183334.GF11144@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <940453b6-7c79-33e8-bc31-3cb5f99c4c50@amd.com>
Date:   Thu, 6 Sep 2018 13:43:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906183334.GF11144@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0201CA0016.namprd02.prod.outlook.com
 (2603:10b6:803:2b::26) To SN6PR12MB2688.namprd12.prod.outlook.com
 (2603:10b6:805:6f::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1738337-3876-4528-e9f7-08d61428b73a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2688;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;3:Lh2z/1NwAh5NrTld9JkDgDxAXBJfFmIKigOTgjDed7GFiVfbRGncL45lZPDE1HZt80HvJTdVGHFBARkTgK1mnsmSzu1qZdN2W9BD9Cszo/sngJl8DBFzCyUd8yzPI4BJ7BCwYVFyFsH1c1oUPAFMzdaIrlP6tOrbza+aLN/gXeGfmTtpBGfotJ0IkLK8+5nc3gotW78hFoPoL5gD0JFPUUNKHVP/0ZIJ1ocU8cVqOKLWZJiP8ONMdvqLP2UkIJ+d;25:86WAhJs6k0AdcWp+4ulzMhzIkxviD8PGFkMqAr48zNPpLhbR4v9TGpc1HootS8rFCU6T9HoSi2lWmJr9GS6To3FPXAIj+Y4sQSMsoP4tpxijid8tHmK7GNmnv6FP79qogKkwHT6OkoKEnHJZtKQRTJv3RX+vYieqorIp2sYXhlHbAK1/wqwRJpAG00knfyH1MdQzbrh8R1C6khL1Yn1y4+Zm07aS03bx05UTaPF55agfv4O28dWi3a9zXnbdmO7dAjrywbs5zUr9oRT9g8fLfBqxErg59dRbhj4Y9IIo+WVPfpDFRDR3+S5OlPAsCNa8cg30qde99JwGyV4B0K+m2w==;31:eCtNpvt56ywwGSUuqO6gDN2I/r8vZxT8+cX2JYBfJOGmJJaPq+bXwoP0TClngTGk6Gr5dk5po61dU2KhkBSq0bIvmePb5IslFqAUCAtp6ipWhyqLs8OsuflTBahRnn3leP3PcvW5zZah5b/ZOLEPE6SNZ5D2dyV/zmWQunNq6ACQpYySYOWgBdRjy/lgalw4ROkHW1jkgeaT18sRE4SJ4Ar8ayJVhb4Ywue+J+wdnXs=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;20:+IO2luxadQOgw9KUDr9WDVjwys4z7hp8NNufx7Zo3mFdrpI5wRgMSvMOzv9JxHeaRcsiGRlNblBl8Uc2ZYw4j5ubj/NTrmHReZwRgScS3hityS2cgsv5llxcCxsHxa8++7Ani74RHVVFnClLgeJQbbt0XrJEZdje318K8tK+q2nGlyClJzOUVOlmOWcU4cWgYQnsC6UA1Xc33Fghph+MS+Rdddz2oJdadg0X+KgVOufNXNUOI8qcFe2oG8NXUz0/Sep3TLqTPOFLEyeY+HejQ1TmsdDLTUWwVWQqnkAFz6no/RqTrT/LdIRmi1+HOPvy8xj6JB1u9YLRvBnstjRU8cW9xsqqogfCMygYODorp0FLYr5LU2NkEwmss0qgXFh3TqaBoSz1cz1rhNMKlmlddOvlBlXbx53Zf9eRUul4Vn+pA4LO78PCZ0UsvO/IQsrEhMr+OCTsoES3/ziNec6DlzxmGpbwBcw7VBYJYGBm3d7I5Me82qkwS9RU02Y4+tAK;4:1uWZwmHgE9a3ipEhfPC0AmrRo/70AzckPrXR1ZQzS5nrDOYbZ6CkVo5Y6twuuyyt2jW/Odz8Dt2OiJkjGSAKJGGd9fNhAQmqosJFpWBtsWA7DZ+I07SMT21Mhzw/nm3cjvPTOeHpmtecL6CmK3R80gaQeRR2PoOezgIP2c0kLrVRtnvgluZkVlQdU8E9MQ2KGI4e5BqqCrHwyEl/7ZchD0zlD+jHEoiGJVCgQIsgOAmlL3FSXamURkdJyRPJOfXPkquP3o9VK8tL0Q/jEBpD+A==
X-Microsoft-Antispam-PRVS: <SN6PR12MB26885A7753A6F74F5BB5833BE5010@SN6PR12MB2688.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:SN6PR12MB2688;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2688;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(346002)(376002)(39860400002)(136003)(189003)(199004)(53936002)(65826007)(2906002)(53546011)(68736007)(5660300001)(93886005)(386003)(16526019)(186003)(6666003)(77096007)(106356001)(81166006)(50466002)(81156014)(105586002)(64126003)(8936002)(31686004)(44832011)(67846002)(486006)(476003)(52116002)(52146003)(23676004)(26005)(4326008)(6246003)(956004)(2616005)(11346002)(97736004)(446003)(305945005)(316002)(6486002)(76176011)(25786009)(6116002)(2486003)(54906003)(3846002)(478600001)(58126008)(110136005)(36756003)(230700001)(229853002)(16576012)(8676002)(7736002)(66066001)(31696002)(47776003)(14444005)(86362001)(65806001)(65956001)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg4OzIzOnduRDhqTm4zUWR3dEZVZHpjYVdrRk9ybG42?=
 =?utf-8?B?VEMwMDRrOUVpcm0wN3VGM3MrYlRjWUJzOHVTNnZBSFZsejJ1cEpsTlRGTkJE?=
 =?utf-8?B?Qnhxd3pSVnhHUC9YaXl4b25Xb2F0cE03azNmQzBiTVE2RUlWMDlBR1AxOFVG?=
 =?utf-8?B?M0c5b0tNU0lIYktvSnV6Y0VJMGtDUDhFd0dUeXNlbjBlSWYyZ0pqUDhyc2xk?=
 =?utf-8?B?N0VDTWp3bUtyMFVPQjF6bkhnMVRzSzVyaVZwRitWSkVZOTdHNERSRWlicU03?=
 =?utf-8?B?cjVVZ05MQW5HK0Y5WmFyNlIvRm5RbmszNTFFSWVsYW9RZU01SzVRRnprWGdr?=
 =?utf-8?B?RFh0NGV2cHZrbXZFUG9HMjhzL05Rc0hFQlFIUExhdTFTbXJONFNGcWlYSXkw?=
 =?utf-8?B?K0tDK1ljSGVNYXhmekhrWkMrc3VCOUxQeVdURzhDdnB1OWNBRzA1aE5ERjBv?=
 =?utf-8?B?bzlENmM5NG9ySFRxTWMzYXoxaXRIRXVKQUFvZEp6bUJwQ3pzRmNBY0t1aGJO?=
 =?utf-8?B?TWgxQ0xBTCt4N2RVZ09Zb3Qra1JpUmU5KzhIN1AreDVRelk1Ym9UeVVlRDBj?=
 =?utf-8?B?bnU4VC9HUDVVK3RVdTZ0T0tVTm5uN0d2TlFDUCtyUXRQa0JBNWZmbTVyZmxW?=
 =?utf-8?B?Qmc4Z0JoeE9RcmNOSzVlNERnUTN3U2t0ZW1mTWxtRlRvekNnMDFDdmxOZkZZ?=
 =?utf-8?B?alFYZUphaHk3eVdrTUVSMlRjWmc4Vk0xY1dSRkh4WFQyWk1qT3BxNDBLUzg0?=
 =?utf-8?B?cHJqSjJLcUpEaFpQdWgzRzBaN0NuR2pVYjhvUmZoOGlPRDk3VTF1dWtrRldn?=
 =?utf-8?B?aVpwT3ZVY3FnN2I5N2xLWHRVZGIvUEcya2dxOEJQSzJZQlJ5MUthUTlPL0pI?=
 =?utf-8?B?WWdFRkg4ZFAyTHhCN3cvNVd6VGVNVmhYT3R6OW9VV1EvbVY2cmthS0MxMWZq?=
 =?utf-8?B?NmllQ3h3ckU5VEZuNFJHTmJzYUJUakZSTGQwWWFESTFkWG1JeCtJQWJjTGZ5?=
 =?utf-8?B?all3ZFl6YTlZSzJJMG5EL3Bsb2ZVWldBNFpMWGk2WXpFaFcxN0c4dmVrVThC?=
 =?utf-8?B?UmZLdG1rUUh1b1pZKy92NWFwZ29JVVRZMS8xQ1FnZGY4cURReHJBY1NJTzh2?=
 =?utf-8?B?Nk8xR1d5K3NEMWllQlh3N1JCQ1p4OERGUEh3UThFSHU1bVU5VE4yM09nYlRR?=
 =?utf-8?B?alNVeE15Z2R1ZzV4dmpSSmZJayt4a3BBcWxudkxUNWMvazhURVJ5bjZISk1I?=
 =?utf-8?B?NGRnVTYzanRiRUZsZk8rS2FXcWNLdWFHL1JIcmNaRDRiRzJFYzFYVXloZHZj?=
 =?utf-8?B?TXpGSkxRTStBYzFPcXV6dFd2d25SaVMrbStFZFBGTzZLZUZUQ2dKZldydDNt?=
 =?utf-8?B?OEJGYi8reVdqVjV0cU1jVE1SbFloM2hqSVZpbjFYWUFyb0w3ZSttSTM4blVV?=
 =?utf-8?B?aXNPR2RtWWRlOXJLMFNYc2wxTzFWanhFTmFQL3FUTWN2YUx5eGg5QmlKelhE?=
 =?utf-8?B?djVIM0tHc3FzMmx2SU10enNUcXF6K2tjcnlQNFZ1RGwwYnVqVjBVUXJNcERR?=
 =?utf-8?B?dXBTS0duTzlYS2ZqYklTOGJUbkxBczA3aDN2N3BwOWlNL05DKzUyU3EvbC9W?=
 =?utf-8?B?dmUvZmRGc1dia1FrTXp1OTQ2ZUxSSmE1MUEzWHRBT1VUc2RCTU1MczR3MU11?=
 =?utf-8?B?cDhBV1hVY0dLTEZjWmxOL0hBd1lxUkdWcVY0K3R5VzRKUWg1bGhrRXY4MTdF?=
 =?utf-8?B?a0t1c3UwMmVMc3I5WElmZHpRcUsxNy9sbDFlSDE0ZUNxeHRBTHlrVjI5dGhU?=
 =?utf-8?B?MzMvY250N3hFdzFNYkJnL1JHOTI2NzZ1c3A3dHVtMzJsRDVVNUJCOHZvemkw?=
 =?utf-8?B?YlBZVldjSTdGUDV3ZXFkaEJjTzNTbmpqazB1dXRMa1dQdDlxTFdJeVpRa1cx?=
 =?utf-8?B?SXl2a05pcFFvUkNrSWFwOWZIYXR4OGs2dTB1WVNVb0dUVVJmdm5RaHo4THBl?=
 =?utf-8?B?cnZLd0NTSk9VY3RaTlFyamE3d2hUOVFXOE5LVzJYTGRiWUx2eXhNWDNUVk1N?=
 =?utf-8?Q?bz7YI9erV+/0T4pzSVzPXxXaC?=
X-Microsoft-Antispam-Message-Info: 6vqKT/1r1RCTnX3SVkfoY8eeEdjmGKf5Hyf2PV9h6VyO2MuHZaL7w7FIHwfc1o0jaoPYA5IoFlWj+0sj5Z0LwrWx170bVyrhb9lXnvBjp/s6PEwcfobue9JamjaI0P+SIXZ+wCsXLneqyOygO3bHuUe9Y+e3W4pVEjPVGW7GcakdCPY1j7heopjFzRkyWPNeFslEkrTXz1IgcJrJYi9RwXFJ0wWBwgcSKnkIEk8jtnwaECkxhiZB/aVEenyeE2NxTGqatOujluqTNQQEy9FBawoftWO8151w9e/CPgjciotp6I1VChzp0gsE4+EEuleeYhDriCbL0xYLlmMWHYpfr94I6oc3jtN/DScHk5fx3cU=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;6:FVIDdC7NTTQMG3zLRDVy9BieB1/3Y3fChnHhtW9gH/I4K8d0ud9Xmsb27syOBw5O+dSdDkunifWO3f+GVXfMGMuyTx3Kg5hmuacpYjwUwGT5n3pMIXLlJgTwNNkndxj9N5YWxA7Z4rDP4D3ssArQIH/iSI4hDSIVLxB959b5aXIWoLoL1Ab98b/2eTt7IBmYuYBmFC4YE/goJXf4Uq22iuqClUhQOn2CSY0RyuGBYt2GbLAdHFrANY9PFZHbk8Sm4LA6bG5Oqm4j2qoScuaSD09WyPdwOIrC8s0er/d9/soyvmuEVkOSJv5eGM69LLpvg275AMp3H3h4BXuNVU1T72yfjwAKO/yhYUM8vqiWPD0236VyG79sALnZW/a5ECJH5HYIJ2FnC7+ucvcAGEM68NQx23nm3UgLjdmqIch01p65L/nIVyycCZcHcfNirw3YewZblCrsRC8pi9vbMgsG5w==;5:XFYHJuQ5GeHHk3G5ppHaF9nbsnStwdp4ZTeWaHFGf321xH/vYRe+WOcAVYEIHvYlB3RePSqaBf5jTherXcaJ/bADbFp3iFjLp91r7BtcGJDSXRxt/BL5btWixdE+Ev5QooZFwFusltT4NAhDHYjmhSkis0ksAsbe25lrrQG3laQ=;7:LZkxo609Sc/nJYk4cv7DZakms7TCA31JNyTBgBVVcjAd8S3KeA7+1t9o7aq5FSsxcWFfu9ViiaJGBmtXj6LojAlEchP9fAN53frPWy/vRmvlS+dE3kmR/TmSGpcTuzm1gdQvmzhDJGgLjhubTFiG+I5TqUERqnCJkFgoLX6lJvvTOwxATpU2NeX41tD2wuNnlh+vR1N2TWnp//4QFroM5Xe572Na8shvdquWNxC5m41o8QobaQ9oOGK7kD45zl0F
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;20:0oWbRRfwnbqeQa15EmV3CmhSVo3d9paxvIe7VKq2QdCHDdyAbX/za7SFHkIfgPr2zy/mIH7j2SRJUzEvDc1Vvx63bJoEcWeA85alETH38xL11ik1/a3kyYmTuozMVj4JRtLpZEXbty9oAjS7voq8W81WtNLHpOa7G4T0VjCjVZy9ISlDgUtwayrsWldsdcn+I6d+3v5FJ+pXnQXyJh3CYejaMKx1fQewSPSxQwqp/KiBCjDgAzG7LQxLzQ2WiyI2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 18:44:02.1405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1738337-3876-4528-e9f7-08d61428b73a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2018 01:33 PM, Borislav Petkov wrote:
> On Thu, Sep 06, 2018 at 08:54:52AM -0700, Sean Christopherson wrote:
>> My thought was that we could simply define a second array for the SEV
>> case to statically allocate for NR_CPUS since __decrypted has a big
>> chunk of memory that would be ununsed anyways[1]. And since the second
>> array is only used for SEV it can be freed if !SEV.
> 
> Lemme see if I get it straight:
> 
> __decrypted:
> 
>   4K
> 
> __decrypted_XXX:
> 
>   ((num_possible_cpus() * 32) / 4K) pages
> 
> __decrypted_end:
> 
> Am I close?


Yes.
