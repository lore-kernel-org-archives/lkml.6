Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86781C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B1E21855
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548407021;
	bh=Vsk+Q9UdItykUbtxgnQXLTsS3JMCEw9vWXLIwMm6Sm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PT8SUSrEfkQCgD/gLkoEqgHyoeWOsRtSZ3IKKo0l1N3V1vRGL75esL73cmi6ef1Bk
	 3hCPJwvtmz5AyIyURCup9ZU/0tUsHr6GQIhIWb8llHqpRd1cZrlujFhWCPUT7dPY7m
	 lRpCexsE9vbzC1+N6F12UaQ2Pk6tpwiPMa82lfug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfAYJDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:03:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfAYJDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:03:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D3D6217D7;
        Fri, 25 Jan 2019 09:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548407018;
        bh=Vsk+Q9UdItykUbtxgnQXLTsS3JMCEw9vWXLIwMm6Sm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2JCmWonr59ix+AGpXn3drpEoBjSoxDWTuE+0xugO48kFLophnte9Q++ZH9+pugtad
         WFULE4fmllmI6A8bAaisKNxREqN9elulqJo3goYdFhoJb7k2Y4PVtLBZL60e4ls49o
         vd75ZkgCNRLx3axIdaHrUvJK6H51/cPQIpo68unI=
Date:   Fri, 25 Jan 2019 10:03:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     thomas@winischhofer.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] tty: sisusb_con, convert addr macros to functions
Message-ID: <20190125090328.GA11818@kroah.com>
References: <20190122151202.18152-1-jslaby@suse.cz>
 <20190122152322.GA17676@kroah.com>
 <15c671db-581d-7155-ea40-40d239069cb4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15c671db-581d-7155-ea40-40d239069cb4@suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:26:12PM +0100, Jiri Slaby wrote:
> On 22. 01. 19, 16:23, Greg KH wrote:
> > On Tue, Jan 22, 2019 at 04:11:59PM +0100, Jiri Slaby wrote:
> >> Convert SISUSB_VADDR and SISUSB_HADDR to inline functions. Now, there
> >> are no more hidden accesses to local variables (vc_data and
> >> sisusb_usb_data).
> >>
> >> sisusb_haddr returns unsigned long from now on, not u16 *, as ulong is
> >> what every caller expects -- we can remove some casts.
> >>
> >> Call sites were aligned to be readable too.
> >>
> >> Use sisusb_haddr on 4 more places in sisusbcon_blank and
> >> sisusbcon_scroll. It was open coded there with [x, y] being [0, 0].
> >>
> >> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> >> ---
> >>  drivers/usb/misc/sisusbvga/sisusb_con.c | 78 ++++++++++++-------------
> >>  1 file changed, 39 insertions(+), 39 deletions(-)
> > 
> > Subject says "tty", yet this is the USB driver.  typo?
> 
> Originally, I had these as a part of various tty cleanups and the tty
> remained there. I will wait for some feedback, if any and drop them in
> v2.

No problem, I fixed it up and queued it up already, as it looks good,
thanks!

greg k-h
