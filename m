Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753893AbeFERKz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753706AbeFERGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:06:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 25/61] powerpc/pseries: Support firmware disable of RFI flush
Date: Tue,  5 Jun 2018 19:01:46 +0200
Message-Id: <20180605170119.310579309@linuxfoundation.org>
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
@@ -473,7 +473,8 @@ static void pseries_setup_rfi_flush(void
 		if (types == L1D_FLUSH_NONE)
 			types = L1D_FLUSH_FALLBACK;
 
-		if (!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR))
+		if ((!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR)) ||
+		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
 			enable = false;
 	} else {
 		/* Default to fallback if case hcall is not available */
