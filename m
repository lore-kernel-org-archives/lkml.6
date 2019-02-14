Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF50C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07011222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbfBNPus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:50:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731438AbfBNPus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:50:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC6A737E8B;
        Thu, 14 Feb 2019 15:50:46 +0000 (UTC)
Received: from krava (unknown [10.43.17.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0E2B55D6B3;
        Thu, 14 Feb 2019 15:50:43 +0000 (UTC)
Date:   Thu, 14 Feb 2019 16:50:42 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools build: Add test-reallocarray.c to test-all.c to
 fix the build Was: Re: reallocarray failure on centos:7 superseded by raw
 data API
Message-ID: <20190214155042.GB16707@krava>
References: <20190212205557.GM3269@kernel.org>
 <20190212205750.GN3269@kernel.org>
 <D9304DB8-0E43-49D0-9F61-871CB14473F8@fb.com>
 <CAEf4BzaCMq5C94bp31Ew=PqcasfuUm-dEvSi6p9ErduRHRgGTA@mail.gmail.com>
 <CA+JHD93gPW4oPkumPK36UkQv_2AOxywAzTjDXz1VgJ7YHa5qBg@mail.gmail.com>
 <CAEf4BzYGzgoZ2c_zuvyjM1d734dMKLm_9Ki8XfFvUGMCMxU=Lw@mail.gmail.com>
 <20190213133855.GB1904@kernel.org>
 <20190213142136.GC1904@kernel.org>
 <CAEf4BzaNBSxZCVC2myZRkn4N8WLJ6cCtV1M6Qy-3e7ZHJHZp6A@mail.gmail.com>
 <20190214153018.GA23266@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214153018.GA23266@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 14 Feb 2019 15:50:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:30:18PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> index 74329957553a..e903b86b742f 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -174,6 +174,10 @@
>  # include "test-libaio.c"
>  #undef main
>  
> +#define main main_test_reallocarray
> +# include "test-reallocarray.c"
> +#undef main
> +
>  int main(int argc, char *argv[])
>  {
>  	main_test_libpython();
> @@ -214,6 +218,7 @@ int main(int argc, char *argv[])
>  	main_test_sdt();
>  	main_test_setns();
>  	main_test_libaio();
> +	main_test_reallocarray();
>  
>  	return 0;
>  }
> diff --git a/tools/build/feature/test-reallocarray.c b/tools/build/feature/test-reallocarray.c
> index 8170de35150d..8f6743e31da7 100644
> --- a/tools/build/feature/test-reallocarray.c
> +++ b/tools/build/feature/test-reallocarray.c
> @@ -6,3 +6,5 @@ int main(void)
>  {
>  	return !!reallocarray(NULL, 1, 1);
>  }
> +
> +#undef _GNU_SOURCE

nice, also test-sched_getcpu.c does not do #undef _GNU_SOURCE

jirka
