Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E696C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB82220693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB82220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937285AbeFSD5i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 23:57:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:36061 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937237AbeFSD5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 23:57:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C5A08AB34;
        Tue, 19 Jun 2018 03:57:35 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Date:   Tue, 19 Jun 2018 13:57:26 +1000
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 3/5 - v2] kbuild: support building of per-directory mod.a
In-Reply-To: <152929772048.17463.15650870667867788917.stgit@noble>
References: <152929708853.17463.17302660556961083137.stgit@noble> <152929772048.17463.15650870667867788917.stgit@noble>
Message-ID: <87sh5je8d5.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


This patch allows a "mod.a" to be built in any
directory.  A previous patch allows that mod.a
to be included in any module or another mod.a.

This is achieved via a new pair of macros: modobj-y and modobj-m.

Anything in modobj-y is added to obj-y and is otherwise
ignored.
Anything listed in modobj-m is built, almost as though "modobj.o" was
a requested target.  The objects are then combined
into mod.a.
These objects are always built with part-of-module=3Dy.

This is sufficient to build a module from source in
multiple directories.  Each "other" directory lists
something like
 modobj-$(CONFIG_FOO) +=3D bar.o bar.o bat.o

and the main directory lists

 obj-$(CONFIG-FOO) =3D foo.o
 foo-y =3D other1/ ../friend/other2/ module.o

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

There was bug in the first version of this.
This line:
+targets +=3D $(filter-out $(subdir-obj-m) $(real-modobj-m), $(real-obj-m))
is now
+targets +=3D $(filter-out $(subdir-obj-m), $(real-modobj-m) $(real-obj-m))

Comma in the wrong place.

Thanks,
NeilBrown

 scripts/Makefile.build | 44 +++++++++++++++++++++++++++++++++-----------
 scripts/Makefile.lib   | 14 ++++++++++----
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 928cd073a657..8ac10348c131 100644
=2D-- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -15,6 +15,8 @@ obj-y :=3D
 obj-m :=3D
 lib-y :=3D
 lib-m :=3D
+modobj-y :=3D
+modobj-m :=3D
 always :=3D
 targets :=3D
 subdir-y :=3D
@@ -80,12 +82,16 @@ ifneq ($(strip $(real-obj-y) $(need-builtin)),)
 builtin-target :=3D $(obj)/built-in.a
 endif
=20
+ifneq ($(strip $(modobj-m)),)
+modobj-target :=3D $(obj)/mod.a
+endif
+
 modorder-target :=3D $(obj)/modules.order
=20
 # We keep a list of all modules in $(MODVERDIR)
=20
 __build: $(if $(KBUILD_BUILTIN),$(builtin-target) $(lib-target) $(extra-y)=
) \
=2D	 $(if $(KBUILD_MODULES),$(obj-m) $(modorder-target)) \
+	 $(if $(KBUILD_MODULES),$(obj-m) $(modorder-target) $(modobj-target))  \
 	 $(subdir-ym) $(always)
 	@:
=20
@@ -119,17 +125,19 @@ modkern_cflags =3D                                   =
       \
 		$(KBUILD_CFLAGS_KERNEL) $(CFLAGS_KERNEL))
 quiet_modtag :=3D $(empty)   $(empty)
=20
=2D$(real-obj-m)        : part-of-module :=3D y
=2D$(real-obj-m:.o=3D.i)  : part-of-module :=3D y
=2D$(real-obj-m:.o=3D.s)  : part-of-module :=3D y
=2D$(real-obj-m:.o=3D.lst): part-of-module :=3D y
+_mod_obj =3D $(real-obj-m) $(real-modobj-m)
+
+$(_mod_obj)        : part-of-module :=3D y
+$(_mod_obj:.o=3D.i)  : part-of-module :=3D y
+$(_mod_obj:.o=3D.s)  : part-of-module :=3D y
+$(_mod_obj:.o=3D.lst): part-of-module :=3D y
=20
=2D$(real-obj-m)        : quiet_modtag :=3D [M]
=2D$(real-obj-m:.o=3D.i)  : quiet_modtag :=3D [M]
=2D$(real-obj-m:.o=3D.s)  : quiet_modtag :=3D [M]
=2D$(real-obj-m:.o=3D.lst): quiet_modtag :=3D [M]
+$(_mod_obj)        : quiet_modtag :=3D [M]
+$(_mod_obj:.o=3D.i)  : quiet_modtag :=3D [M]
+$(_mod_obj:.o=3D.s)  : quiet_modtag :=3D [M]
+$(_mod_obj:.o=3D.lst): quiet_modtag :=3D [M]
=20
=2D$(obj-m)             : quiet_modtag :=3D [M]
+$(obj-m)           : quiet_modtag :=3D [M]
=20
 quiet_cmd_cc_s_c =3D CC $(quiet_modtag)  $@
 cmd_cc_s_c       =3D $(CC) $(c_flags) $(DISABLE_LTO) -fverbose-asm -S -o $=
