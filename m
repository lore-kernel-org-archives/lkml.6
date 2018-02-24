Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeBXC7p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 21:59:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:59486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752253AbeBXC7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 21:59:44 -0500
Date: Sat, 24 Feb 2018 02:59:41 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [PATCH] lib/test_kmod: Fix an integer overflow test
Message-ID: <20180224025941.GB14069@wotan.suse.de>
References: <20180122102754.GD23912@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180122102754.GD23912@mwanda>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2018 at 01:27:54PM +0300, Dan Carpenter wrote:
> The main problem is that the parentheses are in the wrong place and the
> unlikely() call returns either 0 or 1 so it's never less than zero.

Doh, thanks, yes. Seems worth considering a grammar rule for it.

> The other problem is that signed integer overflows like "INT_MAX + 1" are
> undefined behavior.

Likewise.

This seems like another possible generic typo issue. But I would not resolve it
the way you did, in this particular case below num_test_devs represents the
number of already registered devs, before we increment. So the way to resolve
this would be:

	if (num_test_devs + 1 == INT_MAX)

I'll get this upstream, thanks!

  Luis

> Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/lib/test_kmod.c b/lib/test_kmod.c
> index e372b97eee13..30fd6d9e5361 100644
> --- a/lib/test_kmod.c
> +++ b/lib/test_kmod.c
> @@ -1141,7 +1141,7 @@ static struct kmod_test_device *register_test_dev_kmod(void)
>  	mutex_lock(&reg_dev_mutex);
>  
>  	/* int should suffice for number of devices, test for wrap */
> -	if (unlikely(num_test_devs + 1) < 0) {
> +	if (num_test_devs == INT_MAX) {
>  		pr_err("reached limit of number of test devices\n");
>  		goto out;
>  	}
> 

-- 
Luis Rodriguez, SUSE LINUX GmbH
Maxfeldstrasse 5; D-90409 Nuernberg
