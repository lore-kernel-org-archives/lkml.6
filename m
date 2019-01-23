Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37877C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38B921019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548239489;
	bh=1W65/kSWQi/7rtz9edshN64qZnEzVMGgoS2BOcN2QXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fvXbAmOc7FxCx7ItVyvNs1chSwjHkyFQHhK3bu5tbzvopO3li1XapfTi4ImN6Dyma
	 Em6Stnk19A3xqWiW34bAhGdyFLGcQRMctIT16d2fQDfx+BlNJPhVd+Q9UlACyhmrWi
	 1vbbRZx57T80uJSlDKoVzwDZArVCwdyCDRBZuWSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfAWKb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:31:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfAWKb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:31:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AA0D20861;
        Wed, 23 Jan 2019 10:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548239484;
        bh=1W65/kSWQi/7rtz9edshN64qZnEzVMGgoS2BOcN2QXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUMSNBkE8gTzwrHnGdy5ThwJVc1/bgbKyI9fsslsmwSCyazUSXfypQsdq0NgkFz+a
         y/OvfhGKCRCJg6UwXETPgmQ4mJzJdbj8fDt7+P22DYbQ5Oorj4DP2LlobeTID391Os
         rgANKajcut0TGGWjFhTAKsUCBR0IzGAhW85eONXY=
Date:   Wed, 23 Jan 2019 11:31:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Gary R Hook <ghook@amd.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] debugfs: return error values, not NULL
Message-ID: <20190123103122.GE17123@kroah.com>
References: <20190123102702.GA17123@kroah.com>
 <20190123102814.GB17123@kroah.com>
 <20190123102930.GC17123@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123102930.GC17123@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:29:30AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 23, 2019 at 11:28:14AM +0100, Greg Kroah-Hartman wrote:
> > When an error happens, debugfs should return an error pointer value, not
> > NULL.  This will prevent the totally theoretical error where a debugfs
> > call fails due to lack of memory, returning NULL, and that dentry value
> > is then passed to another debugfs call, which would end up succeeding,
> > creating a file at the root of the debugfs tree, but would then be
> > impossible to remove (because you can not remove the directory NULL).
> > 
> > So, to make everyone happy, always return errors, this makes the users
> > of debugfs much simpler (they do not have to ever check the return
> > value), and everyone can rest easy.
> > 
> > Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Reported-by: Gary R Hook <ghook@amd.com>
> > Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Oops, also reported by:
> 	Sebastian Andrzej Siewior <bigeasy@linutronix.de>

And also reported by:
	Michal Hocko <mhocko@kernel.org>

I should have checked my inbox better...
