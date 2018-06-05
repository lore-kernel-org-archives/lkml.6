Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeFEREz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753093AbeFEREv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:04:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "dwmw@amazon.co.uk, boris.ostrovsky@oracle.com, Juergen Gross"
        <jgross@suse.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.9 15/61] x86/amd: revert commit 944e0fc51a89c9827b9
Date: Tue,  5 Jun 2018 19:01:36 +0200
Message-Id: <20180605170118.591023264@linuxfoundation.org>
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

From: Juergen Gross <jgross@suse.com>

Revert commit 944e0fc51a89c9827b98813d65dc083274777c7f ("x86/amd: don't
set X86_BUG_SYSRET_SS_ATTRS when running under Xen") as it is lacking
a prerequisite patch and is making things worse.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/amd.c |    5 ++---
 arch/x86/xen/enlighten.c  |    4 +++-
 2 files changed, 5 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -857,9 +857,8 @@ static void init_amd(struct cpuinfo_x86
 		if (cpu_has(c, X86_FEATURE_3DNOW) || cpu_has(c, X86_FEATURE_LM))
 			set_cpu_cap(c, X86_FEATURE_3DNOWPREFETCH);
 
-	/* AMD CPUs don't reset SS attributes on SYSRET, Xen does. */
-	if (!cpu_has(c, X86_FEATURE_XENPV))
-		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
+	/* AMD CPUs don't reset SS attributes on SYSRET */
+	set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
 }
 
 #ifdef CONFIG_X86_32
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1980,8 +1980,10 @@ EXPORT_SYMBOL_GPL(xen_hvm_need_lapic);
 
 static void xen_set_cpu_features(struct cpuinfo_x86 *c)
 {
-	if (xen_pv_domain())
+	if (xen_pv_domain()) {
+		clear_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
 		set_cpu_cap(c, X86_FEATURE_XENPV);
+	}
 }
 
 static void xen_pin_vcpu(int cpu)
