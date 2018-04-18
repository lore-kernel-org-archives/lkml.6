Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753644AbeDRINU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:13:20 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:55647 "EHLO
        prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeDRINQ (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 18 Apr 2018 04:13:16 -0400
Message-ID: <1524039174.3028.24.camel@suse.com>
Subject: Re: [PATCH v3 1/6] ilog2: create truly constant version for sparse
From: Martin Wilck <mwilck@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Apr 2018 10:12:54 +0200
In-Reply-To: <CA+55aFxLY2=RVAD8m-3bf4vKWpPKWSmjN_tLVWwb4Y7w81UTbA@mail.gmail.com>
References: <20180417233511.6573-1-mwilck@suse.com>
         <20180417233511.6573-2-mwilck@suse.com>
         <CA+55aFxLY2=RVAD8m-3bf4vKWpPKWSmjN_tLVWwb4Y7w81UTbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-17 at 17:07 -0700, Linus Torvalds wrote:
> On Tue, Apr 17, 2018 at 4:35 PM, Martin Wilck <mwilck@suse.com>
> wrote:
> > Sparse emits errors about ilog2() in array indices because of the
> > use of
> > __ilog2_32() and __ilog2_64(),
> 
> If sparse warns about it, then presumably gcc with -Wvla warns about
> it too?

No, it doesn't (gcc 7.3.0). -> https://paste.opensuse.org/27471594
It doesn't even warn on an expression like this:

  #define SIZE (1<<10)
  static int foo[ilog2(SIZE)];

sparse 0.5.2 doesn't warn about that either. It emits "error: bad
integer constant expression" only if ilog2 is used in an array
initializer, like this:

  #define SIZE (1<<10)
  #define SUBS (1<<5)
  static int foo [ilog2(SIZE)] = {
          [ilog2(SUBS)] = 0,
  };

So maybe I was wrong, and this is actually a false positive in sparse.

> So I suspect that what you'd want is
> 
>   #define ilog2(n) \
>         __builtin_choose_expr(__is_constexpr(n), \
>                 const_ilog2(n), \
>                 __builtin_choose_expr(sizeof(n) <= 4, \
>                         __ilog2_u32(n), \
>                         __ilog2_u64(n)))
> 
> or something. Hmm?

Do you want me to convert the patch to your approach anyway?
Or should I throw this away and report to sparse?

Regards and thanks,
Martin

PS: apologies to all recipients for the broken cc list in my post.
-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
