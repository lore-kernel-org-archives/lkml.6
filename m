Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id O+NkNnwpGlvQGAAAmS7hNA
	; Fri, 08 Jun 2018 07:00:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C9437607DC; Fri,  8 Jun 2018 07:00:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D0193601C3;
	Fri,  8 Jun 2018 07:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0193601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeFHHAH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:00:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:35269 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751021AbeFHHAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:00:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77928AD5B;
        Fri,  8 Jun 2018 07:00:03 +0000 (UTC)
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>
Date: Fri, 08 Jun 2018 16:59:47 +1000
Cc: Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 10/11] staging: lustre: move ldlm into ptlrpc
In-Reply-To: <87sh5zlyf4.fsf@notabene.neil.brown.name>
References: <152826510267.16761.14361003167157833896.stgit@noble> <152826511923.16761.9237280635711887801.stgit@noble> <alpine.LFD.2.21.1806070546210.23188@casper.infradead.org> <87sh5zlyf4.fsf@notabene.neil.brown.name>
Message-ID: <87tvqdlq58.fsf@notabene.neil.brown.name>
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

On Thu, Jun 07 2018, NeilBrown wrote:

> On Thu, Jun 07 2018, James Simmons wrote:
>
>>> The ldlm code is built into the ptlrpc module, yet it lived in a
>>> separate directory.  This requires filename editing in the Makefile
>>> and make it difficult to e.g. build the .s file for code in ldlm.
>>>=20
>>> All the ldlm files have distinctive names so confusion from having
>>> ptlrpc and ldlm in the same directory is unlikely.  So move them all
>>> into ptlrpc.
>>
>> Nak. The reason is it would be nice to keep the directory structure.
>> What really needs to be done and Oleg has looked into it is to reduced
>> the number of modules created down to two, one for LNet and the other
>> lustre.ko. This also is a step in the right direction to remove the
>> create struct obd_ops and struct md_ops pointer madness. Well their
>> is the issue with obd echo client but we can deal with this at a later=20
>> date. Also the number of EXPORT_SYMBOLS and things will greatly reduce.
>
> Yeah, you are probably right.
> I had a bit of a look at how to build everything into a
> single module.  You can do with by having a single make
> file that lists parts from other directories - the same way
> that ptlrpc includes files from ldlm - but that is rather ugly.
>
> I've very nearly got it working using the lib-y infrastructure.
> I can build lnet as a single module, but the dependency calc isn't
> quite right so things happen in the wrong order.  The build
> fails the first time because some files don't exist, then
> succeeds on the second run.
> Hopefully I'll figure out how to make it work tomorrow.

I needed lots of changes over my original hack, but I think I have
it quite close now.
This is just a dump of what I have. It needs to be properly split up
and documented but I thought it would be useful for people do see how
I think this should be done.

Obviously there is a big change to non-lustre code here.  That might
take a bit of selling upstream, but I think it is worth trying.  We
aren't the only project that would benefit from this.

What I have done is created infrastructure so that a Makefile
can declare that some .o files are built for use in a module and
placed in "mod.a".  Then another Makefile can declare that a module
includes mod.a from some other directory.
So now lustre/lnet and lustre/lustre each have a module.c and build a
mod.a from various subdirectories, and combine these into a single
module.

As yet this is only compile tested.  I suspect it will work, but I won't
find out until next week.

NeilBrown


diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 8bdb1dc4072c..9ae14ecb1e32 100644
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
+	 $(if $(KBUILD_MODULES),$(obj-m) $(modobj-target) $(modorder-target)) \
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
@@ -508,6 +516,22 @@ targets +=3D $(obj)/lib-ksyms.o
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
+# to build a mod.a, build the directory
+$(filter %/mod.a, $(modobj-m)) : %/mod.a : %
+
+endif # modobj-target
+
 #
 # Rule to link composite objects
 #
@@ -525,7 +549,7 @@ $($(subst $(obj)/,,$(@:.o=3D-y)))       \
 $($(subst $(obj)/,,$(@:.o=3D-m)))), $^)
=20
 quiet_cmd_link_multi-m =3D LD [M]  $@
=2Dcmd_link_multi-m =3D $(LD) $(ld_flags) -r -o $@ $(link_multi_deps) $(cmd=
_secanalysis)
+cmd_link_multi-m =3D $(LD) $(ld_flags) -r -o $@ $(patsubst %/mod.a, --whol=
e-archive %/mod.a --no-whole-archive , $(link_multi_deps)) $(cmd_secanalysi=
s)
=20
 $(multi-used-m): FORCE
 	$(call if_changed,link_multi-m)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5af34a2b0cd9..315590b841b6 100644
=2D-- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -12,9 +12,13 @@ KBUILD_CFLAGS +=3D $(subdir-ccflags-y)
 # Figure out what we need to build from the various variables
 # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
=20
+# objects in modobj-y are treated identically to obj-y
+obj-y :=3D $(obj-y) $(filter-out $(modobj-y), $(obj-y))
+
 # When an object is listed to be built compiled-in and modular,
 # only build the compiled-in version
 obj-m :=3D $(filter-out $(obj-y),$(obj-m))
+modobj-m :=3D $(filter-out $(obj-m), $(modobj-m))
=20
 # Libraries are always collected in one lib file.
 # Filter out objects already built-in
