Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933104AbeBVQBd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:01:33 -0500
Received: from mail-db5eur01on0103.outbound.protection.outlook.com ([104.47.2.103]:18364
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932952AbeBVQBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:01:31 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v5 2/2] mm/memcontrol.c: Reduce reclaim retries in
 mem_cgroup_resize_limit()
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <20180119132544.19569-2-aryabinin@virtuozzo.com>
 <20180119133510.GD6584@dhcp22.suse.cz>
 <CALvZod7HS6P0OU6Rps8JeMJycaPd4dF5NjxV8k1y2-yosF2bdA@mail.gmail.com>
 <20180119151118.GE6584@dhcp22.suse.cz>
 <20180221121715.0233d34dda330c56e1a9db5f@linux-foundation.org>
 <f3893181-67a4-aec2-9514-f141fa78a6c0@virtuozzo.com>
 <20180222140932.GL30681@dhcp22.suse.cz>
 <e0705720-0909-e224-4bdd-481660e516f2@virtuozzo.com>
 <20180222153343.GN30681@dhcp22.suse.cz>
 <0927bcab-7e2c-c6f9-d16a-315ac436ba98@virtuozzo.com>
 <20180222154435.GO30681@dhcp22.suse.cz>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <bf4a40fb-0a24-bfcb-124f-15e5e2f87b67@virtuozzo.com>
