Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B813C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFC420827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="utXV5apl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFC420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbeKFG1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:27:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38873 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbeKFG1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:27:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id f8-v6so4781204pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 13:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=OVgu5swMyCgrUDNrdkyDBWDmd76uszz6tesB4wF/bdc=;
        b=utXV5aplEvyZreAzRLMAbo8u4SB0cRKJVkwTTRSMNixO6oGI73m2087U7Hvbr09aiS
         DbBvYlofCpaufYEsuKS5wYvUpnYltVDq0aSchnvBcit5BPpfpvzFDIcyGY21qj+nAdzu
         7e9yOE8a3we0E+JUbQYOMBKop9ReTOpN2ym56v2wDERf/KCh6Ji2lxsLVOpmO4vewNbl
         9Z5WNswENA/gwqjnr7IBdPcUyOeNkQRMqPcV47rzbAsdP8Zo5NGaoV1FKPmcZqx82ms3
         VrzuJlSsMPb7kUsz21JDHGHzxnZNjMVXgScdMELk2O5iUHqxtyxmmLV+TOM4tajUFUw5
         YnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=OVgu5swMyCgrUDNrdkyDBWDmd76uszz6tesB4wF/bdc=;
        b=eiD5X38OKzp0dRiCviEEbx9Gc4ZOJuyBanGOJWDwY3ACISMrTWnrZnULZ9GE9BEV2F
         bUyGQarYYop684anr6FGmIZ8AjHAHXrq+BWuPxQ6koTijafRtzHXByie+u8KFQ6fccQ5
         oFg0rUHY/8Ct/Nv21Cs5FZEXdK2YTZkx+gP4HKRjb6LBH4TJKWwxc2wQ3oXe8S/gpNGT
         qXw26/nsexp+Uf6pQm12D7+QEcAJeZn9O/pufPkYIyS62ZpmYiave4/ESA/xmDpWclBl
         wEKiFWasmwFWj4PfBeCdLJqBiSHj8CVz/b0Nnz7Erf6FxvT0JfmPCxdNi0qHziNepD+F
         8+KA==
X-Gm-Message-State: AGRZ1gL3E/vP6/RLdMe/2ycrwzlvu/QVfaFH61zO8DOg55xKr8l3tfb1
        oLtC9u4CU0/qLLxVDL3LR/RvEw==
X-Google-Smtp-Source: AJdET5dKSiejbgvcFVKbx2qW2BrsLjIFmj5FEwZgof5PrbohGFBNABwhLwo28tYz3wo0YiGOM+YBoA==
X-Received: by 2002:a63:8c4:: with SMTP id 187-v6mr21530079pgi.396.1541451930899;
        Mon, 05 Nov 2018 13:05:30 -0800 (PST)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id o1sm16118526pgn.63.2018.11.05.13.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 13:05:29 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F1AB58DE-E8D8-449C-B07C-4868B181F5E9@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F0C1406D-50AB-4BE0-B275-698A345B0C1F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 10/12] ext4: add basic fs-verity support
Date:   Mon, 5 Nov 2018 14:05:24 -0700
In-Reply-To: <20181101225230.88058-11-ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-11-ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_F0C1406D-50AB-4BE0-B275-698A345B0C1F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Nov 1, 2018, at 4:52 PM, Eric Biggers <ebiggers@kernel.org> wrote:
> 
> From: Eric Biggers <ebiggers@google.com>
> 
> Add basic fs-verity support to ext4.  fs-verity is a filesystem feature
> that enables transparent integrity protection and authentication of
> read-only files.  It uses a dm-verity like mechanism at the file level:
> a Merkle tree is used to verify any block in the file in log(filesize)
> time.  It is implemented mainly by helper functions in fs/verity/.
> See Documentation/filesystems/fsverity.rst for details.
> 
> This patch adds everything except the data verification hooks that will
> needed in ->readpages().
> 
> On ext4, enabling fs-verity on a file requires that the filesystem has
> the 'verity' feature, e.g. that it was formatted with
> 'mkfs.ext4 -O verity' or had 'tune2fs -O verity' run on it.
> This requires e2fsprogs 1.44.4-2 or later.
> 
> In ext4, we choose to retain the fs-verity metadata past the end of the
> file rather than trying to move it into an external inode xattr, since
> in practice keeping the metadata in-line actually results in the
> simplest and most efficient implementation.  One non-obvious advantage
> of keeping the verity metadata in-line is that when fs-verity is
> combined with fscrypt, the verity metadata naturally gets encrypted too;
> this is actually necessary because it contains hashes of the plaintext.

On the plus side, this means that the verity data will automatically be
invalidated if the file is truncated or extended, but on the negative side
it means that the verity Merkle tree needs to be recalculated for the
entire file if e.g. the file is appended to.

I guess the current implementation will generate the Merkle tree in
userspace, but at some point it might be useful to generate it on-the-fly
to have proper data integrity from the time of write (e.g. like ZFS)
rather than only allowing it to be stored after the entire file is written?

Storing the Merkle tree in a large xattr inode would allow this to change
in the future rather than being stuck with the current implementation.  We
could encrypt the xattr data just as easily as the file data (which should
be done anyway even for non-verity files to avoid leaking data), and having
the verity attr keyed to the inode version/size/mime(?) would ensure the
kernel knows it is stale if the inode is modified.

I'm not going to stand on my head and block this implementation, I just
thought it is worthwhile to raise these issues now rather than after it
is a fait accompli.

> We also choose to keep the on-disk i_size equal to the original file
> size, in order to make the 'verity' feature a RO_COMPAT feature.  Thus,
> ext4 has to find the fsverity_footer by looking in the last extent.


Cheers, Andreas






--Apple-Mail=_F0C1406D-50AB-4BE0-B275-698A345B0C1F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlvgsJUACgkQcqXauRfM
H+CsRRAAuh1XSvfDwsO1atgPaFlL0Q7PcY1+CYff3nkv3uRh9ipcCTihtLAhGOVf
BLqR6uikUyIJefr4j0iFYOI8bI/StscPRXIUR6iYwIzqiErTlnvb0ClQ1VMS5tyu
y+LpKLpkXeTnZHAv5HWgviAM0IotgdpwrEjkuStGj5AHIsMr2Cmh045PXBqmv6yt
uuUmZTmmsHGN8FzaHy75APglMH4axBhgCburXs1Bj9eK54uppuhSIUnS5GKzJhA1
OLlBExpkqCrMmlYgDtOUFfWtJfzTG5HMsMHIR/90I6ahxMw2Qcudud16gthMAuKv
ZSqjOz9hBRTfLICoY4ZN2BhUUhujU5FvGGLLAg23U11BtusfcKerFUql4pZTXgaN
HQpfQy5ST7reXn2xuhkxH0amPoebf9+f6vY0TCKv8w0RpZS6qOHkzbMocuvpuW42
V7i8s+Cd9SH9DGsfGce75MGy2YZu0R/iHbY1BhYZeRRQUEqubLoH/xQREltNjAp3
g7l12NF47h5glm73urKdfIiOq+zNSX8XgiVceuIX5ij4T6z8VcpyJv8lASfpcH+d
z8Tjt3aI+h4vZaCpHteZ9FOuarSoULSbIMRzEaYV2oX3zbM6JCOlb/A9cVKf/522
KsoOjOofDsPNfMRUNo+/egSKVsg1CySgsuUkaF2v1I4QoFXYO4Q=
=XiFo
-----END PGP SIGNATURE-----

--Apple-Mail=_F0C1406D-50AB-4BE0-B275-698A345B0C1F--