@@ -31,12 +35,17 @@ modorder	:=3D $(patsubst %/,%/modules.order, $(filter %=
/, $(obj-y)) $(obj-m:.o=3D.ko
 #   and add the directory to the list of dirs to descend into: $(subdir-y)
 # o if we encounter foo/ in $(obj-m), remove it from $(obj-m)
 #   and add the directory to the list of dirs to descend into: $(subdir-m)
+# o if we encounter foo/ in $(modobj-m), replace it by foo/mod.a
+#   and add the directory to the list of dirs to descend into: $(subdir-m)
 __subdir-y	:=3D $(patsubst %/,%,$(filter %/, $(obj-y)))
 subdir-y	+=3D $(__subdir-y)
 __subdir-m	:=3D $(patsubst %/,%,$(filter %/, $(obj-m)))
 subdir-m	+=3D $(__subdir-m)
+__subdir-m	:=3D $(patsubst %/,%,$(filter %/, $(modobj-m)))
+subdir-m	+=3D $(__subdir-m)
 obj-y		:=3D $(patsubst %/, %/built-in.a, $(obj-y))
 obj-m		:=3D $(filter-out %/, $(obj-m))
+modobj-m	:=3D $(patsubst %/, %/mod.a, $(modobj-m))
=20
 # Subdirectories we need to descend into
 subdir-ym	:=3D $(sort $(subdir-y) $(subdir-m))
@@ -48,13 +57,15 @@ multi-used   :=3D $(multi-used-y) $(multi-used-m)
 single-used-m :=3D $(sort $(filter-out $(multi-used-m),$(obj-m)))
=20
 # $(subdir-obj-y) is the list of objects in $(obj-y) which uses dir/ to
=2D# tell kbuild to descend
+# tell kbuild to descend.  Similarly $(subdir-modobj-m) for $(modobj-m)
 subdir-obj-y :=3D $(filter %/built-in.a, $(obj-y))
+subdir-modobj-m :=3D $(filter %/mod.a, $(modobj-m))
=20
 # Replace multi-part objects by their individual parts,
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
 # DTB
 # If CONFIG_OF_ALL_DTBS is enabled, all DT blobs are built
@@ -68,10 +79,12 @@ always		:=3D $(addprefix $(obj)/,$(always))
 targets		:=3D $(addprefix $(obj)/,$(targets))
 modorder	:=3D $(addprefix $(obj)/,$(modorder))
 obj-m		:=3D $(addprefix $(obj)/,$(obj-m))
+modobj-m	:=3D $(addprefix $(obj)/,$(modobj-m))
 lib-y		:=3D $(addprefix $(obj)/,$(lib-y))
 subdir-obj-y	:=3D $(addprefix $(obj)/,$(subdir-obj-y))
 real-obj-y	:=3D $(addprefix $(obj)/,$(real-obj-y))
 real-obj-m	:=3D $(addprefix $(obj)/,$(real-obj-m))
+real-modobj-m	:=3D $(addprefix $(obj)/,$(real-modobj-m))
 single-used-m	:=3D $(addprefix $(obj)/,$(single-used-m))
 multi-used-m	:=3D $(addprefix $(obj)/,$(multi-used-m))
 subdir-ym	:=3D $(addprefix $(obj)/,$(subdir-ym))
diff --git a/drivers/staging/lustre/include/linux/lnet/lib-lnet.h b/drivers=
/staging/lustre/include/linux/lnet/lib-lnet.h
index 973c17a1c4a1..916fb78fd833 100644
=2D-- a/drivers/staging/lustre/include/linux/lnet/lib-lnet.h
+++ b/drivers/staging/lustre/include/linux/lnet/lib-lnet.h
@@ -76,6 +76,14 @@ extern struct lnet the_lnet;	/* THE network */
 #define LNET_ACCEPTOR_MIN_RESERVED_PORT    512
 #define LNET_ACCEPTOR_MAX_RESERVED_PORT    1023
=20
+int libcfs_init(void);
+int ko2iblnd_init(void);
+int ksocklnd_init(void);
+
+void libcfs_exit(void);
+void ko2iblnd_exit(void);
+void ksocklnd_exit(void);
+
 static inline int lnet_is_route_alive(struct lnet_route *route)
 {
 	/* gateway is down */
diff --git a/drivers/staging/lustre/lnet/Makefile b/drivers/staging/lustre/=
lnet/Makefile
index 0a380fe88ce8..058243c7a080 100644
=2D-- a/drivers/staging/lustre/lnet/Makefile
+++ b/drivers/staging/lustre/lnet/Makefile
@@ -1 +1,10 @@
=2Dobj-$(CONFIG_LNET) +=3D libcfs/ lnet/ klnds/ selftest/
+# SPDX-License-Identifier: GPL-2.0
+
+subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
+subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include
+
+obj-$(CONFIG_LNET) +=3D selftest/
+modobj-$(CONFIG_LNET) +=3D libcfs/ lnet/ klnds/
+
+obj-$(CONFIG_LNET) +=3D lnet.o
+lnet-objs =3D module.o mod.a
diff --git a/drivers/staging/lustre/lnet/klnds/Makefile b/drivers/staging/l=
ustre/lnet/klnds/Makefile
index c23e4f67f837..79dd66a6a7a1 100644
=2D-- a/drivers/staging/lustre/lnet/klnds/Makefile
+++ b/drivers/staging/lustre/lnet/klnds/Makefile
@@ -1 +1 @@
=2Dobj-$(CONFIG_LNET) +=3D o2iblnd/  socklnd/
+modobj-$(CONFIG_LNET) +=3D o2iblnd/  socklnd/
diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/Makefile b/drivers/s=
taging/lustre/lnet/klnds/o2iblnd/Makefile
index 4affe1d79948..6a0eb81cccfe 100644
=2D-- a/drivers/staging/lustre/lnet/klnds/o2iblnd/Makefile
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/Makefile
@@ -1,5 +1,4 @@
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include
=20
=2Dobj-$(CONFIG_LNET_XPRT_IB) +=3D ko2iblnd.o
=2Dko2iblnd-y :=3D o2iblnd.o o2iblnd_cb.o o2iblnd_modparams.o
+modobj-$(CONFIG_LNET) :=3D o2iblnd.o o2iblnd_cb.o o2iblnd_modparams.o
diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c b/drivers/=
staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
index f0b4eb42bc1d..4098c4566fce 100644
=2D-- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
@@ -2921,15 +2921,13 @@ static struct lnet_lnd the_o2iblnd =3D {
 	.lnd_recv	=3D kiblnd_recv,
 };
=20
=2Dstatic void __exit ko2iblnd_exit(void)
+void __exit ko2iblnd_exit(void)
 {
 	lnet_unregister_lnd(&the_o2iblnd);
 }
=20
=2Dstatic int __init ko2iblnd_init(void)
+int __init ko2iblnd_init(void)
 {
=2D	int rc;
=2D
 	BUILD_BUG_ON(sizeof(struct kib_msg) > IBLND_MSG_SIZE);
 	BUILD_BUG_ON(offsetof(struct kib_msg,
 			  ibm_u.get.ibgm_rd.rd_frags[IBLND_MAX_RDMA_FRAGS])
@@ -2940,19 +2938,7 @@ static int __init ko2iblnd_init(void)
=20
 	kiblnd_tunables_init();
=20
=2D	rc =3D libcfs_setup();
=2D	if (rc)
=2D		return rc;
=2D
 	lnet_register_lnd(&the_o2iblnd);
=20
 	return 0;
 }
=2D
=2DMODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
=2DMODULE_DESCRIPTION("OpenIB gen2 LNet Network Driver");
=2DMODULE_VERSION("2.7.0");
=2DMODULE_LICENSE("GPL");
=2D
=2Dmodule_init(ko2iblnd_init);
=2Dmodule_exit(ko2iblnd_exit);
diff --git a/drivers/staging/lustre/lnet/klnds/socklnd/Makefile b/drivers/s=
taging/lustre/lnet/klnds/socklnd/Makefile
index a7da1abfc804..231e1ab5dcf8 100644
=2D-- a/drivers/staging/lustre/lnet/klnds/socklnd/Makefile
+++ b/drivers/staging/lustre/lnet/klnds/socklnd/Makefile
@@ -1,6 +1,4 @@
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include
=20
=2Dobj-$(CONFIG_LNET) +=3D ksocklnd.o
=2D
=2Dksocklnd-y :=3D socklnd.o socklnd_cb.o socklnd_proto.o socklnd_modparams=
.o socklnd_lib.o
+modobj-$(CONFIG_LNET) :=3D socklnd.o socklnd_cb.o socklnd_proto.o socklnd_=
modparams.o socklnd_lib.o
diff --git a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c b/drivers/=
staging/lustre/lnet/klnds/socklnd/socklnd.c
index f01b34ac1a53..d892bdef7133 100644
=2D-- a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
+++ b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
@@ -2875,12 +2875,12 @@ ksocknal_startup(struct lnet_ni *ni)
 	return -ENETDOWN;
 }
=20
=2Dstatic void __exit ksocklnd_exit(void)
+void __exit ksocklnd_exit(void)
 {
 	lnet_unregister_lnd(&the_ksocklnd);
 }
=20
=2Dstatic int __init ksocklnd_init(void)
+int __init ksocklnd_init(void)
 {
 	int rc;
=20
@@ -2903,19 +2903,7 @@ static int __init ksocklnd_init(void)
 	if (rc)
 		return rc;
=20
=2D	rc =3D libcfs_setup();
=2D	if (rc)
=2D		return rc;
=2D
 	lnet_register_lnd(&the_ksocklnd);
=20
 	return 0;
 }
=2D
=2DMODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
=2DMODULE_DESCRIPTION("TCP Socket LNet Network Driver");
=2DMODULE_VERSION("2.7.0");
=2DMODULE_LICENSE("GPL");
=2D
=2Dmodule_init(ksocklnd_init);
=2Dmodule_exit(ksocklnd_exit);
diff --git a/drivers/staging/lustre/lnet/libcfs/Makefile b/drivers/staging/=
lustre/lnet/libcfs/Makefile
index 6a1b232da495..6f169a7b35ae 100644
=2D-- a/drivers/staging/lustre/lnet/libcfs/Makefile
+++ b/drivers/staging/lustre/lnet/libcfs/Makefile
@@ -2,8 +2,6 @@
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include
=20
=2Dobj-$(CONFIG_LNET) +=3D libcfs.o
=2D
 libcfs-obj-y +=3D linux-tracefile.o linux-debug.o
 libcfs-obj-y +=3D linux-crypto.o
 libcfs-obj-y +=3D linux-crypto-adler.o
@@ -13,4 +11,4 @@ libcfs-obj-y +=3D libcfs_string.o hash.o
 libcfs-obj-$(CONFIG_SMP) +=3D libcfs_cpu.o
 libcfs-obj-y +=3D libcfs_mem.o libcfs_lock.o
=20
=2Dlibcfs-objs :=3D $(libcfs-obj-y)
+modobj-$(CONFIG_LNET) +=3D $(libcfs-obj-y)
diff --git a/drivers/staging/lustre/lnet/libcfs/module.c b/drivers/staging/=
lustre/lnet/libcfs/module.c
index 02c404c6738e..b4ec1ebabc6d 100644
=2D-- a/drivers/staging/lustre/lnet/libcfs/module.c
+++ b/drivers/staging/lustre/lnet/libcfs/module.c
@@ -688,7 +688,7 @@ int libcfs_setup(void)
 }
 EXPORT_SYMBOL(libcfs_setup);
=20
=2Dstatic int libcfs_init(void)
+int libcfs_init(void)
 {
 	int rc;
=20
@@ -700,7 +700,7 @@ static int libcfs_init(void)
 	return rc;
 }
=20
=2Dstatic void libcfs_exit(void)
+void libcfs_exit(void)
 {
 	int rc;
=20
@@ -720,11 +720,3 @@ static void libcfs_exit(void)
 	if (rc)
 		pr_err("LustreError: libcfs_debug_cleanup: %d\n", rc);
 }
=2D
=2DMODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
=2DMODULE_DESCRIPTION("Lustre helper library");
=2DMODULE_VERSION(LIBCFS_VERSION);
=2DMODULE_LICENSE("GPL");
=2D
=2Dmodule_init(libcfs_init);
=2Dmodule_exit(libcfs_exit);
diff --git a/drivers/staging/lustre/lnet/lnet/Makefile b/drivers/staging/lu=
stre/lnet/lnet/Makefile
index 0a9d70924fe0..f9f4eb125f6d 100644
=2D-- a/drivers/staging/lustre/lnet/lnet/Makefile
+++ b/drivers/staging/lustre/lnet/lnet/Makefile
@@ -2,9 +2,7 @@
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include
=20
=2Dobj-$(CONFIG_LNET) +=3D lnet.o
=2D
=2Dlnet-y :=3D api-ni.o config.o nidstrings.o net_fault.o		\
+modobj-$(CONFIG_LNET) :=3D api-ni.o config.o nidstrings.o net_fault.o		\
 	  lib-me.o lib-msg.o lib-eq.o lib-md.o lib-ptl.o	\
=2D	  lib-socket.o lib-move.o module.o lo.o			\
+	  lib-socket.o lib-move.o lo.o			\
 	  router.o router_proc.o acceptor.o peer.o
diff --git a/drivers/staging/lustre/lnet/lnet/module.c b/drivers/staging/lu=
stre/lnet/lnet/module.c
deleted file mode 100644
index 9d06664f0c17..000000000000
=2D-- a/drivers/staging/lustre/lnet/lnet/module.c
+++ /dev/null
@@ -1,239 +0,0 @@
=2D// SPDX-License-Identifier: GPL-2.0
=2D/*
=2D * GPL HEADER START
=2D *
=2D * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
=2D *
=2D * This program is free software; you can redistribute it and/or modify
=2D * it under the terms of the GNU General Public License version 2 only,
=2D * as published by the Free Software Foundation.
=2D *
=2D * This program is distributed in the hope that it will be useful, but
=2D * WITHOUT ANY WARRANTY; without even the implied warranty of
=2D * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
=2D * General Public License version 2 for more details (a copy is included
=2D * in the LICENSE file that accompanied this code).
=2D *
=2D * You should have received a copy of the GNU General Public License
=2D * version 2 along with this program; If not, see
=2D * http://www.gnu.org/licenses/gpl-2.0.html
=2D *
=2D * GPL HEADER END
=2D */
=2D/*
=2D * Copyright (c) 2004, 2010, Oracle and/or its affiliates. All rights re=
served.
=2D * Use is subject to license terms.
=2D *
=2D * Copyright (c) 2012, 2015, Intel Corporation.
=2D */
=2D/*
=2D * This file is part of Lustre, http://www.lustre.org/
=2D * Lustre is a trademark of Sun Microsystems, Inc.
=2D */
=2D
=2D#define DEBUG_SUBSYSTEM S_LNET
=2D
=2D#include <linux/lnet/lib-lnet.h>
=2D#include <uapi/linux/lnet/lnet-dlc.h>
=2D
=2Dstatic int config_on_load;
=2Dmodule_param(config_on_load, int, 0444);
=2DMODULE_PARM_DESC(config_on_load, "configure network at module load");
=2D
=2Dstatic struct mutex lnet_config_mutex;
=2D
=2Dstatic int
=2Dlnet_configure(void *arg)
=2D{
=2D	/* 'arg' only there so I can be passed to cfs_create_thread() */
=2D	int rc =3D 0;
=2D
=2D	mutex_lock(&lnet_config_mutex);
=2D
=2D	if (!the_lnet.ln_niinit_self) {
=2D		rc =3D try_module_get(THIS_MODULE);
=2D
=2D		if (rc !=3D 1)
=2D			goto out;
=2D
=2D		rc =3D LNetNIInit(LNET_PID_LUSTRE);
=2D		if (rc >=3D 0) {
=2D			the_lnet.ln_niinit_self =3D 1;
=2D			rc =3D 0;
=2D		} else {
=2D			module_put(THIS_MODULE);
=2D		}
=2D	}
=2D
=2Dout:
=2D	mutex_unlock(&lnet_config_mutex);
=2D	return rc;
=2D}
=2D
=2Dstatic int
=2Dlnet_unconfigure(void)
=2D{
=2D	int refcount;
=2D
=2D	mutex_lock(&lnet_config_mutex);
=2D
=2D	if (the_lnet.ln_niinit_self) {
=2D		the_lnet.ln_niinit_self =3D 0;
=2D		LNetNIFini();
=2D		module_put(THIS_MODULE);
=2D	}
=2D
=2D	mutex_lock(&the_lnet.ln_api_mutex);
=2D	refcount =3D the_lnet.ln_refcount;
=2D	mutex_unlock(&the_lnet.ln_api_mutex);
=2D
=2D	mutex_unlock(&lnet_config_mutex);
=2D	return !refcount ? 0 : -EBUSY;
=2D}
=2D
=2Dstatic int
=2Dlnet_dyn_configure(struct libcfs_ioctl_hdr *hdr)
=2D{
=2D	struct lnet_ioctl_config_data *conf =3D
=2D		(struct lnet_ioctl_config_data *)hdr;
=2D	int rc;
=2D
=2D	if (conf->cfg_hdr.ioc_len < sizeof(*conf))
=2D		return -EINVAL;
=2D
=2D	mutex_lock(&lnet_config_mutex);
=2D	if (!the_lnet.ln_niinit_self) {
=2D		rc =3D -EINVAL;
=2D		goto out_unlock;
=2D	}
=2D	rc =3D lnet_dyn_add_ni(LNET_PID_LUSTRE, conf);
=2Dout_unlock:
=2D	mutex_unlock(&lnet_config_mutex);
=2D
=2D	return rc;
=2D}
=2D
=2Dstatic int
=2Dlnet_dyn_unconfigure(struct libcfs_ioctl_hdr *hdr)
=2D{
=2D	struct lnet_ioctl_config_data *conf =3D
=2D		(struct lnet_ioctl_config_data *)hdr;
=2D	int rc;
=2D
=2D	if (conf->cfg_hdr.ioc_len < sizeof(*conf))
=2D		return -EINVAL;
=2D
=2D	mutex_lock(&lnet_config_mutex);
=2D	if (!the_lnet.ln_niinit_self) {
=2D		rc =3D -EINVAL;
=2D		goto out_unlock;
=2D	}
=2D	rc =3D lnet_dyn_del_ni(conf->cfg_net);
=2Dout_unlock:
=2D	mutex_unlock(&lnet_config_mutex);
=2D
=2D	return rc;
=2D}
=2D
=2Dstatic int
=2Dlnet_ioctl(struct notifier_block *nb,
=2D	   unsigned long cmd, void *vdata)
=2D{
=2D	int rc;
=2D	struct libcfs_ioctl_hdr *hdr =3D vdata;
=2D
=2D	switch (cmd) {
=2D	case IOC_LIBCFS_CONFIGURE: {
=2D		struct libcfs_ioctl_data *data =3D
=2D			(struct libcfs_ioctl_data *)hdr;
=2D
=2D		if (data->ioc_hdr.ioc_len < sizeof(*data)) {
=2D			rc =3D -EINVAL;
=2D		} else {
=2D			the_lnet.ln_nis_from_mod_params =3D data->ioc_flags;
=2D			rc =3D lnet_configure(NULL);
=2D		}
=2D		break;
=2D	}
=2D
=2D	case IOC_LIBCFS_UNCONFIGURE:
=2D		rc =3D lnet_unconfigure();
=2D		break;
=2D
=2D	case IOC_LIBCFS_ADD_NET:
=2D		rc =3D lnet_dyn_configure(hdr);
=2D		break;
=2D
=2D	case IOC_LIBCFS_DEL_NET:
=2D		rc =3D lnet_dyn_unconfigure(hdr);
=2D		break;
=2D
=2D	default:
=2D		/*
=2D		 * Passing LNET_PID_ANY only gives me a ref if the net is up
=2D		 * already; I'll need it to ensure the net can't go down while
=2D		 * I'm called into it
=2D		 */
=2D		rc =3D LNetNIInit(LNET_PID_ANY);
=2D		if (rc >=3D 0) {
=2D			rc =3D LNetCtl(cmd, hdr);
=2D			LNetNIFini();
=2D		}
=2D		break;
=2D	}
=2D	return notifier_from_ioctl_errno(rc);
=2D}
=2D
=2Dstatic struct notifier_block lnet_ioctl_handler =3D {
=2D	.notifier_call =3D lnet_ioctl,
=2D};
=2D
=2Dstatic int __init lnet_init(void)
=2D{
=2D	int rc;
=2D
=2D	mutex_init(&lnet_config_mutex);
=2D
=2D	rc =3D libcfs_setup();
=2D	if (rc)
=2D		return rc;
=2D
=2D	rc =3D lnet_lib_init();
=2D	if (rc) {
=2D		CERROR("lnet_lib_init: error %d\n", rc);
=2D		return rc;
=2D	}
=2D
=2D	rc =3D blocking_notifier_chain_register(&libcfs_ioctl_list,
=2D					      &lnet_ioctl_handler);
=2D	LASSERT(!rc);
=2D
=2D	if (config_on_load) {
=2D		/*
=2D		 * Have to schedule a separate thread to avoid deadlocking
=2D		 * in modload
=2D		 */
=2D		(void)kthread_run(lnet_configure, NULL, "lnet_initd");
=2D	}
=2D
=2D	return 0;
=2D}
=2D
=2Dstatic void __exit lnet_exit(void)
=2D{
=2D	int rc;
=2D
=2D	rc =3D blocking_notifier_chain_unregister(&libcfs_ioctl_list,
=2D						&lnet_ioctl_handler);
=2D	LASSERT(!rc);
=2D
=2D	lnet_lib_exit();
=2D}
=2D
=2DMODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
=2DMODULE_DESCRIPTION("Lustre Networking layer");
=2DMODULE_VERSION(LNET_VERSION);
=2DMODULE_LICENSE("GPL");
=2D
=2Dmodule_init(lnet_init);
=2Dmodule_exit(lnet_exit);
diff --git a/drivers/staging/lustre/lnet/module.c b/drivers/staging/lustre/=
lnet/module.c
new file mode 100644
index 000000000000..2a51ae6542fb
=2D-- /dev/null
+++ b/drivers/staging/lustre/lnet/module.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPL HEADER START
+ *
+ * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License version 2 for more details (a copy is included
+ * in the LICENSE file that accompanied this code).
+ *
+ * You should have received a copy of the GNU General Public License
+ * version 2 along with this program; If not, see
+ * http://www.gnu.org/licenses/gpl-2.0.html
+ *
+ * GPL HEADER END
+ */
+/*
+ * Copyright (c) 2004, 2010, Oracle and/or its affiliates. All rights rese=
rved.
+ * Use is subject to license terms.
+ *
+ * Copyright (c) 2012, 2015, Intel Corporation.
+ */
+/*
+ * This file is part of Lustre, http://www.lustre.org/
+ * Lustre is a trademark of Sun Microsystems, Inc.
+ */
+
+#define DEBUG_SUBSYSTEM S_LNET
+
+#include <linux/lnet/lib-lnet.h>
+#include <uapi/linux/lnet/lnet-dlc.h>
+
+static int config_on_load;
+module_param(config_on_load, int, 0444);
+MODULE_PARM_DESC(config_on_load, "configure network at module load");
+
+static struct mutex lnet_config_mutex;
+
+static int
+lnet_configure(void *arg)
+{
+	/* 'arg' only there so I can be passed to cfs_create_thread() */
+	int rc =3D 0;
+
+	mutex_lock(&lnet_config_mutex);
+
+	if (!the_lnet.ln_niinit_self) {
+		rc =3D try_module_get(THIS_MODULE);
+
+		if (rc !=3D 1)
+			goto out;
+
+		rc =3D LNetNIInit(LNET_PID_LUSTRE);
+		if (rc >=3D 0) {
+			the_lnet.ln_niinit_self =3D 1;
+			rc =3D 0;
+		} else {
+			module_put(THIS_MODULE);
+		}
+	}
+
+out:
+	mutex_unlock(&lnet_config_mutex);
+	return rc;
+}
+
+static int
+lnet_unconfigure(void)
+{
+	int refcount;
+
+	mutex_lock(&lnet_config_mutex);
+
+	if (the_lnet.ln_niinit_self) {
+		the_lnet.ln_niinit_self =3D 0;
+		LNetNIFini();
+		module_put(THIS_MODULE);
+	}
+
+	mutex_lock(&the_lnet.ln_api_mutex);
+	refcount =3D the_lnet.ln_refcount;
+	mutex_unlock(&the_lnet.ln_api_mutex);
+
+	mutex_unlock(&lnet_config_mutex);
+	return !refcount ? 0 : -EBUSY;
+}
+
+static int
+lnet_dyn_configure(struct libcfs_ioctl_hdr *hdr)
+{
+	struct lnet_ioctl_config_data *conf =3D
+		(struct lnet_ioctl_config_data *)hdr;
+	int rc;
+
+	if (conf->cfg_hdr.ioc_len < sizeof(*conf))
+		return -EINVAL;
+
+	mutex_lock(&lnet_config_mutex);
+	if (!the_lnet.ln_niinit_self) {
+		rc =3D -EINVAL;
+		goto out_unlock;
+	}
+	rc =3D lnet_dyn_add_ni(LNET_PID_LUSTRE, conf);
+out_unlock:
+	mutex_unlock(&lnet_config_mutex);
+
+	return rc;
+}
+
+static int
+lnet_dyn_unconfigure(struct libcfs_ioctl_hdr *hdr)
+{
+	struct lnet_ioctl_config_data *conf =3D
+		(struct lnet_ioctl_config_data *)hdr;
+	int rc;
+
+	if (conf->cfg_hdr.ioc_len < sizeof(*conf))
+		return -EINVAL;
+
+	mutex_lock(&lnet_config_mutex);
+	if (!the_lnet.ln_niinit_self) {
+		rc =3D -EINVAL;
+		goto out_unlock;
+	}
+	rc =3D lnet_dyn_del_ni(conf->cfg_net);
+out_unlock:
+	mutex_unlock(&lnet_config_mutex);
+
+	return rc;
+}
+
+static int
+lnet_ioctl(struct notifier_block *nb,
+	   unsigned long cmd, void *vdata)
+{
+	int rc;
+	struct libcfs_ioctl_hdr *hdr =3D vdata;
+
+	switch (cmd) {
+	case IOC_LIBCFS_CONFIGURE: {
+		struct libcfs_ioctl_data *data =3D
+			(struct libcfs_ioctl_data *)hdr;
+
+		if (data->ioc_hdr.ioc_len < sizeof(*data)) {
+			rc =3D -EINVAL;
+		} else {
+			the_lnet.ln_nis_from_mod_params =3D data->ioc_flags;
+			rc =3D lnet_configure(NULL);
+		}
+		break;
+	}
+
+	case IOC_LIBCFS_UNCONFIGURE:
+		rc =3D lnet_unconfigure();
+		break;
+
+	case IOC_LIBCFS_ADD_NET:
+		rc =3D lnet_dyn_configure(hdr);
+		break;
+
+	case IOC_LIBCFS_DEL_NET:
+		rc =3D lnet_dyn_unconfigure(hdr);
+		break;
+
+	default:
+		/*
+		 * Passing LNET_PID_ANY only gives me a ref if the net is up
+		 * already; I'll need it to ensure the net can't go down while
+		 * I'm called into it
+		 */
+		rc =3D LNetNIInit(LNET_PID_ANY);
+		if (rc >=3D 0) {
+			rc =3D LNetCtl(cmd, hdr);
+			LNetNIFini();
+		}
+		break;
+	}
+	return notifier_from_ioctl_errno(rc);
+}
+
+static struct notifier_block lnet_ioctl_handler =3D {
+	.notifier_call =3D lnet_ioctl,
+};
+
+static int __init lnet_init(void)
+{
+	int rc;
+
+	rc =3D libcfs_init();
+	if (rc)
+		return rc;
+
+	mutex_init(&lnet_config_mutex);
+
+	rc =3D libcfs_setup();
+	if (rc)
+		return rc;
+
+	rc =3D lnet_lib_init();
+	if (rc) {
+		CERROR("lnet_lib_init: error %d\n", rc);
+		return rc;
+	}
+
+	rc =3D blocking_notifier_chain_register(&libcfs_ioctl_list,
+					      &lnet_ioctl_handler);
+	LASSERT(!rc);
+
+	if (config_on_load) {
+		/*
+		 * Have to schedule a separate thread to avoid deadlocking
+		 * in modload
+		 */
+		(void)kthread_run(lnet_configure, NULL, "lnet_initd");
+	}
+
+	ko2iblnd_init();
+	ksocklnd_init();
+	return 0;
+}
+
+static void __exit lnet_exit(void)
+{
+	int rc;
+
+	ksocklnd_exit();
+	ko2iblnd_exit();
+
+	rc =3D blocking_notifier_chain_unregister(&libcfs_ioctl_list,
+						&lnet_ioctl_handler);
+	LASSERT(!rc);
+
+	lnet_lib_exit();
+
+	libcfs_exit();
+}
+
+MODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
+MODULE_DESCRIPTION("Lustre Networking layer");
+MODULE_VERSION(LNET_VERSION);
+MODULE_LICENSE("GPL");
+
+module_init(lnet_init);
+module_exit(lnet_exit);
diff --git a/drivers/staging/lustre/lustre/Makefile b/drivers/staging/lustr=
e/lustre/Makefile
index 331e4fcdd5a2..81eb4243afd3 100644
=2D-- a/drivers/staging/lustre/lustre/Makefile
+++ b/drivers/staging/lustre/lustre/Makefile
@@ -1,2 +1,11 @@
=2Dobj-$(CONFIG_LUSTRE_FS) +=3D obdclass/ ptlrpc/ fld/ osc/ mgc/ \
=2D			   fid/ lov/ mdc/ lmv/ llite/ obdecho/
+# SPDX-License-Identifier: GPL-2.0
+
+subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
+subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include
+
+modobj-$(CONFIG_LUSTRE_FS) +=3D obdclass/ ldlm/ ptlrpc/ fld/ osc/ mgc/ \
+			   fid/ lov/ mdc/ lmv/ llite/
+obj-$(CONFIG_LUSTRE_FS) +=3D obdecho/
+
+obj-$(CONFIG_LUSTRE_FS) +=3D lustre.o
+lustre-objs =3D module.o mod.a
diff --git a/drivers/staging/lustre/lustre/fid/Makefile b/drivers/staging/l=
ustre/lustre/fid/Makefile
index 77b65b92667d..c3f2c683c06e 100644
=2D-- a/drivers/staging/lustre/lustre/fid/Makefile
+++ b/drivers/staging/lustre/lustre/fid/Makefile
@@ -1,5 +1,4 @@
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include/
=20
=2Dobj-$(CONFIG_LUSTRE_FS) +=3D fid.o
=2Dfid-y :=3D fid_request.o fid_lib.o lproc_fid.o
+modobj-$(CONFIG_LUSTRE_FS) +=3D fid_request.o fid_lib.o lproc_fid.o
diff --git a/drivers/staging/lustre/lustre/fid/fid_request.c b/drivers/stag=
ing/lustre/lustre/fid/fid_request.c
index a34fd90ca5e5..0e8d92701204 100644
=2D-- a/drivers/staging/lustre/lustre/fid/fid_request.c
+++ b/drivers/staging/lustre/lustre/fid/fid_request.c
@@ -383,7 +383,7 @@ int client_fid_fini(struct obd_device *obd)
 }
 EXPORT_SYMBOL(client_fid_fini);
=20
=2Dstatic int __init fid_init(void)
+int __init fid_init(void)
 {
 	int rc;
=20
@@ -396,15 +396,7 @@ static int __init fid_init(void)
 	return 0;
 }
=20
=2Dstatic void __exit fid_exit(void)
+void __exit fid_exit(void)
 {
 	debugfs_remove_recursive(seq_debugfs_dir);
 }
=2D
=2DMODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
=2DMODULE_DESCRIPTION("Lustre File IDentifier");
=2DMODULE_VERSION(LUSTRE_VERSION_STRING);
=2DMODULE_LICENSE("GPL");
=2D
=2Dmodule_init(fid_init);
=2Dmodule_exit(fid_exit);
diff --git a/drivers/staging/lustre/lustre/fld/Makefile b/drivers/staging/l=
ustre/lustre/fld/Makefile
index 426deba8b815..37097a4421a0 100644
=2D-- a/drivers/staging/lustre/lustre/fld/Makefile
+++ b/drivers/staging/lustre/lustre/fld/Makefile
@@ -1,5 +1,4 @@
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include/
=20
=2Dobj-$(CONFIG_LUSTRE_FS) +=3D fld.o
=2Dfld-y :=3D fld_request.o fld_cache.o lproc_fld.o
+modobj-$(CONFIG_LUSTRE_FS) +=3D fld_request.o fld_cache.o lproc_fld.o
diff --git a/drivers/staging/lustre/lustre/fld/fld_request.c b/drivers/stag=
ing/lustre/lustre/fld/fld_request.c
index 97f7ea632346..21e7dbc65cd3 100644
=2D-- a/drivers/staging/lustre/lustre/fld/fld_request.c
+++ b/drivers/staging/lustre/lustre/fld/fld_request.c
@@ -419,7 +419,7 @@ void fld_client_flush(struct lu_client_fld *fld)
 	fld_cache_flush(fld->lcf_cache);
 }
