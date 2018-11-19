Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFB6C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816C920831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Va0Iq0/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816C920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbeKTBjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:39:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbeKTBjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:39:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62B022086A;
        Mon, 19 Nov 2018 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542640553;
        bh=Tnie24KK0nINs6QndiQ/Jot0JgeKarpIoT2cWBy9cKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Va0Iq0/D4YKn74mQTQiK0yvnviWVZhLkzKjx7GRsE/fZMqpVMIzAdZs/mARMxbl7M
         wuKuu1m6sp7AEDyo7hsfjf6z8UUbWgm0xo+2RLDi8f6hbXwHAyn0Xq7D+/OyLvRpxB
         gIsR8exEG52o8QXQn6EWIOaQ5Sk8tz0DHAu+OteA=
Date:   Mon, 19 Nov 2018 16:15:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Steve McIntyre <93sam@debian.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 087/361] signal: Introduce COMPAT_SIGMINSTKSZ for
 use in compat_sys_sigaltstack
Message-ID: <20181119151551.GC5340@kroah.com>
References: <20181111221619.915519183@linuxfoundation.org>
 <20181111221632.025807083@linuxfoundation.org>
 <20181112114857.2aidwlw2podpzytb@tack.einval.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112114857.2aidwlw2podpzytb@tack.einval.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 11:49:05AM +0000, Steve McIntyre wrote:
> On Sun, Nov 11, 2018 at 02:17:14PM -0800, Greg Kroah-Hartman wrote:
> >4.19-stable review patch.  If anyone has any objections, please let me know.
> >
> >------------------
> >
> >From: Will Deacon <will.deacon@arm.com>
> >
> >[ Upstream commit 22839869f21ab3850fbbac9b425ccc4c0023926f ]
> >
> >The sigaltstack(2) system call fails with -ENOMEM if the new alternative
> >signal stack is found to be smaller than SIGMINSTKSZ. On architectures
> >such as arm64, where the native value for SIGMINSTKSZ is larger than
> >the compat value, this can result in an unexpected error being reported
> >to a compat task. See, for example:
> >
> >  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=904385
> 
> ...
> 
> Thanks Greg! If it's not too much effort, could you also take this for
> 4.9-stable as well please? That would get it into our next Debian
> stable update too. :-)

Does not apply to 4.9.y, can you provide a working backport?

thanks,

greg k-h