Date: Thu, 22 Feb 2018 19:01:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222154435.GO30681@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0009.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::19) To DB6PR08MB2821.eurprd08.prod.outlook.com
 (2603:10a6:6:1d::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 783a35f3-924b-48fa-a660-08d57a0d879c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DB6PR08MB2821;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2821;3:zAQCfxJwbDcQie1OoRVe4FPDfwq+aMqYv+7EW7fig3Gi9os9/H9cEHYBUEgznbxXkuUosr/Z3fd1xSzmzayJSs7Rays/vrxkZ77Trx9z7fkyfPmGNbCADMXjcKvid051+/tgmOr8nu2bWoGOtCsLId1Rer4CexWJ/Pm4Y96cMXrBKp8RM6NRpNw1pY4HPMb2Wtg/6IOAeHQAlME2UlENF2/1L42iK9pRvGFbSbnWRTP/xJ7bpT7v3g0xZWMuznb0;25:i+5wK9QbjbEbZ4omG73jwqc7zxVDQZIKruh/YT/CLeXtGOFS1EvNneU2PAIYZbOF8xpitVf+dROYaNVCNlYINr6/o98GdTfrEFcmqN5VCTfxUyy3VRmUErjUpOrbIfyDgTAlaxaKhGHbIz+hKOJ3ZTydR4nPhcKxBoyqQuU2QRKfUcWmwMMLbO414mvGCHK83yd6huPGkYJjvOTmkptVPudbaaRrCaAd/OKLG2t3XVrPhiSh+BzFyZ8HCsDff7DZ4G9W6o3FiNbEXXHkna1DZ45J+eAYfuEdxVKFNaOLtrqYuoE4pnwXNWw9qYIjxc/dyyiWaAzQI+HstTkAjqDJXw==;31:wMsjMSChbdVvZkqsmAyLc2Ett9gF/Ge9X320I13B8ECoydhuIUXhRD5XPxZE19y7LIWwzAxD1l9Mv5l4oGAMm1UvWhEyRe/yS/96YRRhz5vQ4oTkxsOLVCKL6I14Tn0Kq6yoZ8UN+ne2uAtcpfrTV7L/mOthLlFjV8T0R7xDRZLQc4QNjMYMV1wWroK5F/OODiMgYT+laYz4A90tNjYndtWI6sEKqZHf9K1JZQYgEmg=
X-MS-TrafficTypeDiagnostic: DB6PR08MB2821:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2821;20:bYIAwhRoZQVUd8XOm9ifkJWr828G/HlUibTBqYDUWD+22gm1o+xxqNYAhZhj8YX15f4D1P5UqduZgeDEFECGED9b621zNYPY4dLIEVEoGofflzBgz4yPq0BYD6UNXsdf98nIhLexTZ+ATzL47k30M++opm7llc6LTLPEJGmp+pQXUQYYcX2eqZ5p8NuzTcgF8eX7wursYSL0Td9AfevJeLFzHXyYF1JAqaCcxg6ONu3oTzi9RXJlkebLBAq78/UeAFEe61pVdhlxS3ehc/IoPxbiarjdpc+JGeoE2gnRIemWNeIfQudhPEiPsKU8a9YosY+4SGuhZrVPU8S9LWTvmJ1oMHCXyLI6b9o9sKauiQs0SNYFcmd51hkyR1zsZ+Xe5BHwuMqisgwY2NSG80/1h3qHoDEWjoGcrjW+8wObE5+/xHFlo9Si+VLxwiiZNC7bCu8nqspkkUBxVqgndsvy9ZSYJE+MwDMaUfbKU1b3sJ1GogWQU6YaAAsdh5zbg07p;4:oxLbQWJm86qNww7jBkrXywmwstqCodlWgE7Hgb7HoDukrkMY67sCspITNnrZss1u7vnMotZaric3rBvJzpvw6bV6V6iSz972Ra7Onc8/2Q6eetw49JV3NVA0GNuZF7Hz5gvDq4c5EvNsMS+TTyFn0yntmwe/BT46JWRHZp3/ApZfjoAnwUYowY7z71p/KncwEcwOxqGSsHcvD2HlBsi5vqv/TxASPSO8jr83NQkcv/eUNoY+HpHhbfOkjLlUhMhyhMKRCfSR10vOhng03tMuiA==
X-Microsoft-Antispam-PRVS: <DB6PR08MB282156B7F5B8D42060BA0387B0CD0@DB6PR08MB2821.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(10201501046)(6041288)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR08MB2821;BCL:0;PCL:0;RULEID:;SRVR:DB6PR08MB2821;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(39380400002)(376002)(366004)(396003)(346002)(377424004)(199004)(189003)(54534003)(31686004)(93886005)(105586002)(16576012)(106356001)(4326008)(53546011)(53936002)(8936002)(6246003)(478600001)(65826007)(6116002)(2906002)(386003)(2950100002)(55236004)(16526019)(77096007)(230700001)(26005)(6486002)(76176011)(6916009)(6666003)(52146003)(23676004)(39060400002)(97736004)(2486003)(8676002)(5660300001)(186003)(68736007)(81156014)(3846002)(64126003)(305945005)(66066001)(58126008)(36756003)(86362001)(47776003)(50466002)(52116002)(31696002)(25786009)(316002)(81166006)(65806001)(65956001)(7736002)(54906003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR08MB2821;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4TUIyODIxOzIzOjhza2ErU3VUS2Z2R21LU1FLWmZLdG1pU21P?=
 =?utf-8?B?Rzg5OGxJL0pDVDVRUGpQNmgwNnRENFZjMmVvamVuUUtwTXAwczhxZUFheHRC?=
 =?utf-8?B?OVArTUFvTlRyQmh3b3dGcUtKb2ZJSVZXNGpzSmF6TmhoaWlVcWQyK2Rua2xv?=
 =?utf-8?B?VklVQjlXQXB3ZThxQXUrcis3RENSQTFHREF4dlpDU012cjhsSUZyc29WSzdk?=
 =?utf-8?B?TVFuM1hOR2xrcHIvTTNNWUVxc243bXY3UWZoWjBXekoyVDdLWGdrUXZoQXlN?=
 =?utf-8?B?MzBxYXlDc3EyS0JjeDdWVmh3YVd4aldwS21UeU0rM0lKZ2RQaGNkUWhCYkRp?=
 =?utf-8?B?akxsVnJ1T2p2Y0JxSFpBZmhCTHZ3c2xYZmd3RS8waEV3RHVESVdnOUd5YWNw?=
 =?utf-8?B?MXdxZmZyNGt5cldzUWdkVUhEY3lwWUhEOGJXS2l4dVVhVXVYWmhVUTZkSGZJ?=
 =?utf-8?B?azZLSldYT1RhMFBuTCtHcUF5MDkxSUtDdmx5N3FMUmdVaWlMRWVHa2p2ZWFv?=
 =?utf-8?B?dkY1NVVIZ0ltYjVVNHV6VDBXMXVoUWNNMGVFU0pGMXlGbzEwRVNkNHFHZTda?=
 =?utf-8?B?b3h5UFRlMTgybG80cUlxKzF4Q0dHREZTa0x3OVhWQlJQQnBKZitET0lmWEJU?=
 =?utf-8?B?MW1aOTQ2ay9GUlJCeG9yY2lEb1hnY2lBdWt6cXRFY0RKNEt3ekJheWNEaWUv?=
 =?utf-8?B?STdTVTVsdXpNQm1wNnEvYm1qSXMrQ05GNFRzaTZieWpTakl2VUY1UjBaZWNj?=
 =?utf-8?B?dzIrZmh1Nzd6Ni85UUxlOVBudURLVlYxWE0wM0RVenlZRFo0YTJNN3JQQUds?=
 =?utf-8?B?YmNqSm1SOHIvVnFIOGl5QVladlh4TFhxdXZNaVZad1MwWEZkL3NRK0RvZWtO?=
 =?utf-8?B?U2lrTDUxY1MzK0RJbW5XZGR3TnFFcjErQUx4MWsvZTZNQ1lPaDJsOEVSMDlr?=
 =?utf-8?B?RnN2b1lKMVc2TUo5dU04SG5QcHpXaTdDU2xkZVpsOVJPb05CKzFBQ09CNmJn?=
 =?utf-8?B?YXlacTdJb2FmZ1NHaE5PUGkvTEk0N0k3NGFPajJ4eURXMVd3YTQvb2xSQ1oy?=
 =?utf-8?B?RW1ycWxZSDFHYS9UVzRUajR6TEdva3RGcFJSL1dlOSt2R0c4RlQySzF3eU4z?=
 =?utf-8?B?R1J5endVRXY2YUUvRk9CTncyUXNYUDI0aDlwTStsb0ovT3JzaEl2NVUwZmdT?=
 =?utf-8?B?VVJSN3IvcFA4Qzd5ZHhISHc5cDZ5T2lQS2UwU1B6eTB2WWcxV1MvMkFoRUpq?=
 =?utf-8?B?L0pTNE94b013dWR6NThVdWd5VG5qbTlFU3JwK3hIUmc3ZE1YVXhtQUdvQTRZ?=
 =?utf-8?B?b1pVN3U1cGM5ZEV0K3VEenJZWXMwQlVxM2hjT0NJTjJBZlJkcFFjUEtsUDZD?=
 =?utf-8?B?aURibnpRVFg3ZWgrVXg2ZXhMNFVqc3ZaT00wNlA5Tldvc1NhcG5LUzBqemlw?=
 =?utf-8?B?aXdDYXphTG1IN1VEWE5VNDdFMFhqdWN2MU5iaEt2M0wrOU1VcGNLVGcwN1g2?=
 =?utf-8?B?ZEFhRzdHTkRkWVdheVA0K0tMb0xtdlhNYktGd2c3T2ErWkJ6ZkVoYzhta0M3?=
 =?utf-8?B?VkpIWjMwSWtZa0xjSThzVjF6cU5nbHZIa1BlQkdSenFHYUlaa21xemhTTmJl?=
 =?utf-8?B?Z3RyWVNwQ1F4SHo5RVRTZmVjYWpWOExybTRXUkN3WnNmMEc2RVBTcmU1OWYx?=
 =?utf-8?B?ZTg4RWpUYmgwQy9aMXpNK0RsYTVOd2RWOUQzOC81czZyZXlvWS82MGFrTUQ2?=
 =?utf-8?B?ZDN2NkpTUFRtSkZ1KytlZ01GSGFHd1VSWFhGRUd1MmtrL1I3QURqVWNuazZM?=
 =?utf-8?B?TXZEeVg4cUlZUVF6RHYrV1ZWcXNCc0RPOVU1SklHWFg0WEtsNUxoZUhEY2ZO?=
 =?utf-8?B?aVFhS2pibmI0ZWRCWkVNeFFFUjMwTy9VVE9XK2M3OXkzTjRlQit5VVFsV3ZH?=
 =?utf-8?B?bXEveWlSWitLYTlwSktRTmVsQVJlRnIyV2NoaE5WQkJLWFBpNnM1S1BObTZ0?=
 =?utf-8?Q?XQe2ub?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2821;6:91g+r2H2AfCjF2SRgAvcOEJc8QoV0DYDTOAV4ENOWJAXYYLsyGXoNPKA3nYkiSqthAA56WrOqt1mz/b6rmqvEzOgnuO79AjeTU5QW7v23+ijy7P3vG/M4mz1IOE815gWMwvVQ78jKRpz7LxKB3Z1TJjT90dkdqFPiIZSazOjrteX1h16JFs8bDFw+qnDuoX/HJCNS/EsWQpQV9G+VEoKwaWyzJYIWdGkPyVzUO7Ri+Dfj0QatcD+L68Gs5NdwcQNFBxFwX/deq5caNIPvmhnm9syjqQ3aYkd+aLzmJnugu3xhQ0Yfn9drOkykJuUDsEnsesyLQseP4IDaT5/ACThEz5nPvtLse/nPFaHQcaQwr8=;5:0350pQsmGtYKo2T8f3nFtmYi3jaopeLvvXdSCtQrBLsH+cUnyW95ftip3KBzKRu/QvbjqD4N3D21GCS1OXZ74+Vfcnw2H9oY7c5cg23A2NH1/BzkSiEZsrzo+YrqM2Q34P3q7tyP3CtrOWn7r7I6Vm80uATtG3HkhLnAENFnKAA=;24:v3Sr7yzFdrcfH9eZ2t3RJpld195t1v5wi01qJBSsgXC2RaFxcBxrtpH5I6mLzizy4mqH7Qqd7GDLyM3LR/k6siGpFod7/G7pP4N7+R/Qc2Y=;7:aonfGkwYYXpl7/8SOYeQl/aO2tI9df9TlAd/ixhQEz1znfj9VtzSVmzgWyrbmrgQVywEXVA+onc7nSMM0x3EC/amGEP2dgee+Jl0RodxbrzbfUwr93NyRPGEG9UcTVfNTUj2PHeA9AHKjAo7lRqq8YF/PKrm1lz+S9EhA5v7jKSQk7Ks1R73wTVg/oKe9/7KEGWI3/jHFr31v6mNCKSc1k6sGfEy85cjRa2k4dhOmiRV8TsmpnZlXYrWiF601hZ/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2821;20:W34mLZmTDUu53jAW1SarDOPXECwEmnUYKX8fIQNcZpegqUMXRX4sOqrFpCoIV9i38RBy2eQ8NS8YxwyaJ10YDYVGp9IsOezj9fHe9k4I0ZAuQixPBeefeIdOkcL5uWh66Cbjo1MGfBals4nLYDmKvyLJb+jTCzaBHExJLoDXCj8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 16:01:26.3490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 783a35f3-924b-48fa-a660-08d57a0d879c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2821
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/22/2018 06:44 PM, Michal Hocko wrote:
> On Thu 22-02-18 18:38:11, Andrey Ryabinin wrote:

>>>>
>>>> with the patch:
>>>> best: 1.04  secs, 9.7G reclaimed
>>>> worst: 2.2 secs, 16G reclaimed.
>>>>
>>>> without:
>>>> best: 5.4 sec, 35G reclaimed
>>>> worst: 22.2 sec, 136G reclaimed
>>>
>>> Could you also compare how much memory do we reclaim with/without the
>>> patch?
>>>
>>
>> I did and I wrote the results. Please look again.
> 
> I must have forgotten. Care to point me to the message-id?

The results are quoted right above, literally above. Raise your eyes up. message-id 0927bcab-7e2c-c6f9-d16a-315ac436ba98@virtuozzo.com

I write it here again:

with the patch:
 best: 9.7G reclaimed
 worst: 16G reclaimed

without:
 best: 35G reclaimed
 worst: 136G reclaimed

Or you asking about something else? If so, I don't understand what you want.

> 20180119132544.19569-2-aryabinin@virtuozzo.com doesn't contain this
> information and a quick glance over the follow up thread doesn't have
> anything as well. Ideally, this should be in the patch changelog, btw.
> 

Well, I did these measurements only today and I don't have time machine.
