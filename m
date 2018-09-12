Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1786C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394D8213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2KS4r0Nb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394D8213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeIMA1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbeIMA1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:27:30 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAB4320880;
        Wed, 12 Sep 2018 19:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536780092;
        bh=jY2EEBobq68tm3k8eQHf8RJdjT0vdUUi1OLCQc1zTVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2KS4r0NbeBZQqSKNlg/Zi54/77ztZCX83IycDA7C+LapNFPC8JagRGGUd/UwEZWJK
         OnBeSicSFXP/uItZmb1zNbgNWvrlpRgdXSPeIAurWUmYwk40GuEbjUw70QJcYA0Smf
         dadx0rAA2Lsxsq31xTdoKmMXARpvRur9ne3XCj7M=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 58436140260; Wed, 12 Sep 2018 16:21:29 -0300 (-03)
Date:   Wed, 12 Sep 2018 16:21:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tools: Remove conflicting BITS_PER_LONG define
Message-ID: <20180912192129.GB13738@kernel.org>
References: <20180912170232.25258-1-alexander.sverdlin@nokia.com>
 <20180912190107.GA5502@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912190107.GA5502@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 12, 2018 at 04:01:07PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Sep 12, 2018 at 07:02:32PM +0200, Alexander Sverdlin escreveu:
> >   CC       .../tools/objtool/builtin-check.o
> >   ...
> > In file included from .../tools/arch/x86/include/uapi/asm/bitsperlong.h:11:0,
> >                  from .../tools/include/asm-generic/bitops/__ffs.h:6,
> >                  from .../tools/include/asm-generic/bitops.h:16,
> >                  from .../tools/include/linux/bitops.h:35,
> >                  from .../tools/include/linux/hashtable.h:13,
> >                  from elf.h:24,
> >                  from check.h:22,
> >                  from builtin-check.c:30:
> > .../tools/include/asm-generic/bitsperlong.h:8:0: error: "BITS_PER_LONG" redefined [-Werror]
> >  #define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
> > 
> > Include <asm/bitsperlong.h> instead as other headers do.
> 
> Please try test building all tools in tools/
> 
> This broke make -C tools/perf/

Also, where is the build of objtool failing?

[acme@jouet linux]$ git log --oneline -3
96eddb810b14 (HEAD -> master, torvalds/master) Merge tag 'riscv-for-linus-4.19-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux
aeb5427218a7 Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
5e335542de83 Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid
[acme@jouet linux]$ make -C tools/objtool/
make: Entering directory '/home/acme/git/linux/tools/objtool'
make -C /home/acme/git/linux/tools/build CFLAGS= LDFLAGS= fixdep
make[1]: Entering directory '/home/acme/git/linux/tools/build'
  HOSTCC   fixdep.o
  HOSTLD   fixdep-in.o
  LINK     fixdep
make[1]: Leaving directory '/home/acme/git/linux/tools/build'
make -C /home/acme/git/linux/tools/lib/subcmd/ OUTPUT=/home/acme/git/linux/tools/objtool/
make[1]: Entering directory '/home/acme/git/linux/tools/lib/subcmd'
make -C /home/acme/git/linux/tools/build CFLAGS= LDFLAGS= /home/acme/git/linux/tools/objtool/fixdep
  HOSTCC   /home/acme/git/linux/tools/objtool/fixdep.o
  HOSTLD   /home/acme/git/linux/tools/objtool/fixdep-in.o
  LINK     /home/acme/git/linux/tools/objtool/fixdep
  CC       /home/acme/git/linux/tools/objtool/exec-cmd.o
  CC       /home/acme/git/linux/tools/objtool/help.o
  CC       /home/acme/git/linux/tools/objtool/pager.o
  CC       /home/acme/git/linux/tools/objtool/parse-options.o
  CC       /home/acme/git/linux/tools/objtool/run-command.o
  CC       /home/acme/git/linux/tools/objtool/sigchain.o
  CC       /home/acme/git/linux/tools/objtool/subcmd-config.o
  LD       /home/acme/git/linux/tools/objtool/libsubcmd-in.o
  AR       /home/acme/git/linux/tools/objtool/libsubcmd.a
