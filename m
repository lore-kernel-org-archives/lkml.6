Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754665AbeDBXjF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 19:39:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:61699 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754550AbeDBXjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 19:39:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,397,1517904000";
   d="scan'208";a="30523037"
From: "Luck, Tony" <tony.luck@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC: Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        "Ingo Molnar" <mingo@kernel.org>, Norbert Manthey <nmanthey@amazon.de>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: v4.16+ seeing many unaligned access in dequeue_task_fair() on
 IA64
Thread-Topic: v4.16+ seeing many unaligned access in dequeue_task_fair() on
 IA64
Thread-Index: AdPK2c/PPwOowndOTcOJK3AvgBGmfAAAW8cw
Date: Mon, 2 Apr 2018 23:39:02 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B3C0F02@ORSMSX110.amr.corp.intel.com>
References: <20180402232448.fbop7k5xicblski5@agluck-desk>
In-Reply-To: <20180402232448.fbop7k5xicblski5@agluck-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTUyYzdjYWMtNTM2Mi00MzczLWJkYjEtNDdjY2ZmNjFlNjdlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJ2ODBCMlhqcUZHbFFPWE96TlhMWmxPQ3l5WGkzV2FqczRmUkU4WEdqRkkydlwvV1wva2drWjBmR0kyUjkxMGVlQWQifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel unaligned access to 0xe00000031660fd74, ip=0xa0000001000f23e0
> kernel unaligned access to 0xe00000033bdffbcc, ip=0xa0000001000f2370

Here's the disassembly of dequeu_task_fair() in case it would help to see
which two instructions are getting all the faults:

