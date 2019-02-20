Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A1220859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550675280;
	bh=QW/mfDoKHXjHb7T2AqZRYS+DJNaAsaYmpZOL9S0+pgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mL+oHhGFc/uX1kYcNgmgtCK2Dpn1tWhmkVV8ZKfXvwErC1sYQls4dzr0Gdm4C7Kez
	 3a0GO/cNLL0Q4BuKfzgJxVNwCA1IkHwnDLZGGMIySWIiDFiS2wsczloLcSvz40tJOS
	 upGQcp6xsV0cr5v/7izemzuSH43cklVFAcaoRXu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfBTPH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:07:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfBTPH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:07:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B07620859;
        Wed, 20 Feb 2019 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550675277;
        bh=QW/mfDoKHXjHb7T2AqZRYS+DJNaAsaYmpZOL9S0+pgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RAXAnvw6Q1VM6lOL95mIGEvZh+Qlg5/fWBsbLLKUdBg8MP7V4MFUmCOJO4nUo6HWC
         lR9+40mq0ZVmdlniYfG5bLuOVir1UUZZq5Od98h2UdsnLwriF85KOUfC1iBZbp9Grc
         pvwSYngx5Og3gOtlJRbqMlRj5HHXWNzRCjC1PB0A=
Date:   Wed, 20 Feb 2019 16:07:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kay Sievers <kay@vrfy.org>,
        syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
Subject: Re: [PATCH] kobject: Don't trigger kobject_uevent(KOBJ_REMOVE) twice.
Message-ID: <20190220150753.GB17103@kroah.com>
References: <1550669914-10704-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550669914-10704-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:38:34PM +0900, Tetsuo Handa wrote:
> syzbot is hitting use-after-free bug in uinput module [1]. This is because
> kobject_uevent(KOBJ_REMOVE) is called again due to commit 0f4dafc0563c6c49
> ("Kobject: auto-cleanup on final unref") after memory allocation fault
> injection made kobject_uevent(KOBJ_REMOVE) from device_del() from
> input_unregister_device() fail, while uinput_destroy_device() is expecting
> that kobject_uevent(KOBJ_REMOVE) is not called after device_del() from
> input_unregister_device() completed. Fix this problem by marking "remove"
> event done regardless of result.
> 
> [1] https://syzkaller.appspot.com/bug?id=8b17c134fe938bbddd75a45afaa9e68af43a362d
> 
> Reported-by: syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
> Analyzed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Kay Sievers <kay@vrfy.org>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  lib/kobject_uevent.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index f058026..7ec4165 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -466,6 +466,13 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
>  	int i = 0;
>  	int retval = 0;
>  
> +	/*
> +	 * Mark "remove" event done regardless of result, for some subsystems
> +	 * do not want to re-trigger "remove" event via automatic cleanup.
> +	 */
> +	if (action == KOBJ_REMOVE && kobj->state_add_uevent_sent)
> +		kobj->state_remove_uevent_sent = 1;
> +
>  	pr_debug("kobject: '%s' (%p): %s\n",
>  		 kobject_name(kobj), kobj, __func__);

If you really want to do this, put it below the debugging line.

But I would argue that this is not ok, as the remove uevent did NOT get
sent, and you are saying it did.

What memory is being used-after-free here when we fail to properly send
a uevent?  Shouldn't we fix up that problem correctly?

thanks,

greg k-h
