Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pb/EDdLLHFvdKwAAmS7hNA
	; Sun, 10 Jun 2018 06:57:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DDDBA60850; Sun, 10 Jun 2018 06:57:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmyG/kfm"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3209C606DD;
	Sun, 10 Jun 2018 06:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3209C606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753783AbeFJG5b (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 02:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753674AbeFJG5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 02:57:30 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFE6A20858;
        Sun, 10 Jun 2018 06:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528613849;
        bh=yHQxeCcINGqHjrcxLuXhn13oS2byisnX04xhjsKOpF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmyG/kfmqrLDmpY3dY+tYkNcxF1o1hw+u0yi+vLEXCSqaAZIgNzxHzDofc/+gbNc6
         vmbf5nnejMn2GjIiFJDJzw0UDjuRv2kl5X9d/HlqU2eLwjqnLPP4GomFiRiPGcYO8d
         6bprL+DcEYAYILWL7sn+lQ4dpl5D322IQCt5DJXY=
Date: Sun, 10 Jun 2018 08:57:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/15] fsi: Overall improvements and new SBE fifo driver
Message-ID: <20180610065706.GA17389@kroah.com>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
 <CACPK8XdvnGHz6Om2RQmgu+7F4h9AEh+Ay=A_b4+3vDGqD4SKbA@mail.gmail.com>
 <626a3d2bc30dac29c06ab44fb2c56d17095fca51.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626a3d2bc30dac29c06ab44fb2c56d17095fca51.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 04:46:53PM +1000, Benjamin Herrenschmidt wrote:
> (Greg, see below)
> 
> On Tue, 2018-05-29 at 22:00 +0930, Joel Stanley wrote:
> > On 29 May 2018 at 11:00, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > > This series brings in a number of improvements to our FSI stack
> > > (one of the service interfaces for communicating between a BMC chip and
> > > our POWER processors).
> > > 
> > > The GPIO based "Soft FSI" performance is significantly improved, and
> > > it's reliability as well.
> > > 
> > > The SBE fifo driver provides the interface to the processor "Self Boot
> > > Engine"
> > > 
> > > Some of these patches have been simmering for a while in the OpenBMC
> > > tree.
> > 
> > I run this series atop of 4.17-rc7 today, and they look solid.
> > 
> > Tested-by: Joel Stanley <joel@jms.id.au>
> 
> So how do we proceed ? I have more coming on top of this, but we should
> start with getting this series merged.
> 
> Greg, should we create a FSI git repo with a 3-member maintainer team
> (Jeremy, Chris and myself) and send you pull requests ? Or are you
> happy to continue picking up patches ?

Which ever is best/easiest for you is fine with me, I can work either
way just fine.

> We have more stuff to come in there, including support for a HW master
> contoller in a future BMC chip, some more slave drivers, etc..
> 
> It also looks like the s390 guys might start using some of that as well
> (their chips use FSI as well, so far they used our old service
> processor which uses an ancient non-uptream set of drivers & stack, but
> that's likely to change).

Then maybe a git tree is easiest for all of you to work against?

thanks,

greg k-h
