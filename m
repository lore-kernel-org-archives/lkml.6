Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521919976; cv=none;
        d=google.com; s=arc-20160816;
        b=xfpOGOUCwUu97kmR3IiKbk/zVjKkVbKiK91zBnt8Kcy/73KKkSVgtGoFtcqFYETXen
         yCAUrTsGvjCmpR2anOR5MF5dDj9VMfT++x9/aSralfBXPu5YcWI+aJlYEfem3tKtBlvm
         XGR60nw0TenCsct15dy1q7l2wuumKatpJnX9jURAs0jO50vJSExRe1l//HucnKmbZEXK
         gXwIt5EQe22UuxChUoxh2XfzpBpnlm2TvDk2OUETlsQbISBqwti7a2x9FzBJ8HUdI17L
         lTUOQr0DWKnQf4/nhvwb6a56QMdJIRslLvFQYi513LS0tsrgWiu3HkxLw9T1tU8n1TFl
         i9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=vGq6SjSk4pWzyAE3lghLpii5LRSdMI9x4OfBceOCurY=;
        b=WpyPi8QzDhuYwcDR4XkYeJoGd1IAEZbxmPcw6roru2SXHHBimsj30e3x/umbV61qp+
         OOwq1YRasTLQkBM6clhkFhKLHIkxEHmuFaDUbXCyNnzKTfv3BX8XUHDf8vc3X1qGWZ1J
         Dkr7I0O9qSl/l02URJHEFRZg/sd1ID4JnbvI8mwGINHUnb17NtfT8G8e0SQDHemfPWHk
         Fshj6XJYqhXjVSUrNTwbiKRgu/MtXL/QYFN+PEuP6q758lH6xD53EVbKuIa1VmpI5q7A
         eX9+80QCYbhyQTiG7JavL22crW0gmLQa8DeuzUIBnvZXBOsfJuCzzQBgZrkagM9+j+m8
         iDrA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=C/Jqr+Uh;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=C/Jqr+Uh;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvOfpY42N/LnhBm9RsQNgDhm6/as8iFe6+aSJxGp0aPAJozEmtVQyFygfahzPgMCXtcJdfWKg==
Date: Sat, 24 Mar 2018 22:32:53 +0300
From: Vladimir Davydov <vdavydov.dev@gmail.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, pombredanne@nexb.com,
	stummala@codeaurora.org, gregkh@linuxfoundation.org,
	sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
	penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
	longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
	ying.huang@intel.com, mgorman@techsingularity.net,
	shakeelb@google.com, jbacik@fb.com, linux@roeck-us.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	willy@infradead.org
Subject: Re: [PATCH 06/10] list_lru: Pass dst_memcg argument to
 memcg_drain_list_lru_node()
Message-ID: <20180324193253.y653nm4z6sh7u2kd@esperanza>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163853059.21546.940468208501917585.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152163853059.21546.940468208501917585.stgit@localhost.localdomain>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553658469578349?=
X-GMAIL-MSGID: =?utf-8?q?1595848760748932509?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 04:22:10PM +0300, Kirill Tkhai wrote:
> This is just refactoring to allow next patches to have
> dst_memcg pointer in memcg_drain_list_lru_node().
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  include/linux/list_lru.h |    2 +-
>  mm/list_lru.c            |   11 ++++++-----
>  mm/memcontrol.c          |    2 +-
>  3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> index ce1d010cd3fa..50cf8c61c609 100644
> --- a/include/linux/list_lru.h
> +++ b/include/linux/list_lru.h
> @@ -66,7 +66,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
>  #define list_lru_init_memcg(lru)	__list_lru_init((lru), true, NULL)
>  
>  int memcg_update_all_list_lrus(int num_memcgs);
> -void memcg_drain_all_list_lrus(int src_idx, int dst_idx);
> +void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);

Please, for consistency pass the source cgroup as a pointer as well.
