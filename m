Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbeEOLYI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:24:08 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36605 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752740AbeEOLYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:24:06 -0400
X-Google-Smtp-Source: AB8JxZq5PAu3IF4VdoOZSnTcFLK4QTb4zOg8MywWtbVErROZ1jGyf/vUwHmyoEe/HXIIlr6xnwqnqg==
Date: Tue, 15 May 2018 13:24:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 07/14] net: sched: use reference counting action init
Message-ID: <20180515112404.GL2134@nanopsycho.orion>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-8-git-send-email-vladbu@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526308035-12484-8-git-send-email-vladbu@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 14, 2018 at 04:27:08PM CEST, vladbu@mellanox.com wrote:
>Change action API to assume that action init function always takes
>reference to action, even when overwriting existing action. This is
>necessary because action API continues to use action pointer after init
>function is done. At this point action becomes accessible for concurrent
>modifications so user must always hold reference to it.
>
>Implement helper put list function to atomically release list of actions
>after action API init code is done using them.
>
>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>---
> net/sched/act_api.c | 38 +++++++++++++++++---------------------
> 1 file changed, 17 insertions(+), 21 deletions(-)
>

[...]


>@@ -1196,8 +1190,7 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
> 		return ret;
> 	}
> err:
>-	if (event != RTM_GETACTION)

Howcome you do this for RTM_GETACTION now too? Where is the related "get"?


>-		tcf_action_destroy(&actions, 0);
>+	tcf_action_put_lst(&actions);
> 	return ret;
> }
> 

[...]
