Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D809CC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 04:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BF1208EB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 04:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xNsVZUPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BF1208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHYI0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 04:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbeHYI0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 04:26:32 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DBBF208E8;
        Sat, 25 Aug 2018 04:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535172534;
        bh=kJbFd2kQn/3j/07Ph9GG/Fd/Y1MOk7kr2k4Y/EV/IkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xNsVZUPx83FV9TZpvHc9CoyH5P6nZjfu7MxOm/ix4E/Iie1jO3p1RwNSioRCkV4B1
         D8fk21tz3klsFqNGkUzwP9t7Tfl9qv2TW10GpvPLgc2bS22S6lr+vwNRrorX1eBtV8
         yGihEWbJGy+nUqbLDtswv16PEqtg+tykLxe/oAYg=
Date:   Fri, 24 Aug 2018 21:48:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Colin Walters <walters@verbum.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [RFC PATCH 01/10] fs-verity: add setup code, UAPI, and Kconfig
Message-ID: <20180825044852.GB726@sol.localdomain>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-2-ebiggers@kernel.org>
 <1535132549.2855027.1485213752.129E3334@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535132549.2855027.1485213752.129E3334@webmail.messagingengine.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Fri, Aug 24, 2018 at 01:42:29PM -0400, Colin Walters wrote:
> 
> On Fri, Aug 24, 2018, at 12:16 PM, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > fs-verity is a filesystem feature that provides efficient, transparent
> > integrity verification and authentication of read-only files.  It uses a
> > dm-verity like mechanism at the file level: a Merkle tree hidden past
> > the end of the file is used to verify any block in the file in
> > log(filesize) time.  It is implemented mainly by helper functions in
> > fs/verity/ that will be shared by multiple filesystems.
> > 
> > Essentially, fs-verity reports a file's hash in constant time, but reads
> > that would violate that hash fail at runtime.  This is useful when only
> > a portion of the file is actually accessed, as only the accessed portion
> > has to be hashed, and the latency to the first read is much reduced over
> > a full file hash.  On top of this hashing mechanism, auditing or
> > authentication policies can be implemented to log or verify file hashes.
> > 
> > Note that in general, fs-verity is *not* a replacement for IMA.
> > fs-verity is a lower-level feature, primarily a way to hash a file;
> > whereas IMA deals more with higher-level policy logic, like defining
> > which files are "measured" and what to do with those measurements.  We
> > plan for IMA to support fs-verity measurements as an alternative to the
> > traditional full file hash.  Still, some users find fs-verity useful by
> > itself, so it's also usable without IMA in simple cases, e.g. in cases
> > where just retrieving the file measurement via an ioctl is enough.
> > 
> > A structure containing the properties of the Merkle tree -- such as the
> > hash algorithm used, the block size, and the root hash -- is also stored
> > on-disk, following the Merkle tree.  The actual file measurement hash
> > that fs-verity reports is the hash of this structure.
> > 
> > All fs-verity metadata is written by userspace; the kernel only reads
> > it.  Extended attributes aren't used because the Merkle tree may be much
> > larger than XATTR_SIZE_MAX, we want the hash pages to be cached in the
> > page cache as usual, and in the case of fs-verity combined with fscrypt
> > we want the metadata to be encrypted to avoid leaking plaintext hashes.
> > The fs-verity metadata is hidden from userspace by overriding the i_size
> > of the in-memory VFS inode; ext4 additionally will override the on-disk
> > i_size in order to make verity a RO_COMPAT filesystem feature.
> > 
> > This initial patch only adds the fs-verity Kconfig option, UAPI, and
> > setup code, e.g. the ->open() hook that parses the fs-verity descriptor.
> 
> This first patch also adds a bit of core logic in the
> simple fsverity_prepare_setattr() which ends up being called
> by ext4 later.
> 
> While I'm not too familiar with the vfs, as far as I can
> tell  from inspection of Linus' git master is that pretty much any change (timestamp, hardlinks) ends up
> calling notify_change() which calls the fs-specific one, and in
> the verity case basically denies everything, right?
> 
> Previously I brought up many uses for "content immutable" files:
> https://marc.info/?l=linux-fsdevel&m=151698481512084&w=2
> 
> The discussion sort of died out but...did you have any opinion
> on e.g. my proposal to use the Unix mode bits as a way to describe
> levels of mutablility?
> 
> Let's say that your new _VERITY inode flag becomes "_WRITEPROT"
> or something a bit more generic.
> 
> Do you have any thoughts on my proposal to reuse the Unix mode
> bits to control levels of inode mutability?
> 
> For example, it seems to me we could define u+w as "hardlinks are OK".
> There shouldn't be any reason ext4/f2fs couldn't hardlink a verity-protected
> inode right?  Or if for some reason that is hard, we could disallow that to
> start, but at least have the core VFS support _WRITEPROT inodes?
> 

As Ted pointed out, only truncates are denied on fs-verity files, not other
metadata changes like chmod().

Think of it this way: the purpose of fs-verity is *not* to make files immutable.
It's to hash them.  We can't allow people to change the thing being hashed,
since that would invalidate the hash.  So while fs-verity does make the file
contents immutable, it's actually a requirement for it being hashed (measured),
rather than the end goal.  There's no reason from fs-verity's perspective to
make anything else immutable.

That being said, in the future, we could allow declaring file metadata like the
Unix mode bits in the authenticated portion of the fs-verity descriptor, so they
would be included in the file hash.  fs-verity would then need to enforce that
the declared mode matches the actual one and that the actual one cannot be
changed.  Extended attributes could be included in the hash in the same way.

But that's out of scope for now, as so far users only need the file contents to
be hashed.

- Eric
