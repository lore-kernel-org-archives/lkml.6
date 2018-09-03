Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CB9C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 23:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44CE20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 23:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Z0w61K0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44CE20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeIDDmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 23:42:22 -0400
Received: from ozlabs.org ([203.11.71.1]:33393 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeIDDmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 23:42:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4245XX2pzvz9s3C;
        Tue,  4 Sep 2018 09:19:56 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536016797;
        bh=4fX6icdsFHCOSXafgTzjUbemADCj5L6uM4jpO/e/Q5A=;
        h=Date:From:To:Cc:Subject:From;
        b=Z0w61K0f9bfkFDqXTrLwba7UwlojbF771vIRtAGbL4Jb4F6N8EXnnFUTx+tS4IGIt
         qKzQOAjAEO09cpFzczLcY8ya9ngAVlbQmJPv26Ec5XVFjPpnP8Mgeznc1BtdMf1MbT
         YUN0VIyxpKGZIw3yarqYaeIVmWhzYPlbHiVLe5aM78S+X99cmIG6tkwuHYo8haqzbh
         WYLtgll9P889F03sN9mKZhWWr92IBKEIulWruZagFE0MjZJcMJ4gwTSqn3XkBwflh7
         JLYAzrUnw1lRiJQXrLAMpsfjiUMYQMOPo2cCgO18/5FvKHQGfp7viOd/9E8IGgUT7R
         v8Il4EXjNHe8g==
Date:   Tue, 4 Sep 2018 09:19:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the dmi tree with Linus' tree
Message-ID: <20180904091950.2e49b1a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.XsCb+VdQ3kODON9R5lYliI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.XsCb+VdQ3kODON9R5lYliI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the dmi tree got a conflict in:

  drivers/acpi/bus.c

between commit:

  ae976358cd7b ("Revert "ACPI / bus: Parse tables as term_list for Dell XPS=
 9570 and Precision M5530"")

from Linus' tree and commit:

  767b174cad46 ("ACPI / bus: Only call dmi_check_system on X86")

from the dmi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/acpi/bus.c
index 292088fcc624,0ac3ad75309c..000000000000
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@@ -1033,11 -1056,15 +1029,16 @@@ void __init acpi_early_init(void
 =20
  	acpi_permanent_mmap =3D true;
 =20
+ #ifdef CONFIG_X86
  	/*
 -	 * Check machine-specific quirks
 +	 * If the machine falls into the DMI check table,
 +	 * DSDT will be copied to memory
+ 	 * Note that calling dmi_check_system here on other architectures
+ 	 * would not be OK because only x86 intializes dmi early enough.
+ 	 * Thankfully only x86 systems need such quirks for now.
  	 */
 -	dmi_check_system(acpi_quirks_dmi_table);
 +	dmi_check_system(dsdt_dmi_table);
+ #endif
 =20
  	status =3D acpi_reallocate_root_table();
  	if (ACPI_FAILURE(status)) {

--Sig_/.XsCb+VdQ3kODON9R5lYliI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluNwZYACgkQAVBC80lX
0Gxe8Qf/elrm2pW26rZ9GHjMoleWgw+C+rshSJjPgTbK7+N7POlsX9ooNZ2djaMP
uECuSCNZLwyTX6rKKrIRMeNf5r8proNB+6yPAIYEEEHYUqTt7ygZ9dsiRrZcFswy
3LdosjzMlMDWAf5+Ga2JO55dz9GKbmBCycwG1tX9G+M38Cts6YNC8Cxl+KFgxuRV
et9JSsYsRx4dFFVxIRuCMAKfafeQ6f9jPHGcDKyovQ38Ld5lTwc9tV/bcKxH+3Y4
pEuiT4vcJW8U6G7Omga8MgnGWItyDyG5YA0BMJK6xKCDzQZggSqDeVZyRjPUDGrK
IwrA2u+6dYzoL8vOkFDVhQuEuuWzhQ==
=rbOe
-----END PGP SIGNATURE-----

--Sig_/.XsCb+VdQ3kODON9R5lYliI--
