Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F495C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494922089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494922089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeJBFcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:32:16 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50486 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBFcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:32:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 5177F27585;
        Mon,  1 Oct 2018 18:52:07 -0400 (EDT)
Date:   Tue, 2 Oct 2018 08:52:03 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Firoz Khan <firoz.khan@linaro.org>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v3 3/5] m68k: add system call table generation support
In-Reply-To: <1538397477-4003-4-git-send-email-firoz.khan@linaro.org>
Message-ID: <alpine.LNX.2.21.1810020843320.10@nippy.intranet>
References: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org> <1538397477-4003-4-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2018, Firoz Khan wrote:

> --- /dev/null
> +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
> @@ -0,0 +1,35 @@
> +#!/bin/sh

That's not accurate. These are bash scripts, not Bourne shell.

If you run 'checkbashisms', you'll see that a few small changes are needed 
in order to gain standards compliance and portability.

Some untested suggestions:

diff --git a/arch/m68k/kernel/syscalls/syscallhdr.sh b/arch/m68k/kernel/syscalls/syscallhdr.sh
index e0e3108cfc7f..9811f82848e6 100644
--- a/arch/m68k/kernel/syscalls/syscallhdr.sh
+++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
@@ -18,17 +18,17 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
     nxt=0
     while read nr abi name entry ; do
 	if [ -z "$offset" ]; then
-	    echo -e "#define __NR_${prefix}${name}\t$nr"
+	    echo "#define __NR_${prefix}${name}	$nr"
 	else
-	    echo -e "#define __NR_${prefix}${name}\t($offset + $nr)"
+	    echo "#define __NR_${prefix}${name}	($offset + $nr)"
 	fi
 	nxt=$nr
-	let nxt=nxt+1
+	nxt=$((nxt+1))
     done
 
     echo ""
     echo "#ifdef __KERNEL__"
-    echo -e "#define __NR_syscalls\t$nxt"
+    echo "#define __NR_syscalls	$nxt"
     echo "#endif"
     echo ""
     echo "#endif /* ${fileguard} */"
diff --git a/arch/m68k/kernel/syscalls/syscalltbl.sh b/arch/m68k/kernel/syscalls/syscalltbl.sh
index d2635dea4e96..89ab047097ce 100644
--- a/arch/m68k/kernel/syscalls/syscalltbl.sh
+++ b/arch/m68k/kernel/syscalls/syscalltbl.sh
@@ -13,7 +13,7 @@ emit() {
 
     while [ $nxt -lt $nr ]; do
 	echo "__SYSCALL($nxt, sys_ni_syscall, )"
-	let nxt=nxt+1
+	nxt=$((nxt+1))
     done
 
     echo "__SYSCALL($nr, $entry, )"
@@ -29,6 +29,6 @@ grep '^[0-9]' "$in" | sort -n | (
     while read nr abi name entry ; do
 	emit $nxt $nr $entry
 	nxt=$nr
-        let nxt=nxt+1
+        nxt=$((nxt+1))
     done
 ) > "$out"

-- 
