Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbeC0GDl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:03:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50716 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeC0GDk (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:03:40 -0400
X-Google-Smtp-Source: AG47ELsyYOqslONOYxelelhqnG/mDcEorDB801WnbTyNo7WDslXr+O4iSn8StTMXFJXENn3zaV9drA==
Date: Tue, 27 Mar 2018 08:03:36 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH v1 3/3] perf: Support perf -vv
Message-ID: <20180327060336.gjdy442pkdc7k2rr@gmail.com>
References: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
 <1522080424-12912-4-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522080424-12912-4-git-send-email-yao.jin@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jin Yao <yao.jin@linux.intel.com> wrote:

> +++ b/tools/perf/perf.c
> @@ -64,6 +64,7 @@ static struct cmd_struct commands[] = {
>  	{ "top",	cmd_top,	0 },
>  	{ "annotate",	cmd_annotate,	0 },
>  	{ "version",	cmd_version,	0 },
> +	{ "version2",	cmd_version2,	0 },
>  	{ "script",	cmd_script,	0 },
>  	{ "sched",	cmd_sched,	0 },
>  #ifdef HAVE_LIBELF_SUPPORT
> @@ -190,6 +191,11 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  			break;
>  		}
>  
> +		if (!strcmp(cmd, "-vv")) {
> +			(*argv)[0] = "--version2";
> +			break;
> +		}

That is just lazy hackery, please use the regular option library to add options 
and document them!

Also, '--version2' is a sloppy name, the right solution is to do what Git does, it 
has a --build-options sub-option to 'perf version':

  triton:~/tip> git version -h
  usage: git version [<options>]

      --build-options       also print build options


  triton:~/tip> git version --build-options
  git version 2.14.1
  sizeof-long: 8

This should be done for perf as well, and _then_ maybe can we add a helper alias 
that maps '-vv' to 'version --build-options'.

Thanks,

	Ingo
