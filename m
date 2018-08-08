Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2212CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F9421AA7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="G8wheZu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F9421AA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbeHIBqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:46:39 -0400
Received: from ozlabs.org ([203.11.71.1]:46219 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731665AbeHIBqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:46:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41m6sz32tCz9s3Z;
        Thu,  9 Aug 2018 09:24:39 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533770682;
        bh=niO16ZQM6deMzSda7XCoUIz2fpj/j+McC7YZhaFtzF0=;
        h=Date:From:To:Cc:Subject:From;
        b=G8wheZu3LSDLhMmQzachGSn69czOJ9fInXA6QuJn5bZWrlJGm5/E4QeXUPhzuGh64
         E4SdWJLfcNpxfh0rEro9NbOVgq8gv6UvLrzwh6NHgPSu02hWwREUBJ3oTplhKDkl6X
         DblwQZ7nAiSBN0+tFY3Z1+mrIlOyvzYMoIsAj5nz6ouXbOZLWpwLUNw4QCFeTFfkXE
         4i3wlT/nGbEuhChS3Ci8mAbX5uH15Q4X/krmh8blgb09jU7Rhw0B1IIX8/zEnAN3B2
         cF/EFHMj97ryMRfsCV5DiyQSsqN48rP0OGWFAiSL3YxW5sjxjhn99zBXiOZF7zBKZ5
         e7qpTwlVOC3Hw==
Date:   Thu, 9 Aug 2018 09:24:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20180809092420.094e8722@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WssEaKtcwrCAINGXV1YpKj9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WssEaKtcwrCAINGXV1YpKj9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 defconfig)
failed like this:

Invalid absolute R_X86_64_32S relocation: __end_rodata_aligned
/kisskb/src/arch/x86/boot/compressed/Makefile:127: recipe for target 'arch/=
x86/boot/compressed/vmlinux.relocs' failed

Caused by commit

  39d668e04eda ("x86/mm/pti: Make pti_clone_kernel_text() compile on 32 bit=
")

This was a build using gcc 4.6.3.  the i386 defconfig also failed
like this:

Invalid absolute R_386_32 relocation: __end_rodata_aligned

They started failing on next-20180723 (which is the first -next that
contained the above commit).  Sorry that we did not notice this earlier.
At least the i386 defconfig build works with gcc 7.3.1.

You can see the full build results here:
http://kisskb.ellerman.id.au/kisskb/head/6b522b734da2950c368aae668f963b8925=
fb5545/

--=20
Cheers,
Stephen Rothwell

--Sig_/WssEaKtcwrCAINGXV1YpKj9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltre6QACgkQAVBC80lX
0GzhyQgAoMUS/c/3qBLyYgmcQb2mh7XlzeQOhof8GRxWQLifEG8XHkEWd5pVnBfA
j3nF3uM7rMx8e9Y2K0tQlH0rSc3Gkr3GLmOG1ZGqTVl7zaj/h7kOikrMGe7PfT5s
iF90MNxSg6wLHD9pZpZlrmAvm7CGnXugW+DvC/IXkkRU3zJI0DmlkgZpcD/OHjqm
non0wFD88uvDhFugKGkE+0lDbY/imKrbN60RJQPSuj2EBtejlC1SnDa+2IyUNKzt
iMu5Y6+JEJdFhDNSzr9QkEjgaIyhBc8vNYGlnYCWbpe1Y7cHo4t0AMI/o1GUyKY8
ARb7mjnMqQXYS2reMpDnzpbXbhgoiw==
=obHU
-----END PGP SIGNATURE-----

--Sig_/WssEaKtcwrCAINGXV1YpKj9--
