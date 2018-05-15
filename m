Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeEOI7F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:59:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42214 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbeEOI63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:58:29 -0400
X-Google-Smtp-Source: AB8JxZoED4f9hhcsM+tW/Awp9EQT07Whul5GE6/NFP4K7wWqXVMPRiqQ4gRe22V6Fm5e4ZCwTuvC6Q==
Date: Tue, 15 May 2018 10:58:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 05/14] net: sched: always take reference to action
Message-ID: <20180515085827.GJ2134@nanopsycho.orion>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-6-git-send-email-vladbu@mellanox.com>
 <20180514162301.GC2134@nanopsycho.orion>
 <vbftvradqe4.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vbftvradqe4.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 14, 2018 at 08:49:07PM CEST, vladbu@mellanox.com wrote:
>
>On Mon 14 May 2018 at 16:23, Jiri Pirko <jiri@resnulli.us> wrote:
>> Mon, May 14, 2018 at 04:27:06PM CEST, vladbu@mellanox.com wrote:
>>>Without rtnl lock protection it is no longer safe to use pointer to tc
>>>action without holding reference to it. (it can be destroyed concurrently)
>>>
>>>Remove unsafe action idr lookup function. Instead of it, implement safe tcf
>>>idr check function that atomically looks up action in idr and increments
>>>its reference and bind counters.
>>>
>>>Implement both action search and check using new safe function.
>>>
>>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>>---
>>> net/sched/act_api.c | 38 ++++++++++++++++----------------------
>>> 1 file changed, 16 insertions(+), 22 deletions(-)
>>>
>>>diff --git a/net/sched/act_api.c b/net/sched/act_api.c
>>>index 1331beb..9459cce 100644
>>>--- a/net/sched/act_api.c
>>>+++ b/net/sched/act_api.c
>>>@@ -284,44 +284,38 @@ int tcf_generic_walker(struct tc_action_net *tn, struct sk_buff *skb,
>>> }
>>> EXPORT_SYMBOL(tcf_generic_walker);
>>> 
>>>-static struct tc_action *tcf_idr_lookup(u32 index, struct tcf_idrinfo *idrinfo)
>>>+bool __tcf_idr_check(struct tc_action_net *tn, u32 index, struct tc_action **a,
>>>+		     int bind)
>>> {
>>>-	struct tc_action *p = NULL;
>>>+	struct tcf_idrinfo *idrinfo = tn->idrinfo;
>>>+	struct tc_action *p;
>>> 
>>> 	spin_lock_bh(&idrinfo->lock);
>>
>> Why "_bh" variant is necessary here?
>
>It is not my code.

Yeah, yet still I wonder :)
