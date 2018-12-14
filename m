Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3080C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A2C20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544765950;
	bh=+fuXuucgjsGxJpfz4mLRn3G87obuhSBTCnsySxr+u/g=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=DB80eC5eOWCC+GEE6k2hWqrBctJQAZlBn226CuKidUlt8XbMYiTkJFGl7F7ownJyq
	 jyWh86JEZRPJpRUXaWhfqnuqYRjBt4419StCpHleesDJBOQ98EXKPcA7/E30CDRwsZ
	 MU7eGf0R8x3lM0/UyU3vJlIEDf0gYIgkyBerEB2Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A2C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeLNFjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 00:39:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbeLNFjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 00:39:09 -0500
Received: from sol.localdomain (c-24-23-142-8.hsd1.ca.comcast.net [24.23.142.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2390120811;
        Fri, 14 Dec 2018 05:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544765948;
        bh=+fuXuucgjsGxJpfz4mLRn3G87obuhSBTCnsySxr+u/g=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=bJtb36dFmy2KT/YEcp8SIrJ4/5gPoP3Os+xtXQ2ipm9ORhziDe1vRb4JhcbBLMrNf
         YGYElHgtIU5+Kda7ga7Ev4KvkySFvqdUGvWVqyTFUn6nmDYO+N0OQCUdIvv6yBFX/9
         J4iue2ZEjUaq2ATU61jvItEIStrQCKcL9/WixxVg=
Date:   Thu, 13 Dec 2018 21:39:06 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181214053905.GA710@sol.localdomain>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-2-ebiggers@kernel.org>
 <20181212091406.GA31723@infradead.org>
 <20181212202609.GA193967@gmail.com>
 <20181213202249.GA3797@infradead.org>
 <20181214051722.GF20880@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214051722.GF20880@thunk.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:17:22AM -0500, Theodore Y. Ts'o wrote:
> Furthermore, it would require extra complexity in the common fsverity code
> --- which looks for the Merkle tree at the end of file data --- for no real
> benefit.

To clarify, while this is technically true currently, as I mentioned it's been
kept flexible enough such that a filesystem *could* store the metadata elsewhere
with only some slight changes to the common fs/verity/ code which won't break
other filesystems.  Though of course, keeping all filesystems using the
"metadata after EOF" approach does allow a couple simplifications.

- Eric
