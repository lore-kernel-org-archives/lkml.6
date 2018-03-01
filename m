Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162036AbeCAVbU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:31:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42276 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161500AbeCAVbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:31:19 -0500
Date: Thu, 1 Mar 2018 13:31:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 3/6] sysctl: Add flags to support min/max range
 clamping
Message-Id: <20180301133117.1d4b27e327f8e51275c82489@linux-foundation.org>
In-Reply-To: <1519926220-7453-4-git-send-email-longman@redhat.com>
References: <1519926220-7453-1-git-send-email-longman@redhat.com>
        <1519926220-7453-4-git-send-email-longman@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Mar 2018 12:43:37 -0500 Waiman Long <longman@redhat.com> wrote:

> When minimum/maximum values are specified for a sysctl parameter in
> the ctl_table structure with proc_dointvec_minmax() handler, update
> to that parameter will fail with error if the given value is outside
> of the required range.
> 
> There are use cases where it may be better to clamp the value of
> the sysctl parameter to the given range without failing the update,
> especially if the users are not aware of the actual range limits.
> Reading the value back after the update will now be a good practice
> to see if the provided value exceeds the range limits.
> 
> To provide this less restrictive form of range checking, a new flags
> field is added to the ctl_table structure. The new field is a 16-bit
> value that just fits into the hole left by the 16-bit umode_t field
> without increasing the size of the structure.
> 
> When the CTL_FLAGS_CLAMP_RANGE flag is set in the ctl_table entry,
> any update from the userspace will be clamped to the given range
> without error.
> 
> ...
>
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -116,6 +116,7 @@ struct ctl_table
>  	void *data;
>  	int maxlen;
>  	umode_t mode;
> +	uint16_t flags;

It would be nice to make this have type `enum ctl_table_flags', but I
guess there's then no reliable way of forcing it to be 16-bit.

I guess this is the best we can do...

--- a/include/linux/sysctl.h~sysctl-add-flags-to-support-min-max-range-clamping-fix
+++ a/include/linux/sysctl.h
@@ -116,7 +116,7 @@ struct ctl_table
 	void *data;
 	int maxlen;
 	umode_t mode;
-	uint16_t flags;
+	uint16_t flags;			/* enum ctl_table_flags */
 	struct ctl_table *child;	/* Deprecated */
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
@@ -125,7 +125,7 @@ struct ctl_table
 } __randomize_layout;
 
 /**
- * enum ctl_table_flags - flags for the ctl table
+ * enum ctl_table_flags - flags for the ctl table (struct ctl_table.flags)
  *
  * @CTL_FLAGS_CLAMP_RANGE: Set to indicate that the entry should be
  *	flexibly clamped to min/max range in case the user provided


>  	struct ctl_table *child;	/* Deprecated */
>  	proc_handler *proc_handler;	/* Callback for text formatting */
>  	struct ctl_table_poll *poll;
