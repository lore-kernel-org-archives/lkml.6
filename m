Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeEOL5n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:57:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33780 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752906AbeEOL5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:57:41 -0400
X-Google-Smtp-Source: AB8JxZrtvJtDg2zspTyNC+gRp+KFjEgqwx/CUVdl52B42gruIC6EJRH/POJ9hZ4J4hfDMgk7AZvxew==
Date: Tue, 15 May 2018 13:57:39 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 07/14] net: sched: use reference counting action init
Message-ID: <20180515115739.GN2134@nanopsycho.orion>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-8-git-send-email-vladbu@mellanox.com>
 <20180515112404.GL2134@nanopsycho.orion>
 <vbflgclm9wc.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
 <20180515113954.GM2134@nanopsycho.orion>
 <vbfk1s5m9hi.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vbfk1s5m9hi.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 15, 2018 at 01:41:45PM CEST, vladbu@mellanox.com wrote:
>
>On Tue 15 May 2018 at 11:39, Jiri Pirko <jiri@resnulli.us> wrote:
>> Tue, May 15, 2018 at 01:32:51PM CEST, vladbu@mellanox.com wrote:
>>>
>>>On Tue 15 May 2018 at 11:24, Jiri Pirko <jiri@resnulli.us> wrote:
>>>> Mon, May 14, 2018 at 04:27:08PM CEST, vladbu@mellanox.com wrote:
>>>>>Change action API to assume that action init function always takes
>>>>>reference to action, even when overwriting existing action. This is
>>>>>necessary because action API continues to use action pointer after init
>>>>>function is done. At this point action becomes accessible for concurrent
>>>>>modifications so user must always hold reference to it.
>>>>>
>>>>>Implement helper put list function to atomically release list of actions
>>>>>after action API init code is done using them.
>>>>>
>>>>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>>>>---
>>>>> net/sched/act_api.c | 38 +++++++++++++++++---------------------
>>>>> 1 file changed, 17 insertions(+), 21 deletions(-)
>>>>>
>>>>
>>>> [...]
>>>>
>>>>
>>>>>@@ -1196,8 +1190,7 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
>>>>> 		return ret;
>>>>> 	}
>>>>> err:
>>>>>-	if (event != RTM_GETACTION)
>>>>
>>>> Howcome you do this for RTM_GETACTION now too? Where is the related
>>>> "get"?
>>>
>>>In patch 5. There is always a possibility of concurrent delete without
>>>rtnl lock so all usages of action pointers were converted to hold
>>>reference to action.
>>
>> So that means that if you run kernel in between, with patch 5 but
>> without patch 7 and you do RTM_GETACTION, you leak a reference, right?
>
>Right.

That is an issue. You need to make sure that the code is without bugs
like this after every applied patch. You need to make sure the code is
bisectable.

Thanks.
