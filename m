Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB163C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 17:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6BC2172A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 17:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="L+DI2vXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6BC2172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeHYUqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 16:46:06 -0400
Received: from imap.thunk.org ([74.207.234.97]:44848 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbeHYUqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 16:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2Gvon5qCNUv1RdmJlEfyvsCgqsf0IUliZT9i8RxiwWw=; b=L+DI2vXqiahEQ4c/IvsJfMJS0G
        yB6sg4pyiV/SCkUTc68jUPx8pA/QXwiKRTM1pjh+uVSBPVbZ2A3C4QlBcQREE99Mg0hXHMEpCUw8O
        pC8DiUorGNt/EgAQcS6/YHdfTpcSaW1TpDTYr1YTdeQfi99t3xOMbRdntqwJQ6wCHOzA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1ftc14-00034U-94; Sat, 25 Aug 2018 17:06:26 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CF4AA7A4B70; Sat, 25 Aug 2018 13:06:24 -0400 (EDT)
Date:   Sat, 25 Aug 2018 13:06:24 -0400
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
Subject: Re: [RFC PATCH 02/10] fs-verity: add data verification hooks for
 ->readpages()
Message-ID: <20180825170624.GB10619@thunk.org>
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
 <20180825041647.GA726@sol.localdomain>
 <21e86199-28a7-4693-aef5-5fc28842535c@huawei.com>
 <20180825071827.GD726@sol.localdomain>
 <c907ad1d-c7c8-714a-0e59-373c1df3afe8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c907ad1d-c7c8-714a-0e59-373c1df3afe8@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 03:43:43PM +0800, Gao Xiang wrote:
> > I don't know of any plan to use fs-verity on Android's system partition or to
> > replace dm-verity on the system partition.  The use cases so far have been
> > verifying files on /data, like APK files.
> > 
> > So I don't think you need to support fs-verity in EROFS.
> 
> Thanks for your information about fs-verity, that is quite useful for us
> Actually, I was worrying about that these months...  :)

I'll be even clearer --- I can't *imagine* any situation where it
would make sense to use fs-verity on the Android system partition.
Remember, for OTA to work the system image has to be bit-for-bit
identical to the official golden image for that release.  So the
system image has to be completely locked down from any modification
(to data or metadata), and that means dm-verity and *NOT* fs-verity.

The initial use of fs-verity (as you can see if you look at AOSP) will
be to protect a small number of privileged APK's that are stored on
the data partition.  Previously, they were verified when they were
downloaded, and never again.

Part of the goal which we are trying to achieve here is that even if
the kernel gets compromised by a 0-day, a successful reboot should
restore the system to a known state.  That is, the secure bootloader
checks the signature of the kernel, and then in turn, dm-verity will
verify the root Merkle hash protecting the system partition, and
fs-verity will protect the privileged APK's.  If malware modifies any
these components in an attempt to be persistent, the modifications
would be detected, and the worst it could do is to cause subsequent
reboots to fail until the phone's software could be reflashed.

Cheers,

					- Ted
