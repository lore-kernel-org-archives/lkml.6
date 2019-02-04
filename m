Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE0FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3257420815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfBDUaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:30:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728717AbfBDUaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:30:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D83D89AD0;
        Mon,  4 Feb 2019 20:30:21 +0000 (UTC)
Received: from krava (ovpn-204-43.brq.redhat.com [10.40.204.43])
        by smtp.corp.redhat.com (Postfix) with SMTP id C9F075D9CA;
        Mon,  4 Feb 2019 20:30:19 +0000 (UTC)
Date:   Mon, 4 Feb 2019 21:30:18 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Carrillo Cisneros <davidca@fb.com>
Subject: Re: [PATCH] perf utils: silent "Couldn't synthesize bpf events"
 warning for EPERM
Message-ID: <20190204203018.GD4794@krava>
References: <20190204193140.719740-1-songliubraving@fb.com>
 <41F4E192-ABD1-41BF-9BAE-45E78DD719B3@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F4E192-ABD1-41BF-9BAE-45E78DD719B3@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 04 Feb 2019 20:30:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 07:33:06PM +0000, Song Liu wrote:
> 
> 
> > On Feb 4, 2019, at 11:31 AM, Song Liu <songliubraving@fb.com> wrote:
> > 
> > Synthesizing BPF events is only supported for root. Silent warning msg
> > when non-root user runs perf-record.

great, it was annoying ;-)

Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> > 
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Reported-by: David Carrillo-Cisneros <davidca@fb.com>
> > Tested-by: David Carrillo-Cisneros <davidca@fb.com>
> > Signed-off-by: Song Liu <songliubraving@fb.com>
> > ---
> > tools/perf/util/bpf-event.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> > index 796ef793f4ce..62dda96b0096 100644
> > --- a/tools/perf/util/bpf-event.c
> > +++ b/tools/perf/util/bpf-event.c
> > @@ -236,8 +236,8 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
> > 			pr_debug("%s: can't get next program: %s%s",
> > 				 __func__, strerror(errno),
> > 				 errno == EINVAL ? " -- kernel too old?" : "");
> > -			/* don't report error on old kernel */
> > -			err = (errno == EINVAL) ? 0 : -1;
> > +			/* don't report error on old kernel or EPERM  */
> > +			err = (errno == EINVAL || errno == EPERM) ? 0 : -1;
> > 			break;
> > 		}
> > 		fd = bpf_prog_get_fd_by_id(id);
> > -- 
> > 2.17.1
> > 
> 
> CC David. 
