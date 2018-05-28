Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165469AbeE1Nmq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:42:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964769AbeE1Knw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:43:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 035/496] powerpc/pseries: Support firmware disable of RFI flush
Date: Mon, 28 May 2018 11:57:00 +0200
Message-Id: <20180528100321.087770636@linuxfoundation.org>
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

commit 582605a429e20ae68fd0b041b2e840af296edd08 upstream.

Some versions of firmware will have a setting that can be configured
to disable the RFI flush, add support for it.

Fixes: 8989d56878a7 ("powerpc/pseries: Query hypervisor for RFI flush settings")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/setup.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -482,7 +482,8 @@ static void pseries_setup_rfi_flush(void
 		if (types == L1D_FLUSH_NONE)
 			types = L1D_FLUSH_FALLBACK;
 
-		if (!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR))
+		if ((!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR)) ||
+		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
 			enable = false;
 	} else {
 		/* Default to fallback if case hcall is not available */
