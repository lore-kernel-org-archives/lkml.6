Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeESVLL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 17:11:11 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37893 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752515AbeESVLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 17:11:09 -0400
X-Google-Smtp-Source: AB8JxZqxhWvelUqhU7+tY3WOBZjxIqa3HyAFDPFy9VEMo9xW1GmfsPcLNQAJq4jrK8EA1qyK+hX/kQ==
Date: Sat, 19 May 2018 18:11:04 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Vlad Buslov <vladbu@mellanox.com>, netdev@vger.kernel.org,
        davem@davemloft.net, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        ast@kernel.org, daniel@iogearbox.net, edumazet@google.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        kliteyn@mellanox.com
Subject: Re: [PATCH 04/14] net: sched: implement unlocked action init API
Message-ID: <20180519211104.GB5488@localhost.localdomain>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-5-git-send-email-vladbu@mellanox.com>
 <20180514151641.GD1848@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514151641.GD1848@nanopsycho>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 05:16:41PM +0200, Jiri Pirko wrote:
> Mon, May 14, 2018 at 04:27:05PM CEST, vladbu@mellanox.com wrote:
> >Add additional 'unlocked' argument to act API init functions.
> >Argument is true when rtnl lock is not taken and false otherwise.
> >It is required to implement actions that need to release rtnl lock before
> >loading kernel module and reacquire if afterwards.
> >
> >Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>
> [...]
>
>
> >@@ -721,9 +722,11 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
> > 	a_o = tc_lookup_action_n(act_name);
> > 	if (a_o == NULL) {
> > #ifdef CONFIG_MODULES
> >-		rtnl_unlock();
> >+		if (!unlocked)
> >+			rtnl_unlock();
> > 		request_module("act_%s", act_name);
> >-		rtnl_lock();
> >+		if (!unlocked)
> >+			rtnl_lock();
>
> Although I don't like this conditional locking scheme, I see no other
> way to solve this :/ But I think would be better perhaps to rename
> "unlocked" to something like "rtnl_held".

Agreed. "rtnl_held" also removes the double negation, "!un...".
