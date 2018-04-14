Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeDNUbz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 16:31:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60484 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751347AbeDNUbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 16:31:52 -0400
Subject: Re: [PATCH] x86/cpufeature: guard asm_volatile_goto usage with
 CC_HAVE_ASM_GOTO
To: Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@fb.com>
CC: <mingo@kernel.org>, <daniel@iogearbox.net>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kernel-team@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, netdev <netdev@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <20180410204259.3981586-1-yhs@fb.com>
 <20180410210716.GI4082@hirez.programming.kicks-ass.net>
 <552d5866-912e-afde-f25a-77ae8390816d@fb.com>
 <20180413181924.GT4064@hirez.programming.kicks-ass.net>
 <a65f6542-8754-ea84-d1bf-076349b6b288@fb.com>
 <20180414101112.GX4064@hirez.programming.kicks-ass.net>
From: Yonghong Song <yhs@fb.com>
Message-ID: <339b047f-7886-967b-08e0-703cd892de30@fb.com>
Date: Sat, 14 Apr 2018 13:30:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180414101112.GX4064@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:180::1:2fc6]
X-ClientProxiedBy: CO1PR15CA0091.namprd15.prod.outlook.com
 (2603:10b6:101:21::11) To BY1PR15MB0070.namprd15.prod.outlook.com
 (2a01:111:e400:507c::23)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY1PR15MB0070;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR15MB0070;3:dvk0x71CfC7aI3gHcvWUw+ak6K36qzBphpnHBFIvb6/FpC+efqsGBYXYXQdd6MrcY3OYJWaoYRyGX8L4GpvUUBWiprTsV5DB5OSAFsn1SlKGhPWu3MsZNzN3MNCoEbqftcHk+j14K3drEwA18m+8X8xqg7HdKoyekyJvZeOry3FPNaSrREUvlCHrOJOgRhbH5wstRGspazDqFA+SaL36wMK39B2zS58jGPaZvqIgk3YV/srgHCJ+1mIU8MNC4jkN;25:8Zz0UMtSW+EJdOrV3zK5u8S4AHpmgoOMlwrF54oYLnsE2vXHb8ZS7cLXTV6nmdXzMTzywnX7He8b6AlzqmmIEYxvaBI1fqFHRt7mX0htJnEu8rom5FmABfUmGkdHbE4gN86TX/Pm6jlmTPMy+NJedCTmvwioEyKlHUceAUO7oQ/HFqujSCWBuPjnyvk0cP4eugjm+NczQhHuddWzj8vGF0J/6JBVEjq4HKPlX71cxDtTht41Sulk36tbNJr3MuGHtFVf+IDllo4PHz2PE73IMGuTsA5E904uaDRtJAnNR8RLoBgY/ONlZeGWUCeuucI+IDWnbu1dEtqwHvzEXyNa7g==;31:bYbb9ddOxngYraJJYGFOhBBc2JZ/RzKrYa634B6hCc4yiOuBERyFcpR1dRYmBML1ewDl6aJ6C2K4Zsx1c/rnk+IzZ+rF/5l1J0fzljGH21zA/tpOm71bv/HvtoQP2c4SVG2lqo4mrr0hf6OBvdLhwCpGhBrmZhQ4Hm4APANchWSRPAx5gyhGDQv7/Bt/hVEGgCdK3jafuJg6SH3WB1RGJmlEowCVqskt6iA3aG4wUfw=
