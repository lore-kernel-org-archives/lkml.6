Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AB8JxZq7Zn8kXnyZ9OePhdDYkak7tQTQjVTqNQUsvnzsrHBzTbMofI0ItE1lTvCfI11CjlEgkbOv
ARC-Seal: i=1; a=rsa-sha256; t=1524062055; cv=none;
        d=google.com; s=arc-20160816;
        b=HULQ+CJAxBa5t6vnTvLsInk0e5wCQpEVTQ7+BtmiZWMbR/RYI7et2T/ClXAotpP5B7
         mVsacfRdV0cSlXX799jPKCY+3P7J1NWLsMtjZeDO5QLbU/s0x/Yq58JffSMQ9W7kbao3
         s6EJ3/aoFuh1qdartqV75jwwQcm0MA5KZCqIGa2rseHEO7uG8acykXirr8BS3aTF4+C3
         bz47pGCxjpTl6mIjJUG662FphJ+HP7YHEdty5mLU/ciRXRfbjwX+ZKD0q4TdGP/gSKDy
         D+UWgRJhNNEfaU8gEK6/x4Nr83L32PuqMHZGhRh6Jbf/hxgLqwF6kZeBBhpECN77VP+M
         lIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:date:message-id:in-reply-to:references:from:subject:cc
         :to:arc-authentication-results;
        bh=fxDJygiaTcYbiTqDy0I0smt9INRUknJkNYWqAorpWtU=;
        b=ZL4qU47SZN9v3XpoKOsEduMCV3JenVTCbf2QT+BlgvCoULJwA08gJvGl86UMs5tMGl
         UHJ2FnSUMgPJBvolcV25MbNmdGqR0dV7UNkDWuVSmlYSgGmvlwubG1C4xyeNVTy9Go9Y
         w/jBydPoxKsQ6a5yplkFgsT4HXDbzCSzobrIuJBLkzTpiEC1dTG6AoRDEeUIov+Ck1hs
         2xWl7oQQ6dYzSxrdrBuchw7TnNnIAWI4AFQkFdJ6+JQPeFCzG8QWF8JTm9BrexR8M/6f
         bnaguVYadJWrLUbJBGMwYC/brRWP2O2+x69Z5tOksIwDpoUbhXNzUuGC0U94YjgsIwee
         Ae0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
To: ktkhai@virtuozzo.com, willy@infradead.org, wei.w.wang@intel.com
Cc: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, chris@chris-wilson.co.uk, longman@redhat.com,
        minchan@kernel.org, hillf.zj@alibaba-inc.com, ying.huang@intel.com,
        mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
        lirongqing@baidu.com, aryabinin@virtuozzo.com
Subject: Re: [PATCH v2 01/12] mm: Assign id to every memcg-aware shrinker
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
	<152399118252.3456.17590357803686895373.stgit@localhost.localdomain>
	<201804182314.IIG86990.MFVJSFQLFOtHOO@I-love.SAKURA.ne.jp>
	<b544689c-718c-abda-889c-5ec5eb755854@virtuozzo.com>
In-Reply-To: <b544689c-718c-abda-889c-5ec5eb755854@virtuozzo.com>
Message-Id: <201804182332.FAC65178.FLVJFMSOtHOFQO@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Wed, 18 Apr 2018 23:32:42 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009267479229519?=
X-GMAIL-MSGID: =?utf-8?q?1598094894495543382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kirill Tkhai wrote:
> On 18.04.2018 17:14, Tetsuo Handa wrote:
> > Kirill Tkhai wrote:
> >> The patch introduces shrinker::id number, which is used to enumerate
> >> memcg-aware shrinkers. The number start from 0, and the code tries
> >> to maintain it as small as possible.
> >>
> >> This will be used as to represent a memcg-aware shrinkers in memcg
> >> shrinkers map.
> > 
> > I'm not reading this thread. But is there reason "id" needs to be managed
> > using smallest numbers? Can't we use address of shrinker object as "id"
> > (which will be sparse bitmap, and would be managed using linked list for now)?
> 
> Yes, it's needed to have the smallest numbers, as next patches introduce
> per-memcg bitmap containing ids of shrinkers.

If you use sparse bitmap (xbitmap ?), I think you can do it.