=20
=2Dstatic int __init fld_init(void)
+int __init fld_init(void)
 {
 	int rc;
=20
@@ -432,15 +432,7 @@ static int __init fld_init(void)
 	return 0;
 }
=20
=2Dstatic void __exit fld_exit(void)
+void __exit fld_exit(void)
 {
 	debugfs_remove_recursive(fld_debugfs_dir);
 }
=2D
=2DMODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
=2DMODULE_DESCRIPTION("Lustre FID Location Database");
=2DMODULE_VERSION(LUSTRE_VERSION_STRING);
=2DMODULE_LICENSE("GPL");
=2D
=2Dmodule_init(fld_init)
=2Dmodule_exit(fld_exit)
diff --git a/drivers/staging/lustre/lustre/include/lustre_compat.h b/driver=
s/staging/lustre/lustre/include/lustre_compat.h
index 3c6db0d632dc..3e4343e4740a 100644
=2D-- a/drivers/staging/lustre/lustre/include/lustre_compat.h
+++ b/drivers/staging/lustre/lustre/include/lustre_compat.h
@@ -50,16 +50,6 @@
 #define current_ngroups current_cred()->group_info->ngroups
 #define current_groups current_cred()->group_info->small_block
=20
=2D/*
=2D * OBD need working random driver, thus all our
=2D * initialization routines must be called after device
=2D * driver initialization
=2D */
=2D#ifndef MODULE
=2D#undef module_init
=2D#define module_init(a)     late_initcall(a)
=2D#endif
=2D
 #define LTIME_S(time)		   (time.tv_sec)
