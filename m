Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeCOMue (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:50:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750987AbeCOMuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:50:32 -0400
Date: Thu, 15 Mar 2018 13:50:30 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Laura Abbott <labbott@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New -Werror=restrict error with incremental gcc
Message-ID: <20180315125030.GA4727@krava>
References: <34478c69-e238-90db-bf1e-9622a060c778@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34478c69-e238-90db-bf1e-9622a060c778@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 02:19:41PM -0700, Laura Abbott wrote:
> Hi,
> 
> Fedora picked up a new gcc (8.0.1-0.18.fc29) and it seems to have introduced a new error:
> 
>   gcc -Wp,-MD,/home/labbott/linux/tools/objtool/.str_error_r.o.d -Wp,-MT,/home/labbott/linux/tools/objtool/str_error_r.o -Wall -Werror -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wshadow -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat -Wstrict-aliasing=3 -Wno-switch-default -Wno-switch-enum -Wno-packed -fomit-frame-pointer -O2 -g -I/home/labbott/linux/tools/include -I/home/labbott/linux/tools/arch/x86/include/uapi -I/home/labbott/linux/tools/objtool/arch/x86/include -I/home/labbott/linux/tools/lib -D"BUILD_STR(s)=#s" -c -o /home/labbott/linux/tools/objtool/str_error_r.o ../lib/str_error_r.c
> ../lib/str_error_r.c: In function ‘str_error_r’:
> ../lib/str_error_r.c:25:3: error: passing argument 1 to restrict-qualified parameter aliases with argument 5 [-Werror=restrict]
>    snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
>    ^~
> 
> This looks like gcc is now warning about the aliasing from printing out buf
> while printing to the buffer. I can work around this pretty easily but I
> know people have strong opinions about gcc warnings. Any thoughts?

I did not get above warning.. objtool compiled for me properly

but we have some issues with perf there, I have to use
following to get it compile, plus attached patch

  make EXTRA_CFLAGS="-Wno-format-truncation -Wno-cast-function-type"

the format-truncation are mostly fine, because we use the
buffer len to be safe and the worst things that will happen
is that we won't open the file, because the path is too long

the cast-function-type seems like a problem, I've bunch
of following errors:

	 /root/linux/tools/perf/util/python.c:830:15: warning: cast between incompatible function types from ‘PyObject * (*)(struct pyrf_evsel *, PyObject *, PyObject *)’ {aka ‘struct _object * (*)(struct pyrf_evsel *, struct _object *, struct _object *)’} to ‘PyObject * (*)(PyObject *, PyObject *)’ {aka ‘struct _object * (*)(struct _object *, struct _object *)’} [-Wcast-function-type]
	   .ml_meth  = (PyCFunction)pyrf_evsel__open,
		       ^
	/root/linux/tools/perf/util/python.c:1052:15: warning: cast between incompatible function types from ‘PyObject * (*)(struct pyrf_evlist *, PyObject *, PyObject *)’ {aka ‘struct _object * (*)(struct pyrf_evlist *, struct _object *, struct _object *)’} to ‘PyObject * (*)(PyObject *, PyObject *)’ {aka ‘struct _object * (*)(struct _object *, struct _object *)’} [-Wcast-function-type]
	   .ml_meth  = (PyCFunction)pyrf_evlist__mmap,
		       ^
	/root/linux/tools/perf/util/python.c:1058:15: warning: cast between incompatible function types from ‘PyObject * (*)(struct pyrf_evlist *, PyObject *, PyObject *)’ {aka ‘struct _object * (*)(struct pyrf_evlist *, struct _object *, struct _object *)’} to ‘PyObject * (*)(PyObject *, PyObject *)’ {aka ‘struct _object * (*)(struct _object *, struct _object *)’} [-Wcast-function-type]
	   .ml_meth  = (PyCFunction)pyrf_evlist__open,

we might want to look at it.. there were some python related
changes recently, like v3 support.. Arnaldo?

thanks,
jirka


---
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index cce926aeb0c0..48696fd80ad1 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2721,7 +2721,7 @@ static int check_ev_match(char *dir_name, char *scriptname,
 	int match, len;
 	FILE *fp;
 
-	sprintf(filename, "%s/bin/%s-record", dir_name, scriptname);
+	scnprintf(filename, MAXPATHLEN, "%s/bin/%s-record", dir_name, scriptname);
 
 	fp = fopen(filename, "r");
 	if (!fp)
