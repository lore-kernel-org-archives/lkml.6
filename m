Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CB9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20137205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KXVNns5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20137205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeJQAxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:53:01 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:46190 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeJQAxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:53:01 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D115810C07CF;
        Tue, 16 Oct 2018 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1539709301; bh=iuxayycDUiz8vvVlgXzqIwVjbS7XOQBu0A3T7LwrAec=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KXVNns5CY5zo40FoH5Oig91maFWCQomiu1CNjIJyCSYZHkDAxjiqyqWkg+6GXa3mI
         L9Tahjnm4jiaW82q6v89c7/u0dbAOlZeRL7Xb/CH2cs6j3kOrg0W86MDYnMi8OtzKL
         ga6Pcp4p9fr2bbqmsWTNT5G1/DAwcuohhUEJYo5qL9t2/pEf+i53qe8vNXVvw7cvMW
         vJs6iudt2HO6tv3j04P2GWd697FO32si34la81Fxd2Yo3X9SRvOP7CaZTD+mS7cRj7
         N2BlsVqsYd/HT46+Z6r1Fo9GkTWZXO2w9kY1doXUhDPMmt9C6GU7GjVOP7DoTyb3HD
         bVOI9GXdOdlXA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id BD1F7533E;
        Tue, 16 Oct 2018 10:01:41 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 16 Oct 2018 10:01:41 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 16 Oct 2018 19:01:38 +0200
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
Thread-Topic: [PATCH] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
Thread-Index: AQHUZSQxvYC/p9gjBE6voT39JjIrB6UiCfSw
Date:   Tue, 16 Oct 2018 17:01:38 +0000
Message-ID: <4881796E12491D4BB15146FE0209CE646817407C@DE02WEMBXB.internal.synopsys.com>
References: <20181016074504.2042-1-abrodkin@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B0AE356@US01WEMBX2.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B0AE356@US01WEMBX2.internal.synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWJyb2RraW5c?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0yM2Q1ZjY0ZC1kMTY1LTExZTgtYmU5OC04OGIx?=
 =?us-ascii?Q?MTFjZGUyMTdcYW1lLXRlc3RcMjNkNWY2NGUtZDE2NS0xMWU4LWJlOTgtODhi?=
 =?us-ascii?Q?MTExY2RlMjE3Ym9keS50eHQiIHN6PSI4NTc0IiB0PSIxMzE4NDE4Mjg5NzAy?=
 =?us-ascii?Q?NDYxMTgiIGg9IlhhVEFxdnNiUS9OVitLUkpSaFlxUmRMc1E4VT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFB?=
 =?us-ascii?Q?RG1MMC9tY1dYVUFhV3dZSzR3SDNrbHBiQmdyakFmZVNVT0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBUDhQcGVnQUFBQUFBQUFBQUFBQUFBSjRBQUFCbUFHa0Fi?=
 =?us-ascii?Q?Z0JoQUc0QVl3QmxBRjhBY0FCc0FHRUFiZ0J1QUdrQWJnQm5BRjhBZHdCaEFI?=
 =?us-ascii?Q?UUFaUUJ5QUcwQVlRQnlBR3NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3Qm5BR1lBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhNQVlRQnRBSE1BZFFCdUFHY0FYd0JqQUc4QWJnQm1BQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFjd0Jo?=
 =?us-ascii?Q?QUcwQWN3QjFBRzRBWndCZkFISUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtB?=
 =?us-ascii?Q?WHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCekFHMEFhUUJqQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFi?=
 =?us-ascii?Q?Z0JsQUhJQWN3QmZBSE1BZEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1B?=
 =?us-ascii?Q?RzhBZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWRB?=
 =?us-ascii?Q?QnpBRzBBWXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFI?=
 =?us-ascii?Q?a0FYd0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0IxQUcwQVl3QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFad0IwQUhNQVh3QndBSElBYndCa0FIVUFZd0IwQUY4?=
 =?us-ascii?Q?QWRBQnlBR0VBYVFCdUFHa0FiZ0JuQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHRUFiQUJsQUhNQVh3QmhBR01BWXdCdkFIVUFiZ0IwQUY4QWNBQnNBR0VB?=
 =?us-ascii?Q?YmdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSE1BWVFCc0FHVUFjd0Jm?=
 =?us-ascii?Q?QUhFQWRRQnZBSFFBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUNlQUFBQWN3QnVBSEFBY3dCZkFHd0FhUUJqQUdVQWJnQnpB?=
 =?us-ascii?Q?R1VBWHdCMEFHVUFjZ0J0QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFB?=
 =?us-ascii?Q?QUJ6QUc0QWNBQnpBRjhBYkFCcEFHTUFaUUJ1QUhNQVpRQmZBSFFBWlFCeUFH?=
 =?us-ascii?Q?MEFYd0J6QUhRQWRRQmtBR1VBYmdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFIWUFad0JmQUdzQVpR?=
 =?us-ascii?Q?QjVBSGNBYndCeUFHUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFB?=
 =?us-ascii?Q?QUFBQUFDQUFBQUFBQT0iLz48L21ldGE+?=
