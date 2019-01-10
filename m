Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEB6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB412173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547128317;
	bh=eqwyh473IZuRFlKsuc0i8qWVAcUW9z2gIpKxXzlnfX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yCO/YwEvVBeDVHlTTwjRKuFqU4zrplqOSFqaSmDvTTbjxUxbjHrp5MYvkxuFKRibU
	 tjUgktu1ccPL5gSn0Sx9Zf7TWi0zz4eJTsA6Yit+uJb1d6l2ECUgRLbOiq2tAPRy68
	 cBh99U9n4eCZNDj3OFarUjAGY7+SRUoXQgJ1eh7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfAJNv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:51:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727684AbfAJNv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:51:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D21E20879;
        Thu, 10 Jan 2019 13:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547128315;
        bh=eqwyh473IZuRFlKsuc0i8qWVAcUW9z2gIpKxXzlnfX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRrVP2Z9BgzulWSU7SxxD8BBCX9vA02piVjnPaEbf3C/X4S8xJcqTYqna4PFDattT
         ZghmtxIUKrdBrw6T88DCMDoky/3/8n8OjOQwwBQbaRMji39B9DsdVPWJOZEZOe1pH6
         K2BvKl51Agv/25uTVnYjyB64YTlly8PxCvUVu1AY=
Date:   Thu, 10 Jan 2019 14:51:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] reduce tty latency
Message-ID: <20190110135153.GA9966@kroah.com>
References: <20190110101232.9398-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110101232.9398-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:12:29AM +0100, Oleksij Rempel wrote:
> This patch set is reducing latency on tty path.
> For testing I used hackbench running on all cores of 4 core system and
> high prioritized application sending and receiving packets over tty interface
> with loop-back adapter.

Odd, all of these ended up in my spam folder, you might want to check
your server email settings...

> Results without this patches:
>         latency histogram:
>             0 ... <     250 usec : 1933104 transmissions
>           250 ... <     500 usec : 21339 transmissions
>           500 ... <     750 usec : 8952 transmissions
>           750 ... <    1000 usec : 6226 transmissions
>          1000 ... <    1500 usec : 7688 transmissions
>          1500 ... <    2000 usec : 5236 transmissions
>          2000 ... <    5000 usec : 11724 transmissions
>          5000 ... <   10000 usec : 3588 transmissions
>         10000 ... <   50000 usec : 2123 transmissions
>         50000 ... < 1000000 usec : 20 transmissions
>                  >= 1000000 usec : 0 transmissions
> 
> Test results after this patches:
>         min latency: 0 sec : 75 usec
>         max latency: 0 sec : 125 usec
>         average latency: 81 usec
>         latency measure cycles overall: 79000000
>         latency histogram:
>             0 ... <     250 usec : 79000000 transmissions
>           250 ... <     500 usec : 0 transmissions
>           500 ... <     750 usec : 0 transmissions
>           750 ... <    1000 usec : 0 transmissions
>          1000 ... <    1500 usec : 0 transmissions
>          1500 ... <    2000 usec : 0 transmissions
>          2000 ... <    5000 usec : 0 transmissions
>          5000 ... <   10000 usec : 0 transmissions
>         10000 ... <   50000 usec : 0 transmissions
>         50000 ... < 1000000 usec : 0 transmissions
>                  >= 1000000 usec : 0 transmissions
>         average no. of read calls to assemble the packet: 1 

Like Linus said, who runs a real-world system that cares about this
latency measurement?

Yes, it might be fun for odd benchmarks to show the value of one RT
patchset/OS vs. another one, but this change can cause real issues in
real systems that do real, non-serial-loopback work.

thanks,

greg k-h
