Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbeCUP5G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:57:06 -0400
Received: from mail-eopbgr50139.outbound.protection.outlook.com ([40.107.5.139]:63664
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751653AbeCUP45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:56:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH 5/6] mm/vmscan: Don't change pgdat state on base of a
 single LRU list state.
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20180315164553.17856-1-aryabinin@virtuozzo.com>
 <20180315164553.17856-5-aryabinin@virtuozzo.com>
 <20180320152550.GZ23100@dhcp22.suse.cz>
 <232175b6-4cb0-1123-66cb-b9acafdcd660@virtuozzo.com>
 <20180321113217.GG23100@dhcp22.suse.cz>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <3c5d5884-44a6-0c7f-dca3-adcde718e5ea@virtuozzo.com>
Date: Wed, 21 Mar 2018 18:57:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321113217.GG23100@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR06CA0151.eurprd06.prod.outlook.com
 (2603:10a6:7:16::38) To AM0PR08MB3252.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 765ff608-44c2-4699-00c7-08d58f445e1b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3252;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;3:UlobJUxfyOGW3xuipufUqTBuYyqizflrKoJE3BWrVfgAV7LSbRxCcHXq6O+WZ9GQhjXugigz4Q19+bKz71pKF6EOkUYae7N+t3t0VfRhEpxpUQIsoH6w2WKwr21KKP16HeB7F4pMEq73DYd5RyF3WSaCO1e5HuwOe+4lPa4s79ol7XjdeIiR3oh3IKBdmX9xY3o0R0kTTg/xWyxJcwbOe58OOw+sXDhEwCYQThD5ZyfhuRc+LHOeoB2x+XvWPt4w;25:SxoVorBkdbZMcwAzR+gAjgGaNgeW7ZRTLUmGISmj22p1jqAP2NPsThhf2T5cS4wuLhd9IdDlssAzq0iX1Xk71OSD+Hnfpz33tF3TcfMwtdyIYvKml40m2CyhPsOnFkubeUj5xbob3dUjA6QKbLFIDukSHxcBsbbOEI6Im7v1uvdUwYv4rz4rTEqrhllglWm2g4rbes80pj/0sX8+uEP8qb2zCrn71vE8o2ysBtlhGv3Rquex39dos8wMK7TMs3TBufiNrSlJokWy9yYFgJD4qlFN3+sIZ6LUHmgZJlO1/pP+G23i39z/X+KUswgSrDyzplkRcu51kb5fEngmiwzG7g==;31:Q/cNUvfGNo6dsr/dLsJQy74UDdaMzAZyNLMA/fVm5Y9CmzagfPGg4x3K45o/xyiD9I7v9PRSWg2ww0xTPH+/7onRVGoTpm2roZq9W1aRTp1wPy1heQuqVf5YZqmWLTgqx0zZghvwERxxpk9DWttGKeLIurcb9xYKk+nBwWZa6motGhU0uUwxiKSpYuvp9Y2chRWSTBLvu6zaCkkWtVv0RNe3zq2GWvmflewWoYhvpbo=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3252:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;20:xLIj21exY51CAhaxNR8z+GwwzageZ8YNgPiYKJp1+5Y36D0f3jYhoGWeHdzRL5SeRcgcF/cerCCW2/tRJLKSBMiHW+RCw+NxwxXhFwuIIoadGNgs0TkgxKQXUrTlW24mxkAtkdNDU6AyhuTkmFfi4HuHV/sjKVURQDmrjktT2bc3kNH7EMJ+M2aBxwXDY+zz4PH/NNLpaGQeUPOS5P/XjYfaIoxe/08Esg2pH+32coa2XM7XEtauZLGRnnA56YhBddz5BWK6yBtM2iM27VBgdykIKDWfjSWKJPrw+bmiDrAMfJVO0xJ+tmkniDeIZUAxS322tjZU5dtPBe8z6BAlkKs2atJkWCqABLT12WldFZsKP42ds/fhbA5+ajtejZrpLdsxDNSVBDUDSVU5Y8Wz2LN2YWiKLcfteFCFMvCmGdB81uvk0frXGW6r4mAS1w22utiXkTUHOSt70a0FaIAzLZte8FH0JRVTM7IT2GXc8w6IK//BFAcfyLMjrHN4Rfsl;4:1sa3FL4MlLk6gwsVirpPMnM843JjU/HCqH8AjOb45NEmp82Mrx1kFZrwE4ZSInYhSHI3CgDJ6wbtW8YHfRBkTUhvzsaW9mCBs2TXG2Ag2zyhFYPCZwmukOmkdc/MI+TEHSV/JFRZWDkqAPd6J/iqpSjbEkAuFe1bbZ3+T1Lw5ZHUQLS7AAyBr4LgJZ9gZy4HZYxmXQsTgE8w+9IqtI4UkzPuNx+JRVSM4oCeX89ZHnz9Qs7JX9Bto6XwRVZUx1bwC4KqIaMkthDwvsKSkMWwiQ==