x-dg-rorf: 
x-originating-ip: [10.225.15.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,

> -----Original Message-----
> From: Vineet Gupta
> Sent: Tuesday, October 16, 2018 7:03 PM
> To: Alexey Brodkin <abrodkin@synopsys.com>; linux-kernel@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org; Daniel Lezcano <daniel.lezcano@li=
naro.org>; Thomas Gleixner <tglx@linutronix.de>
> Subject: Re: [PATCH] clocksource/drivers/arc_timer: Utilize generic sched=
_clock
>=20
> On 10/16/2018 12:45 AM, Alexey Brodkin wrote:
> > It turned out we used to use default implementation of sched_clock()
> > from kernel/sched/clock.c which was as precise as 1/HZ, i.e.
> > by default we had 10 msec granularity of time measurement.
> >
> > Now given ARC built-in timers are clocked with the same frequency as
> > CPU cores we may get much higher precision of time tracking.
>=20
> Can you do LMBench runs with and w/o and see if there's any other changes=
. I'm
> hoping lat_ctx will be more consistent.

Sure, I have this, see below:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
             L M B E N C H  3 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
---------------------------------------------------------------------------=
-----------
        Host                 OS Description                             Mhz=
  tlb  cache  mem   scal
                                                                           =
  pages line   par   load
                                                                           =
        bytes
----------------- ------------- --------------------------------------- ---=
- ----- ----- ------ ----
hz-2018.10.16.log Linux 4.18.14 hz-2018.10.16.log                        99=
8     8   128 1.7500    1
sched_clock-2018. Linux 4.18.14 sched_clock-2018.10.16.log               99=
7     8       1.7500    1

Processor, Processes - times in microseconds - smaller is better
---------------------------------------------------------------------------=
---
Host                 OS  Mhz null null      open slct sig  sig  fork exec s=
h =20
                             call  I/O stat clos TCP  inst hndl proc proc p=
roc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- -=
---
hz-2018.1 Linux 4.18.14  998 0.38 0.59 2.76 5.02 22.4 0.54 2.23 319. 1780 3=
347
sched_clo Linux 4.18.14  997 0.38 0.61 2.66 5.01 22.3 0.54 2.25 325. 1775 3=
315

Basic integer operations - times in nanoseconds - smaller is better
-------------------------------------------------------------------
Host                 OS  intgr intgr  intgr  intgr  intgr =20
                          bit   add    mul    div    mod  =20
--------- ------------- ------ ------ ------ ------ ------=20
hz-2018.1 Linux 4.18.14 1.0100 1.1500          13.0 7.9900
sched_clo Linux 4.18.14 1.0100 1.1500          13.0 7.9900

Basic uint64 operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS int64  int64  int64  int64  int64 =20
                         bit    add    mul    div    mod  =20
--------- ------------- ------ ------ ------ ------ ------=20
hz-2018.1 Linux 4.18.14    11.          10.2  126.2   96.5
sched_clo Linux 4.18.14    11.          10.2  126.2   96.6

Basic float operations - times in nanoseconds - smaller is better
-----------------------------------------------------------------
Host                 OS  float  float  float  float
                         add    mul    div    bogo
--------- ------------- ------ ------ ------ ------=20
hz-2018.1 Linux 4.18.14  184.5  181.5  375.0  935.3
sched_clo Linux 4.18.14  185.1  185.7  375.0  882.9

Basic double operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS  double double double double
                         add    mul    div    bogo
--------- ------------- ------  ------ ------ ------=20
hz-2018.1 Linux 4.18.14  253.9  285.6 1490.0 2264.3
sched_clo Linux 4.18.14  255.0  283.6 1515.0 2284.3

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
hz-2018.1 Linux 4.18.14 3.4400 6.7700 0.7300 9.6300   68.1    15.3   115.0
sched_clo Linux 4.18.14 3.5100 7.1300 5.7900 7.9200   71.8    17.6   124.5

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
hz-2018.1 Linux 4.18.14 3.440  14.6 16.0  31.5        48.0        94.
sched_clo Linux 4.18.14 3.510  15.5 13.4  31.5        49.4       158.

*Remote* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS   UDP  RPC/  TCP   RPC/ TCP
                               UDP         TCP  conn
--------- ------------- ----- ----- ----- ----- ----
hz-2018.1 Linux 4.18.14                            =20
sched_clo Linux 4.18.14                            =20

File & VM system latencies in microseconds - smaller is better
---------------------------------------------------------------------------=
----
Host                 OS   0K File      10K File     Mmap    Prot   Page   1=
00fd
                        Create Delete Create Delete Latency Fault  Fault  s=
elct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -=
----
hz-2018.1 Linux 4.18.14   11.0 7.8438   54.3   12.8   221.0 0.475 1.16420 8=
.607
sched_clo Linux 4.18.14   10.8 7.7240   54.1   12.9   223.0 0.505 1.16280 8=
.475

*Local* Communication bandwidths in MB/s - bigger is better
---------------------------------------------------------------------------=
--
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Me=
m
                             UNIX      reread reread (libc) (hand) read wri=
te
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- ---=
--
hz-2018.1 Linux 4.18.14 224. 456. 111.  248.0  404.8  384.6  232.4 405. 454=
.4
sched_clo Linux 4.18.14 220. 458. 145.  241.6  404.6  384.3  232.3 404. 453=
.9

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------------------------------=
---
Host                 OS   Mhz   L1 $   L2 $    Main mem    Rand mem    Gues=
ses
--------- -------------   ---   ----   ----    --------    --------    ----=
---
hz-2018.1 Linux 4.18.14   998 3.0820   24.3       210.5       371.0
sched_clo Linux 4.18.14   997 3.0820   24.3       210.6       371.2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index dec0dd88ec15..3268dad4effe 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -290,6 +290,7 @@ config CLKSRC_MPS2
> >
> >  config ARC_TIMERS
> >  	bool "Support for 32-bit TIMERn counters in ARC Cores" if COMPILE_TES=
T
> > +	depends on GENERIC_SCHED_CLOCK
>=20
> It needs to select, not depends on

Well from what I may see git grepping:
 1) Architcture selects GENERIC_SCHED_CLOCK
 2) Clocksource driver depends on GENERIC_SCHED_CLOCK

> > @@ -88,6 +89,11 @@ static u64 arc_read_gfrc(struct clocksource *cs)
> >  	return (((u64)h) << 32) | l;
> >  }
> >
> > +static u64 arc_gfrc_clock_read(void)
>=20
> Needs to be notrace like other such routines.

Ok will add this.

> >
> > +
> >  static struct clocksource arc_counter_timer1 =3D {
> >  	.name   =3D "ARC Timer1",
> >  	.rating =3D 300,
> > @@ -209,6 +229,8 @@ static int __init arc_cs_setup_timer1(struct device=
_node *node)
> >  	write_aux_reg(ARC_REG_TIMER1_CNT, 0);
> >  	write_aux_reg(ARC_REG_TIMER1_CTRL, TIMER_CTRL_NH);
> >
> > +	sched_clock_register(arc_timer1_clock_read, 64, arc_timer_freq);
>=20
> TIMER1 is 32 bits wide.

Yep , blind copy-pasting is not good, will change it.

-Alexey=20
