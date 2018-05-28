Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbeE1EjW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 00:39:22 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33481 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752091AbeE1EjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 00:39:18 -0400
X-ME-Proxy: <xmx:9YcLW8TYjb8OZVz4TbeGaFo0vcxYo3If4f_J7uLjraMkmSF2b8ae9g>
X-ME-Proxy: <xmx:9YcLWwOFn9bKDImJtcjkC3AAgafK7o1F7wSsJ1iccWASKhzvlTKPzg>
X-ME-Proxy: <xmx:9YcLW3UIP7ZF8jGKe8OvCh2n45q7gTGvUIIVMXsK2o00Nc-7MMO7gA>
X-ME-Proxy: <xmx:9YcLW4bFBfvI9RVxAN_Sz0LYXlBvkapwYfGlFv_AUaHXPhoBUY4TeQ>
X-ME-Proxy: <xmx:9YcLW0svRfqBH4BH7fL5WJfTDMjumz9az-7iPdHBPn_UEGtGC8Wd0A>
X-ME-Proxy: <xmx:9YcLW1XmZakbUVOR-L-4ozrQoXeheeq-WHcLK0lG_7KihnF99KXAtQ>
X-ME-Sender: <xms:9YcLW5fqoWTnNNimlu9GyX9CRbOUbaBvLSXJym-jw6f6XJfiRjuu7g>
Message-ID: <1527482351.2693.12.camel@themaw.net>
Subject: Re: [PATCH] mm-kasan-dont-vfree-nonexistent-vm_area-fix
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>
Date: Mon, 28 May 2018 12:39:11 +0800
In-Reply-To: <1527480795.2693.4.camel@themaw.net>
References: <dabee6ab-3a7a-51cd-3b86-5468718e0390@virtuozzo.com>
         <201805261122.HdUpobQm%fengguang.wu@intel.com>
         <20180525204804.3a655370ef4b41e0d96e03f3@linux-foundation.org>
         <1527480795.2693.4.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 12:13 +0800, Ian Kent wrote:
> On Fri, 2018-05-25 at 20:48 -0700, Andrew Morton wrote:
> > On Sat, 26 May 2018 11:31:35 +0800 kbuild test robot <lkp@intel.com> wrote:
> > 
> > > Hi Andrey,
> > > 
> > > I love your patch! Yet something to improve:
> > > 
> > > [auto build test ERROR on mmotm/master]
> > > [cannot apply to v4.17-rc6]
> > > [if your patch is applied to the wrong git tree, please drop us a note to
> > > help improve the system]
> > > 
> > > url:    https://github.com/0day-ci/linux/commits/Andrey-Ryabinin/mm-kasan-
> > > do
> > > nt-vfree-nonexistent-vm_area-fix/20180526-093255
> > > base:   git://git.cmpxchg.org/linux-mmotm.git master
> > > config: sparc-allyesconfig (attached as .config)
> > > compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin
> > > /m
> > > ake.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # save the attached .config to linux build tree
> > >         make.cross ARCH=sparc 
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    fs/autofs/inode.o: In function `autofs_new_ino':
> > >    inode.c:(.text+0x220): multiple definition of `autofs_new_ino'
> > >    fs/autofs/inode.o:inode.c:(.text+0x220): first defined here
> > >    fs/autofs/inode.o: In function `autofs_clean_ino':
> > >    inode.c:(.text+0x280): multiple definition of `autofs_clean_ino'
> > >    fs/autofs/inode.o:inode.c:(.text+0x280): first defined here
> > 
> > There's bot breakage here - clearly that patch didn't cause this error.
> > 
> > Ian, this autofs glitch may still not be fixed.
> 
> Yes, autofs-make-autofs4-Kconfig-depend-on-AUTOFS_FS.patch should have
> fixed that.
> 
> I tied a bunch of .config combinations and I was unable to find any that
> lead to both CONFIG_AUTOFS_FS and CONFIG_AUTOFS4_FS being defined.

Oh, autofs-make-autofs4-Kconfig-depend-on-AUTOFS_FS.patch was sent as
a follow up patch which means it's still possible to have both
CONFIG_AUTOFS_FS and CONFIG_AUTOFS4_FS set between 
autofs-create-autofs-Kconfig-and-Makefile.patch and the above patch.

Perhaps all that's needed is to fold the follow up patch into
autofs-create-autofs-Kconfig-and-Makefile.patch to close that
possibility.

I'll check that can be done without problem.

> 
> I must be missing something else, I'll investigate.

And I'll check if there's anything else I'm missing.

Sorry for the inconvenience.

> 
> Ian
