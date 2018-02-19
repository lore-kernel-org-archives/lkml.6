Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeBSCj6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 21:39:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:61481 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752381AbeBSCj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 21:39:56 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,533,1511856000";
   d="scan'208";a="31087372"
Date: Mon, 19 Feb 2018 10:31:11 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: changbin.du@intel.com, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v3] perf ftrace: Append an EOL when write tracing files
Message-ID: <20180219023111.jwoycbutz4nnq6nd@intel.com>
References: <1518576264-16436-1-git-send-email-changbin.du@intel.com>
 <20180219012134.GA1583@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219012134.GA1583@sejong>
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 10:21:34AM +0900, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Feb 14, 2018 at 10:44:24AM +0800, changbin.du@intel.com wrote:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > Before this change, the '--graph-funcs', '--nograph-funcs' and
> > '--trace-funcs' options didn't work as expected when the <func> doesn't
> > exist. Because the kernel side hid possible errors.
> > 
> > $ sudo ./perf ftrace -a --graph-depth 1 --graph-funcs abcdefg
> >  0)   0.140 us    |  rcu_all_qs();
> >  3)   0.304 us    |  mutex_unlock();
> >  0)   0.153 us    |  find_vma();
> >  3)   0.088 us    |  __fsnotify_parent();
> >  0)   6.145 us    |  handle_mm_fault();
> >  3)   0.089 us    |  fsnotify();
> >  3)   0.161 us    |  __sb_end_write();
> >  3)   0.710 us    |  SyS_close();
> >  3)   7.848 us    |  exit_to_usermode_loop();
> > 
> > On above example, I specified function filter 'abcdefg' but all functions
> > are enabled. The expected error is hidden.
> > 
> > The original fix is to make the kernel support '\0' as end of string:
> > https://lkml.org/lkml/2018/1/16/116
> > 
> > But above fix cannot be compatible with old kernels. Then Namhyung Kim
> > suggest adding a space after function name.
> > 
> > This patch will append an '\n' when write tracing file. After this fix,
> > the perf will report correct error state. Also let it print an error if
> > reset_tracing_files() fails.
> > 
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > 
> > ---
> > v3: Took Kim's suggestion that add a space after function name.
> > v2: Rebase.
> > ---
> >  tools/perf/builtin-ftrace.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 25a42ac..9ffd748 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -72,6 +72,7 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
> >  	ssize_t size = strlen(val);
> >  	int flags = O_WRONLY;
> >  	char errbuf[512];
> > +	char *val_copy;
> >  
> >  	file = get_tracing_file(name);
> >  	if (!file) {
> > @@ -91,12 +92,20 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
> >  		goto out;
> >  	}
> >  
> > -	if (write(fd, val, size) == size)
> > +	/*
> > +	 * Copy the original value and append a '\n'. Without this,
> > +	 * the kernel can hide possible errors.
> > +	 */
> > +	val_copy = strdup(val);
> 
> Please check the return value.
>
Thanks, I will update.
 
> Thanks,
> Namhyung
> 
> 
> > +	val_copy[size] = '\n';
> > +
> > +	if (write(fd, val_copy, size + 1) == size + 1)
> >  		ret = 0;
> >  	else
> >  		pr_debug("write '%s' to tracing/%s failed: %s\n",
> >  			 val, name, str_error_r(errno, errbuf, sizeof(errbuf)));
> >  
> > +	free(val_copy);
> >  	close(fd);
> >  out:
> >  	put_tracing_file(file);
> > @@ -280,8 +289,10 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  	signal(SIGCHLD, sig_handler);
> >  	signal(SIGPIPE, sig_handler);
> >  
> > -	if (reset_tracing_files(ftrace) < 0)
> > +	if (reset_tracing_files(ftrace) < 0) {
> > +		pr_err("failed to reset ftrace\n");
> >  		goto out;
> > +	}
> >  
> >  	/* reset ftrace buffer */
> >  	if (write_tracing_file("trace", "0") < 0)
> > -- 
> > 2.7.4
> > 

-- 
Thanks,
Changbin Du
