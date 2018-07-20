Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E12ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D0020833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh871wMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D0020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbeGTPbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731390AbeGTPba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:31:30 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02D47206B7;
        Fri, 20 Jul 2018 14:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532097774;
        bh=VN8eX64lPBOLoSrvoFkWP7wNU1vBOFH0OIVusdxHI/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zh871wMu8fZniFw8ZCfyphTRQYP92h0InK3CcyojgzjxSrmIEZK6+n6jSpsdzvTUK
         sZVwsWgag7SPL40JuwNiozuAIAk42B/o40cqZxf2g5rnpgXjqIIk/wAOHSrxpyHZ4Y
         eKVdpsVKV7XSlxcwNId4/9oBq/Zz+PjfHriC+9CI=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 885B0140260; Fri, 20 Jul 2018 11:42:47 -0300 (-03)
Date:   Fri, 20 Jul 2018 11:42:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com
Subject: Re: [PATCHv3 4/4] perf tools: Fix struct comm_str removal crash
Message-ID: <20180720144247.GA4329@kernel.org>
References: <20180719143345.12963-1-jolsa@kernel.org>
 <20180719143345.12963-5-jolsa@kernel.org>
 <20180719182843.GA2812@kernel.org>
 <20180719183114.GB2812@kernel.org>
 <20180720012055.GA8457@sejong>
 <20180720101740.GA27176@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720101740.GA27176@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 20, 2018 at 12:17:40PM +0200, Jiri Olsa escreveu:
> On Fri, Jul 20, 2018 at 10:20:55AM +0900, Namhyung Kim wrote:
> > Hi Arnaldo,
> > 
> > On Thu, Jul 19, 2018 at 03:31:14PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Jul 19, 2018 at 03:28:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Thu, Jul 19, 2018 at 04:33:45PM +0200, Jiri Olsa escreveu:
> > > > > +++ b/tools/perf/util/comm.c
> > > > > @@ -18,11 +18,9 @@ struct comm_str {
> > > > >  static struct rb_root comm_str_root;
> > > > >  static struct rw_semaphore comm_str_lock = {.lock = PTHREAD_RWLOCK_INITIALIZER,};
> > > > >  
> > > > > -static struct comm_str *comm_str__get(struct comm_str *cs)
> > > > > +static bool comm_str__get(struct comm_str *cs)
> > > > >  {
> > > > > -	if (cs)
> > > > > -		refcount_inc(&cs->refcnt);
> > > > > -	return cs;
> > > > > +	return cs ? refcount_inc_not_zero(&cs->refcnt) : false;
> > > > >  }
> > > > 
> > > > I don't like changing the semantics of a __get() operation this way, I
> > > > think it should stay like all the others, i.e. return the object with
> > > > the desired refcount or return NULL if that is not possible.
> > > > 
> > > > Otherwise we'll have to switch gears when debugging refcounts in various
> > > > objects, that start having slightly different semantics for reference
> > > > counting.
> > > > 
> > > > We should try to find a fix that maintains the semantics of refcounting.
> > > 
> > > After looking at the code, this refcount_inc_not_zero returns bool comes
> > > from the kernel, trying to see how this is used with __get() operations
> > > there, if at all.
> > 
> > Something like this?
> > 
> > static struct comm_str *comm_str__get(struct comm_str *cs)
> > {
> >     if (cs && refcount_inc_not_zero(&cs->refcnt))
> >         return cs;
> >     return NULL;
> > }
> > 
> > 
> > Other than that I don't have better idea, so
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Thanks,
> > Namhyung
> 
> righ, we can change comm_str__get like that, attached v3

Thanks, glad it was so easy. :-)

- Arnaldo
 
