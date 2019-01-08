Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC3FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45EF0206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfAHTnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:43:21 -0500
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:50194 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732680AbfAHTnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:43:17 -0500
Received: from ip4d142c80.dynamic.kabel-deutschland.de ([77.20.44.128] helo=xps13.fritz.box); authenticated
        by wp227.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1ggxHO-00070C-SI; Tue, 08 Jan 2019 20:43:14 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH v2 1/2] tools: create tools/debugging/ and add a script decoding /proc/sys/kernel/tainted
Date:   Tue,  8 Jan 2019 20:40:06 +0100
Message-Id: <20190108194007.29439-2-linux@leemhuis.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108194007.29439-1-linux@leemhuis.info>
References: <20190108194007.29439-1-linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1546976596;1498efdc;
X-HE-SMSGID: 1ggxHO-00070C-SI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a script to the tools/ directory that shows if or why the running kernel was
tainted. The script was mostly written by Randy Dunlap (thx!), who published it
while discussing changes that try to make admin-guide/tainted-kernels.rst more
comprehensible (
https://lore.kernel.org/lkml/8f67a8ca-bf64-c537-843a-b03bcfc3dace@infradead.org/
); I enhanced the script a bit and created this patch.

As the script targets users I did not want to add it to scripts/, as this dir
according to its Makefile "contains sources for various helper programs used
throughout the kernel for the build process". The directory tools/scripts/ also
did not look like a good fit, as the stuff that's there already is used for
other purposes. That's why I created a new directory for tools like this; maybe
we should move scripts/decodecode there as well, but that's something for
another day.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 tools/Makefile                  |  14 ++-
 tools/debugging/Makefile        |  16 +++
 tools/debugging/kernel-chktaint | 202 ++++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+), 6 deletions(-)
 create mode 100644 tools/debugging/Makefile
 create mode 100755 tools/debugging/kernel-chktaint

diff --git a/tools/Makefile b/tools/Makefile
index abb358a70ad0..c0d1e59f5abb 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -12,6 +12,7 @@ help:
 	@echo '  acpi                   - ACPI tools'
 	@echo '  cgroup                 - cgroup tools'
 	@echo '  cpupower               - a tool for all things x86 CPU power'
+	@echo '  debugging              - tools for debugging'
 	@echo '  firewire               - the userspace part of nosy, an IEEE-1394 traffic sniffer'
 	@echo '  freefall               - laptop accelerometer program for disk protection'
 	@echo '  gpio                   - GPIO tools'
@@ -60,7 +61,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup firewire hv guest spi usb virtio vm bpf iio gpio objtool leds wmi pci: FORCE
+cgroup firewire hv guest spi usb virtio vm bpf iio gpio objtool leds wmi pci debugging: FORCE
 	$(call descend,$@)
 
 liblockdep: FORCE
@@ -95,7 +96,8 @@ kvm_stat: FORCE
 all: acpi cgroup cpupower gpio hv firewire liblockdep \
 		perf selftests spi turbostat usb \
 		virtio vm bpf x86_energy_perf_policy \
-		tmon freefall iio objtool kvm_stat wmi pci
+		tmon freefall iio objtool kvm_stat wmi \
+		pci debugging
 
 acpi_install:
 	$(call descend,power/$(@:_install=),install)
@@ -103,7 +105,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-cgroup_install firewire_install gpio_install hv_install iio_install perf_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install:
+cgroup_install firewire_install gpio_install hv_install iio_install perf_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install:
 	$(call descend,$(@:_install=),install)
 
 liblockdep_install:
@@ -129,7 +131,7 @@ install: acpi_install cgroup_install cpupower_install gpio_install \
 		perf_install selftests_install turbostat_install usb_install \
 		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
-		wmi_install pci_install
+		wmi_install pci_install debugging_install
 
 acpi_clean:
 	$(call descend,power/acpi,clean)
@@ -137,7 +139,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-cgroup_clean hv_clean firewire_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean:
+cgroup_clean hv_clean firewire_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean debugging_clean:
 	$(call descend,$(@:_clean=),clean)
 
 liblockdep_clean:
@@ -175,6 +177,6 @@ clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean spi_clean usb_clean virtio_clean \
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean liblockdep_clean \
-		gpio_clean objtool_clean leds_clean wmi_clean pci_clean
+		gpio_clean objtool_clean leds_clean wmi_clean pci_clean debugging_clean
 
 .PHONY: FORCE
diff --git a/tools/debugging/Makefile b/tools/debugging/Makefile
new file mode 100644
index 000000000000..e2b7c1a6fb8f
--- /dev/null
+++ b/tools/debugging/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for debugging tools
+
+PREFIX ?= /usr
+BINDIR ?= bin
+INSTALL ?= install
+
+TARGET = kernel-chktaint
+
+all: $(TARGET)
+
+clean:
+
+install: kernel-chktaint
+	$(INSTALL) -D -m 755 $(TARGET) $(DESTDIR)$(PREFIX)/$(BINDIR)/$(TARGET)
+
diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
new file mode 100755
index 000000000000..2240cb56e6e5
--- /dev/null
+++ b/tools/debugging/kernel-chktaint
@@ -0,0 +1,202 @@
+#! /bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Randy Dunlap <rdunlap@infradead.org>, 2018
+# Thorsten Leemhuis <linux@leemhuis.info>, 2018
+
+usage()
+{
+	cat <<EOF
+usage: ${0##*/}
+       ${0##*/} <int>
+
+Call without parameters to decode /proc/sys/kernel/tainted.
+
+Call with a positive integer as parameter to decode a value you
+retrieved from /proc/sys/kernel/tainted on another system.
+
+EOF
+}
+
+if [ "$1"x != "x" ]; then
+	if  [ "$1"x == "--helpx" ] || [ "$1"x == "-hx" ] ; then
+		usage
+		exit 1
+	elif  [ $1 -ge 0 ] 2>/dev/null ; then
+		taint=$1
+	else
+		echo "Error: Parameter '$1' not a positive interger. Aborting." >&2
+		exit 1
+	fi
+else
+	TAINTFILE="/proc/sys/kernel/tainted"
+	if [ ! -r $TAINTFILE ]; then
+		echo "No file: $TAINTFILE"
+		exit
+	fi
+
+	taint=`cat $TAINTFILE`
+fi
+
+if [ $taint -eq 0 ]; then
+	echo "Kernel not Tainted"
+	exit
+else
+	echo "Kernel is \"tainted\" for the following reasons:"
+fi
+
+T=$taint
+out=
+
+addout() {
+	out=$out$1
+}
+
+if [ `expr $T % 2` -eq 0 ]; then
+	addout "G"
+else
+	addout "P"
+	echo " * proprietary module was loaded (#0)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "F"
+	echo " * module was force loaded (#1)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "S"
+	echo " * SMP kernel oops on an officially SMP incapable processor (#2)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "R"
+	echo " * module was force unloaded (#3)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "M"
+	echo " * processor reported a Machine Check Exception (MCE) (#4)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "B"
+	echo " * bad page referenced or some unexpected page flags (#5)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "U"
+	echo " * taint requested by userspace application (#6)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "D"
+	echo " * kernel died recently, i.e. there was an OOPS or BUG (#7)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "A"
+	echo " * an ACPI table was overridden by user (#8)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "W"
+	echo " * kernel issued warning (#9)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "C"
+	echo " * staging driver was loaded (#10)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "I"
+	echo " * workaround for bug in platform firmware applied (#11)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "O"
+	echo " * externally-built ('out-of-tree') module was loaded  (#12)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "E"
+	echo " * unsigned module was loaded (#13)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "L"
+	echo " * soft lockup occurred (#14)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "K"
+	echo " * kernel has been live patched (#15)"
+fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "X"
+	echo " * auxiliary taint, defined for and used by distros (#16)"
+
+fi
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "T"
+	echo " * kernel was built with the struct randomization plugin (#17)"
+fi
+
+echo "For a more detailed explanation of the various taint flags see"
+echo " Documentation/admin-guide/tainted-kernels.rst in the the Linux kernel sources"
+echo " or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"
+echo "Raw taint value as int/string: $taint/'$out'"
+#EOF#
-- 
2.20.1