a0000001000f21c0 <dequeue_task_fair>:
a0000001000f21c0:	08 28 29 0e 80 05 	[MMI]       alloc r37=ar.pfs,10,7,0
a0000001000f21c6:	c0 00 33 7e 46 00 	            adds r12=-32,r12
a0000001000f21cc:	c2 08 85 84       	            adds r16=4236,r33
a0000001000f21d0:	09 58 40 ab 16 27 	[MMI]       addl r11=-685232,r1
a0000001000f21d6:	80 02 84 02 42 20 	            adds r40=128,r33
a0000001000f21dc:	05 10 01 84       	            mov r41=r34;;
a0000001000f21e0:	08 00 00 00 01 00 	[MMI]       nop.m 0x0
a0000001000f21e6:	f0 00 2c 00 42 80 	            mov r15=r11
a0000001000f21ec:	04 00 c4 00       	            mov r36=b0
a0000001000f21f0:	19 30 00 50 07 39 	[MMB]       cmp.eq p6,p7=0,r40
a0000001000f21f6:	30 00 c0 a3 4e 03 	            mov r3=-219008
a0000001000f21fc:	60 00 00 41       	      (p06) br.cond.spnt.few a0000001000f2250 <dequeue_task_fair+0x90>;;
a0000001000f2200:	0b 50 00 20 10 10 	[MMI]       ld4 r10=[r16];;
a0000001000f2206:	90 50 3c 24 40 00 	            shladd r9=r10,3,r15
a0000001000f220c:	00 00 04 00       	            nop.i 0x0;;
a0000001000f2210:	0b 40 00 12 18 10 	[MMI]       ld8 r8=[r9];;
a0000001000f2216:	60 1a 20 00 40 00 	            add r38=r3,r8
a0000001000f221c:	00 00 04 00       	            nop.i 0x0;;
a0000001000f2220:	11 18 71 4c 01 21 	[MIB]       adds r35=156,r38
a0000001000f2226:	70 02 98 02 42 00 	            adds r39=128,r38
a0000001000f222c:	68 f3 ff 58       	            br.call.sptk.many b0=a0000001000f1580 <dequeue_entity>;;
a0000001000f2230:	0a 10 00 46 10 10 	[MMI]       ld4 r2=[r35];;
a0000001000f2236:	e0 f8 0b 7e 46 00 	            adds r14=-1,r2
a0000001000f223c:	00 00 04 00       	            nop.i 0x0
a0000001000f2240:	0a 00 00 00 01 00 	[MMI]       nop.m 0x0;;
a0000001000f2246:	00 70 8c 20 23 00 	            st4 [r35]=r14
a0000001000f224c:	00 00 04 00       	            nop.i 0x0
a0000001000f2250:	09 98 c0 02 d7 26 	[MMI]       addl r19=-2069584,r1
a0000001000f2256:	50 21 80 00 42 00 	            adds r21=4,r32
a0000001000f225c:	83 01 05 84       	            adds r24=152,r32;;
a0000001000f2260:	09 90 00 26 18 10 	[MMI]       ld8 r18=[r19]
a0000001000f2266:	60 01 54 20 20 00 	            ld4 r22=[r21]
a0000001000f226c:	00 00 04 00       	            nop.i 0x0;;
a0000001000f2270:	09 a0 fc 2d 3f 23 	[MMI]       adds r20=-1,r22
a0000001000f2276:	10 01 48 a0 20 00 	            ld4.a r17=[r18]
a0000001000f227c:	00 00 04 00       	            nop.i 0x0;;
a0000001000f2280:	08 00 00 00 01 00 	[MMI]       nop.m 0x0
a0000001000f2286:	00 a0 54 20 23 00 	            st4 [r21]=r20
a0000001000f228c:	a1 8a 24 50       	            tbit.z p8,p9=r17,21
a0000001000f2290:	18 00 00 00 01 00 	[MMB]       nop.m 0x0
a0000001000f2296:	10 d9 00 80 02 00 	            chk.a.clr r17,a0000001000f2440 <dequeue_task_fair+0x280>
a0000001000f229c:	00 00 00 20       	            nop.b 0x0
a0000001000f22a0:	10 00 00 00 01 00 	[MIB]       nop.m 0x0
a0000001000f22a6:	00 00 00 02 00 04 	            nop.i 0x0
a0000001000f22ac:	e0 00 00 43       	      (p08) br.cond.dpnt.few a0000001000f2380 <dequeue_task_fair+0x1c0>
a0000001000f22b0:	0b b8 00 30 10 10 	[MMI]       ld4 r23=[r24];;
a0000001000f22b6:	b0 00 5c 14 73 00 	            cmp4.eq p11,p10=0,r23
a0000001000f22bc:	00 00 04 00       	            nop.i 0x0;;
a0000001000f22c0:	71 01 81 40 02 e1 	[MIB] (p11) adds r32=288,r32
a0000001000f22c6:	12 01 00 00 42 05 	      (p11) mov r17=r0
a0000001000f22cc:	e0 00 00 42       	      (p10) br.cond.dptk.few a0000001000f23a0 <dequeue_task_fair+0x1e0>;;
a0000001000f22d0:	09 f8 40 18 00 21 	[MMI]       adds r31=16,r12
a0000001000f22d6:	00 88 80 60 23 c0 	            st4.rel [r32]=r17
a0000001000f22dc:	00 10 1d 50       	            tbit.z p6,p7=r34,0;;
a0000001000f22e0:	10 00 44 3e 90 11 	[MIB]       st4 [r31]=r17
a0000001000f22e6:	00 00 00 02 00 03 	            nop.i 0x0
a0000001000f22ec:	a0 00 00 43       	      (p06) br.cond.dpnt.few a0000001000f2380 <dequeue_task_fair+0x1c0>
a0000001000f22f0:	09 88 e0 42 02 21 	[MMI]       adds r17=312,r33
a0000001000f22f6:	e0 80 85 04 42 40 	            adds r14=304,r33
a0000001000f22fc:	c4 0b 09 84       	            adds r34=316,r33;;
a0000001000f2300:	09 00 01 22 10 10 	[MMI]       ld4 r32=[r17]
a0000001000f2306:	00 01 88 20 20 00 	            ld4 r16=[r34]
a0000001000f230c:	00 00 04 00       	            nop.i 0x0;;
a0000001000f2310:	10 00 00 00 01 00 	[MIB]       nop.m 0x0
a0000001000f2316:	90 00 80 10 28 04 	            tbit.z p9,p8=r32,0
a0000001000f231c:	70 00 00 43       	      (p08) br.cond.dpnt.few a0000001000f2380 <dequeue_task_fair+0x1c0>
a0000001000f2320:	0b 48 01 1c b8 10 	[MMI]       ld8.acq r41=[r14];;
a0000001000f2326:	10 0a a4 5c 40 00 	            or r33=1,r41
a0000001000f232c:	00 00 04 00       	            nop.i 0x0;;
a0000001000f2330:	0b 40 85 20 05 20 	[MMI]       sub r40=r33,r16;;
a0000001000f2336:	70 4a a0 00 42 00 	            adds r39=9,r40
a0000001000f233c:	00 00 04 00       	            nop.i 0x0;;
a0000001000f2340:	0a 58 48 4e 8a f5 	[MMI]       cmp4.ltu p11,p10=18,r39;;
a0000001000f2346:	82 82 a0 22 c0 e5 	      (p11) shladd r40=r16,2,r40
a0000001000f234c:	04 62 00 84       	      (p11) adds r39=32,r12
a0000001000f2350:	62 81 70 18 00 21 	[MII] (p11) adds r16=28,r12
a0000001000f2356:	00 00 00 02 80 05 	            nop.i 0x0;;
a0000001000f235c:	45 40 75 52       	      (p11) extr.u r40=r40,2,30
a0000001000f2360:	6a 01 84 20 90 d1 	[MMI] (p11) st4 [r16]=r33;;
a0000001000f2366:	02 40 9d 20 23 00 	      (p11) st4 [r39]=r40
a0000001000f236c:	00 00 04 00       	            nop.i 0x0
*a0000001000f2370:	6a 39 01 20 18 d0 	[MMI] (p11) ld8 r39=[r16];;
a0000001000f2376:	02 38 45 70 23 00 	      (p11) st8.rel [r17]=r39
a0000001000f237c:	00 00 04 00       	            nop.i 0x0
a0000001000f2380:	00 00 00 00 01 00 	[MII]       nop.m 0x0
a0000001000f2386:	00 28 01 55 00 00 	            mov.i ar.pfs=r37
a0000001000f238c:	40 0a 00 07       	            mov b0=r36
a0000001000f2390:	19 00 00 00 01 00 	[MMB]       nop.m 0x0
a0000001000f2396:	c0 00 31 00 42 80 	            adds r12=32,r12
a0000001000f239c:	08 00 84 00       	            br.ret.sptk.many b0;;
a0000001000f23a0:	18 f0 e0 42 02 21 	[MMB]       adds r30=312,r33
a0000001000f23a6:	00 02 81 04 42 00 	            adds r32=288,r32
a0000001000f23ac:	00 00 00 20       	            nop.b 0x0
a0000001000f23b0:	09 e0 50 18 00 21 	[MMI]       adds r28=20,r12
a0000001000f23b6:	f0 81 30 00 42 c0 	            adds r31=16,r12
a0000001000f23bc:	00 10 1d 50       	            tbit.z p6,p7=r34,0;;
a0000001000f23c0:	09 e8 00 3c b8 10 	[MMI]       ld8.acq r29=[r30]
a0000001000f23c6:	10 01 80 20 20 00 	            ld4 r17=[r32]
a0000001000f23cc:	00 00 04 00       	            nop.i 0x0;;
a0000001000f23d0:	00 00 00 00 01 00 	[MII]       nop.m 0x0
a0000001000f23d6:	b0 01 76 3e 29 40 	            shr.u r27=r29,32
a0000001000f23dc:	03 e8 00 84       	            mov r26=r29
*a0000001000f23e0:	0b 00 74 38 98 11 	[MMI]       st8 [r28]=r29;;
a0000001000f23e6:	f0 e8 6c 1c 69 00 	            cmp4.ltu p15,p14=r29,r27
a0000001000f23ec:	00 00 04 00       	            nop.i 0x0;;
a0000001000f23f0:	eb d1 00 36 00 21 	[MMI] (p15) mov r26=r27;;
a0000001000f23f6:	90 09 68 5c 40 00 	            or r25=1,r26
a0000001000f23fc:	00 00 04 00       	            nop.i 0x0;;
a0000001000f2400:	02 68 44 32 8c 34 	[MII]       cmp4.ltu p13,p12=r17,r25
a0000001000f2406:	00 00 00 02 00 26 	            nop.i 0x0;;
a0000001000f240c:	12 c9 14 80       	      (p12) sub r17=r17,r25
a0000001000f2410:	a2 89 44 22 05 20 	[MII] (p13) sub r17=r17,r17
a0000001000f2416:	00 00 00 02 00 00 	            nop.i 0x0;;
a0000001000f241c:	00 00 04 00       	            nop.i 0x0
a0000001000f2420:	18 00 44 40 b0 11 	[MMB]       st4.rel [r32]=r17
a0000001000f2426:	00 88 7c 20 a3 03 	            st4 [r31]=r17
a0000001000f242c:	d0 fe ff 4a       	      (p07) br.cond.dptk.few a0000001000f22f0 <dequeue_task_fair+0x130>
a0000001000f2430:	10 00 00 00 01 00 	[MIB]       nop.m 0x0
a0000001000f2436:	00 00 00 02 00 00 	            nop.i 0x0
a0000001000f243c:	50 ff ff 48       	            br.few a0000001000f2380 <dequeue_task_fair+0x1c0>
a0000001000f2440:	09 00 00 00 01 00 	[MMI]       nop.m 0x0
a0000001000f2446:	10 01 48 20 20 00 	            ld4 r17=[r18]
a0000001000f244c:	00 00 04 00       	            nop.i 0x0;;
a0000001000f2450:	11 00 00 00 01 00 	[MIB]       nop.m 0x0
a0000001000f2456:	80 50 45 12 28 00 	            tbit.z p8,p9=r17,21
a0000001000f245c:	50 fe ff 48       	            br.few a0000001000f22a0 <dequeue_task_fair+0xe0>;;
