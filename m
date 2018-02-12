Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932836AbeBLX47 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 18:56:59 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:47049 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932735AbeBLX46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 18:56:58 -0500
X-Google-Smtp-Source: AH8x224Cg9wwJlNAd+hrf7quN2M9rysa3hjoXDbLgWOwXxKb8gXavQXPyQP3A3cXbisFEo6qd89oSA==
Date: Mon, 12 Feb 2018 15:56:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Alice Michael <alice.michael@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Shannon Nelson <shannon.nelson@oracle.com>
Subject: Re: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
Message-ID: <20180212235655.GC5199@roeck-us.net>
References: <1518475021-3337-1-git-send-email-linux@roeck-us.net>
 <20180212234201.GB4290@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212234201.GB4290@saruman>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 11:42:02PM +0000, James Hogan wrote:
> Hi Guenter,
> 
> On Mon, Feb 12, 2018 at 02:37:01PM -0800, Guenter Roeck wrote:
> > Since commit 60f481b970386 ("i40e: change flags to use 64 bits"),
> > the i40e driver uses cmpxchg64(). This causes mips:allmodconfig builds
> > to fail with
> > 
> > drivers/net/ethernet/intel/i40e/i40e_ethtool.c:
> > 	In function 'i40e_set_priv_flags':
> > drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4443:2: error:
> > 	implicit declaration of function 'cmpxchg64'
> > 
> > Implement a poor-mans-version of cmpxchg64() to fix the problem for 32-bit
> > mips builds. The code is derived from sparc32, but only uses a single
> > spinlock.
> 
> Will this be implemened for all 32-bit architectures which are currently
> missing cmpxchg64()?
> 
No idea.

> If so, any particular reason not to do it in generic code?
> 
Again, no idea. When the problem was previously seen on sparc32,
it was implemented there.

> If not then I think that driver should be fixed to either depend on some
> appropriate Kconfig symbol or to not use this API since it clearly isn't
> portable at the moment.
> 
Good point.

> See also Shannon's comment about that specific driver:
> https://lkml.kernel.org/r/e7c934d7-e5f4-ee1b-0647-c31a98d9e944@oracle.com
> 

Well, this was an RFC only. Feel free to ignore it.

FWIW, this is the second time that the call was introduced in the i40 driver.
After the first time the code was rewritten to avoid the problem, but now it
came back. Someone must really like it ;-). For my part, I may just blacklist
the offending driver in my builds; that is less than perfect, but much easier
than having to deal with the same problem over and over again. Guess I'll wait
for a while and do just that if the problem isn't fixed in a later RC.

Guenter
