Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeFERFi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751879AbeFERFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:05:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Subject: [PATCH 4.9 31/61] powerpc/rfi-flush: Call setup_rfi_flush() after LPM migration
Date: Tue,  5 Jun 2018 19:01:52 +0200
Message-Id: <20180605170119.701287189@linuxfoundation.org>
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

commit 921bc6cf807ceb2ab8005319cf39f33494d6b100 upstream.

We might have migrated to a machine that uses a different flush type,
or doesn't need flushing at all.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/mobility.c |    3 +++
 arch/powerpc/platforms/pseries/pseries.h  |    2 ++
 arch/powerpc/platforms/pseries/setup.c    |    2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -314,6 +314,9 @@ void post_mobility_fixup(void)
 		printk(KERN_ERR "Post-mobility device tree update "
 			"failed: %d\n", rc);
 
+	/* Possibly switch to a new RFI flush type */
+	pseries_setup_rfi_flush();
+
 	return;
 }
 
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -79,4 +79,6 @@ extern struct pci_controller_ops pseries
 
 unsigned long pseries_memory_block_size(void);
 
+void pseries_setup_rfi_flush(void);
+
 #endif /* _PSERIES_PSERIES_H */
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -450,7 +450,7 @@ static void __init find_and_init_phbs(vo
 	of_pci_check_probe_only();
 }
 
-static void pseries_setup_rfi_flush(void)
+void pseries_setup_rfi_flush(void)
 {
 	struct h_cpu_char_result result;
 	enum l1d_flush_type types;
