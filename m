Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeDFWeZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 18:34:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751679AbeDFWeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 18:34:24 -0400
Date: Fri, 6 Apr 2018 17:34:20 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] livepatch: Initialize shadow variables safely by
 a custom callback
Message-ID: <20180406223420.icjwcq7vy24tvecu@treble>
References: <20180405122315.29065-1-pmladek@suse.com>
 <20180405122315.29065-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180405122315.29065-2-pmladek@suse.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 02:23:14PM +0200, Petr Mladek wrote:
> @@ -150,6 +149,23 @@ static void *__klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
>  		goto exists;
>  	}
>  
> +	new_shadow->obj = obj;
> +	new_shadow->id = id;
> +
> +	if (ctor) {
> +		int err;
> +
> +		err = ctor(obj, new_shadow->data, ctor_data);
> +		if (err) {
> +			spin_unlock_irqrestore(&klp_shadow_lock, flags);
> +			kfree(new_shadow);
> +			WARN(1,
> +			     "Failed to construct shadow variable <%p, %lx>\n",
> +			     obj, id);
> +			return NULL;
> +		}
> +	}
> +

I'm not sure why a constructor would return an error, though I guess it
doesn't hurt to allow it.

The WARN seems excessive though, IMO.  The constructor itself can warn
(or printk or whatever else) if it thinks its warranted.

Also I think the 'err' variable isn't really needed.

-- 
Josh
