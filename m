Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D0C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfBYPgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:36:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbfBYPgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:36:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBF6B3DE08;
        Mon, 25 Feb 2019 15:36:51 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7BCE51A7EE;
        Mon, 25 Feb 2019 15:36:49 +0000 (UTC)
Date:   Mon, 25 Feb 2019 16:36:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
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
Message-ID: <20190225153648.GG14757@krava>
References: <20190224190656.30163-1-jolsa@kernel.org>
 <20190224190656.30163-11-jolsa@kernel.org>
 <20190225134548.GA31136@kernel.org>
 <20190225135651.GE14757@krava>
 <20190225150722.GQ31136@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225150722.GQ31136@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 25 Feb 2019 15:36:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 12:07:22PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > > > +}
> > > > +
> > > >  static int open_file_read(struct perf_data *data)
> > > >  {
> > > >  	struct stat st;
> > > > @@ -254,6 +270,22 @@ static int open_file_dup(struct perf_data *data)
> > > >  	return open_file(data);
> > > >  }
> > > >  
> > > > +static int open_dir(struct perf_data *data)
> > > > +{
> > > > +	if (perf_data__is_write(data) &&
> > > > +	    mkdir(data->path, S_IRWXU) < 0)
> > > > +		return -1;
> > > > +
> > > > +	/*
> > > > +	 * So far we open only the header, so we
> > > > +	 * can read the data version and layout.
> > > > +	 */
> > > > +	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
> > > > +		return -ENOMEM;
> > > 
> > > so, if this fails, then we should unwind the mkdir, if it was
> > > performed, so that we leave things as they were before calling
> > > open_dir(), right?
> > 
> > I think we need to some global solution on this,
> 
> If we don't add more, that would be a good thing :-)
> 
> The other parts also need to be investigated to see what is best in that
> case, but here, undoing the mkdir() if the asprintf() fails is the right
> thing to do :-)

true ;-) will resend

thanks,
jirka
