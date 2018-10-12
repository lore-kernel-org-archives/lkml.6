Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A7DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6920A2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6920A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sf-tec.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeJLTkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:40:00 -0400
Received: from mail.sf-mail.de ([78.47.74.12]:37399 "EHLO mail.sf-mail.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbeJLTkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:40:00 -0400
Received: (qmail 6568 invoked from network); 12 Oct 2018 12:07:49 -0000
Received: from mail.sf-mail.de ([::ffff:78.47.74.12]:50458 HELO webmail.sf-mail.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.34dev) with (DHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA
        for <firoz.khan@linaro.org>; Fri, 12 Oct 2018 14:07:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 12 Oct 2018 14:07:47 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, linux-parisc-owner@vger.kernel.org
Subject: Re: [PATCH v4 3/6] parisc: add system call table generation support
In-Reply-To: <1539337442-3676-4-git-send-email-firoz.khan@linaro.org>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-4-git-send-email-firoz.khan@linaro.org>
Message-ID: <c6280818c999449646ec216984f2df9e@sf-tec.de>
X-Sender: eike-kernel@sf-tec.de
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firoz Khan wrote:

> diff --git a/arch/parisc/kernel/syscalls/syscallhdr.sh
> b/arch/parisc/kernel/syscalls/syscallhdr.sh
> new file mode 100644
> index 0000000..607d4ca
> --- /dev/null
> +++ b/arch/parisc/kernel/syscalls/syscallhdr.sh
> @@ -0,0 +1,35 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +in="$1"
> +out="$2"
> +my_abis=`echo "($3)" | tr ',' '|'`

Any reason not to use $() instead of backticks?

> +prefix="$4"
> +offset="$5"
> +
> +fileguard=_UAPI_ASM_PARISC_`basename "$out" | sed \
> +    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> +    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> +    echo "#ifndef ${fileguard}"
> +    echo "#define ${fileguard}"
> +    echo ""
> +
> +    nxt=0
> +    while read nr abi name entry compat ; do
> +	if [ -z "$offset" ]; then
> +	    echo -e "#define __NR_${prefix}${name}\t$nr"

This mixed indentation with both tabs and spaces is a bit messy.

> +	else
> +	    echo -e "#define __NR_${prefix}${name}\t($offset + $nr)"
> +	fi
> +	nxt=$nr
> +	let nxt=nxt+1

Why do you use let here when you do $(()) calculations at other places?

> +    done
> +
> +    echo ""
> +    echo "#ifdef __KERNEL__"
> +    echo -e "#define __NR_syscalls\t$nxt"
> +    echo "#endif"
> +    echo ""
> +    echo "#endif /* ${fileguard} */"
> +) > "$out"
> diff --git a/arch/parisc/kernel/syscalls/syscalltbl.sh
> b/arch/parisc/kernel/syscalls/syscalltbl.sh
> new file mode 100644
> index 0000000..04abde7
> --- /dev/null
> +++ b/arch/parisc/kernel/syscalls/syscalltbl.sh
> @@ -0,0 +1,46 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +in="$1"
> +out="$2"
> +my_abis=`echo "($3)" | tr ',' '|'`
> +offset="$4"
> +
> +emit() {
> +    nxt="$1"
> +    if [ -z "$offset" ]; then
> +	nr="$2"
> +    else
> +	nr="$2"
> +	nr=$((nr+offset))

This could be one line, no? Or just set offset to 0 if it is empty and 
avoid that if alltogether.

> +    fi
> +    entry="$3"
> +
> +    while [ $nxt -lt $nr ]; do
> +	echo "__SYSCALL($nxt, sys_ni_syscall, )"
> +        let nxt=nxt+1
> +    done
> +    echo "__SYSCALL($nxt, $entry, )"
> +}
> +
> +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> +    if [ -z "$offset" ]; then
> +	nxt=0
> +    else
> +	nxt=$offset
> +    fi

Another argument for offset=0 as default.

> +
> +    my_abi="$(cut -d'|' -f2 <<< $my_abis)"

"<<<" is a bash extension and will not work with /bin/sh.

> +    while read nr abi name entry compat ; do
> +	if [ $my_abi = "compat" ]; then
> +	    if [ -z "$compat" ]; then
> +		emit $nxt $nr $entry
> +	    else
> +		emit $nxt $nr $compat
> +	    fi
> +	else
> +	    emit $nxt $nr $entry
> +	fi

I would go for a local variable being set to $compat or $entry and 
calling emit at only one place. And there should be only one if with 2 
expressions, no need for 3 branches.

> +        let nxt=nxt+1

Inconsistent indentation.

> +    done
> +) > "$out"

Eike
