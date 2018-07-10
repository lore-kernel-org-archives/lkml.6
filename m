Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26099C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 17:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB44E208F7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 17:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="cLs6EjiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB44E208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933420AbeGJRKv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 13:10:51 -0400
Received: from mail-eopbgr710093.outbound.protection.outlook.com ([40.107.71.93]:33515
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933267AbeGJRKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 13:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPRCn0RV0b3l54KsS2QjERgL2UJSKFiHUMEHskhUfUM=;
 b=cLs6EjiYZ11zXsN2gPaAPIs9RngMh/bVgn1OacuXVCC7WPbOXa8o1f68nn99eopsWprCRX3nNHfHXhrIn5LQZZ23gTOu6efEOcg/qVw0RvM8lg5c/CgzFZgANzeqmSboXO/z9CDXI8Y1dKqpmc/8/+5YVsSrcuvA9HGCDj6iVKg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Tue, 10 Jul 2018 17:10:44 +0000
Date:   Tue, 10 Jul 2018 10:10:40 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180710171040.f3gyyh524xlsqv4j@pburton-laptop>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
 <20180709164939.uhqsvcv4a7jlbhvp@pburton-laptop>
 <CAAhV-H7bqhz+dzgPk0_tTAN6y_k_8Ds9heF0p5uPHsHNg0v4Rg@mail.gmail.com>
 <20180710093637.GF2476@hirez.programming.kicks-ass.net>
 <20180710105437.GT2512@hirez.programming.kicks-ass.net>
 <tencent_26F8B9E004D4512B2225FCE1@qq.com>
 <20180710121727.GK2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710121727.GK2476@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2201CA0074.namprd22.prod.outlook.com
 (2603:10b6:301:5e::27) To BN7PR08MB4932.namprd08.prod.outlook.com
 (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e13bddcc-4188-46f7-fa2e-08d5e68812bb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:avYJ6W9LEhJowaonoiy3pI7MNlme7e0kTtJjMNQLAxjvPuS4HX2Zj5lqrAQPYIJANtFqmQs2jL7X6dRyXSOQCo23iRPFxnwJevNeQkJocOA/b1X74Nvo5YsTsdZMyaZH1bhm2voU6Tdv31cVxbU57twHYYQ7++Zn50XGRE8v8V9jxXTcqAufXHoSijnQRKcYHtrYzrTiL6+kvlfB0I7lJpo1QdHXolQREdnAIykQNZJ8EUJtvGSfy1iDhN9WpAVY;25:JkQT9kygghVcJNmtIqL7fXwz0aV++iwI3ex9Z3nwIszvyXjLhvR0T3UlGcKYhKL57SK0wP/0E3gFcCSLFS4AkE5GgvfeY3XWG/Nu03gN98WcB2UJBX8H0GCslhLIRlrbGjr6Ok0UBzIXcMW8kJODA1tEk4ySZ8ww/nt4dB4BTH5h6ovlAobPLCaV91PZfhXC5qxG/YIFi8WlXbF+nGQmExwq69NziakDPndNL12nYwXcoq8alFFe+ml3kp5e1SZWay2CH+tvXjG0dLPO/IOCmieozkF2tsPr+Ue1NKZG9MjMjYOVJT5//yGGL+XE+8tEcCoCyx9CNzRjw8AubV1nyg==;31:wtXlQ1T1a94ybikcpupld3yc5e/jluXWxf0HgiI1RYXKKkLFt1YmDfN+DMX9xO0Ml0YXZRkXsOovp36HmeGozHYa3J/DdoQTHAqrbictdaLhNVNC9g3nZETJ8orcZJzTFh9wwUiNKGHQFDD159NuVHnPfuLUcpjwwbTcNPBnrcpZrWZpKldIZiefWlpYfevJZfmGL1wMh7xuDlaEmxjSo7ofGjWd10I80lCjwe3EX+A=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:5bQW8jTt/neaZzGh67PtBWXc/SSQm05Gei0EF/UnjFnRNCOSrbseAgh/rrDil9M1AWOylo/F3etg4X/MfJx22JzNkz0bXRg52cz+/oT/OmTsG1QZbaPy2/hG8h+jXvvPjbQZ2IktEYdAi86yhsyW7p/s+hix56Tefek9q8Vj+Vb3H452g9WupnW++tWRDP46seAaDIJSQ6JDJV8w5j/h98sBgX5Z1r33GEm25eIBtjjS6ctVrVmKyR8leIk7S2xR;4:bKNKySk4mpAEpS+qfhMGyQrjlCQbTGgwQQ++Q9RtRd+izrRAjU4Cob7E7TVZ2h4oRraUHiLQH0PDJAtxuM0fx2hrLxqU/zT7VDRxD/WFc/EjWF8W6bedMjNjkMWOGNAKiKmOTfX/8JIW8iaAkjsxoAoVql7x7VGpFzd+tvNknX/hfkef4r5qgs0cLM6ltZTsWzyIJbxU5sTksEOL9GiqIJTKSCFOkBu0u7AZPXCZ8tJHKGb13u/y80Ell7rpGnrmDopnXJItvBV0TnGh8pAYhw==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4932847AB7C9CF3415A04827C15B0@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(2016111802025)(20161123564045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(346002)(136003)(39850400004)(376002)(366004)(199004)(189003)(53936002)(58126008)(6246003)(4326008)(25786009)(39060400002)(97736004)(9686003)(6306002)(6666003)(229853002)(66066001)(446003)(11346002)(50466002)(54906003)(110136005)(2906002)(486006)(956004)(47776003)(68736007)(44832011)(6486002)(16586007)(8936002)(14444005)(26005)(42882007)(7736002)(16526019)(305945005)(186003)(5660300001)(81166006)(76506005)(33896004)(7416002)(105586002)(106356001)(966005)(81156014)(8676002)(93886005)(316002)(6496006)(76176011)(386003)(476003)(33716001)(3846002)(1076002)(52116002)(23726003)(6116002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4932;23:xN/Y99EOMeYBJ4+05sDTqmlG0kb/YA5S8n1L9jmeh?=
 =?us-ascii?Q?pwWy8dKwp5ix0pcf4iznSh9GDrzgO8kdyktJbKqkC7peTiPuiZI5X4e5QsTY?=
 =?us-ascii?Q?LVwkMmFizXx12goArwYyzUk0koczBz8PS/y+Fpyr7Rh5SwI778xeftQXouod?=
 =?us-ascii?Q?UDHVY4B+uoiSBbAp8e20cyPb061E1BTsS7bd/X6bh8m2nKsal9tVYLj4vj2i?=
 =?us-ascii?Q?stHa/eqDsFa/Z7wwG7epU46DBQ78wvfNUrXcmxBsOGTKINreVi5wa32CiHGT?=
 =?us-ascii?Q?pWgSvDbIMWg4gYmNUJMTLXonQ8OA1573EliYMReSSJh+1/PDgtc/MLBMURJD?=
 =?us-ascii?Q?+XyNqmUOdG+AzBinIZeTlkQhX2iXcOYnnQhBR51KiSYVFALUYGPr/kMMBmCH?=
 =?us-ascii?Q?lFcG2hdtQr/CQIzUSGnMH+Umn1Xs1DaxKrJcJoDQDWuDiyTVPqUuiTrofR9F?=
 =?us-ascii?Q?9gFQ8dn3QMGa1RGwtSw7nq5hOxVdOvuk3hkvSMMIulpK75XvpAj7p4RhXsST?=
 =?us-ascii?Q?ChYAtf3eCxnwfMnO3DGJheKgpQaER6BdQ7LIiv5s5BIJfbX9vJp3+bZbA00P?=
 =?us-ascii?Q?xHpZHBDYqwNlCnXgBRMSCMxZnD1eqzpUdFD5jjYn2EegqjfQ2C8PlkAarPs/?=
 =?us-ascii?Q?fTZJhYx6PMzYSGYJgI6OFfuwfrBeW4+L7A69OlXatodnc0lzBnFqJe6P9pI4?=
 =?us-ascii?Q?nTIishTqvfhKKWDPX6rRw20ndpp+PYnVvHpvXrwP1L/0QYA8iYBkaBPx/wdV?=
 =?us-ascii?Q?HFt1xCpf/hm05ruD05Nqdj17XCjdLlfRu5AEw+erBjs2kbvTjEOGZBbjxjap?=
 =?us-ascii?Q?iEf4ZBYa/1j87/Yvst//hk4TQeMv2H87uNtwvfolFamQFDKQCi0SfIX0uavN?=
 =?us-ascii?Q?AcVVmWfP9fXBJA3CwCMwKzkUNopZqOu7IczH2ZkCH+rlbBDxM6zmA8L3PDYa?=
 =?us-ascii?Q?vtN7ZUSX9Orv/iKKCq8Rpb/k7vsr/7LYra0+1pwQjb0R3fSboOtctb1UmUTk?=
 =?us-ascii?Q?PU0wJbrKeHKUUc6OS2JV14OeuPIHkXUYqvgjTHnDvR3OIZRpexmAjVzE+P47?=
 =?us-ascii?Q?SVTDcXSN74ePfOfyijJIPDPTFQU0u9Ksx+6ToFe2iRsRoOr7Q7xoc12lTPle?=
 =?us-ascii?Q?5tsJh+CS5IKT9ITDDc95uMDR7tNq5SvpTgFq4khDC7q3KilbTpjsjgYiqyIO?=
 =?us-ascii?Q?mx3BbLFmhiIBqScWStTyvFUDqGaZ98L1wn7xpir4kSTKWITYMxrcuUxUOZEF?=
 =?us-ascii?Q?nv0c2JDlYfDy0VR5bwkuz2Ojuj4oxfYGeWYZDm3Kn5OUfkj74pGooVQqAxtZ?=
 =?us-ascii?Q?Py+MlrFl5gGu3EXROterm8iFUnfHrOkP8PE1891NUJbJd31EGJOPnP2YD1AO?=
 =?us-ascii?Q?AgdmrZCS78fkRXShAdKYvab5dkoQQoLBGktX9Gy4KdAqyfZALdjBA3EPawxA?=
 =?us-ascii?Q?PYkVJUDKzu9TZEMCnBlver2UEU25DA=3D?=
X-Microsoft-Antispam-Message-Info: LBQFZtCGS824IsuFvAnc57SFOb7wUkQ08yZLQ+uH94iugPh8Klb9vKAS+u8bypsY1vXdozRYDTLk5CyN5Vq8VYxN5GoRyPROOQ1OG7F1jhjylFwzbm7Uc6Xgu7MI+n3/B6tjxfH2UiVYHlZDTSYWnFSaK2cAF1J0cIL2NyuVEFUwnZSKfFYRWtAgQTdLNenxsTRkC4Dl+oVGSWxbSsJj0coRp6FfPpp7z0n7QiDfYPrXIYEtD5ylfIDJRuS46KjyOvOtwpE2/FVbISGgrp5ZrjXhWwTpnKXZQ5Pi6EW8XtXdJ/PnSx8gZBJduSS8yUs2pQh16LWee815ivoG8Q1BKnPFjkfpu0OFeBjUZMCyWqc=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:GWeB/DTTZzvENJ7I4WZLUnE5uUXmqAr3ADIQAl9whkllqWzyGk7CVfd7FQcajc6kSsRGFZUE3mJ7pWmUcM2Yl9KCeihhT7v8dF2ILU01TfZdOLaJw171Ty9hZZgqIIFi1vIyV3XbMPs3aYnSCn2QMu8eQ3adgNEYNaBgYZn9UkbllKw7ARHOIW4yPznALbrzxNQZ6obkB6FXs5QTYJXW5iUnEIrICauTQCfWFfMZLJqXgx+3CWD/T9oZZRHLDKdvpaeym+S9eCARG6IvbsC+M+2A33LjKxiEy8FNGONeug4c6/Hv2KOV2kXPBh0vmGJwhx+WTLsu6tzv94iBpFjNVGEZqoSBRt9Luermq5cgT8GDkRdr/RwXA0US0t07552FP5yEnBHiWm1LJVxxPEBJSMajqFUOnTd8UbmTVcY6IEP6L+JxcfwaMh2/YsHMZ7NlADuLl1eqWYff4QjR4FcavQ==;5:F5JqF80F6geMroEbff0larfpd7NegOVUh4QTa3/Wgu850ciiVCnwQzdkgIiRhBQd+cuJ5HMa1ytpm0++N7hiMbHhZaasXhkTTHvQI1WXBU6kfCnql2P8Z2GaVDEx9p47cFFLT6Kvdtmez6E4An7OB/DhqtAoGAYJzeERnuYhxdY=;24:9oHVg4i0BwxtZUQmk65kEXXcsMzTotkOxyuS94yNmdN+X6USgpsxzIOpUZE7Y1leWTk7FePNizMwp1buSa8EXMfNn97NHTXOnqUVD/CacaE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;7:MODyV1nYGfQvdbeTXYgl3hQ/2JZ6sPY2xKJWBUUM+u84CUWjlRDt0eUH3WtMePE7GHShGWVOlD4XOy9s5irqXMzQNMt+fNSgD+OcEQ3Sm9iUvTm0J/ir86M6aF2IMXK6AEyV/Li2+rzxXvxBWm2KDzab5fq3LjyFwPUin1UxXnElg27iUYOZW9EDVSJdDXByGkY6FNe/+vxJQqzLzMED+4oJAFUftEwiz/WI6iCWW2SGeYjgcafpdA1bNTDQidiE
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 17:10:44.4543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13bddcc-4188-46f7-fa2e-08d5e68812bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jul 10, 2018 at 02:17:27PM +0200, Peter Zijlstra wrote:
> >  1, CPU0 set the lock to 0, then do something;
> >  2, While CPU0 is doing something, CPU1 set the flag to 1 with
> >     WRITE_ONCE(), and then wait the lock become to 1 with a READ_ONCE()
> >     loop;
> >  3, After CPU0 complete its work, it wait the flag become to 1, and if
> >     so then set the lock to 1;
> >  4, If the lock becomes to 1, CPU1 will leave the READ_ONCE() loop.
> 
> > If without SFB, everything is OK. But with SFB in step 2, a
> > READ_ONCE() loop is right after WRITE_ONCE(), which makes the flag
> > cached in SFB (so be invisible by other CPUs) for ever, then both CPU0
> > and CPU1 wait for ever.
> 
> Sure.. we all got that far. And no, this isn't the _real_ problem. This
> is a manifestation of the problem.
> 
> The problem is that your SFB is broken (per the Linux requirements). We
> require that stores will become visible. That is, they must not
> indefinitely (for whatever reason) stay in the store buffer.

For the record, my understanding is that this doesn't really comply with
the MIPS architecture either. It doesn't cover store buffers explicitly
but does cover the more general notion of caches.

From section 2.8.8.2 "Cached Memory Access" of the Introduction to the
MIPS64 Architecture document, revision 5.04 [1]:

> In a cached access, physical memory and all caches in the system
> containing a copy of the physical location are used to resolve the
> access. A copy of a location is coherent if the copy was placed in the
> cache by a cached coherent access; a copy of a location is noncoherent
> if the copy was placed in the cache by a cached noncoherent access.
> (Coherency is dictated by the system architecture, not the processor
> implementation.)
> 
> Caches containing a coherent copy of the location are examined and/or
> modified to keep the contents of the location coherent. It is not
> possible to predict whether caches holding a noncoherent copy of the
> location will be examined and/or modified during a cached coherent
> access.

All of the accesses Linux is performing are cached coherent.

I'm not sure which is the intent (I can ask if someone's interested),
but you could either:

  1) Consider the store buffer a cache, in which case loads need to
     check all store buffers from all CPUs because of the "all caches"
     part of the first quoted sentence.

or

  2) Decide store buffers aren't covered by the MIPS architecture
     documentation at all in which case the only sane thing to do would
     be to make it transparent to software (and here Loongson's isn't).

> > I don't think this is a hardware bug, in design, SFB will flushed to
> > L1 cache in three cases:
> 
> > 1, data in SFB is full (be a complete cache line);
> > 2, there is a subsequent read access in the same cache line;
> > 3, a 'sync' instruction is executed.
> 
> And I think this _is_ a hardware bug. You just designed the bug instead
> of it being by accident.

Presuming that the data in the SFB isn't visible to other cores, and
presuming that case 2 is only covering loads from the same core that
contains the SFB, I agree that this doesn't seem like valid behavior.

Thanks,
    Paul

[1] https://www.mips.com/?do-download=introduction-to-the-mips64-architecture-v5-04
