Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2CAC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BB7208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544100602;
	bh=/Dvw4wp6P6s5iK4EZUDnjkxQ3J7Mcv/P4lyEgMWC8Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ilbg1I2Y/hqcATI6p+fY1GG60KGVJ+iNTVdAxIzDHWCI5qnJCng+VbFEF1K7tHL5e
	 3/trCiyzIDVv0c0AeTJjB3WIWRAnAnWCqoyLDkrjzHjYzdUcuTtnlWeiIXBEDS4wfN
	 E5SMgY2J9tV73bDkdC04XwGhlb7nbl9kpvZ519ug=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BB7208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbeLFMuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:50:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729404AbeLFMuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:50:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4075D20878;
        Thu,  6 Dec 2018 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544100599;
        bh=/Dvw4wp6P6s5iK4EZUDnjkxQ3J7Mcv/P4lyEgMWC8Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yHnFEtaOTdlRA8jGXdag+pD+A6TtKl5ApCTbnsJEaZdNcRldvRdz8xyrClmlCummm
         d6Q9oBTSCuLniWsWwF9CgFtpyBq0t2K3fRnNSfx55RTwFL2wsG3c2fhlfLI+fqaCFs
         v6yaNqIEFj79BGIPxZCwkmDHFXmo2MDDQQqubU1U=
Date:   Thu, 6 Dec 2018 13:49:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiaozhou Liu <lxz1983@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Compiler Attributes: move kernel-only attributes into
 __KERNEL__
Message-ID: <20181206124957.GA22907@kroah.com>
References: <20181128140852.178260-1-liuxiaozhou@bytedance.com>
 <CANiq72kzHqQ-M2Gyrf7iy1BQMabM6txChYwa8hrDkMmc3w8ORw@mail.gmail.com>
 <20181129021635.rzmehzzfgt2jvpgi@bytedancedeMacBook-Air.local>
 <CANiq72=uwbHqPB_1b7q+dD7FaqZ+HOmOvXMPX3d=z7-xqzwFzQ@mail.gmail.com>
 <20181206123926.q5gd5u62vg2u7s5w@bytedancedeMacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206123926.q5gd5u62vg2u7s5w@bytedancedeMacBook-Air.local>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 08:39:26PM +0800, Xiaozhou Liu wrote:
> On Thu, Nov 29, 2018 at 11:42:11AM +0100, Miguel Ojeda wrote:
> 
> > Exactly, thanks a lot for clarifying it up (we should put this in the
> > commit message, I would say). That also answers my question: it is
> > clear everything should be back into __KERNEL__. The only worry is
> > that the v4.19 release contained 815f0ddb346c, so it has them exposed,
> > so someone could have started relying on them. Or, more likely, the
> > exposed macros could break some source code out there. Hm... Should a
> > "fix" be backported?
> 
> What about letting v4.19 maintainers make the decision?

If something is fixed in Linus's tree for this, I want to take it into
the 4.19-stable tree as well.

thanks,

greg k-h
