Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F23C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2738A21531
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pn9QpByj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2738A21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeI0TSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:18:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43436 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbeI0TSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:18:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id q19-v6so1903536pgn.10;
        Thu, 27 Sep 2018 06:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cdilXEzxuizn9R/tFBHbAoxMJeGa3i8nrC/7D179fx8=;
        b=pn9QpByj60NcUmZ+mABoG04s6JhfnK9/wpHpm4B16BZ83gnVl7/Ez0TihZFcajEfhX
         82dLr8FFk4T1DgNJJmPUaSxpZQhxA3k+nVkDJbbEc2rDLZVonsoF0vrEmZhBuNo7FXPA
         V55gZ6Gaq6jY+eLLwU7gpyLg1E2dPLfs2GXhVeTsNNww/3XhDwygIoxRZurCtxnail3O
         We1PCYF+g/Rg04h1i908dhiUiHA0PDiWNnyFm2Arb0z2L1088O0WmHwsF2mCEg6W2QcC
         bNRwwWj/OWz0dK6lCY0yBQanyhh7MZEWHJ+4rNYurSTjnsUB8jeAItlwNnJ28xOZ99hi
         c5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cdilXEzxuizn9R/tFBHbAoxMJeGa3i8nrC/7D179fx8=;
        b=RSE2+rejF4k+aUnY89weOtyv3mIraMaVTZIW9e/v97VXyF+/T5LDv728Q3kktcE6RR
         Hl4zAuLqH49pZVekSXleLqHSLrQFQsOiMb1+NyYM3scMZJRp9ejny8dblZNBgItHymqQ
         I8kTWUzPZvJfqC4uNlbbHIDlu6qvUeg1sqI5SAusdNfa+lnNDS5PGV0VV1nSnGePefT9
         oEqG8RraOGlwG7hTI20wDKig2DIsdSRHuncegAfJXJgAnqQXOjKuvSxlFgkcv74pCpOH
         zISgkgqMyoMPA+Rew/tuwy3swEpbKYbxdr7Fl/3wGA1GZauXTZNllgsI4+y9Q4YX4qo7
         AaQQ==
X-Gm-Message-State: ABuFfoiV5wOXKWwIxq/S/cvP6PwRxGJJsTw07/d9fFwas5+kGlGkPqtP
        c3FfYfz+3qcjsWO9hl0PnoY=
X-Google-Smtp-Source: ACcGV62lUNdU8Y154p1rVwfq745L+8eAV+LNLfGVb/S0BtFBjksMyzy6rH9fxoLftOqvEm8RvwmcRQ==
X-Received: by 2002:a17:902:6a8b:: with SMTP id n11-v6mr10956685plk.16.1538053241234;
        Thu, 27 Sep 2018 06:00:41 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id p19-v6sm3303884pgh.60.2018.09.27.06.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 06:00:40 -0700 (PDT)
Subject: Re: KASAN: use-after-free Read in tcf_block_find
To:     Dmitry Vyukov <dvyukov@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com,
        David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <00000000000084e2450576c817cc@google.com>
 <CAM_iQpXxzR3GP4wK7z+wW_0-vC9cuyiwnrCYqx+NpBgDvBXLcg@mail.gmail.com>
 <7fcb1c03-6976-9b34-601d-5f50b74c5b0a@gmail.com>
 <CAM_iQpX4sKSPFXgEjU-be=he=91+=3Bm9KvP3CMciA9zi2b-6g@mail.gmail.com>
 <CACT4Y+YbfOYDHJjeK-88wQDg2oSF3fqsaWBhkDwnDr+KUsLnDA@mail.gmail.com>
 <CACT4Y+YbQbZ7XTPK1HLvPiR9rmSm7Cz0H2LJAFfYfAta1Y3CiQ@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <de41f26b-efe6-9985-cf38-169c18791cd6@gmail.com>
Date:   Thu, 27 Sep 2018 06:00:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YbQbZ7XTPK1HLvPiR9rmSm7Cz0H2LJAFfYfAta1Y3CiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/27/2018 01:10 AM, Dmitry Vyukov wrote:

> 
> Would a stack trace for call_rcu be helpful here? I have this idea for
> a long time, but never get around to implementing it:
> https://bugzilla.kernel.org/show_bug.cgi?id=198437
> 
> Also FWIW I recently used the following hack for another net bug. It
> made that other bug involving call_rcu way more likely to fire. Maybe
> it will be helpful here too.
> 
> diff --git a/net/core/dst.c b/net/core/dst.c
> index 81ccf20e28265..591a8d0aca545 100644
> --- a/net/core/dst.c
> +++ b/net/core/dst.c
> @@ -187,8 +187,16 @@ void dst_release(struct dst_entry *dst)
>                 if (unlikely(newrefcnt < 0))
>                         net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
>                                              __func__, dst, newrefcnt);
> -               if (!newrefcnt)
> -                       call_rcu(&dst->rcu_head, dst_destroy_rcu);
> +               if (!newrefcnt) {
> +                       if (lock_is_held(&rcu_bh_lock_map) ||
> +                               lock_is_held(&rcu_lock_map) ||
> +                               lock_is_held(&rcu_sched_lock_map)) {
> +                               call_rcu(&dst->rcu_head, dst_destroy_rcu);
> +                       } else {
> +                               synchronize_rcu();

dst_release() can be called in context we hold a spinlock, this would be bad to reschedule here.

> +                               dst_destroy_rcu(&dst->rcu_head);
> +                       }
> +               }
>         }
>  }
> 