make[1]: Leaving directory '/home/acme/git/linux/tools/lib/subcmd'
make[1]: Entering directory '/home/acme/git/linux/tools/objtool'
make[2]: Entering directory '/home/acme/git/linux/tools/objtool'
  GEN      arch/x86/lib/inat-tables.c
  CC       arch/x86/decode.o
  LD       arch/x86/objtool-in.o
make[2]: Leaving directory '/home/acme/git/linux/tools/objtool'
  CC       builtin-check.o
  CC       builtin-orc.o
  CC       check.o
  CC       orc_gen.o
  CC       orc_dump.o
  CC       elf.o
  CC       special.o
  CC       objtool.o
  CC       libstring.o
  CC       str_error_r.o
  LD       objtool-in.o
make[1]: Leaving directory '/home/acme/git/linux/tools/objtool'
  LINK     objtool
make: Leaving directory '/home/acme/git/linux/tools/objtool'
[acme@jouet linux]$

Now building it without -C:

$ make -C tools/clean
[acme@jouet objtool]$ make
make -C /home/acme/git/linux/tools/build CFLAGS= LDFLAGS= fixdep
make[1]: Entering directory '/home/acme/git/linux/tools/build'
  HOSTCC   fixdep.o
  HOSTLD   fixdep-in.o
  LINK     fixdep
make[1]: Leaving directory '/home/acme/git/linux/tools/build'
make -C /home/acme/git/linux/tools/lib/subcmd/ OUTPUT=/home/acme/git/linux/tools/objtool/
make[1]: Entering directory '/home/acme/git/linux/tools/lib/subcmd'
make -C /home/acme/git/linux/tools/build CFLAGS= LDFLAGS= /home/acme/git/linux/tools/objtool/fixdep
  HOSTCC   /home/acme/git/linux/tools/objtool/fixdep.o
  HOSTLD   /home/acme/git/linux/tools/objtool/fixdep-in.o
  LINK     /home/acme/git/linux/tools/objtool/fixdep
  CC       /home/acme/git/linux/tools/objtool/exec-cmd.o
  CC       /home/acme/git/linux/tools/objtool/help.o
  CC       /home/acme/git/linux/tools/objtool/pager.o
  CC       /home/acme/git/linux/tools/objtool/parse-options.o
  CC       /home/acme/git/linux/tools/objtool/run-command.o
  CC       /home/acme/git/linux/tools/objtool/sigchain.o
  CC       /home/acme/git/linux/tools/objtool/subcmd-config.o
  LD       /home/acme/git/linux/tools/objtool/libsubcmd-in.o
  AR       /home/acme/git/linux/tools/objtool/libsubcmd.a
make[1]: Leaving directory '/home/acme/git/linux/tools/lib/subcmd'
make[1]: Entering directory '/home/acme/git/linux/tools/objtool'
make[2]: Entering directory '/home/acme/git/linux/tools/objtool'
  GEN      arch/x86/lib/inat-tables.c
  CC       arch/x86/decode.o
  LD       arch/x86/objtool-in.o
make[2]: Leaving directory '/home/acme/git/linux/tools/objtool'
  CC       builtin-check.o
  CC       builtin-orc.o
  CC       check.o
  CC       orc_gen.o
  CC       orc_dump.o
  CC       elf.o
  CC       special.o
  CC       objtool.o
  CC       libstring.o
  CC       str_error_r.o
  LD       objtool-in.o
make[1]: Leaving directory '/home/acme/git/linux/tools/objtool'
  LINK     objtool
[acme@jouet objtool]$


So where is the failure?

- Arnaldo
