Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0469C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992312098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LAz8h9Ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992312098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeJQASF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:18:05 -0400
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:40133
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727016AbeJQASF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=032NYMqbBRYh4x9IPHC8MSyVE4YO7qmC+VgD485rhNM=;
 b=LAz8h9DsnrQbDCU1jFPlRRjo1xbqN6Ksw+DeXdRSDPjzuMEewRj98bhFegh1Sn6eSP2ZExVBCy+qYZT5hfhYZvpw5RbfY++R9Ua74IaCOxvF4qeerjF64Jki0IpSFATZ9thGixrRVWVbMiho+J5qMS+nxrVCR0hpiBFFYAm4UgY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mark.Rutland@arm.com; 
Received: from lakrids.cambridge.arm.com (217.140.106.52) by
 VI1PR08MB2989.eurprd08.prod.outlook.com (2603:10a6:803:44::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.31; Tue, 16 Oct 2018 16:26:48 +0000
Date:   Tue, 16 Oct 2018 17:26:45 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        songliubraving@fb.com, eranian@google.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, megha.dey@intel.com,
        frederic@kernel.org, nd@arm.com
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Message-ID: <20181016162645.ymtuk6qqz65sg7bt@lakrids.cambridge.arm.com>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Originating-IP: [217.140.106.52]
X-ClientProxiedBy: CWXP265CA0074.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:39::14) To VI1PR08MB2989.eurprd08.prod.outlook.com
 (2603:10a6:803:44::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69d78b37-763e-4bec-2633-08d633842c2a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB2989;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2989;3:EyOO0qRuotcyrTfjMX3apSvPMtGxhLTHVq7JAvtd0CQFqWz6SeuA54GqolYVnrti7wQ49J/plrRX6PekbvEzFtsb+LO5QML+KK7JBbj0VYEZ/iGt93d7U56akvqEpLVMK7NSEFwb/cbJeyheIWfVieAXEA/XC2NXCWCfOxSUsX/kQUheyQs1JQfvDdmhyEuv3nZl9bQiHKLWRWgRDwXGYJptDRb1Fq+DDuRMP2P5/qntzdrWDjzNEO5JXfNh9D2X;25:OrypruS1QZUMUyVO9Ab/W+8pYmyoU35HGaSM5MsMRBYkpA11eykiLHThr2GtYzKnTt6DBURtydQnJ2hkSyR8PjNLOi0HCjqLqRvvb9m4zZE+cbU8bza2ovl9oruWna/tMQqThe+rNesCURjFPkr2Mh/UqeLcxhbKBOgDcQT8KrW99DBkrpKhrD2GtaZc9xLv0kSMx0/3H+A1O/glNOnWWvK6oxuOT0i0SLmxN7xVgxbsRoVtByVaEO4CU40HZotEe4mk2eIVH3iCfbNoSf05yjuYxiEx+r99bRcDw8ZwILR/LhIGEMOtD1oI4RnQ913LGvwRUCHiUOa4abxTxCyHhA==;31:Xbk8EyqVfpSB/HHXTFqiibufhxGrIx9UczFv35T6LZQjDG9l5jOD6xrTUQ/LCQuc7oJo3PFVpQerTMf1ngPDNaFCGgV85MDtJBx5i1Nzn+hFEOZF2s+/KWWzoYwmvfbhY76ifNHitrFoVaGd3VMFWkho+NUFIInSQLUg50zOAr/zv/msbTX/8h2eTTTJrNRfOWGh8A95PDe17JeMZV1IvwBCBPQAgKg9tBymeS0rg+s=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2989:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2989;20:gDXeltoTDRcCC7ITHKikfqCkr/jLNZt+F8scwKJMgiz+RPMksb6zFutV2/Zigm6OpBoIVQHtao7QgtEw90N6bV3YBD3YmoFedt8ZQGiWQJ9j7NQRe4Ffk6RlZjkSwwPq54j8gViBVxnxqA1HYou2+1HPzgCXIpBty7VOs8UFsiD0H31Z1IORBfo86fcwgxcpcVJNa09G8tzwBEKYef1vUozCHyuDk/fDh/3VVUnLkAc280ZDZNHQnl1AdqwvKN5Cc9Z8rif0a4LZv58ha76P6fm8WC23FWVh32vFgIoTVnY5SIPxNSB6V6sIEAH1OOpzO+Adsqg7LbzQIx9nY4Co7aL3xgPGLZ3wtK+v34ZzwrrvFjNMebQzU5KENQQi9IYTquPaJ2YgfJW0T3NpWa0ermbwvxP08ndlhqRxiwogglE=;4:jrqFrvvRzCmm14YTmQjZI/biCP8+rDhQSLV8eGG3IJ2rL3qhUt0N3b+mlMQoxm/kKE2BeGJbU3dzoGoweKu2jlZXRb0EAuuoYfskePzeyuEz8+LX7jaur6whMmFJEdzl7xN199WktoHBbnfqSuxsDoiWaYxjaglEp3+ua+2M7vHXFgcwJZJOvym4uliL9gDTICuhJAdGOUMlN4zBJfvScS/Yqn3elRBkRwhzLv43J3z8LuV/Eabp3jZ6HQzzLuBsxx8HCyTz/FoFYdneyEHyyVRRej0XKZQR6cM47F7qzNnyE1nhroiEqzZvSM45VNTR
X-Microsoft-Antispam-PRVS: <VI1PR08MB29893AE164D3A3656DA3392684FE0@VI1PR08MB2989.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170088055959);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR08MB2989;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2989;
X-Forefront-PRVS: 0827D7ACB9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(57704003)(53754006)(51444003)(199004)(189003)(106356001)(6916009)(5660300001)(229853002)(105586002)(86362001)(316002)(446003)(476003)(16586007)(956004)(58126008)(97736004)(44832011)(486006)(53936002)(6246003)(14444005)(55016002)(76176011)(81166006)(3846002)(16526019)(6116002)(186003)(68736007)(7736002)(4326008)(8676002)(81156014)(72206003)(11346002)(26005)(1076002)(23726003)(305945005)(7696005)(52116002)(7416002)(25786009)(478600001)(8936002)(66066001)(386003)(6666004)(2906002)(47776003)(50466002)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2989;H:lakrids.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB2989;23:IEBH4plMBJrA5pmMQ+nu51wRegLcYF7edsBzgmxBw?=
 =?us-ascii?Q?zubAXEu92kLPkQPE7lS7+HdWfqVDdB0JOBwh+NJlSWUUwEW0YtBJI3tiMgwA?=
 =?us-ascii?Q?zY+wpr+VRstQUIiQ51WgtotKo3qX+Ozj5gkRJwOYS5blfc12mWv9i62enVGY?=
 =?us-ascii?Q?iYE6qVMp8D9qKjBL2i3uGhM4LUuT0FCvkunhVuangOpowvgU2oEMccgJdU9M?=
 =?us-ascii?Q?Ey7PLc7/VluHrd+KtS6D+vmcduqPQCf3EhGdT3+LwIPYLi74xUeBrwz3Ilk/?=
 =?us-ascii?Q?UXYnY5linuvA+PkSX9qWUR6bwM2uvg9NBzfAHqmKnrUi9DUkAtfWb8J3tRzW?=
 =?us-ascii?Q?gS6RYmqzIOyHs+ymU90YYdipNCtL4qz9EPWW7ukMOXem9jr4p2H87zNasyeq?=
 =?us-ascii?Q?HWEkDBkWQbyBy89FCxCpqJZaFPlJpo8qnE/yOEdIlewqa6VzGhDMv8Z3hYBV?=
 =?us-ascii?Q?BrrqfUwDVFPqIf8vdux9vUp4UumKRmX22fcAt4tdmHR7mE2NJSHLbpU1OUZ6?=
 =?us-ascii?Q?sleUv46odovunNx1YpSlGTH2Zs1ZpZTm+m2ErzjVyrF6fhNh8dcgf1G/4aJh?=
 =?us-ascii?Q?Hn9hB7g6HbmG0kFMZckt0G1RPFUI4Va0uWEvz53w6gyFY1kJlDUDmxC9z/mN?=
 =?us-ascii?Q?L5QYP83HK+YJ/oR3LvxaWIHrFoCBR1LlElHDpPz/4xCwAINWZ5QhNEkEMLBt?=
 =?us-ascii?Q?LYnTrnBYGTSKd/lnMheTlt9I+2Swg6o1BCJf6CBKgr1VJthZqbVCri4U/+s2?=
 =?us-ascii?Q?vM7c54/OXuf0PN8j5+0nWwD4Xl34BGhzXR9EJ6mhSky3wec0VqEt+YTLkiQX?=
 =?us-ascii?Q?XqFPrvpanYW23beiMrMuIp3+Bkw/9nTLARGraegwTE0IrRWDZpnIL4QNCXxl?=
 =?us-ascii?Q?7E9yj27MF5coKP7H8KNkqBG8uvmB/DEGE7NbtQN9G1g71+unhND/v/RKoWQa?=
 =?us-ascii?Q?30Wq4EZDa3xlrUb9kd0ZGTbcHbAxrmPLnW3mI8I+FpUEVl+sO+kfI9ZPV3i5?=
 =?us-ascii?Q?wGSmXIHvHVXuUXxQmjsCfQ5VQOHv+25wu6NcfWrz3rN2j2WxcupRrxmHY5yU?=
 =?us-ascii?Q?3l4N+Y06vnpSSYXAm2JBDBQ5w9tbgsO/8neueQbLjs8FL2eZHgmd5Ck1otM3?=
 =?us-ascii?Q?zbZ47s55PwB4AszXSuJKM+HZ3eHLix1JVt0MBz/Z1oph2Gb09MYt3w8L2geM?=
 =?us-ascii?Q?dkxXVz/DoSSSPgjFimYdTg+p4nSf/N6xX14UbsfcwAPMkOgn5dKMfuvZ5Mk/?=
 =?us-ascii?Q?TV7aZ+JGmsq4Wt6stkDTXE12hEvOgunrnzEOv03nkWSYE2s47Q134yv9KR0Z?=
 =?us-ascii?Q?URZZbLJWYq75ZMl3x7lIQM=3D?=
