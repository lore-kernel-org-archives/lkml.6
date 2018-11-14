Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CFCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692EE22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxVIMtpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692EE22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeKOJHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:07:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:54074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeKOJHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:07:45 -0500
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 227C52175B;
        Wed, 14 Nov 2018 23:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542236549;
        bh=udYU6pD/2YCdcxf5pfNMwEq5nm32L1u51rqIZitrVwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RxVIMtpexQMgZVMvPMgGL/sR+yp7FY9IJzbdnmSOyaYWFjRABCEiqu42gl6bUaLo6
         VqoM0CAer5G72gfTWDNUvwWG9Qcmucgx+SeZQtOUuqsb68ejb+ccOjXdjoqL3lIErQ
         FvxZuLyM6qUzqGthWHlYtYyUzrPw6ZTemrR5pSZU=
Date:   Wed, 14 Nov 2018 15:02:28 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] sysrq: Use panic() to force a crash
Message-ID: <20181114230228.GA17998@kroah.com>
References: <20180920171253.115372-1-mka@chromium.org>
 <20181114225718.GN22824@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114225718.GN22824@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 02:57:18PM -0800, Matthias Kaehlcke wrote:
> On Thu, Sep 20, 2018 at 10:12:53AM -0700, Matthias Kaehlcke wrote:
> > sysrq_handle_crash() currently forces a crash by dereferencing a
> > NULL pointer, which is undefined behavior in C. Just call panic()
> > instead, which is simpler and doesn't depend on compiler specific
> > handling of the undefined behavior.
> > 
> > Remove the comment on why the RCU lock needs to be released, it isn't
> > accurate anymore since the crash now isn't handled by the page fault
> > handler (for reference: the comment was added by commit 984cf355aeaa
> > ("sysrq: Fix warning in sysrq generated crash.")). Releasing the lock
> > is still good practice though.
> > 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/tty/sysrq.c | 13 +++----------
> >  1 file changed, 3 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > index 06ed20dd01ba..d779a51499a0 100644
> > --- a/drivers/tty/sysrq.c
> > +++ b/drivers/tty/sysrq.c
> > @@ -134,17 +134,10 @@ static struct sysrq_key_op sysrq_unraw_op = {
> >  
> >  static void sysrq_handle_crash(int key)
> >  {
> > -	char *killer = NULL;
> > -
> > -	/* we need to release the RCU read lock here,
> > -	 * otherwise we get an annoying
> > -	 * 'BUG: sleeping function called from invalid context'
> > -	 * complaint from the kernel before the panic.
> > -	 */
> > +	/* release the RCU read lock before crashing */
> >  	rcu_read_unlock();
> > -	panic_on_oops = 1;	/* force panic */
> > -	wmb();
> > -	*killer = 1;
> > +
> > +	panic("sysrq triggered crash\n");
> >  }
> >  static struct sysrq_key_op sysrq_crash_op = {
> >  	.handler	= sysrq_handle_crash,
> 
> Does this need further changes or is it ready to land?

Ugh, it somehow got dropped from my queue, sorry.  I'll add it back and
get to it next week, my fault.

greg k-h
