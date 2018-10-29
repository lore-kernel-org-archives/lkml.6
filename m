Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF9EC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2872064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2872064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbeJ2SLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:11:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33235 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbeJ2SLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:11:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id i15-v6so8379243qtr.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIbHfazCbL427uhX0bEmyj805xEbvdrUodbO/C3xOVI=;
        b=RqPIdTglozNMGVasdCwYbGdxwSCWIfsdO+svXSZFJ2jeyn6IRoiOxJQMi16Ce9GV6i
         k2P5Vonc81TI532KJjOiQ8BxsTdcpDVo6OYwKbsCiLXZJPgTkVRzMfdpKxHXg6l7jSED
         sWUwWlWTzX4PQKHny3L6UbNbuOe3h1QIsgO9Qi5dg39mw/iegtYOAzt42mcAMls4iObR
         kVZ/H2XmKqEp4BeugYFc99TFuj/kT+sgE+NKSsFSKzQiFc9pkDeZl4uepXi5T3BrdCp/
         7m5Xl1FiWNX9pd3UQVwjNXsD9oijJ4sarto/kDwV4RauXt5d+wyj4scmvsfFaTrNNMlH
         8cpA==
X-Gm-Message-State: AGRZ1gLbpto8KpOijn0bEdQdK9YYCxvn+6DhoCQk5YbfmDDUw0yvBuC+
        FygL74Yk5vO2argRf0X5DbLE4wt50wlwUldq4F0=
X-Google-Smtp-Source: AJdET5fNq1wGrJzfDmjGWxCDrJDYtxpXWAIBtnLXOhKjsxbNp2lF/hEYT4jiQqlYDLdsSizpwdwfQuJ1vUcXcNwNqI0=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr392880qvl.180.1540805003420;
 Mon, 29 Oct 2018 02:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181028230627.GA3420@andrea> <20181028231003.GA4021@andrea> <20181029012042.GR4170@linux.ibm.com>
In-Reply-To: <20181029012042.GR4170@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Oct 2018 10:23:07 +0100
Message-ID: <CAK8P3a3t54qYyj1r0vjXJzgb3wvJLt4ypb7=xesavcJwC30_kg@mail.gmail.com>
Subject: Re: [RFR] Store tearing
To:     Paul McKenney <paulmck@linux.ibm.com>
Cc:     andrea.parri@amarulasolutions.com,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 2:21 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Mon, Oct 29, 2018 at 12:10:03AM +0100, Andrea Parri wrote:
> > Hopefully, with Paul's proper email address this time,
> >
> >   Andrea
> >
> > On Mon, Oct 29, 2018 at 12:06:27AM +0100, Andrea Parri wrote:
> > > Hi,
> > >
> > > memory-barriers.txt says:
> > >
> > >   [on "store tearing"]
> > >
> > >   "In fact, a recent bug (since fixed) caused GCC to incorrectly use
> > >    this optimization in a volatile store.".
> > >
> > > I was wondering if you could help me retrieve some reference/discussions
> > > about this?
>
> This was quite some time ago, but it involved a 32-bit volatile store
> of a constant such as 0x10001.  The machine in question had a narrow
> store-immediate instruction, so the compiler emitted  a pair of 16-bit
> store-immediate instructions.  This bug was fixed, though only after
> significant screaming and shouting.

A related issue I remember was on ARMv5 (an architecture without
unaligned access) where a function like )not sure if this specific
one triggers it, but something like it did)

struct my_registers {
     u32 a;
     u32 b;
     u32 c;
} __attribute__((packed));
#define __raw_writel(p, v) do { (volatile u32 __iomem *)(p) = (v); } while (0)
void my_write_a(struct my_registers __iomem *r, u32 val)
{
       __raw_writel(&r->a, val);
}

The above is undefined behavior because we cast from an unaligned
data type to a 32-bit aligned type, and gcc resolved this by turning the
intended 32-bit store into a set of 8 bit stores. We worked around this
by changing __raw_writel() into a inline assembly that always uses a
32-bit store.

      Arnd
