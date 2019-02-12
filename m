Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067D6C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACC92070D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549959934;
	bh=+Fd0EwoqWU/kz4L0k58lT9or/eJJ9P6/DgNPCoknYmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0ZjXm0W4mEUmw5XNOEGHaWCvf5+D4cH/1DzYtIwj5MoQ4uxUX3LIB+7a0p95NvdMw
	 gUd4V6T0b27aYmNb/wtze7piaLdzkfgYIzMfXTlA5mJ+1q8n8S4p6NyJV/hUevshD8
	 ePRLxDj5HbIZSEr1Jp/q42yWFSJh8IPFU29HkZ1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfBLIZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:25:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:32984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfBLIZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:25:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E9F72070D;
        Tue, 12 Feb 2019 08:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549959932;
        bh=+Fd0EwoqWU/kz4L0k58lT9or/eJJ9P6/DgNPCoknYmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRufwKv4/Ur9qK9i3CEi8Cs9E4TUpr37mUp81/orBP2Csv/XAcmRXG2cVOXEzIhMy
         YwgCt8Ql7xfsLWbkHwlT8LQEHQ4woygwE++mOD9u8RkdFecQJBW6jxT+kwirMnNCYT
         Y7GWI93immvQTeXvgZ+pWdflT+X2LWUdGmP1hlLA=
Date:   Tue, 12 Feb 2019 09:25:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: RFC: drop ISA support in the synlink tty driver?
Message-ID: <20190212082517.GA27889@kroah.com>
References: <20190211132534.29407-1-hch@lst.de>
 <20190212075151.GA7588@kroah.com>
 <7585c8b6-6dc4-2556-d14f-2fd60dc7df90@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7585c8b6-6dc4-2556-d14f-2fd60dc7df90@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 09:08:41AM +0100, Jiri Slaby wrote:
> On 12. 02. 19, 8:51, Greg Kroah-Hartman wrote:
> > On Mon, Feb 11, 2019 at 02:25:33PM +0100, Christoph Hellwig wrote:
> >> Hi Greg and Jiri,
> >>
> >> I've been working hard to get rid of the remaining callers the pass a
> >> NULL struct device to the DMA mapping functions and am almost done.
> >>
> >> The only non-trivial driver is the synclink driver, which has legacy
> >> early 90s style ISA support that doesn't use the device model at all.
> >>
> >> In theory we could convert it to an isa_driver, but without testing
> >> that seems rather dangerous.  So for now I would suggest that we
> >> remove the ISA support in this driver - if anyone cares enough we
> >> can resurrect it from the git history and convert it to use the driver
> >> model.
> > 
> > No objection from me at all, I'll go queue this up now, thanks.
> 
> Agreed, but I would kill also the MGSL_BUS_TYPE_ISA macro proper.

It's just a #define, in a uapi file, so we should probably leave it as
userspace programs _might_ depend on it.  I have no idea why, but oh
well...

thanks,

greg k-h
