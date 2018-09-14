Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ABFC04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E70620882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JKKXZj9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E70620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbeINH1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 03:27:05 -0400
Received: from mail-bn3nam01on0070.outbound.protection.outlook.com ([104.47.33.70]:43587
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728289AbeINH1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 03:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0BBipACbP9aYDb1dNA75FXC6guCysGSpDj5RP4oVyE=;
 b=JKKXZj9Kw/oD+QmxcZwz4ZcbvMbyuv7mFIXOEvAZgy/VHGKWtW7S7SZxFDjG4zvMzjnVWfQpYQ/NOH5VI9v0LSjo2yqO6/qTPDlF/aKKuJtiB0rfm6zfkzLcFbd8vPoSzeMaIssiuTrBwf8+nUcPFjLyiFV/gUZG87m7a0AwIAU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from Brijeshs-MacBook-Pro.local (165.204.77.1) by
 BN7PR12MB2673.namprd12.prod.outlook.com (2603:10b6:408:29::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Fri, 14 Sep 2018 02:14:51 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v8 1/2] x86/mm: add .bss..decrypted section to hold shared
 variables
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1536875471-17391-1-git-send-email-brijesh.singh@amd.com>
 <1536875471-17391-2-git-send-email-brijesh.singh@amd.com>
 <alpine.DEB.2.21.1809140122590.1473@nanos.tec.linutronix.de>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <a9391cea-bdd5-fdfe-442b-0c9f9699ee49@amd.com>
Date:   Thu, 13 Sep 2018 21:14:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809140122590.1473@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0057.namprd05.prod.outlook.com
 (2603:10b6:803:41::34) To BN7PR12MB2673.namprd12.prod.outlook.com
 (2603:10b6:408:29::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d81cd24-9788-49ee-c062-08d619e7db76
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2673;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2673;3:n0fUpWArGkPQ+c85AyZ2riY3VHwfSF7VG4GS1waEiGGdj7TBo+qUDQQ98LbIMHdfqvRUgdepTDlhga+dRXFcPecLEnCO6M44IVpWVg/ottEW9azMf8phvLas3Tmn9dHGCodLLSwe79t2D+UnBr0Hc6v2AGcpC9Zk9h3DkBw1U0DOoj1DGUK0XDSJgwWC8hKx9CHUPXOEceYlQ+7S2b44tIJ7xgs6qvonA/IF/be8eTqoXPduWLTgX6Y3yNz90lMz;25:WQe15iRXfHHbm+zgmbc6YlDaVVmmZPx3EbmOEjQpd68APBmBVohIROvBawdvF1A4R/k+DPCahMfnUGTL6mDj0gGe6rQQHEVWGv+yi22h9Nvz44vIm0DXmQhKUrGQTEryTqdZxx4d775Pdkv59b+ByxrUhaSDGTt2DjAdXqSUVed2VQgizPUbDu0O2OVKo29f4aMH5JwJt8yfSeNy6qvqql9UWUotj5ReddNgJxAKBN1DeLPyMJyNHiIrmd+PphsCAd4gvOO5OvIqI8b/hZlkPKzknUM+DNh4NYj5qwXKjAZQZ+kbg5ppe3cpodmAojshmHNAuZfsdyaQ0asfIYOBUg==;31:MMfybrbp6sBn9kUy//khP7258GXzACOpc1cmLmrK8MxlpFObsOqfbUk9UZG+Wd7G4SNT2By7a/QtbCufUQTJeVISMXtEsxY3BYHHa64ygO9a7wxjaxQEn7TLkFTwSGtoMZ5+dD+qggpg+TWTXl3EQcPAegEaETp2ZN/vTE45saXt0VYTErz5npvodz2m1glPvLnJm74zyiW29l1eYpPNuqewMe147ajcLVYrpPtA+XQ=
X-MS-TrafficTypeDiagnostic: BN7PR12MB2673:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2673;20:TAZ6wJ1JwowwGMxy8ukme2dliELcqeWNC/kLGSfB50Fa6P4DfKU0kGh1LmyVC6D5y4nnipIpjGOOZJSD9+xH6BshXE5yT+y3s20d/09yqvQtyQnif4D1qdjyf/ENcm5ZSN+Sv7WhjB9ezJd/etlDbWMHN0PABlshiY3GKwv7vJ6EnQkPHxi9fWDxUdPUJatYg8HNglZSitfXKseocj/uVk+KNF77iJ3JHcYkoWQvjpk+y9oq+k7vuHAyOQHdacJFdIFbRJ7sTLFruUYgimpCxj1MhSyQyKcTS7/ld2Y4xExrm+6O9Poj2v3TImNQddFShMVxP1BhR+Xzr3EnOgcAbeMo1MMcsTVhjTtfs126DjzMVbJMGwHJtPCcGbqe9knlwSwfDRudwaYsygWvoByRGOblnSqew7MVJofIzp4i8wuAHM2Kj6cit6fms+uJB0IeMJ5/FwiI3uf3Vy2uRhswNz+nRAA6xhXMwIkt7feT6KABp4GOAXP/4uMoi0v1Qlwu;4:YFRHdFkgVwjig1dXsJM3FA86+0I/3Je87LbBaGSpbf0Bdl2CFxbPG48W5hDSgieQ51M7wUVG2emZQDisR8vhLXg5/LUZqS3dbNUmZqbEJVIA0ld1iZQl6CMOslQH4WkUVKzd2OO9x5xUVoSjbSRL7df+sW3+hzbOla6R/XXUaxRVJQfi8yqdycxPJlKtjW8l9VhkFcOpOnlEcoUZzwTicnQNKW+XncXgv7c8NK70yVUaA1OBcN/IiKicmCwXdCphKQptj1rE1LLMOAUYJNjQUQ==
X-Microsoft-Antispam-PRVS: <BN7PR12MB2673E3F920D9117FA2143B25E5190@BN7PR12MB2673.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:BN7PR12MB2673;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2673;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(189003)(199004)(478600001)(81156014)(65956001)(66066001)(230700001)(65826007)(44832011)(53936002)(81166006)(50466002)(105586002)(5660300001)(6116002)(6916009)(23676004)(2486003)(486006)(4326008)(52146003)(25786009)(305945005)(6512007)(8936002)(65806001)(64126003)(8676002)(106356001)(186003)(3846002)(31696002)(31686004)(16526019)(6666003)(52116002)(36756003)(76176011)(229853002)(6506007)(26005)(386003)(53546011)(86362001)(7736002)(6246003)(47776003)(68736007)(956004)(2616005)(476003)(54906003)(446003)(316002)(11346002)(97736004)(6486002)(58126008)(2906002)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2673;H:Brijeshs-MacBook-Pro.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjEyTUIyNjczOzIzOjJJVVVUOG0zYVA1VlE1dmNqQ2x4alIvK0pR?=
 =?utf-8?B?Ni9pOUpMQ2NiaHJOYnJRSktjRTlPY2ZYK09jOFNPVUdzSjhWMXU0WlZkTkF6?=
 =?utf-8?B?TERKMk5TUmMwaWE4RUFrbDNJVGg5bWtpUFdKeEFtRG9lY3h0MnBKMjFIWDN5?=
 =?utf-8?B?aHpRMTZ0VkNJSFdSVnByNVZOM1RXTnl1dHBVZW5JWjVMM3g5K1BiaVFnWlNl?=
 =?utf-8?B?WXZPb21HaEh6N2N2REIrRkx2bEFsUVg3c1pkR2FLU0JqMjhNTGoza1hZSWdN?=
 =?utf-8?B?ZjEwRkYzWDJNZ214QzRMR3VqdzlJRnlnOGFmeGxWU1FPRkN5NTI1aERMMUhj?=
 =?utf-8?B?RDJMZng3TjUvNTVXMHhPejlUcUZBQ2UvTDNPU3M3Rzc5SllKbHh3T0VRMnpX?=
 =?utf-8?B?RDloNFdxWGhNZVpJbDFCVGZkNE1DS2dXTUZRbERuRWdkZWJrb1dzNXM4bmRq?=
 =?utf-8?B?SVI1TUtNb3h5Y3JRMEZCU285Wnp1NnQwejRjRjFJck95bi9QZ2w5WEg2aWlP?=
 =?utf-8?B?Qy9aMVEyUDRLQVJ1bXVHU3dxT0NpdStIYUU5VzhkNlNCTTJzdTlCcS92WjdN?=
 =?utf-8?B?T21NQlowdmUvaE1NMFhYd3U0T0lBczl6enU2RUV4aEdvV0R3WDhHaDVSUmNz?=
 =?utf-8?B?dVhBV0N6RzRGRnJ2YkhBcDVyODE3NHFTeDNDcFZhUlZBQ1hwVndjSGM4eFpG?=
 =?utf-8?B?VCtlZ3hVZTJTemF2ZjNUV3UyaTlTTndRbmRCdUh6Zzh2dFdZSjRkWXFLaXhr?=
 =?utf-8?B?QzVTbjZtSUw3ZFRzejdXMThZMG9KRENDdWo5aENTQWlsdjNhUzVMdnBrSHBY?=
 =?utf-8?B?ZHJCRlZqem5aTVhnT1V3ekZZb2ptb0Z3YmYxeDVqdkpaUjJ5Nko0WkVrTERV?=
 =?utf-8?B?NXF3STZLM21PYUZ3OVkwbWFWK3VyK2pCWkQ4R3JiUGU3TXFLMVBFWlZ6SkRJ?=
 =?utf-8?B?M0pzdVhlK3Z3OTFvWnBzUE9KWDYwVTFmN3dWV2lFaCtySTg2YlM2T0grb0x4?=
 =?utf-8?B?Z1FBa2xoejlNdk42a2lEZkZEOE9taVBkSVc4SFdOTlg4YkZCSmxBN3phM215?=
 =?utf-8?B?dVhLUVZlMWV0L3V4ejV6WnhUNEp2TEdCVEUxa05UQ1BHRG92K0VseHNUNzJz?=
 =?utf-8?B?ZkZOR3V6YjF0MTY3Y25ORy9VOTVVMVdYS2h0N3JVcVpnR0NrN1JpN3pJU3oy?=
 =?utf-8?B?cWhVSmNNc0RGcnRNSERDL2Z5djk2WWRaNHlZSFpSdnFncmlDTmlIRy9sM1Z1?=
 =?utf-8?B?U3kreCtIcSsvam1LM3ZSTnFqVjhCLzYrdDlsWkQ3allDRGNGR1VsSWxydnFm?=
 =?utf-8?B?ZnhCRkNtR0NtU3FqWnJVb29ZRnlzZWZIVGRyaDNQRFlacHlxSHAyZnpDNnEy?=
 =?utf-8?B?WklPdFN4c1J6c2V4UWtscW8xVjZwN0VLci9hd0Y5NktLM2JPNXo0YXpRQVoz?=
 =?utf-8?B?THUzQ0Y2OUJycEdGOWVOS1UwdDJwNjVQdGdrNmpSWFZCc25pNVd6aytjRUFL?=
 =?utf-8?B?QjBlRXhCUjFjaVNPRkZrc1JqWHJZTUVZeWV1QVNTcFRBM0E3eDMyaW1WRXhz?=
 =?utf-8?B?L3haUEU5bmdhdm1qakdQSm9BYVFnZGZyWEI4eE9hNi9YVlpGS2lid2IvSGxP?=
 =?utf-8?B?YVhML3hZYlRvVjFqSE1WSldMMnFuMGZFekwrb2NUSjNMdW9PMlJhQzM0Z3B4?=
 =?utf-8?B?ay9VdnpjU1lVWUNFMmh2SG1RRW11LzlnS3ZBODlyS0syT09SUG4vNk1RSngz?=
 =?utf-8?B?dVB1aFBZY1R2bldkNEg2c1JOQjhzTThFUGR0ZUlCd20yaFNIQU40QWJ4dEVr?=
 =?utf-8?B?YlZiNjBGc0NqUjI0d2dnKzdWbms2S1ZyQjdKL1duRE5Mc29pV05QV09VMmJS?=
 =?utf-8?B?SjNvMG5HNU1iSU9yeXVsZHd3NDBiZ3VLMHZRQUYySHArU1VsYVNqNS9UOGhC?=
 =?utf-8?B?L2ZPdjU4ZEk5RTZ6eGFZQ2k1bGZubHhFL1FZUUF6UVp1WVFBWU9WOGorVkhh?=
 =?utf-8?Q?AO1x76?=
X-Microsoft-Antispam-Message-Info: /WCv8i3QponXxivUg1FhZpOZmNbdD8HB0ZoMt8IiBUY6qNmuNBnNoXikgPFIlc9bjZffJ22LVpRowJk+36PTCO6YVufMQOvItO37K6NEWPnPneOFy7vqfHrHmbI1YwLZxgOIXCIGBxMUQ2qKnphswWq1kHJ1HHdFr5KovNAb8wv+y+Z9k00XQQ9riXV6vasZjrkxtZ2jgS5CfSTknLH8OkAdYBG+Jtdr7yzwizrGwHHZBg67ubzVnk0ik03XPQ8hyKEfzpxLgtHj/EDNQ4/FLLi2Y9OCkfrLkvDr+yOy4ra6r0Ua7Ik5nb8HqTqjksTT9TA7m7jND9bSRwLvqrEPvXbvwWXL2S1xRXrGeDL079w=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2673;6:/0eCN9tHoyjybxNau1kVKXpfCUhJnMcOCVpc59h5z6m/RJ2yuHte3xLmgBplr+aTNfbtpp8vyxxUprC2L10kM57yhni8unjzvYrJB5LdFTpu6mfLyEyynqHuKU1Z/Ugd7d55dm7reT9WgihNW1USi2byMoGuI19Qz2mEXyFD+VEk5WSuxjoxL89K6z8CSQCGhoRfJp+1rkc3rgQGRw+1lC0yzKlXSISUHuOSPYcUQsgFtPpmiSq+Mbd04cIiZP1TP6/6ddUtU0LvHZRKIT+LiiXbZHa9LCMcjiaYRC4UbH7LQhlL8j66Hq/ovZeNrGQcABf+pmaOSzlP/KUFBfUN1eyYRVaLc/0icqKiqusz3pkFIxKOsol89jSfupYvNr/5sdwLpsU9ce+PvLWUipZMeE2CK40nqx1VVwUZQJlAC94OiCDPvMk2PHYvDrC82rLAhVAoWEKgYFHou17bJnuWtg==;5:ch0BXdYu9ReJSpafxVYI9T0RTpeZmu9NKbfQWn63V62Qv9NE26Q1yFWxxGCAoFv5kqjml/yHpUpvXeUbOfq5H6xJP+2EHMAz305C8bDndkjeRXU3ZV3RTCEagg72Zv9yHW0QCT3tnVyvWGrqH0CFUbbTi/N3OQihhQ/5eVrGaMA=;7:7A8j0YZlhutem83uUaxDoNqmwCplgj19IArr9VuZPStgmv8hEjGCXZ9KTKqR1bkzQCAHneCJkXBQOzzPynAXVOFlLALYdlH015e5rN6kg3ASZgNFvoN4xlJTKKP6Lym/Rt0sJuxP6eiMBV/N2BRAxkKx1PubCEmLvVM7yNwwX1Zb7bkArMhl51QVdX2d5VYm2z1SBNsmRLnhDQ6dm3FEqY3l/ykSZcZO4JTKhgkmRECRP5hOAUfhHhsm6XN37nF7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2673;20:iuWY+R1zveYjRegCAR5+yvT/QKrGd4/MKhtrk4062ptJK/7RASw5hXB2KprIFPVbxBuAiFFFHNfDdtTSriOe8+JldB8iNQ5Yqg4mBo4Teos+MVAq4BqyBaNojL3p6nw2tm00ryLDn8tR7dYOQZTJEoLtWi/qgDriyWInutIeX4xzTVW9/hiBnM87pbspjWaO0PkFb3w1Iph8skaG5s5AuvmlWYypu9SSUoECzFqOMZ7MGzMyNGAYzFv+0IZArfWr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 02:14:51.7137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d81cd24-9788-49ee-c062-08d619e7db76
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/18 6:24 PM, Thomas Gleixner wrote:
> On Thu, 13 Sep 2018, Brijesh Singh wrote:
>>  
>> +void __weak mem_encrypt_free_decrypted_mem(void) { }
>> +
>>  void __ref free_initmem(void)
>>  {
>>  	e820__reallocate_tables();
>>  
>> +	mem_encrypt_free_decrypted_mem();
>> +
>>  	free_kernel_image_pages(&__init_begin, &__init_end);
>>  }
>>  
>> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
>> index b2de398..718acdf 100644
>> --- a/arch/x86/mm/mem_encrypt.c
>> +++ b/arch/x86/mm/mem_encrypt.c
>> @@ -348,6 +348,16 @@ bool sev_active(void)
>>  EXPORT_SYMBOL(sev_active);
>>  
>>  /* Architecture __weak replacement functions */
>> +void __init mem_encrypt_free_decrypted_mem(void)
>> +{
>> +	if (mem_encrypt_active())
>> +		return;
> Why?

Hmm, I think we should be able to free the unused memory when memory
encryption is active.
In that case, since memory range was mapped C=0 so we should do
set_memory_encryptyed()
to change from C=0 -> C=1 before freeing it.

>> +
>> +	free_init_pages("unused decrypted",
>> +			(unsigned long)__start_bss_decrypted_unused,
>> +			(unsigned long)__end_bss_decrypted);
> Everything _AFTER_ __start_bss_decrypted_unused _IS_ unused and can be
> freed. No conditional nothing. It's unused in any case.
>
> Thanks,
>
> 	tglx
>
>