X-Microsoft-Antispam-PRVS: <AM0PR08MB32525D5F9E98216E49FB1C77B0AA0@AM0PR08MB3252.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501324)(52105095)(10201501046)(3002001)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:AM0PR08MB3252;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3252;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39850400004)(396003)(376002)(39380400002)(346002)(377424004)(54534003)(189003)(199004)(8936002)(53546011)(52116002)(52146003)(31696002)(86362001)(66066001)(16526019)(105586002)(47776003)(65806001)(65956001)(76176011)(59450400001)(106356001)(97736004)(6666003)(2950100002)(68736007)(31686004)(229853002)(6916009)(386003)(81166006)(2486003)(186003)(23676004)(93886005)(230700001)(4326008)(25786009)(53936002)(6486002)(81156014)(50466002)(6246003)(77096007)(58126008)(64126003)(7736002)(478600001)(305945005)(6116002)(16576012)(3846002)(2906002)(316002)(55236004)(65826007)(5660300001)(36756003)(54906003)(26005)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3252;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjUyOzIzOjZTZFYyNEdZdlZwMityMnVyU3p3UUFWMU9V?=
 =?utf-8?B?RmNuWGtBS3pzRjh2MldUU2pmSS9DRDBjTTA0aVEyVDhoZVlrRldrY3NWOWs5?=
 =?utf-8?B?RUdFT3AwUHdDblBRUVljL0hpMGc3THVWRXRVMjRrTitVQWg5a2llNG5USnA1?=
 =?utf-8?B?NFpFWTBjWXJ3QmlwenFaSklKdnJFTGpyeE1rRERvRmp3SFJDbWw3OVRNTk9N?=
 =?utf-8?B?dkQ1b1d6TDkwRFFLNHBkOWwvNXZJODRvdENVNmZIT2tPMGFJREc0VlVlZm1y?=
 =?utf-8?B?a2FDRFhWSXN1ckczUE9CMkgvdU1xS2E3ajhpM1N0aGhMNDRMNFh1TitVcUFH?=
 =?utf-8?B?bXVELzVOQWM5T0VhL1lJZldBZTNNSm8yRHpiUjg2citYZTNKcDgrMHhFSlBs?=
 =?utf-8?B?ZmQ1RHlLZ1NCcU4yYUFXeThkQ3BtaFVQSFFGa0JyUDBMU2FDVS92Q2hrandD?=
 =?utf-8?B?MGtidnlGMnRWaUsyZEpvWUM2N1FvS0gwcVJXZzFROWs3dFUweTVBWVJqMElK?=
 =?utf-8?B?UndzcmM5UThOVzhEWXVyS3NtZmtzVGFIQWJVcFQ4ZlJ1dVBQVVFsOW51ZzdE?=
 =?utf-8?B?UFhKTytnZmNPaVBTVXJTUXVUdG04cWg1akk1RFhlU0tNOHZpQW0yVkRmcEFa?=
 =?utf-8?B?YlNGODUwL0ttMlBkMWNFSjZlb3hwWFNZTFVPTk5xd1hMSURnMWVLRVdsTkFK?=
 =?utf-8?B?c3RvSW44N1l4aEhoS053VXBEeU91R2JZNnRXalpkcnpRRkowSG9aUERsUVRn?=
 =?utf-8?B?QnBDcERabytIanJwRGk1ay83TWY4VExEYTJHMjAvcTJGaU5vSlpVa2tobjds?=
 =?utf-8?B?SEZEdk5GYkhMejJpVW5MLzFhbC9LRkVoZ1U5ZDV2WUtTeEFXTXF3aXpmdTAy?=
 =?utf-8?B?Q3M1UjFNMmVva0Z2SU5OM0Z0S0J1MzVmMzFkZGtSWEZtbmlKZ1Z4V0tHTitB?=
 =?utf-8?B?bll4Z1ZxR1cvd3BzL3BsRHRLN28vb1VJNUM2aXB1Z2VoVkJPMWEwZHlrSlFS?=
 =?utf-8?B?RVhzeWFLVlVXWFFOdisvWWxiLy9VTFFHN050WFQzOXh1RVhjTldyeHJPSWZi?=
 =?utf-8?B?T3N3OWZvbGVZRStGVisrc24va2dEa0F2cmNDN2MyTmJHMG9MaE5KQlRXMTJp?=
 =?utf-8?B?L3BiV01FbDJVQko1VHJxWUlXYnljSGVteENtS3VtVG5SOUlPeXVxY3dHMTNt?=
 =?utf-8?B?dUZoLzZLZG96Q09SYWRXTDNzQU5BR0phQW9ReUZuM3ZPYlVKZnQ1RG4wNWtW?=
 =?utf-8?B?WGl2YmtNc3RmL0FROUdxekZhOFdYMjdSeThHamNxeEwxeVl4TWpGOTdySG1m?=
 =?utf-8?B?WEVkSTBCLzBoVWNQT055TGd4d0hQb28vbVdJWVIzZWRtaUtmV2VIRzdLLytX?=
 =?utf-8?B?V2tDNS84T00yR3d5STk2ejQ1cExlNG1pVys3NUR3dWVXaEZ6OWlCdGFQTVdR?=
 =?utf-8?B?S0pGODgxT29mekc2NkkvUVVMTGxyNFROeWFWU3dJL296TUJVM2pmZ3p1Qkkr?=
 =?utf-8?B?Z1VkUzVNY29KTkdxSUpyc0tYNkpDN205S2lxT2U0Q3ZTWVY5VU5KeEU4b3dx?=
 =?utf-8?B?T3ZFM0RUeFF0Ymtld0ozYml2KzE4dUNJTklrQlR4UmxONmZWTTJmVXdpWmVr?=
 =?utf-8?B?b014UWtWTHFvTGU5V1VkNEp3ejVkNFhoZWFvVEgxNUh1ZXp3bTQ5UFVSZElG?=
 =?utf-8?B?L0hoT3dHY0dibGorY3JBYlUxSzZrRWlQa0FIcTFTWVpqNCtoSHdlOTZkZDNZ?=
 =?utf-8?B?bGZRS05UdlpsbGZHUkVweGpya3BwSUltMlhKTC92cnRwUVF5SXNZRmF5aUgv?=
 =?utf-8?B?SEVQdHJFYnh2aFdrQzNtUlQ3Ylg1VVphREdIV3JBRWJ5Vi9OeFR2N2pZNTVi?=
 =?utf-8?B?bkw3ZlNPTmh2N2NuQ1JrR1FQMmxqOHFDWUJTK1FsNTRwTm5YYkhxcVpNK0tl?=
 =?utf-8?B?NDJQazhuNVlIUmZ0ZTRtdFRGWXJzV2xKN2lKTzBTYnA4UlVlN21hbG8wUUZ4?=
 =?utf-8?Q?9+uH6A?=
