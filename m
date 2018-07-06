Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F87C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AF922560
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="lfozAYXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AF922560
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=concurrent-rt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934593AbeGFTFN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:05:13 -0400
Received: from mail-eopbgr690098.outbound.protection.outlook.com ([40.107.69.98]:50848
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932913AbeGFTFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector1-concurrentrt-com02e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZIiJxjKWVNPLTqRoAKlIwJzBouXVlbLdR7uDdFeMbc=;
 b=lfozAYXfJdheqzFJRZ57j47ppYRQ4ew+QN0NEwjaKSK8eZ47ai9J8QwXnF9TuJEcSHJtHKIIu0zNEMOh2VGajlpDLvGvlwCQhETKxCb/RlqVnoJxVjPZa6akn61Rz2Gcv4A67eA9l/CszKhDUzB2VOEgEOX9AXsZKZacCNk3qKQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joe.Korty@concurrent-rt.com; 
Received: from zipoli.concurrent-rt.com (12.220.59.2) by
 BYAPR11MB2568.namprd11.prod.outlook.com (2603:10b6:a02:c6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Fri, 6 Jul 2018 19:05:06 +0000
Date:   Fri, 6 Jul 2018 15:05:02 -0400
From:   joe.korty@concurrent-rt.com
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Julia Cartwright <julia@ni.com>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <linux-rt-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT v2] sched/migrate_disable: fallback to
 preempt_disable() instead barrier()
Message-ID: <20180706190502.GA26154@zipoli.concurrent-rt.com>
Reply-To: "Joe Korty" <joe.korty@concurrent-rt.com>
References: <20180704173519.GA24614@zipoli.concurrent-rt.com>
 <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
 <20180705161807.GA5800@zipoli.concurrent-rt.com>
 <20180705165937.5orx3md3krg4akaz@linutronix.de>
 <20180706105857.5tgi5irdxdryet64@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706105857.5tgi5irdxdryet64@linutronix.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Originating-IP: [12.220.59.2]
X-ClientProxiedBy: BN6PR1201CA0010.namprd12.prod.outlook.com
 (2603:10b6:405:4c::20) To BYAPR11MB2568.namprd11.prod.outlook.com
 (2603:10b6:a02:c6::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 386f9e1f-b910-45de-e919-08d5e37363c3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR11MB2568;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR11MB2568;3:eK16j0wONiKTHn0eSYQipVqVDfqOp69vDETHR3fZXwDH0doStwWABapu2Gp4jcVXZ0H3yOIF9mbYus2IGHXULjl3FhslECabldm2NG5Ru1W18vX6RqelhVA0rkLesrEUbOQ1ijZUh3gVs0VzUhR9aQRuHOdcUd56kLnDa9u5W4ZfqKM2V4zNbmoZPusskG82b4PIBqigfwDGT8VF/76jdOUDV4qV5MKaLQfPAPvnMuPx3r05wuTWv1pLiWwfJaiY;25:tMVTuCr5jIBVbEe10UkXQCwWItvwKKso6EHadsaESPcef9tujYHtiSDUFkE2qMHzY9CQsAYsIzfVZPUAZNAx9ikhrLyihiie1s8hkWTs0ekNSj4Q9Wq94eHkPpfwCJDaAOrKWc+0+SqQ5imiylo0kDjqlzbtfkW8MoGWe0bqimuoSSyklG9fbobzcVrjCBedZaTc2yymDWz5iFKHivXlV5HJh/dT5zfgdmJ4v4w9QEqSc5omqAvIPjr6gvb/6iBLe/908ri9B2TRjqrNBTfUFbYMPu79FaE4um6R1LBLHmlfXaY5IySIA2HycZ1A50gLlG87ix3mZZ+OdacEnaD1xw==;31:n9lFnj91iQaO0cYsGYf/GXAWtvAc/mPb3J1n8pBSJbARykHfx1UUPRYU2gHPyGIhQOyUbRJ7XrO+nL4TO7R4X1d0LOV2HcxR6QhsZZtXtlSN3EZFQeKfy/U+A5xx8OEvl9ym60m0f2beE7ykZAuHzJu5MiF7OVhO/jnxcL9SonZt2bjI6BB7lvZAL1baOt2hhGIjGu1powRAlezgkkcoMq1m7nZM/FWqZNlE+Lx58PI=
X-MS-TrafficTypeDiagnostic: BYAPR11MB2568:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR11MB2568;20:DV5E0eP6VJcp/ULCFivQufDK+Tqun45cQaRHlE7vd/StVN0p2JhcLYieEfgrfWbfoOFT91jisWXLeYeZmsdIlSsnwUNXC0BaqNrYnaufpfyIJ0V3k3+x438fa+sZBbcdHA85u0U9q39vEGbQIVgxvmoP5tzR4Z+7w3rQFuLvl6+pA5xdzumF7E2KLBHSKR6NNvUK62Xj33QkvC+lmuH3ewjzZ9HK051zjRGXiHvsCb+Q5RNSgmOG/SwyO7V7n+ENLdXB2phIm62Yg+LTMm0wKAQkaJhIrpUHp2E2G0N312cjNmqc4cSfpP/Xpt5LrwJcMRGrSNe7v3XaYowx5qYTl/+FdKDCnyJqFaJhOe3ehdaWcMpN0434rLFdyWw5HcaowEkMxABPYd4Iw9x4+2WjHH8Jx8mnzKH6zVDuw3EpQhI=;4:BBA3FmDybFkHlBxtn9Wg/9r/4EsYDMy3biABZrrAHJ9MBito8ko7srSWBNJKOKEXKyXXtzv35Nt5UPpLXspVbaSx0mQGt2E2wBwpDDJe4wP0ETzblwxHeb7nBVnma0ENs5am++gcBewHzP6rIdHOhtiTS7NbxMn60axixoshhCtBoTI/ZANXhuwyJZ52n0Vkz2da4qyzWlVKi0OJKWXf0c0MB4PHyrvNoWMB0snaut0lACWJ1yKRtdikXEh3I+y51y6zen4Idp+adMukqxwjzdpRnoFE6zUmiK+9E2lPEZDfTRZPDrGmMxdPWb9NDlMG
X-Microsoft-Antispam-PRVS: <BYAPR11MB2568653B23964F993CD5DCB2A0470@BYAPR11MB2568.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR11MB2568;BCL:0;PCL:0;RULEID:;SRVR:BYAPR11MB2568;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(53416004)(7736002)(2906002)(54906003)(305945005)(68736007)(3846002)(8676002)(1076002)(86362001)(6246003)(16586007)(66066001)(25786009)(6116002)(72206003)(14444005)(6916009)(81156014)(81166006)(23726003)(53936002)(478600001)(316002)(4326008)(8936002)(97736004)(85782001)(58126008)(69596002)(9686003)(33656002)(50466002)(52116002)(186003)(76176011)(43066004)(386003)(26005)(47776003)(229853002)(7696005)(16526019)(106356001)(105586002)(93886005)(6666003)(476003)(5660300001)(446003)(11346002)(55016002)(486006)(956004)(18370500001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB2568;H:zipoli.concurrent-rt.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR11MB2568;23:6eiikTw8S5mnvkmFcsFBSkrDZvCCqIF1tEt1bR19B?=
 =?us-ascii?Q?1u/ywFgspN9vS1BpdmpcQlpTfGUT7t8TT3ReU9/jsSZJusSVzQruG8Bo+5Rf?=
 =?us-ascii?Q?6JS9+/D5dOS8ZMzo49jmexECbWdKnkx924ubfeXlzOTJ1twbrfYGHvmlmZut?=
 =?us-ascii?Q?vN5K6BGm2U8axPyWDHGDHfIeUhQtlM8hyPHH0KbB8MYg+vi2i2pkOlNoMtwH?=
 =?us-ascii?Q?Bb4xs+YKU96aavk0IPM8ZCItEeuXjOix8YrdnsGc3Q7/xu/Q1ifneKKnnWb+?=
 =?us-ascii?Q?7JhGEHbog0Iln1zrLIXP5Vn+8OlCTSe5BBe1a6VatJiuNo9AyL6NKkkDe897?=
 =?us-ascii?Q?YQviNqcuSG1UXEYSgUIvdb64TWkeM1prQp8+qcCoEswa+xUsgAlZkeXdDNih?=
 =?us-ascii?Q?UcX3jYqmM1r2DhnuRaqfb+TOIfvWQdWuI9uk6xpgrHInMm+kiNGzkS5clSTU?=
 =?us-ascii?Q?l7Qn3HkpwVD/Zup35IH5q+xTHYWYiN9PLnpNrqXMhI495IkUOpZkomBqIDtA?=
 =?us-ascii?Q?OiDU1quCsat5p1Fw1TKG6OTzAq/ZZyYHBUuxg8XYZeoROqfjXcDwIPeSL9Vl?=
 =?us-ascii?Q?9A8qDHTpUfdLNQiBslBU71PJ7kVhM+uoDS+cWLaAeA9a+ABLRQlaxTMy/X5L?=
 =?us-ascii?Q?LAzk1H1dZ9iblyejz/4n54KUf1LPenFsLjqRhyZfIfPfsJ7RRnqRhl/RgrZ5?=
 =?us-ascii?Q?4X5CKaEvwRDcq5ddp1Hv4S0VWICuBiqHBIqitZu/ZyeuGLCcH6elgZpdWtYO?=
 =?us-ascii?Q?CTauN4bezGvJ/LgQBj5EI62KuemVlaoPSQbP03ePS5OSOxZXj9JMbr27C/0z?=
 =?us-ascii?Q?8LA8XIpzgJSNENzrH2dUTStdb9FawSP1ZVjSxam5nd0Jqb43vnPbnfyVJsHE?=
 =?us-ascii?Q?Tqv2RO9Z7j92LZb75m7I5I6xEXUzpKDhsbajoxkSQVlEejPQByrLXhcvqw9Y?=
 =?us-ascii?Q?nUxJLpVAO5TSnoB486OJtDk678L2bIBWd8En2FN+tDG7FdOR10+gqH0V9Ng3?=
 =?us-ascii?Q?x8vU3X7dr2iIYCPipKElGD9DUjLCdPippNrwfbbGywbPgo/r3iF9ALNw/I4V?=
 =?us-ascii?Q?eGd0naSJRTZWTS/qZvB8hM7w0sPo08doGNlnb1vpp3Qq83bCTYDwUgtq08Uf?=
 =?us-ascii?Q?bot43bgMLbER+hdiV6x5bWNlsJGVS/zjNgZFiUdrWsU1gpIPYB0rKG5oj6+g?=
 =?us-ascii?Q?a1mIDIzsjuqZDmTwIEdC2FhXkYN8hVuCR7elnt4Nw3ZL/uC4MJFE48EuOSQR?=
 =?us-ascii?Q?YhhLv9ej5Fm90b4x1tmJI9+xaUpY7N19dK2/pFI3Xj2KqzU0GXf9ZQ6r9+AI?=
 =?us-ascii?Q?s+d/Fo9w84jTV5cmjT8Va5Qa3XMfnWoXHjpaZr+FwUkNA0nHz5BjB1qVA7ZO?=
 =?us-ascii?Q?6qj5/i3WFiM6d2V0kFejsVyMV0SkNT7HWujFXK9Q3EEstBO?=
X-Microsoft-Antispam-Message-Info: U1KTVe43ytrvp8aDs3ojH5varbgbgYb9zabEp+34MrOjoIafs5EITi5xi2Z8V4wyWQCzsoa180tvaLYbROaecx3kgqhBNwSCYfZDGarnki5I2tCPkex7uNS1pwPG2K8huWxyQyCUynN8E9nET5VbkfIZ7Xseeg3gcotwxuX9dctVcfS+SydU4OlRR791ThyvLhKuccZvAlloDFRr7lV6B9BesWUJWyPb/wRJGEjYM24q+Rkjf0qVyZmwcdgiAtI+RoJ8Dymof2RdNGDHJXI1PsMfjHAzNv0lYF4cOGa5Nl1gvooEQaARLlmxL7TFqLi+NQDNFG1pabv5wXAJuxFhrjC0Xe+b0vRIDxRUSNorv7o=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR11MB2568;6:mYVVLhE1lCad3lZaL7fA4FXXqZMsMFzqLby/4ZOlEvhQyDsM8cGA+U9qC4iZn9zbhciopnzs2vsuLdcn5NPSUZntV0mIvk5XNXHlz+U0BReSdxep7o3BVlNZbIxPI1KBy/QyGMYdHVeiw9T1StB0sC7LQQupjBbJOzXGzIspdl1tEreVcaLIG89LOyb7zLr3USpNNVJ0PMBNg8EL1nqLiSunc71PSuHFKVj5g9hta7bBwi2bv0XAnGtibJ7aaO8SMh8F7GgK3AJCx1C78K/+Fqv+bXKKYXcMQdngNaLxuXHH59ZrZaa+GmWD/4UDmATCXxjRKAZUc3pocdzEf6gfrxEKqKWlwA74Nv7gT2M9IJs+C8uMXILawE3oMEzKud4rbkPIJun0WIEI8CdRzByaIVA0BNkxpWQBME/0Kk9DWSTrjEDWFHMr4N4I6LqjnAu9oWb8sIjE4EOTbU61pYhN8Q==;5:BeZomBrLDF5lpercLqZc/SI4OLOW81qpBjZvvco3beO9z0tKSxTRK6ACOWyuAfOu2UNa7efrw/vdotyZ21mWSv4QWmBp5Ct3V1B016FgwygyMBHK2et5oICGWcFh0aU/gdvKNimYi2K4oh93Sk0v0wJWMr08i376ghcqjqVOndQ=;24:NnjcI76OTDRRtvtsYYDdLGfUz4DUm9CWYnld2aM1U2/IH1w9wZKh0EqP+/xBBWYzpj21h7GlNhYePf1qfXoCRM+qN0ypRaS9oTAcPjX8zN8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR11MB2568;7:3p/SMoNr6ADu+cPHXdVHPOLhQsp5spS+qCHtzsdhF1LfydGWZ7AWqsTTLXf6P6XQhyaq2myWzwK6Zr10Bxzq1DMvb3zd4+gOVmB/P71TaBjXLNOsuFCuine7MOJhaRfkKiTUHGgGfrSMtnXhDKSQ3jW5c1Kgrj3Z/MWgdvg9dPkfXqrG+36WAgXRAK4/ccbKI7bwPatmlK1p4dSwRDcO5khrUAPfjY8RoOoyI4Fq7WrB45v4p+0FCXnUIfbwSg+L
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 19:05:06.8570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 386f9e1f-b910-45de-e919-08d5e37363c3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2568
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 12:58:57PM +0200, Sebastian Andrzej Siewior wrote:
> On SMP + !RT migrate_disable() is still around. It is not part of spin_lock()
> anymore so it has almost no users. However the futex code has a workaround for
> the !in_atomic() part of migrate disable which fails because the matching
> migrade_disable() is no longer part of spin_lock().
> 
> On !SMP + !RT migrate_disable() is reduced to barrier(). This is not optimal
> because we few spots where a "preempt_disable()" statement was replaced with
> "migrate_disable()".
> 
> We also used the migration_disable counter to figure out if a sleeping lock is
> acquired so RCU does not complain about schedule() during rcu_read_lock() while
> a sleeping lock is held. This changed, we no longer use it, we have now a
> sleeping_lock counter for the RCU purpose.
> 
> This means we can now:
> - for SMP + RT_BASE
>   full migration program, nothing changes here
> 
> - for !SMP + RT_BASE
>   the migration counting is no longer required. It used to ensure that the task
>   is not migrated to another CPU and that this CPU remains online. !SMP ensures
>   that already.
>   Move it to CONFIG_SCHED_DEBUG so the counting is done for debugging purpose
>   only.
> 
> - for all other cases including !RT
>   fallback to preempt_disable(). The only remaining users of migrate_disable()
>   are those which were converted from preempt_disable() and the futex
>   workaround which is already in the preempt_disable() section due to the
>   spin_lock that is held.
> 
> Cc: stable-rt@vger.kernel.org
> Reported-by: joe.korty@concurrent-rt.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1???v2: limit migrate_disable to RT only. Use preempt_disable() for !RT
>        if migrate_disable() is used.
> 
>  include/linux/preempt.h |    6 +++---
>  include/linux/sched.h   |    4 ++--
>  kernel/sched/core.c     |   23 +++++++++++------------
>  kernel/sched/debug.c    |    2 +-
>  4 files changed, 17 insertions(+), 18 deletions(-)


Hi Sebastian,
v2 works for me.

I compiled and booted both smp+preempt+!rt and
smp+preempt+rt kernels, no splats on boot for either.

I ran the futex selftests on both kernels, both passed.

I ran a selection of posix tests from an old version of
the Linux Test Project, both kernels passed all tests.

Regards, and thanks,
Joe
