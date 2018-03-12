Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeCLXAX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:00:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44400 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbeCLXAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:00:22 -0400
Date: Mon, 12 Mar 2018 16:00:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, eric.dumazet@gmail.com,
        xiyou.wangcong@gmail.com, fw@strlen.de
Subject: Re: [PATCH] proc: reject "." and ".." as filenames
Message-Id: <20180312160018.5d4cb6917c84b2805ff32d1d@linux-foundation.org>
In-Reply-To: <20180310001223.GB12443@avx2>
References: <20180310001223.GB12443@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Mar 2018 03:12:23 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Various subsystems can create files and directories in /proc
> with names directly controlled by userspace.
> 
> Which means "/", "." and ".." are no-no.
> 
> "/" split is already taken care of, do the other 2 prohibited names.
> 
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -366,6 +366,14 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
>  		WARN(1, "name len %u\n", qstr.len);
>  		return NULL;
>  	}
> +	if (qstr.len == 1 && fn[0] == '.') {
> +		WARN(1, "name '.'\n");
> +		return NULL;
> +	}
> +	if (qstr.len == 2 && fn[0] == '.' && fn[1] == '.') {
> +		WARN(1, "name '..'\n");
> +		return NULL;
> +	}
>  	if (*parent == &proc_root && name_to_int(&qstr) != ~0U) {
>  		WARN(1, "create '/proc/%s' by hand\n", qstr.name);
>  		return NULL;

--- a/fs/proc/generic.c~proc-reject-and-as-filenames-fix
+++ a/fs/proc/generic.c
@@ -387,10 +387,8 @@ static struct proc_dir_entry *__proc_cre
 		WARN(1, "name len %u\n", qstr.len);
 		return NULL;
 	}
-	if (qstr.len == 1 && fn[0] == '.') {
-		WARN(1, "name '.'\n");
+	if (WARN(qstr.len == 1 && fn[0] == '.', "name '.'\n"))
 		return NULL;
-	}
 	if (qstr.len == 2 && fn[0] == '.' && fn[1] == '.') {
 		WARN(1, "name '..'\n");
 		return NULL;

is neater, but the whole function should be thus converted and I'll let
you decide on that.
