Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeFERGZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753590AbeFERGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:06:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 45/61] powerpc/64s: Fix section mismatch warnings from setup_rfi_flush()
Date: Tue,  5 Jun 2018 19:02:06 +0200
Message-Id: <20180605170120.557211051@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 501a78cbc17c329fabf8e9750a1e9ab810c88a0e upstream.

The recent LPM changes to setup_rfi_flush() are causing some section
mismatch warnings because we removed the __init annotation on
setup_rfi_flush():

  The function setup_rfi_flush() references
  the function __init ppc64_bolted_size().
  the function __init memblock_alloc_base().

The references are actually in init_fallback_flush(), but that is
inlined into setup_rfi_flush().

These references are safe because:
 - only pseries calls setup_rfi_flush() at runtime
 - pseries always passes L1D_FLUSH_FALLBACK at boot
 - so the fallback flush area will always be allocated
 - so the check in init_fallback_flush() will always return early:
   /* Only allocate the fallback flush area once (at boot time). */
   if (l1d_flush_fallback_area)
   	return;

 - and therefore we won't actually call the freed init routines.

We should rework the code to make it safer by default rather than
relying on the above, but for now as a quick-fix just add a __ref
annotation to squash the warning.

Fixes: abf110f3e1ce ("powerpc/rfi-flush: Make it possible to call setup_rfi_flush() again")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/setup_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -726,7 +726,7 @@ void rfi_flush_enable(bool enable)
 	rfi_flush = enable;
 }
 
-static void init_fallback_flush(void)
+static void __ref init_fallback_flush(void)
 {
 	u64 l1d_size, limit;
 	int cpu;
