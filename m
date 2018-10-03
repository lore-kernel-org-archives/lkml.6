Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9EDC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06FD20645
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BHEaOtMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06FD20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeJCKhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 06:37:14 -0400
Received: from ozlabs.org ([203.11.71.1]:57379 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbeJCKhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 06:37:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Q29V42fsz9s7h;
        Wed,  3 Oct 2018 13:50:38 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538538638;
        bh=3c85BcuDHHu389EHQ4FeYwtpACjFSLtt9Wdkdfy9ios=;
        h=Date:From:To:Cc:Subject:From;
        b=BHEaOtMB8H33HhfJFS7hGOM7pAtV1D4rI8ofAi2qq6hBb3rMZdnt2Jj+6ix1uwUmQ
         71x8qI0ZE+ATFRfpcDDgRFBDi4zw6xFpdkpr/WK5lZ+AhjmIxRypN0grNw17PJNEJR
         7wPLuLrD6slJ5xcyIgyh39uWAmYlxNZNZ8sGqLoklbg9JwyH5sxNdbXeAFR1J5Vqhy
         ntmgV24+eguYgsY2aLotgFn2RWZ4CZ5bVH/5/l04UOKn1VWWdNf4WNPliZA/JczpjL
         4OvaOAZc11uk2gKL+zRnH2pqCASS0ELffoCvdioNCkGLAiP2FHpO7k0Z9GfVdpohyj
         0pbo2b2fWQw0g==
Date:   Wed, 3 Oct 2018 13:50:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: occassional build errors
Message-ID: <20181003135038.24438d97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/654D6paRw+IaZia8xFV6OEY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/654D6paRw+IaZia8xFV6OEY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

I don't know if that has anything to changes in the kbuild system, but
since Tuesday, I have been getting random build errors that go away after
I remove the object directory and build again.  The latest example is this:

include/linux/kconfig.h: file not recognized: file format not recognized
make[2]: *** [scripts/Makefile.build:492: crypto/crypto_user.o] Error 1
make[1]: *** [Makefile:1057: crypto] Error 2
make: *** [Makefile:152: sub-make] Error 2
Command exited with non-zero status 2

It is always complaining about a .h file ...

Makefile:152 is the MAKE lien below:

# Invoke a second make in the output directory, passing relevant variables
sub-make:
        $(Q)$(MAKE) -C $(KBUILD_OUTPUT) KBUILD_SRC=3D$(CURDIR) \
        -f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))

Makefile:1057 is the MAKE line below:

PHONY +=3D $(vmlinux-dirs)
$(vmlinux-dirs): prepare scripts
        $(Q)$(MAKE) $(build)=3D$@ need-builtin=3D1

scripts/Makefile.build:492 is the if_changed line below:

$(multi-used-m): FORCE
        $(call if_changed,link_multi-m)
        @{ echo $(@:.o=3D.ko); echo $(filter-out FORCE,$^); \
           $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=3D.mod)
$(call multi_depend, $(multi-used-m), .o, -objs -y -m)

Not sure what else I can tell you.

--=20
Cheers,
Stephen Rothwell

--Sig_/654D6paRw+IaZia8xFV6OEY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu0PI4ACgkQAVBC80lX
0Gy0LAf8CwCKEd/94KzYgo4ys0Oy5ZYUeu3an+fPimjOGPEqyd8p5d4I/wVqiy3j
A5i7t5mpEmYq5BhKHJf/PvsEbmI2V1QxrC+8ADSRxsOFB/szhLCD8UXGoROzyQcG
5L+qm8dIXmDLi7G1fTpJ7KGbPFqOmWPQt7QUIcf7TX+ZdAQF4UM6qJg8ygmr03+a
Dfm6YGEgYfQDQOmFWHlC9/wOHnPEzmcjjCtj/QKr3sAVaqyPOBNCr0JZlvTE7LjW
FvVVToQcewZxihhVCOYR76biJHPUoIAebq3N2RmWpb0AY0J2vIysjUfxjXd0Fh+M
gQB3Z9WVKeIyo3Ugy/6cD0ttFn7BfQ==
=aTXN
-----END PGP SIGNATURE-----

--Sig_/654D6paRw+IaZia8xFV6OEY--
