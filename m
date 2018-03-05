Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932251AbeCET7J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:59:09 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34973 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeCET7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:59:07 -0500
X-Google-Smtp-Source: AG47ELt9PndWTf2owNBC28bZ7OlLlhEFg7eLMaGQ09unUeqNndHObqAAFfffY59fAWmY0mij8GZPxg==
Date: Mon, 5 Mar 2018 14:59:05 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Howard McLauchlan <hmclauchlan@fb.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@fb.com,
        Yonghong Song <yhs@fb.com>, Josef Bacik <jbacik@fb.com>,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH] uprobe: add support for overlayfs
Message-ID: <20180305195904.sliaqqv4dzuebque@destiny>
References: <20180228004014.445-1-hmclauchlan@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228004014.445-1-hmclauchlan@fb.com>
User-Agent: NeoMutt/20170714 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 04:40:14PM -0800, Howard McLauchlan wrote:
> uprobes cannot successfully attach to binaries located in a directory
> mounted with overlayfs.
> 
> To verify, create directories for mounting overlayfs
> (upper,lower,work,merge), move some binary into merge/ and use readelf
> to obtain some known instruction of the binary. I used /bin/true and the
> entry instruction(0x13b0):
> 
> 	$ mount -t overlay overlay -o lowerdir=lower,upperdir=upper,workdir=work merge
> 	$ cd /sys/kernel/debug/tracing
> 	$ echo 'p:true_entry PATH_TO_MERGE/merge/true:0x13b0' > uprobe_events
> 	$ echo 1 > events/uprobes/true_entry/enable
> 
> This returns 'bash: echo: write error: Input/output error' and dmesg
> tells us 'event trace: Could not enable event true_entry'
> 
> This change makes create_trace_uprobe() look for the real inode of a
> dentry. In the case of normal filesystems, this simplifies to just
> returning the inode. In the case of overlayfs(and similar fs) we will
> obtain the underlying dentry and corresponding inode, upon which uprobes
> can successfully register.
> 
> Running the example above with the patch applied, we can see that the
> uprobe is enabled and will output to trace as expected.
> 
> Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>

Reviewed-by: Josef Bacik <jbacik@fb.com>

Thanks,

Josef
