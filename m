Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2912AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D478C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0NzrTtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D478C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbeK0Xdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:33:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbeK0Xdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:33:46 -0500
Received: from quaco.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 675AE2147D;
        Tue, 27 Nov 2018 12:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543322158;
        bh=fFmPX57EqyrrAeP+W4gZQxF9WNbSC1q89ZvCms7RSt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0NzrTtU20e1TFtBs137sMT2bJUd9eg0VpzV8VaJgLF3kX4bUM2jDrRLtdTdxJfea
         t1QmiPgOj+Zdsz7dVJ5sY/himr7DVSJIxJ2fVRRObSnKX1zjTKK8QV1p4V1Tq979hM
         /lZ17tlGxGpFs2i/ubXDvOGaR6mFB241B9HBfX6g=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id 4C4214111B; Mon, 26 Nov 2018 15:53:34 -0300 (-03)
Date:   Mon, 26 Nov 2018 15:53:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Eric Saint-Etienne <eric.saintetienne@gmail.com>
Subject: Re: [PATCH] perf map: remove extra indirection from map__find()
Message-ID: <20181126185334.GA18491@kernel.org>
References: <1542969759-24346-1-git-send-email-eric.saint.etienne@oracle.com>
 <20181123161416.GB5575@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123161416.GB5575@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 23, 2018 at 05:14:25PM +0100, Jiri Olsa escreveu:
> On Fri, Nov 23, 2018 at 02:42:39AM -0800, Eric Saint-Etienne wrote:
> > A double pointer is used in map__find() where a single pointer is enough
> > because the function doesn't affect the rbtree and the rbtree is locked.
> > 
> > Signed-off-by: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/map.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index 354e545..3dac766 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -846,19 +846,18 @@ void maps__remove(struct maps *maps, struct map *map)
> >  
> >  struct map *maps__find(struct maps *maps, u64 ip)
> >  {
> > -	struct rb_node **p, *parent = NULL;
> > +	struct rb_node *p;
> >  	struct map *m;
> >  
> >  	down_read(&maps->lock);
> >  
> > -	p = &maps->entries.rb_node;
> > -	while (*p != NULL) {
> > -		parent = *p;
> > -		m = rb_entry(parent, struct map, rb_node);
> > +	p = maps->entries.rb_node;
> > +	while (p != NULL) {
> > +		m = rb_entry(p, struct map, rb_node);
> >  		if (ip < m->start)
> > -			p = &(*p)->rb_left;
> > +			p = p->rb_left;
> >  		else if (ip >= m->end)
> > -			p = &(*p)->rb_right;
> > +			p = p->rb_right;
> >  		else
> >  			goto out;
> >  	}
> > -- 
> > 1.8.3.1
> > 

-- 

- Arnaldo