@ $<
@@ -417,7 +425,7 @@ $(obj)/%.o: $(src)/%.S $(objtool_dep) FORCE
 	$(call if_changed_rule,as_o_S)
=20
 targets +=3D $(filter-out $(subdir-obj-y), $(real-obj-y))
=2Dtargets +=3D $(filter-out $(subdir-obj-m), $(real-obj-m))
+targets +=3D $(filter-out $(subdir-obj-m), $(real-modobj-m) $(real-obj-m))
 targets +=3D $(lib-y) $(extra-y) $(MAKECMDGOALS) $(always)
=20
 # Linker scripts preprocessor (.lds.S -> .lds)
@@ -508,6 +516,20 @@ targets +=3D $(obj)/lib-ksyms.o
=20
 endif
=20
+ifdef modobj-target
+
+quiet_cmd_ar_modobj =3D AR      $@
+      cmd_ar_modobj =3D rm -f $@; \
+                    $(AR) rcTP$(KBUILD_ARFLAGS) $@ $(filter $(real-modobj-=
m), $^)
+
+$(modobj-target): $(real-modobj-m) FORCE
+	$(call if_changed,ar_modobj)
+
+targets +=3D $(modobj-target)
+
+endif # modobj-target
+
+
 #
 # Rule to link composite objects
 #
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 6e7aa08324f0..c84167169a59 100644
=2D-- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -16,12 +16,13 @@ KBUILD_CFLAGS +=3D $(subdir-ccflags-y)
 # is exactly what happens for directories in obj-y. So move all
 # directories from obj-m to obj-y.  Then we will know that any directory
 # in real-obj-m is a component of some other object.
=2Dobj-y :=3D $(obj-y) $(filter %/, $(obj-m))
+obj-y :=3D $(obj-y) $(filter %/, $(obj-m)) $(filter-out $(obj-y), $(modobj=
-y))
 obj-m :=3D $(filter-out %/, $(obj-m))
=20
 # When an object is listed to be built compiled-in and modular,
 # only build the compiled-in version
 obj-m :=3D $(filter-out $(obj-y),$(obj-m))
+modobj-m :=3D $(filter-out $(obj-y), $(modobj-m))
=20
 # Libraries are always collected in one lib file.
 # Filter out objects already built-in
@@ -42,6 +43,7 @@ single-used-m :=3D $(sort $(filter-out $(multi-used-m),$(=
obj-m)))
 # including built-in.a from subdirectories
 real-obj-y :=3D $(foreach m, $(obj-y), $(if $(strip $($(m:.o=3D-objs)) $($=
(m:.o=3D-y))),$($(m:.o=3D-objs)) $($(m:.o=3D-y)),$(m)))
 real-obj-m :=3D $(foreach m, $(obj-m), $(if $(strip $($(m:.o=3D-objs)) $($=
(m:.o=3D-y)) $($(m:.o=3D-m))),$($(m:.o=3D-objs)) $($(m:.o=3D-y)) $($(m:.o=
=3D-m)),$(m)))
+real-modobj-m :=3D $(foreach m, $(modobj-m), $(if $(strip $($(m:.o=3D-objs=
)) $($(m:.o=3D-y)) $($(m:.o=3D-m))),$($(m:.o=3D-objs)) $($(m:.o=3D-y)) $($(=
m:.o=3D-m)),$(m)))
=20
 # Handle objects in subdirs
 # ------------------------------------------------------------------------=
