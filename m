Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81EDC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618C920878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544104643;
	bh=jb7mWdCCcM/JZzzpNtw/VrA6Oy4txwyDIhWp2nvyNPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eYqr/jmUHwXbeTt8Ulw0sCi+Pxs6omg8RP2hz/iZ8vulzmWsHHtPMbnA38cYGD5tm
	 2rTar6YNvOMDUEjhQstQZ0+JooTWaicKpY1qALiPSq4VLQER2JjUDB7tlpjusvZASs
	 cZbDQwx4Y80DE2Dz/zwspEHWLDdG1mXyWyMC//iQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618C920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbeLFN5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbeLFN5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:57:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154D120672;
        Thu,  6 Dec 2018 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544104641;
        bh=jb7mWdCCcM/JZzzpNtw/VrA6Oy4txwyDIhWp2nvyNPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1RzrLepXqNWMzvOBI4go/oRqWznZriUGJyAjZd/58VWKXxGOODs/gb22sez8pyhW
         dPoWrlPw4/SMmsWjIM/qqG6n4wZgbMfnBmEU3cmL96Df1zy1giRkRufe6qKltSpLP3
         mNc1Lw6YXEqM2KFJWGuzhARwRilTGuqc0ZZf+Bpg=
Date:   Thu, 6 Dec 2018 14:57:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v2] ptp: fix an IS_ERR() vs NULL check
Message-ID: <20181206135719.GA18607@kroah.com>
References: <20181130163252.e6z33t23j3qud57z@localhost>
 <20181203105506.GA21127@unbuntlaptop>
 <20181204044257.grk3na2wyrx6nssg@localhost>
 <20181204070033.GG3073@unbuntlaptop>
 <20181204145538.dnyqlfspnpqmojop@localhost>
 <20181204151049.GK3073@unbuntlaptop>
 <20181206123843.f637bvkvzibev2p5@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206123843.f637bvkvzibev2p5@localhost>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 04:38:43AM -0800, Richard Cochran wrote:
> Greg,
> 
> On Tue, Dec 04, 2018 at 06:10:49PM +0300, Dan Carpenter wrote:
> > On Tue, Dec 04, 2018 at 06:55:38AM -0800, Richard Cochran wrote:
> > > On Tue, Dec 04, 2018 at 10:00:33AM +0300, Dan Carpenter wrote:
> > > > 
> > > > Why did you commit 3b1ad360acad ("pps: using ERR_PTR instead of NULL
> > > > while pps_register_source fails")?  You're not listed as a maintainer so
> > > > I wouldn't have known to CC you.
> > > 
> > > I'm confused.  Where is that commit?
> 
> ...
> 
> > I'm on linux-next but originally it came from the char-misc-next tree.
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-next
> 
> Commit 3b1ad360acad changes a return value in the PPS core, but it is
> missing the hunk for the caller in drivers/ptp/ptp_clock.c.  Can that
> be amended?

Send me a patch or tell me what I need to revert and I will be glad to
do so :)

thanks,

greg k-h
