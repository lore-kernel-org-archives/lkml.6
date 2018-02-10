Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbeBJSE2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 13:04:28 -0500
Received: from smtprelay0091.hostedemail.com ([216.40.44.91]:52060 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751087AbeBJSE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 13:04:27 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:2895:2915:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3873:3874:4321:4605:5007:6691:7904:8660:10004:10400:10848:11232:11658:11914:12294:12295:12296:12740:12760:12895:13069:13148:13161:13229:13230:13311:13357:13439:14096:14097:14659:14721:21080:21611:21627:30054:30060:30069:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: neck24_7defc40f7e725
X-Filterd-Recvd-Size: 1976
Message-ID: <1518285863.16865.17.camel@perches.com>
Subject: Re: [PATCH] seq_file: remove redundant assignment of index to
 m->index
From: Joe Perches <joe@perches.com>
To: Donglin Peng <dolinux.peng@gmail.com>, viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sat, 10 Feb 2018 10:04:23 -0800
In-Reply-To: <CAErzpmu5o+tLJyY9GqkFEOn=KSs0q9pevCBWcvzpxDyV9RiC_Q@mail.gmail.com>
References: <CAErzpmu5o+tLJyY9GqkFEOn=KSs0q9pevCBWcvzpxDyV9RiC_Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-02-10 at 23:59 +0800, Donglin Peng wrote:
> There are two redundant assignments in the traverse() function, because
> the while loop will break after these two assignments, and after that
> the variable index will be assigned to m->index again.
[]
> diff --git a/fs/seq_file.c b/fs/seq_file.c
[]
> @@ -120,14 +120,12 @@ static int traverse(struct seq_file *m, loff_t offset)
>          if (pos + m->count > offset) {
>              m->from = offset - pos;
>              m->count -= m->from;
> -            m->index = index;
>              break;
>          }
>          pos += m->count;
>          m->count = 0;
>          if (pos == offset) {
>              index++;
> -            m->index = index;
>              break;
>          }
>          p = m->op->next(m, p, &index);

Of course this looks correct, but how
are you _absolutely sure_ about this?

Perhaps the m->op->stop(m, p) call below
the break, which takes m as an argument,
needs an updated m->index.

Unless you can verify _all_ the indirect
paths that stop() can take, this patch may
not be correct.