=20
 #ifndef QUOTA_OK
diff --git a/drivers/staging/lustre/lustre/include/lustre_lib.h b/drivers/s=
taging/lustre/lustre/include/lustre_lib.h
index 87748e9902a7..16fa74caed37 100644
=2D-- a/drivers/staging/lustre/lustre/include/lustre_lib.h
+++ b/drivers/staging/lustre/lustre/include/lustre_lib.h
@@ -85,6 +85,25 @@ static inline int l_fatal_signal_pending(struct task_str=
uct *p)
=20
 /** @} lib */
=20
+int fid_init(void);
+int fld_init(void);
+int lmv_init(void);
+int lov_init(void);
+int mdc_init(void);
+int mgc_init(void);
+int obdclass_init(void);
+int osc_init(void);
+int ptlrpc_init(void);
+
+void fid_exit(void);
+void fld_exit(void);
+void lmv_exit(void);
+void lov_exit(void);
+void mdc_exit(void);
+void mgc_exit(void);
+void obdclass_exit(void);
+void osc_exit(void);
+void ptlrpc_exit(void);
=20
=20
 /* l_wait_event_abortable() is a bit like wait_event_killable()
diff --git a/drivers/staging/lustre/lustre/ldlm/Makefile b/drivers/staging/=
lustre/lustre/ldlm/Makefile
new file mode 100644
index 000000000000..7dc83d1f3416
=2D-- /dev/null
+++ b/drivers/staging/lustre/lustre/ldlm/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
+subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include
+
+ldlm_objs :=3D l_lock.o ldlm_lock.o
+ldlm_objs +=3D ldlm_resource.o ldlm_lib.o
+ldlm_objs +=3D ldlm_plain.o ldlm_extent.o
+ldlm_objs +=3D ldlm_request.o ldlm_lockd.o
+ldlm_objs +=3D ldlm_flock.o ldlm_inodebits.o
+ldlm_objs +=3D ldlm_pool.o
+
+modobj-$(CONFIG_LUSTRE_FS) +=3D $(ldlm_objs)
diff --git a/drivers/staging/lustre/lustre/llite/Makefile b/drivers/staging=
/lustre/lustre/llite/Makefile
index 5200924182ae..ec0877d8f65e 100644
=2D-- a/drivers/staging/lustre/lustre/llite/Makefile
+++ b/drivers/staging/lustre/lustre/llite/Makefile
@@ -2,7 +2,6 @@
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include
=20
=2Dobj-$(CONFIG_LUSTRE_FS) +=3D lustre.o
 lustre-y :=3D dcache.o dir.o file.o llite_lib.o llite_nfs.o \
 	    rw.o rw26.o namei.o symlink.o llite_mmap.o range_lock.o \
 	    xattr.o xattr_cache.o xattr_security.o \
@@ -11,3 +10,5 @@ lustre-y :=3D dcache.o dir.o file.o llite_lib.o llite_nfs=
.o \
 	    lproc_llite.o
=20
 lustre-$(CONFIG_FS_POSIX_ACL) +=3D acl.o
+
+modobj-$(CONFIG_LUSTRE_FS) +=3D $(lustre-y)
diff --git a/drivers/staging/lustre/lustre/llite/super25.c b/drivers/stagin=
g/lustre/lustre/llite/super25.c
index d335f29556c2..8f81ae4e6998 100644
=2D-- a/drivers/staging/lustre/lustre/llite/super25.c
+++ b/drivers/staging/lustre/lustre/llite/super25.c
@@ -81,9 +81,8 @@ struct super_operations lustre_super_operations =3D {
 	.remount_fs    =3D ll_remount_fs,
 	.show_options  =3D ll_show_options,
 };
=2DMODULE_ALIAS_FS("lustre");
=20
=2Dstatic int __init lustre_init(void)
+int __init lustre_init(void)
 {
 	int rc;
=20
@@ -164,7 +163,7 @@ static int __init lustre_init(void)
 	return rc;
 }
=20
=2Dstatic void __exit lustre_exit(void)
+void __exit lustre_exit(void)
 {
 	lustre_register_super_ops(NULL, NULL, NULL);
 	lustre_register_client_process_config(NULL);
@@ -179,11 +178,3 @@ static void __exit lustre_exit(void)
 	kmem_cache_destroy(ll_inode_cachep);
 	kmem_cache_destroy(ll_file_data_slab);
 }
=2D
=2DMODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
=2DMODULE_DESCRIPTION("Lustre Client File System");
=2DMODULE_VERSION(LUSTRE_VERSION_STRING);
=2DMODULE_LICENSE("GPL");
=2D
=2Dmodule_init(lustre_init);
=2Dmodule_exit(lustre_exit);
diff --git a/drivers/staging/lustre/lustre/lmv/Makefile b/drivers/staging/l=
ustre/lustre/lmv/Makefile
index 91c99114aa13..4fa01f085f2a 100644
=2D-- a/drivers/staging/lustre/lustre/lmv/Makefile
+++ b/drivers/staging/lustre/lustre/lmv/Makefile
@@ -1,5 +1,4 @@
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include
=20
=2Dobj-$(CONFIG_LUSTRE_FS) +=3D lmv.o
=2Dlmv-y :=3D lmv_obd.o lmv_intent.o lmv_fld.o lproc_lmv.o
+modobj-$(CONFIG_LUSTRE_FS) +=3D lmv_obd.o lmv_intent.o lmv_fld.o lproc_lmv=
.o
diff --git a/drivers/staging/lustre/lustre/lmv/lmv_obd.c b/drivers/staging/=
lustre/lustre/lmv/lmv_obd.c
index 65f94e6ecaad..17e825f54668 100644
=2D-- a/drivers/staging/lustre/lustre/lmv/lmv_obd.c
+++ b/drivers/staging/lustre/lustre/lmv/lmv_obd.c
@@ -3102,7 +3102,7 @@ static struct md_ops lmv_md_ops =3D {
 	.unpackmd		=3D lmv_unpackmd,
 };
=20
=2Dstatic int __init lmv_init(void)
+int __init lmv_init(void)
 {
 	struct lprocfs_static_vars lvars;
 	int rc;
@@ -3117,15 +3117,7 @@ static int __init lmv_init(void)
 				 LUSTRE_LMV_NAME, NULL);
 }
=20
=2Dstatic void lmv_exit(void)
+void lmv_exit(void)
 {
 	class_unregister_type(LUSTRE_LMV_NAME);
 }
=2D
=2DMODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
=2DMODULE_DESCRIPTION("Lustre Logical Metadata Volume");
=2DMODULE_VERSION(LUSTRE_VERSION_STRING);
=2DMODULE_LICENSE("GPL");
=2D
=2Dmodule_init(lmv_init);
=2Dmodule_exit(lmv_exit);
diff --git a/drivers/staging/lustre/lustre/lov/Makefile b/drivers/staging/l=
ustre/lustre/lov/Makefile
index 1ebf0193f61a..a4167566cee6 100644
=2D-- a/drivers/staging/lustre/lustre/lov/Makefile
+++ b/drivers/staging/lustre/lustre/lov/Makefile
@@ -2,8 +2,7 @@
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include
=20
=2Dobj-$(CONFIG_LUSTRE_FS) +=3D lov.o
=2Dlov-y :=3D lov_obd.o lov_pack.o lov_offset.o lov_merge.o \
+modobj-$(CONFIG_LUSTRE_FS) +=3D lov_obd.o lov_pack.o lov_offset.o lov_merg=
e.o \
 	 lov_request.o lov_ea.o lov_dev.o lov_object.o lov_page.o  \
 	 lov_lock.o lov_io.o lovsub_dev.o lovsub_object.o lovsub_page.o      \
 	 lovsub_lock.o lov_pool.o lproc_lov.o
diff --git a/drivers/staging/lustre/lustre/lov/lov_obd.c b/drivers/staging/=
lustre/lustre/lov/lov_obd.c
index 344ff4b20168..4b2ed026ccf1 100644
=2D-- a/drivers/staging/lustre/lustre/lov/lov_obd.c
+++ b/drivers/staging/lustre/lustre/lov/lov_obd.c
@@ -1388,7 +1388,7 @@ static struct obd_ops lov_obd_ops =3D {
=20
 struct kmem_cache *lov_oinfo_slab;
=20
=2Dstatic int __init lov_init(void)
+int __init lov_init(void)
 {
 	struct lprocfs_static_vars lvars =3D { NULL };
 	int rc;
@@ -1427,18 +1427,10 @@ static int __init lov_init(void)
 	return rc;
 }
=20
=2Dstatic void /*__exit*/ lov_exit(void)
+void /*__exit*/ lov_exit(void)
 {
 	class_unregister_type(LUSTRE_LOV_NAME);
 	kmem_cache_destroy(lov_oinfo_slab);
=20
 	lu_kmem_fini(lov_caches);
 }
