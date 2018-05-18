Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbeERWbl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:31:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752393AbeERWbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:31:40 -0400
Date: Fri, 18 May 2018 15:31:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Roman Kagan <rkagan@virtuozzo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idr: fix invalid ptr dereference on item delete
Message-Id: <20180518153138.459c78a83c6bada41b4b187d@linux-foundation.org>
In-Reply-To: <20180518175025.GD6361@bombadil.infradead.org>
References: <20180518175025.GD6361@bombadil.infradead.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018 10:50:25 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> If the radix tree underlying the IDR happens to be full and we attempt
> to remove an id which is larger than any id in the IDR, we will call
> __radix_tree_delete() with an uninitialised 'slot' pointer, at which
> point anything could happen.  This was easiest to hit with a single entry
> at id 0 and attempting to remove a non-0 id, but it could have happened
> with 64 entries and attempting to remove an id >= 64.
> 
> Fixes: 0a835c4f090a ("Reimplement IDR and IDA using the radix tree")
> Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
> Debugged-by: Roman Kagan <rkagan@virtuozzo.com>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

Neither of the changelogs I'm seeing attempt to describe the end-user
impact of the bug.  People like to know that so they can decide which
kernel version(s) need patching, so please always remember it.

Looknig at the sysbot report, the impact is at least "privileged user
can trigger a WARN", but I assume there could be worse,
as-yet-undiscovered impacts.  So I'm thinking a cc:stable is needed,
yes?
