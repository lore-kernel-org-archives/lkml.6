Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD617ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 15:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D0321477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 15:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Eqo/AO3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D0321477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeIOUqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 16:46:32 -0400
Received: from imap.thunk.org ([74.207.234.97]:36346 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbeIOUqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 16:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ouJYJf9Ynv4x3YlG46BxmqHRpVy2LHKS5G8T2JjaGbs=; b=Eqo/AO3HwYU0Ii+Ov5yeXZH7w2
        5eyadTQK934jd1ZeTyjJK6W7zMDU4kEuskx2UjF6D2bTzuZ8lmimnUw27cKfzfLLG41CaKAvoHF+9
        BrP6MXFHywPQHlyK2taeRZ7erWkjlbsRYIg0W5nLzLka5Sk6Bw501XwW/OavV2WokpqM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g1CTQ-0001wb-BG; Sat, 15 Sep 2018 15:27:04 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 31FCD7A5855; Sat, 15 Sep 2018 11:27:03 -0400 (EDT)
Date:   Sat, 15 Sep 2018 11:27:03 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [RFC PATCH 01/10] fs-verity: add setup code, UAPI, and Kconfig
Message-ID: <20180915152703.GA9979@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-2-ebiggers@kernel.org>
 <1535132549.2855027.1485213752.129E3334@webmail.messagingengine.com>
 <20180825044852.GB726@sol.localdomain>
 <1536930930.1003187.1508104496.6465C44D@webmail.messagingengine.com>
 <20180914162142.GA734@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914162142.GA734@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 09:21:43AM -0700, Eric Biggers wrote:
> > 
> > Now AIUI, Zip files have an internal header that contains e.g. the size and
> > indexes into the internal files.  So if someone added random data to the end
> > of a zip file, nothing is going to end up actually reading it.
> 
> After the verity bit is enabled, the verity metadata is not visible to
> userspace.  Yes, that means i_size is adjusted too.  Also all contents
> modifications are denied, including appends.

One of this reasons why this is important is that ZIP files *also*
have an central directory at the end.  And in the case of the APK
files, there is an in-band signature block which is located at at the
end of the last file and the central directory, which can be located
by starting at the end of the file, finding the length of the central
directory, and then backing up to find the signature block.

    	 	       	    		- Ted
