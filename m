Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCCDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CA820652
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfBXNce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 08:32:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbfBXNce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 08:32:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C609B5945F;
        Sun, 24 Feb 2019 13:32:33 +0000 (UTC)
Received: from krava (ovpn-204-32.brq.redhat.com [10.40.204.32])
        by smtp.corp.redhat.com (Postfix) with SMTP id BB0E260856;
        Sun, 24 Feb 2019 13:32:28 +0000 (UTC)
Date:   Sun, 24 Feb 2019 14:32:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 05/17] perf data: Add perf_data__(create_dir|close_dir)
 functions
Message-ID: <20190224133227.GA19795@krava>
References: <20190221094145.9151-1-jolsa@kernel.org>
 <20190221094145.9151-6-jolsa@kernel.org>
 <CAM9d7cgnR=Yto5Vatv-mYxr3E=eeYaiaofpMZLJ6fk3dpj9YSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgnR=Yto5Vatv-mYxr3E=eeYaiaofpMZLJ6fk3dpj9YSQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 24 Feb 2019 13:32:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 02:07:53PM +0900, Namhyung Kim wrote:

SNIP

> > +static void close_dir(struct perf_data_file *files, int nr)
> > +{
> > +       while (--nr >= 1) {
> > +               close(files[nr].fd);
> > +               free(files[nr].path);
> > +       }
> > +       free(files);
> > +}
> > +
> > +void perf_data__close_dir(struct perf_data *data)
> > +{
> > +       close_dir(data->dir.files, data->dir.nr);
> > +}
> > +
> > +int perf_data__create_dir(struct perf_data *data, int nr)
> > +{
> > +       struct perf_data_file *files = NULL;
> > +       int i, ret = -1;
> > +
> > +       files = malloc(nr * sizeof(*files));
> > +       if (!files)
> > +               return -ENOMEM;
> > +
> > +       data->dir.files = files;
> > +       data->dir.nr    = nr;
> > +
> > +       for (i = 0; i < nr; i++) {
> > +               struct perf_data_file *file = &files[i];
> > +
> > +               if (asprintf(&file->path, "%s/data.%d", data->path, i) < 0)
> > +                       goto out_err;
> > +
> > +               ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
> > +               if (ret < 0)
> > +                       goto out_err;
> 
> It seems you need to free the file->path here.

it'll be freed in the close_dir call below,
I need to call zalloc to make sure it's ok

jirka

> 
> Thanks,
> Namhyung
> 
> 
> > +
> > +               file->fd = ret;
> > +       }
> > +
> > +       return 0;
> > +
> > +out_err:
> > +       close_dir(files, i);
> > +       return ret;
> > +}
> > +
> >  static bool check_pipe(struct perf_data *data)
> >  {
> >         struct stat st;

SNIP

