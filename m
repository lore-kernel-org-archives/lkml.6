Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933271AbeCSLZV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:25:21 -0400
Received: from mail-db5eur01on0110.outbound.protection.outlook.com ([104.47.2.110]:11824
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932804AbeCSLZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:25:18 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH RFC] xfs, memcg: Call xfs_fs_nr_cached_objects() only in
 case of global reclaim
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <152112607662.7371.16175767692798928059.stgit@localhost.localdomain>
 <20180315174903.GM23100@dhcp22.suse.cz>
 <c6a9bf24-50e6-8e60-94af-28e99c51f516@virtuozzo.com>
 <20180315230313.GM18129@dastard>
 <6628c551-f607-367b-1ee6-f458266c1d92@virtuozzo.com>
 <20180316213910.GF7000@dastard>
 <18a031f3-2136-4ef9-6ede-05f5b835661c@virtuozzo.com>
Message-ID: <435c3d64-7806-8a85-fdab-30d8bdabcd45@virtuozzo.com>
Date: Mon, 19 Mar 2018 14:25:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <18a031f3-2136-4ef9-6ede-05f5b835661c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::33)
 To AM5PR0801MB1331.eurprd08.prod.outlook.com (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53b89d52-b880-4cb0-35c8-08d58d8c161c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:wXy7I9Jf0P399bPJ9qsl/IIqWVLpaq5fWtGOuAwYiIwKQuNDUUvPX5Ol469j/NEg7QutDLhg/u9ORwWIvdbRWb9O5D0iy0k0/3DviklU5sE0xqqj78OdC+lU2nk8TDLnPEnVyqyxpMvrHzk0K7vUR0omr7L74TkpOwk5D8UYkI/Bl82Z4UQrxRJ8DZFNOx9qF8C5rI2yl4tDLMawNp2Nkh5sQHdxoYviqur2A+09IsZAD42qcobhY0HniY7HxTLb;25:XoFjUAqmY6/E2p5lYvnVy3+xAftMKoXJevV27VIQC8kaTgIt8vnhqlDhI7AreeswmM/lEdGrCqCYcGhIvELs6c4ukGC0xyGzSB5rYjCz9NVL0qXLDZIG0l00fdxScXH8aNuPs/WuMAPb20vWPpzjS5i2aE3wTmOUFHwlbuWNZw8HZnBx6HcH1+9aidKrBc8nEkBUpU0Asxhsm3bu8+3Y3sMfvjewyZDWLgzPB3N5BCu6jqdd7gUoFILjyBHsC2ewyj5qQEc3YSUv7azeEimPvwLoydulJIzI21loojvtF3kHsU7OAyCVb0yGaoPISN/w9+1xnuQHXQzxhWsGtPDGqw==;31:1D1LHQTqneLEFnTKb8QJb/Bbzqq3YDb8fNSzU30WKwt+JVfTWCAXSBNcALqAB6hCcbBbrYjtg2BzYkGkAv3z0gDa2C5lj+tNVo38UFI+Q5pqg+iJRVOuCeexFV/a2qnNfFrGYsrMthI3GLK2E1Fe0NiZjtpIjyOAuJhFrJSj+a72KO/EjlJOTSuOOXhFHJXwHiaxI6MXu9DohKiMeaTs27w2nV3n3MbeorbaKSb/XrI=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:Lg4UPOUViYbrdQxKBlIFTUdq2BiUwuKJRx/FtzV1EExrRWvlpc+hdo0bgSK6m3g0rEbcu7DMvxOSdxq0+7ICb1v3yh34cfOCOHFlwUlPC/KwHFokgxl7sopMxzbXTm9yr0srL65qwe8VwS4SugAgMzGJ06xSknpRV1dH+udRSwkOXJTEfijhJ+BJbaw+zXxeuo+S0/figNiebRJNz7SvYUpvX4lXzx40EurzbpFejo8uG1Qgqwpe0YlYbGHLO8R3MPw3IPAZ5wDuOze+eVI5HCb5Sg+sI1nzkkibigle9pSDtGMsRGB19uDbExO/wSQQe4/UKC8z14gYS+7yQ51B5sCT4QOTuTvw4qPxd/71akYL5wAH479dnT162ddylN8VmWH5G1T/BRBk0KK/wUzZf75yJ6DCtRATLWRpPVooLgZJEEE2i2v0AquSvFDPSdsw5VvIBOZnONLLiB3lupOeyqJiQQTSQPQjnwP9JsB/ize7BqO3ML9tjZo6Z+kwQvNq;4:TB5LOkMGZq2w6Cgw76ERRqmWThQcN7Wt1nIrRdVy1o+WRpCLMXVJ1aR2ptHvmRnkanjTVeTmruj/WQpuqViKEMLPPiP9g1DqRA+g7a3q6yy7pWBymHNYNVVyHJV3b5mdBX6F6uB8xu4GsEXHKUeR3enm16k29FEW8jrn9yHRIYW2FL6Z8jkKY36vOaHmPGivT9n93JPSwpbwq156Lz01tbB+Dg4ZXGmMMg++8f9UTgAbo9Sn8uPDPiw940LycEkhyg8fsvnvUEFniBOYMeK6rWgM5m6oAGmknY2pTDi6QHbEzYD/3o5CnDFdXhftVT8h
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1331C8C83A408D88295EACB1CDD40@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(366004)(39840400004)(346002)(376002)(39380400002)(199004)(189003)(377424004)(16526019)(47776003)(229853002)(316002)(386003)(16576012)(53546011)(36756003)(55236004)(65806001)(66066001)(65956001)(50466002)(5660300001)(59450400001)(26005)(77096007)(305945005)(65826007)(76176011)(52116002)(186003)(2486003)(52146003)(7736002)(23676004)(6666003)(230700001)(6916009)(2950100002)(31686004)(93886005)(2906002)(68736007)(25786009)(6486002)(4326008)(478600001)(8676002)(31696002)(106356001)(105586002)(53936002)(6116002)(97736004)(81166006)(81156014)(6246003)(3846002)(58126008)(64126003)(8936002)(86362001)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6YkM1bGpuQUZPYUhXNnQwLzdSUkxDNGhp?=
 =?utf-8?B?akw0Y0hmQ2E0bE1nclNBRVc4NmlGbjBUd2J5SDg1NkFidkV6blRkdEFNdEhj?=
 =?utf-8?B?YWdCUEhqVHJSOHdPMXBBdVNRelhKZC83MG1NcmFvcnpodnVCb0hLMm41MGNP?=
 =?utf-8?B?NTc3UENQYnlDc3JkbUVqSmpLeUFTblNQWk9KOUFEbFpoMEhXeEM3K2dWanZo?=
 =?utf-8?B?c1k2bzJrMTJUazljaWV2dStNOUh3V3VvQ01aSWhjNm9LOW1NZm0wME5qSTRS?=
 =?utf-8?B?WjlNdWR2dm5haWJpTExpcjVWcFFhYno4MjFaR2lzUitGTWhRMHZmNWdMVzBV?=
 =?utf-8?B?Tno3QkRSNXBYaDFzb2pJNjhyTzhMdUZKQVJZQnF6SERBcVdTSkhqbGsxcmdR?=
 =?utf-8?B?UTJJRllST1VhenRwTXRhcXhZRDhNSmlIUm16aUVxUFVsNm9PYUMvdTB0U2hF?=
 =?utf-8?B?Uk1XSTlmbmNnTHcwZHJpclJuUlRGRVdnelZLTGxWbEE3SjVZRHNhZElobzVP?=
 =?utf-8?B?aGZEbnRnNUtQMjEvMzc5M2xidXNjbGhRTGZQTXlxSGFCdG1Yb3VtUkRzWElu?=
 =?utf-8?B?LzFoVW11b0pobFBzb1A2cjRQWHBYRFUyMnRadm1palBTYzkxa0g5cG54L3Yv?=
 =?utf-8?B?Qjd1eHR6NGhiR28weHRlSGk0UEw3eW41cEdVZEpIMkllTURkQm84NXFvZVQ1?=
 =?utf-8?B?TmxuNXFCdVhMMHlWYWNYaldjZkZLbTN3UGpDNEs1bFVTL0ozbXhHZnpacTQ2?=
 =?utf-8?B?Y1ZEOXIreVBZeU92Qmxjby9UR1N5TFFTaVNubnJCN09wUnQzYzFjbDlGS2or?=
 =?utf-8?B?djlyVXY1QzVzWkVSZkNOWW0yWXBKMnkxcjdFMVFSZzFmeTBTaFFwcVJHVWl0?=
 =?utf-8?B?SjFJMklHMC9kQW5tb01wNklDdzVIZ3VlRUpaQzk1VDNOZlZrS1liWTFXcEpr?=
 =?utf-8?B?MVNCcW96QlA4REtYYjFoV1dmbktwTnljTFlVdVcwaUZnOWliRmJVSjZQcEEr?=
 =?utf-8?B?VWhyZ1ZnYnFpYVVDOTVqRU54UzJ5UlQ4bGFYV3hKLzZldWloNnlrbFU1akY2?=
 =?utf-8?B?MDlEbnA0TVhUeEd4M0tXemVBQy93WG1ZZDUrUXZkYkF0a3dFL0FKd0lFMlE2?=
 =?utf-8?B?eXNNeTFaUk0rM2VBY1lyYnlHUUtuYzBGTVlaUjdydkJQY2NEZFBOYk5TYmRm?=
 =?utf-8?B?bnpGMHRUTmhpUWRkM3BlSkozTWJVdFpXYnZpM2IzbUhkQ3l5UGMxQzVmWWYz?=
 =?utf-8?B?UXRROGVEKzg1SE05bE5DQisvRXp2bWZNOWNsdWZsNDdwVVBPR3dGNVhjSWU0?=
 =?utf-8?B?YzlaZWgwSGtNSkVSWFhDSVR1L0hrNmhpdHR1blRKa295RS9YUU5wTWs4TG9D?=
 =?utf-8?B?UXN6bVlNSkVoaXg1ZnBMSms5OXpBaHRFOWtZQXNySzVMMG9aRUtGUGw5NFZw?=
 =?utf-8?B?WmF4cnhVRlZKQ3luN0l5UU9nSk90NDRPOEltd0FYRy9WaTg1eEZKMDF5NFhz?=
 =?utf-8?B?VHR0aTlLcDduTFc4VDRoVFQvU0lHTElmNmllNHA2dTdsYnZkZTQvVTNtK01y?=
 =?utf-8?B?UFc1UVBiRlhaVjdYMVNQUThkY3dSK3VtbVNVd0swWGd4RXBnelQ2WlVNeXow?=
 =?utf-8?B?cjQ1UmRqd3JiMDJLcHlKT0hBODFxRTNBNGhVUU1UcXZiVU1pV0lZWlRHeFV1?=
 =?utf-8?B?N3gxM1hLMnV0dURwRUphMUJGNW96TWluLyt5azNPcHJFR0FtRE1qbEtUVlJ5?=
 =?utf-8?B?Y3lHVnpPNnFFRTkxbEJoOFNQQXlqSTMwNHpRZjJDdU5qQVMxelZQOXpBbEYx?=
 =?utf-8?B?S0NCZzhOYlBDSndRMjRpb2Z1NkZsUThEL0xXN1BwWElNd2FtNU5ubzBZakpP?=
 =?utf-8?B?MGJIcUxHV3NlRi94SlI1Q2hmdzBlUjZWNnM5RUtKT0JWVDlHRHZad2hoRmI0?=
 =?utf-8?Q?oqxFrZk9lob2lu5kd51OvG67ec7bXsws=3D?=
X-Microsoft-Antispam-Message-Info: TYlGXUG1YR5/1Up3xU3D+EMzEoPzxZ6QcIByzWajqwRWLEyxIz8+dWAifqPsgNmz6PXiwqZyUKXX07ou+QquMnWlti5OIkL0vm+wQbKElb6P4HF3PRC3qcKbEXKqHodL/AU2SRrl6ECgzOMJ7pkSvO6FQi834okR4wiPHY6VxmFoQPD1v4ov/guoRgb2mDQo
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:5NJH1fkWip0yY//shHvt/L0n6Lm1u4w6/13XX7NGw0ok8yoj6DO8X2Ln/B7Zjlv/nGFbsN2ViSPXaLy/lZMh2khjt8OvkbBBSTkzWdz9v07Zt51DRKlGgskGbijPgdRCT6NLcmI1cLZdDJf2woHyoAUJOLBTMJEIMEUvrwQu1ni0HdIvW5ftbdnWIoZ5b26hDDy9kybecaaqgq+S9KkrLDk5Dio39msNcc73I3HfuFg1B4QfaRifnzv7YlBNCmmuwROmp1h2IIliZ7+2Pfa23aUaUNSKgs/KI8wkS+94ZtWOC1cE7b1Cqms6bBQPTlNdtqPHIqo2WTJ2PLTlCdHky5jMCiELOwnz1akte/fStIU=;5:0qXiR5k+rZ5k44UTRHpnYG3P7NBtZRLH055r/5/V/iW+tsPHXjMb3hf5BJp84TEePvj11tGlHbkz/u3IcutB9qNcswdeziKYIQaUk/H2IWDGPA8mmm0MSmA0tlich+J7gbUv7OEBgW7MiyvDDfAiHcSyLUZ4kCECR479UWkW3CU=;24:3C5I1n+t8ZZo4EMTUdJltVDcOJfaue8T4fFb3pD4aUPyw6Kb8pdvLHkAuIu9IllXipJ4HODyT9PUn0VwTZhcosjbhv2Yuf40khASeVmx+TI=;7:dfP0zl4c/I2L/3JWWIwX2qGNJeafUGRdODDDJFwyBd+AZNj8fUBVXoHmjq+DyMd6cGODufhgzNKG7eknp+IMCMdnWg2CyakOEuafQYdCPVi8b8E3MlJ9U3ysBK3bH4ALtj4+IULJZqFxCD3nwJSpwEyjklFx/OLp6vLjYefWdZDeFA9BFpfajkY0yqMrjXKidzqDuqMZ/6AgV9D07TtkqI+LP3DE1nwRIdTluB7h9GDg6j5H32pEwJXc1gD+CPhj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:kaD2xeUoHNi6jHlPd7ACyGBauzRJ8oGHWKyZMGAjRn+uaD27Xdl5qaz7n6mNOAH511dmWaPKtze0D33XF+ZmnIQSLscVY9h4cwq4+/J2xnxyS+qMGziVSLqryPG232GBQFQNevd0HlBjioXAZ9nt/TfJBxlbY2jzUTCo+ZbFicI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 11:25:14.3365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b89d52-b880-4cb0-35c8-08d58d8c161c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.2018 14:06, Kirill Tkhai wrote:
> On 17.03.2018 00:39, Dave Chinner wrote:
>> On Fri, Mar 16, 2018 at 11:55:30AM +0300, Kirill Tkhai wrote:
>>> On 16.03.2018 02:03, Dave Chinner wrote:
>>>> On Thu, Mar 15, 2018 at 10:28:43PM +0300, Kirill Tkhai wrote:
>>>>> On 15.03.2018 20:49, Michal Hocko wrote:
>>>>>> On Thu 15-03-18 18:01:34, Kirill Tkhai wrote:
>>>>>>> xfs_reclaim_inodes_count(XFS_M(sb)) does not care about memcg.
>>>>>>> So, it's called for memcg reclaim too, e.g. this list is shrinked
>>>>>>> disproportionality to another lists.
>>>>>>>
>>>>>>> This looks confusing, so I'm reporting about this.
>>>>>>> Consider this patch as RFC.
>>>>>>
>>>>>> Could you be more specific about the problem you are trying to solve?
>>>>>> Because we do skip shrinkers which are not memcg aware by
>>>>>> shrink_slab:
>>>>>> 		/*
>>>>>> 		 * If kernel memory accounting is disabled, we ignore
>>>>>> 		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
>>>>>> 		 * passing NULL for memcg.
>>>>>> 		 */
>>>>>> 		if (memcg_kmem_enabled() &&
>>>>>> 		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>>>>>> 			continue;
>>>>>>
>>>>>> Or am I missing something?
>>>>>
>>>>> sb->s_op->nr_cached_objects is a sub-method of generic super_cache_count().
>>>>> super_cache_count() is owned and only called by superblock's shrinker,
>>>>> which does have SHRINKER_MEMCG_AWARE flag.
>>>>
>>>> Xfs inodes are accounted to memcgs when they are allocated.  All the
>>>> memcg reclaim stuff is done at the VFS inode cache level - all the
>>>> XFS inode cache shrinker does is clean up inodes that are not
>>>> referenced by the VFS inode cache because the memcg aware reclaim
>>>> has already freed them.
>>>>
>>>> i.e. what the XFS inode cache is doing is perfectly reasonable -
>>>> memcg aware inode reclaim is occuring at the VFS level, but on XFS
>>>> that does not free the inodes as they are still referenced
>>>> internally by XFS. However, once the inode is removed from the VFS
>>>> LRU, all memcg information about the inode is destroyed, so there's
>>>> nothing in the XFS layers that cares about memcgs.
>>>
>>> So, after inode is removed from LRU, memory still remains accounted
>>> to memcg till the time they are actually freed. I personally don't
>>> care, just to mention.
>>>  
>>>> Hence when the XFS inode shrinker then called to run a
>>>> garbage collection pass on unreferenced inodes - the inodes that
>>>> are now unreferenced in the memcg due to the VFS inode shrinker pass
>>>> - it frees inodes regardless of the memcg context it was called from
>>>> because that information is no longer present in the inode cache.
>>>> Hence we just ignore memcgs at this level.
>>>
>>> But xfs_fs_free_cached_objects() returns number of these freed object
>>> as result to super_cache_scan(), so shrinker interprets them as related
>>> to a memcg, while they may be related to another memcg. This introduces
>>> a disproportion relatively to another shrinkers called to memcg.
>>
>> In what way? All memcgs see tha same values from the backing cache
>> and so try to do the same amount of scanning work. The shrinker
>> accounting simply doesn't care where the objects are scanned from,
>> as long as it comes from the same place as the calculation of the
>> number of objects in the cache it's about to scan.
> 
> shrinker->count_objects() result is used to count number of objects,
> do_shrink_slab() should shrink during the call:
> 
>         freeable = shrinker->count_objects(shrinker, shrinkctl);
> 
> Then shrinker takes part of this value:
> 
>         delta = freeable >> priority;
>         delta *= 4;
>         do_div(delta, shrinker->seeks);
> 
> This is a number, the shrinker tries to shrink during the call.
> Let the priority is DEF_PRIORITY. Then, shrinker try to shrink
> freeable*4/(shrinker->seeks * 2^DEF_PRIORITY) enteties from every
> shrinker. Equal percent of every memcg shrinker.
> 
> When XFS shows global number of cached objects in count_objects(),
> shrinker also tryes to shrink the same percent of global objects,
> as for other memcg shrinkers. So, when you have small memcg
> with 128Mb memory allowed and small number of tasks related to it,
> you may meet 1Gb of cached objects, which were queued by another
> big cgroup. So, the small cgroup may shrink number of objects of
> size more, then its own. It's not fair. That's all I'm worry in
> this message.
>  
>> The memcg accounting, OTOH, is completely divorced from the
>> shrinker, so if it's still got too much slab memory accounted to it,
>> it will simply run the shrinker again and do some more memory
>> reclaim.
> 
> This message is not about OOM, it's about imbalance. See above.
> 
>> XFS does this for IO efficiency purposes, not because it's ideal
>> behaviour for memcgs. If we start doing exact memcg-only inode
>> reclaim, we're going back to the bad old days where inode reclaim
>> causes really nasty small random write storms that essentially
>> starve the storage subsystem of all other IO for seconds at a time.
>> That is a *far worse problem* from a system performance POV than
>> having the memcg memory reclaim run a couple more shrinker passes
>> and do a little more work....
> 
> Ok, this is a point.
> 
>>> Is there a problem? This is what my patch about.
>>
>> You've described some theoretical issue, but not described any user
>> visible or performance impacting behaviour that users actually care
>> about. What reproducable, observable behaviour does it fix/change?
> 
> Strange question. Do you fix problems only when you meet a reproducable
> BUG()? This is the kernel, and many problem may be racy. But this
> does not mean, it's prohibited to discuss about them.
> 
>>>> So, is there a problem you are actually trying to fix, or is this
>>>> simply a "I don't understand how the superblock shrinkers work,
>>>> please explain" patch?
>>>
>>> I work on some shrinker changes, and just want to understand they don't
>>> touch anything. 
>>
>> Oh, goody, another person about to learn the hard way that shrinkers
>> are far more varied and complex than page reclaim :P
> 
> It may be a surprise, but I have to say, that all memcg-aware shrinkers
> are based on list_lrus. XFS is exception. So, your words are not about
> shrinkers in general, just about XFS.

Just to clarify. I personally do not care about this problem. Consider
this as RFC/possible error report. If you are not interested in this,
let's stop the discussion.

Kirill
