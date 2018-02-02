Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755209AbeBBSlt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:41:49 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35930 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754188AbeBBSlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:41:22 -0500
X-Google-Smtp-Source: AH8x224qIDKd2hF/0GreF9SiGGDyezEcW23vCX0es/Fum/dlJ8+jarON+014n5xkA+kuxl7g0sUuvQ==
Date: Fri, 2 Feb 2018 13:41:20 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 7/7] Kbuild: lto: pass -m32/-m64 to to LDFINAL
In-Reply-To: <20180202162104.2300532-7-arnd@arndb.de>
Message-ID: <nycvar.YSQ.7.76.1802021336090.1842@knanqh.ubzr>
References: <20180202161550.2106846-1-arnd@arndb.de> <20180202162104.2300532-7-arnd@arndb.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2018, Arnd Bergmann wrote:

> Building randconfig kernels with a biarch compiler fails with LTO
> when the final link uses a different target architecture compared
> to the earlier compilation stages.
> 
> Setting -m32 or -m64 in ${LDFINAL} solves this problem, though my
> feeling is that there is a better way to do this. There might also
> be other from KBUILD_CFLAGS that we may need in LDFINAL.

On ARM I had the same problem as it requires explicit arch flags. I 
therefore used this patch:

----- >8
Subject: [PATCH] LTO: scripts/gcc-ld: LTO on ARM needs arch specific gcc flags

Otherwise the final link where code generation happens produces code
for the wrong ISA when the default CPU configured into gcc is not the
one we need.

Also display the actual command when invoked with "make V=1".

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/scripts/gcc-ld b/scripts/gcc-ld
index d95dd0be38..fa53be2a34 100755
--- a/scripts/gcc-ld
+++ b/scripts/gcc-ld
@@ -27,4 +27,10 @@ while [ "$1" != "" ] ; do
 	shift
 done
 
-exec $CC $ARGS
+case "${KBUILD_VERBOSE}" in
+*1*)
+	set -x
+	;;
+esac
+
+exec $CC $KBUILD_CFLAGS $ARGS