X-Microsoft-Antispam-Message-Info: V9do3a5mX5sH94G/GEPCT7d6lvt5hzFJ8ve1gD1/LNm6jUFRae/r9rU/J1QwGurQXNY58dHrOtaAl7KrJ2UEohXdEexTJxkH/EHUOUvjHltVwg1I4dMJqH3WlPVmWmW8KG5h7R29yRFZ5LozTEgETkw07RKU3lYCMZsArItH4jRz/jWmuCY0IeBh+U7lh5YvR+NZiDLx7p5c9BOoPqqXhvM5JDNzRi0xHEHQmPqJlj5EFESkahtwPykcKrdaz5FrSEiL3cBVFD3yS6B57kmdaxjM5O6aKh4wJV4XXa8mEFoC6J3IyLP6L+MykCjumP5xK7bNSN0AZFmTAc8mhMh1IuPGpze7Qmji9EO6m7GJ4Xo=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2989;6:gmLcauqBPoGoUSPr1yCAfp/dyfY5KCeF+pnue9GAN06skOzmhtCma5WSFlbCtpQmg2Jr0dwE0xw4kWlCtnJBLT9s1iyZN/EllphzJaCpbYublf/cv9hlMqYeySDG9hkdlpSnyskSXCqsNtBqYqglFDsDvUp0G7UrFtrdtJe9ssltDAddfXITTCyD+HOaGS6TSx4lFyHapDOX5easTOiTjHXG1RgSe+Lkdt0JSFiHesZn6S4YEX4EJ1A3HcJlcFx73ewtaVc6C1VLLxnJ1ZYgFRavpSpZHdCAx6kTjvA78LqG3hdRT7yTNYXDC215UeNIBGU4qiMkAgNWtcG+2f+bdWtAdjGRcFRKKQL2HbfE3n/NRk0oN2F/dLrhuCO9OaLsq9ZoojPKnu2/iKS7ZCIuQv9TSmvohqbI5f8kQ0H+OQRO9lxe/x3l3mwo8yIjsh3x3tDgiA/WodmT91tDmX8o8A==;5:QATgZJ4HvjBFuGTal/JkCtAtgRNtQotf7N1gD4CtphTUEGXfSdbcFoERzUHo5C75D0hLXOOJ67El7MbKqqnQZVKwP6OD5KrNrATOx4S3ASYe0tsSPwIv8qbzR/kBy+MpsDPuh5lJOXnaChv4+hGodCSWcKXsi8OVmYrd3rVZaYs=;7:7Gd29L2IxJ0hLDpc0yqhE8CSTCzSgpC3gBZvG6e8O+nP/aIoMX426k9YIgFiEnSXzSx8w4iF3f1o1HChW1hfev32QyZBffsWzBfI7yzwTJ3C4u7gIYfSYjTagJUrycyL+UwUFt7YdCIuGDsVQL+prQzRd25tmbQAKNFDURUeSjSvaAwvuNLUu1MMF+u+cAFyOaGWIO119AzyZR+Wo/TJi9n2PyB8u8DvNVLTRVzkvI38iHi9iR5PaGwPx4Gv9qvB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2018 16:26:48.4007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d78b37-763e-4bec-2633-08d633842c2a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2989
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 12:45:59PM +0200, Peter Zijlstra wrote:
> Hi all,
> 
> There have been various issues and limitations with the way perf uses
> (task) contexts to track events. Most notable is the single hardware PMU
> task context, which has resulted in a number of yucky things (both
> proposed and merged).
> 
> Notably:
> 
>  - HW breakpoint PMU
>  - ARM big.little PMU
>  - Intel Branch Monitoring PMU
> 
> Since we now track the events in RB trees, we can 'simply' add a pmu
> order to them and have them grouped that way, reducing to a single
> context. Of course, reality never quite works out that simple, and below
> ends up adding an intermediate data structure to bridge the context ->
> pmu mapping.
> 
> Something a little like:
> 
>               ,------------------------[1:n]---------------------.
>               V                                                  V
>     perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
>               ^                      ^     |                     |
>               `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
> 
> This patch builds (provided you disable CGROUP_PERF), boots and survives
> perf-top without the machine catching fire.
> 
> There's still a fair bit of loose ends (look for XXX), but I think this
> is the direction we should be going.

I think this is the right direction, as this is roughly what I suggested
before the RB-tree stuff. ;)

> Comments?

Vague things inline below.

> +/*
> + *           ,------------------------[1:n]---------------------.
> + *           V                                                  V
> + * perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
> + *           ^                      ^     |                     |
> + *           `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
> + *
> + *
> + * XXX destroy epc when empty
> + *   refcount, !rcu
> + *
> + * XXX epc locking
> + *
> + *   event->pmu_ctx		ctx->mutex && inactive
> + *   ctx->pmu_ctx_list		ctx->mutex && ctx->lock
> + *
> + */
> +struct perf_event_pmu_context {
> +	struct pmu			*pmu;
> +	struct perf_event_context 	*ctx;
> +
> +	struct list_head		pmu_ctx_entry;
> +
> +	struct list_head		pinned_active;
> +	struct list_head		flexible_active;
> +
> +	unsigned int			embedded : 1;

Is this just for lifetime management (i.e. not attempting to free the
embedded epc)?

Do we need a flag? Can't we have the pmu hold a ref on its embedded epc,
and init that at pmu init time?

> +
> +	unsigned int			nr_events;
> +	unsigned int			nr_active;
> +
> +	atomic_t			refcount; /* event <-> epc */
> +
> +	void				*task_ctx_data; /* pmu specific data */
> +};
>  
>  struct perf_event_groups {
>  	struct rb_root	tree;
> @@ -710,7 +749,6 @@ struct perf_event_groups {
>   * Used as a container for task events and CPU events as well:
>   */
>  struct perf_event_context {
> -	struct pmu			*pmu;
>  	/*
>  	 * Protect the states of the events in the list,
>  	 * nr_active, and the list:
> @@ -723,20 +761,21 @@ struct perf_event_context {
>  	 */
>  	struct mutex			mutex;
>  
> -	struct list_head		active_ctx_list;
> +	struct list_head		pmu_ctx_list;
> +
>  	struct perf_event_groups	pinned_groups;
>  	struct perf_event_groups	flexible_groups;
>  	struct list_head		event_list;

I think that the groups lists and event list should be in the
perf_event_pmu_context.

That would make scheduling and rotating events a per-pmu thing, as we
want, without complicating the RB tree logic or requiring additional
hooks.

That may make the move_group case more complicated, though.

... and maybe I've missed some other headache with that?

>  
> -	struct list_head		pinned_active;
> -	struct list_head		flexible_active;
> -
>  	int				nr_events;
>  	int				nr_active;
>  	int				is_active;
> +
> +	int				nr_task_data;
>  	int				nr_stat;
>  	int				nr_freq;
>  	int				rotate_disable;

Likewise these all seem to be PMU-specific (though I guess we care about
them in the ctx-switch fast paths?).

> +
>  	atomic_t			refcount;
>  	struct task_struct		*task;
>  
> @@ -757,7 +796,6 @@ struct perf_event_context {
>  #ifdef CONFIG_CGROUP_PERF
>  	int				nr_cgroups;	 /* cgroup evts */
>  #endif
> -	void				*task_ctx_data; /* pmu specific data */
>  	struct rcu_head			rcu_head;
>  };

[...]

> @@ -1528,6 +1498,11 @@ perf_event_groups_less(struct perf_event
>  	if (left->cpu > right->cpu)
>  		return false;
>  
> +	if (left->pmu_ctx->pmu < right->pmu_ctx->pmu)
> +		return true;
> +	if (left->pmu_ctx->pmu > right->pmu_ctx->pmu)
> +		return false;
> +
>  	if (left->group_index < right->group_index)
>  		return true;
>  	if (left->group_index > right->group_index)
> @@ -1610,7 +1585,7 @@ del_event_from_groups(struct perf_event
>   * Get the leftmost event in the @cpu subtree.
>   */
>  static struct perf_event *
> -perf_event_groups_first(struct perf_event_groups *groups, int cpu)
> +perf_event_groups_first(struct perf_event_groups *groups, int cpu, struct pmu *pmu)
>  {
>  	struct perf_event *node_event = NULL, *match = NULL;
>  	struct rb_node *node = groups->tree.rb_node;
> @@ -1623,8 +1598,19 @@ perf_event_groups_first(struct perf_even
>  		} else if (cpu > node_event->cpu) {
>  			node = node->rb_right;
>  		} else {
> -			match = node_event;
> -			node = node->rb_left;
> +			if (pmu) {
> +				if (pmu < node_event->pmu_ctx->pmu) {
> +					node = node->rb_left;
> +				} else if (pmu > node_event->pmu_ctx->pmu) {
> +					node = node->rb_right;
> +				} else  {
> +					match = node_event;
> +					node = node->rb_left;
> +				}
> +			} else {
> +				match = node_event;
> +				node = node->rb_left;
> +			}
>  		}
>  	}
>  
> @@ -1635,13 +1621,17 @@ perf_event_groups_first(struct perf_even
>   * Like rb_entry_next_safe() for the @cpu subtree.
>   */
>  static struct perf_event *
> -perf_event_groups_next(struct perf_event *event)
> +perf_event_groups_next(struct perf_event *event, struct pmu *pmu)
>  {
>  	struct perf_event *next;
>  
>  	next = rb_entry_safe(rb_next(&event->group_node), typeof(*event), group_node);
> -	if (next && next->cpu == event->cpu)
> +	if (next && next->cpu == event->cpu) {
> +		if (pmu && next->pmu_ctx->pmu != pmu)
> +			return NULL;
> +
>  		return next;
> +	}
>  
>  	return NULL;
>  }

This would be much nicer with a per-pmu event_list.

[...]

> +	// XXX premature; what if this is allowed, but we get moved to a PMU
> +	// that doesn't have this.
>  	if (is_sampling_event(event)) {
>  		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
>  			err = -EOPNOTSUPP;

Ugh, could that happen for SW events moved into a HW context?

Thanks,
Mark.
