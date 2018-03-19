Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeCSLGM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:06:12 -0400
Received: from mail-eopbgr00113.outbound.protection.outlook.com ([40.107.0.113]:22430
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932487AbeCSLGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:06:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH RFC] xfs, memcg: Call xfs_fs_nr_cached_objects() only in
 case of global reclaim
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
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <18a031f3-2136-4ef9-6ede-05f5b835661c@virtuozzo.com>
Date: Mon, 19 Mar 2018 14:06:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316213910.GF7000@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P195CA0011.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::21)
 To VI1PR0801MB1344.eurprd08.prod.outlook.com (2603:10a6:800:3b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bce9aac6-97aa-4874-c8da-08d58d8968ed
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;3:4BwF3snHSvZ+xu4Ad6bGLehY3dlbIHroccLqgFWLtnebtDkbeGVWg9YR8W8ovaEMwbMngqzCB3DapOizwjM7xoeMg+ncYnpWn2V53H1osGU2JhSwJy/WWxdqDBxPQE1OXcTIJO28kdZsaNUAd1WUCmlpPQhKpdqbfahfUkKZd/u5OPvLe2WB0ruG3Yt2fpso8GAW3IrL3hrJbEFYakSEm4IANYQtPPVQkBlxWGmEbCrSfq85LmRgO2ne7YZ27MYG;25:1/OIXsywkFs7Rxx3qTXQ3w26cpDQHorEBdArd4CyV4dFUVFb2uyY1KYtl9m4rbrDpkRBJ8cr42wSDMjGX6ZrDfx6cJyLzkeQm8MAnK9AJsOBsXDTpulfwMctF5AXpwLpq758kJLVKfULItDtQoO4AAbDp3eELwlWfEJ4KFPIex5ciVlRGWizBOvu9eeqccih998mSIZZLEnJPBOnaht7tZk3ARVv0PE+/X5EYe3Dp4nKPd706VSy34vy8GSs0/IM+LTxMz9zUTEKgjDg0yB/zdfgaPBItyHnIKGNa0+Bqn/EhMl/VvE1O+UAhasbitDB0CL/83HuEQCU1niqc+YdbQ==;31:UcQAnod4sQE8sI99r1si8+Uu+vKP+CVzW85x1eMywT4hV/chNaDbCDdN22YCycoVNZi18IXGFf0fvE4ESzjYTmPiqbXb6JNkGCgkfMLHxNmwsNOO9nghPr8D0XG42gNj1l6USYlUjA3cn/mGJacb9dLlF30zAHayx8jJYRWORKOPm6nR8Y6mpsijau3MEi+limU5wvESnD06ZiNAXs/8sQ0FxeTJK9zhv/NRo6RyGIA=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1344:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:GgYPTBsRT9oFhGOmx/sp+ctrPRnK1EG+0UZhxzSNh9ZwUfV5U8VCBQrI8FKJrSzB192UtN8FZoN84Jf6vs9+ohPdm0erkrS3pc02BIsFcZoYQdv5bfF2qwb9dAXXh20XomgXKMBBWNlnNIW7iJBdo+Yq8IMzm0LpVe1xB6pXDL4DGEHUh9K4ZEMsPlpHOptFsxPzTnK6rmrq8R+LMfDJPe8H5VLm1xWx/Uu2allX45mvtZ7mgv5LCon5Aall5lRuT/xqxU8yMatQgu+EyRmsjTfEXwk50+qZKnkZVHd6eicln4QOpbPUOZCaYSrxJJijBSjBXrMhsEuDT1o/yEd0vnC8AWJRieKzrj5yr7pFvvXgJBICgHUA8rFbx4tjp+QI0mcpWfqO01xTp5ogdXk6WjJ0Wnddr5IVQU5SbJ6FyAYcXSiriwok5c5nXfBOR+5z8RAyt7VBfGIreCC4IGRdBCBBBc8bfUZkM3FYzvvJISLKwtw8b1sehCc2T72Dimlt;4:B3fpxrvSDeRyzcprckr52y5wVIbaBZ48S2+S6KNAOwEiw1ZwZAPd2/L4OI+7xP0aQEYjUTVuD+zYbexmF3ZJKo7Pcxf2KNYl4KHRK6k3I/oEwz6AS+25L+2FB7WA7i/y3j5SijNPCfGppDS09R2rT7Um/v3tycKs+3hmB/mTKVqlwxu/kINqDx2HTmIV2PvEpuQQwQtao4LqqUwCz6z5I7gJBSWciz5rs+CX//5LnCyKsZfF5Dn6ittKghp2UQ9MoKXQzCCIwv4UEB/7kfAFqr+NX2YxyTo5pUTgEmLY6jEdGvzm0FR8hilfNEVdvzf0
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13448E326995C248FFDA7024CDD40@VI1PR0801MB1344.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0801MB1344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1344;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(376002)(366004)(39380400002)(346002)(396003)(39840400004)(377424004)(189003)(199004)(16576012)(59450400001)(316002)(229853002)(105586002)(305945005)(230700001)(5660300001)(64126003)(7736002)(52116002)(97736004)(76176011)(31696002)(2950100002)(50466002)(6666003)(6486002)(6916009)(31686004)(16526019)(478600001)(86362001)(77096007)(58126008)(66066001)(65956001)(68736007)(65806001)(36756003)(53936002)(81156014)(106356001)(2906002)(53546011)(6116002)(386003)(4326008)(26005)(3846002)(93886005)(47776003)(65826007)(25786009)(55236004)(186003)(2486003)(6246003)(8936002)(23676004)(81166006)(52146003)(8676002)(309714004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1344;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDQ7MjM6MTVhMnRaaHlycVlxNHFINThsVE5qWXRx?=
 =?utf-8?B?R1p0NzZIVHJNdEpMVXh2TGlyRVd0MGI2QXI5MHNIdkM4M2NFdS82UEZFWE1X?=
 =?utf-8?B?K2xiY1JIcWtibWpEanMyUnI4Y3BtWGM1N3NPcS9YZnZqV0lOT2hkS2lJTzlz?=
 =?utf-8?B?OFFCL1FnMzEwbmJDYlgyNEFLbmpTYnRaR0RENDd2SDNzdHo1VHpMUjhKZndm?=
 =?utf-8?B?d0ZDQ1R5ZWZSWnNjTS9VN29BNVdpemIvUk93UjJSbUYrbEpiWldVTlpNUDJQ?=
 =?utf-8?B?dldwOWJpeEJhU0NxVXhxNHlucTFybjk2RTA0U1VQQWNoTXNadmxYYytKbEQ2?=
 =?utf-8?B?dTE3azlSay8xWXpacDVRY1FnVGM3bFhYMjdCb3NORVl0cVBBUTBLUW93d2Jw?=
 =?utf-8?B?TC9hOFMyNU5yQWVlOUpNWVVoNkxzbzk0K2VBcGY2YUJ3TjgwbUJ6WHpOZHpx?=
 =?utf-8?B?MmRHVGpuZWQvaHhVbTJoc0tZUlh0Rlo4VldQR1BmK3BZTmJoQ3p1cVJkSXlq?=
 =?utf-8?B?ZEo3eERTRUorbDRmK3BNOEtjb0Z6aXk3dVNMSWk0NG5PYVZJVGlRT2hqR0FI?=
 =?utf-8?B?c1FHWDNpNi9FNDJTdlFaTnNKNDUzeElYY0Jlbm9VaVZWSHJpMm9BQkZZRnpU?=
 =?utf-8?B?YXNMbEZlM1pGNEtVQm02Y3poakcrUExMM1Q1d3RicWQrVElPT0U1NjlMNVBk?=
 =?utf-8?B?UFQ4WThYZk5QQWdaVWphL0o3MXZNbGZPaUVQODFiYlNIdURpM1ZhQzRVOXBO?=
 =?utf-8?B?a1g3QzNoKzRyUWd5WXExZ0xwSnhndGdJTWQzSUxDcGd3a3ZBRzdJbURMMFkz?=
 =?utf-8?B?OGk0TlUvN2NCSTZnbEpZNkRmTkRpT01od2tYNCtDZXl3TDl0VFpJYjFXRjlN?=
 =?utf-8?B?Zmd6WWdoQit4TC81UkVmOEdlT2g0TDdaZGhIM3Q3eW81U2NERVJXL0F1ZjBa?=
 =?utf-8?B?REgyT0pQOEZ5SnI2bEYrNmZrZXNycVdJM1ZaR3RuV3BZV2sxY3B4Vy8xMzg1?=
 =?utf-8?B?a0ZYV1NFaG9RdFcvSmZOQkpmNW9MYUVtamttME9ISVE0aEZTYnJZRmxSTW5P?=
 =?utf-8?B?SHZMK1pTVWJ3WC9JQUtaSFBESzZWN2FNaEhpWEhqaHFxV2dKUnBxRVAzVmV1?=
 =?utf-8?B?M1VYWjdqZTFBZUJkN3pQbnlFMGlzMjA5Tm9kQnVlYnpDb3NyZU9Qbjc3cVE1?=
 =?utf-8?B?bm53MVJoYnNIaVg2Vk9nNDIzSDBKb0xaVEJmdVlyYjJhNmphbTl3V3k1YlpZ?=
 =?utf-8?B?WUw0bjBWYWlkMWMxNkNJb2dVMmJnaG5sdTE3MFRCS2dmM3NhVmhIcWM2WjNm?=
 =?utf-8?B?bUs4a1ZNR1ZwOWN3QzlQZTl2elZtVWJpKzFJVSt3K1crYlRyM1ZwVW51QW40?=
 =?utf-8?B?cUVKNkxUQnl2M1h2a2xEeDRibXdUblNzWCt0OERkeGRiTkdsQXd2T1VnY3NS?=
 =?utf-8?B?a1p1QktUZTNQNzU3ZkYzNkpHZHJSekhyVjBRTkt0MlpRME9jSVRQS1AxYzlj?=
 =?utf-8?B?UkowQzJsTDQyWElLUCtZeXFnYi83SDRMQjRmWmRQanhGN3JOS05Eb28vTDdm?=
 =?utf-8?B?Q3RBVXlGWno5SDcvVklYYlhvVWFUMkVyZkNVdGxDRDFRYnNFNGI2WVBma3R6?=
 =?utf-8?B?by91RmRFWlJUL3VGckt4N1g1dlhUdGlYbjFaNWFZb3NhNkVnWnZMZ0hkUS9F?=
 =?utf-8?B?bTJGRm41S2hFVmxjWVlENW5WTGFkL0p1SGl1Ym0wV2VWTmdOU1JwSm1xRWg4?=
 =?utf-8?B?OXlFRkNSMnhjOUhRNTRDN0p6UWpITWIvbU1IU0g0dVY3d213cjNwZGNlRUw0?=
 =?utf-8?B?Zkl4R2ZQVmp4Y3J2b0VEUzBrM2VBUkdrVk52dnducnFheFYvVHRZUU9NbEUv?=
 =?utf-8?B?UVN3SVd1U1RaM0FUUlRLWHdWUEJpVHFzOWkzdzBjZHNsUVo3bzR2NVpybnJa?=
 =?utf-8?B?S1lXa1pyZkhIbWNuYjVpSVRyTGhmcGR2WWtaQkFZYUpEdnRtbDBpM1dNV3BS?=
 =?utf-8?B?QkVFTDA0alJHK3dWT3BRUlUxQzBhc3BzenE1dnhBYXozMzBDblBlWVV4blFi?=
 =?utf-8?B?TEE5S29pd3loVjFscFdkZzZPVnhGQVFLV3JlcDBhcnJabmNlMWZ4czBZaG8z?=
 =?utf-8?B?bmc5QT09?=
X-Microsoft-Antispam-Message-Info: FFCogTZ0dyzXnX3wRcV0mxDRkt+fIN7/pNyTXMZIFz9IO/ISsyswMJ7mwYAZcyhjfdLmJt1huINFqFMIbx00F/feb5gcKTMzlpS6sUAH7fiUQ+Qizm/f4pjEQNivrDmT4bM6/xNYg3lqmyzhtElT29BGF/VsyVb3nhp9crKzjD58aYoXEdEwbE++qCukTw/X
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;6:oD5gnC02f3bz1eEu6ENbkHShpIIPsRQI9/tcx/6pFzSa1+//80Hxnswf3gU4gRB+POzAeDMAZVBlDRRz+cVGZFo2tRPXfxhYmwHSno1NAab2kGSFg6OwYrdnFLGvxOT4+PTmabA1vk4Z3el14nlU297h109UjgqO4M6b6HuEGLGvHejEqYix7Q/znuc8Yars1zUdViVGSgCo9MU6bGjsxrW7wOXYIHa+osjuRI7RW2znwoRKvF5Wl+3Ci5i9vhEGgmoAjqwVjXz3S4mq6BEG3sysMylEoVM7eSV9qyTpIPmGTtK4R8CKGmE7bCnAwYeQ2Trfdo/hgo0uhwKmq3S+LWgsAeTBtultgch0cS2HdDg=;5:CWG5zvcRUVeaMI19PhhaxngmNPob28JLHAFHYNavOpZA7s3oRAIpjSa38mRZ7zbU831qGU0fIF2Qeodij+VoH2cI2+E6LrM1wWx6mlW9c/oHTUka1iPiT9OgET4zIMXuZlhDtB5BPbHIKpTcDvzlMYRw/87XCZHnCwOXINTStS8=;24:tpbZRv5TnnAnxlZ9H0ulv3/tnvqWLqndypqCpLYS3CuhHNAG6O32ijAQZdfFzUEGV2My8MXfKNbhtFJOxXuuf1PrYU5lnsY0zBm99+zEQCo=;7:g2L0dCNkZKJZl62fXM1z47nL/penj0roUfu2oTy5ita0tw+2Fd0Z6l9fqoYOToPPJUHvk2ZPoPZQTfMPKVTgl0CMHauUqmViQUN5XFAUeYdP5DinTKoQEe5kXr42qvUnni5lT/AHhGx0OULNeF4mRB2+6PICk79VcjeQqYJ3upue3XUtvx7KwImhg50YA2p2Y3hX5tgxY/0tm7H+6MYMVJgiUeaRTN28J1d6wbE3/YRgD9tyNNlxzvgYniiqZTkJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:vewCRpEy8loALbwVRI3U0v9vuH75r0/S267pkY7rtt2FcWp1Kl8Q1oPk9FSHMXDqVkwZzksEWu51mS8ytn9pq5fRlpE/gLo6PmCvXHcKorN8ZNg82kGJtPDHabhR+p5NJlFBxU7GLHV3ZG2ZZ2FqJtDFsc6IYhSzs7xgtX0Tl7w=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 11:06:04.7461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bce9aac6-97aa-4874-c8da-08d58d8968ed
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1344
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.2018 00:39, Dave Chinner wrote:
> On Fri, Mar 16, 2018 at 11:55:30AM +0300, Kirill Tkhai wrote:
>> On 16.03.2018 02:03, Dave Chinner wrote:
>>> On Thu, Mar 15, 2018 at 10:28:43PM +0300, Kirill Tkhai wrote:
>>>> On 15.03.2018 20:49, Michal Hocko wrote:
>>>>> On Thu 15-03-18 18:01:34, Kirill Tkhai wrote:
>>>>>> xfs_reclaim_inodes_count(XFS_M(sb)) does not care about memcg.
>>>>>> So, it's called for memcg reclaim too, e.g. this list is shrinked
>>>>>> disproportionality to another lists.
>>>>>>
>>>>>> This looks confusing, so I'm reporting about this.
>>>>>> Consider this patch as RFC.
>>>>>
>>>>> Could you be more specific about the problem you are trying to solve?
>>>>> Because we do skip shrinkers which are not memcg aware by
>>>>> shrink_slab:
>>>>> 		/*
>>>>> 		 * If kernel memory accounting is disabled, we ignore
>>>>> 		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
>>>>> 		 * passing NULL for memcg.
>>>>> 		 */
>>>>> 		if (memcg_kmem_enabled() &&
>>>>> 		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>>>>> 			continue;
>>>>>
>>>>> Or am I missing something?
>>>>
>>>> sb->s_op->nr_cached_objects is a sub-method of generic super_cache_count().
>>>> super_cache_count() is owned and only called by superblock's shrinker,
>>>> which does have SHRINKER_MEMCG_AWARE flag.
>>>
>>> Xfs inodes are accounted to memcgs when they are allocated.  All the
>>> memcg reclaim stuff is done at the VFS inode cache level - all the
>>> XFS inode cache shrinker does is clean up inodes that are not
>>> referenced by the VFS inode cache because the memcg aware reclaim
>>> has already freed them.
>>>
>>> i.e. what the XFS inode cache is doing is perfectly reasonable -
>>> memcg aware inode reclaim is occuring at the VFS level, but on XFS
>>> that does not free the inodes as they are still referenced
>>> internally by XFS. However, once the inode is removed from the VFS
>>> LRU, all memcg information about the inode is destroyed, so there's
>>> nothing in the XFS layers that cares about memcgs.
>>
>> So, after inode is removed from LRU, memory still remains accounted
>> to memcg till the time they are actually freed. I personally don't
>> care, just to mention.
>>  
>>> Hence when the XFS inode shrinker then called to run a
>>> garbage collection pass on unreferenced inodes - the inodes that
>>> are now unreferenced in the memcg due to the VFS inode shrinker pass
>>> - it frees inodes regardless of the memcg context it was called from
>>> because that information is no longer present in the inode cache.
>>> Hence we just ignore memcgs at this level.
>>
>> But xfs_fs_free_cached_objects() returns number of these freed object
>> as result to super_cache_scan(), so shrinker interprets them as related
>> to a memcg, while they may be related to another memcg. This introduces
>> a disproportion relatively to another shrinkers called to memcg.
> 
> In what way? All memcgs see tha same values from the backing cache
> and so try to do the same amount of scanning work. The shrinker
> accounting simply doesn't care where the objects are scanned from,
> as long as it comes from the same place as the calculation of the
> number of objects in the cache it's about to scan.

shrinker->count_objects() result is used to count number of objects,
do_shrink_slab() should shrink during the call:

        freeable = shrinker->count_objects(shrinker, shrinkctl);

Then shrinker takes part of this value:

        delta = freeable >> priority;
        delta *= 4;
        do_div(delta, shrinker->seeks);

This is a number, the shrinker tries to shrink during the call.
Let the priority is DEF_PRIORITY. Then, shrinker try to shrink
freeable*4/(shrinker->seeks * 2^DEF_PRIORITY) enteties from every
shrinker. Equal percent of every memcg shrinker.

When XFS shows global number of cached objects in count_objects(),
shrinker also tryes to shrink the same percent of global objects,
as for other memcg shrinkers. So, when you have small memcg
with 128Mb memory allowed and small number of tasks related to it,
you may meet 1Gb of cached objects, which were queued by another
big cgroup. So, the small cgroup may shrink number of objects of
size more, then its own. It's not fair. That's all I'm worry in
this message.
 
> The memcg accounting, OTOH, is completely divorced from the
> shrinker, so if it's still got too much slab memory accounted to it,
> it will simply run the shrinker again and do some more memory
> reclaim.

This message is not about OOM, it's about imbalance. See above.

> XFS does this for IO efficiency purposes, not because it's ideal
> behaviour for memcgs. If we start doing exact memcg-only inode
> reclaim, we're going back to the bad old days where inode reclaim
> causes really nasty small random write storms that essentially
> starve the storage subsystem of all other IO for seconds at a time.
> That is a *far worse problem* from a system performance POV than
> having the memcg memory reclaim run a couple more shrinker passes
> and do a little more work....

Ok, this is a point.

>> Is there a problem? This is what my patch about.
> 
> You've described some theoretical issue, but not described any user
> visible or performance impacting behaviour that users actually care
> about. What reproducable, observable behaviour does it fix/change?

Strange question. Do you fix problems only when you meet a reproducable
BUG()? This is the kernel, and many problem may be racy. But this
does not mean, it's prohibited to discuss about them.

>>> So, is there a problem you are actually trying to fix, or is this
>>> simply a "I don't understand how the superblock shrinkers work,
>>> please explain" patch?
>>
>> I work on some shrinker changes, and just want to understand they don't
>> touch anything. 
> 
> Oh, goody, another person about to learn the hard way that shrinkers
> are far more varied and complex than page reclaim :P

It may be a surprise, but I have to say, that all memcg-aware shrinkers
are based on list_lrus. XFS is exception. So, your words are not about
shrinkers in general, just about XFS.

Regards,
Kirill
