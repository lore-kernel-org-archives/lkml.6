Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932673AbeBVNuK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:50:10 -0500
Received: from mail-eopbgr00092.outbound.protection.outlook.com ([40.107.0.92]:23376
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932564AbeBVNuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:50:07 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v5 2/2] mm/memcontrol.c: Reduce reclaim retries in
 mem_cgroup_resize_limit()
To: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <20171220102429.31601-1-aryabinin@virtuozzo.com>
 <20180119132544.19569-1-aryabinin@virtuozzo.com>
 <20180119132544.19569-2-aryabinin@virtuozzo.com>
 <20180119133510.GD6584@dhcp22.suse.cz>
 <CALvZod7HS6P0OU6Rps8JeMJycaPd4dF5NjxV8k1y2-yosF2bdA@mail.gmail.com>
 <20180119151118.GE6584@dhcp22.suse.cz>
 <20180221121715.0233d34dda330c56e1a9db5f@linux-foundation.org>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <f3893181-67a4-aec2-9514-f141fa78a6c0@virtuozzo.com>
Date: Thu, 22 Feb 2018 16:50:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221121715.0233d34dda330c56e1a9db5f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0401CA0068.eurprd04.prod.outlook.com
 (2603:10a6:3:19::36) To HE1PR08MB2825.eurprd08.prod.outlook.com
 (2603:10a6:7:2e::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 461f6f69-f4e7-447d-ecca-08d579fb2b05
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:HE1PR08MB2825;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2825;3:uxDRJ05sTqDmd8FpJcOOnLFETBAFixYz4LhmAKAISyUKxHt9g46xI6QP+SJc9w87ydjFaEg6D4oswYio4XvA4MfSO4lQm8ZChSsZjz9iM3J3UdF37ApqR5yF1vXXaeMo3b6fegZiNNfW9JKMP75eWQo2xaz1v2ZlkKWJSdkD0vOfyuVxLyE71QVI2VE1/db6tT752J20vW7UUt8Cu1ZQGluoyl+R4n+CFQaat0Lgm+5i5aD5QcOFbgm8aWikPYuX;25:1pf4X3z79lhdpAEzwZy569F0QXHLvRGoQw4dEIgGMRqm9Bd+K2WLksXuYgBuLHmTvUynpzVknfW7Of63+oibwzfxe7XvJOT3a581u+RdcLpc4ji4zbDQjKygbq41LOKy6HE85DVc4wZbGFstnazqYYqN/+W4dYGpNYbvgX+StrS0fJFz6qn6F3g4ZysNkGPbbkWuwvF1HWCJk022CKV9O5Ctljg9f4+WJRxNadFqecQ8mxKDUC69j10WFb3voH+BO6/bev7o3K76qIc9K2p9JbL4yeKI1ikLulSYi9e7TQdzDPZLG8n45FrLx4rMlHKgKqdrHUXpoQ65E9G3ysmFIw==;31:6otxZtTTkFe7L8Jlc5pYnANvFc1t3pabcEHVgejVhBexIv1h+QkG/GYAORGh4Shqd4jy3irKvgp38OB05p+dyFesSk1DA4z70JYH0eHpHUIPQn57sx3Ey/ZnJdS7gaecvYviqE4HOyLBNpTi2taI5iB3meJAhgI379mePXif6X+QxmI5w/vezqSiAz+JHaA9nmWvTBTooYp8p6+r7VbpkICHOoNkcXBdQcgVSru1VU0=
X-MS-TrafficTypeDiagnostic: HE1PR08MB2825:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2825;20:JdniLNMsZZKuORgCSVVtAMNyhWPo9HXtPzI/Hi1z5EzSzXEOaV6l1Hmb50dY4zJgB47Qg3CYqkKZyKkst9sL/Rl6foedyG+b++Sw9Dxd51y4NzWlNM7ImstLKhuTLvwDLKvUpHwqgHObrilsDeNKfZW5vJQtR8K8W4f3jjfy8XzZRB37OttC/AcpOQAyBpXLwT8Ceic3iY9FTI/NvIRXm+2/oCYw3j0FO6YKNG95zTwndIHvrtGqawFs+CChqfwJW1HxjYObHZFtAXTmtf4xE9J/KuEButCMazO+FQDkbzeBlbGRSxYrJdpTklcltxj4fvZm7sAaU/I1G4XNNQ7vgm9O7GtC7VJX4zQdvaXJzgktX926SzqjMqgnOxhZvIwEO1koP5TasCTaSmeCXQx2hQVpkG+EmXP6ge/bFTTTUp7ZPwzSnlmd5qxoCOm28y2vL9MgYiFr8vlFUTmgs1revNolme5IHFEpAxD459USBU2DzsmtuZxI3OCz5+UckJGu;4:Gat81IV4z0BSgHuNnlNEUqhKswXC3HugDN53aadpERQYC830wFUolPDUfRbiKiZeYmpat3MzsrFibBK68tUNtbluk+MQkRgXFD2ZYeM8ofsrnLR8tNc6mWZasg9UYq+EZEa+Tva0CQN3JijskQ+S/flToG/xpV1OkPh51Z6S4TwxjJ9V17KCEwMxFXeBgQTipsjwbdNwfKm6qLaEJOKSU/J+uoA782jwh1DH/DQMnJwaqX4dPzZLwj4dla6x/Jds7ZCwge5eEIiBTBa0UtPaaw==
X-Microsoft-Antispam-PRVS: <HE1PR08MB2825372EDBF4DB04C267D42AB0CD0@HE1PR08MB2825.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231101)(944501161)(93006095)(93001095)(3002001)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR08MB2825;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB2825;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39380400002)(346002)(39850400004)(396003)(366004)(189003)(199004)(110136005)(58126008)(54906003)(39060400002)(53936002)(6486002)(16576012)(229853002)(25786009)(316002)(6246003)(86362001)(52116002)(8676002)(50466002)(36756003)(186003)(2486003)(8936002)(81156014)(4326008)(105586002)(76176011)(31696002)(97736004)(106356001)(55236004)(305945005)(2906002)(68736007)(16526019)(81166006)(6666003)(52146003)(7736002)(230700001)(26005)(478600001)(93886005)(23676004)(3846002)(6116002)(66066001)(64126003)(2950100002)(77096007)(5660300001)(53546011)(65806001)(386003)(47776003)(31686004)(65826007)(65956001)(59450400001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB2825;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4TUIyODI1OzIzOm9zbkJyWjBYcjZxSWFRVktRamRNejRRSVA1?=
 =?utf-8?B?MWg1bWtHWTd6dGpuUGgzcGRGTVhvdFNrQjh1bjk5TWtTdXU0c3U4VlkyNkVI?=
 =?utf-8?B?aHY5RnZwcHc2UWZOK1N1N0JIUWFiMS82M2I1UHRsSWZnZHJiTGpiNFplQ1Rw?=
 =?utf-8?B?bjZYN1drQ3dCc1NqWGlhb05FZkcxVmhoZitYcmxjem9meEoyV0hrZTViZTZH?=
 =?utf-8?B?UWZYbDRmWkpLcHk5UzlTNGRKeG1wVk5BRWVWcnBJdytZdVpxeHhqU2I5aU5s?=
 =?utf-8?B?TDRMR3JPYzAvNG1td2M4NnkxdmlZamp3MEF5bFpuZkdzUnE1WHgzQ3lmNHkz?=
 =?utf-8?B?UVozblV6a25hUVNseGc1RGlWTHNRQzdMbEorYXl0UkdVL2pxOGhCRnR1bWJy?=
 =?utf-8?B?V2kxUGZyWWR2VTN6RFhTN0xDNjdLQU50UEFvZEJCWStyVE9qQnZsanZ3ZVhh?=
 =?utf-8?B?dUIrUVdqdHQvZUVmT2dwdzdkVWZQbFMveGNYelNucEcvZGNHaXAxUFRWZHY0?=
 =?utf-8?B?WjZUNkY1RDlaRyt5OE8rcG9ISWx4QTEwT0VNaGd5dTJjTG1KZ1dxb1gvWVpm?=
 =?utf-8?B?bDVpVTFqSXNNK0phaE5lY1VvMmtkd0xseTU0RnNKZHJZamtyZFg4Z2p0K01q?=
 =?utf-8?B?MDhONzNiNkQ2dlVuUEQyeVd0dHRKcUVQckw4ZEVvd3YrZ0RVQVQ4WkdQc1pr?=
 =?utf-8?B?WWpISzZmR3FvMU5sUmV6UDN4dS9SZzJWcTkvSWQrbndNbkFJZGQvWFg4cUht?=
 =?utf-8?B?U1JKQXR0MDJpZDJwU1lDdk1aMHJsNWlEYzhtTmRLYTFGbGtzM0NrWWJoODdi?=
 =?utf-8?B?MHR3SXhSeVBLejNHMjRCUUhCdFp6VWJNTHN6WlRmTGtuTXduSmtTSmt3aEZC?=
 =?utf-8?B?RnBpbkdEd0Y4U2JOL2Y0MW5oemJjUjlLbDBCM1VDdkZnQ1EzL2NUWTJxaE04?=
 =?utf-8?B?MlVmczVGRXBtV0pHcDZmZVduRTI3L0NjRWFCSWkvZk5hbGxUd2VTUjJqTGsv?=
 =?utf-8?B?blJHc3FBUlhmUTVpNTBYMlJEc0ZLMW93cWZCTS91OExOa2JWREU2T0JLaVUz?=
 =?utf-8?B?N1ZsUTZRTTlMQTEzQkhBaU9EZnNNM1BvTi9mTVErZkNob1dIeXZMZ3d5QXFz?=
 =?utf-8?B?OTNhcXpJUDI0eDhtdlNRZnhZZVMwT3dDMkVkZnMxUEh5WmpmSmk3VVpDcTJE?=
 =?utf-8?B?MHBjc2VmbGhJV0Zncll2YnlTRFJVQS8yS0c3blEzSGd3cGN1WmVJQ2IydFFr?=
 =?utf-8?B?ZVBvWDd5QVA0dk82cmQ2YlVJd2p4VUtBcE93R3RFc3BBQ0c5SXdUaVZFSnVr?=
 =?utf-8?B?cGV5WURMRFAwZm91d1FRcVUyWGZ0TjlwUDZFVE9ENmllYUxiNWtmblZkZjV0?=
 =?utf-8?B?VkR4SmNzbkpBMS9nU1IrcHBWcjlPbE1TWmxzYkFYTHdJT2ZHckN3N1NXS3dT?=
 =?utf-8?B?VUFSZkdYY0JRQng0c21xVU5TMWgxZ25FeDNWRENHNENaV25BcG9BRFl6Zlg4?=
 =?utf-8?B?bmU0OTFoSUVhS21XaWxCMWFEcEYwNmlleU1XMkVZbW9SN2hOcG8va2lwYm1U?=
 =?utf-8?B?MnJqRmVSY0pzNDhocmRkNkU0VisvL2hvdTNpQVNBbUhrWHpqUFc5QXFVeDFv?=
 =?utf-8?B?NU1vUnlaL1hBWlpNKzB2a3FOQzg3V1dyb01vR1Z2eW5wMk5sNFdPbFZpVnd5?=
 =?utf-8?B?Umx0WExWY1N4Ump2R0k4ajRXekxIMW9qNVVpU0Q1cXNnempQUUFjNGhkbHg2?=
 =?utf-8?B?V21aL3pZOUJBUy8wNWpFbFJtVlpqV0dlOStPSXI5Q0lsN1VmcnJsSmhCclZu?=
 =?utf-8?B?cFNQRHk1OFNhOUliUXZqMkVaZlJ6Q25GV29xd3JjLzM1UGJpT21UQTZtb3Az?=
 =?utf-8?B?NUo0UU9oSzRtY3NLUVJGcXNBVWtBOGtESHpyVXJNMWwrazMzbTdEVjhxQlha?=
 =?utf-8?B?VXg5QmZ6WGVWWkxvQ3RzbFhzcjltMkczUE5xQUtsek5HaVBWa0tLc2RkbE5C?=
 =?utf-8?Q?a/3ufd?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2825;6:tRmSLg1FtqqKvWk75be/XdCRYWA96ZK5dQVNxzWbGmbhcKvsSsTGr20FGjpRxR6m5cLFa4+FuA6JP9uBp/hMYS/15sIhiDhfafrTWB/aOBaZFt6AZhW121tstMla5AzmYeJLRqnhiz6/hqQKREQ0iNRqgXY2U+DBhJpOEqkred0VcJjhOnDLkLgC1KisLrCQLYhS0sJ0rx/ZzqNRzQy+cKMjk452Jd/4AQZc/DXsBOFH75joXW+APc5sbzVw2HOCeZ2bK6UwxsefYxlITMpq1ZO1a3S8yRqL1mUm9NQP+lvQNcVWxnxlZixlOIuaejth8weB7wrsIjNa0yxAuMfTCnEomT2aClBPt6QyUWYiq54=;5:3xDFXlETjJ9vCWKkBbzz6bSWyTWEfSDruHANR5PpC/ngR1Ffpn7LQHaXcuvSg6N+R003VMwgehtYy16x7fC0C/+eBWwTMmwpe94UmUk2yEThGOI/eLWNJe39DM+cE3p8tnm1ffLkQ99kW5lTSrvlqf/A5QxWk5fU/CykMXBKhpo=;24:ce2g9ft4txrlajU9bMfpIQQsafLyFF90Yvl2cCGo+R6v6jIeWJhkWCugHyi1p107Hfbnuv03nGxaRot+wDk61kEQG9Ma1VCVijsPO1jg4YY=;7:cQWGAu0tl4VtYetH3ecjQhnM9JeECdotg3xiivVc6QXz5uMpVnfcLYV+BFdEn3GDdY/oqWNDbkGrb3uUhABq8b2ZeIe1Jkb9RDvNhvuPAOJtvvcvw0MGOpR7gfQKSM9fK3j7vIASB2vnNxsLd9BGwyPBeQfdGcz82QBpgfibQ52DZfyBJXutBtz40sDkAracQgjYrwJqCqugMdlhUzsWXTkOiojM8uo7tl84On8nhiMqC8ZfWjkUAuaUaNBE1TOg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2825;20:/STeZtDySk/HK6NVzEZsplFEE+lhT9ScD6erguf3g5cxUwRZrtONFZAiQC1Vgzr1sW+iuI4NtUedWAxB8BP9oXENR1en2D9raxrZY21uU50LN0X+gPXO10m1GbnfsUVNf2i6+E66CIXb2MHHj3m6y4sBd+yBZNpNlT/eom4eoK4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 13:50:00.5541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 461f6f69-f4e7-447d-ecca-08d579fb2b05
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2825
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 11:17 PM, Andrew Morton wrote:
> On Fri, 19 Jan 2018 16:11:18 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
>> And to be honest, I do not really see why keeping retrying from
>> mem_cgroup_resize_limit should be so much faster than keep retrying from
>> the direct reclaim path. We are doing SWAP_CLUSTER_MAX batches anyway.
>> mem_cgroup_resize_limit loop adds _some_ overhead but I am not really
>> sure why it should be that large.
> 
> Maybe restarting the scan lots of times results in rescanning lots of
> ineligible pages at the start of the list before doing useful work?
> 
> Andrey, are you able to determine where all that CPU time is being spent?
> 

I should have been more specific about the test I did. The full script looks like this:

mkdir -p /sys/fs/cgroup/memory/test
echo $$ > /sys/fs/cgroup/memory/test/tasks
cat 4G_file > /dev/null
while true; do cat 4G_file > /dev/null; done &
loop_pid=$!
perf stat echo 50M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
echo -1 > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
kill $loop_pid


I think the additional loops add some overhead and it's not that big by itself, but
this small overhead allows task to refill slightly more pages, increasing
the total amount of pages that mem_cgroup_resize_limit() need to reclaim.

By using the following commands to show the the amount of reclaimed pages:
perf record -e vmscan:mm_vmscan_memcg_reclaim_end echo 50M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
perf script|cut -d '=' -f 2| paste -sd+ |bc

I've got 1259841 pages (4.9G) with the patch vs 1394312 pages (5.4G) without it.
