Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D97AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4E720833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4E720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeIZAts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:49:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIZAts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:49:48 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8B26B107E;
        Tue, 25 Sep 2018 18:40:56 +0000 (UTC)
Date:   Tue, 25 Sep 2018 20:40:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Tong Zhang <ztong@vt.edu>, tglx@linutronix.de,
        akpm@linux-foundation.org, linux@dominikbrodowski.net,
        ebiederm@xmission.com, keescook@chromium.org, Dave.Martin@arm.com,
        wolffhardt.schwabe@fau.de, yang.shi@linux.alibaba.com,
        linux-kernel@vger.kernel.org, wenbo.s@samsung.com
Subject: Re: different capability from different namespace required for
 prctl_set_mm_exe_file
Message-ID: <20180925184054.GA15291@kroah.com>
References: <990D0DB4-35C7-4B7B-A938-2B984CD97E78@vt.edu>
 <20180925173745.GA20508@kroah.com>
 <20180925183427.GH15710@uranus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925183427.GH15710@uranus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 09:34:27PM +0300, Cyrill Gorcunov wrote:
> On Tue, Sep 25, 2018 at 07:37:45PM +0200, Greg KH wrote:
> > On Tue, Sep 25, 2018 at 01:26:55PM -0400, Tong Zhang wrote:
> > > Kernel Version: 4.18.5
> > > 
> > > Problem Description:
> > > 
> > > We discovered inconsistent check when using prctl_set_mm_exe_file(), which is used to setup exe file link.
> > > 
> > > It is required to have capable(CAP_SYS_RESOURCE) in prctl_set_mm().
> > > while ns_capable(CAP_SYS_ADMIN) in prctl_set_mm_map().
> > > 
> > > There are two differences:
> > > 1)requiring capability from: user namespace, init namespace.
> > > 2)capability bit required is different
> > 
> > Can you submit a patch showing what you think is the correct fix here?
> 
> It is done this way on purpose. The prctl_set_mm_map is a complex call
> which carries a bunch of parameters and allowed if you're inside user-ns admin,
> in turn prctl_set_mm allows to modify settings one by one. So no, it is not
> an error but rather call specifics.

I was hoping that when the submitter went to create such a patch, they
would have realized that.  You learn more when trying to fix a problem
than when someone has to tell you the answers :)

thanks,

greg k-h