=2D
=2DMODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
=2DMODULE_DESCRIPTION("Lustre Logical Object Volume");
=2DMODULE_LICENSE("GPL");
=2DMODULE_VERSION(LUSTRE_VERSION_STRING);
=2D
=2Dmodule_init(lov_init);
=2Dmodule_exit(lov_exit);
diff --git a/drivers/staging/lustre/lustre/mdc/Makefile b/drivers/staging/l=
ustre/lustre/mdc/Makefile
index c7bc3351ccb0..6ee93aa9e911 100644
=2D-- a/drivers/staging/lustre/lustre/mdc/Makefile
+++ b/drivers/staging/lustre/lustre/mdc/Makefile
@@ -1,5 +1,4 @@
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include
=20
=2Dobj-$(CONFIG_LUSTRE_FS) +=3D mdc.o
=2Dmdc-y :=3D mdc_request.o mdc_reint.o mdc_lib.o mdc_locks.o lproc_mdc.o
+modobj-$(CONFIG_LUSTRE_FS) +=3D mdc_request.o mdc_reint.o mdc_lib.o mdc_lo=
cks.o lproc_mdc.o
diff --git a/drivers/staging/lustre/lustre/mdc/mdc_request.c b/drivers/stag=
ing/lustre/lustre/mdc/mdc_request.c
index cff31cb0a9ac..57225bf2bb72 100644
=2D-- a/drivers/staging/lustre/lustre/mdc/mdc_request.c
+++ b/drivers/staging/lustre/lustre/mdc/mdc_request.c
@@ -2741,7 +2741,7 @@ static struct md_ops mdc_md_ops =3D {
 	.revalidate_lock	=3D mdc_revalidate_lock
 };
