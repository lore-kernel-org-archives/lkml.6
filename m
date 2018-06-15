Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94F8C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE6620891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="jh5lCz2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE6620891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966009AbeFOTIw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:08:52 -0400
Received: from mail-he1eur01on0068.outbound.protection.outlook.com ([104.47.0.68]:11200
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965052AbeFOTIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9NJFR3RdLRbRBGHcSNn3oOSqbDtyN/2JwaEv0dFMyk=;
 b=jh5lCz2pkYysBDL1/FXbrgls9usZvNYHPoXglwPu3eHqIKbtmbPznpiyzJE/oPc+T25psj5U9eVuyEhnTAg/JCKzHlPdp+txO4Ut1C0Rcf7rUgU8Pr2vLeLRuDFWF3K2IZ8A49z/r663XSqfespSWmi3oZ737O3V1Wcb+zmaGbk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM0PR05MB4450.eurprd05.prod.outlook.com (2603:10a6:208:5a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Fri, 15 Jun 2018 19:08:47 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fTu5J-0000pa-7d; Fri, 15 Jun 2018 13:08:33 -0600
Date:   Fri, 15 Jun 2018 13:08:33 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] infiniband: fix a subtle race condition
Message-ID: <20180615190833.GC5877@mellanox.com>
References: <20180613234947.15767-1-xiyou.wangcong@gmail.com>
 <20180614053446.GB18426@mtr-leonro.mtl.com>
 <CAM_iQpXxHk+yFqqK-Hezsc83_mKfbUXr4=jjNnik5DwGscRKUA@mail.gmail.com>
 <20180614070108.GD18426@mtr-leonro.mtl.com>
 <20180614142448.GC24762@mellanox.com>
 <CAM_iQpWz9b01ksW_OUHgr1=pf-bNsq_TxoNCQxuDdhUXfvoyOQ@mail.gmail.com>
 <20180614172441.GE24762@mellanox.com>
 <CAM_iQpXFmqcCQWkyGPmev5LrPpDoEc=wpXQVDWJx2UQWPhwb2g@mail.gmail.com>
 <20180615025739.GB29138@mellanox.com>
 <CAM_iQpUYWzxMDgJJazLwvD1Tx_7i4PRC0r+2JKar3Vr4bW-Q+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpUYWzxMDgJJazLwvD1Tx_7i4PRC0r+2JKar3Vr4bW-Q+w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR1201CA0020.namprd12.prod.outlook.com
 (2603:10b6:301:4a::30) To AM0PR05MB4450.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 693f981c-9552-4923-c841-08d5d2f36c1d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4450;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;3:EN+vsk4bd1QEDyZjQ3trEU0Lc7E3DLxcJtUoTG+MoQAsPZcxxxtuoo9XNDjNEc/E4cH9jdZRbyuJhwJlGQEYzqnUUeViKDAw4s+V4bR50HASJ32Gbi1DM4VjJRnW3RI4i4NmfCKQEAZIAy34HE8/CsFo25o8hkRB89JwzYIDCjHwg6Q2/dcfLd1DIjSwVUMv/xhoWJ//8zlhNX1VeOFEA5WmQRtf5CibA8+VAFk86llW/Xk90o0LSPaNnGodgv3J;25:cjsjXGzOFXs6cGmVtqU1q3fINIaBDuViemEsl2+GOs25rcIQAv8giYFEuAp0iQxLckJMBA0PxqOzFuSK2qOFNwlSzabjs2pDxfk1coCeXeP+rXhhUpOTSBqba0S2HW8e9U+DCaHNtFxV8ZvBazJXGYlLJ+8335jzUWubKCeDHhieZga4qFW6Arwav4KUKMvA0mbjRb+Q2+fftmXf3171WIT4yIxVoyDxMSD8e97fpq/Ti1lZbXcfGEkIaQq5dl2xR1QuOQLJDclbjS7q/iacDNnlwsBTRxuGG2125wjXwsFimCGbJLmr/BkXKEjc0glyKwOh00fYWv0UY5IvNs2SyA==;31:oI7M4KXN58c7IOZB7nE/ZzHqq3EIpzSw7mMwX1Ol3jISOHLZNuTvaPeSCJD9myD1w39NCfrLiM5BB78OlmcvmaFlwBwHikJNca/maZwVTdzlWBB+qqTOPSjTPvbohFWMf2V+WPOqKdTu8p8X1zqcsTEe0fEs8UCwqD+4cA5orjKesgtln81WflzZN2EnevmV9I9jxXj13d+ogIT8AV9Xfb4HzA7baX28cBoYmemE7wE=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4450:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;20:UYNp1l37GonDaWoATus6ZPpNVH0gSRheHjp1bOMhFIBjMmOWqAAJcGu/D3FWWxBo1P+7ueRFgo9XVb95I28piRPiqwPGJ60IlnX4eSgxFCwR+ic1F4y6LYQ9NN7lmgufAesVJJWcSCP2y84wtxItfUkNh7MkpfTNLcLzkRTezlR/+DFBMMGwTWxVrtWLZBi1Fpiux62bILCo5osEkTRq2iIzUfCdPotfaFabOx0dIZVnlyIU92/tekNj6Rhim2wdQI4Hwd8fQ8NUqVj8IaKZpy4qpRFYXMDWHR5NcDqQi4tZ9jRQu60kQ0b1CPJAiLB+CSc/mkhx4/mNXnpHG+gPC4IdwlJ2sfHbCLs6j24ejvIU/UuWxDrYsnkAxXLpb3mcaTYQlxVSnnHBQUrGjN1/T37Xz/KFxh5R3+vjIRMGE1AtTVjaNWIIswJPtZBlP78zz7WZtI3APcUqk4MjwicB1TEe6nhn7N7Q+IbttDRS5VwpjtC6esTcO9zOLxJY/4Rp;4:NBhayySaKY1yDGztd998lQOuqUd4T5sxWIfkXW+bKF8c6p6XI4CWOnRD4qkOjN+ZweDVEGUZP6fL+qyyGdvYHDQ+hf0M/yKT3pAGCvGAdxTdq42JWFAn1IS+LXLp332NgZaPMG6G8/VPdaRhUQzRVH8MZ+r6IWSmqpgfN1y9/xf1hDNYHhsRdgV4OCGFqtk/VRe9Oq0Wg5nQh/5ImDDjXXakgeT9kQmd8nzt4l87CRwscxrthIFJbjf4RkKOuENrsDvytVCz2kiNPi/J5JbBJQ==
X-Microsoft-Antispam-PRVS: <AM0PR05MB445062E17B3C1112A6601C54CF7C0@AM0PR05MB4450.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR05MB4450;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4450;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(316002)(16586007)(52116002)(69596002)(86362001)(33656002)(58126008)(83796002)(2906002)(76176011)(105586002)(106356001)(7736002)(8676002)(305945005)(478600001)(57986006)(54906003)(386003)(46656002)(81156014)(47776003)(11346002)(446003)(2616005)(26005)(476003)(186003)(59450400001)(486006)(229853002)(93886005)(97736004)(23726003)(6116002)(3846002)(66066001)(122856001)(8936002)(1076002)(39060400002)(81166006)(9786002)(4326008)(9746002)(68736007)(5660300001)(53936002)(50466002)(6916009)(6246003)(36756003)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4450;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4450;23:LoiywiuLShGdkxXYtuAvsvUQD++LDe31GAenC77Pz?=
 =?us-ascii?Q?qQgseMkj3BAPnt7tIdIdiOJ2dryp9GP+cvGikAKP7r6Vaz0CYT8SNd0/PgLL?=
 =?us-ascii?Q?p68s8+7GsCMDTWC+9gvJFCRTl8NK1JQQQcYnJO9jdlKpa0zd61Tyn0pFOh+5?=
 =?us-ascii?Q?UZICr9kffm/AvwdPfJnpQV/JN0G9FKYmhmNdrytA/RkzWN9FI2usHl30D8MD?=
 =?us-ascii?Q?x1YJxcI5Y7mbaJL0e8RrGgBBt6GhPUwcIrxQekvnRbNL3HkuBwqqIiGvS8Od?=
 =?us-ascii?Q?Rh5ZkeUu5qnc5cv9ZFO+Pa5k2OwrboyMGefqed4eVt8rO2LUPYexJsSLC6ij?=
 =?us-ascii?Q?HYOGWzZ/gD5K6H/gjGjw5bSUQIhP67py9R1tgJYxQf+mFF9BHKpEG3FP4oX1?=
 =?us-ascii?Q?VwSzj8d0PKGYEL/pn2Ppw2VgMKxz6knL6VlIRaR7bHFtV5xJvRGRkLpq6fEZ?=
 =?us-ascii?Q?LC58IMEIUYWUrkzhVlurwSw91t+VM13lwi68WPC0z72LQ6QI/b1LpOAMKmXs?=
 =?us-ascii?Q?KE+YgUE92OuHpN236jjoiKSTVlidBpSTHEfdgn75uCjhs1JQ0fpNTbfqqZu3?=
 =?us-ascii?Q?LEmv6e5UQYXfR56c171plikF88yc0HGeMvZdqzyzIYKKFkGlObxVKuTHc7OS?=
 =?us-ascii?Q?dVGSZjgkKYCQLuq+t8Erd9djJWDpOghRbygu8s2+clz8avX6iSYjiuMmbsN0?=
 =?us-ascii?Q?xc7yoin7zOrfWAwkruZErn1dB6Vl2aTuBa2XX8DEzAHQV1n8SpuWT/qFOEwA?=
 =?us-ascii?Q?GF+yNG0cZucpOqmOoNARwdsOQVB5S6ZxyEuHO9gmCsCVlPvYhbYem0tyHQeg?=
 =?us-ascii?Q?xxdvX3gqGavV7ORpUX4BAJhn7JtThBTxMGTRLvwU2i16CH4roNRE3yFbRGcQ?=
 =?us-ascii?Q?EDW6iqay/LUaj18khD9RuNhexal+pC3YDe06IkLm/dYADIDPq808xDc1o8dR?=
 =?us-ascii?Q?cASAbPxyuOpe9BWHbOQ0vT0tKy6DmTmc01+C+cgT2P42IJgLpWbd+ZZAmmOR?=
 =?us-ascii?Q?WOIdtktF0fQN3JQzeUQJiwsjUx1qUgLOiE5sspqHgmzl88pP0Hpt2cBb1Eq1?=
 =?us-ascii?Q?0rAfED8LguqrHwctP3EPa+aIE+bJG69ykOyef92FjhoWpJY5QTXl3iCeh1E8?=
 =?us-ascii?Q?CCwlGWgA2QcYhMf1O7eXjjlt6wGn6a0yqTEuWJRmhhtjRISMov+NWVmCbRy4?=
 =?us-ascii?Q?MBus2XPFOF95xaoHld+dWti0zdZzKWe+mWqeFucFpavwBnz3kqZBHd/aZjRh?=
 =?us-ascii?Q?Xsfl4gukM9tWQ+8dmN0o8UDVoInv0P0vJP+Li+CLMQPh9GhKFqmgrRTCmTU2?=
 =?us-ascii?Q?ky2ZB190uXxEIrlMcwndAD1Fxn/gvl9sAKDeobGXGaHf6ita17mpSCHBV3pi?=
 =?us-ascii?Q?tN5+LEdZfE2nAsrfNgRZYaUh6JQzjUfged+2RO7QdCrgbL5ASSBy5i7HODsF?=
 =?us-ascii?Q?9vrTDk1dQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: gl3jr1zKFXfFYgaSH+M6H9VQc0BSxjLjplavs0gcsWvo2kwpoS74G7Pz1Isy+b3z/i2nxPq08iDB3d0x/s+HWtc1motQZTxpMBlDUIEDenLCd2xunQvfmxXtlxkLvnb3wYxN6csPRRfGtzPTm7GCSxa6gx4WUZq4oDRxCg/D1yglDjEFWvW3nIvcfFoFRMNr
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;6:+jQab7GvlXVWtycH+dy10TZwPpJ2LVtkc83uOekhWg0FOZHH643Vj3xMF+4swR4lTnd3MLNy/dnAdX39xo2EV8MM38+XDds5Vxskm4nLDCha2bVUZHs0fnCNc4hj5sMuf8u+twLsoh3ScBxl41ZbRajjiOVznLShUaiV4kxnhM+4Cl8WqfD8rRwkaUuBzXk7UZ/2H0uzfqGwidhtsOlifd4icp5xeUGEIjhf/UUndL4PwqeKWkwSGR7/L6H1Ji1IjCqTvjWSGhZUQF285jCVkCVqMX7LuNic3SKFv63hMtejD0+YeTQc2jxr4xT58ERDLjSyW/SqP0ktfOubi3aVktCkwW2iINXnCDcfjbUM5m3bTM6qw5siozsVzdZRHMOldkE7lDJEAsIq4Z37LOI47B1o9xAZVEIxgY2kF85988rbMQesm4pFF5q9Fi5iA0KVqUDVZFjj86qWhF15Gkuvpw==;5:SYbTmiF+hTgpWIDZktFQwh5RqP3YGz63q58to+tU3V7r9AzqX0UAcyiaaBZtK6i+B69EpWkH8rfDOugUnvINpkV5ogBkPzE33szjgDL8bLcc7cO8tCGJeyBT/LanSdieDPwLf49JIr9UDVhdA3oYvLg3yiTIv7rIzidl8oy/j0Q=;24:EJV3lQPatIeZJ9GWzjbYZDTnLh+J5eNmFPNYi8/cJj6B4hj2tW70+lTRmP8V6YV2XXRsvSw6QWLY7jAtuXl10yuQWK+lTq2HKJm6QPYmtmU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;7:HSLEdn18jZZopjXtnBKrP56jOt8q2adynzgw2jnoNXr7VQCUjIjVorUflH47tFQBm72gcNxjf3C/XeB/SaGJrXH1LCJiiMUQ4zMflEZ6rHvOS51B0CUhwn7kij8ZjLGeofGo0wrKoMx/BIb2lFiemPzY/NUECqDCcPYGxGTfGAIY988Rws7HDfjb8NytG3pknRpn6fTLRUtt/Thrx7wd2G2401Pp1RuXbF/QTLGCS0ckUuzBFjNIGoRUmm8GEB7h
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 19:08:47.3538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 693f981c-9552-4923-c841-08d5d2f36c1d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 10:57:49AM -0700, Cong Wang wrote:

> > No, it *is* the point - you've proposed a solution, one of many, and
> > we need to see an actual sensible design for how the locking around
> > ctx->file should work correctly.
> 
> I proposed to a solution for imbalance unlock, you ask a design
> for use-after-free, which is *irrelevant*. So why it is the point?

The point is, I don't care about the imbalance report.

I care about the actual bug, which you have identified as
ucma_migrate_id() running concurrently with ucma_event_handler(). That
seems like a great analysis, BTW.

Stop that from happening and the lock imbalance warning will naturally go
away. So will the use after free.

I gave you some general ideas on how to do that, obviously they are
not easy to do eg somehow solving the dealock with mut would be
tricky. But maybe there is still some kind of simple solution..

Another option might be to just fail ucma_migrate_id() when
ucma_event_handler() is outstanding.. That *might* be OK.. We've
talked about doing things like this for other ucma syzkaller
bugs. Also a bit complicated.

Anyhow I'm NAK'ing this patch, since it just doesn't move things
forward, and removes a warning that is pointing at a bunch of
different bugs.

Jason
