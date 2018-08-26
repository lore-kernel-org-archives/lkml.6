Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E2BC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D005F208DA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMTj6AI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D005F208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeHZVAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 17:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbeHZVAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 17:00:24 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B96208D8;
        Sun, 26 Aug 2018 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535303836;
        bh=5fl/7KS5bMbu4x03I9H56U0A8XPQKFj6z4Cz6C1l8IU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LMTj6AI+4ZKDUVold+9dmPsu0SV25qhImRBipi+OWg1qrFfKa9fDBHVapggiBzTjV
         QG/rM3Wn2ZCcUChT4+du1W0+y2aS8s26uDtrz0XIsg2clEhqHqKgzLekxaSsAhjN5a
         +NRw5x94OYiC/MbLV9OGY3uKX2yKFqYTRTczIDuM=
Date:   Sun, 26 Aug 2018 10:17:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chuck Lever <chucklever@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [RFC PATCH 01/10] fs-verity: add setup code, UAPI, and Kconfig
Message-ID: <20180826171713.GB728@sol.localdomain>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-2-ebiggers@kernel.org>
 <815EEE5D-D90F-4E97-A33E-D33D868B962B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815EEE5D-D90F-4E97-A33E-D33D868B962B@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuck,

On Sun, Aug 26, 2018 at 12:22:08PM -0400, Chuck Lever wrote:
> Hi Eric-
> 
> Context: I'm working on IMA support for NFSv4, and would like to
> use fs-verity (or some Merkle tree-like mechanism) eventually to
> help address the performance impacts of using IMA with large NFS
> files.
> 
> 
> > On Aug 24, 2018, at 12:16 PM, Eric Biggers <ebiggers@kernel.org> wrote:
> > 
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > fs-verity is a filesystem feature that provides efficient, transparent
> > integrity verification and authentication of read-only files.  It uses a
> > dm-verity like mechanism at the file level: a Merkle tree hidden past
> > the end of the file is used to verify any block in the file in
> > log(filesize) time.  It is implemented mainly by helper functions in
> > fs/verity/ that will be shared by multiple filesystems.
> 
> This description suggests that the only way fs-verity can work is
> by placing the Merkle tree data after EOF. Further, this organi-
> zation is exposed to user space, making it a fixed part of the
> fs-verity kernel/user space API.
> 
> Remote filesystems -- esp. NFS -- would prefer to manage the Merkle
> tree data in other ways. The NFSv4 protocol, for example, supports
> named streams (as some other filesystems do), and could store the
> Merkle trees in those. Or, a new pNFS layout type could be con-
> structed where Merkle trees are stored separately from a file's
> content -- perhaps even on a separate file server.
> 
> File servers can store this data as the servers' local filesystems
> require.
> 
> Sharing how the Merkle tree is created and used is sensible, but
> IMHO the filesystem implementations should be allowed to store this
> tree however they find convenient. The Merkle trees should be
> exposed via a clean API, not as part of the file's content.
> 

There has also been discussion with this on the thread for patch 02/10.
"A Merkle tree hidden past the end of the file" describes how ext4 and f2fs are
proposed to implement it, and it describes the file format expected by
FS_IOC_ENABLE_VERITY.  But, at FS_IOC_ENABLE_VERITY time, a filesystem could
copy the verity metadata to somewhere else if it wanted, e.g. into a file
stream, and then truncate the file to its original size.

Afterwards, fs-verity doesn't really care where the metadata is stored.
Currently it does actually assume it's beyond EOF since it calls
read_mapping_page() directly, but that could be replaced at any time with
indirection via a method fsverity_operations.read_metadata_page().
We actually had such a method originally, but it turned out to be unnecessary
for ext4 and f2fs, so I had dropped it for now.

I will make this clearer in the next revision of the patchset, and maybe even
consider reintroducing ->read_metadata_page() to make it clear that filesystems
don't necessarily have to store the metadata beyond EOF.

Thanks,

- Eric
