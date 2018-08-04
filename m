Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA75C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 05:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CCB21775
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 05:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="p3Di7WUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CCB21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeHDHUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 03:20:05 -0400
Received: from imap.thunk.org ([74.207.234.97]:36424 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeHDHUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 03:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=eyRbIOy++1SQ0QjOX3jJd/TSPjlUqCYZr6nuf+XihHQ=; b=p3Di7WUO6bpaR95m4UW2V0wFnF
        q8Sf/sfxOeZr4ON0tHvb45TrC5qAVvmYDrGQAsGxuGPa3lBWDlpwLwq7Qn+ErQ37diH86KBOGv/Dz
        pSYvytdycsOWQIgnQFJFMmaZLgLSGLZmpSQjKm88JTK0dLZ5ECX++w6M7uk/IHhBRJds=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1flozS-0007xW-7p; Sat, 04 Aug 2018 05:20:34 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4EB607A64C9; Sat,  4 Aug 2018 01:20:33 -0400 (EDT)
Date:   Sat, 4 Aug 2018 01:20:33 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru
Subject: Re: [dm-devel] LVM snapshot broke between 4.14 and 4.16
Message-ID: <20180804052033.GA4461@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Mike Snitzer <snitzer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru
References: <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru>
 <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <b2bbd8ec-ac5b-fa8a-d3f7-8615d87f73c3@redhat.com>
 <CA+55aFwWZX=CXmWDTkDGb36kf12XmTehmQjbiMPCqCRG2hi9kw@mail.gmail.com>
 <20180803185431.GB3258@redhat.com>
 <CA+55aFwDEY7B6OMh5xL2wc8BRj1KkzBHggNowAjbsWfma6H5Zg@mail.gmail.com>
 <20180803193037.GA4581@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803193037.GA4581@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 03:30:37PM -0400, Mike Snitzer wrote:
> 
> I was trying to give context for the "best to update lvm2 anyway"
> disclaimer that was used.  Yeah, it was specious.

Well, it seemed to indicate a certain attitude that both Linus and I
are concerned about.  I tried to use more of a "pursuading" style to
impress why that attitude was not ideal/correct.  Linus used a much
more assertive style (e.g., "Hell, no!").

> And yeah, that isn't a good excuse to ignore it but: dm-snapshot is a
> steaming pile as compared to dm thin-provisioning...

On a side note, this is the first that I've heard the assertion that
dm-thin was better than dm-snapshot.  My impression was that
dm-snapshot was a proven code base, that only did one thing and (as
far as I could tell) did it well.  In contrast, dm-thin is much newer
code, **far** more complex, with functionality and corner cases
approaching that of a file system --- and just to be even more
exciting, it doesn't have an fsck/repair tool to deal with corrupted
metadata.

In your opinion, is it because you disagree with the assumption that
dm-thin is scary?  Or is the argument that dm-snapshot is even
scarier?

						- Ted

P.S.  It could be that my impression is wrong/out-dated, but the
kernel documentation still says that userspace tools for checking and
repairing the metadata are "under development".  As a file system
developer, the reaction this inspires is best summed up as:

     https://imgflip.com/memetemplate/50971393/Scared-Face
