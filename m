Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965A9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB9B20660
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="MRRLJo/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfAJOuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:50:10 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43523 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfAJOuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:50:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so10392151eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 06:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WvIj/qzc/fwVS3+DAxFSN02879Zu0Pn8kVHCBgyUFGk=;
        b=MRRLJo/QcvegG+P98LsFOC61g9c/gXGkEBRMqGvbbomUn5t6IAMekQnvIkgkU8WosN
         3feZ7EpkNGy+nU0S+6mGfOKkjujLqf6VofR8J/eI4XIAmyiSIJrFiej6dXzDAUN/vhuJ
         7GyySh9qfN5Yz9qmB1ap5LJVDAWxUJFqRQsParcbGKvafh9ULl1aL/FTLFks7gqCNJBy
         E4U9NSe4TkQYEwF2747UmZbVWwpCGeF3UxnD+VJE1gfr+9lUgCHoB/jaBxguzF/KM4Yo
         KdnwKRqdb/DfiRRxx8r7NH+3W695I2YtFnDU+zHC+HbtzIhCQQX25LRTrI2XXVWQqZ1u
         7qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WvIj/qzc/fwVS3+DAxFSN02879Zu0Pn8kVHCBgyUFGk=;
        b=mGd09pbDSXk/5xYxavFVn4GzUxun5ldtJuCLsvo9/9ed8sg+lT2MYiXvVLbE8p25vq
         1OpaXeG8XjSgskfa9upzuZNNNCxWuUZ3YudcZw7yZS73g8mBo6RNNLoVLVyo/aEtJzDg
         0ZU7k7HQ0NZ9hj3I7IkKFX5av4SNEO9K3xdGVTdGm8zEJwG9KaoboDSTFA+AiKGVfuU3
         dgdv+eKKjUnVDJ3nIESJkuj/vNzqcfJl7eETIemsxn0Q5dFIpmJvx7u+ybjkGjbyu/tg
         n4jSIAyix1PCUzYJVmfczXWofm942+DdgvWMMgbPDF0EJMyo/1ouXcutz63H195w9krN
         5r2A==
X-Gm-Message-State: AJcUukfuUKPqGwPL0evGqgnbHipskfztEaLJpBap2duHbYw8d3ANZqGp
        49AVHSylfRyrmwGYzK3gnvL2cg==
X-Google-Smtp-Source: ALg8bN5495yuCFAORrFydsRWGbLirfk5QO+WB3lLrOvzQM3aY79YXCnACwWLI4zsJKS74PgoACwwlQ==
X-Received: by 2002:a17:906:4944:: with SMTP id f4-v6mr8752026ejt.72.1547131807547;
        Thu, 10 Jan 2019 06:50:07 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:d6c:c571:88:8aee:976c])
        by smtp.gmail.com with ESMTPSA id z6-v6sm1113558ejq.63.2019.01.10.06.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 06:50:06 -0800 (PST)
Date:   Thu, 10 Jan 2019 15:50:05 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        mcgrof@kernel.org, joe.lawrence@redhat.com, longman@redhat.com,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org
Subject: Re: [RESEND PATCH v3 2/2] sysctl: handle overflow for file-max
Message-ID: <20190110145004.zhc2t42aasni7wnq@brauner.io>
References: <20190107222700.15954-1-christian@brauner.io>
 <20190107222700.15954-3-christian@brauner.io>
 <20190108070110.GA7998@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190108070110.GA7998@light.dominikbrodowski.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 08:01:10AM +0100, Dominik Brodowski wrote:
> On Mon, Jan 07, 2019 at 11:27:00PM +0100, Christian Brauner wrote:
> > @@ -2833,6 +2836,10 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
> >  				break;
> >  			if (neg)
> >  				continue;
> > +			if ((max && val > *max) || (min && val < *min)) {
> > +				err = -EINVAL;
> > +				break;
> > +			}
> >  			val = convmul * val / convdiv;
> >  			if ((min && val < *min) || (max && val > *max))
> >  				continue;
> 
> This is a generic change which affects all users of
> do_proc_doulongvec_minmax() that have extra1 or extra2 set. In sysctl.c, I
> do not see another user of proc_doulongvec_minmax() that has extra1 or
> extra2 set. However, have you verified whether your patch changes the
> behaviour for other files that make use of proc_doulongvec_minmax() or
> proc_doulongvec_ms_jiffies_minmax(), and not only of the file-max sysctl?

Sorry for the delayed reply. I did look at the callers. The functions
that are of interest afaict are:

proc_doulongvec_ms_jiffies_minmax
proc_doulongvec_minmax

So this could be visible when users write values that would overflow the
type used in the kernel.
I guess your point is whether we are venturing into userspace break
territory. Hm... We should probably make sure that we're not regressing
anyone else! What do you think if instead of the above patch we did:

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ba4d9e85feb8..37727b4c7a97 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1721,7 +1721,7 @@ static struct ctl_table fs_table[] = {
 		.data		= &files_stat.max_files,
 		.maxlen		= sizeof(files_stat.max_files),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
+		.proc_handler	= proc_file_max,
 	},
 	{
 		.procname	= "nr_open",
@@ -2758,7 +2758,7 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
 				     void __user *buffer,
 				     size_t *lenp, loff_t *ppos,
 				     unsigned long convmul,
-				     unsigned long convdiv)
+				     unsigned long convdiv, bool strict)
 {
 	unsigned long *i, *min, *max;
 	int vleft, first = 1, err = 0;
@@ -2806,7 +2806,12 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
 				continue;
 			val = convmul * val / convdiv;
 			if ((min && val < *min) || (max && val > *max))
-				continue;
+				if (strict) {
+					err = -EINVAL;
+					break;
+				} else {
+					continue;
+				}
 			*i = val;
 		} else {
 			val = convdiv * (*i) / convmul;
@@ -2843,7 +2848,15 @@ static int do_proc_doulongvec_minmax(struct ctl_table *table, int write,
 				     unsigned long convdiv)
 {
 	return __do_proc_doulongvec_minmax(table->data, table, write,
-			buffer, lenp, ppos, convmul, convdiv);
+			buffer, lenp, ppos, convmul, convdiv, false);
+}
+
+static int proc_file_max(struct ctl_table *table, int write,
+			 void __user *buffer, size_t *lenp, loff_t *ppos,
+			 unsigned long convmul, unsigned long convdiv)
+{
+	return __do_proc_doulongvec_minmax(table->data, table, write, buffer,
+					   lenp, ppos, convmul, convdiv, true);
 }
 
 /**
@@ -2865,7 +2878,8 @@ static int do_proc_doulongvec_minmax(struct ctl_table *table, int write,
 int proc_doulongvec_minmax(struct ctl_table *table, int write,
 			   void __user *buffer, size_t *lenp, loff_t *ppos)
 {
-    return do_proc_doulongvec_minmax(table, write, buffer, lenp, ppos, 1l, 1l);
+	return do_proc_doulongvec_minmax(table, write, buffer, lenp, ppos, 1l,
+					 1l, false);
 }
 
 /**
@@ -2890,7 +2904,7 @@ int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int write,
 				      size_t *lenp, loff_t *ppos)
 {
     return do_proc_doulongvec_minmax(table, write, buffer,
-				     lenp, ppos, HZ, 1000l);
+				     lenp, ppos, HZ, 1000l, false);
 }
