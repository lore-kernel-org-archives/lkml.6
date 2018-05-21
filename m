Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoZd5vittahQSFV/+gDF4MEw5zXFNII9QT7uwoTkzH02mLpBNo/eksoR8xcUP+xyUUQ6cBV
ARC-Seal: i=1; a=rsa-sha256; t=1526937600; cv=none;
        d=google.com; s=arc-20160816;
        b=Nt9RX5arS7eJRKoardB8Z2I8zFcfKpc30hHRu1Edul/mFVsdQObWCf9DVgNXE315SW
         aW6Sry5/qR5TR2P/XaBAaZuiNmFZn0gGZb63IXmUnQCIynx6ftFQO6rDtrOGTj+EXPTz
         7e1gKdf2lzMZ+sHPNW0DECya5LFqi8q0eNLzUxdvC8ESg8vx+yP6Z8iA28d6kQ28sx2V
         2kYi4rOKnk65SBcUbk9DvwAZcpRtFsK0JsNRNCgcHqBgcX5o+qVKGsjF86U3oLQkQnt/
         w6FTDU4bxPHpZ+49Sc+hBbiTTL0lvzXco/7E7OZLp35kPeH4YfSCwInecUhG0GfiD6jM
         oCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=lTMqyTQXj9Pd0L2nPDPodNdQoMmt2LahI+rGzA0i2ls=;
        b=GoUil27DFUoqBJ8qieWIfJX35unKox83we/wGwExKqLdII7NXGmG8T795frY8cxf0W
         uYLnrRyLCBuB2icvzBORb+18haS1CoWhH4LNiOuNwsPbdU1Kwn8zIElCAw3liW1qMVD+
         Ei0/8PTg+p1w6s5h+DiJjHHBzjIkiUNQQJ59OCnzymYP9DIUwelOeIYsHC1dYsaEayKy
         jamkjthbcKO1DWBSweEW+oPrDST1skqIJhsOnvEJG4sEWlHm2gVtdTRu/sHixTdX+fBH
         2qtG+6SyD4RnoZrmY4IsjXsNYJQorq0FlAG0x8YTnRbpXk/BNikM1R/Ptxv+o0eHC9Ig
         aeiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GKtMs+aR;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GKtMs+aR;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 53/95] x86/bugs: Expose /sys/../spec_store_bypass
Date: Mon, 21 May 2018 23:11:43 +0200
Message-Id: <20180521210458.156477130@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109836232139188?=
X-GMAIL-MSGID: =?utf-8?q?1601110121771919716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit c456442cd3a59eeb1d60293c26cbe2ff2c4e42cf upstream

Add the sysfs file for the new vulerability. It does not do much except
show the words 'Vulnerable' for recent x86 cores.

Intel cores prior to family 6 are known not to be vulnerable, and so are
some Atoms and some Xeon Phi.

It assumes that older Cyrix, Centaur, etc. cores are immune.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |    1 
 arch/x86/include/asm/cpufeatures.h                 |    1 
 arch/x86/kernel/cpu/bugs.c                         |    5 ++++
 arch/x86/kernel/cpu/common.c                       |   23 +++++++++++++++++++++
 drivers/base/cpu.c                                 |    8 +++++++
 include/linux/cpu.h                                |    2 +
 6 files changed, 40 insertions(+)

--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -378,6 +378,7 @@ What:		/sys/devices/system/cpu/vulnerabi
 		/sys/devices/system/cpu/vulnerabilities/meltdown
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
 		/sys/devices/system/cpu/vulnerabilities/spectre_v2
+		/sys/devices/system/cpu/vulnerabilities/spec_store_bypass
 Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Information about CPU vulnerabilities
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -360,5 +360,6 @@
 #define X86_BUG_CPU_MELTDOWN		X86_BUG(14) /* CPU is affected by meltdown attack and needs kernel page table isolation */
 #define X86_BUG_SPECTRE_V1		X86_BUG(15) /* CPU is affected by Spectre variant 1 attack with conditional branches */
 #define X86_BUG_SPECTRE_V2		X86_BUG(16) /* CPU is affected by Spectre variant 2 attack with indirect branches */
+#define X86_BUG_SPEC_STORE_BYPASS	X86_BUG(17) /* CPU is affected by speculative store bypass attack */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -404,4 +404,9 @@ ssize_t cpu_show_spectre_v2(struct devic
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_SPECTRE_V2);
 }
+
+ssize_t cpu_show_spec_store_bypass(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_SPEC_STORE_BYPASS);
+}
 #endif
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -894,10 +894,33 @@ static const __initconst struct x86_cpu_
 	{}
 };
 
+static const __initconst struct x86_cpu_id cpu_no_spec_store_bypass[] = {
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_PINEVIEW	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_LINCROFT	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_PENWELL		},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_CLOVERVIEW	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_CEDARVIEW	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT1	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_AIRMONT		},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT2	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_MERRIFIELD	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_CORE_YONAH		},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_XEON_PHI_KNL		},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_XEON_PHI_KNM		},
+	{ X86_VENDOR_CENTAUR,	5,					},
+	{ X86_VENDOR_INTEL,	5,					},
+	{ X86_VENDOR_NSC,	5,					},
+	{ X86_VENDOR_ANY,	4,					},
+	{}
+};
+
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 ia32_cap = 0;
 
+	if (!x86_match_cpu(cpu_no_spec_store_bypass))
+		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
+
 	if (x86_match_cpu(cpu_no_speculation))
 		return;
 
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -521,14 +521,22 @@ ssize_t __weak cpu_show_spectre_v2(struc
 	return sprintf(buf, "Not affected\n");
 }
 
+ssize_t __weak cpu_show_spec_store_bypass(struct device *dev,
+					  struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Not affected\n");
+}
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
+static DEVICE_ATTR(spec_store_bypass, 0444, cpu_show_spec_store_bypass, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
 	&dev_attr_spectre_v1.attr,
 	&dev_attr_spectre_v2.attr,
+	&dev_attr_spec_store_bypass.attr,
 	NULL
 };
 
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -53,6 +53,8 @@ extern ssize_t cpu_show_spectre_v1(struc
 				   struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_spectre_v2(struct device *dev,
 				   struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_spec_store_bypass(struct device *dev,
+					  struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
