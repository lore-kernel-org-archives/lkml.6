Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753833AbeFERMy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752186AbeFERGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:06:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 44/61] powerpc/pseries: Restore default security feature flags on setup
Date: Tue,  5 Jun 2018 19:02:05 +0200
Message-Id: <20180605170120.487069044@linuxfoundation.org>
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

From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

commit 6232774f1599028a15418179d17f7df47ede770a upstream.

After migration the security feature flags might have changed (e.g.,
destination system with unpatched firmware), but some flags are not
set/clear again in init_cpu_char_feature_flags() because it assumes
the security flags to be the defaults.

Additionally, if the H_GET_CPU_CHARACTERISTICS hypercall fails then
init_cpu_char_feature_flags() does not run again, which potentially
might leave the system in an insecure or sub-optimal configuration.

So, just restore the security feature flags to the defaults assumed
by init_cpu_char_feature_flags() so it can set/clear them correctly,
and to ensure safe settings are in place in case the hypercall fail.

Fixes: f636c14790ea ("powerpc/pseries: Set or clear security feature flags")
Depends-on: 19887d6a28e2 ("powerpc: Move default security feature flags")
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/setup.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -453,6 +453,10 @@ static void __init find_and_init_phbs(vo
 
 static void init_cpu_char_feature_flags(struct h_cpu_char_result *result)
 {
+	/*
+	 * The features below are disabled by default, so we instead look to see
+	 * if firmware has *enabled* them, and set them if so.
+	 */
 	if (result->character & H_CPU_CHAR_SPEC_BAR_ORI31)
 		security_ftr_set(SEC_FTR_SPEC_BAR_ORI31);
 
@@ -492,6 +496,13 @@ void pseries_setup_rfi_flush(void)
 	bool enable;
 	long rc;
 
+	/*
+	 * Set features to the defaults assumed by init_cpu_char_feature_flags()
+	 * so it can set/clear again any features that might have changed after
+	 * migration, and in case the hypercall fails and it is not even called.
+	 */
+	powerpc_security_features = SEC_FTR_DEFAULT;
+
 	rc = plpar_get_cpu_characteristics(&result);
 	if (rc == H_SUCCESS)
 		init_cpu_char_feature_flags(&result);