X-Microsoft-Antispam-Message-Info: ncshWETtA2smEQr8ffgS7qXK7sL3dKCo04z2GjRD7qC+F4kMU/7nQ74sYEnXma38txkdSXKDnltiXZ1jK66yn6pX0/zMWwxlYpJDwovCkrv3rLEoOYwZZabJRBWkyDUS4BGOz3xDXRE4VJ48LO9ubyRxhewLYIaV4f0uqAXSQd6+XZ+zlxOksG8kiFQrykj8
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;6:S32wQM2DkmvZkRLkCsrWmWq6ZvXkxH5F/8H3icOMCPMS+MXdwOQgc8eGy9f0BstXHutUvA207Xuyee7v/vYmP9TNnTCKtf38GvyEsPoKOWC93qKYVRml/xKrWikju7e4b5+XeRYhfiAFykcKdXtLFeXFp0vEFHsw0LWCCPbghmRVVdNtBCw1qWx7gNmcPXSdEA3UDZzyC1nqINGmf4CTYCjhwhu79OgONykSF2vNa2ZBiK/02+ZpQotP7WolJz9wFyQHofhFMz3brYKFVeBVchj2C5FdFXB7PVD05yVtEtkXvW6BJJIfnvJS1YJ9+WV9oy9xjOz+f0bCB3Z+U/izDNSYZck7p97slMaQUv3qWi/FZb4kVjbjJXUKbUem4meRBMGY3E8PoY+8JzmtsBu3RFPjnM85ZMKaVc6U9QmkrfSTi2yYKryXoLL4jYanT2fLCagXW/O092x6hfAX/B2KbA==;5:81lzABoGUP/SoovoHA4EDKhjn8sSIsxGMMbuhrxTpVWFilTi3fCTKfjnz06Mu9/t5V3zXNiMZEcyOiJlVqcQmjeF3zoYJq/CZW/lgTscop57sFDw/A/ByuCkFT7UhIaKJqAoSzQERnjlekGt1y0LsGfxrKCiHLZmrjKWNWNSdAo=;24:1PyyyQc8nYOZrV5FxuSdLI11SNHNilzpFZaP9I0+9eKpkRNXnKX+bmxT+snzmTm71mXKi3+0BZoyx7OYSXJG/S0JCDsDqic8YMfgz9eKbEk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;7:R44r/of8tdmSy094i2OHqzc9wNPeFpxGvd1zwYYI1OyIyLM2zt3L9lFaQH5wtuJo85Shx/HOvS2ha1ZY/BXns73p+pFY39BbBspTqr1e0k891LZu3KQgz6l6zWqTrJ/zZfrSXOx94nw4qxADg29zwp02cQIlsUTIsiBfnacWQ8E1twFbWpjC3eZ7hlXe1JvMAcqxTQoJEigWVaUpiA28aVIn9OAIybyj5L5JjZeITXQGRPdZmsdkr/2lPgqHja7W;20:fkj6DGB+3C/X88YhcJVeqd2oCBmFAWphuY7W9Q+cPNIdp6lnDl6/gVoUD9yJgujRbSSAM7YnGmEZNhMJvBltD1rPcch6D9Ci1PNRsn2+MttBAXamjaiRXXqJlIiznS7p3wok4oMR3VuMAstNNSAo9bE33T1ah5clDPl18mgR99s=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 15:56:53.6075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 765ff608-44c2-4699-00c7-08d58f445e1b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/21/2018 02:32 PM, Michal Hocko wrote:
> On Wed 21-03-18 13:40:32, Andrey Ryabinin wrote:
>> On 03/20/2018 06:25 PM, Michal Hocko wrote:
>>> On Thu 15-03-18 19:45:52, Andrey Ryabinin wrote:
>>>> We have separate LRU list for each memory cgroup. Memory reclaim iterates
>>>> over cgroups and calls shrink_inactive_list() every inactive LRU list.
>>>> Based on the state of a single LRU shrink_inactive_list() may flag
>>>> the whole node as dirty,congested or under writeback. This is obviously
>>>> wrong and hurtful. It's especially hurtful when we have possibly
>>>> small congested cgroup in system. Than *all* direct reclaims waste time
>>>> by sleeping in wait_iff_congested().
>>>
>>> I assume you have seen this in real workloads. Could you be more
>>> specific about how you noticed the problem?
>>>
>>
>> Does it matter?
> 
> Yes. Having relevant information in the changelog can help other people
> to evaluate whether they need to backport the patch. Their symptoms
> might be similar or even same.
> 
>> One of our userspace processes have some sort of watchdog.
>> When it doesn't receive some event in time it complains that process stuck.
>> In this case in-kernel allocation stuck in wait_iff_congested.
> 
> OK, so normally it would exhibit as a long stall in the page allocator.
> Anyway I was more curious about the setup. I assume you have many memcgs
> and some of them with a very small hard limit which triggers the
> throttling to other memcgs?
 
Quite some time went since this was observed, so I may don't remember all details by now.
Can't tell you whether there really was many memcgs or just a few, but the more memcgs we have
the more severe the issue is, since wait_iff_congested() called per-lru.

What I've seen was one cgroup A doing a lot of write on NFS. It's easy to congest the NFS
by generating more than nfs_congestion_kb writeback pages.
Other task (the one that with watchdog) from different cgroup B went into *global* direct reclaim
and stalled in wait_iff_congested().
System had dozens gigabytes of clean inactive file pages and relatively few dirty/writeback on NFS.

So, to trigger the issue one must have one memcg with mostly dirty pages on congested device.
It doesn't have to be small or hard limit memcg.
Global reclaim kicks in, sees 'congested' memcg, sets CONGESTED bit, stalls in wait_iff_congested(),
goes to the next memcg stalls again, and so on and on until the reclaim goal is satisfied.
