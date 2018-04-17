Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756007AbeDQQUE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755873AbeDQQUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:20:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830EC21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 17 Apr 2018 13:20:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, jeyu@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        schwidefsky@de.ibm.com, brueckner@linux.vnet.ibm.com,
        heiko.carstens@de.ibm.com, peterz@infradead.org, me@tobin.cc,
        keescook@chromium.org
Subject: Re: [PATCH] modules: Fix display of wrong module .text address
Message-ID: <20180417162000.GA7157@kernel.org>
References: <20180417082054.26978-1-tmricht@linux.ibm.com>
 <a967eb54-9c54-f9a7-f92a-0ae3d8eb60ba@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a967eb54-9c54-f9a7-f92a-0ae3d8eb60ba@de.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 17, 2018 at 10:24:35AM +0200, Christian Borntraeger escreveu:
> 
> 
> On 04/17/2018 10:20 AM, Thomas Richter wrote:
> > In kernel v4.16.0 the module .text address is displayed
> > wrong when using /sys/module/*/sections/.text file.
> > Commit ef0010a30935 ("vsprintf: don't use 'restricted_pointer()' when
> > not restricting")
> > is the first bad commit.
> > 
> > Here is the issue, using module qeth_l2 on s390 which is the
> > ethernet device driver:
> > 
> > [root@s35lp76 ~]# lsmod
> > Module                  Size  Used by
> > qeth_l2                94208  1
> > ...
> > 
> > [root@s35lp76 ~]# cat /proc/modules | egrep '^qeth_l2'
> > qeth_l2 94208 1 - Live 0x000003ff80401000
> >                        ^ This is the correct address in memory
> > [root@s35lp76 ~]# cat /sys/module/qeth_l2/sections/.text
> > 0x0000000018ea8363      <---- This is a wrong address
> > [root@s35lp76 ~]#
> > 
> > This breaks the perf tool which uses this address on s390
> > to calculate start of .text section in memory.
> > 
> > Fix this by printing the correct (unhashed) address.
> > 
> > Thanks to Jessica Yu for helping on this.
> > 
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Cc: Jessica Yu <jeyu@kernel.org>
> 
> CC stable?

Adding the missing:

Fixes: ef0010a30935 ("vsprintf: don't use 'restricted_pointer()' when not restricting")

Should be enough?

- Arnaldo
 
> > ---
> >  kernel/module.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/module.c b/kernel/module.c
> > index a6e43a5806a1..77ab7211ddef 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -1472,7 +1472,7 @@ static ssize_t module_sect_show(struct module_attribute *mattr,
> >  {
> >  	struct module_sect_attr *sattr =
> >  		container_of(mattr, struct module_sect_attr, mattr);
> > -	return sprintf(buf, "0x%pK\n", (void *)sattr->address);
> > +	return sprintf(buf, "%#lx\n", kptr_restrict < 2 ? sattr->address : 0);
> >  }
> >  
> >  static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
> > 
