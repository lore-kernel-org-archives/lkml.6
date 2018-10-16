Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C78DC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544D920869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="iac40Rx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544D920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeJPJkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 05:40:01 -0400
Received: from imap.thunk.org ([74.207.234.97]:45588 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbeJPJkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 05:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0awaBIrNlz+LZ/rdVVLaloUEdaqZ8nWryIPbg9MybVA=; b=iac40Rx+YA7fJnhuSHhyhUAPrf
        Kc3Rs30VMusL9c9/0/+ZZUu5PuOKonl/aBn2gACt8x11ZYIJy2LcMdo+BAXvuQIUld+WkkHpiFm2c
        PTudARD+XRLnYn6Kt8NOiXGyMI03sqMttuKpKNMUsfNlyqESq0jcA9jvJWhH8ZYoVyIw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gCEWh-0004G4-EZ; Tue, 16 Oct 2018 01:52:03 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7BA447A4986; Mon, 15 Oct 2018 21:52:01 -0400 (EDT)
Date:   Mon, 15 Oct 2018 21:52:01 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     valdis.kletnieks@vt.edu
Cc:     Dennis Zhou <dennisszhou@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
Message-ID: <20181016015201.GB18547@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        valdis.kletnieks@vt.edu, Dennis Zhou <dennisszhou@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <13987.1539646128@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13987.1539646128@turing-police.cc.vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 07:28:48PM -0400, valdis.kletnieks@vt.edu wrote:
> 
> Traceback of the rm crash (I have *no* idea why it has systemd-tmpfile as Comm:
> as none of the tmpfile config reference /usr/src at all, and the config says it
> shouldn't have been running at the time of the crash, and I can't replicate as
> the directory is now empty...)

Given the commit that it bisected down to, I very much doubt it has
anything to do with a specific directory or pathname.  Either you or
your distribution has enabled blk cgroup for I/O throttling, and
there's some race that you're tripping across.  What ext4 file or
directory happens to be accessed when you trip across the problem is
probably just pure luck.

If you can disable the block I/O throttling configuration (which may
very well be distro-specific), the problem will probably go away.  I
don't use blkcg at all, personally, and on a personal laptop
(especially if you have an SSD), I really don't see the point.

Still, I'm sure the people who *do* use blkcg for real (mostly in data
centers, in my experience) will probably thank you for being a great
guinea pig.  :-)

						- Ted
