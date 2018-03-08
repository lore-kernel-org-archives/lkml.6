Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751070AbeCHXTl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:19:41 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34139 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbeCHXTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:19:40 -0500
X-Google-Smtp-Source: AG47ELtZjkLxm71AEwVoXhizK6dBJSbPBFLUdMNDkRUnvEdR9Bu0Yc8NYDLuAqa8nmNAu9RbSzqIIA==
Subject: a Heisenbug tale (was: Re: arm crypto .S_shipped files sometimes get
 rebuilt randomly)
To: Leonard Crestez <leonard.crestez@nxp.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1520450729.13685.19.camel@nxp.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <c4b2ac3a-9f6f-9985-c7a3-f758c13e7b73@rasmusvillemoes.dk>
Date: Fri, 9 Mar 2018 00:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520450729.13685.19.camel@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-07 20:25, Leonard Crestez wrote:
> Hello,
> 
> I am using a toolchain with a broken/old version of perl which doesn't
> include integer.pm and I noticed it triggers occasional build failures
> on arch/arm64/crypto/sha512-core.S_shipped. Workarounds are easy, but
> if the purpose of the .S_shipped is to avoid the need to have all
> dependencies on the build machine then something went wrong?

About a year ago, I debugged a very similar problem for a customer. The
build system (an OpenEmbedded clone) did something like

(1) git clone -n ...
(2) git checkout -q $somerev
(3) make foo_config
(4) make vmlinux
(5) make LOADADDR=0x1234 uImage
(6) make modules
...

The symptoms, when the bug appeared, was that the kernel was built with
some version string "4.5.6-01234-g0abcdef", but the modules (both the
native kernel modules and those built externally using the linux-dev
package) ended up in /lib/modules/4.5.6-01234-g0abcdef-dirty.

Now, the truly annoying thing about this bug was that when I did the
above steps manually, but did a "git status" in-between steps 4 and 5 to
see where the -dirty might come from, I could _never_ reproduce the bug
(and git status always reported that the tree was clean), while it
usually happened at least 1 in 20 CI builds. Of course, I didn't realize
right away that "git status" was hiding the bug, but without that, I
could reproduce about as often as the CI, while 100 builds with that
extra step never reproduced. With that as a hint, I found
http://git.661346.n2.nabble.com/BUG-in-git-diff-index-td7652105.html#a7652109,
and slowly began to realize what might be happening.

The thing is, the setlocalversion script doesn't use "git status" to
decide whether to append -dirty, but rather the plumbing command "git
diff-index". During the "make vmlinux", the tree is obviously clean, so
we get the 4.5.6-01234-g0abcdef string baked into vmlinux. In some
cases, the two files

arch/arm/crypto/aesbs-core.S_shipped
arch/arm/crypto/bsaes-armv7.pl

ended up with different timestamps (the latter being newest) after the
git checkout, so during that same "make vmlinux", the S_shipped file
would be regenerated using the perl script. Since it is updated with ">"
shell redirection, the dev and ino stays the same, so does the content,
but the mtime is obviously updated.

If we then go on to do a "make LOADADDR=0x1234 uImage", the kernel build
system again calls setlocalversion, and this time "git diff-index
--name-only HEAD" actually produces output (namely,
arch/arm/crypto/aesbs-core.S_shipped), so include/config/kernel.release
is recreated, this time containing "4.5.6-01234-g0abcdef-dirty". The
right version string was already baked into vmlinux, so the resulting
kernel shows that for uname -r, but everything from now on, including
internal and external module builds, ends up using the -dirty string.

And this is why doing a "git status" would always hide the bug: git
diff-index only looks at the stat(2) information, and the newer mtime
was enough for it to print out arch/arm/crypto/aesbs-core.S_shipped ;
but "git status" actually opens the file and compares the contents
(which are unchanged), and then updates git's index, noting the new
stat() info for the file.

With that, I started looking at the timestamps of the above files
immediately after "git checkout". They were either identical (=no bug),
or the .pl was 4 ms (aka 1 jiffy) newer than the .S_shipped (=the bug
would appear), so that explained why the bug apparently happened at
random: if and only if a timer tick hit between git creating those two
files.

What we ended up doing was to explicitly set the mtime of every file in
the repo to the same reference time after the git checkout (find ... |
xargs touch --date=...). I also wanted to send a patch to change the
Makefile to use the filechk mechanism to avoid updating the .S_shipped
file when the script produced identical output, but never got around to it.

Rasmus
