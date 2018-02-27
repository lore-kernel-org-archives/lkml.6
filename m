Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeB0RpV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:45:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751554AbeB0RpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:45:19 -0500
Date: Tue, 27 Feb 2018 11:45:18 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Robin Jarry <robin.jarry@6wind.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] kbuild: fix host progs build with libs in non
 standard locations
Message-ID: <20180227174518.qzw6eqmuyggcvjl6@treble>
References: <cover.1519393674.git.robin.jarry@6wind.com>
 <cover.1519668832.git.robin.jarry@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1519668832.git.robin.jarry@6wind.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 07:41:45PM +0100, Robin Jarry wrote:
> This patchset allows to build host programs that depend on external libs
> installed in non standard locations (i.e. not in /usr/include, /usr/lib,
> etc.).  For now, the only way is to force HOSTCC to include both the
> path to the host compiler and the build flags.
> 
> I have encountered this issue when building linux into the buildroot
> framework. host-* versions of libs may be compiled and installed in a
> host staging dir removing the need to install them on the build system.
> 
> I'm not really satisfied with the new HOST_{C,LD}FLAGS variables.  They
> are too similar to HOST{C,LD}FLAGS and I find them confusing.  However,
> HOST_EXTRA*FLAGS are already reserved for local use in makefiles (see
> Documentation/kbuild/makefiles.txt).  And I didn't want to have even
> longer USER_HOST_*FLAGS.  If someone has a better proposition, I'll
> happily make a v3.

In Documentation/kbuild/kbuild.txt, we have the following environment
variables:

  KCFLAGS
  --------------------------------------------------
  Additional options to the C compiler (for built-in and modules).
  
  CFLAGS_KERNEL
  --------------------------------------------------
  Additional options for $(CC) when used to compile
  code that is compiled as built-in.
  
  CFLAGS_MODULE
  --------------------------------------------------
  Additional module specific options to use for $(CC).
  
  LDFLAGS_MODULE
  --------------------------------------------------
  Additional options used for $(LD) when linking modules.
  
  LDFLAGS_vmlinux
  --------------------------------------------------
  Additional options passed to final link of vmlinux.

So instead of

  HOST_CFLAGS
  HOST_LDFLAGS

maybe it would be more consistent to call them

  CFLAGS_HOST
  LDFLAGS_HOST

?

Also, the new environment variables should be documented in the above
file.

-- 
Josh
