Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AB8JxZrTymW/hvoLbHLpEbtAabXo4Rcg4sMO8jURtClMCQNmeRoqNkwuVkhYwB+jBLIhHpsDoO16
ARC-Seal: i=1; a=rsa-sha256; t=1526035414; cv=none;
        d=google.com; s=arc-20160816;
        b=DLZwYr7GKWkqqGr17RmLeYyc22tK71AnaTXJc5f/TsUW7YVlaglBoxlh7QJ1sR1oFV
         wQgo6NR5wtoUwWhvL/YABMlspmtLhESpQMk8IRNVw761N3oEEZHcX/3BLRyZzhYiXRyu
         YzLxkan7Ltf5yM4zPSYorMBIvh+dPbI8os7iYr0/pqF0t/wvP1RUARpBTqW/YY4wnKsI
         FmnfntYYP/dR52uzqOEp6KstsskftJ8J9LjWsd05vSN7MV/FhjgPV2YMFnFOHvPPyOVp
         Z3WGK2SQkQZYLNfeDkADw5UfNdyhfKmhv2ZjcppD30EVwT1B0VjuiXK311Pb5Dt29Y6+
         jfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=0RMJqL3Uz9nuAK6QtHNgOVgYQ8l8aRRhaV+xXnIIR6g=;
        b=AXnLarfLlN1jABLEafKfMTWFYcvvSynxpptPNV56LuK2Lp7W23wYjI/V5vR7Dhumb5
         DXmihOXR5c8NZSqufMPULOcFP2Ia+MgnFeGSTi/sBlu3d36A0jbLqze/n/l41JoBP94D
         PXj2ya3UyJKSLxYkj5mrXsyy8UH0Cm6bAU3TQXy7M3JVO59l+Kt53vAW/sLxCPdJvMtI
         sRHck0yTvsk9lYYW7os9yK+0/dGF3NEkFL1VFzOwP/CezbXPTimZEFp763nugB4RmuGF
         lCIqWE9dbEpuiTPYUAC4yfQHbMAeqx7hQpfdwaXBVx8KA8VEg8M6Srfnht32bRS94ajZ
         9orA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="126600547"
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>,
	Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v16 2/9] pci-error-recovery: Add AER_FATAL handling
Date: Fri, 11 May 2018 06:43:21 -0400
Message-Id: <1526035408-31328-3-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600164110585653734?=
X-GMAIL-MSGID: =?utf-8?q?1600164110585653734?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It adds description on AER_FATAL error handling.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/Documentation/PCI/pci-error-recovery.txt b/Documentation/PCI/pci-error-recovery.txt
index 0b6bb3e..688b691 100644
--- a/Documentation/PCI/pci-error-recovery.txt
+++ b/Documentation/PCI/pci-error-recovery.txt
@@ -110,7 +110,7 @@ The actual steps taken by a platform to recover from a PCI error
 event will be platform-dependent, but will follow the general
 sequence described below.
 
-STEP 0: Error Event
+STEP 0: Error Event: ERR_NONFATAL
 -------------------
 A PCI bus error is detected by the PCI hardware.  On powerpc, the slot
 is isolated, in that all I/O is blocked: all reads return 0xffffffff,
@@ -228,13 +228,7 @@ proceeds to either STEP3 (Link Reset) or to STEP 5 (Resume Operations).
 If any driver returned PCI_ERS_RESULT_NEED_RESET, then the platform
 proceeds to STEP 4 (Slot Reset)
 
-STEP 3: Link Reset
-------------------
-The platform resets the link.  This is a PCI-Express specific step
-and is done whenever a fatal error has been detected that can be
-"solved" by resetting the link.
-
-STEP 4: Slot Reset
+STEP 3: Slot Reset
 ------------------
 
 In response to a return value of PCI_ERS_RESULT_NEED_RESET, the
@@ -320,7 +314,7 @@ Failure).
 >>> However, it probably should.
 
 
-STEP 5: Resume Operations
+STEP 4: Resume Operations
 -------------------------
 The platform will call the resume() callback on all affected device
 drivers if all drivers on the segment have returned
@@ -332,7 +326,7 @@ a result code.
 At this point, if a new error happens, the platform will restart
 a new error recovery sequence.
 
-STEP 6: Permanent Failure
+STEP 5: Permanent Failure
 -------------------------
 A "permanent failure" has occurred, and the platform cannot recover
 the device.  The platform will call error_detected() with a
@@ -355,6 +349,27 @@ errors. See the discussion in powerpc/eeh-pci-error-recovery.txt
 for additional detail on real-life experience of the causes of
 software errors.
 
+STEP 0: Error Event: ERR_FATAL
+-------------------
+PCI bus error is detected by the PCI hardware. On powerpc, the slot is
+isolated, in that all I/O is blocked: all reads return 0xffffffff, all
+writes are ignored.
+
+STEP 1: Remove devices
+--------------------
+Platform removes the devices depending on the error agent, it could be
+this port for all subordinates or upstream component (likely downstream
+port)
+
+STEP 2: Reset link
+--------------------
+The platform resets the link.  This is a PCI-Express specific step and is
+done whenever a fatal error has been detected that can be "solved" by
+resetting the link.
+
+STEP 3: Re-enumerate the devices
+--------------------
+Initiates the re-enumeration.
 
 Conclusion; General Remarks
 ---------------------------
-- 
2.7.4
