Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C4AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3E72086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3E72086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeKJEmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:42:19 -0500
Received: from tartarus.angband.pl ([54.37.238.230]:51088 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbeKJEmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:42:17 -0500
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1gLC0X-000503-84; Fri, 09 Nov 2018 19:59:53 +0100
Date:   Fri, 9 Nov 2018 19:59:53 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 0/17] Kernel compression: add ZSTD, remove LZMA1 and BZIP2
Message-ID: <20181109185953.xwyelyqnygbskkxk@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
As new compressors get invented, they tend to find their way into the
kernel, yet we never prune superseded ones.  It's time to do so.

In particular, BZIP2 is drastically slower than other compressors we
have, even when they achieve smaller sizes.  It takes more memory, too.
And, BZIP2 is not used anywhere else in the kernel -- just for booting
the kernel itself and the initrd.  Thus, we can drop it from the tree
completely, making Linus happier by around 900 lines.

LZMA1 is redundant with XZ (LZMA2), and unlike the latter, it uses its own
copy of code that's not shared with anything else (some drivers use XZ).
Let's drop it as well.  Some bootloaders can use it thus let's keep the
Kconfig option, but I left no piece of code inside the kernel itself.

On the other hand, Nick Terrell has a couple of patches adding ZSTD support
(using code already in use in multiple pieces around the kernel).  ZSTD is
strong and fast, obsoleting all mid-range compressors.  As the removal of
BZIP2 and LZMA1 would be hopelessly entangled with this addition, I'm
resending Nick's patches here.  I've been booting using them since Oct'17
on amd64 (kernel+initrd), armhf and arm64 (initrd) without issues, other
folks tested various other architectures as well.

Thus, I'd recommend people to use:
* XZ for most machines
* ZSTD where speed is important
* maaaaybe LZ4 is some special cases
(grub and u-boot are ridiculously slow at reading, making fast but weak
decompressors a net loss.  On the other hand, XZ decompresses pretty fast
but is very slow at compress time, making ZSTD preferred for rapid devel
cycles.)

* we can't get rid of GZIP in foreseable future
* LZO is obsolete but is used elsewhere in the kernel

Total:
 69 files changed, 518 insertions(+), 1785 deletions(-)

Not sure whose tree this patchset should go through.  I'm also not sure
how finely split into commits you want the arch bits be; I included
defconfig bits all together, yet separated code changes per-arch.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ A dumb species has no way to open a tuna can.
⢿⡄⠘⠷⠚⠋⠀ A smart species invents a can opener.
⠈⠳⣄⠀⠀⠀⠀ A master species delegates.
