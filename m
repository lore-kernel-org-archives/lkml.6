Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C08BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332DE21917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545400514;
	bh=eNap5BvKhkYocPucHi/N3yL1KQlZFe3gylWzY7OVazI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W+OP7jzJcd+d2X5op7+7uoj3TheikrzhcoWBPOTt6xJSOZjztcZRKG0nbd3Wufouu
	 7tC2ViqDjV99WkETSa1vDfCC93RjC/NsO0/w3HupOtOwdPF5BYIGsWz6epr8sAthnE
	 bshqZwKjWOdZG2E9TMzzkblS8xlWRjHPcMVQtRyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390788AbeLUNzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:55:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbeLUNzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:55:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F6E621917;
        Fri, 21 Dec 2018 13:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545400511;
        bh=eNap5BvKhkYocPucHi/N3yL1KQlZFe3gylWzY7OVazI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zh1kVU2rD9h4bUgDL4qz9w7j7x+hWFx1TZ9cfFq3VNA0F5jG9sVgs2ct38PGOQCB7
         fiZj1M18Du392QWmd7kkU3cq5UXFOT6zBmiokuhi+SVJtkkAfY32Pz2hP0HjPlmDas
         nAsynSE0qJLB/ciLaei2Tic88WWKJnKC4BFS8uxk=
Date:   Fri, 21 Dec 2018 14:55:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        arve@android.com, maco@android.com
Subject: Re: [PATCH] binderfs: implement sysctls
Message-ID: <20181221135509.GA30679@kroah.com>
References: <20181221133909.18794-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221133909.18794-1-christian@brauner.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 02:39:09PM +0100, Christian Brauner wrote:
> This implements three sysctls that have very specific goals:

Ick, why?

What are these going to be used for?  Who will "control" them?  As you
are putting them in the "global" namespace, that feels like something
that binderfs was trying to avoid in the first place.

> 1. /proc/sys/fs/binder/max:
>    Allow global root to globally limit the number of allocatable binder
>    devices.

Why?  Who cares?  Memory should be your only limit here, and when you
run into that limit, you will start failing :)

> 2. /proc/sys/fs/binder/nr:
>    Allow global root to easily detect how many binder devices are currently
>    in use across all binderfs mounts.

Why?  Again, who cares?

> 3. /proc/sys/fs/binder/reserved:
>    Ensure that global root can reserve binder devices for the initial
>    binderfs mount in the initial ipc namespace to prevent DOS attacks.

Huh?  Can't you just create your "global root" devices first?  Doesn't
the code do that already anyway?

And what kind of DoS attack could this ever prevent from anyway?

> This is equivalent to sysctls of devpts.

devpts isn't exactly the best thing to emulate :)

> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  drivers/android/binderfs.c | 81 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 79 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 7496b10532aa..5ff015f82314 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -64,6 +64,71 @@ struct binderfs_info {
>  
>  };
>  
> +/* Global default limit on the number of binder devices. */
> +static int device_limit = 4096;
> +
> +/*
> + * Number of binder devices reserved for the initial binderfs mount in the
> + * initial ipc namespace.
> + */
> +static int device_reserve = 1024;
> +
> +/* Dummy sysctl minimum. */
> +static int device_limit_min;
> +
> +/* Cap sysctl at BINDERFS_MAX_MINOR. */
> +static int device_limit_max = BINDERFS_MAX_MINOR;
> +
> +/* Current number of allocated binder devices. */
> +static atomic_t device_count = ATOMIC_INIT(0);

You have a lock you are using, just rely on that, don't create
yet-another-type-of-unneeded-lock with an atomic here.

Anyway, I really don't see the need for any of this just yet, so I
didn't read beyond this point in the code :)

thanks,

greg k-h
