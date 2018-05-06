Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbeEFKwY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 06:52:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60385 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeEFKwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 06:52:23 -0400
Date: Sun, 6 May 2018 03:51:56 -0700
From: tip-bot for David Wang <tipbot@zytor.com>
Message-ID: <tip-13e8582245267b872dc6eb4ab695fffc797d99f5@git.kernel.org>
Cc: bp@suse.de, davidwang@zhaoxin.com, greg@kroah.com,
        linux-edac@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, tony.luck@intel.com, linux-kernel@vger.kernel.org
Reply-To: davidwang@zhaoxin.com, bp@suse.de, greg@kroah.com,
        linux-edac@vger.kernel.org, tony.luck@intel.com, mingo@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <1524652420-17330-2-git-send-email-davidwang@zhaoxin.com>
References: <1524652420-17330-2-git-send-email-davidwang@zhaoxin.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE: Enable MCE broadcasting on new Centaur CPUs
Git-Commit-ID: 13e8582245267b872dc6eb4ab695fffc797d99f5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  13e8582245267b872dc6eb4ab695fffc797d99f5
Gitweb:     https://git.kernel.org/tip/13e8582245267b872dc6eb4ab695fffc797d99f5
Author:     David Wang <davidwang@zhaoxin.com>
AuthorDate: Wed, 25 Apr 2018 18:33:39 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 6 May 2018 12:46:25 +0200

x86/MCE: Enable MCE broadcasting on new Centaur CPUs

Newer Centaur multi-core CPUs also support MCE broadcasting to all
cores. Add a Centaur-specific init function setting that up.

 [ bp:
   - make mce_centaur_feature_init() static
   - flip check to do the f/m/s first for better readability
   - touch up text
  ]

Signed-off-by: David Wang <davidwang@zhaoxin.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: lukelin@viacpu.com
Cc: qiyuanwang@zhaoxin.com
Cc: Greg KH <greg@kroah.com>
Cc: brucechang@via-alliance.com
Cc: timguo@zhaoxin.com
Cc: cooperyan@zhaoxin.com
Cc: Tony Luck <tony.luck@intel.com>
Cc: benjaminpan@viatech.com
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/1524652420-17330-2-git-send-email-davidwang@zhaoxin.com

---
 arch/x86/kernel/cpu/mcheck/mce.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 42cf2880d0ed..cd76380af79f 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1727,6 +1727,21 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 	}
 }
 
+static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
+{
+	struct mca_config *cfg = &mca_cfg;
+
+	 /*
+	  * All newer Centaur CPUs support MCE broadcasting. Enable
+	  * synchronization with a one second timeout.
+	  */
+	if ((c->x86 == 6 && c->x86_model == 0xf && c->x86_stepping >= 0xe) ||
+	     c->x86 > 6) {
+		if (cfg->monarch_timeout < 0)
+			cfg->monarch_timeout = USEC_PER_SEC;
+	}
+}
+
 static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
@@ -1739,6 +1754,9 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		mce_amd_feature_init(c);
 		break;
 		}
+	case X86_VENDOR_CENTAUR:
+		mce_centaur_feature_init(c);
+		break;
 
 	default:
 		break;
