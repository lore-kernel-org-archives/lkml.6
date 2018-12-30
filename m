Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F0DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 14:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB15A20861
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546181113;
	bh=lA4yNxPuJYO4NYzrU00ULPlIXQ6YvfeOi1LADggBJy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FoRUUCm7bUQBfgYf37/lDKUE1EDqv9vLS5iBjNJqVrJwTlt0OJK3Ym/jwJt0TQZLk
	 ZE+ZwpFuA6I+cSXQJJLBE/7c07r1Zkyrr2SMon+VkE8bYgoyYfIaWOqpuh2G4oCls9
	 IWLPevTaZ4NpOROcHJVjMW5DYYD5gZfbn2Q/UJ4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeL3OpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 09:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeL3OpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 09:45:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0A0920811;
        Sun, 30 Dec 2018 14:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546181108;
        bh=lA4yNxPuJYO4NYzrU00ULPlIXQ6YvfeOi1LADggBJy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEg0F+XxTQft84YsXMjD9uo9V4h7hiweAiTkIGdoQ77MSueijriuXtl2Mb4Tsk2eH
         9aqojpW/GGp9kLMzjEoCx71o6HFoRRDASXxHOyxU0lTCb7Je9miRtZL1B11qB/4wbR
         nQo4C3SNsDzgJ9stotUlb35Oa5TUTn2f0eLtrdNU=
Date:   Sun, 30 Dec 2018 15:45:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>, Chen Yu <yu.c.chen@intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 0/2] [RFC] sysfs: Add hook for checking the file
 capability of opener
Message-ID: <20181230144506.GA18985@kroah.com>
References: <20181230132856.24095-1-jlee@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181230132856.24095-1-jlee@suse.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 09:28:54PM +0800, Lee, Chun-Yi wrote:
> There have some discussion in the following mail loop about checking
> capability in sysfs write handler:
>     https://lkml.org/lkml/2018/9/13/978

A sysfs callback should not care about stuff like this.

Worst case, do a simple:
	if (!capable(CAP_FOO))
		return -EPERM

you don't care or need to worry about the file handle for that at all,
right?

> Sometimes we check the capability in sysfs implementation by using
> capable function.

Which should be fine, right?

> But the checking can be bypassed by opening sysfs
> file within an unprivileged process then writing the file within a
> privileged process. The tricking way has been exposed by Andy Lutomirski
> for CVE-2013-1959.

And who does this for a sysfs file?  And why?

> Because the sysfs_ops does not forward the file descriptor to the
> show/store callback, there doesn't have chance to check the capability
> of file's opener.

Which is by design.  If you care about open, you are using sysfs wrong.

> This patch adds the hook to sysfs_ops that allows
> different implementation in object and attribute levels for checking
> file capable before accessing sysfs interfaces.

No, please no.

> The callback function of kobject sysfs_ops is the first implementation
> of new hook. It casts attribute to kobj_attribute then calls the file
> capability callback function of attribute level. The same logic can
> be implemented in other sysfs file types, like: device, driver and
> bus type. 
> 
> The capability checking logic in wake_lock/wake_unlock sysfs interface
> is the first example for kobject. It will check the opener's capability.

Why doesn't the file permission of that sysfs file determine who can or
can not write to that file?

thanks,

greg k-h
