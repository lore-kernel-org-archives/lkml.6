Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9537C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A187C21A34
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A187C21A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbeHFQqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:46:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731523AbeHFQqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:46:40 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76ETt4C077614
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 10:37:16 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kpqp8hpd5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 10:37:16 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 6 Aug 2018 15:37:14 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 15:37:11 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w76EbAvJ37355730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 14:37:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 130154C059;
        Mon,  6 Aug 2018 17:37:20 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEE404C04E;
        Mon,  6 Aug 2018 17:37:19 +0100 (BST)
Received: from localhost (unknown [9.152.212.144])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Aug 2018 17:37:19 +0100 (BST)
Date:   Mon, 6 Aug 2018 16:37:09 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 1/1] kbuild: allow alternate src for target's implicit
 prerequisite
References: <cover.thread-dc1802.your-ad-here.call-01533563120-ext-8550@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-dc1802.your-ad-here.call-01533563120-ext-8550@work.hours>
X-TM-AS-GCONF: 00
x-cbid: 18080614-0020-0000-0000-000002B1FBEE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080614-0021-0000-0000-000020FE3DD3
Message-Id: <patch-1.thread-dc1802.git-dc180286abb1.your-ad-here.call-01533563120-ext-8550@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=607 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With kbuild there is no easy way to re-compile source files from another
directory, which is required for the decompressor on some platforms
(files like lib/ctype.c, lib/cmdline.c, etc). Writing custom build
rules for those files is not feasible since original rules are complex
and kbuild functions and variables are not exposed.

The simplest solution is to reverse include source files either into
existing files or separate files. That eliminates the need to tackle
with the kbuild rules, but is ugly.

Here is another solution to that problem, utilizing secondary expansion.
Build rules are in a form:
$(obj)/%.o: $(src)/%.c ...
$(obj)/%.o: $(src)/%.S ...

"src" variable could be changed to cover the need of specifying alternate
source file directory.
src := $(if $(SRCDIR_$(@F)),$(SRCDIR_$(@F)),$(src))

So, if there is SRCDIR_<target> set, it will be used, original "src" is
used otherwise. But that wouldn't work as it is. To be able to utilize
automatic variables in implicit prerequisite secondary expansion has to
be used and src value has to be additionally escaped.

Alternate src dir then could be specified in Makefile as:
obj-y := file1.o file2.o
SRCDIR_file1.o := file1/src/dir
SRCDIR_file2.o := file2/src/dir

Which is enough to build $(obj)/file1.o from file1/src/dir/file1.(c|S),
and $(obj)/file2.o from file2/src/dir/file2.(c|S)

Secondary expansion has been introduced with make 3.81, which is
minimal supported version by kbuild itself.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 scripts/Makefile.build | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 514ed63ff571..97c6ece96cfb 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -70,6 +70,10 @@ $(warning kbuild: Makefile.build is included improperly)
 endif
 
 # ===========================================================================
+# Allow to specify alternate source directory of target's implicit prerequisite
+# e.g. 'SRCDIR_cmdline.o := lib'
+.SECONDEXPANSION:
+srcdir := $$(if $$(SRCDIR_$$(@F)),$$(SRCDIR_$$(@F)),$(src))
 
 ifneq ($(strip $(lib-y) $(lib-m) $(lib-)),)
 lib-target := $(obj)/lib.a
@@ -134,13 +138,13 @@ $(obj-m)             : quiet_modtag := [M]
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
 cmd_cc_s_c       = $(CC) $(c_flags) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
 
-$(obj)/%.s: $(src)/%.c FORCE
+$(obj)/%.s: $(srcdir)/%.c FORCE
 	$(call if_changed_dep,cc_s_c)
 
 quiet_cmd_cpp_i_c = CPP $(quiet_modtag) $@
 cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<
 
-$(obj)/%.i: $(src)/%.c FORCE
+$(obj)/%.i: $(srcdir)/%.c FORCE
 	$(call if_changed_dep,cpp_i_c)
 
 # These mirror gensymtypes_S and co below, keep them in synch.
