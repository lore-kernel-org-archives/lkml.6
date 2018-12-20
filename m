Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CFCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582BD218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OEZjdgq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389399AbeLTSnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:43:10 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:38350 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389371AbeLTSnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:43:10 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B8C2510C0E00;
        Thu, 20 Dec 2018 10:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545331389; bh=jpwKVNQoclFo4m+mrr0h3pd+OLd0bO1Ut7VNurR2fgo=;
        h=From:To:CC:Subject:Date:References:From;
        b=OEZjdgq47MPtTO8OuNCoFfEnaEtaOqaPVXtZDW9tt1PDDug9X8W+as+qFfdseTOHq
         uzoU5F1sonPNuxkUil6DaAHvha9h2tcNd6YbqdobdTXaxb6URElibyafOTfg/e8yFI
         jwWHdAposeJXOs1owZFWLBaXTP2wRZIClHe4o+eKlMipdx+QRtT0TL2G9+HZ2AIR2w
         TonZZfD0JZYy+NMgvIbpLl1kRD/Hhu3VP4xS9mw6DJ369YVy9mkohBZYhUKy9Az+Uz
         TS0pG2FeHTmzroXIsoofvtAn/s4rt5sxHJidn/23YMrTa7zPLzSbNw/ORAlEJjtdn1
         9my9XpbfL8qIA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id A5E9C5B81;
        Thu, 20 Dec 2018 10:43:09 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 20 Dec 2018 10:43:09 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/2] ARC: show_regs: avoid page allocator
Thread-Topic: [PATCH 1/2] ARC: show_regs: avoid page allocator
Thread-Index: AQHUlwMR8PfsxZ55lUuwqgC40oqmmA==
Date:   Thu, 20 Dec 2018 18:43:08 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642388B@US01WEMBX2.internal.synopsys.com>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-2-git-send-email-vgupta@synopsys.com>
 <1545239047.14089.13.camel@synopsys.com>
 <49f9edc9-87ee-1efc-58f8-b0d9a52c8a49@synopsys.com>
 <e2d2c160-0ef6-5504-7824-032a5c70fa7f@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 5:30 AM, Tetsuo Handa wrote:=0A=
>> | Stack Trace:=0A=
>> |  arc_unwind_core+0xcc/0x100=0A=
>> |  ___might_sleep+0x17a/0x190=0A=
>> |  mmput+0x16/0xb8=0A=
> Then, does mmput_async() help?=0A=
>=0A=
=0A=
It helps, but then we get the next one (w/o my patch 2/2)=0A=
=0A=
BUG: sleeping function called from invalid context at kernel/locking/rwsem.=
c:23=0A=
in_atomic(): 1, irqs_disabled(): 0, pid: 69, name: segv-null-ptr=0A=
no locks held by segv-null-ptr/69.=0A=
CPU: 0 PID: 69 Comm: segv-null-ptr Not tainted 4.18.0+ #72=0A=
=0A=
Stack Trace:=0A=
  arc_unwind_core+0xcc/0x100=0A=
  ___might_sleep+0x17a/0x190=0A=
  down_read+0x18/0x38=0A=
  show_regs+0x102/0x310=0A=
  get_signal+0x5ee/0x610=0A=
  do_signal+0x2c/0x218=0A=
  resume_user_mode_begin+0x90/0xd8=0A=
    @off 0x103d4 in [/segv-null-pt=0A=
