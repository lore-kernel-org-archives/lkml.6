Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5F8C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEA120659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ix9VpetN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEA120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeIGCdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:33:50 -0400
Received: from mail-by2nam01on0057.outbound.protection.outlook.com ([104.47.34.57]:55953
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbeIGCdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvo0s6HCxi6XPtVAoc80yick26XTW1xJk6TE8UlxKHs=;
 b=Ix9VpetNxRum7a15syXkHXdvEQnXU/+7Yu1OYPAAX2NTaKQi53G8rq1rJlhfj2w4qQ0eRZjhO9Ot2Ck2LB4mBLru2B9//uEGDSkmsbDQxM0fxu8G1PzfviLNdr+yUoeM2muH8iOMdsHJoPagHYY8M7uLkNoX5jbDJnTt7/y0lPk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 BN7PR12MB2675.namprd12.prod.outlook.com (2603:10b6:408:29::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 21:56:09 +0000
Cc:     brijesh.singh@amd.com, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
To:     Sean Christopherson <sean.j.christopherson@intel.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
 <20180906122423.GA11144@zn.tnic> <20180906135041.GB32336@linux.intel.com>
 <20180906141825.GB370@linux.intel.com>
 <fcd5efe9-3e26-3aff-9173-9f8c3f3183f1@amd.com>
 <20180906184750.GB4570@linux.intel.com>
 <c219ec47-1a1f-5d19-0b5b-0cebb706ca6c@amd.com>
 <20180906194710.GA16605@linux.intel.com>
 <9126c92f-ad3b-a5b6-ac44-416405489a7e@amd.com>
 <20180906203926.GA5717@linux.intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <4c6df918-0b47-e823-1141-82baa068828d@amd.com>
Date:   Thu, 6 Sep 2018 16:56:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906203926.GA5717@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0019.namprd05.prod.outlook.com
 (2603:10b6:803:40::32) To BN7PR12MB2675.namprd12.prod.outlook.com
 (2603:10b6:408:29::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 746ab7ed-0239-4c7a-c392-08d614438e2a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2675;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;3:AhkUsrcs1RVFkw0c5iaHION680uODtsQr1+u20dyBxLqEQyM56e4HNE7MW3R4AIA1/6qVB2aPhl2JpevvvREqtCKED2/ciIXgYgMjCgXEhtR4R+AIKVY6QeIrxFALHSBnbqD4waB+sLTaIqb+DRCLW8TtI1TmVgh0RyiFJ8eM51nRY7HUTJnDqRoB6ZcCC5Yjgw63YNlPq9s9WkgmxCwRIHHslvUt+pe2RQqjEuBj5EvylgWqCW43VQPrZ9lO8R1;25:RFN0OsQ39fST/twF5nYWvIgati0+pLZHZeA1wGkrQSojAo7Y6szbHI0moQqxNShvEjl+09nj/W5ffomou9pd6FUcC1v+HUgJaA/qK4Zoft9rSAkqZfgtsxgHLGZflRKYiD1WJoXKpjvN9XVJl5pWExlUQ++fIGd2wt5URDC8ToOsva2S8kQtvsrcTiweXdq9coH7OBdgPhxVOYVS7vhZOsBECFzh3dXJubpFND7SkzxdUWgUNiX0ymPDwkaib4oAJKpIabwwebBfb4CRBxLUnVPcFRf7zN0HXG6qJPcZU8gEdqhj+W6MNCwWx4VUaL6A7rEzLgKgxrg7R5i79ej+Tw==;31:m5xwIBEYaB93HdMSX38VFXtaBuiK1lrilk9kz08N3YUPnA/s7t1MYFmLDx3hVks7E8onURMFlNA0EFNZO2KSOGzvQTJwh5xSgbH5pXZqnvTUDA3wFUVR2dPzdBDAOzBhmdzrNnW+DpmkMdZVKdMD2/TOrcMaVFSixCd7UfVXFKnkDtkvoBDk1VkQtEEIJgi9FPjQZBAZ9AZC0pwKTUpHq3C6rkKPqN/7mpSvDSOum84=
X-MS-TrafficTypeDiagnostic: BN7PR12MB2675:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:/Da60fkYD7Nxb/3ms7+sOF/7Jgzeh2+6b3hnDF0G2zIke/RFxTiveRCdFUW0SSIlIAEBnr+JPeOMZj1YaRN6utQqd+cTotH/O4elTjSBODD4KzSXIxukGhW2TY4zhh8NZy+EnZ0one8G2hrMXGrUHbfYo5w4mo3sVrkeE52X/USbjS1rQe9gpi9YWWAveK4kTKZMAyoTVG9Mo4/s1bubv/cO7e9/Exa6xOq7W3fxiwHnJ3oQEv9wIRJpAAFrQ60iJNqOohBbBlTlrXRrlqkQmaf+ebYbnN+jHaBbDJ6oxzJtsma0ei/+Rl20GaMtvHYpzc5AwchpqosUnb9KEqxRJlzFSSnf576wFy9QxojCrZUW0BH2plRFocYaZFK/IwYVazmSeM8O+KnPUXyP++iMUN54M+65Nc8I+c34CMp7563iwui07juZlgwJfEj8cyirQNNd/ujQqI/DwruxkC+uYGNSvKrzj6FDFfqw5m8JbTDOvyVIJ9mKuycIsZLA4pS6;4:1/iKUqm2ZRcBNo7A0Hx3p45e4RquTrgIXBfmstc8a6TEVgNpXTnp7FGX5sW6TORhQsQfScHcSIOKq4kEJE/6r8/eHQCihtyVDTv+/XnrzkXILbdNmbPomdlbbiNC9bJNuwPm3z3rWVOmXaI10PT24Cw3fRgdI5lumwAbhkvw9RlwoAZ6zNN7CyWdJzcS6cUTdaONX652EE70yiibqLlR7zx0reejxh5MpUdMkeg/Llb+S275P3TUN8R9CMz2R0EY8basFM2AUkJrG7nbc3yQIw==
X-Microsoft-Antispam-PRVS: <BN7PR12MB2675FD60491470B88AAF3654E5010@BN7PR12MB2675.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:BN7PR12MB2675;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2675;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(52314003)(36756003)(478600001)(2486003)(52146003)(97736004)(23676004)(186003)(54906003)(16526019)(316002)(76176011)(50466002)(52116002)(26005)(53936002)(956004)(2616005)(446003)(11346002)(8676002)(77096007)(53546011)(486006)(8936002)(386003)(58126008)(81156014)(81166006)(44832011)(2906002)(67846002)(476003)(16576012)(66066001)(31696002)(68736007)(65806001)(230700001)(7736002)(86362001)(65956001)(25786009)(47776003)(64126003)(93886005)(6246003)(229853002)(3846002)(6666003)(6116002)(6486002)(106356001)(65826007)(6916009)(31686004)(4326008)(305945005)(5660300001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2675;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjEyTUIyNjc1OzIzOllZQ0JuRnhXVmpid2lPaTBZYXkyeUYweE5S?=
 =?utf-8?B?U0s3bzIrdjh0Z3F0QUVqVnVqdTdLVUE1eWozK1hURGNJU29ac0x2YjcydkxQ?=
 =?utf-8?B?L1NjWW14SVRzM2U3ZlV1MlZBQml3TjF2c0hCMlRmUmdrSnZnYlJRK0M1aWZN?=
 =?utf-8?B?bU9UVEpkWlc3RlFrcFZEUVdGSk41NUxtZE5qb3F6cDdRWE1IbU5UWkdYTDd4?=
 =?utf-8?B?SWQ4SUlJZkJzYzNEUmVKR2p0Q2RLejFYWUgwUE0rYUhPMlNOT1NreUJyenYy?=
 =?utf-8?B?cTJYMklYUkNqbXZsR3NPM0FPUXNsMVFubGJaV2ZYUnBZTlRmRnd0bkR0UFF2?=
 =?utf-8?B?OEd2SXVKWHBUektpcmtncWNRZGNaZVdLRm1ZTTNRYk9HeGF5cVVUZFZaZzUv?=
 =?utf-8?B?cWNoKzRDMmZDWXRQQ2svM1NHWXY4eU1TYmhTc3YwQ2ErYnRZZk9mQ1cwMjk0?=
 =?utf-8?B?S2pZOWZCU2MyUEZnaS9oUlcxQjNXQXdMc256NFU5Rkp4UEd4OFBQNzFIMzYx?=
 =?utf-8?B?bW1XSmgzemNITTllcm1JbGduNmw5U1RHcnZJcjJEMTdDcjRlL2VVcFg4ZlRO?=
 =?utf-8?B?d3FXTmp5WS8yK3B1dlBxQ3dKSnZ3R3dJbEVxd3FtcmtqdDlpMXcxaWJ4TkVR?=
 =?utf-8?B?UTRaQXJkcnRvVzByNTQzRHVTSE5XYkRZRTlWUE1oNCt6M0c5WHVzeHRyZ3Jh?=
 =?utf-8?B?SXB4OCt0ck5iVVVzdk43cllxVHlTcklpb0ZzK3R6WjlHazA0eXgyZC8zc2Jy?=
 =?utf-8?B?YmJZMXMyVXFOZ1NPTGJWaHliQ25Ra1h3QzNqUjdER1VoWHA1RkhneXpoYm1i?=
 =?utf-8?B?RXU4SXhhZnJWV3FvVjlxS3hDYjVvSWFHTlpaODFidWNVdngwamhOSjJKWm5w?=
 =?utf-8?B?M2tNYVFCOG5mSzVSd1hSM0hudXltMjI2dU9Cb0VHdjNFOEtPenB6N1Viei8w?=
 =?utf-8?B?eVNjWnZORUpqWUltaVZGWDNDR0dpTDFaSllJRXBFWjVzcStML1hBbXlyWlFu?=
 =?utf-8?B?UnZJOTJIRkRKN0dyUnJtUy9jWGxuQzRRNWt1c2ptS3FHanV3Ulgxb083UGdQ?=
 =?utf-8?B?NEhBT05ieGxHRUJhOWRMdjFTM1pGSVNuTURvdmF3Rkx0aU9Fb2hvdUlmM0hh?=
 =?utf-8?B?b1MyUWt1NFl3Vm9ZcUdmb0NBdXQxcGViWFg5cG8zSXFKYXl1bzMrdGx5Nit0?=
 =?utf-8?B?cmNYaFZPckdZclhGaUJIei8wZnI0cU1MQzNqaHdpTmFQRTVwTjMvRlMvOUky?=
 =?utf-8?B?bXBLSERBZk1WbVhtUFd2THZLWVlxb05ibEtnVExaSmdkb0dKQVBzTVpFQ1M5?=
 =?utf-8?B?Y2xZRU1LaHB3ZWVFV1F5R0czQkdIcE44UDBKU1ViZVhJVy9oekk5cW1JZk5a?=
 =?utf-8?B?dEdMajBxSlVKeXdiNzllaVo2Qi9WM0kxOW9kT1pINC9mc0F4RVVRQURNV1gz?=
 =?utf-8?B?YUg4NWdnbXdnM3ZxSlp4Z09iaW40Y09TdVVXY3I5a21jUGVQc3JxOWZ6aTFG?=
 =?utf-8?B?T0dnTTY1dXRMN0pMSC9GZkd2dG83dUsrTEE3dW0rRlhjSUlUTWNJN0MxNUVK?=
 =?utf-8?B?aU1xZVUxWmxtRG5BNHZDajh4UDZnNVZCZE1KeXpuRTdFaXpETGphOTdVaDlT?=
 =?utf-8?B?dmRHVDhaMW93NXpJOFFJbWdEWFhJU09JZzVwd0MyZnFLcVpDakVWUGtYM0pm?=
 =?utf-8?B?c1RYbGZDUFRNZ2ZxVFQzWVllUGpOY3NqTXhjVjBjdmU4bUFTNlEwdnhlb0tM?=
 =?utf-8?B?V3Z6VVFwZlVIdkRrMTUzQnJ0anFFcmdXL0RaUFlrQXRMdUpnQlp0M3ZwRVA0?=
 =?utf-8?B?blM4aW9IRnhndlVvajhjZ0lOcklHQmJoN3B5QVJZODZ2M1Q5eSthZWEvbk8y?=
 =?utf-8?B?eis5WmUwOVpiSS9ZTjNkSkp3ZmpnZEtwZksxQVI5eUhYT1BFaktuT0tLWFR0?=
 =?utf-8?B?bU03ZldwSUZpQWtmb3FTU25qc3NkNVh1cUVXZ3laT1ZzUERhSjFvRjNsSjRM?=
 =?utf-8?B?V1Nnb05kU0tzMk50aDVORExIOGN1MDhwTC9DdTUvNzk5a3doejZSNVR2L3Z1?=
 =?utf-8?Q?5608=3D?=
X-Microsoft-Antispam-Message-Info: 00412MStrD1RoH7RhNycCcoiiBAhJRgzG2aIOXu7BOgx307P3C16Attg5FesARUJKqFZgP1FXauZIzndqhVrh7RqJv2z7IHNCbT9zlwxSyFhiT4aoGnjuFQeELLzqxZ/ZPJfZimyVW/48xq0MP1L6FNAp2GAq38m5v03LI9zFzvOjJte0KGvXucJQcvJYF7y/Yh1AA/kXeEExgQ65svKt6+x1eTUiybHjzBtVrN0PWj59d6lsomrsJan3CFL8cW0ueNX/B46pyvpSrvSAcwz+SUewHxfyBl/bUrSzbsqFhdcyw946V/0IC7zjxONqAI/utUSJesP9iZ2D4q1rAVGVJxz66GNrxpIkK08gQPzGLs=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;6:uaW7NKT12cL/JhuZJIwxEfPJsAwrEx9d3sjt2hE6pMkChIuWX5MCcMHXTm2tcwKikMnl5z9ZG1fKOkVcWp+Tt6FMvy0ZkpIIzCdidvqABRBjO4OtISHM4mS36CuS0qUogiafrN66rmZBZXnDlJfmeTGZ1keRAY5tpd+fVlD1CSLlm0/bN6zV/K+tXy1YmaD70XS3eJ2vIFAlOye9wu/+NLrOnDTdECiaJOzdXHnguDOh8EYP2scJICmvW66BJX4GOEvi20DFzNBln4WXWbVhad8r0DpuxhTt1A19he+UiLqnFjRj1Vpg7ya7EXMsjIDuY4BA7NHxajFBBXKGLIleXNHzUNriZth0IHUm/jX3BAS9rnPE+yWwnErcGPwX8AZUlad7kulPNNntuapN1Ee5byzCfJo/xLGaYEJQEk4EFWB84l3jyV+6+oc1r8XwqNET2o4n4ZGDLnb4fUxOWuYEdQ==;5:tzUBLrCzkl4ykaRw1ejSx+HEZssGlV37Aw7gaJyE7qJz56mtdV7BXpQlgXOq7apIUjrwuBt51uc7jGexWMmQBy7FTw6AqXA3lkK/SaZuj/Rmj4E+kvRSVlRJE7V1nxwxxi0Ly/eTBfsW6pmvngi7hjBInVjaZM1bxYiV/z5luNU=;7:e/n+w0OEB2nkOsHDCngXk/o2+uVGU/8891CBCfQPzusuXMrDuyFjETBeq3CWryLUAwrL1TllSAvSYA1jVuIQ97YFNo8fs0YKQvBnXop2IH6Pk1d1kuXPhCi04ugck68XLsxkmrzutld4FLOYq6z2rZvcXWqPL2RGy7FsDmdnJsr0CEAQWYdmo5z3XCx7nFUOGp+Gscry9SeixHhVG0dF2vnHG0cOeyq6cqxtmTtWF9Iyx+DrZs0svcUqPEISzYp8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:t5lVgkuvFMCKfFk/81F0MBETUq5lGpWiMMpXerReEqmul0U6wBXYWR7MfxeVlBOGgtCc+559Q8wIF0joZI70HzuwFtRT16VSD6KnncjfW3mIgDvEwZyh2XmjvLsm4zsp7jwYfCCRjh1CPw0oB90Ah8PFcJK7BLE34I5RmaUCkymR0ZLtsK06byvdOekV0KDeq/7MBi7iQW3cUMTiO2plZya2bM+VYA+cRJ8J3/ZuMjcz7dnkMb4/jxKk1Kbkr1H1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 21:56:09.3316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 746ab7ed-0239-4c7a-c392-08d614438e2a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2018 03:39 PM, Sean Christopherson wrote:
> On Thu, Sep 06, 2018 at 03:20:46PM -0500, Brijesh Singh wrote:
>>
>>
>> On 09/06/2018 02:47 PM, Sean Christopherson wrote:
>> ...
>>
>>>>
>>>> Yes, the auxiliary array will dumped into the regular .bss when
>>>> CONFIG_AMD_MEM_ENCRYPT=n. Typically it will be few k, I am not
>>>> sure if its worth complicating the code to save those extra memory.
>>>> Most of the distro's have CONFIG_AMD_MEM_ENCRYPT=y anyways.
>>>
>>> I just realized that we'll try to create a bogus array if 'NR_CPUS <=
>>> HVC_BOOT_ARRAY_SIZE'.  A bit ugly, but we could #ifdef away both that
>>> and CONFIG_AMD_MEM_ENCRYPT=n in a single shot, e.g.:
>>>
>>> #if defined(CONFIG_AMD_MEM_ENCRYPT) && NR_CPUS > HVC_BOOT_ARRAY_SIZE
>>> #define HVC_AUX_ARRAY_SIZE  \
>>> 	PAGE_ALIGN((NR_CPUS - HVC_BOOT_ARRAY_SIZE) * \
>>> 		   sizeof(struct pvclock_vsyscall_time_info))
>>> static struct pvclock_vsyscall_time_info
>>> 	hv_clock_aux[HVC_AUX_ARRAY_SIZE] __decrypted __aligned(PAGE_SIZE);
>>> #endif
>>>
>>
>> The HVC_BOOT_ARRAY_SIZE macro uses sizeof(..) and to my understanding
>> the sizeof operators are not allowed in '#if'. Anyway, I will try to see
>> if it can be used, if not then I will stick to CONFIG_AMD_MEM_ENCRYPT
>> check.
> 
> Hmm, we'll need something otherwise 'NR_CPUS - HVC_BOOT_ARRAY_SIZE'
> will wrap and cause build errors.
> 


Right.

One option is we can hard-code the check for > 64, something like this:

#if defined(CONFIG_AMD_MEM_ENCRYPT) && NR_CPUS > 64
...
...
#endif

But this assumption will break if we ever add a new field in
struct pvclock_vsyscall_time_info. Hence I am not in favor of this.

Second option is, use KVM_MAX_VCPUS or NR_CPUS, something like this:

#ifdef CONFIG_AMD_MEM_ENCRYPT
  #define HVC_AUX_ARRAY_SIZE \
          PAGE_ALIGN(NR_CPUS * sizeof(struct pvclock_vsyscall_time_info))
...
#endif

In this case we will allocate few extra bytes which will get freed for
the non-SEV case anyways.



