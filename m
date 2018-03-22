Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeCVXNe convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbeCVXNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:13:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC452177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 22 Mar 2018 19:13:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sztsian@gmail.com
Cc: johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, zsun@redhat.com
Subject: Re: [PATCH 2/2] trace-cmd: Change the way of getting python
 ldflags.
Message-ID: <20180322191331.48b3d9dd@gandalf.local.home>
In-Reply-To: <20180204032014.6962-3-sztsian@gmail.com>
References: <20180204032014.6962-1-sztsian@gmail.com>
        <20180204032014.6962-3-sztsian@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  4 Feb 2018 11:20:14 +0800
sztsian@gmail.com wrote:

> From: Zamir SUN <sztsian@gmail.com>
> 
> Prior than this patch, Makefile detects python ldflags using a hardcoded
> python command. It will cause problems if we are building against
> python3 in the future when ldflags for python2 and python3 are
> different. With this patch, python ldflags are detected by
> corresponding python{,3}-config which will detect the right config for
> python plugins.
> 
> Signed-off-by: Zamir SUN (Red Hat) <sztsian@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 7c0d1a6..f41e399 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -636,7 +636,7 @@ report_noswig: force
>  
>  PYTHON_INCLUDES = `pkg-config --cflags $(PYTHON_VERS)`
>  PYTHON_LDFLAGS = `pkg-config --libs $(PYTHON_VERS)` \
> -		$(shell python2 -c "import distutils.sysconfig; print distutils.sysconfig.get_config_var('LINKFORSHARED')")
> +		$(shell $(PYTHON_VERS)-config --ldflags)
>  PYGTK_CFLAGS = `pkg-config --cflags pygtk-2.0`
>  
>  ctracecmd.so: $(TCMD_LIB_OBJS) ctracecmd.i

BTW, I did have this applied, but when testing it caused warnings. I
had to apply this patch to fix it:

-- Steve

>From d5579b729114135da20bcee6896a0683ff54f33a Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Thu, 22 Mar 2018 18:38:22 -0400
Subject: [PATCH] trace-cmd build: Do not execute python scripts if there is no
 python

I was triggering the following build messages when not having swig installed:

make: -config: Command not found

    NO_PYTHON forced: swig not installed, not compiling python plugins

make: -config: Command not found
  UPDATE                 trace_python_dir
make: -config: Command not found

This is due to the executing of $(PYTHON_VERS)-config, which would just turn
into "-config". Do not assign the PYTHON_* variables if NO_PYTHON is
defined.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index 2c82301..26fd42b 100644
--- a/Makefile
+++ b/Makefile
@@ -373,10 +373,16 @@ report_nopythondev: force
 	$(Q)echo "    python-dev is not installed, not compiling python plugins"
 	$(Q)echo
 
+ifndef NO_PYTHON
 PYTHON_INCLUDES = `pkg-config --cflags $(PYTHON_VERS)`
 PYTHON_LDFLAGS = `pkg-config --libs $(PYTHON_VERS)` \
 		$(shell $(PYTHON_VERS)-config --ldflags)
 PYGTK_CFLAGS = `pkg-config --cflags pygtk-2.0`
+else
+PYTHON_INCLUDES =
+PYTHON_LDFLAGS =
+PYGTK_CFLAGS =
+endif
 
 export PYTHON_INCLUDES
 export PYTHON_LDFLAGS
-- 
2.13.6
