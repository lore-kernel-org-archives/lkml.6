Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2607C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773DF204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="EDawwX8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773DF204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbeJAWDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:03:53 -0400
Received: from imap.thunk.org ([74.207.234.97]:36736 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729439AbeJAWDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=56VrLbx0piItw7J2oVlCKP4F9OkbDP2PXVchbORTtEY=; b=EDawwX8NvzH8w182mxZ7LFB3gJ
        38+4nmBB5hOAqPKVwwefrJCktRL5YrMAwViDNbWECdSEv9XxtZVJYY3kDngjItfbYluFxo3QN56kL
        NkfjsElkHy0PcL1tbC6kaRwfGPQucKyoFx4dqUh3Ma4RLITqP7elhocR5MI/JI/OkNkg=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g704g-0008Jk-72; Mon, 01 Oct 2018 15:25:30 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7B8867A5186; Mon,  1 Oct 2018 11:25:29 -0400 (EDT)
Date:   Mon, 1 Oct 2018 11:25:29 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Dave Chinner <david@fromorbit.com>, TongZhang <ztong@vt.edu>,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
Subject: Re: Leaking Path in XFS's ioctl interface(missing LSM check)
Message-ID: <20181001152529.GA2549@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Dave Chinner <david@fromorbit.com>, TongZhang <ztong@vt.edu>,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
References: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu>
 <20180926013329.GD31060@dastard>
 <20180926192426.472360ea@alans-desktop>
 <20180927013812.GF31060@dastard>
 <20180930151652.6975610c@alans-desktop>
 <20181001002521.GM31060@dastard>
 <20181001160442.47c798bc@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001160442.47c798bc@alans-desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 04:04:42PM +0100, Alan Cox wrote:
> > Systems restricted by LSMs to the point where CAP_SYS_ADMIN is not
> > trusted have exactly the same issues. i.e. there's nobody trusted by
> > the kernel to administer the storage stack, and nobody has defined a
> > workable security model that can prevent untrusted users from
> > violating the existing storage trust model....
> 
> With a proper set of LSM checks you can lock the filesystem management
> and enforcement to a particular set of objects. You can build that model
> where for example only an administrative login from a trusted console may
> launch processes to do that management.
> 
> Or you could - if things were not going around the LSM hooks.

It would be useful if anyone actually *wants* to do this thing to
define a formal security model, and detail *everything* that would
need to be changed in order to accomplish it.  Just as we don't
speculatively add code "just in case" someone might want to use it
someday, I don't think we should be adding random LSM hooks just
becausre someone *might* want do something.

Let's see the use case, and let's see how horrible the changes would
need to be, and how credible we think it is that someone will actually
want to *use* it.  I suspect the chagnes will be a really huge number
of places, and not just in XFS....

					- Ted