> thanks,
> jirka
> 
> 
> ---
> We occasionaly hit following assert failure in perf top,
> when processing the /proc info in multiple threads.
> 
>   perf: ...include/linux/refcount.h:109: refcount_inc:
>         Assertion `!(!refcount_inc_not_zero(r))' failed.
> 
> The gdb backtrace looks like this:
> 
>   [Switching to Thread 0x7ffff11ba700 (LWP 13749)]
>   0x00007ffff50839fb in raise () from /lib64/libc.so.6
>   (gdb)
>   #0  0x00007ffff50839fb in raise () from /lib64/libc.so.6
>   #1  0x00007ffff5085800 in abort () from /lib64/libc.so.6
>   #2  0x00007ffff507c0da in __assert_fail_base () from /lib64/libc.so.6
>   #3  0x00007ffff507c152 in __assert_fail () from /lib64/libc.so.6
>   #4  0x0000000000535373 in refcount_inc (r=0x7fffdc009be0)
>       at ...include/linux/refcount.h:109
>   #5  0x00000000005354f1 in comm_str__get (cs=0x7fffdc009bc0)
>       at util/comm.c:24
>   #6  0x00000000005356bd in __comm_str__findnew (str=0x7fffd000b260 ":2",
>       root=0xbed5c0 <comm_str_root>) at util/comm.c:72
>   #7  0x000000000053579e in comm_str__findnew (str=0x7fffd000b260 ":2",
>       root=0xbed5c0 <comm_str_root>) at util/comm.c:95
>   #8  0x000000000053582e in comm__new (str=0x7fffd000b260 ":2",
>       timestamp=0, exec=false) at util/comm.c:111
>   #9  0x00000000005363bc in thread__new (pid=2, tid=2) at util/thread.c:57
>   #10 0x0000000000523da0 in ____machine__findnew_thread (machine=0xbfde38,
>       threads=0xbfdf28, pid=2, tid=2, create=true) at util/machine.c:457
>   #11 0x0000000000523eb4 in __machine__findnew_thread (machine=0xbfde38,
>   ...
> 
> The failing assertion is this one:
> 
>   REFCOUNT_WARN(!refcount_inc_not_zero(r), ...
> 
> The problem is that we keep global comm_str_root list, which
> is accessed by multiple threads during the perf top startup
> and following 2 paths can race:
> 
>   thread 1:
>     ...
>     thread__new
>       comm__new
>         comm_str__findnew
>           down_write(&comm_str_lock);
>           __comm_str__findnew
>             comm_str__get
> 
>   thread 2:
>     ...
>     comm__override or comm__free
>       comm_str__put
>         refcount_dec_and_test
>           down_write(&comm_str_lock);
>           rb_erase(&cs->rb_node, &comm_str_root);
> 
> Because thread 2 first decrements the refcnt and only after then it
> removes the struct comm_str from the list, the thread 1 can find this
> object on the list with refcnt equls to 0 and hit the assert.
> 
> This patch fixes the thread 1 __comm_str__findnew path, by ignoring
> objects that already dropped the refcnt to 0. For the rest of the
> objects we take the refcnt before comparing its name and release
> it afterwards with comm_str__put, which can also release the object
> completely.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Link: http://lkml.kernel.org/n/tip-vrizt6sw1lu1ybsrl9l0wwln@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/comm.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
> index 7798a2cc8a86..31279a7bd919 100644
> --- a/tools/perf/util/comm.c
> +++ b/tools/perf/util/comm.c
> @@ -20,9 +20,10 @@ static struct rw_semaphore comm_str_lock = {.lock = PTHREAD_RWLOCK_INITIALIZER,}
>  
>  static struct comm_str *comm_str__get(struct comm_str *cs)
>  {
> -	if (cs)
> -		refcount_inc(&cs->refcnt);
> -	return cs;
> +	if (cs && refcount_inc_not_zero(&cs->refcnt))
> +		return cs;
> +
> +	return NULL;
>  }
>  
>  static void comm_str__put(struct comm_str *cs)
> @@ -67,9 +68,14 @@ struct comm_str *__comm_str__findnew(const char *str, struct rb_root *root)
>  		parent = *p;
>  		iter = rb_entry(parent, struct comm_str, rb_node);
>  
> +		/*
> +		 * If we race with comm_str__put, iter->refcnt is 0
> +		 * and it will be removed within comm_str__put call
> +		 * shortly, ignore it in this search.
> +		 */
>  		cmp = strcmp(str, iter->str);
> -		if (!cmp)
> -			return comm_str__get(iter);
> +		if (!cmp && comm_str__get(iter))
> +			return iter;
>  
>  		if (cmp < 0)
>  			p = &(*p)->rb_left;
> -- 
> 2.17.1
