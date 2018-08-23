Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F056C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C009D2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="G+AE8/I4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C009D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbeHWPYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:24:42 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:60178 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeHWPYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:24:42 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 86D8024E1F9D;
        Thu, 23 Aug 2018 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535025319; bh=+T5nke/ZRnOuqKt0LEhKQvOQyWBvTZiNvkY04p5nHuo=;
        h=From:To:Cc:Subject:Date:From;
        b=G+AE8/I4EPvx2OuPUTryWengWzOCNH4txqp+wU2EtyFUz6Xclt6cSz7zefSVLPq5y
         RNUARRSHg8NxD5UFW8PnC2LT6s33TYcO+XP3QG0eyZuj8lcoWo0wKNbVq5vlFPqbOV
         m45XlDEWevTJgbLpr/9ICOV8LvcIkgcZ0lWvKdDrGmyIfBnB380TWLxkel2snMAkTo
         +/f2CgUxBzxYAbKwkakUjOK/y8EHFF6xdw3LGg8l6L/vYuNmec5I8Xres26aplRWbs
         2by1Zx7niazZRTdVYvdrFZG+zAle7sdgYD9r+whxsWPGdEKqPzIc0S1wCqwRopZXEQ
         nRFUSRvqSEfqQ==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id F2A1D39F0;
        Thu, 23 Aug 2018 04:55:18 -0700 (PDT)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 63CF73E8D8;
        Thu, 23 Aug 2018 13:55:17 +0200 (CEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH] tools/pci: Change pcitest compiling process
Date:   Thu, 23 Aug 2018 13:55:15 +0200
Message-Id: <f543d460ccff7891aa08c744fb675eb2c11fb2e7.1535025221.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change tool compiling process in order to be build using the same
mechanism used in other linux tools (e.g. iio, perf, etc). This will
allow in future the buildroot tool to build and integrate this tool in
a more expeditious way.

Update documentation accordingly.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/PCI/endpoint/pci-test-howto.txt | 19 ++++++----
 tools/Makefile                                | 13 ++++---
 tools/pci/Build                               |  1 +
 tools/pci/Makefile                            | 53 +++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 14 deletions(-)
 create mode 100644 tools/pci/Build
 create mode 100644 tools/pci/Makefile

diff --git a/Documentation/PCI/endpoint/pci-test-howto.txt b/Documentation/PCI/endpoint/pci-test-howto.txt
index 75f48c3..16df733 100644
--- a/Documentation/PCI/endpoint/pci-test-howto.txt
+++ b/Documentation/PCI/endpoint/pci-test-howto.txt
@@ -98,17 +98,20 @@ Note that the devices listed here correspond to the value populated in 1.4 above
 2.2 Using Endpoint Test function Device
 
 pcitest.sh added in tools/pci/ can be used to run all the default PCI endpoint
-tests. Before pcitest.sh can be used pcitest.c should be compiled using the
-following commands.
+tests. To compile this tool the following commands should be used:
 
-	cd <kernel-dir>
-	make headers_install ARCH=arm
-	arm-linux-gnueabihf-gcc -Iusr/include tools/pci/pcitest.c -o pcitest
-	cp pcitest  <rootfs>/usr/sbin/
-	cp tools/pci/pcitest.sh <rootfs>
+	# cd <kernel-dir>
+	# make -C tools/pci
+
+or if you desire to compile and install in your system:
+
+	# cd <kernel-dir>
+	# make -C tools/pci install
+
+The tool and script will be located in <rootfs>/usr/bin/
 
 2.2.1 pcitest.sh Output
-	# ./pcitest.sh
+	# pcitest.sh
 	BAR tests
 
 	BAR0:           OKAY
diff --git a/tools/Makefile b/tools/Makefile
index be02c8b..abb358a 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -21,6 +21,7 @@ help:
 	@echo '  leds                   - LEDs  tools'
 	@echo '  liblockdep             - user-space wrapper for kernel locking-validator'
 	@echo '  bpf                    - misc BPF tools'
