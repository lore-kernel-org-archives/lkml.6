Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933763AbeBMIfM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 03:35:12 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42059 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933631AbeBMIfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 03:35:10 -0500
X-Google-Smtp-Source: AH8x225d0oZeKSuoASMhsSKnI2/tUZfL3GuMo0Io4BzwKAGoquwZWR+0HjhXhPmp3GZayv4lf38FUg==
Date: Tue, 13 Feb 2018 17:35:05 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Dave Young <dyoung@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2] printk: move dump stack related code to
 lib/dump_stack.c
Message-ID: <20180213083505.GA1953@jagdpanzerIV>
References: <20180213072834.GA24784@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213072834.GA24784@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/13/18 15:28), Dave Young wrote:
> 
> dump_stack related stuff should belong to lib/dump_stack.c thus move them
> there. Also conditionally compile lib/dump_stack.c since dump_stack code
> does not make sense if printk is disabled.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>


The patch also saves us some additional memory on !PRINTK configs.
For example things like this

	if (kobj->state_initialized) {
		/* do not error out as sometimes we can recover */
		printk(KERN_ERR "kobject (%p): tried to init an initialized "
		       "object, something is seriously wrong.\n", kobj);
		dump_stack();
	}

now we won't have that dump_stack() call, which does not seems to be doing
anything useful anyway when printk() is not available.

	-ss
