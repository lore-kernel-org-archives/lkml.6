Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59889C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317E420663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfBYN46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:56:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfBYN4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:56:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F4F65944B;
        Mon, 25 Feb 2019 13:56:55 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1327D60199;
        Mon, 25 Feb 2019 13:56:52 +0000 (UTC)
Date:   Mon, 25 Feb 2019 14:56:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 10/20] perf data: Add directory support
Message-ID: <20190225135651.GE14757@krava>
References: <20190224190656.30163-1-jolsa@kernel.org>
 <20190224190656.30163-11-jolsa@kernel.org>
 <20190225134548.GA31136@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225134548.GA31136@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 25 Feb 2019 13:56:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:45:48AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Feb 24, 2019 at 08:06:46PM +0100, Jiri Olsa escreveu:
> > Adding support to have directory as perf.data.
> > 
> > The caller needs to set 'struct perf_data::is_dir flag
> > and the path will be treated as directory.
> > 
> > The 'struct perf_data::file' is initialized and open
> > as 'path/header' file.
> > 
> > Adding check to direcory interface functions to check
> > on is_dir flag.
> > 
> > Link: http://lkml.kernel.org/n/tip-pvot1aywiem9epgqpfi1agaj@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/data.c    | 41 ++++++++++++++++++++++++++++++++++++++-
> >  tools/perf/util/data.h    |  6 ++++++
> >  tools/perf/util/session.c |  4 ++++
> >  3 files changed, 50 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > index 7bd5ddeb7a41..72ac4dbb5c69 100644
> > --- a/tools/perf/util/data.c
> > +++ b/tools/perf/util/data.c
> > @@ -34,6 +34,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
> >  	struct perf_data_file *files = NULL;
> >  	int i, ret = -1;
> >  
> > +	if (WARN_ON(!data->is_dir))
> > +		return -EINVAL;
> > +
> >  	files = zalloc(nr * sizeof(*files));
> >  	if (!files)
> >  		return -ENOMEM;
> > @@ -69,6 +72,9 @@ int perf_data__open_dir(struct perf_data *data)
> >  	DIR *dir;
> >  	int nr = 0;
> >  
> > +	if (WARN_ON(!data->is_dir))
> > +		return -EINVAL;
> > +
> >  	dir = opendir(data->path);
> >  	if (!dir)
> >  		return -EINVAL;
> > @@ -173,6 +179,16 @@ static int check_backup(struct perf_data *data)
> >  	return 0;
> >  }
> >  
> > +static bool is_dir(struct perf_data *data)
> > +{
> > +	struct stat st;
> > +
> > +	if (stat(data->path, &st))
> > +		return false;
> > +
> > +	return (st.st_mode & S_IFMT) == S_IFDIR;
> > +}
> > +
> >  static int open_file_read(struct perf_data *data)
> >  {
> >  	struct stat st;
> > @@ -254,6 +270,22 @@ static int open_file_dup(struct perf_data *data)
> >  	return open_file(data);
> >  }
> >  
> > +static int open_dir(struct perf_data *data)
> > +{
> > +	if (perf_data__is_write(data) &&
> > +	    mkdir(data->path, S_IRWXU) < 0)
> > +		return -1;
> > +
> > +	/*
> > +	 * So far we open only the header, so we
> > +	 * can read the data version and layout.
> > +	 */
> > +	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
> > +		return -ENOMEM;
> 
> so, if this fails, then we should unwind the mkdir, if it was
> performed, so that we leave things as they were before calling
> open_dir(), right?

I think we need to some global solution on this,
currently we also leve halfway screwed perf.data
if we fail in the middle

I think maybe we need to add something on upper (session)
layer to cleanup if we screw up

jirka
