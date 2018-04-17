Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755265AbeDQQfO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:35:14 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:49638 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754462AbeDQQfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:35:11 -0400
Date: Tue, 17 Apr 2018 09:35:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mawilcox@microsoft.com,
        asavery@chromium.org, gwendal@chromium.org
Subject: Re: Crashes/hung tasks with z3pool under memory pressure
Message-ID: <20180417163509.GA4922@roeck-us.net>
References: <20180417160032.46915216@seldlx21914.corpusers.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417160032.46915216@seldlx21914.corpusers.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 04:00:32PM +0200, Vitaly Wool wrote:
> Hi Guenter,
> 
> > [ ... ]
> > > Ugh. Could you please keep that patch and apply this on top:
> > > 
> > > diff --git a/mm/z3fold.c b/mm/z3fold.c
> > > index c0bca6153b95..e8a80d044d9e 100644
> > > --- a/mm/z3fold.c
> > > +++ b/mm/z3fold.c
> > > @@ -840,6 +840,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
> > >                       kref_get(&zhdr->refcount);
> > >                       list_del_init(&zhdr->buddy);
> > >                       zhdr->cpu = -1;
> > > +                     break;
> > >               }
> > >               list_del_init(&page->lru);
> > > 
> > Much better, in a way. The system now takes much longer to crash,
> > and the crash reason is a bit different. The log is too long to attach,
> > so I copied it to [1].
> > 
> > crashdump.0002                  Latest log
> > 000[12]-Fix-attempt-[12].patch  Patches applied on top of v4.17.0-rc1.
> 
> thanks for the update. Let's start from a clean sheet. I believe this patch has to be applied anyway so could you please check if it solves the problem. 
> 

Getting better; the log is much less noisy. Unfortunately, there are still
locking problems, resulting in a hung task. I copied the log message to [1].
This is with [2] applied on top of v4.17-rc1.

Guenter

---
[1] http://server.roeck-us.net/qemu/z3pool/crashdump.0003
[2] http://server.roeck-us.net/qemu/z3pool/0001-Fix-attempt-3.patch
