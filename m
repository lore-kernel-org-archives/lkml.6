Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeESVne (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 17:43:34 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38433 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbeESVnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 17:43:31 -0400
X-Google-Smtp-Source: AB8JxZqdpcpbxYVK6h7k6gDgcjVtalfb66tWLC78EjGS7gO4Ww0uICsxJpQM67gu+cZW6N2HNT8YuA==
Date: Sat, 19 May 2018 18:43:27 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 06/14] net: sched: implement reference counted action
 release
Message-ID: <20180519214327.GC5488@localhost.localdomain>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-7-git-send-email-vladbu@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526308035-12484-7-git-send-email-vladbu@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 05:27:07PM +0300, Vlad Buslov wrote:
...
> @@ -1052,6 +1088,36 @@ static int tca_action_flush(struct net *net, struct nlattr *nla,
>  	return err;
>  }
>
> +static int tcf_action_delete(struct net *net, struct list_head *actions,
> +			     struct netlink_ext_ack *extack)
> +{
> +	int ret;

Reverse christmass tree.. this line should be the last in variable
declarations.

> +	struct tc_action *a, *tmp;
> +	char kind[IFNAMSIZ];
> +	u32 act_index;
> +
> +	list_for_each_entry_safe(a, tmp, actions, list) {
> +		const struct tc_action_ops *ops = a->ops;
> +
> +		/* Actions can be deleted concurrently
> +		 * so we must save their type and id to search again
> +		 * after reference is released.
> +		 */
> +		strncpy(kind, a->ops->kind, sizeof(kind) - 1);

This may be problematic. Why strncpy here?

a->ops->kind is also of size IFNAMSIZ. If a->ops->kind is actually
IFNAMSIZ-1 long, kind here won't be NULL terminated, as kind is not
initialized and strncpy won't add the NULL.

> +		act_index = a->tcfa_index;
> +
> +		list_del(&a->list);
> +		if (tcf_action_put(a))
> +			module_put(ops->owner);
> +
> +		/* now do the delete */
> +		ret = tcf_action_del_1(net, kind, act_index, extack);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	return 0;
> +}