+	@echo '  pci                    - PCI tools'
 	@echo '  perf                   - Linux performance measurement and analysis tool'
 	@echo '  selftests              - various kernel selftests'
 	@echo '  spi                    - spi tools'
@@ -59,7 +60,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup firewire hv guest spi usb virtio vm bpf iio gpio objtool leds wmi: FORCE
+cgroup firewire hv guest spi usb virtio vm bpf iio gpio objtool leds wmi pci: FORCE
 	$(call descend,$@)
 
 liblockdep: FORCE
@@ -94,7 +95,7 @@ kvm_stat: FORCE
 all: acpi cgroup cpupower gpio hv firewire liblockdep \
 		perf selftests spi turbostat usb \
 		virtio vm bpf x86_energy_perf_policy \
-		tmon freefall iio objtool kvm_stat wmi
+		tmon freefall iio objtool kvm_stat wmi pci
 
 acpi_install:
 	$(call descend,power/$(@:_install=),install)
@@ -102,7 +103,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-cgroup_install firewire_install gpio_install hv_install iio_install perf_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install:
+cgroup_install firewire_install gpio_install hv_install iio_install perf_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install:
 	$(call descend,$(@:_install=),install)
 
 liblockdep_install:
@@ -128,7 +129,7 @@ install: acpi_install cgroup_install cpupower_install gpio_install \
 		perf_install selftests_install turbostat_install usb_install \
 		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
-		wmi_install
+		wmi_install pci_install
 
 acpi_clean:
 	$(call descend,power/acpi,clean)
@@ -136,7 +137,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-cgroup_clean hv_clean firewire_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean:
+cgroup_clean hv_clean firewire_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean:
 	$(call descend,$(@:_clean=),clean)
 
 liblockdep_clean:
@@ -174,6 +175,6 @@ clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean spi_clean usb_clean virtio_clean \
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean liblockdep_clean \
-		gpio_clean objtool_clean leds_clean wmi_clean
+		gpio_clean objtool_clean leds_clean wmi_clean pci_clean
 
 .PHONY: FORCE
diff --git a/tools/pci/Build b/tools/pci/Build
new file mode 100644
index 0000000..c375aea
--- /dev/null
+++ b/tools/pci/Build
@@ -0,0 +1 @@
+pcitest-y += pcitest.o
diff --git a/tools/pci/Makefile b/tools/pci/Makefile
new file mode 100644
index 0000000..46e4c2f
--- /dev/null
+++ b/tools/pci/Makefile
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../scripts/Makefile.include
+
+bindir ?= /usr/bin
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+endif
+
+# Do not use make's built-in rules
+# (this improves performance and avoids hard-to-debug behaviour);
+MAKEFLAGS += -r
+
+CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+
+ALL_TARGETS := pcitest pcitest.sh
+ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
+
+all: $(ALL_PROGRAMS)
+
+export srctree OUTPUT CC LD CFLAGS
+include $(srctree)/tools/build/Makefile.include
+
+#
+# We need the following to be outside of kernel tree
+#
+$(OUTPUT)include/linux/: ../../include/uapi/linux/
+	mkdir -p $(OUTPUT)include/linux/ 2>&1 || true
+	ln -sf $(CURDIR)/../../include/uapi/linux/pcitest.h $@
+
+prepare: $(OUTPUT)include/linux/
+
+PCITEST_IN := $(OUTPUT)pcitest-in.o
+$(PCITEST_IN): prepare FORCE
+	$(Q)$(MAKE) $(build)=pcitest
+$(OUTPUT)pcitest: $(PCITEST_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
+
+clean:
+	rm -f $(ALL_PROGRAMS)
+	rm -rf $(OUTPUT)include/
+	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+
+install: $(ALL_PROGRAMS)
+	install -d -m 755 $(DESTDIR)$(bindir);		\
+	for program in $(ALL_PROGRAMS); do		\
+		install $$program $(DESTDIR)$(bindir);	\
+	done
+
+FORCE:
+
+.PHONY: all install clean FORCE prepare
-- 
2.7.4

