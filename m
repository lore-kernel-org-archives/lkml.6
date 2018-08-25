Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FDFC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 05:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F196E208F7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 05:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="C8TB4i4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F196E208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeHYIoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 04:44:15 -0400
Received: from imap.thunk.org ([74.207.234.97]:44008 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbeHYIoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 04:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4VkBSW7Eyr3fFvNeN3r2YH4rHAXfHpTnt5QBtv1HKGo=; b=C8TB4i4GT+R/wnRr5WIiiXcUax
        lUTng6KW9h0y43WmKvrDOpZ/5XFnKBAmlfonrCHh8yx+4E1Cdd/h1ju3hIj8yqnazDdXRn3MytJI+
        T4uD4iuORQNRRxrTnFLl9QMMgYu+60OgZCNf/E/hU/JbS3RTjBuWs0RYvDdVWMlguLyk=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1ftQmF-0008IL-HW; Sat, 25 Aug 2018 05:06:23 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 024947A4B70; Sat, 25 Aug 2018 01:06:21 -0400 (EDT)
Date:   Sat, 25 Aug 2018 01:06:21 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [f2fs-dev] [RFC PATCH 02/10] fs-verity: add data verification
 hooks for ->readpages()
Message-ID: <20180825050621.GA25031@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>, linux-kernel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Victor Hsieh <victorhsieh@google.com>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-3-ebiggers@kernel.org>
 <2f2382c3-e5e9-f0da-dc89-42dfc7b2b636@huawei.com>
 <20180825034544.GA5281@thunk.org>
 <cb646950-94ea-9b28-80f1-3c840ad85581@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb646950-94ea-9b28-80f1-3c840ad85581@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 12:00:04PM +0800, Gao Xiang wrote:
> 
> But I have some consideration than the current implementation.... (if it is suitable to discuss, thanks...)
> 
> 1) Since it is the libfs-like library, I think bio-strict is too strict for its future fs users.

Well, it's always possible to potentially expand fs-crypt and
fs-verity to be more flexible in the future.  For example, Chandan
Rajendra from IBM has been working on a set of patches to support file
systems that have a block size smaller than a page size.  This turns
out to be important on Power architecture with 64k page sizes.

Fundamentally, a Merkle tree is a data structure that works on fixed
size chunks, both for the data blocks and the hash tree.  The natural
size to use is the page size, since data is cached in the page cache.

So a file system can be store data in any number of places, but
ultimately, most interesting file systems are ones where you can
execute ELF binaries out of said file system with demand paging, which
in turn means that mmap has to work, which in turn means that file
data will be stored in the page cache.  This is true of f2fs, btrfs,
ext4, xfs, etc.  So basically, fs-verity will be verifying the page
before it is marked as uptodate.  Right now, all of the file systems
that we are interested in trigger the call to ask fsverity to verify
the page via the bio endio callback function.

Some other file systems could theoretically call that function after
assembling the page from a dozen random locations in a b-tree.  In
that case, it could call fsverity after assembling the page in the
page cache.  But I'd suggest worrying about it when such a file system
comes out of the woodwork, and someone is willing to do the work to
integrate fserity in that file system.

> 2) My last question
> "At last, I hope filesystems could select the on-disk position of hash tree and 'struct fsverity_descriptor'
> rather than fixed in the end of verity files...I think if fs-verity preparing such support and interfaces could be better....."
> is also for some files partially or totally encoded (eg. compressed, or whatever ...)

Well, the userspace interface for instantiating a fs-verity file is
that it writes the file data with the fs-verity metadata (which
consists of the Merkle tree with a fs-verity header at the end of the
file).  The program (which might be a package manager such as dpkg or
rpm) would then call an ioctl which would cause the file system to
read the fs-verity header and make only the file data visible, and the
file system would the verify the data as it is read into the page
cache.

That is the userspace API to the fs-verity system.  That has to remain
the same, regardless of which file system is in use.  We need a common
interface so that whether it is the Android APK management system, or
some distribution package manager, can instantiate fs-verity protected
file the same way regardless of the file system in use.

There is a very simple, easy way to implement this in the file system,
and f2fs and ext4 both do it that way --- which is to simply change
the i_size exposed to the userspace when you stat the file, and we use
the file system's existing mechanism to map logical block numbers to
physical block numbers to read the Merkle tree.

If the file system wants to import that file data and store it
somewhere else random --- perhaps it breaks it apart into a zillion
tiny pieces and puts it in a b-tree --- a file system implementor is
free to do that.  I personally think it is a completely insane thing
to do, but there is nothing in the fs-verity design that *prohibits*
that.

Regards,

						- Ted
