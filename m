Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeESWSI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 18:18:08 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45541 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752569AbeESWSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 18:18:04 -0400
X-Google-Smtp-Source: AB8JxZppGFCw7LuaHIYfgdI1ji42OeYRGULVbIR+PrEMa1ROmz59t/fK/SwLyTOeMVR2EgS4XthcjA==
Date: Sat, 19 May 2018 19:17:59 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 10/14] net: sched: extend act API for lockless actions
Message-ID: <20180519221759.GE5488@localhost.localdomain>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-11-git-send-email-vladbu@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526308035-12484-11-git-send-email-vladbu@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please use a more meaningful patch summary. This one is too generic.

On Mon, May 14, 2018 at 05:27:11PM +0300, Vlad Buslov wrote:
...
> +int tcf_idr_find_delete(struct tc_action_net *tn, u32 index)

What about naming it tcf_idr_delete_index() instead?
The find operation is always implicit when you don't specify the
object itself directly, and then it describes which key will be used.

> +{
> +	struct tcf_idrinfo *idrinfo = tn->idrinfo;
> +	struct tc_action *p;
> +	int ret = 0;
> +
> +	spin_lock_bh(&idrinfo->lock);
> +	p = idr_find(&idrinfo->action_idr, index);
> +	if (!p) {
> +		spin_unlock(&idrinfo->lock);
> +		return -ENOENT;
> +	}
> +
> +	if (!atomic_read(&p->tcfa_bindcnt)) {
> +		if (refcount_dec_and_test(&p->tcfa_refcnt)) {
> +			struct module *owner = p->ops->owner;
> +
> +			WARN_ON(p != idr_remove(&idrinfo->action_idr,
> +						p->tcfa_index));
> +			spin_unlock_bh(&idrinfo->lock);
> +
> +			tcf_action_cleanup(p);
> +			module_put(owner);
> +			return 0;
> +		}
> +		ret = 0;
> +	} else {
> +		ret = -EPERM;
> +	}
> +
> +	spin_unlock_bh(&idrinfo->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(tcf_idr_find_delete);
...
