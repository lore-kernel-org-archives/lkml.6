Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968951AbeE1Ko2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968907AbeE1KoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:44:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Subject: [PATCH 4.14 039/496] powerpc/rfi-flush: Always enable fallback flush on pseries
Date: Mon, 28 May 2018 11:57:04 +0200
Message-Id: <20180528100321.317017045@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 84749a58b6e382f109abf1e734bc4dd43c2c25bb upstream.

This ensures the fallback flush area is always allocated on pseries,
so in case a LPAR is migrated from a patched to an unpatched system,
it is possible to enable the fallback flush in the target system.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/setup.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -468,26 +468,18 @@ static void pseries_setup_rfi_flush(void
 
 	/* Enable by default */
 	enable = true;
+	types = L1D_FLUSH_FALLBACK;
 
 	rc = plpar_get_cpu_characteristics(&result);
 	if (rc == H_SUCCESS) {
-		types = L1D_FLUSH_NONE;
-
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
 			types |= L1D_FLUSH_MTTRIG;
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
 			types |= L1D_FLUSH_ORI;
 
-		/* Use fallback if nothing set in hcall */
-		if (types == L1D_FLUSH_NONE)
-			types = L1D_FLUSH_FALLBACK;
-
 		if ((!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR)) ||
 		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
 			enable = false;
-	} else {
-		/* Default to fallback if case hcall is not available */
-		types = L1D_FLUSH_FALLBACK;
 	}
 
 	setup_rfi_flush(types, enable);
