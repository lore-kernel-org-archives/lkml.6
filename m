Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D5CECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55ECB214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55ECB214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeIQNee convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:34:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34524 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeIQNee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:34:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12-v6so10376725otl.1;
        Mon, 17 Sep 2018 01:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=owavJQ73XMPzBMz4Kir1uv+vaLcBQKtS8jSPJrlxbOQ=;
        b=XQxwh7dle2OjB+VJtXjn1Dg17Z7ANBkotJe4WWU02tEQqJtD0DM/Uzxz0Rz179/kiJ
         w+Bhn94XVftW5fc+esYBZxrlhEddAwONHMMaID99CI+tMjWYR7BD+gj+AGq1otA9VtGj
         Ne1eEbK+dlFg6jgcdx3m9UdssQkxEPS14oBntGNtMBu6E8hV4RREgT4Z6/SqYwAMVE0A
         gTaY4UBNgp81DQsbtU10IRP8xrWoNoBw9vMf07Du2nSMWg39d7Fsf4CyrNMTAu7v06iq
         0npqgQjgeGMZD78nFvlWbMTTZA3/gEPwbhb+gCjW4c/e8i/BkgpnkxWgf+GkAphKPStn
         CZMQ==
X-Gm-Message-State: APzg51DITkuLAj2CUt5K4wVOCM6wM/TrFyHKOYD/H+vPdpI6ikBcFmTB
        jRc3afOuMQYhcJGdKIfqkuFjHZdhcUPzUTdp/FI=
X-Google-Smtp-Source: ANB0VdYcrDfBgh0wMRjv9QOqgsttlZn08JmlxgPl9FW0mMvgRtHdSbtMcpzgnOp958DEtVScAHcO53rumyg3zep08b4=
X-Received: by 2002:a9d:7317:: with SMTP id e23-v6mr11032376otk.162.1537171696845;
 Mon, 17 Sep 2018 01:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <9611469.2z7W9akjOQ@aspire.rjw.lan> <767e9ec4-cc35-9255-360a-4d12736aa4de@nextfour.com>
 <1831106.CYv9dyYV15@aspire.rjw.lan> <e028742e-cd42-24a7-0da1-4fa12d8c9d7c@nextfour.com>
 <CAJZ5v0gRjfGDSyZXRwGgF9dOBR9OJbfYE8Dbpqdx6oCMN1XUVA@mail.gmail.com> <alpine.DEB.2.21.1809141438560.10480@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809141438560.10480@nanos.tec.linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Sep 2018 10:08:05 +0200
Message-ID: <CAJZ5v0iw99hWVY6P+uxOwZR4CkJJAbSytKuMr5Qk2-TYvzftCQ@mail.gmail.com>
Subject: Re: [PATCH] PM / suspend: Count suspend-to-idle loop as sleep time
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        mika.penttila@nextfour.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 2:41 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 14 Sep 2018, Rafael J. Wysocki wrote:
> > On Fri, Sep 14, 2018 at 11:53 AM Mika Penttilä
>
> > > >> But doesn't injecting sleep time here make monotonic clock too large
> > > >> by the amount of sleeptime?  tick_freeze() / tick_unfreeze() already
> > > >> injects the sleeptime (otherwise delta would be 0).  > > >
> > > >
> > > > No, it doesn't.
> > > >
> > > > The delta here is the extra time taken by the loop which hasn't been counted
> > > > as sleep time yet.
> > >
>
> > > I said incorrectly monotonic clock, but
> > > timekeeping_inject_sleeptime64() forwards the wall time, by the amount
> > > of delta.  Why wouldn't some other cpu update xtime when one cpu is in
> > > the loop? And if all cpus enter s2idle, tick_unfreeze() injects
> > > sleeptime. My point is that this extra injection makes wall time wrong,
> > > no?
> >
> > OK, you're right.  I got that the other way around.
> >
> > So, the patch is withdrawn.

[Sorry for the delay, personal life intervened.]

> I just tried to wrap my brain around that whole thing and utterly
> failed, so I can't give any recommendations right now.

Thanks for looking into this!

> Rafael, could you please enable some lightweight instrumentation which lets
> me see the longer sequence of events which are leading to this or tell me
> what I need to do to reproduce that myself?

I will, when I find out more.  The reported issues may just go away
after fixing some other bugs.

Cheers,
Rafael
