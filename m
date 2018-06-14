Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 45794C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B2C208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Isux6vGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B2C208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbeFNFvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752719AbeFNFvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:51:06 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32C06208D4;
        Thu, 14 Jun 2018 05:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528955466;
        bh=EO5T3EbOzwnX46fa3086X79EQ16CnfIaVZ4beg6QvmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Isux6vGnWbqKFWHT/wj3GjkR2Gpff/qfv9qOyIKO/6JotNtO8KkCujgCeuVg7ut5g
         xG+dgNGmQok+OB3McNGpbE0ec2DuQ4nb4P6Popx/aHJmN9xsi02dH84V/AFTTg8A4D
         mP5xrMs3yhGNGjDUL9o3GV5NeTzlPh/uNuC+a8jk=
Date:   Thu, 14 Jun 2018 07:50:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Xavier Deguillard <xdeguillard@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] vmw_balloon: fix inflation of 64-bit GFNs
Message-ID: <20180614055042.GA31687@kroah.com>
References: <20180613135412.81660-1-namit@vmware.com>
 <20180613135412.81660-2-namit@vmware.com>
 <20180614052336.GA29739@kroah.com>
 <485C5DF2-52FB-487C-AF65-096D74E9416B@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <485C5DF2-52FB-487C-AF65-096D74E9416B@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 05:41:01AM +0000, Nadav Amit wrote:
> at 10:23 PM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Jun 13, 2018 at 06:54:06AM -0700, Nadav Amit wrote:
> >> When balloon batching is not supported by the hypervisor, the guest
> >> frame number (GFN) must fit in 32-bit. However, due to a bug, this check
> >> was mistakenly ignored. In practice, when total RAM is greater than
> >> 16TB, the balloon does not work currently, making this bug unlikely to
> >> happen.
> >> 
> >> Fixes: ef0f8f112984 ("VMware balloon: partially inline vmballoon_reserve_page.")
> >> 
> >> Cc: stable@vger.kernel.org
> > 
> > Again, no blank line between these things.
> > 
> > Also, please break this up into two different patch series.  One for
> > 4.18-final and one for 4.19-rc1.  You should always split up bugfixes
> > from new features/cleanups as that is what I have to do when sending
> > them to Linus.
> 
> I have only sent what I thought is appropriate for 4.18 (cleanup/features 
> will be sent separately):
> 
> * 5 bug fixes (1-5/7)
> * 1 update the maintainer list (7/7)
> * 1 update to the comment to prevent checkpatch from complaining (6/7)
> 
> If you think any patch is unsuitable to 4.18 - please say which.

How do I know which patch goes to which branch?  Please make it so
obvious I can not get it wrong.  Remember, I get 1000 emails a day, you
don't want me to have to make a judgement call about anything, as I will
mess it up  :)

thanks,

greg k-h
