Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeCGN7D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:59:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeCGN7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:59:00 -0500
Date: Wed, 7 Mar 2018 10:58:54 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, namhyung@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf mmap: Discard head in overwrite_rb_find_range
Message-ID: <20180307135854.GA2187@redhat.com>
References: <1520336663-53466-1-git-send-email-xieyisheng1@huawei.com>
 <20180307102157.GC22848@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307102157.GC22848@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 07, 2018 at 11:21:57AM +0100, Jiri Olsa escreveu:
> On Tue, Mar 06, 2018 at 07:44:23PM +0800, Yisheng Xie wrote:
> > In overwrite mode, start will be set to head in perf_mmap__read_init.
> > Therefore, it is no need to set the start one more in
> > overwrite_rb_find_range and *start can be used as head instead of
> > passing head to overwrite_rb_find_range.
> 
> it conflicts a little with recent cleanup from Kan Liang,,
>   https://marc.info/?t=152035082800001&r=1&w=2
> 
> otherwise it looks ok to me

yeah, wait a while till I push Kan's simplifications and then resubmit,
ok?

- Arnaldo
 
> jirka
> 
> > 
> > Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> > ---
> >  tools/perf/util/mmap.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> > index 91531a7..6751ac9 100644
> > --- a/tools/perf/util/mmap.c
> > +++ b/tools/perf/util/mmap.c
> > @@ -223,19 +223,18 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
> >  	return 0;
> >  }
> >  
> > -static int overwrite_rb_find_range(void *buf, int mask, u64 head, u64 *start, u64 *end)
> > +static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
> >  {
> >  	struct perf_event_header *pheader;
> > -	u64 evt_head = head;
> > +	u64 evt_head = *start;
> >  	int size = mask + 1;
> >  
> > -	pr_debug2("overwrite_rb_find_range: buf=%p, head=%"PRIx64"\n", buf, head);
> > -	pheader = (struct perf_event_header *)(buf + (head & mask));
> > -	*start = head;
> > +	pr_debug2("%s: buf=%p, start=%"PRIx64"\n", __func__, buf, *start);
> > +	pheader = (struct perf_event_header *)(buf + (*start & mask));
> >  	while (true) {
> > -		if (evt_head - head >= (unsigned int)size) {
> > +		if (evt_head - *start >= (unsigned int)size) {
> >  			pr_debug("Finished reading overwrite ring buffer: rewind\n");
> > -			if (evt_head - head > (unsigned int)size)
> > +			if (evt_head - *start > (unsigned int)size)
> >  				evt_head -= pheader->size;
> >  			*end = evt_head;
> >  			return 0;
> > @@ -287,7 +286,7 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
> >  		 * Backward ring buffer is full. We still have a chance to read
> >  		 * most of data from it.
> >  		 */
> > -		if (overwrite_rb_find_range(data, md->mask, head, startp, endp))
> > +		if (overwrite_rb_find_range(data, md->mask, startp, endp))
> >  			return -EINVAL;
> >  	}
> >  
> > -- 
> > 1.7.12.4
> > 
