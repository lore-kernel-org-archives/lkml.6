Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207F1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEA42083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+0bkrf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEA42083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeIABsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbeIABsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:48:33 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 830E42083C;
        Fri, 31 Aug 2018 21:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535751549;
        bh=ULePFtDGZRwMHbBH6SuwbFOjI+KpgWTUMhE4uYZMZCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N+0bkrf4MQWIRuRP7qyTHmnrld3AERH5sUZRJmlHwJsGZ/ikcEFmOB/cO0isojxbF
         UliAvAxERtGwRRWW5QQiiK/xNGvJOBcuaadgWkR0/92AdZ4lIynnSc9iaYORrEMC+C
         CCwnlNDJ2B8f7ffwyeVWme0mqvOCoFgyqrrNZe0g=
Date:   Fri, 31 Aug 2018 14:39:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [RFC PATCH 00/10] fs-verity: filesystem-level integrity
 protection
Message-ID: <20180831213907.GA212813@gmail.com>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <1535745923.25742.1.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1535745923.25742.1.camel@pengutronix.de>
User-Agent: Mutt/1.10.1+60 (20b17ca5) (2018-08-02)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Fri, Aug 31, 2018 at 10:05:23PM +0200, Jan Lübbe wrote:
> On Fri, 2018-08-24 at 09:16 -0700, Eric Biggers wrote:
> [...]
> > Since fs-verity provides the Merkle tree root hash in constant time and
> > verifies data blocks on-demand, it is useful for efficiently verifying
> > the authenticity of, or "appraising", large files of which only a small
> > portion may be accessed -- such as Android application (APK) files.  It
> > can also be useful in "audit" use cases where file hashes are logged.
> > fs-verity also provides better protection against malicious disk
> > firmware than an ahead-of-time hash, since fs-verity re-verifies data
> > each time it's paged in.
> [...]
> > Feedback on the design and implementation is greatly appreciated.
> 
> Hi,
> 
> I've looked at the series and the slides linked form the recent lwn.net
> article, but I'm not sure how fs-verity intends to protect against
> malicious firmware (or offline modification). Similar to IMA/EVM, fs-
> verity doesn't seem to include the name/location of the file into it's
> verification. So the firmware/an attacker could replace one fs-verity-
> protected file with another (maybe a trusted system APK with another
> one for which a vulnerability was discovered, or /sbin/init with
> /bin/sh).
> 
> Is the expected root hash of the file provided from somewhere else, so
> this is not a problem on Android? Or is this problem out-of-scope for
> fs-verity?
> 
> For IMA/EVM, there were patches by Dmitry to address this class of
> attacks (they were not merged, though):
> https://lwn.net/Articles/574221/
> 
> Thanks,
> Jan
> 
> [1] https://events.linuxfoundation.org/wp-content/uploads/2017/11/fs-ve
> rify_Mike-Halcrow_Eric-Biggers.pdf

Well, it's up to the user of fs-verity.

If you know that, say, /bin/sh is supposed to have a fs-verity file measurement
of sha256:01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b, then
you can just check that.

Or, after IMA support is added, users will be able to configure the fs-verity
measurements to go into the IMA measurement log and/or audit log, just regular
file hashes.  Those records include both the file path and hash.

On the other hand, if the policy you want to enforce is just that a particular
file is using fs-verity and that its hash has been signed by a particular key,
then indeed, if there are multiple hashes that were signed with that key, an
attacker can replace the contents with a different signed contents.  But that's
not really fs-verity's fault; it's really the type of policy that the user chose
to use on top of it, as part of their overall system security architecture.

Yes, the initial plan for Android APK verification is to just use that type of
policy, probably using the in-kernel signature verification support included in
patch 07/10.  So it will therefore have that limitation.  Still, it will be a
massive improvement over the status quo where attackers can make arbitrary
changes to APK files post-installation, e.g. to persistently inject arbitrary
malware.

It will also be possible to improve the security properties of APK verification
in the future by doing additional checks, such as optionally including
additional file metadata in the fs-verity measurement (fs-verity's design allows
for this; they can be added as authenticated extensions), or even simply
checking for the correct metadata from trusted userspace code running in the
/system partition.  Or perhaps the trusted userspace code could download the
expected fs-verity measurement of the APK from the app store given the app name.
There are lots of options.  But we have to start somewhere, and fs-verity is a
tool that seems to be needed in any case.

- Eric
