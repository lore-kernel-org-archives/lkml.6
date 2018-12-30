Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22576C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 14:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD13221901
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546181319;
	bh=RhGUK6hGsKpMGmYyO6LnX86IanwvMpsjhxYVI2HAD1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h5+Af9JbPNUyXa7/wLEXn/fRYPEuwgE1Vaa60nwVTu9wDTUZ2m7MX5kVpsAPadCIE
	 qxxxO8taRyyi38XeFn8CWx/4OUOjnGXCH/VgV9vU+hcCXjgLxRosJmCdGl0Tl9qCwr
	 CiCmTrG+4OItmQcQWTcKpScmEPEmDvb0J7tl2LGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbeL3Osi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 09:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeL3Osi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 09:48:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D02E20811;
        Sun, 30 Dec 2018 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546181317;
        bh=RhGUK6hGsKpMGmYyO6LnX86IanwvMpsjhxYVI2HAD1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPaR/APwRRHuSuV2d+sHoRLKw4G7c1b4fQopEg3Sxzov1qgnQKHyt0881784IIiQk
         PQ2uDyDWNzwdMeHcGdfqAyLC3Q3RyyHU0V5fojjXjE55I6lQNRtiNLWtOMfhRxKX6V
         nBCC9WPFATvm1QgHsHH01md8sfxyDaIvPAT8GODs=
Date:   Sun, 30 Dec 2018 15:48:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>, Chen Yu <yu.c.chen@intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/2] PM / Sleep: Check the file capability when writing
 wake lock interface
Message-ID: <20181230144835.GB18985@kroah.com>
References: <20181230132856.24095-1-jlee@suse.com>
 <20181230132856.24095-3-jlee@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181230132856.24095-3-jlee@suse.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 09:28:56PM +0800, Lee, Chun-Yi wrote:
> The wake lock/unlock sysfs interfaces check that the writer must has
> CAP_BLOCK_SUSPEND capability. But the checking logic can be bypassed
> by opening sysfs file within an unprivileged process and then writing
> the file within a privileged process. The tricking way has been exposed
> by Andy Lutomirski in CVE-2013-1959.

Don't you mean "open by privileged and then written by unprivileged?"
Or if not, exactly how is this a problem?  You check the capabilities
when you do the write and if that is not allowed then, well

And you are checking the namespace of the person trying to do the write
when the write happens, which is correct here, right?

If you really want to mess with wake locks in a namespaced environment,
then put it in a real namespaced environment, which is {HUGE HINT} not
sysfs.

So no, this patch isn't ok...

thanks,

greg k-h
