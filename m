Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeEPHnh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:43:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35934 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752516AbeEPHne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:43:34 -0400
X-Google-Smtp-Source: AB8JxZoT/XFueLSNIyfKctGw/kg6+Lo3LrbkabTfRvjDM99wrAf9Dk6p7BUnFFub0pboUE4SdnhJrw==
Date: Wed, 16 May 2018 09:43:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 09/14] net: sched: don't release reference on action
 overwrite
Message-ID: <20180516074332.GB1972@nanopsycho>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-10-git-send-email-vladbu@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526308035-12484-10-git-send-email-vladbu@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 14, 2018 at 04:27:10PM CEST, vladbu@mellanox.com wrote:
>Return from action init function with reference to action taken,
>even when overwriting existing action.
>
>Action init API initializes its fourth argument (pointer to pointer to
>tc action) to either existing action with same index or newly created
>action. In case of existing index(and bind argument is zero), init
>function returns without incrementing action reference counter. Caller
>of action init then proceeds working with action without actually
>holding reference to it. This means that action could be deleted
>concurrently. To prevent such scenario this patch changes action init

Be imperative to the codebase in the patch description.


>behavior to always take reference to action before returning
>successfully.

Where's the balance? Who does the release instead? I'm probably missing
something.

>
>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>---
> net/sched/act_bpf.c        |  8 ++++----
> net/sched/act_connmark.c   |  5 +++--
> net/sched/act_csum.c       |  8 ++++----
> net/sched/act_gact.c       |  5 +++--
> net/sched/act_ife.c        | 12 +++++-------
> net/sched/act_ipt.c        |  5 +++--
> net/sched/act_mirred.c     |  5 ++---
> net/sched/act_nat.c        |  5 +++--
> net/sched/act_pedit.c      |  5 +++--
> net/sched/act_police.c     |  8 +++-----
> net/sched/act_sample.c     |  8 +++-----
> net/sched/act_simple.c     |  5 +++--
> net/sched/act_skbedit.c    |  5 +++--
> net/sched/act_skbmod.c     |  8 +++-----
> net/sched/act_tunnel_key.c |  8 +++-----
> net/sched/act_vlan.c       |  8 +++-----
> 16 files changed, 51 insertions(+), 57 deletions(-)
>
>diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
>index 5d95c43..5554bf7 100644
>--- a/net/sched/act_bpf.c
>+++ b/net/sched/act_bpf.c
>@@ -311,9 +311,10 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
> 		if (bind)
> 			return 0;
> 
>-		tcf_idr_release(*act, bind);
>-		if (!replace)
>+		if (!replace) {
>+			tcf_idr_release(*act, bind);
> 			return -EEXIST;
>+		}
> 	}
> 
> 	is_bpf = tb[TCA_ACT_BPF_OPS_LEN] && tb[TCA_ACT_BPF_OPS];

[...]
