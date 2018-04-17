Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753693AbeDQQBV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:01:21 -0400
Received: from mout.gmx.net ([212.227.17.22]:57507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753596AbeDQQBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:01:16 -0400
Message-ID: <1523980839.7093.1.camel@gmx.de>
Subject: Re: 4.17.0-rc1 doesn't boot.
From: Mike Galbraith <efault@gmx.de>
To: Borislav Petkov <bp@alien8.de>,
        =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 17 Apr 2018 18:00:39 +0200
In-Reply-To: <20180417153101.GB2894@pd.tnic>
References: <CADDKRnAp1EKCAosD-kLNRaJ4qJppUtmmP1n76wzcvNUVa0fQzg@mail.gmail.com>
         <20180417081458.GA2894@pd.tnic>
         <CADDKRnDmycResXxAsfYfM6sFoWffD_v_cMoR4XF7OxUps3mU+Q@mail.gmail.com>
         <20180417142715.GL18640@pd.tnic>
         <CADDKRnBtQKz5S3EdJbrVH8PN9_qTrSQ3owcK=PfxToHdxpu8rA@mail.gmail.com>
         <20180417153101.GB2894@pd.tnic>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Uzw7xQvRawY1E5QJbuV9WMqB8qi4/USNz7aoWCkwNJYaNbRx3FS
 l7kIwlOgFw+ZSHHCDebfCb4PrXFfime86SzDDdwdCxV8abxkdMWgjBnKcPJ1ZToe0WkAjGp
 zraM5dm9o673zNtIQn8Jw+wThPdri3BUVzEGWdh9ok8iCREOiv9FI9ggzRdht7hnvpoghOs
 OYgM4O/GHszn8BZ5+FyOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6T30hPawJFg=:3SLFQ81wSfsPZ4/VQsMJbm
 S+NISmrkJTLUh4aqthRR0xF5WxXacwdwwyFDAjrQNgIu2d+dKGx213jlpMC4cebgl4Ve/XQEt
 ncOOLGDEe8AA5sGgJRbQxp0OSoysfcZXyXsvsDZup0qO3+KBQKevOtky88dSZQJd59z6hjxUt
 VgyD3AedDIcGZQRw2+WTHIfFtZE1tvRJJ301G66QGgKJ6apf/s9y7DjpD9pfOH1lGx0U7O7hg
 q9nl7eIZA22/DJM/L+DFV3ThxAb6ECPJn7mKchvUdrVRHdfHh0Eqg2CxIK/syxCEeSTckaDfD
 HqkNfY+Xtx1KkuXccU6KFNgfDmth91YBrKN+nklzUHcPyRInS66C6c+PGTdrdMosgTvvktGmz
 u6AAGNUXHtB3COleyqKEKI6jrO8pDZ6jPv8NZ9Z/vk28VVouNguHL3mkzQsBh0BMF2MaHdWYa
 8OIRGAeCaAoKL2XwLQZqAholH4yH2VVe0F2ZpyZiYsr4qymBHx4yNANk9h1owfOejOSVsjgiY
 NTO8Hiw8R50FLvam26jxbMlCSFxCt1NOhHwjpjHkwt7rULoIxFCFCHG5Lj6n728UEYNVKS5QZ
 cf0qlj+haNgIzvbQ+WPPHQ93dBGvAo3uEp37Tdc8SLT8aWyMTLNCjvi22BomkIVtutAFtKO2t
 MHned2WczybjKKt15sQ9ZtWftp+eLPOHQ0OTylYfnJzDHJRfku4goD3192o0VBUlp17QZ+ONc
 5YeowsZNaP90m38GaPNdKp0fL8o1JbGzonoquKJPBcxwQcZb/SdrIqYK7aAf2PJ37JL9ktqH6
 /f8uEzqsHk/7wSxJxNns+R0wq6E3HJmawk/pmFTDWsqTTkQpqk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-17 at 17:31 +0200, Borislav Petkov wrote:
> On Tue, Apr 17, 2018 at 05:21:30PM +0200, Jörg Otte wrote:
> > finished bisection.
> > 39114b7a743e6759bab4d96b7d9651d44d17e3f9 is the first bad commit
> > (x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image).
> 
> Looks like you're not the only one:
> 
> http://marc.info/?i=20180417150130.GA11166@ak-laptop.emea.nsn-net.net

I'm hitting this too, but only with PREEMPT_RT.  I put a bandaid on it
(tell pti_kernel_image_global_ok() to return true for PREEMPT_RT) while
waiting to see if it was really really as non-rt as it appeared to be.

	-Mike
