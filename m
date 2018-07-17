Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A75FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB752086B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="l4zRH/yX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB752086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeGQFLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 01:11:21 -0400
Received: from ozlabs.org ([203.11.71.1]:49029 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbeGQFLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 01:11:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41V6zC0NZnz9s0n;
        Tue, 17 Jul 2018 14:40:39 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531802439;
        bh=APEH99Xk56EYykXuMs87+TJhHFczL3EN6EmJ9uH8ujY=;
        h=Date:From:To:Cc:Subject:From;
        b=l4zRH/yXB45EH9HrzIMhD9XItcvek7aZys3zJt1Q65QpMkAMY+t6XzoDSAiKSkkHE
         4Kc3M/+AgXmDcQCEKUDyZ3WEwNZO11mpSy5rUJWEQA1g9/wtFRmDVLd8EqfmJXzk25
         Q5/gjdr1VmibgBcK+Qrt/HtRBcV3QjY6Z4tmuUniSMFC+/kGaxtkDyPD/6pc985cBI
         8EnIrCBf4YceMFzbHIslP7KzbBVYEuITa7mmOdN4M8ZAu23Azrr9PiNjwi+VjTf/L0
         jDMlN+CrSPblr29nEupjOFlU5oTgQpC+D80qg89lTT/qnQ0gWLtJuhrOKnfrkSyZ3V
         Wa2YJzo9oVk7g==
Date:   Tue, 17 Jul 2018 14:40:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>
Subject: linux-next: build failure after merge of the integrity tree
Message-ID: <20180717144038.50394022@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ai.jCjB9ONn6CD0SP3vdnNf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ai.jCjB9ONn6CD0SP3vdnNf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the integrity tree, today's linux-next build (x86_64
allmodconfig) failed like this:

security/integrity/ima/ima_main.c:549:5: error: redefinition of 'ima_load_d=
ata'
 int ima_load_data(enum kernel_load_data_id id)
     ^~~~~~~~~~~~~
security/integrity/ima/ima_main.c:506:5: note: previous definition of 'ima_=
load_data' was here
 int ima_load_data(enum kernel_load_data_id id)
     ^~~~~~~~~~~~~

Caused by commit

  4995c7ac4490 ("ima: based on policy require signed kexec kernel images")

interacting with commit

  16c267aac86b ("ima: based on policy require signed kexec kernel images")

from the sceurity tree.

Basically the same set of patches are in the security tree and the
integrity tree as different commits.  The merge managed to add this
function twice.  I have added a patche to remove one copy of the function.

Please clean up the integrity tree relative to the security tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ai.jCjB9ONn6CD0SP3vdnNf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltNc0YACgkQAVBC80lX
0Gz+lQgAj/zzeIaU8cXZQesXXSczjGxfPtCv1HNJhy4NRVNh6Zcn1fXI7SRNvZEr
UMBIz68eF2h1xFfcU3SerzAZth8LJ0m5BiW2RueJT++y8ZnqaasBZpWVSCNOOIfC
bv4P3z2/b7u9TaqMiEOTrXGQz9mFsxDWGNCHRTSMZVxvd2ILK0s03ZXlKxBWaC2A
/PmUztfQP2A14BLjMLradzY6RH0qOWVeotZsZPSd0uIc9A+kyc0SspANJl3piNUk
SvgJ6kLAeoAxIZKwExD5qrGJYaAFMafpZuQmymEyZ1VDmupszO9PpOP0CTEvdmwR
1P4oXE1vFDDMmhYxZDPZxGpyv9k+MA==
=w+ya
-----END PGP SIGNATURE-----

--Sig_/ai.jCjB9ONn6CD0SP3vdnNf--