@@ -157,7 +161,7 @@ cmd_cc_symtypes_c =                                                         \
     $(call cmd_gensymtypes_c,true,$@) >/dev/null;                           \
     test -s $@ || rm -f $@
 
-$(obj)/%.symtypes : $(src)/%.c FORCE
+$(obj)/%.symtypes : $(srcdir)/%.c FORCE
 	$(call cmd,cc_symtypes_c)
 
 # LLVM assembly
@@ -165,7 +169,7 @@ $(obj)/%.symtypes : $(src)/%.c FORCE
 quiet_cmd_cc_ll_c = CC $(quiet_modtag)  $@
       cmd_cc_ll_c = $(CC) $(c_flags) -emit-llvm -S -o $@ $<
 
-$(obj)/%.ll: $(src)/%.c FORCE
+$(obj)/%.ll: $(srcdir)/%.c FORCE
 	$(call if_changed_dep,cc_ll_c)
 
 # C (.c) files
@@ -313,7 +317,7 @@ cmd_undef_syms = echo
 endif
 
 # Built-in and composite module parts
-$(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
+$(obj)/%.o: $(srcdir)/%.c $(recordmcount_source) $(objtool_dep) FORCE
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 
@@ -330,7 +334,7 @@ quiet_cmd_cc_lst_c = MKLST   $@
 		     $(CONFIG_SHELL) $(srctree)/scripts/makelst $*.o \
 				     System.map $(OBJDUMP) > $@
 
-$(obj)/%.lst: $(src)/%.c FORCE
+$(obj)/%.lst: $(srcdir)/%.c FORCE
 	$(call if_changed_dep,cc_lst_c)
 
 # Compile assembler sources (.S)
@@ -370,14 +374,14 @@ cmd_cc_symtypes_S =                                                         \
     $(call cmd_gensymtypes_S,true,$@) >/dev/null;                           \
     test -s $@ || rm -f $@
 
-$(obj)/%.symtypes : $(src)/%.S FORCE
+$(obj)/%.symtypes : $(srcdir)/%.S FORCE
 	$(call cmd,cc_symtypes_S)
 
 
 quiet_cmd_cpp_s_S = CPP $(quiet_modtag) $@
 cmd_cpp_s_S       = $(CPP) $(a_flags) -o $@ $<
 
-$(obj)/%.s: $(src)/%.S FORCE
+$(obj)/%.s: $(srcdir)/%.S FORCE
 	$(call if_changed_dep,cpp_s_S)
 
 quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
@@ -413,7 +417,7 @@ cmd_modversions_S =								\
 endif
 endif
 
-$(obj)/%.o: $(src)/%.S $(objtool_dep) FORCE
+$(obj)/%.o: $(srcdir)/%.S $(objtool_dep) FORCE
 	$(call if_changed_rule,as_o_S)
 
 targets += $(filter-out $(subdir-obj-y), $(real-obj-y)) $(real-obj-m) $(lib-y)
@@ -425,7 +429,7 @@ quiet_cmd_cpp_lds_S = LDS     $@
       cmd_cpp_lds_S = $(CPP) $(cpp_flags) -P -U$(ARCH) \
 	                     -D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ $<
 
-$(obj)/%.lds: $(src)/%.lds.S FORCE
+$(obj)/%.lds: $(srcdir)/%.lds.S FORCE
 	$(call if_changed_dep,cpp_lds_S)
 
 # ASN.1 grammar
@@ -434,7 +438,7 @@ quiet_cmd_asn1_compiler = ASN.1   $@
       cmd_asn1_compiler = $(objtree)/scripts/asn1_compiler $< \
 				$(subst .h,.c,$@) $(subst .c,.h,$@)
 
-$(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
+$(obj)/%.asn1.c $(obj)/%.asn1.h: $(srcdir)/%.asn1 $(objtree)/scripts/asn1_compiler
 	$(call cmd,asn1_compiler)
 
 # Build the compiled-in targets
-- 
2.18.0.13.gd42ae10

