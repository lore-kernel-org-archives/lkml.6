Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeBKCUd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 21:20:33 -0500
Received: from casper.infradead.org ([85.118.1.10]:49702 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbeBKCUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 21:20:31 -0500
Date: Sat, 10 Feb 2018 17:02:01 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Joe Perches <joe@perches.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] seq_file: remove redundant assignment of index to
 m->index
Message-ID: <20180211010201.GA14719@bombadil.infradead.org>
References: <CAErzpmu5o+tLJyY9GqkFEOn=KSs0q9pevCBWcvzpxDyV9RiC_Q@mail.gmail.com>
 <1518285863.16865.17.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518285863.16865.17.camel@perches.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 10:04:23AM -0800, Joe Perches wrote:
> > @@ -120,14 +120,12 @@ static int traverse(struct seq_file *m, loff_t offset)
> >          if (pos + m->count > offset) {
> >              m->from = offset - pos;
> >              m->count -= m->from;
> > -            m->index = index;
> >              break;
> >          }
> >          pos += m->count;
> >          m->count = 0;
> >          if (pos == offset) {
> >              index++;
> > -            m->index = index;
> >              break;
> >          }
> >          p = m->op->next(m, p, &index);
> 
> Of course this looks correct, but how
> are you _absolutely sure_ about this?
> 
> Perhaps the m->op->stop(m, p) call below
> the break, which takes m as an argument,
> needs an updated m->index.

Not only that, but ->next might also look at m->index.
This is not performance critical; don't try to optimise it.

  Programmers waste enormous amounts of time thinking about, or worrying
  about, the speed of noncritical parts of their programs, and these
  attempts at efficiency actually have a strong negative impact when
  debugging and maintenance are considered. We should forget about small
  efficiencies, say about 97% of the time: premature optimization is the
  root of all evil. Yet we should not pass up our opportunities in that
  critical 3%.  -- Donald Knuth
