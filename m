Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AG47ELsIQG9LMUyfZXbj0wUuq6DU/AOEgJ9OtJwKJwwjMgZcchzXumPzEEnratVhsOgHR3tjyRaS
ARC-Seal: i=1; a=rsa-sha256; t=1522078484; cv=none;
        d=google.com; s=arc-20160816;
        b=u0L9tjZTnxuYORnHGlv/7pQoJaaTmxCSGd3Pxn4/nRxkec9XsjM/pDTMjs+MHvoEYZ
         WOY0lmGIp1q+UYZVBOaHqQpCRI6/ej1x7m/UrCy00f38T0fzDr51gRQLC78FSb0VFOCQ
         S56rKXx0XOUW4JL3myNULIcbz04vexFQWA0q3UoDsfDr/FtG6WfF4G5LVU8WGoa6mulV
         aKtAZ/whltveYdppIRtEQZTMWP36kFqCn0QtGSLwJkCvMm9MDcmHI7yVMCG4MmO2hLQt
         KUy0vanE5/3nJBFVineiG0eeZd4kkBXs89DquIbT2lZpgJ7H/CfvFMMbrZ9PYgvAkPVn
         oFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=OSw37RviY59NBqIWhTH+sjI/YRxxdUxRApxnUwKpvlo=;
        b=YSWynU4mwZ9/7B5JgQF4gN+lP6nbJUFiQf3+zjyHVhtbZnU3RmQHpSZxVmxVHFYWth
         9J4eCq1e3o3OhyvV2XV8/uWzediorB1tbrDUQK7tPqcOwGzWkDVwhqaZ6eEzYxFv7APt
         3Snu2dHdNlne6niNA423Oh4oB4Kiow5OZLNcT0LTHSaiwP1qXNTnx1lgBdmUkDhc5Ynu
         sgZEJNWmddhEElACggjIVHkCYVySPoqaKys0XzagNTcBpsHOp7ooeyEPhMQf130SyCHj
         b2mnl4jP0/lkQa+GSNQphRqgz3/U/zhfx1N5AJzSq3z+nW1+d+CQNiZevBLtPmggHotT
         QSYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=NixOKvd9;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=NixOKvd9;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Mon, 26 Mar 2018 08:34:37 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>, viro@zeniv.linux.org.uk,
	hannes@cmpxchg.org, mhocko@kernel.org, akpm@linux-foundation.org,
	tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
	gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
	mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
	chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
	hillf.zj@alibaba-inc.com, ying.huang@intel.com,
	mgorman@techsingularity.net, shakeelb@google.com, jbacik@fb.com,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 02/10] mm: Maintain memcg-aware shrinkers in
 mcg_shrinkers array
Message-ID: <20180326153437.GF10912@bombadil.infradead.org>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163848990.21546.2153496613786165374.stgit@localhost.localdomain>
 <20180324184516.rogvydnnupr7ah2l@esperanza>
 <448bb904-a861-c2ae-0d3f-427e6a26f61e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448bb904-a861-c2ae-0d3f-427e6a26f61e@virtuozzo.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553609558263575?=
X-GMAIL-MSGID: =?utf-8?q?1596014969086000973?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 06:20:55PM +0300, Kirill Tkhai wrote:
> On 24.03.2018 21:45, Vladimir Davydov wrote:
> > Why don't you simply use idr instead of ida? With idr you wouldn't need
> > the array mapping shrinker id to shrinker ptr. AFAIU you need this
> > mapping to look up the shrinker by id in shrink_slab. The latter doesn't
> > seem to be a hot path so using idr there should be acceptable. Since we
> > already have shrinker_rwsem, which is taken for reading by shrink_slab,
> > we wouldn't even need any additional locking for it.
> 
> The reason is ida may allocate memory, and since list_lru_add() can't fail,
> we can't do that there. If we allocate all the ida memory at the time of
> memcg creation (i.e., preallocate it), this is not different to the way
> the bitmap makes.
> 
> While bitmap has the agvantage, since it's simplest data structure (while
> ida has some radix tree overhead).

That would be true if you never wanted to resize the bitmap, but of
course you do, so you have your own interactions with RCU to contend with.
So you have the overhead of the RCU head, and you have your own code to
handle resizing which may have subtle errors.
