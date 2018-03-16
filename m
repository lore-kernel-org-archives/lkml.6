Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753289AbeCPIzn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:55:43 -0400
Received: from mail-eopbgr20118.outbound.protection.outlook.com ([40.107.2.118]:59328
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751094AbeCPIzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:55:38 -0400
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
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6628c551-f607-367b-1ee6-f458266c1d92@virtuozzo.com>
Date: Fri, 16 Mar 2018 11:55:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315230313.GM18129@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0055.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::44) To VI1PR0801MB1343.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec8ed3f1-07f1-4cd0-70bd-08d58b1bae17
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:UQu1CAUJ4wNpe8Ew5Rri/XDJIH4bKoS4c+TSs2Vqiv7w20iiyOY+cwtzr0LUMOYjqK6qPj9A7yUCwjoBuuyhPl1T8Et5Gq4xoU0HkvKh/eA5KROmtu9oLQcS0HzYS4kGIRBcuPoCeqUt8tJszxbSvoc0L2xh4dfEVwOKR2yGUpBXUP8hVNKDdwD8Kq6ksBgrvmT65L818LMxiI/aoW9kTpHLbEzYukUjHx0JZTUtw0J4sJcXpj2Sb9UYdxVmcVdb;25:3jG06LSOFvXEUPNU3nXPZ1MkbTyfEGBJGi1hWgttT6VXBy3ogZbYW5UE1qjr0ixvCZ+cFRZDmLts7o0cp0qmbw+7h9fQ7Jp7BtKCxCaDfEkCivJRQVnjDn23ueWZG9tvXOeuSmMZ6k4eEzxB1pssxGxRxIpKv9Ql1xF2k6aygP3Adcb+9+pB0O6TDWnbdTorD4aS6RQxDJvYrtktFcH3RTBhImibvmabpjG6uBpI9zjxXh+I5Br0VW8PeaTKafXFycw8wcqgTGWW9ybmTA+/ZRGM7F3ZwDiUIR5YAKbEKjeNoJPWxU9dyOOcKIOO2tkWI0D+iKqqJdVKvo6vsKhHeA==;31:i4BMexSKBixLtsYFHmooLoAfrKdBjwlt/exrN8RzhGunA1uRWbgnt4IK3p4mXWO7IfAW62u7K/S9fHhnZcaysXF2e0rY3YVhxLcP//qLwtt1QniLHdn0zSaymD30XpOuQV7nrlxpghrgTOdPfXSmTrvXNi6+H8cGONpQZEiUHzLvZo1cIG5lymEVoLlrgwYIZWpDji+1qO40y36c0UWrLct9H02fKBcKSQgore02ifI=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:6dC1f7O6iVjZCbM0fN7Nbcm4vAkg+iYrGZ/Nm/aabaHJiuhHUMZyVRaGUWIv+X3k371GzCey3koCqrWnz5UH7/ubYmPDTayVkjMKIis7js4mhXS3QSHWjE4u4H+ylQq8gXuYmff+g44gddi3BG2ZaDo+QUY0JJf8yb/95thataYXx8A2K0d/S2H66ZJKJhwwb+eODiv3QNpzXsev6RUpvPQ+WWbaYXPaPOERm70jFoy3CV/HQqZF7FeFi0fWter48OUkrVLmvrsquhLpiSK1ZcJYsvLSQtFG6FZgq/XUtQIRVqfuzrcpLDwDlZVcaxLpyAiyCmssLEE5UyJLLiaPpKlzltG+rKDIbuu1VDru3SD+GXPI0R1UTuhiCIzbN/GVq09e8MRvHUpKHgiql/E1XJmXXndkLo6kzMNnaIXBKYId4YjjZo4t2PxVeDj769X4CNuk4kwGT+dFjIywmgVLl9PG8Ml4UKMH8m8rrBH87S1uIRv3jm+Z0ma4DW3odo8L;4:rXjPNmysZP2JRTq4rArrUBe7WYVr6uRUqIYtje8SizYXQUp0moNebBoQQxscoPTQWRPEI5tDOYWKqoWgC/WsULrqfsU7yBZMWShyYzu8J9fgDvrTEZpPLWGKqftVJGPd4JcjY8/RJVdy/dhKNm7rsZIHofu7X6xNLo0g0CLHsNXqRozgmzPgckkIR0ON3l2tMuzRzcbCADgZBM9pdQoLuyJY43U0mg/+PX/RGvLylcuNXvRGmoPwmQmTCyw7LGnYMnZsL6Yo5w7jW55qylMI7+t5V8VW/PqwwqMyApBe2ebT7uyyCxT+WU9dCjYbaqLw
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1343AADDBAF37D427099DAF9CDD70@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 0613912E23
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(39850400004)(396003)(39380400002)(346002)(377424004)(189003)(199004)(316002)(86362001)(65956001)(65806001)(229853002)(305945005)(106356001)(7736002)(93886005)(58126008)(2906002)(6116002)(47776003)(16576012)(36756003)(186003)(3846002)(2950100002)(6916009)(77096007)(26005)(6486002)(66066001)(76176011)(16526019)(105586002)(386003)(5660300001)(55236004)(8936002)(53546011)(478600001)(65826007)(6246003)(53936002)(4326008)(81166006)(25786009)(97736004)(31686004)(68736007)(31696002)(50466002)(52146003)(230700001)(81156014)(64126003)(52116002)(23676004)(2486003)(59450400001)(8676002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6WVM0d1A0MkhmU2pFNjlEa2tiSWZGK2cv?=
 =?utf-8?B?elBidmVCalFVNWRoZk4zbk5EeWxmS0doQ3dYbW8rWnFHd1kzaUQ4TnNvYktR?=
 =?utf-8?B?RFpqcVEwKzdiY21vbk9FS3VFTUhEY1UyQ0xzQWN1M1BkOGo0N3RENjdvai9o?=
 =?utf-8?B?K0l6WktDWTRUY2cvZUtCUUczbUFpRXNKYU5mRjFDeFlVblY2NWdqbHNCeVJW?=
 =?utf-8?B?V3lScWdKWkZ4aFQ5dHdZYTFMKy9RZ1paTUJDZGIvQ2FZSnNnakdWREZFaGc4?=
 =?utf-8?B?aDg4TnY2UFpnVTNIeGV2MTc0QWd4dmdzK2M0RmhXN1VNUndsMmt1ZGNId2Jw?=
 =?utf-8?B?UzlHYU55STMxcDlsN0kwd0F2MStrU2JaOStGcENxc1NvVWx4bU5neHI4aTNL?=
 =?utf-8?B?NmxVemhZeXVmdXVuNEcyL2lTY01TMHp6V05ybFpSZkFjcWZNN0FaamxkWTJn?=
 =?utf-8?B?ZURjYVdrSm0vbFM3aS9HRlVUY1p5WjEvN0N0NXRvcG5lWENWN2NEakptcDZi?=
 =?utf-8?B?andwVGh6SDhROEV4bjlvV2JFMlJya2lUVlZCbUVhMlZkTTdrNEdhZGhTWWVD?=
 =?utf-8?B?dGhMbGN6Tk5QSStJTVJUMTdyRnlGeWVtZ0ZNdHlnREhoRXRydmw4RFdKbFNk?=
 =?utf-8?B?UWpyeGxsTGFVb0IycnZzUDNqZzgvM2JvZEJwWjNGbk1TNThKK1hEbUNHOVV1?=
 =?utf-8?B?b01teGhpQWlPZE14bjBON1hzSGNYWUZ5bGliNllicVlvSTY2QnU0VFZ2K2lM?=
 =?utf-8?B?RE5iNVpqdEtUNWozN29rN2xNalhCSTRmczFLNDB5NWtBckViaGVaZEFFTTJU?=
 =?utf-8?B?ZjEyb0duYTZPNkdoN3BlYXdaOXR4dmJjT0lMR3NTRFI0bTJyWTVFdUgzdHox?=
 =?utf-8?B?OEZIRVJrWmNLOUtNT1Z3YlE3Tm1VSlljZ2tJc2VhRDQrbmlQanZRdE1sV21T?=
 =?utf-8?B?U2FNU2RjMzdUOTkraGVFY25seEp1N05kMjFHdmFZNnl4T3FjaE0yN1R0R1lF?=
 =?utf-8?B?MVU2OXJFeFJEYnltZEIrSTBFbWM1bXZrS0ZPSXhTSGFtOUROYlg3V0hSSllY?=
 =?utf-8?B?Wkp3K0xxeEV4MFZ4MlJGQ2lUVXBxV01zTThtRkQwdVJBL0drYVlmdmVZZVYy?=
 =?utf-8?B?Z01ENSs4WWJ1S0RrN2h5c0E1V0ovOExGaDNnY01BSHhBeUJ5NE12NEpHcXBM?=
 =?utf-8?B?VzBiSGdtdEowNnY3ZVNtYmdEdDkvdzFGU0ZoU0pkaGxxMStxVVU4S3ByaTFz?=
 =?utf-8?B?VXc3ekROOHlhUjg5emE3WDc4SkVvVUR5WUpEUXdhTmNGamQyQVJWUkg2ZHp5?=
 =?utf-8?B?OG1mbWp2NWJ0b0FiOFNGQjdSZTdMZU5LZW1XaTZtWktEZWlwVHlyL2UrZHdt?=
 =?utf-8?B?OGVMM2lyZE5YQm1LQXF1a1FxRndjTW1qdmpETEZsUThGQ25GNmN4MTB2aGJm?=
 =?utf-8?B?MjZoYkR5OGxNMURPbDNkM2xmNDZMVlIxMVRsc1I1MzhzeHFSUjQ4YkVvdDNh?=
 =?utf-8?B?dWV6M0lNVW5lVkRRSGNKKzFrejJ1eFRFWktjSmJ5eEV3WWZXSFRFTjFTTEZK?=
 =?utf-8?B?NVYya3I2eEdoVGNuejA0ZFpYVnRwTVYyYUdHN1lneFRYUnhKTWQ3TUFtRUpw?=
 =?utf-8?B?VmZ1bmliaEZSUTZsTzEwZlZsWlJrUFkzZWh5Vm13cllheG1KbVlIQjUwUDds?=
 =?utf-8?B?RFBiSUxYSGVWYXZabVhNRS9jNXE3N1d4dWpvVU1sSXQxVndPbS90K0VNTWVl?=
 =?utf-8?B?OW5LaS93UmljZTNmNGs5elhtVnBvMHhGVWQzdmgyelhTSk5MSXF3MXZQaitu?=
 =?utf-8?B?WWdLTjZHaEFqRXJUNVZJTXl3cXB3VXdqZURHNHpmUVhycWV6K2FwRFZFMnV2?=
 =?utf-8?B?aDdUbGZRTTNpc1I4SlpaUlNhWFVyWGcrNFRpa1BGb3JjQUg1VnJyR1dOTHZG?=
 =?utf-8?Q?kcn/2MvIuZsgYgKV9NDV6QHaVtGnxs/I=3D?=
X-Microsoft-Antispam-Message-Info: hyzkBagaVWA1EgGoLvC4N3A+8NFsNuPK/ioWtmDdYN7uUTUeaBnHYysIKwYbxNHwJoDT74rIXND7wa8J/Ffn3ZTKZ20yUQoEJ3LEg3XnJFYTkjJNSThIuPMaNJyHYzhn/a2I7yxib+L2DEQXG985AXFZMlwp9Xf5FdIowE5RLTCuQc/hL/YzuQ5XEdCv1jBM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:fxK8Nh+Q6CwL++gP57eLtPGceqBOv2YGtkv/zIZb5RN1qyD+oPIjWpHsHH+i0FJ4CvhFQ98txP1dq99O+cerPlrumSyGCHGzThTAQlWPmmPzatzihRkXn6YzTx5Et4I5dMm4XHPB3rlY8Qn1PIWRV1wlJc6gNlSHwmu4sDQ+D9VEpPWC36ScySD5vOcug/q8LuvbKLFgIxo3aeD0LD9YsCsaTNrTL8v2nh0XpJtUty5DR3x1g/ILBjPqTMvjfgbQx+wdgovcm1v5v32dJa2Qfhz9KKuQlslVHYg13uR42aEK4ePNY63pVc88y5bGy+YQZT6wTpjnSQEn91qn9cp4sCm8CsACam8Vw9bpEMI3+50=;5:AJuzpW/0Cwq+5pUoPq+8AujWgFkG/0CSwUyGkXXbfTM5XaAky3qP2dwNuNYqHEm1m1HLXwMfc8N3e7SnkznQ3Ki0UAcBilWBdiLEYqxBxi3M2/aFt1L7TwkQp+Qq97N/gSg+a2eqDB9oTF8CJ87+YSKE9RKBjbx3MARoxT6IQxQ=;24:12JF3V+Y7kfyaYpTGuyDfDgSclxuM5QbBE0RD+v2hnb5aalMatAdkby+qVtx/QQ+PP4fyNkfZpXsN1ZIg2on3Bx5FH5obHuy7TVUNDc3xis=;7:OsGanrHJlcadNSh1xQUjYSudrE4nWC5F8nFfWB7AJ7M/dPiaJrk1xS137Ri1/rEQirsHDUANpxcReYWUJK0lmtUzfqw20lzosQFWIHf+0H6wQaYh5tKrAxf1+AADeLb+xkcz6MLa0sS7xmFcsA8HpOVRiWAfIOY9Q6sCeRgyC9eK2cszcc/5oWQeg48nrW2Zq8x1bOHFQdn/D0hK134MavZblt1m9hEKTsuthkxcA014sNQqTH3EOyj15WLWJ8bS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:rct0Q5E3Y+YDqiDiCVKdXUIaKdYRMhZY6EzSrjYQwEzYqtdZWWfdRU+MRQXE9J3ZYswoReDhr0ed4HeTlhgDm3siX/p1VyeWxEaID0GKV0OjH/YQGet/EOAqRF6N62sFRYSW9KoRN31UFxun6wAHMa9wkTnkrzEFLp3nelYlMEM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 08:55:33.8630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8ed3f1-07f1-4cd0-70bd-08d58b1bae17
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.2018 02:03, Dave Chinner wrote:
> On Thu, Mar 15, 2018 at 10:28:43PM +0300, Kirill Tkhai wrote:
>> On 15.03.2018 20:49, Michal Hocko wrote:
>>> On Thu 15-03-18 18:01:34, Kirill Tkhai wrote:
>>>> xfs_reclaim_inodes_count(XFS_M(sb)) does not care about memcg.
>>>> So, it's called for memcg reclaim too, e.g. this list is shrinked
>>>> disproportionality to another lists.
>>>>
>>>> This looks confusing, so I'm reporting about this.
>>>> Consider this patch as RFC.
>>>
>>> Could you be more specific about the problem you are trying to solve?
>>> Because we do skip shrinkers which are not memcg aware by
>>> shrink_slab:
>>> 		/*
>>> 		 * If kernel memory accounting is disabled, we ignore
>>> 		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
>>> 		 * passing NULL for memcg.
>>> 		 */
>>> 		if (memcg_kmem_enabled() &&
>>> 		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>>> 			continue;
>>>
>>> Or am I missing something?
>>
>> sb->s_op->nr_cached_objects is a sub-method of generic super_cache_count().
>> super_cache_count() is owned and only called by superblock's shrinker,
>> which does have SHRINKER_MEMCG_AWARE flag.
> 
> Xfs inodes are accounted to memcgs when they are allocated.  All the
> memcg reclaim stuff is done at the VFS inode cache level - all the
> XFS inode cache shrinker does is clean up inodes that are not
> referenced by the VFS inode cache because the memcg aware reclaim
> has already freed them.
> 
> i.e. what the XFS inode cache is doing is perfectly reasonable -
> memcg aware inode reclaim is occuring at the VFS level, but on XFS
> that does not free the inodes as they are still referenced
> internally by XFS. However, once the inode is removed from the VFS
> LRU, all memcg information about the inode is destroyed, so there's
> nothing in the XFS layers that cares about memcgs.

So, after inode is removed from LRU, memory still remains accounted
to memcg till the time they are actually freed. I personally don't
care, just to mention.
 
> Hence when the XFS inode shrinker then called to run a
> garbage collection pass on unreferenced inodes - the inodes that
> are now unreferenced in the memcg due to the VFS inode shrinker pass
> - it frees inodes regardless of the memcg context it was called from
> because that information is no longer present in the inode cache.
> Hence we just ignore memcgs at this level.

But xfs_fs_free_cached_objects() returns number of these freed object
as result to super_cache_scan(), so shrinker interprets them as related
to a memcg, while they may be related to another memcg. This introduces
a disproportion relatively to another shrinkers called to memcg.
Is there a problem? This is what my patch about.

> So, is there a problem you are actually trying to fix, or is this
> simply a "I don't understand how the superblock shrinkers work,
> please explain" patch?

I work on some shrinker changes, and just want to understand they don't
touch anything. 

Kirill
