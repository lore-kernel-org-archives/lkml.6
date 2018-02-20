Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeBTXRI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:17:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45644 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbeBTXRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:17:07 -0500
Date: Tue, 20 Feb 2018 15:17:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/3] sysctl: Warn when a clamped sysctl parameter is set
 out of range
Message-Id: <20180220151705.8b4519f105db8f5c119015f0@linux-foundation.org>
In-Reply-To: <1519059231-2456-3-git-send-email-longman@redhat.com>
References: <1519059231-2456-1-git-send-email-longman@redhat.com>
        <1519059231-2456-3-git-send-email-longman@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2018 11:53:50 -0500 Waiman Long <longman@redhat.com> wrote:

> Even with clamped sysctl parameters, it is still not that straight
> forward to figure out the exact range of those parameters. One may
> try to write extreme parameter values to see if they get clamped.
> To make it easier, a warning with the expected range will now be
> printed in the kernel ring buffer when a clamped sysctl parameter
> receives an out of range value.

This assumes that do_proc_dointvec_minmax_conv() and
do_proc_douintvec_minmax_conv() are only ever called by privileged
userspace.  Because we mustn't give unprivileged applications a way to
spam the kernel logs.

That's presumably true in the case of the caller you just added, but I
don't see what we can do to guarantee this in the future, so perhaps we
should add some permission check to the pr_warn()?
