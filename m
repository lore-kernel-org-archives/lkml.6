Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeCOOey (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:34:54 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:50660 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752108AbeCOOex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:34:53 -0400
X-Google-Smtp-Source: AG47ELsZqC4JWP7UowjqRGDCY6wdACcRGAIJZNK0iZZAJq4Ru8SPpMPFXXD1B/5Wlu6S5HtqPAzIvQ==
Message-ID: <1521124490.2686.16.camel@arista.com>
Subject: Re: [PATCHv3] iommu/intel: Ratelimit each dmar fault printing
From: Dmitry Safonov <dima@arista.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Date: Thu, 15 Mar 2018 14:34:50 +0000
In-Reply-To: <20180315142253.GC5259@8bytes.org>
References: <20180215191729.15777-1-dima@arista.com>
         <20180315134649.skh2aukcmg5ud74y@8bytes.org>
         <1521123183.2686.7.camel@arista.com> <20180315142253.GC5259@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-15 at 15:22 +0100, Joerg Roedel wrote:
> On Thu, Mar 15, 2018 at 02:13:03PM +0000, Dmitry Safonov wrote:
> > So, you suggest to remove ratelimit at all?
> > Do we really need printk flood for each happened fault?
> > Imagine, you've hundreds of mappings and then PCI link flapped..
> > Wouldn't it be better to keep ratelimiting?
> > I don't mind, just it looks a bit strange to me.
> 
> I never said you should remove the ratelimiting, after all you are
> trying to fix a soft-lockup, no?
> 
> And that should not be fixed by changes to the ratelimiting, but with
> proper irq handling.

Uh, I'm a bit confused then.
- Isn't it better to ratelimit each printk() instead of bunch of
printks inside irq handler?
- I can limit the number of loops, but the most of the time is spent in
the loop on printk() (on my machine ~170msec per loop), while
everything else takes much lesser time (on my machine < 1 usec per
loop). So, if I will limit number of loops per-irq, that cycle-limit
will be based on limiting time spent on printk (e.g., how many printks
to do in atomic context so that node will not lockup). It smells like
ratelimiting, no?

I must be misunderstanding something, but why introducing another limit
for number of printk() called when there is ratelimit which may be
tuned..

-- 
Thanks,
             Dmitry