X-MS-TrafficTypeDiagnostic: BY1PR15MB0070:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR15MB0070;20:EBqZIRgRBKRufG/fKwUxsrRCefO+XvDnacedeCZFSZ7wqe/+KqnGSOOluGPM5I7HcrU3ZyIxBLng7T3BiNaR/quNeGZw1yuXhFhOH46ggOc3u3ScTetG+Zej4ODR2M5W4Bh4Pu/gomZZLf9RWC2qLlHJsRpsdZ7eXrYX1eFlQ7lihGRFK3EMz+ZbKE7oxNdiToOeMApO6O9CGV9ySJTUbm6RWtn1Izcn+eXV/QlxbBdKOIkz27kvb98a7fVzGqxD1QqZroN3y41GmAmcCc/g1xSfi2uKZxC3UAroaBMIi7Wp25BSvXyaL+KWQ33hCw/aIOgGnN4Jg+UIG4T/oFaDM5FRKzf/VO9LcSZvwfMfPFOuysy3w589zH+4ldhApf+I5TV8H3zHWjVhcJeZEs/cEOQUjmRLmXxbPNJtFe1B2Vfh8e7HkpENFJfvY5BjbBbMv9Mmmt4h3iaOOE/1HYOw9tSCBjJ8/JY9Pm5K65QPmymrygGztEwCpIfW2YZMhcFI;4:Z5gwxD4hMRUnva/5kn2kCh1ylyp3o9N6L4FjPbpirXJngEAUicDHVGwfDhKHhT6ey17K8E4qxDsD0UJo65dgo3L5pbX8/K3iPdtyOEqVSS7emeeAKvhlOjKBDwH8+bcB920SXtWTQBlTVQPP+kEBpxJkT6ZWaNtKX4pgOUxcBmbmHV6CB6fhvWsiyCUCUHGzrh4lK0sETTeiOu+TTe5VPmplDhmr+iE4ATejPbaNaJEYA2PltDooCbuWuOOoOVGlOk+XVVFhZdSaQ95nW46Jwh7HGygvlpxXoU7qIHHh6+7xc3nBd682oz8xyLHkaF3k
X-Microsoft-Antispam-PRVS: <BY1PR15MB0070755BC697F9A491E49177D3B20@BY1PR15MB0070.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231232)(11241501184)(944501327)(52105095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BY1PR15MB0070;BCL:0;PCL:0;RULEID:;SRVR:BY1PR15MB0070;
X-Forefront-PRVS: 0642A5E7BA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(376002)(346002)(189003)(199004)(36756003)(2906002)(6666003)(6636002)(446003)(230700001)(6116002)(6486002)(229853002)(53416004)(31686004)(68736007)(67846002)(476003)(486006)(105586002)(6506007)(386003)(53546011)(59450400001)(50466002)(106356001)(58126008)(2486003)(52146003)(65826007)(23676004)(69596002)(52396003)(2616005)(52116002)(64126003)(81166006)(81156014)(8676002)(46003)(25786009)(97736004)(76176011)(6246003)(5660300001)(86362001)(186003)(8936002)(16526019)(4326008)(6512007)(11346002)(47776003)(93886005)(7736002)(478600001)(65806001)(305945005)(31696002)(110136005)(54906003)(316002)(53936002)(65956001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY1PR15MB0070;H:DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTFQUjE1TUIwMDcwOzIzOklNUEY0VG9QYUpONnJrMDQrMy91T2lkaEQv?=
 =?utf-8?B?eXRmVDBYRGpOcEhOZzJHZHJXcG1WWCs0TWFRVzBiT05RTkJlNWE2aUd5NTJJ?=
 =?utf-8?B?eFVrNXh4OGlzcGVweW5RTGhtZ1hkQmhkcit2ZEF5cUk0ZmthcUppdW5VWm9l?=
 =?utf-8?B?YllFcDRoNmhYdmlmenVPNWN2azJUbDQwQm16TVBxNzdDVjFoQW5pUnNBRTFE?=
 =?utf-8?B?Tk9pc1NzMmhIdkNKMHphNisxaVdXcEM1Z0VSY3pBTjI2elVCQmEvMHBqR2dt?=
 =?utf-8?B?ZUZ5T1UxdEhNcFJwa1lSVTd2L3dNdWw4L3gyQUF0dWluamYrWmpaY3dWM24z?=
 =?utf-8?B?aXBUQXFRUWdRdlBJcGx3OUZLQnBtT0tUd0czUkgxakFjRFEybGNtUVVXeHpL?=
 =?utf-8?B?N3RTZGR1MFF5NnkySzg0VWczOURRZkpndndibzBzT0ZjYnNFK0hBZHZDN1ZT?=
 =?utf-8?B?L0U4d0dyMlhmV2pvTUtERnlleGk4aFEzUzVXQldabU5oOWM4bkUvQ1k1bGk0?=
 =?utf-8?B?MFRhYTBqUGJFdXRpNGRBdm9GMW9FWXYzRllhdDRTVVJJRG14aGQ4SU8yTjFU?=
 =?utf-8?B?Q2VnR0VvaDZyWGFSMTk0QUNyOEV5NjhaWnBMRVdJb29md24vWGkvTHdtYmVa?=
 =?utf-8?B?Q1ZZcHFlajM2NTBBMnJ4TGovYU80ci9EbDlIMElMc0liU2g5SkhwcmhtbE8z?=
 =?utf-8?B?NEtQczRxenY5dVdRSEg0Z1JiODR0WGwrdHdXWURSb054VjE5aFVBWGtwOVhy?=
 =?utf-8?B?UGlFWUhRejVwZHpLMjFhU2djZHJyQzdpbm5KYzAyVVhMSWN3OHQxYVArVW5t?=
 =?utf-8?B?bzNyUFpwTTVYS1JkTGExZm9GNG8rejVXRkI1ZkEycENHWEE5TmQ1eFd0bTJ1?=
 =?utf-8?B?bEhueVhVYVJmYmlLS2ZHeUdVbXV6WmlzODBpMlMzbzlLMVkxeFRNM1ppb2t1?=
 =?utf-8?B?YVBxeGYyRTB5VVU1THo3a2xjZ0lzYnUwZCtFQWFxODF4KzcxRDB3ZjdySk1C?=
 =?utf-8?B?WUtvOXcyN09ydFpRL3c2SUVsK2FLdTdicGxYWFJhVW9id0pLZDdDSjg1Z3E1?=
 =?utf-8?B?Z1l4cENkSnVnNlRPcGQyTlcwdGwyUFNuQUVKVFJ4Z0pDRDYvT3V4ci8rTVBV?=
 =?utf-8?B?K1BsVDhPeG5DWjRyOVo4b2JXeDRqMjBJV3Q5NjMwdjJ0Rmw5Y3gvT2F3TVVC?=
 =?utf-8?B?SHBleWk0bmZLUzByZzYvQkxJSkNQZUk3b3F3M2pjWVY3V1F4MVFLMXN2endZ?=
 =?utf-8?B?eUErbVFlc0w3Q1ZjN2tUQWpiM3N3d0pFZVZSc1dvVG51ZW5BQ25LYkQwU0FF?=
 =?utf-8?B?anpSYkk1cVlSMnNTUDdzWGZtZHNjQTdmZnRXcjBoMVQvSlVlUngrMU5xR3VT?=
 =?utf-8?B?akZTRHR0alNraWRSSXZRblE1UTRReUJYcmlKNm1zSVdLK2ZUWnMrRWczQmFJ?=
 =?utf-8?B?ZkQvLzJRU2FGSHlwaDN2MU9yS2drY284b1R3c2ZsbGQ4ZTIwQUZHTi9KS3d4?=
 =?utf-8?B?Q3JrYXFKamo1SW5VNmNCbno0WTdmZktmSlpKdFErUEdkK2hLdWI0R0lsVHg3?=
 =?utf-8?B?dmwzNXhKNzB4YXA5aC9rUFp4WFZlYjVlbTdNR1czV3RaSG9RWWQzTnVGd1Rm?=
 =?utf-8?B?Y2tYQ1NFOVlQRnRIYUlZL0IxY1o2SklRSGczQVFWQ3RJMXBBN2tVb0JkaGUv?=
 =?utf-8?B?MGhVczVTODE3cWltdzFsY3ZMc2cycW9pOHRZQ1UrNkIrV2xoaUxicnpUdWZG?=
 =?utf-8?B?eEtiTm1CUUNOcCtsenVkbllBbkx5aVFGK1pGejM3MGtyWEZmK2l6NjlNcUhO?=
 =?utf-8?B?L0t3SkRZeDdQR1NMTXFNWDJXWUdzd09yWjdHTm9kOU5GUjcrVTBzejVDcytJ?=
 =?utf-8?B?dzlOTnlvV2NBRjk3aVZNZmdlUUpoWkVBSjMxZDBOQm5heVVFNjBnUzFrZ00v?=
 =?utf-8?B?MFU5YnRHYkRWMTJDdHVoa0hRRERNTDZjVTd1Z0N3RDY4QzUyRlAxaVVPZ1M0?=
 =?utf-8?B?RFRrcU8zTEVCUzV5Q1RiZU44Mjl5MUJXQ1FFRFpiN2FjdVJlcGk4ZnQ2RW92?=
 =?utf-8?Q?LaKU7A5TKlS2/75cl0mKu7qAB?=
X-Microsoft-Antispam-Message-Info: snmqNM/+Irvwed5RkLnUaVz+4tX+1pcBSzRK33ifGSw8z8th+hY0RwLAH3jWx0OuaeBtHn+xaAT63raisB9VmzBDd/4QAdLmfKNUBzJBDPaV8qZnFcmXpG0ehSMkG9tQNIP2M5f1CA/ILMXxZFX/LDdd5h6EXgOMCZS2tJrj2p1779pC/68S7ZSJZxXxncFf
X-Microsoft-Exchange-Diagnostics: 1;BY1PR15MB0070;6:37/mTOXWIyveC0BkuTnm91O9ODDf6JBCLWPWOInzS+R3qwm2PEHwJjNoEt6RGCe6CuKfwpCcmlpQ69cf3MDkcaaYjdYH8EVBimCOVUYKs418+ubMID2iZPvnu3y/hQeEtCmKzs30TwEadJvK+pl64jKgBRLe0IviEJ/y29VtnclrZcS/F3M4y909lbHO/B5lCFXagUaf19ratsf3G14vSb+qXz0ShgPY1SL4WtqUkd1NamO0xNpub+W6AstKnW+o3qqU+htdEBJ+lD47FnQQDOZzpAH6xpyCJ/oIbWf+EwfPaOX6XR+0M8gzSFsOVsAy2McYGsOzaCDD0LW+EbapHRomS7kDwAZmeVOS/fvvPIU9BtC7JR1VoALGgHDWhOVHh3Y0YEDeOagRkJnwIx41tw0NASm73R+skBeMja2DIHoOMc6lo1F5caAJYLk6RFW8zBcLv2rtPzdjxaE34eELbw==;5:KVjP6TwqLRkrH6YiuJMncyxwTEzHpSEbIJQ9s5gcuQ0pu0R6dMblOrDUfLLDGgh3MYGVec2/gtG+J/NmU05CV9iMtc+qF2jGALm3jJ3Da9xXbLx8kF9VRiRCV+vQAJCueDKlhHq1xGOOb3a3+7FKtd/MBE17QwJEUBdeCsYz2zI=;24:z4dOoWiObnDO30e2joEHK1IE9AchRK9hgfe28f+63MBHsZv9Lmaieo902g5UiogB+B1Bf1GN1aL4ddoW97Wvo8qeH+NRqhB4nHrEb0OWCRs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR15MB0070;7:c36z/1MlRmQ1ljMMoh8G4h4xI+jsUreAlH/GcQWrOqdYkjUdKaMDxqyIKpobkQD7vQFzuMB3uG6h7awkjx5ZU7f8xYRQigDsOKVD0iPbQ38rOzpS1+LR23oKaqaSSecO0FSjiHC1BxaY1MW58PL0JUeLdvxM3k5Sfl32IlbnqLh8zrVsfBN/r9YRip/YOhtC0jDGrEectv7nG8rP75bp9TqTh3Cz6Q7aq1sLPO8sifPUhc1qR9kfO2wD+SUoMTct;20:LkJVfYWV64s6Dd4rttBRfVd/LbfRRZrTPAefictN/tndDLkRtYX2e01arx9NrcKVEBhpi0ElZlbwsho7TYyt1SsMlWabjx80MsOoGdlekntAtrjIS82INU74E6qgUWlV1CKBroHfhEuVVaIWna3wL5AG7MUjvsluqRn27MWgM+I=
X-MS-Office365-Filtering-Correlation-Id: 410ad17c-a611-465c-582b-08d5a246a2f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2018 20:30:59.7707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 410ad17c-a611-465c-582b-08d5a246a2f0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB0070
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-14_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/18 3:11 AM, Peter Zijlstra wrote:
> On Fri, Apr 13, 2018 at 01:42:14PM -0700, Alexei Starovoitov wrote:
>> On 4/13/18 11:19 AM, Peter Zijlstra wrote:
>>> On Tue, Apr 10, 2018 at 02:28:04PM -0700, Alexei Starovoitov wrote:
>>>> Instead of
>>>> #ifdef CC_HAVE_ASM_GOTO
>>>> we can replace it with
>>>> #ifndef __BPF__
>>>> or some other name,
>>>
>>> I would prefer the BPF specific hack; otherwise we might be encouraging
>>> people to build the kernel proper without asm-goto.
>>>
>>
>> I don't understand this concern.
> 
> The thing is; this will be a (temporary) BPF specific hack. Hiding it
> behind something that looks 'normal' (CC_HAVE_ASM_GOTO) is just not
> right.

This is a fair concern. I will use a different macro and send v2 soon.
Thanks.
