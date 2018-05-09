Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AB8JxZrA3f9G53XDGh4TlbbIkzJLienJAb/CT15beDttw4fn9AuUskBCLCedM16dHE9BXNaQ+ECT
ARC-Seal: i=1; a=rsa-sha256; t=1525906514; cv=none;
        d=google.com; s=arc-20160816;
        b=I9X0eEPxCJMvC3mLFCuJjcW3o2Shy3TMoSzpx7ZFJmeLi67iFR7ZfS8J8oYAfIrXcY
         ADsRhbZ12mrU6JdpeU4QtQmQsVqLMX0nqGGpAsaB6pi5gBlw02Rp3FWwfmNhGvFh/Ttf
         FbKlnYVTKPRdrTkcs/LVQ4qN9N/UwJqBAh+sr2Jli82KPOaEF4Z5RnZQJAi1N8WOqzQb
         AKm4VKfrzNX0nJl2CYhprVHd0z6ds0NlgFPBief13/qj28eRnjToblOnUc6ixlfX7wjK
         DZTT1FID5rTQ7kKgGx5ZUapWL3FOttq/VIQ36EySRpIff436WEzoNC/5ZZYtQHJscf97
         bN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=IWZ7OL1wyNwzgrqnraeRjs5K8gHbsIPyDPTOC7PruCE=;
        b=vp/HXz3mtzR2ErU3CM9UjUB4MxF0WawQonbrzwCxMMQrkT31CRRo5Wt35mCHSuT3lb
         I3ZC9aNDO1uFBzreAqWWPUXID2BSqUFXEpwz3b8aOsRhIop/a1InCgl6kiGah0aUiNXO
         lZUq34DNt68lDNHgFbhC+gGARSAdd+AQYImRzwGk3953Qc/Il18aEkbuCOWa/cYD6SjO
         AW849LbP6/ErhmxnQLUxTCVtMIaYGCrK5wzKjWBXuIDcjN66wBHUS/sFlsvd/+mJxYyr
         q0lUfMyoH7Ov5mbB4KeqHQRW5ye3nW6gLuDjScsA8jn8tvaOrjIKbgc5LDMBqjFgcMMu
         +L2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Wed, 9 May 2018 15:55:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: vdavydov.dev@gmail.com, shakeelb@google.com, viro@zeniv.linux.org.uk,
 hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, ying.huang@intel.com,
 mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 lirongqing@baidu.com, aryabinin@virtuozzo.com
Subject: Re: [PATCH v4 01/13] mm: Assign id to every memcg-aware shrinker
Message-Id: <20180509155511.9bb3de08b33d617559e5fb3a@linux-foundation.org>
In-Reply-To: <152586701534.3048.9132875744525159636.stgit@localhost.localdomain>
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
	<152586701534.3048.9132875744525159636.stgit@localhost.localdomain>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987539736036809?=
X-GMAIL-MSGID: =?utf-8?q?1600028949147980289?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 09 May 2018 14:56:55 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> The patch introduces shrinker::id number, which is used to enumerate
> memcg-aware shrinkers. The number start from 0, and the code tries
> to maintain it as small as possible.
> 
> This will be used as to represent a memcg-aware shrinkers in memcg
> shrinkers map.
> 
> ...
>
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -248,6 +248,9 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  	s->s_time_gran = 1000000000;
>  	s->cleancache_poolid = CLEANCACHE_NO_POOL;
>  
> +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)

It would be more conventional to do this logic in Kconfig - define a
new MEMCG_SHRINKER which equals MEMCG && !SLOB.

This ifdef occurs a distressing number of times in the patchset :( I
wonder if there's something we can do about that.

Also, why doesn't it work with slob?  Please describe the issue in the
changelogs somewhere.

It's a pretty big patchset.  I *could* merge it up in the hope that
someone is planning do do a review soon.  But is there such a person?