=20
=2Dstatic int __init mdc_init(void)
+int __init mdc_init(void)
 {
 	struct lprocfs_static_vars lvars =3D { NULL };
 	int rc;
@@ -2756,15 +2756,8 @@ static int __init mdc_init(void)
 				 LUSTRE_MDC_NAME, NULL);
 }
=20
=2Dstatic void /*__exit*/ mdc_exit(void)
+void /*__exit*/ mdc_exit(void)
 {
 	class_unregister_type(LUSTRE_MDC_NAME);
 }
=20
=2DMODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
=2DMODULE_DESCRIPTION("Lustre Metadata Client");
=2DMODULE_VERSION(LUSTRE_VERSION_STRING);
=2DMODULE_LICENSE("GPL");
=2D
=2Dmodule_init(mdc_init);
=2Dmodule_exit(mdc_exit);
diff --git a/drivers/staging/lustre/lustre/mgc/Makefile b/drivers/staging/l=
ustre/lustre/mgc/Makefile
index 8abf108dbcf7..b1555e33fe49 100644
=2D-- a/drivers/staging/lustre/lustre/mgc/Makefile
+++ b/drivers/staging/lustre/lustre/mgc/Makefile
@@ -1,5 +1,4 @@
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include
=20
=2Dobj-$(CONFIG_LUSTRE_FS) +=3D mgc.o
=2Dmgc-y :=3D mgc_request.o lproc_mgc.o
+modobj-$(CONFIG_LUSTRE_FS) +=3D mgc_request.o lproc_mgc.o
diff --git a/drivers/staging/lustre/lustre/mgc/mgc_request.c b/drivers/stag=
ing/lustre/lustre/mgc/mgc_request.c
index 32df804614d3..68ef04eddfd2 100644
=2D-- a/drivers/staging/lustre/lustre/mgc/mgc_request.c
+++ b/drivers/staging/lustre/lustre/mgc/mgc_request.c
@@ -1825,7 +1825,7 @@ static struct obd_ops mgc_obd_ops =3D {
 	.process_config =3D mgc_process_config,
 };
