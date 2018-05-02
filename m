Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeEBACH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 20:02:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36708 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbeEBACF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 20:02:05 -0400
Date: Tue, 1 May 2018 17:02:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: David Rientjes <rientjes@google.com>,
        "Joel Fernandes (Google)" <joel.opensrc@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rdunlap@infradead.org
Subject: Re: [PATCH] proc/stat: Separate out individual irq counts into
 /proc/stat_irqs
Message-Id: <20180501170203.d2b0a99acf0b5288476a11a7@linux-foundation.org>
In-Reply-To: <20180424061859.GA16181@avx2>
References: <20180419190846.GE2066@avx2>
        <1c3b9cf3-3a36-568f-3da2-e560a721f4aa@redhat.com>
        <20180419195504.GA4343@avx2>
        <eb7c1569-e445-5cbb-6d10-2694b625232a@redhat.com>
        <20180419203949.GA4555@avx2>
        <c0530769-50c3-87ad-1558-164873482130@redhat.com>
        <CAEi0qNn9KbTtUxLvFKvq958BhG9KrpY=S-89T5HJBebO9Da4zw@mail.gmail.com>
        <20180421203422.GA14396@avx2>
        <20180421203604.GB14396@avx2>
        <alpine.DEB.2.21.1804232249380.82340@chino.kir.corp.google.com>
        <20180424061859.GA16181@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018 09:18:59 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Mon, Apr 23, 2018 at 10:54:18PM -0700, David Rientjes wrote:
> > On Sat, 21 Apr 2018, Alexey Dobriyan wrote:
> > 
> > > > On Thu, Apr 19, 2018 at 04:23:02PM -0700, Joel Fernandes (Google) wrote:
> > > > > Can we not just remove per-IRQ stats from /proc/stat (since I gather
> > > > > from this discussion it isn't scalable), and just have applications
> > > > > that need per-IRQ stats use /proc/interrupts ?
> > > > 
> > > > If you can prove noone is using them in /proc/stat...
> > > 
> > > And you can't even stick WARN into /proc/stat to find out.
> > > 
> > 
> > FWIW, removing per irq counts from /proc/stat would break some of our
> > scripts.  We could adapt to that, but everybody else would have to as
> > well, so I'm afraid it's not going to be possible.
> 
> Excellent!
> 
> > It would probably be better to extract out the stats that you're actually
> > interested in to a new file.
> 
> This is the worst scenario. Individual IRQ stats are going to live in 2 places.
> And /proc/stat still would be slow.

No, a new /proc/stat2 which omits the `intr' line would be fast(er). 
Although if we're going to do such a thing we might choose to
reorganize and prune /proc/stat2 even further, and actually put some
thought into it - the current one is a bit of a dog's breakfast.

Dumb question(s):

a) if we moved the `intr' line to the very end of /proc/stat, would
   anything break?  Maybe.

b) if an application were then to read stuff from /proc/stat and
   were to stop reading before it read the `intr' line, would
   its read from /proc/stat still be slow?

c) if the answer to b) is "yes" then can we change that?  Only go
   off and prepare the `intr' line if the application is really truly
   reading it in?
