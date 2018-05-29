Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754716AbeE2Grb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:47:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754466AbeE2Gr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:47:27 -0400
Date: Mon, 28 May 2018 23:47:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com
Subject: Re: [PATCH 8/8] signal: simplify rt_sigaction()
Message-ID: <20180529064719.GA14800@infradead.org>
References: <20180528134916.7568-1-christian@brauner.io>
 <20180528134916.7568-9-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528134916.7568-9-christian@brauner.io>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (act)
>  		if (copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
>  			return -EFAULT;

	if (act && copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
		return -EFAULT;

>  	ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);
> -
> -	if (!ret && oact) {
> +	if (!ret && oact)
>  		if (copy_to_user(oact, &old_sa.sa, sizeof(old_sa.sa)))
>  			return -EFAULT;
> -	}

	ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);
	if (!ret && oact && copy_to_user(oact, &old_sa.sa, sizeof(old_sa.sa)))
		return -EFAULT;

Althought I'd personaly write it as:

	ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);
	if (ret)
		return ret;
	if (oact && copy_to_user(oact, &old_sa.sa, sizeof(old_sa.sa)))
		return -EFAULT;
	return 0;
