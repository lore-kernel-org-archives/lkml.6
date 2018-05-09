Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933297AbeEIA4w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 20:56:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39880 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932934AbeEIA4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 20:56:50 -0400
X-Google-Smtp-Source: AB8JxZrKm7K5ZHOFxiDSu/GdLTZTaR92vdQyDGY746MAteRixLZ4l6qg/6ELQjysJ/ttpWWPHpMaZA==
Date: Wed, 9 May 2018 08:56:41 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org
Subject: Re: [PATCH 1/2] perf cs-etm: Support unknown_thread in
 cs_etm_auxtrace
Message-ID: <20180509005640.GB23540@leoy-ThinkPad-X240s>
References: <1525360703-26159-1-git-send-email-leo.yan@linaro.org>
 <CANLsYky4QatoCv_4k1r8eb4Rjugx9g2YZLG1dtHKJy9AsHtCSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYky4QatoCv_4k1r8eb4Rjugx9g2YZLG1dtHKJy9AsHtCSg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 11:01:30AM -0600, Mathieu Poirier wrote:
> On 3 May 2018 at 09:18, Leo Yan <leo.yan@linaro.org> wrote:
> > CoreSight doesn't allocate thread structure for unknown_thread in etm
> > auxtrace, so unknown_thread is NULL pointer.  If the perf data doesn't
> > contain valid tid and then cs_etm__mem_access() uses unknown_thread
> > instead as thread handler, this results in segmentation fault when
> > thread__find_addr_map() accesses thread handler.
> >
> > This commit creates new thread data which is used by unknown_thread, so
> > CoreSight tracing can roll back to use unknown_thread if perf data
> > doesn't include valid thread info.  This commit also releases thread
> > data for initialization failure case and for normal auxtrace free flow.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 6533b1a..417302c 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -239,6 +239,7 @@ static void cs_etm__free(struct perf_session *session)
> >         for (i = 0; i < aux->num_cpu; i++)
> >                 zfree(&aux->metadata[i]);
> >
> > +       thread__zput(aux->unknown_thread);
> >         zfree(&aux->metadata);
> >         zfree(&aux);
> >  }
> > @@ -266,6 +267,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
> >         if (!thread) {
> >                 if (cpumode != PERF_RECORD_MISC_KERNEL)
> >                         return -EINVAL;
> > +
> 
> Extra line, please remove.
> 
> With this change:
> 
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks for reviewing, Mathieu.  Will spin new patches and send out.

[...]

Thanks,
Leo Yan