=20
=2Dstatic int __init mgc_init(void)
+int __init mgc_init(void)
 {
 	int rc;
=20
@@ -1837,15 +1837,7 @@ static int __init mgc_init(void)
 				   LUSTRE_MGC_NAME, NULL);
 }
=20
=2Dstatic void /*__exit*/ mgc_exit(void)
+void /*__exit*/ mgc_exit(void)
 {
 	class_unregister_type(LUSTRE_MGC_NAME);
 }
=2D
=2DMODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
=2DMODULE_DESCRIPTION("Lustre Management Client");
=2DMODULE_VERSION(LUSTRE_VERSION_STRING);
=2DMODULE_LICENSE("GPL");
=2D
=2Dmodule_init(mgc_init);
=2Dmodule_exit(mgc_exit);
diff --git a/drivers/staging/lustre/lustre/module.c b/drivers/staging/lustr=
e/lustre/module.c
new file mode 100644
index 000000000000..a8a8c9687c95
=2D-- /dev/null
+++ b/drivers/staging/lustre/lustre/module.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPL HEADER START
+ *
+ * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License version 2 for more details (a copy is included
+ * in the LICENSE file that accompanied this code).
+ *
+ * You should have received a copy of the GNU General Public License
+ * version 2 along with this program; If not, see
+ * http://www.gnu.org/licenses/gpl-2.0.html
+ *
+ * GPL HEADER END
+ */
+
+#include <linux/module.h>
+#include <lustre_lib.h>
+
+static int __init  lustre_init(void)
+{
+	return obdclass_init() ||
+		ptlrpc_init() ||
+		fld_init() ||
+		osc_init() ||
+		mgc_init() ||
+		fid_init() ||
+		lov_init() ||
+		mdc_init() ||
+		lmv_init();
+}
+
+
+static void __exit lustre_exit(void)
+{
+	lmv_exit();
+	mdc_exit();
+	lov_exit();
+	fid_exit();
+	mgc_exit();
+	osc_exit();
+	fld_exit();
+	ptlrpc_exit();
+	obdclass_exit();
+}
+
+MODULE_ALIAS_FS("lustre");
+MODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
+MODULE_DESCRIPTION("Lustre Client File System");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(LUSTRE_VERSION_STRING);
+
+module_init(lustre_init);
+module_exit(lustre_exit);
diff --git a/drivers/staging/lustre/lustre/obdclass/Makefile b/drivers/stag=
ing/lustre/lustre/obdclass/Makefile
index e36ba2167d10..606647bde6a9 100644
=2D-- a/drivers/staging/lustre/lustre/obdclass/Makefile
+++ b/drivers/staging/lustre/lustre/obdclass/Makefile
@@ -2,9 +2,7 @@
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include
=20
=2Dobj-$(CONFIG_LUSTRE_FS) +=3D obdclass.o
=2D
=2Dobdclass-y :=3D module.o sysctl.o \
+modobj-$(CONFIG_LUSTRE_FS) +=3D module.o sysctl.o \
 	      llog.o llog_cat.o llog_obd.o llog_swab.o class_obd.o debug.o \
 	      genops.o uuid.o lprocfs_status.o lprocfs_counters.o \
 	      lustre_handles.o lustre_peer.o statfs_pack.o linkea.o \
diff --git a/drivers/staging/lustre/lustre/obdclass/class_obd.c b/drivers/s=
taging/lustre/lustre/obdclass/class_obd.c
index d6c46858941b..6f07837b56f5 100644
=2D-- a/drivers/staging/lustre/lustre/obdclass/class_obd.c
+++ b/drivers/staging/lustre/lustre/obdclass/class_obd.c
@@ -444,7 +444,7 @@ static int obd_init_checks(void)
 	return ret;
 }
=20
=2Dstatic int __init obdclass_init(void)
+int __init obdclass_init(void)
 {
 	int i, err;
=20
@@ -517,7 +517,7 @@ static int __init obdclass_init(void)
 	return err;
 }
=20
=2Dstatic void obdclass_exit(void)
+void obdclass_exit(void)
 {
 	lustre_unregister_fs();
=20
@@ -535,10 +535,3 @@ static void obdclass_exit(void)
 	obd_zombie_impexp_stop();
 }
=20
=2DMODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
=2DMODULE_DESCRIPTION("Lustre Class Driver");
=2DMODULE_VERSION(LUSTRE_VERSION_STRING);
=2DMODULE_LICENSE("GPL");
=2D
=2Dmodule_init(obdclass_init);
=2Dmodule_exit(obdclass_exit);
diff --git a/drivers/staging/lustre/lustre/obdclass/obd_mount.c b/drivers/s=
taging/lustre/lustre/obdclass/obd_mount.c
index 06c38fdef7ba..30a5e34d5ae8 100644
=2D-- a/drivers/staging/lustre/lustre/obdclass/obd_mount.c
+++ b/drivers/staging/lustre/lustre/obdclass/obd_mount.c
@@ -1232,7 +1232,6 @@ static struct file_system_type lustre_fs_type =3D {
 	.kill_sb	=3D lustre_kill_super,
 	.fs_flags	=3D FS_RENAME_DOES_D_MOVE,
 };
