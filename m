Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2693EC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6352086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="P6ssse4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6352086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeIKPKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:10:32 -0400
Received: from mail-eopbgr10097.outbound.protection.outlook.com ([40.107.1.97]:46445
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbeIKPKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KrTJQqenhzaqP6L4ZIhrA4I055HoXn6/T5Sv90oIrg=;
 b=P6ssse4PmI8fsWuYOBMBWRBeP6bar7vrvB3W84KocfUTgRX9uoUOlJWOBwXXem0NOVjquuuN9i3D81EiyUIbJ0zCvUc3mY8hV0g04ZkKgo+9Mu9ORARr9btjIRG8o0hKNvN3V0LKFs+WsLDf6K3ySBo0L0KfrYZiy6MUSlUwvKM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 DB6PR0801MB2022.eurprd08.prod.outlook.com (2603:10a6:4:76::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Tue, 11 Sep 2018 10:11:50 +0000
Subject: [PATCH 0/3] fuse: Solve request_find() bottleneck
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, kuznet@virtuozzo.com, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 Sep 2018 13:11:47 +0300
Message-ID: <153666041612.19117.14667042009014596105.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR0701CA0053.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::21) To DB6PR0801MB2022.eurprd08.prod.outlook.com
 (2603:10a6:4:76::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a65e62e0-678b-46ef-085a-08d617cefe19
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2022;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2022;3:i1djDAO73U++NOLHnwbrL1vdcM20X/5ZRoKekeIi/Mt1F1Ujp7UxSKppi5hry/8mbc9Txy9LCMW5G87nMNityEHMlzRq1bj6T0o37RH58M5FgBAu2Q5yErFn0y005vAUFoy7Q/GfgqcWopMdWeXaFLrzTi7RiOoDFucGfAag5oJbYdZSsybwaWphuMff/YNTd6naTf0OMEaj/rXmDHfSW6MTw03uVyzTe7raAiyhsCPGRwKd6wQSzEzJh6AXzwER;25:6aEc4yuurKZHADsX9foLw+BHgDNP5bjv2WTxdVLvl61olom++sQaoo3cVqqbl7B0pe2krfrTJNVivS7XSSrLP+e09DyvT0c3QtrgonrGMA+GNb09j4IVphjFVNZSDy7xB0y3i65Jth+ZK3ewa7iBwYsY04XQuFXyABwQzKLa1MlxDvs56HwzUCcbH81jezUZK0+Lg5p9hAld6+5yrDpb+eisn4EB/dqh9zrU8CaCY6ANmeqEjHe0xOMowjWjJjA0wnI7SSlWFf7skk//lnX9Kg7nCi74AGMFkGfyWaEc5OvoQi74ZlkAf0k3b7Gm0HLokyR4Tc/nSfXXrIBn9TGYXw==;31:ZZgMMEteVFB7vL0jsqK9IaWGbRGHhnd/wRKUJPbMfkdIHPjO1dOi1OdL4tZlxIDNK1XFHnGnEcDNCIxiSOZwHCqMzY+4FI1qm2TpBgN8SEco3l5ggtYmm9y5SPI++xLz7ROdSUxip7/PeKvK7Q9e0oq0gwuHaVrH8jlViJQ4wN6adYpnGNTIdLT4khxf1RNVpE3UW2Gy0TvGDgeMIkTqjSuoyPLNkdYihJD4SKqndLw=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2022:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2022;20:wVjfCKydke37yh3DcqNLZ2VSASgX0pM4KG6+jdmNt9Sb7foWhBc2Fy213wlSpJ1i4duV5JGJLkyg+fnxEEnigIiYBzKLOblYphvhKG9QgeYu+zieF7ARK15GGv6XthGpWUVRaIngcgp5aX1YXUFLgJ+gIfk1NjS71ZSMqjpnuCkWnnw19S6ZSOAu/yf5wBIBT1p834jnTAW8n3xEumckCV0na5W+HEUFZf2cuVX3MLrX/as4nsHpl/qxtwhGX50RY9ER/2GKN4SD6Cvs6+1xgXBmZnVOPG/e2joEDcOO9oGfugszl+hIEfB+kWu4spoN/mi1jYC3I+vzdt5KJ5LKyrrBaSpq8ruwMnhMvTQmUVgqg/AXrho3biZXQ4dsv5Nesc2MD2s2CBlCHUS5idnhJVmouD/OgsJqFExag5lfEVgTc5mK+XAbOPL58w/jVldb/8cQRKlAoDw+Zw515W51rAWygJCEIXenE6uId6YEtaOMd4tmjl03/ZI/BYMvBgJZ;4:DaGDETsHvbC12KIMidpLAEcHoClvIKS5eTf/FBHRSIy5ZYNdY0c8inD7jFV8HgGloDe1uPsC92npcMXqPZ6ICaPlsFm2b9dqui99SQ//5XQzTbareG31bFhe3pIrRA8Qh/zPgYSRvz8wqYNgDSTDb3xqQcGOKVH9h0ymFoCw2BPjxuUXK3Fkp/jAFxPP+vSUuc31fl1Z0RsEglPlEd6Aw2eTCWfR/JOxXQo+nEaJJONVx+k6rTDs/N7O7iB4dB0Z/KgCH6CkqtgiT9TuphEK/6TD7v66Nz1jJysnDBIz2Q3pZbCW3bAm06pfNpUfaOML
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2022549FF441DA3DB011E711CD040@DB6PR0801MB2022.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:DB6PR0801MB2022;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2022;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(346002)(39850400004)(376002)(366004)(396003)(199004)(189003)(2486003)(86362001)(81166006)(8676002)(2906002)(7736002)(106356001)(105586002)(25786009)(61506002)(478600001)(3846002)(230700001)(305945005)(81156014)(6116002)(66066001)(97736004)(47776003)(7696005)(33896004)(316002)(8936002)(53936002)(9686003)(52116002)(58126008)(55016002)(5660300001)(23676004)(476003)(6666003)(50466002)(956004)(486006)(26005)(6506007)(68736007)(386003)(14444005)(186003)(103116003)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2022;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjI7MjM6RGxpdnFxUDUwQk1NTGJLR2tQTHU1bHJQ?=
 =?utf-8?B?ckF5NkNSYm9qT3hRcno1LzYzMUtnOVJYalEySnM5QkNLbGpPWi9HRjRlRlVh?=
 =?utf-8?B?dm44WmhuenJ2SjVOR3BsN3JxWDRiL2R1Zzg0OEt4Mll4NmtmSHBDNCtjc3Ny?=
 =?utf-8?B?Yks2T210bkNYcUVObmU4QmgzWWN3cjlheDR1clJHNDloQ3V1czhzQjJnVUIr?=
 =?utf-8?B?cWk1S2hYQ2VCenZXalorcDd5MHhXVTJYanJJVFVhYWJjQU95R09UY3FZQmR4?=
 =?utf-8?B?WG5Ed254MVpVUEFZMDJoaTNHNm1aY1VRWGZOeVpwQnZFTzJMRTNKMGVPbFZU?=
 =?utf-8?B?QkhSRFcwb2x5QWhkSzhSWDhkZGptWjdENzAwNXk2eEl3ZFJTS3VrbmxRYlor?=
 =?utf-8?B?eWEvejREb3JRQ1hMZXhndkt0MCt0SkpvT3BhcEFlR1pveE4va2NIWC9qTHE1?=
 =?utf-8?B?czJLWUxWUDZwWjVQNkttREFvSjkwTG0rNXlsbkg4S2I2a29reFg4QnRacVpT?=
 =?utf-8?B?TGhCQXR5aWFkcjd5bzNBdkdDL0tjTFpxcDRTR3JpaURuWjQrWVVyRDA3cTdV?=
 =?utf-8?B?MTBwOU13YmRGekg2eS9uUjRqUmJSdDE1Y2FBOFgxQ3VSL0JteWptemNscWh1?=
 =?utf-8?B?cDNrL082TzZ5dWYyb0pXVjR0UXRBU1ordEMvSk1RR3hNV2dEU3VMNC90U2dX?=
 =?utf-8?B?ZkYycTlvakZ4djZ5QStxRWdpSUdIZTJMb1R3YWQ5K0lXTDd4c1dYUHFLdk0x?=
 =?utf-8?B?Rmw2SnZuU203QzVrWDVvdGJGZVY4Tks4ZnBmTWxzS3RYaTlhT2llaFNuNjlK?=
 =?utf-8?B?KzRVYTNCQjJiRXZBMVp1VzE0MUFadnE3TnVJWVpBSVNZOWdUbkM3a2ZTZ0o5?=
 =?utf-8?B?YXUvSllJTFhwb0NmRlRjNFo5R0RCUTQzYnVIVEhBdi9BOGdrQTkzVllBd2ll?=
 =?utf-8?B?aGdBSldYRzhlSmZuNk40UDRKL1ZMU0JIWHhuSkZHYTV0Z0Z6UmJ6enlQblpG?=
 =?utf-8?B?eFNLUm4wdFhiOTA2STd3bHZOeDdIdDcydHVTNHMrcDBBakJ0dzdaZUtWY3hq?=
 =?utf-8?B?ZEIrOTVMcTRTM0dYcU1JQndrY3cvZlZsRU1rNmdtOWZZTEhGWmswSm8zaEFi?=
 =?utf-8?B?eU5TcThyVU9aS3NZVVowL2JjanBINnMxTkc5SHkxaTZzTWxFWkNTWTIyd2JU?=
 =?utf-8?B?bGhwM0dYVkxWUTBINWJYb1FXQ1YzZnZaYWJUZms5Nm05RkkzaDhranBya1d3?=
 =?utf-8?B?cFJ1ME95N3d5ZkI3N0oyUFFJMW1xVXQ0VVFmb0lyVEp1c0UvUUp0N2lUZHdS?=
 =?utf-8?B?cG1iRWRtL0UxUkkzQXNZM2loVkZjTUp4L1ZXL2J0cGZSZTFibUtiSTRnSFJa?=
 =?utf-8?B?aElBVnJLaHJHTkNicGkvK01mcHNaNEV6UGMxMFdpbWFub1VmSUlxbHNvVnhV?=
 =?utf-8?B?cklRYjJYYUZibzhwZWpiSFdyQ0ptdGFlSWFCQnltNVdMVUp6enB2MDZFYUdX?=
 =?utf-8?B?cXlhS2ZPOERoU0VTdm5DaU1hT2YveTN2YkJJRGV5MG95dFZvc1kyS2tPeWVV?=
 =?utf-8?B?d2k4MzZjWFhKYnUvalBJQkdzb0UySW9pZz09?=
X-Microsoft-Antispam-Message-Info: r9Ng5kBau6alx+8Ucfb2uF2is9S1pFAFZkrcE4AkPGOf2qwgPCxrKp5TMPSyjmzPdWr5UOuQMGS3JYf3X3QOMMRbkv/93pahFgtkQrvn53n02XLeq/U+lTP7fHJd/1GbRQXxgDyKn0TWWL4btjgZkH8JkiCB5cGNFGJpbqJodfpEzODnIfLoHrFYZH8Iinbv1h3iJcZZc5Kx1qjxIvdrbr1sEwwprpskYfNqivmnEUwBob6MbRK2MPtoBZx7uYimNol7kVVHm2jP6uSGno+hU2u9+pcqSxh2Vfwei2SZrA0ROavdZ1CPGwUNlqSFzHoZGhLTwQA1A4iJNY1MiVZB/g2WJS7leC4IKagOX2i8ouQ=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2022;6:5CHEmWyHSheYFDDU8aLD6KE1c7JpywJbTxT+C6GL0GR1N9gn0vzDAmqBe4qNlRSjoj5cZwOTNW//+JDCoY3d6PF1b+MYytcJrGkKs3iFVDK5qik8PgnlfxrpSM4Tip/986zC2s9HHNVb39kWMVNlkpsJ8wG21GamlVPMmZ3UGw/K1VE67pHU+STtt7KoIODjHQnuhAkUgm7NTJQJVbTqwdrRmNuYO59MEdd+3aJBkzcK2Cl0vWlGDG8F7cqz/gZmG10pyrimFsEGfovWQ35K4/8+tM6V3lusQa6jD9fWBWZSfDYDuB4cXpxGvdKs3Np8A2oair8xXVfqsG3MmU5c4JXE0qxHM/wOQZInALDpc871C5kIzlQ7NycCLvwH26h1zDjkMAy91wGpVoDai/7NemVezn2NHBdt3l4X537HNxXwrBozHEgMtNWYgVkZbew1E9gCQksnIsBGKHFcyGcYqg==;5:7xeN4sXQspd3zXMcNTAplIhXSvoa5BEcgmlLWZ46OIsFOw5p7IujhJzZcWI3aY7Q4V0JuwvdpilFnyGPugoTtujnZGWg/WXUZtP4yZON+JBbPseQOXHgiB8L2cgRzu+Xxn38UZta5phfqTTIYA7je8xooH/rsczr1t+1KdBWFlc=;7:GD7XqauzXzCUwUEk4VI6EO9WVTaidJaYgjwMhGXTCBT3GofSdl1WTYWabjO6B3Je8mcdmPwszoYxInO8NEPEgyJjRldTxzQGhuXZJvsVvuMYSKIlKoO0t1KwWXKqEb0QGntp+aXCsNwLhHdDMbvYQGwPe5oMz5i3XEWoQU5UkflbNVNPMgLKH5cZ5Ur0+BHLyvKOLK4OwZPXOYn7l0tlF9YIjjqtcwmG44jEDynlndO3aGmVa4dz84kJuu1jP1tu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2022;20:vRY/SqCv6rgRH+qTt1xiSme+KACLZJmjtFFQJYODKgVpQThp3IPAcIpDcXLQo5+RAdoQTv3Vt01EgsHxl56uGsHxjNnR1C1oCiUyxdTKa8w3EqifxasuKmTg+lctd05dltrdJj5L9SQu1XvqgJy9RtwpYQ1XsdJwRP8oRoXdvzs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 10:11:50.6823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a65e62e0-678b-46ef-085a-08d617cefe19
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We noticed the performance bottle neck in FUSE running our
Virtuozzo storage over rdma. On some types of workload
we observe 20% of time spent in request_find() in profiler.
This function is iterating over long list of requests, and it
scales bad.

The patch introduces hash table to reduce the number
of iterations, we do in this function. Also, algorithm
of generating IDs for interrupt requests is changed,
simplified request_find() function and killed
fuse_req::intr_unique field.

Kirill
---

Kirill Tkhai (3):
      fuse: Change interrupt requests allocation algorhythm
      fuse: Kill fuse_req::intr_unique
      fuse: Use hash table to link processing request


 fs/fuse/dev.c    |   47 +++++++++++++++++++++++++++++++++++++----------
 fs/fuse/fuse_i.h |   11 +++++------
 fs/fuse/inode.c  |    5 ++++-
 3 files changed, 46 insertions(+), 17 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
