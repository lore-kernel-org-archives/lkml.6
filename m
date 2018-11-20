Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47816C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CF22087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwVxtBUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CF22087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbeKUD2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:28:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730398AbeKUD2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:28:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE2720831;
        Tue, 20 Nov 2018 16:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542733125;
        bh=0fY4+Pq/ps3B+xEtxzaTUZB1dmaa40kSDRXk2cI3+R0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwVxtBUXmYx44D+9oRYMaRL8eYYLO5oLqkF1gIXYyrPK1k5YfkUOdkVLeE96/xTpF
         /ZCPdYrE0f9kAK3UX2bs+6wlpL4RGCi+sOxxoRQcSnqjZeIUSAs8jhK8tLM3sTZ9No
         raHd8HdOnRndTDQZunV5oKz30nY4n8A51UOAvyn4=
Date:   Tue, 20 Nov 2018 17:58:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Radu Rendec <radu.rendec@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Improve kernfs_notify() poll notification latency
Message-ID: <20181120165842.GB28793@kroah.com>
References: <20181116020954.24924-1-radu.rendec@gmail.com>
 <20181116020954.24924-2-radu.rendec@gmail.com>
 <20181120161419.GS2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120161419.GS2509588@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 08:14:19AM -0800, Tejun Heo wrote:
> On Thu, Nov 15, 2018 at 09:09:54PM -0500, Radu Rendec wrote:
> > kernfs_notify() does two notifications: poll and fsnotify. Originally,
> > both notifications were done from scheduled work context and all that
> > kernfs_notify() did was schedule the work.
> > 
> > This patch simply moves the poll notification from the scheduled work
> > handler to kernfs_notify(). The fsnotify notification still needs to be
> > done from scheduled work context because it can sleep (it needs to lock
> > a mutex).
> > 
> > If the poll notification is time critical (the notified thread needs to
> > wake as quickly as possible), it's better to do it from kernfs_notify()
> > directly. One example is calling sysfs_notify_dirent() from a hardware
> > interrupt handler to wake up a thread and handle the interrupt in user
> > space.
> > 
> > Signed-off-by: Radu Rendec <radu.rendec@gmail.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Greg, can you please route this one?

Sure, I'll queue it up soon...

greg k-h
