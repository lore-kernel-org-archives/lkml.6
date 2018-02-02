Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeBBQVg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:21:36 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:51339 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeBBQVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:21:22 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andi Kleen <ak@linux.intel.com>
Cc: Nicolas Pitre <nico@linaro.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/7] [HACK] x86: crypto: fix link error with LTO
Date: Fri,  2 Feb 2018 17:21:00 +0100
Message-Id: <20180202162104.2300532-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202161550.2106846-1-arnd@arndb.de>
References: <20180202161550.2106846-1-arnd@arndb.de>
X-Provags-ID: V03:K0:/4xB8qLKWRsQKS6zFXtOIoVYJOhfhv/XMhjjv3mV7IpzLd2Amsp
 DRXC8eRUisLpqAR1g38LRi2XbAdnCRUuBzpyO1w/wV+z5f8zxr0OX3FCJJ/tkcGUzK6xsjP
 1XYem71gFR08CjBfcOHX/+8YxoDb9vGsQ7sU/0tY2ClEHLlzbs3pSiSXObJfqHR6jUrp2Fk
 6aJAaDrQr0CT6yF1EnJrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Uy4Kgz9iaYM=:FYA3RK/NLHdVC+0osIkE4a
 jPUeN7QhWD/Ztn1SoyP7tmuYD31Oje1A80SZ3/q4RG/RfmwDijE7xQWIkvZlxrsLFZbq2E2kA
 A3KGAjEWxEy4vB/3YOgDyvwkgHGxa8O8CBcxgem8O+4/RQ9UuOC+DEOKTXy/v+nwGpMzuv9vH
 Wd4QrqSArEMl3MLr6JGglUX4zupEs+sNGRC062hR6EHF+T7ix1Xk66CXo0iwPtM1XXj3xzr+i
 Y4FudgJcOrxSdnhXrNSahme13E+5S0FyjGqkSdnQhFo4NdycfhqTxKq0Q0LSmrTk4aWmy4SN8
 hn8NzxuHicmWHMY3+HfwGMws2CRrSjRbGg/bKSXGYx42iLEYzNlahLsgpueVH4TZjQ/EM92Rp
 n3m+q3by5VOUQMoGsS8YLftEMUzqpYtNim9ilBeAPwgWyVy+e9GPGcO7yMR6pM3OQJVICUvnV
 xax4+dMfd61SFe6OSY9pOQjPhtoBDI5oRBninsk81PmluSkWr+YRzFCenQ8S6itmvX2WVepXd
 u93qnwFMOwZg0SIE0hUwUKnjBOgxzHQAlMMTmRxixYJxW0TIVpe1m9gq/ppJj8V/TaBoEsATG
 gZOd14nkQytgzrxYePmVXnLO8fHKoWY1+gRFiQw8RjVnx/m2/uCScKAkvq1onmLhn3eJeB//S
 txHEIfy9ym/PsPK+X6eA2riLHGDNRT5OvvFnbM3s4dioGC3mD/8eJCXSrze/w5ZZuf0N3WJDN
 1EmU+mRAAi9LBQr9FN6UGFA2rUQRSTgJ5oGFgw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crypto_it_tab and the other symbols like it are defined in
crypto/aes_generic.c and exported for loadable modules. When
building with LTO and CONFIG_TRIM_UNUSED_KSYMS, the exports
are eliminated, since kbuild fails to take the users in
the arch/x86/crypto/aes-i586-asm_32.S assembler file into
account.

This adds an ugly workaround by adding a reference to each symbol
into aes_glue.c, which gets linked together with the assembler
file.

We obviously want to fix the CONFIG_TRIM_UNUSED_KSYMS logic
to do the right thing here instead, but I couldn't come up
with a good fix, so I use this instead to get a clean build
for testing.

This fix only works most of the time, but I still ran into
some cases where combining an .S with a .c file did not
produce the correct .ko file, as the lto linker apparently
did not expect that kind of input. 'nm' on the file after
'ld -r' showed only the contents of the assembler file, and
after the lto-ld stage, only the contents of the .c file
are there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/crypto/aes_glue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/crypto/aes_glue.c b/arch/x86/crypto/aes_glue.c
index e26984f7ab8d..6da3e3c34a77 100644
--- a/arch/x86/crypto/aes_glue.c
+++ b/arch/x86/crypto/aes_glue.c
@@ -53,6 +53,11 @@ static struct crypto_alg aes_alg = {
 
 static int __init aes_init(void)
 {
+	/* ugly hack to force a link time dependency */
+	if (&crypto_it_tab == &crypto_ft_tab ||
+	    &crypto_fl_tab == &crypto_il_tab)
+		return 0;
+
 	return crypto_register_alg(&aes_alg);
 }
 
-- 
2.9.0
