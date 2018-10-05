Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D448DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4DD208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4DD208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbeJEX6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:58:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45292 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbeJEX6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:58:34 -0400
Received: by mail-ot1-f65.google.com with SMTP id u22so13319911ota.12;
        Fri, 05 Oct 2018 09:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XljLqX9eXIuRQosUM4KeYlmmSjpyha1rYixAv1GAi7w=;
        b=r24DWzeFYwRTkESPr88ylKRYmTGpJTkBPL35QWTykWQDw9ilqw0V0r7BzXfZUM/jme
         l5kSxbTocGyIIHzC+jK2ZD0j8aPcFmcFOEVRkBK2tj8itRAYwbMDsGjo4+DU2/PNcXQh
         XSVB/rjyfTCmUbEmidJwoTv+F9+5Eyzk0JvICBCpXOc0w/LTbTZGTe7jFauKT5E/ab3n
         UZMQ8wNtrTh+cdP4QgbNrXOhgJ2GC+a+Z9ztS1eKuGoA6kPXBAjC8jZEH7bxtrs8qviF
         Fvk191YSdQD+AJTy0JDaSw3jf+H/2yU1Ht5yrkWK+ul2U7d2IQMiMoLxNQK9nTSkrqQw
         2wpQ==
X-Gm-Message-State: ABuFfoggLUTFaVSX2TkBcN7u4uJm6MtS+ORDawDOSDveJOIdRAvi8U0o
        9LHBkpRC4Tzb5PomfIDELjqPzAvJDQ==
X-Google-Smtp-Source: ACcGV619SNVK+McwRQAIJpBNhGG+LnSTDITEyXhEpl8W0rExapKdpQmE6EXbIfVvP/irfgPNq/nECA==
X-Received: by 2002:a9d:308d:: with SMTP id s13mr7263505otc.359.1538758739965;
        Fri, 05 Oct 2018 09:58:59 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:58:59 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc:     Grant Likely <glikely@secretlab.ca>,
        Kumar Gala <kumar.gala@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, Tom Rini <trini@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 07/36] kbuild: Add support for DT binding schema checks
Date:   Fri,  5 Oct 2018 11:58:19 -0500
Message-Id: <20181005165848.3474-8-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the build infrastructure for checking DT binding schema
documents and validating dts files using the binding schema.

Check DT binding schema documents:
make dt_binding_check

Build dts files and check using DT binding schema:
make dtbs_check

Currently, the validation targets are separate from a normal build to
avoid a hard dependency on the external DT schema project and because
there are lots of warnings generated.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-doc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .gitignore                                   |  1 +
 Documentation/Makefile                       |  2 +-
 Documentation/devicetree/bindings/.gitignore |  2 ++
 Documentation/devicetree/bindings/Makefile   | 30 ++++++++++++++++++++
 Makefile                                     |  8 +++++-
 scripts/Makefile.lib                         | 24 ++++++++++++++--
 6 files changed, 63 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/.gitignore
 create mode 100644 Documentation/devicetree/bindings/Makefile

diff --git a/.gitignore b/.gitignore
index 97ba6b79834c..a20ac26aa2f5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -15,6 +15,7 @@
 *.bin
 *.bz2
 *.c.[012]*.*
+*.dt.yaml
 *.dtb
 *.dtb.S
 *.dwo
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2ca77ad0f238..9786957c6a35 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Sphinx documentation
 #
 
-subdir-y :=
+subdir-y := devicetree/bindings/
 
 # You can set these variables from the command line.
 SPHINXBUILD   = sphinx-build
