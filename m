Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612BEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB36321570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k7nI0suS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB36321570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeHUB3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:29:34 -0400
Received: from mail-eopbgr730075.outbound.protection.outlook.com ([40.107.73.75]:20096
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbeHUB3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGp2lx9mIPug/rMum2NzFDzF3SBq9p2KE+3NhJSSWvY=;
 b=k7nI0suSL3F1lpXuoy7pmlR3jJPbV7VDADnUhR2Q9tzpbEr0C98qt8zGVsAwVOnKxeKsmzwUSMzg7szMIuGzNZTrgIb3SlwQg3+1gBYxyoOnr79b+7w062LZjCcWoUTzOzUj4ygNWutXYprDOcRBEZXfabbrThnY/FNEACTToxI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:6f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.24; Mon, 20 Aug 2018 22:12:03 +0000
Cc:     brijesh.singh@amd.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Subject: SEV guest regression in 4.18
To:     "x86@kernel.org" <x86@kernel.org>
Message-ID: <20ad6cd5-394c-d3ae-d99c-b656d7ef8293@amd.com>
Date:   Mon, 20 Aug 2018 17:11:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0701CA0014.namprd07.prod.outlook.com
 (2603:10b6:803:28::24) To SN6PR12MB2687.namprd12.prod.outlook.com
 (2603:10b6:805:6f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 566b3dd7-4af9-4fce-7af6-08d606e9f5bf
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2687;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;3:/OTYmE8KNtz5ZTv1H60hwzygU9okImfRwoxd1jyPXoz6QbBYvCzz+E9JVpfNH2F3OtFGN0EBIWaSOUy3bttXi/9pz7r7JzuiIDurppDTqWmlfzYJW0qlcQ3+ydbtIY5zvQbPIygwlpG0K50QRVqk48VPsq277OGIY6X7pt4XGav5lpS1Ym0+lKQ28xMgJkXinpUlJdQvRgLQS9+SWhbsil4woPv6cLCKMWbyXVa7CumJfOcZNtQX1MlrIComI4kr;25:Q3AfO1dITkydVultAl1k+dEUGOx7BRmp1alnysHUMMbYGAuYUUS0syw5foqCxVI2RADiep2IOuz8O9RpXHq20tU7dNXvoybhyvGrGNGm852UIB44+VoppS0fyqD3MsytTGrna+3r55g6AMPB/HnrAUOHwFeK6rzoSO4AbOHtUtC5VoGWWmc6my1YNL3oKNJCOs2ZyrB7XITtDT/kVnyfjCXerr73pGcY7V1kv9hdhhYd0d88VXzjZ+/7lm0OZ5W12cYgDeLlbGLHEv0qggIv4XmM8LuajGkfJWJrkdnLbTRotpw4owEPvQ1DHXEnowxvVGxAgdh1yKAK0hgikntEKA==;31:NEQVJMhatc6MRls/L+G8Bw15WMifgukH4XwbB0n3HUgiOm68DUbjbsRgKFQjJJ82WpW3hhu5s2/SoALoT/SamJpdKi01M2XFJQooCFa+4Zo5UKVzXW+Opg84iJhzNlqNuaNeQalxH4P0pWdmax07F+Y5dPnFhDqAkPa92MgxiCo5yz0dN4euaAdioRNf+5X2KbAVIm//OQkgIBvc+R+cGA/ZWrxFDcVrXXZeVg8XguQ=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;20:WI0cvrAwZWtjlewnXvuvS2GZRfiNj8mEoSkPeC48thrBcE5KAEWJqngm+htSlQKrTJsTR9CK1WEozj8N+pb0kL0DoUGEKfHk9xoT1/fLAKl5SpeFb4HqIgfVN11imCe+HRKP96AMJGMw3O4PxcIDs8Ef/uFGQpgZhFswVWcg3pib3feqXU5KOpkY7wYiKuCwp9s7YWxHFYo38OzvoRYCgpWSc0yiKJhmppSi4qa8tXbmKTPQqRtOXlyUoFfFOzKn4HNfjesxGPr4Czcb19GxfXcLudbCrZRxJh/NI47QAWxEZzZGPgwbjBhB4vqADjoeS2Jy2J2PTatGPem8lt00CnK8K6ZPEikL6yHUbySQEzPmZm+gR4wNe/ylJG/jY3u72iucvlmf4vxY28bnR5obNwehZpR/eWC+YbFkklp8MbPLf15/SptdlL4hp2lpsBZHX3C7X7sI9Am6LTGLqWSGLc4tRje0nPAfGK7Ae4gTcjbFX2cGW5upklpKtHWMWWCK;4:ozSDR8/CPPs/Cclf96BP5DrJhm2qi9siVi66IrEUDuzX80nsUuvLz0xGFHCaKazSwFZp6xIjdvVAm/0k2GTqoAxAcHGJAzVkoBF3CNdnAawrYCPYblALPRkzDcmYzpnyI/Brmihe6wvEQiDaCYICgjFO2+O3uW3mzushS+eUL6CTTc/79DtIgYI2dv17Mu2Qit7vbM6sq8Jlsgjv2Hb6NiUqwptS+ylfnPPtjRD346i6GpkFfHY6A3USHBUWpyJSRS/FSEyS/FjR9ZJzTEBi2hmKV2FaPV8pXKEuaEISRSFV8lUvTygg7gMfptfO6WZ+
X-Microsoft-Antispam-PRVS: <SN6PR12MB2687BFC7352C9EC42FF3CA7EE5320@SN6PR12MB2687.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:SN6PR12MB2687;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2687;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(53754006)(54906003)(14444005)(47776003)(4326008)(6306002)(16576012)(58126008)(316002)(25786009)(53936002)(6486002)(966005)(65826007)(65806001)(65956001)(5660300001)(36756003)(6916009)(97736004)(5640700003)(6666003)(2906002)(66066001)(478600001)(476003)(486006)(2616005)(2351001)(386003)(3846002)(31686004)(26005)(77096007)(16526019)(186003)(6116002)(64126003)(105586002)(44832011)(23676004)(50466002)(230700001)(956004)(305945005)(86362001)(8936002)(81156014)(67846002)(31696002)(52146003)(7736002)(68736007)(2486003)(2501003)(8676002)(81166006)(52116002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2687;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg3OzIzOnh5b0tCUlVrM2tScEc5bW16UFhraTkxVDV5?=
 =?utf-8?B?VVRqb2ttUi9BZWlVWmloemFpL3FHd3RrdjdVYVNObzFBLzVvUmpxOFpHN0Ja?=
 =?utf-8?B?T3ZpNFJ4RVcrek5QL0NxV25JWmJXWnRsYnZncmU5U21HMC9sR2ZJN3VFb093?=
 =?utf-8?B?MVlXZDhacVF2T2krYUpzcTBPaWtvVTN4RGRPYXdNT0pZMm5rRHY1bTRjbm5H?=
 =?utf-8?B?RUNGY1p2NkEwa3Z4WmVTNm1uUDFLbjc5cXg0a01DUmd5Vm1NeDZZZmlaVzk0?=
 =?utf-8?B?Q2JlZlpWZjY5RmRVRXREMCtmRTRQUGNBenpzOWZkUVZKekZBajFlbnh5OWlm?=
 =?utf-8?B?K2QzMDhQMTBMRWF6bDZWMzFqV2l6UkVMaFl6cTJsakF6cTUvZEREWk05djJZ?=
 =?utf-8?B?ckk5SGZjdm55QlU4RFhJTjBFY0FDM1pKZnJXQ3ZINVEyTHZubFpHUmNFYk53?=
 =?utf-8?B?M2RzOURyREUwSW9mMk9wMGhqaS9uTG56Q0tWRVlkSzlhT1c0MnM5YXkvM2hu?=
 =?utf-8?B?QmVPUkZMelJYa0NnM3F5ZVoxV3hjQVhnNU1IUkYvMGJWNkIrdVFhZHlHRnBl?=
 =?utf-8?B?VTVPelQwMWp0MnB4WHFaS2g0WUIwK001NUxaTXNaRktsOTgzdWgzREMxdHpk?=
 =?utf-8?B?U25SQm9FYXA4T3JUbElidkpLWm5nWFNUdGtGQ3BaODBUeDR2K3RVcVc2TFhM?=
 =?utf-8?B?Y3djM3hVbjEvcC9hbVBOVERnUHBmU1NuRXRuQzJ0dHZSUDdKN2xkNWw3NG5h?=
 =?utf-8?B?SHdMTmR6d21nY2k2QWFYcmVEVkN4VXFxb3N1cTg3RDRkcFR6SjZNaTRvTDJo?=
 =?utf-8?B?MkJ6blp1Y2pCZ0h5eEtFQVVkWlppNDdLRjVZSE9Galc4MmFTWkROcEJGRHkz?=
 =?utf-8?B?UDhyNEJtNktjNXZURGx0RnprNkc5cXJEQXR2ZU5XV3RpK2NCRW0yRldkZmgx?=
 =?utf-8?B?K1BFWWxZNFIrWTVSb1Z6bFBXNjVoVTBJc2ZheE9kRUZheHpldkYyRXFrd2Er?=
 =?utf-8?B?QzdkclcyY1ZOVmJEb0hXRFFPSm9TNDdLN2hGbHJtSzExRzN2WldTdXZxMFll?=
 =?utf-8?B?RmNiRFlNeUZ5cG5lTVVPSjFZOTMvRHV0eFhHUDV4SytkYnVCQWdBY2xWTlBa?=
 =?utf-8?B?RW1obDhXU1o2R1QvYURjWlV0a1N3Z1FGN1RubmtTT3lQWkJrTURucVdzaTlY?=
 =?utf-8?B?bFVpTEVqV0ZOSnB6eWhHdnhwdXNRUHJwKy9tcWZBZ1l6RmV5a2hLWHdBS21B?=
 =?utf-8?B?UVYweG5ZZGhFdnNGYmVoWVc2WU1qWFlEdXN0L1I1WEpwWmcrNUpabTJDSzBx?=
 =?utf-8?B?NEpkZkkwOTBvVDNKdW5QSk1YYWVITHhsM3J6MHhmbkMzMUtwaCtsRDVta2Jz?=
 =?utf-8?B?Y2RqYy9TVlpxOEVFL0l5SHkyY2p1Qm9RK3Zid2M1NU54ZXVybk45SFMxSlZQ?=
 =?utf-8?B?QUR6amliZlQ5bGM5aDN3N1JFbURsZ2ZvMGtwUEtkaFFkQVVqdW5IbE1peXhY?=
 =?utf-8?B?MzhnUGU2OTBpby9PZzdYYW5TWldkT1NENFB5cUdzZ1VKc3NpbzlOaHNtdk1C?=
 =?utf-8?B?YnI4VnIzK1JETmlqMUM4MFlKVFlaOUZUUTFmdTN6a24rY1U0ZXlaSEtmMUZx?=
 =?utf-8?B?M3J5TmlIZW5mVkExUlgyaWdyWi9Zckc0V3pyOER4SlpkQVhUWW5oS2VkdUxo?=
 =?utf-8?B?Skpub2FBeEJrMUtJS09VMlpBeHFFaDlQd3plTnJlRFBUcFdYSTV6b0RtdFEx?=
 =?utf-8?B?N0lFdVl1TVRIR29ndjJRYVdsdVZrZ0VTYU1xR1RJeTdXY3dLalU1UmJTcm8x?=
 =?utf-8?B?ZGwxTVMvNWdUTUw5a2NORXUrR3pkRHcwRHRpSWtDY2xnWkNPd29LUFpTRmM0?=
 =?utf-8?B?NW9MUXBjSGc3WVZlczl5SVhncVFtVlVrR1BXTWNLT1NlRkhmWjhyQnVKc1BQ?=
 =?utf-8?B?djZUNzRHSnpEV1E0aGxIeklHcmFNMlhaeWZycitkTXNIZ2hlS291aGE4Y2FU?=
 =?utf-8?B?d21Jb3NqV29Lcm1Ca0htNnJnczhNOW5vT2xNZz09?=
X-Microsoft-Antispam-Message-Info: mFiRROG+FrqWYd+WYTbSmUeR0Syxd/SpnNom36/op4grT1ZQCjly2keldlbQI9J/yyWEEyzHQX5YEhDdF1vNV3NxBNGxI1XWiI1DGCBPFPaytGfdWQctfhCuGhAURtcT40EKjHQez18zR88lueFzfq6omkKTZduh4WQksiiDBWCwNG+qiwzM6t5xZLxevoDDU2u8qcdnadzqA2fhbPGMfImwXe1ZoAlvtGQpjYpexfCguCwEt7WEQkUxtYOOo9NT8m2/opoaeYHejp/xstr4AmwaRLY1AzYceVay/iRmT8PoIwY52FdPD/CY57dfGkPyP/Fc5065BsGTfM8/t+mut66xEvfcJ8Rw0X/lZ23ZZgo=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;6:ArUM+Ow047MsShMFM5jk0zs9G5Tp3tlE8NqRbM9fc4WdxoL07ECGBPVmXlGd9qH3zhFGfZM5sf//8rViia75yOkLQVXRbS7dEm+1TRsdOxmBEqPQF0dwJ5ixsGczSutYbXdfzniNLXkfLRnAGfcYOFmQNYVVOZy2JSS08InAtgN3oHeSjdPQzATsyk08I1gKkU6PL5fWmi0i8evPyiGxJ+/3L6k/YEJZ9im3yDt8DiWUEiVpzco9L/T5Zdnh69LPMnEMwdQkcUxXjK0ZAVeZzCjaIHpGPFaEpZRXj5hwkLIkdbsXmYJKaSHUlBM0VMUCcZngff0seAIV8dwbdUGvTdBZMKiOgOpGji2HGInKQiMlXtYudYjnAOYEj6ev/adw2XdJ5WTX1I+WO8QqRkAGm8THTmSHoetO09AS43UvYyj4m1liJCxrT/JgFJJb/yTZkKvpkAo4ovuo3lMfgPBPvQ==;5:TOmGAOgZcGJwWs3MiW1Up1ylXVyCK9HO5FVt2fR+V+Ti9+NsluERa6AAt+E0j29QsBVXvHlMdtMU7jvl+QsAvTJLv7ZIH01jQl+GEpPD57jB6xPSoj9iwQ1GkdEYkpNGeU3++BJrNGY6D+KtICS6iKYcOZwtKqC2NVXt8XtXwUo=;7:Q5OnZGnH0+BgCKUklf6sxOuXs2xhzc1dgq+KF+TZoxDEqe/GS2uRiDELLy706sxuYLgpVezgm7MxhYUXqD2CM3eFYchx2QT9q5AjbAgqcoKeqnLRVghZqE0rbTAPHYu+AFPlRi6bQIOEoc7zYwhGt/vC1tJzPCsLDpJbhhs1y8s8CkylC148O+OIi3iUC1gb+tc1IgCPZ8XjZsu3f2qvVBol+ZLEfRKdNG1nTpgmbLB2cWDVIpxHWrFjbqL0uTVa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;20:DyDmfELX5y0avN0yc5RoMHSaUE/jcNI9iXd8cyvs/MkeFJUqW6hNEQu4uNL7uZthzOFrYkCO0r4MdTDPnlb/idTanR9o8EAWTvdXlskygdt0ODh3DHSojYGrvZzdAk3pf4+U9Sxzkp+ULAXaHWsOA/C2JSYbhvAFlzd1UsrGSP+rO5NwlhwTZB+qn7DAPHFvXCnG9k12VVpZlxbhznk09n3yi759d9AEaZA8XOHnwyLkhK2D3P0C5Nend6iOTrjW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 22:12:03.6492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 566b3dd7-4af9-4fce-7af6-08d606e9f5bf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The following commit

"
x86/kvmclock: Remove memblock dependency

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=368a540e0232ad446931f5a4e8a5e06f69f21343

"
broke the SEV support in 4.18.

Since the guest physical address holding the wall_clock and
vcpu_time_info are shared with the hypervisor  it must be mapped
as "decrypted" when SEV is active. To clear the C-bit we use 
kernel_physical_mapping_init() to split the large pages into 4K before
changing the C-bit. Now the kernel_physical_mapping_init() is failing to
allocate the memory because its called very early.

[    0.000000] Call Trace:
[    0.000000]  ? dump_stack+0x5c/0x80
[    0.000000]  ? panic+0xe7/0x247
[    0.000000]  ? alloc_low_pages+0x130/0x130
[    0.000000]  ? kernel_physical_mapping_init+0xe0/0x204
[    0.000000]  ? early_set_memory_enc_dec+0x123/0x174
[    0.000000]  ? 0xffffffffae000000
[    0.000000]  ? kvmclock_init+0x60/0x1ea
[    0.000000]  ? kvm_init_platform+0xa/0x16
[    0.000000]  ? setup_arch+0x434/0xce9
[    0.000000]  ? start_kernel+0x67/0x52e
[    0.000000]  ? load_ucode_bsp+0x76/0x12e
[    0.000000]  ? secondary_startup_64+0xa4/0xb0

I don't have proper solution to fix it. I have the following two
approaches in mind:

1)
  - reserve  a few pages in head_64.S
  - pass a flag in kernel_physical_mapping_init() to tell it to use
    the preallocated pages instead of alloc_low_pages().

or

2)
  - update hv_clock_boot and hv_clock_boot to align PMD_SIZE
  - when variables are PMD_SIZE aligned then we do not need to
    split the pages hence avoid the allocation issue.

Since the variables are static hence we also need to update the contents 
to match with updated C-bit. Currently, we use sme_early_decrypt() to
perform in-place decrypt but this routines can not be called before
pat_init() hence we probably need to do come up with some other approach
for this as well.


Any suggestions/recommendations ?


Thanks
Brijesh