---
@@ -53,8 +55,11 @@ __subdir-y	:=3D $(patsubst %/,%,$(filter %/, $(real-obj-=
y)))
 subdir-y	+=3D $(__subdir-y)
 __subdir-m	:=3D $(patsubst %/,%,$(filter %/, $(real-obj-m)))
 subdir-m	+=3D $(__subdir-m)
+__subdir-mo	:=3D $(patsubst %/,%,$(filter %/, $(real-modobj-m)))
+subdir-m	+=3D $(__subdir-mo)
 real-obj-y	:=3D $(patsubst %/, %/built-in.a, $(real-obj-y))
 real-obj-m	:=3D $(patsubst %/, %/mod.a, $(real-obj-m))
+real-modobj-m	:=3D $(patsubst %/, %/mod.a, $(real-modobj-m))
=20
 # Subdirectories we need to descend into
 subdir-ym	:=3D $(sort $(subdir-y) $(subdir-m))
@@ -62,9 +67,9 @@ subdir-ym	:=3D $(sort $(subdir-y) $(subdir-m))
 # $(subdir-obj-y) is the list of objects in $(real-obj-y) which uses dir/ =
to
 # tell kbuild to descend
 subdir-obj-y :=3D $(filter %/built-in.a, $(real-obj-y))
=2D# $(subdir-obj-m) is the list of objects in $(real-obj-m) which uses dir=
/ to
=2D# tell kbuild to descend
=2Dsubdir-obj-m :=3D $(filter %/mod.a, $(real-obj-m))
+# $(subdir-obj-m) is the list of objects in $(real-obj-m) and
+# $(real-modobj-m) which use dir/ to tell kbuild to descend
+subdir-obj-m :=3D $(filter %/mod.a, $(real-obj-m) $(real-modobj-m))
=20
 # DTB
 # If CONFIG_OF_ALL_DTBS is enabled, all DT blobs are built
@@ -83,6 +88,7 @@ subdir-obj-y	:=3D $(addprefix $(obj)/,$(subdir-obj-y))
 subdir-obj-m	:=3D $(addprefix $(obj)/,$(subdir-obj-m))
 real-obj-y	:=3D $(addprefix $(obj)/,$(real-obj-y))
 real-obj-m	:=3D $(addprefix $(obj)/,$(real-obj-m))
+real-modobj-m	:=3D $(addprefix $(obj)/,$(real-modobj-m))
 single-used-m	:=3D $(addprefix $(obj)/,$(single-used-m))
 multi-used-m	:=3D $(addprefix $(obj)/,$(multi-used-m))
 subdir-ym	:=3D $(addprefix $(obj)/,$(subdir-ym))
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsofycACgkQOeye3VZi
gbmDeg//eRZqtJCwLR9S28bE4yrVcof4p9koOYwKS/WwPYyJ2D4C123c4n3Sa6GY
Ay0Su1F0R/gFDMtzgXtZ3OEEeyx439Nt4+qxEFarSOx7QJs/VtBvrLBjrGc8DJB7
ZmIoHoetTkkD9OePb+wCaFJLlwl7x3sJ8+1Aoc19JmCwO/Sa/hHW0wlgGPe/n8jo
+pMb2rSobtzQO+0Ds7zvdPotAlvW7pjpiln2a03FJwT74luy8hm/T7TxX/mWQJyJ
jKDyNk3FNBgKgsm20oxl570q5nLRExLHdY19MvY168PpkwfyI8zBTO5g7MhobYzk
rZcIEPGdUXf3ugzCQT/DZBdcReUX/YxPLnID3fti+2b415O/butOT22D8u2cPkRh
b7WQSAfnHudKa++J6kfX0lL70RcJnam4Redaxo/Ca1OO0L3ozYXftuo8kF1mHPaO
usFH1x4h37M5/qwL87/bpu/lCHgeByiK2emT5lRLkl+T951xFWHqGteC99wlRwid
H5mC/kO2AMrwy7gcSq8lXa2SHvrTM7h82Tt1TOT4vz6m3JeI1zv44R5jcgkbLOe5
XhCdpXjcOIunVQd4HTl1Yb29ZMNlcjQcuVtnR3sSCxObmVGA8XOnu9S2IZS7yrhT
AGhmck4VEkvzKkbCG42PXqwEX1hXL3PuxhQxdrjFPWHE8+vAmjk=
=Mjrh
-----END PGP SIGNATURE-----
--=-=-=--