=2DMODULE_ALIAS_FS("lustre");
=20
 int lustre_register_fs(void)
 {
diff --git a/drivers/staging/lustre/lustre/osc/Makefile b/drivers/staging/l=
ustre/lustre/osc/Makefile
index 30dec90e64e8..5706a988c471 100644
=2D-- a/drivers/staging/lustre/lustre/osc/Makefile
+++ b/drivers/staging/lustre/lustre/osc/Makefile
@@ -1,6 +1,5 @@
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include
=20
=2Dobj-$(CONFIG_LUSTRE_FS) +=3D osc.o
=2Dosc-y :=3D osc_request.o osc_dev.o osc_object.o \
+modobj-$(CONFIG_LUSTRE_FS) +=3D osc_request.o osc_dev.o osc_object.o \
 	 osc_page.o osc_lock.o osc_io.o osc_quota.o osc_cache.o lproc_osc.o
diff --git a/drivers/staging/lustre/lustre/osc/osc_request.c b/drivers/stag=
ing/lustre/lustre/osc/osc_request.c
index 61ef6c8d7a12..46af1ad36f18 100644
=2D-- a/drivers/staging/lustre/lustre/osc/osc_request.c
+++ b/drivers/staging/lustre/lustre/osc/osc_request.c
@@ -2819,7 +2819,7 @@ static struct shrinker osc_cache_shrinker =3D {
 	.seeks		=3D DEFAULT_SEEKS,
 };
=20
=2Dstatic int __init osc_init(void)
+int __init osc_init(void)
 {
 	struct lprocfs_static_vars lvars =3D { NULL };
 	unsigned int reqpool_size;
@@ -2890,7 +2890,7 @@ static int __init osc_init(void)
 	return rc;
 }
=20
=2Dstatic void /*__exit*/ osc_exit(void)
+void /*__exit*/ osc_exit(void)
 {
 	unregister_shrinker(&osc_cache_shrinker);
 	class_unregister_type(LUSTRE_OSC_NAME);
@@ -2898,10 +2898,3 @@ static void /*__exit*/ osc_exit(void)
 	ptlrpc_free_rq_pool(osc_rq_pool);
 }
=20
=2DMODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
=2DMODULE_DESCRIPTION("Lustre Object Storage Client (OSC)");
=2DMODULE_LICENSE("GPL");
=2DMODULE_VERSION(LUSTRE_VERSION_STRING);
=2D
=2Dmodule_init(osc_init);
=2Dmodule_exit(osc_exit);
diff --git a/drivers/staging/lustre/lustre/ptlrpc/Makefile b/drivers/stagin=
g/lustre/lustre/ptlrpc/Makefile
index 77f8eabb2e28..0dffec552511 100644
=2D-- a/drivers/staging/lustre/lustre/ptlrpc/Makefile
+++ b/drivers/staging/lustre/lustre/ptlrpc/Makefile
@@ -2,15 +2,6 @@
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/include
 subdir-ccflags-y +=3D -I$(srctree)/drivers/staging/lustre/lustre/include
=20
=2Dobj-$(CONFIG_LUSTRE_FS) +=3D ptlrpc.o
=2DLDLM :=3D ../../lustre/ldlm/
=2D
=2Dldlm_objs :=3D $(LDLM)l_lock.o $(LDLM)ldlm_lock.o
=2Dldlm_objs +=3D $(LDLM)ldlm_resource.o $(LDLM)ldlm_lib.o
=2Dldlm_objs +=3D $(LDLM)ldlm_plain.o $(LDLM)ldlm_extent.o
=2Dldlm_objs +=3D $(LDLM)ldlm_request.o $(LDLM)ldlm_lockd.o
=2Dldlm_objs +=3D $(LDLM)ldlm_flock.o $(LDLM)ldlm_inodebits.o
=2Dldlm_objs +=3D $(LDLM)ldlm_pool.o
 ptlrpc_objs :=3D client.o recover.o connection.o niobuf.o pack_generic.o
 ptlrpc_objs +=3D events.o ptlrpc_module.o service.o pinger.o
 ptlrpc_objs +=3D llog_net.o llog_client.o import.o ptlrpcd.o
@@ -18,5 +9,7 @@ ptlrpc_objs +=3D pers.o lproc_ptlrpc.o wiretest.o layout.o
 ptlrpc_objs +=3D sec.o sec_bulk.o sec_gc.o sec_config.o
 ptlrpc_objs +=3D sec_null.o sec_plain.o nrs.o nrs_fifo.o
=20
=2Dptlrpc-y :=3D $(ldlm_objs) $(ptlrpc_objs) sec_lproc.o
+ptlrpc-y :=3D $(ptlrpc_objs) sec_lproc.o
 ptlrpc-$(CONFIG_LUSTRE_TRANSLATE_ERRNOS) +=3D errno.o
+
+modobj-$(CONFIG_LUSTRE_FS) +=3D $(ptlrpc-y)
diff --git a/drivers/staging/lustre/lustre/ptlrpc/ptlrpc_module.c b/drivers=
/staging/lustre/lustre/ptlrpc/ptlrpc_module.c
index 5c32b657b3b5..1260a7b9cae0 100644
=2D-- a/drivers/staging/lustre/lustre/ptlrpc/ptlrpc_module.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/ptlrpc_module.c
@@ -81,7 +81,7 @@ void ptlrpc_dec_ref(void)
 }
 EXPORT_SYMBOL(ptlrpc_dec_ref);
=20
=2Dstatic int __init ptlrpc_init(void)
+int __init ptlrpc_init(void)
 {
 	int rc, cleanup_phase =3D 0;
=20
@@ -166,7 +166,7 @@ static int __init ptlrpc_init(void)
 	return rc;
 }
=20
=2Dstatic void __exit ptlrpc_exit(void)
+void __exit ptlrpc_exit(void)
 {
 	tgt_mod_exit();
 	ptlrpc_nrs_fini();
@@ -176,11 +176,3 @@ static void __exit ptlrpc_exit(void)
 	ptlrpc_hr_fini();
 	ptlrpc_connection_fini();
 }
=2D
=2DMODULE_AUTHOR("OpenSFS, Inc. <http://www.lustre.org/>");
=2DMODULE_DESCRIPTION("Lustre Request Processor and Lock Management");
=2DMODULE_VERSION(LUSTRE_VERSION_STRING);
=2DMODULE_LICENSE("GPL");
=2D
=2Dmodule_init(ptlrpc_init);
=2Dmodule_exit(ptlrpc_exit);
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsaKWQACgkQOeye3VZi
gbkKVBAAk+j079lF0LwDWh117lrWWmI5iKQVksI2G79x/8PKEK45f/SM+uo2yRXm
ZzCqug4tpnZxb5Va5wNpkhvboZm0dukCU19jveWl8zNVsiWDN6Gu2EVmVGYEEuHq
94+aq+clElHUDcppI1Wtr/C9n5PX9Pu1xmIBZ4xmVIzPKPGPf8jfFLVjLEpMXewp
qMhssrcDVAY0F/e+OvaiVFH9k3uj06EmORDiYO7Z85x5VQmqpdpDJGK9hQ/tXIIB
BvUCA3KMipY8lJsF6LegHhv56Ts18194h4OCNIlsbjQn+Q0TpK/AL/x6Kn6WhVmR
Jw0giV6vXx7sBa+y+8ZZJG0MBwSIrmgfSwnNjjjZSSJmJJ6MLXf8HjmHAZx7FlJI
mF/NCxPtPa5bOwJ6U7uDh+pZx+uN/Yq2NPMenPj/KFh7ZiSp4H6hrUUPS7I2fBlx
DLb7LKb37KsRJFyO+Oymdnd4XNvHTDDSKnHu1OHH89FaiTaqBKCkDvmU3ZlIbPdH
rhvfOqt8piDdBs1r3G19AnKezsil05tasXRsOviLPVpEAoFlsAOwzivhC4BQ6Xqo
At4nulybNU2kJyflMEpZqk7Pt9kYjHKqHpVtvb4kEGr4SC99OES3KnYjkNqdxAEy
rYGTjxXkVWNS1mxQ4aME8JnIMpLIIOHmgfqwtCXlYwimw/f23DE=
=43nA
-----END PGP SIGNATURE-----
--=-=-=--
