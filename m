Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932092AbeENPQu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:16:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37950 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbeENPQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:16:48 -0400
X-Google-Smtp-Source: AB8JxZqiOOiPwy39ufOpCm87fIorg8HBBIOTK43DjqIQ1Z+WCWKyfFuH7Z7m4KaWWLHP5zM6fApL5g==
Date: Mon, 14 May 2018 17:16:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 04/14] net: sched: implement unlocked action init API
Message-ID: <20180514151641.GD1848@nanopsycho>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-5-git-send-email-vladbu@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526308035-12484-5-git-send-email-vladbu@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 14, 2018 at 04:27:05PM CEST, vladbu@mellanox.com wrote:
>Add additional 'unlocked' argument to act API init functions.
>Argument is true when rtnl lock is not taken and false otherwise.
>It is required to implement actions that need to release rtnl lock before
>loading kernel module and reacquire if afterwards.
>
>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>

[...]


>@@ -721,9 +722,11 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
> 	a_o = tc_lookup_action_n(act_name);
> 	if (a_o == NULL) {
> #ifdef CONFIG_MODULES
>-		rtnl_unlock();
>+		if (!unlocked)
>+			rtnl_unlock();
> 		request_module("act_%s", act_name);
>-		rtnl_lock();
>+		if (!unlocked)
>+			rtnl_lock();

Although I don't like this conditional locking scheme, I see no other
way to solve this :/ But I think would be better perhaps to rename
"unlocked" to something like "rtnl_held".

[...]