diff --git a/Documentation/devicetree/bindings/.gitignore b/Documentation/devicetree/bindings/.gitignore
new file mode 100644
index 000000000000..7e47316f1d7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/.gitignore
@@ -0,0 +1,2 @@
+*.example.dts
+*.yaml.tmp
diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
new file mode 100644
index 000000000000..b57f0dec3fab
--- /dev/null
+++ b/Documentation/devicetree/bindings/Makefile
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0
+DT_DOC_CHECKER ?= dt-doc-validate
+DT_EXTRACT_EX ?= dt-extract-example
+
+quiet_cmd_chk_binding = CHKDT   $<
+      cmd_chk_binding = (set -e; \
+                         $(DT_DOC_CHECKER) $< ; \
+                         mkdir -p $(dir $@) ; \
+                         $(DT_EXTRACT_EX) $< > $@ )
+
+$(obj)/%.example.dts: $(src)/%.yaml FORCE
+	$(call if_changed,chk_binding)
+
+DT_MK_SCHEMA ?= dt-mk-schema
+DT_TMP_SCHEMA := .schema.yaml.tmp
+extra-y += $(DT_TMP_SCHEMA)
+
+quiet_cmd_mk_schema = SCHEMA  $@
+      cmd_mk_schema = mkdir -p $(obj); \
+                      $(DT_MK_SCHEMA) -o $@ $(srctree)/$(src)
+
+DT_DOCS = $(shell cd $(srctree)/$(src) && find * -name '*.yaml')
+DTS_EXAMPLES = $(patsubst %.yaml,%.example.dts, $(DT_DOCS))
+extra-y += $(DTS_EXAMPLES)
+
+DTBS = $(patsubst %.yaml,%.example.dtb, $(DT_DOCS))
+extra-y += $(DTBS)
+
+$(obj)/$(DT_TMP_SCHEMA): $(addprefix $(obj)/, $(DTBS)) FORCE
+	$(call if_changed,mk_schema)
diff --git a/Makefile b/Makefile
index 021e274c4b03..648f7238e883 100644
--- a/Makefile
+++ b/Makefile
@@ -1227,10 +1227,13 @@ ifneq ($(dtstree),)
 %.dtb: prepare3 scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
 
-PHONY += dtbs dtbs_install
+PHONY += dtbs dtbs_install dt_binding_check
 dtbs: prepare3 scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree)
 
+dtbs_check: prepare3 dt_binding_check
+	$(Q)$(MAKE) $(build)=$(dtstree) CHECK_DTBS=1
+
 dtbs_install:
 	$(Q)$(MAKE) $(dtbinst)=$(dtstree)
 
@@ -1244,6 +1247,9 @@ PHONY += scripts_dtc
 scripts_dtc: scripts_basic
 	$(Q)$(MAKE) $(build)=scripts/dtc
 
+dt_binding_check: scripts_dtc
+	$(Q)$(MAKE) $(build)=Documentation/devicetree/bindings
+
 # ---------------------------------------------------------------------------
 # Modules
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 8fe4468f9bda..d1c5630ba24c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -61,6 +61,11 @@ real-obj-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))
 extra-y				+= $(dtb-y)
 extra-$(CONFIG_OF_ALL_DTBS)	+= $(dtb-)
 
+ifneq ($(CHECK_DTBS),)
+extra-y += $(patsubst %.dtb,%.dt.yaml, $(dtb-y))
+extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtb,%.dt.yaml, $(dtb-))
+endif
+
 # Add subdir path
 
 extra-y		:= $(addprefix $(obj)/,$(extra-y))
@@ -284,13 +289,28 @@ $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
 quiet_cmd_dtc = DTC     $@
 cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
-	$(DTC) -O dtb -o $@ -b 0 \
+	$(DTC) -O $(2) -o $@ -b 0 \
 		$(addprefix -i,$(dir $<) $(DTC_INCLUDE)) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
 	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
 
 $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
-	$(call if_changed_dep,dtc)
+	$(call if_changed_dep,dtc,dtb)
+
+DT_CHECKER ?= dt-validate
+DT_BINDING_DIR := Documentation/devicetree/bindings
+DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/.schema.yaml.tmp
+
+quiet_cmd_dtb_check =	CHECK  $@
+      cmd_dtb_check =	$(DT_CHECKER) -p $(DT_TMP_SCHEMA) $@ ;
+
+define rule_dtc_dt_yaml
+	$(call cmd_and_fixdep,dtc,yaml)		\
+	$(call echo-cmd,dtb_check) $(cmd_dtb_check)
+endef
+
+$(obj)/%.dt.yaml: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
+	$(call if_changed_rule,dtc_dt_yaml)
 
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 
-- 
2.17.1

