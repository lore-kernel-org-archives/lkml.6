Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeBEPu2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:50:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:31284 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752767AbeBEPuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:50:16 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,465,1511856000";
   d="scan'208";a="171790858"
Date: Mon, 5 Feb 2018 07:50:01 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        nico@linaro.org, linux-kernel@vger.kernel.org,
        Wanlong Gao <wanlong.gao@gmail.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/2] modpost: don't add warnings for LTO-generated symbols
Message-ID: <20180205155001.GI30338@tassilo.jf.intel.com>
References: <20180205151300.539874-1-arnd@arndb.de>
 <20180205151300.539874-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205151300.539874-2-arnd@arndb.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 04:12:52PM +0100, Arnd Bergmann wrote:
> WARNING: vmlinux.o(.data+0x12e0): Section mismatch in reference from the variable pfkey_net_ops.lto_priv.2992 to the function .init.text:pfkey_net_init.lto_priv.2977()
> The variable pfkey_net_ops.lto_priv.2992 references
> the function __init pfkey_net_init.lto_priv.2977()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

A better fix would be to ensure modpost always runs on already LD_FINALed
objects, so it never sees LTO.

Otherwise you would need to teach modpost about the LTO symbol table
and some other magic. I did that once, but it turned out to be very
ugly.

-Andi
