Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELt8JE5q7mPLn3U7zc1//nEdYGLIC2AByyfJbpMew+N7kvB42ymgZX76AXSczhIbj3ObdStw
ARC-Seal: i=1; a=rsa-sha256; t=1521141387; cv=none;
        d=google.com; s=arc-20160816;
        b=tKsvzlucisDtD37OLSOSGZ70VutG60uUPGgJj7QP7Qi4v54k3ZmMpues45uToE4+6n
         J3DmFkbUDQ5zb5lz6sTzjsBYfDaeaJfeD6jTN1diVC4XLfUkm0qWUeuojgpQZde4kENE
         wNUxQXjyYMOdQ24xbSKF2mpxwgwnwUUOPZfL+7bRWV2VLq68HrI447MQ4wF1sscEyZCM
         OePdLRqr5gT6j+3newXpZHh1BGgZxZeHOcKlVM7fqI3h8qk87GjDzadmAWQY1NdVPZJz
         NdF/ICxdjDpE5DBnfS016Xc/EXguc48AAecjjv6DxSibYNymiKmYPLRPSacTL/Ua9p9s
         ELqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gEOKyIe1U9YBfXe66t+RgpZxY6v2Q9Kuc9lgV7yWwOA=;
        b=L61HvwOXYULeJFBQ4CkTLVeA3kPyjTOthl76pGow0O3g+FdMIZlNwZhQYwBOz0wmpH
         Xqhrzx55TW6X6xxG3OGoDpI9pEL2BtyFL25jcSt3kD2/ZG/PxDR6KCRt5hsrMCsuKul3
         wCarsAMFIdikxO2HeqCocCM/t2Bca3HioJGzoCQ9AwziQJXTC9Rbdu/G76tgyRFoCA8F
         ioQ48svolU0+RtTk+vm2fsW9NFcbhhj5M+XtaJDXnLWbafCqPlsMZ9kaA1lVNWI3MvGK
         MeRZw87hMpQVPp1HpLK5iLMqDptiCquM7TBW/9LJJLOyCrUjwuF3XHWgo7PG1qd5FN+5
         EBng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Michael Neuling <mikey@neuling.org>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Daniel Axtens <dja@axtens.net>,
	Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	David Gibson <david@gibson.dropbear.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Joe Perches <joe@perches.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Tobin C. Harding" <me@tobin.cc>,
	Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC rebase 8/9] powerpc/64s: barrier_nospec: Add hcall triggerr
Date: Thu, 15 Mar 2018 20:15:57 +0100
Message-Id: <54913b22e2f3647c670b6fb3e1fecce34729b736.1521141122.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <cover.1521141122.git.msuchanek@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032350788756916?=
X-GMAIL-MSGID: =?utf-8?q?1595032350788756916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Adapted from the RFI implementation

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/platforms/pseries/mobility.c |  2 +-
 arch/powerpc/platforms/pseries/pseries.h  |  2 +-
 arch/powerpc/platforms/pseries/setup.c    | 37 ++++++++++++++++++++++---------
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 8a8033a249c7..9d506be1580e 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -349,7 +349,7 @@ void post_mobility_fixup(void)
 			"failed: %d\n", rc);
 
 	/* Possibly switch to a new RFI flush type */
-	pseries_setup_rfi_flush();
+	pseries_setup_rfi_nospec();
 
 	return;
 }
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 27cdcb69fd18..d49670c67686 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -100,6 +100,6 @@ static inline unsigned long cmo_get_page_size(void)
 
 int dlpar_workqueue_init(void);
 
-void pseries_setup_rfi_flush(void);
+void pseries_setup_rfi_nospec(void);
 
 #endif /* _PSERIES_PSERIES_H */
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 9877c3dfcdc8..4b899a4db6dd 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -459,30 +459,47 @@ static void __init find_and_init_phbs(void)
 	of_pci_check_probe_only();
 }
 
-void pseries_setup_rfi_flush(void)
+void pseries_setup_rfi_nospec(void)
 {
 	struct h_cpu_char_result result;
-	enum l1d_flush_type types;
-	bool enable;
+	enum l1d_flush_type flush_types;
+	enum spec_barrier_type barrier_type;
+	bool flush_enable;
+	bool barrier_enable;
 	long rc;
 
 	/* Enable by default */
-	enable = true;
-	types = L1D_FLUSH_FALLBACK;
+	flush_enable = true;
+	flush_types = L1D_FLUSH_FALLBACK;
+	barrier_enable = true;
+	/* no fallback available if the firmware does not tell us */
+	barrier_type = SPEC_BARRIER_NONE;
 
 	rc = plpar_get_cpu_characteristics(&result);
 	if (rc == H_SUCCESS) {
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
-			types |= L1D_FLUSH_MTTRIG;
+			flush_types |= L1D_FLUSH_MTTRIG;
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
-			types |= L1D_FLUSH_ORI;
+			flush_types |= L1D_FLUSH_ORI;
+		if (result.character & H_CPU_CHAR_SPEC_BAR_ORI31)
+			barrier_type |= SPEC_BARRIER_ORI;
 
 		if ((!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR)) ||
 		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
-			enable = false;
+			flush_enable = false;
+		/*
+		 * Do not check H_CPU_BEHAV_BNDS_CHK_SPEC_BAR - the ORI does
+		 * nothing anyway when not supported.
+		 */
+		if ((!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
+			barrier_enable = false;
+	} else {
+		/* Default to fallback if case hcall is not available */
+		flush_types = L1D_FLUSH_FALLBACK;
 	}
 
-	setup_rfi_flush(types, enable);
+	setup_barrier_nospec(barrier_type, barrier_enable);
+	setup_rfi_flush(flush_types, flush_enable);
 }
 
 #ifdef CONFIG_PCI_IOV
@@ -658,7 +675,7 @@ static void __init pSeries_setup_arch(void)
 
 	fwnmi_init();
 
-	pseries_setup_rfi_flush();
+	pseries_setup_rfi_nospec();
 
 	/* By default, only probe PCI (can be overridden by rtas_pci) */
 	pci_add_flags(PCI_PROBE_ONLY);
-- 
2.13.6
