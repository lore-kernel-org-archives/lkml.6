Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751033AbeC0HcR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:32:17 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45279 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeC0HcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:32:15 -0400
X-Google-Smtp-Source: AIpwx48i0BP1Qkq+VVc8UwIiXqgS9RopOp7ROWCr/e7th1WN54QGcDMtbsh8zHnA6/tLfP2LSQxoGw==
Date: Tue, 27 Mar 2018 10:32:12 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>, adobriyan@gmail.com,
        mhocko@kernel.org, mguzik@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180327073212.GG2236@uranus>
References: <1522088439-105930-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180326183725.GB27373@bombadil.infradead.org>
 <20180326192132.GE2236@uranus>
 <aef52c2a-4b75-f8a7-2083-f53f42bddab8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aef52c2a-4b75-f8a7-2083-f53f42bddab8@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 05:59:49PM -0400, Yang Shi wrote:
> > Say we've two syscalls running prctl_set_mm_map in parallel, and imagine
> > one have @start_brk = 20 @brk = 10 and second caller has @start_brk = 30
> > and @brk = 20. Since now the call is guarded by _read_ the both calls
> > unlocked and due to OO engine it may happen then when both finish
> > we have @start_brk = 30 and @brk = 10. In turn "write" semaphore
> > has been take to have consistent data on exit, either you have [20;10]
> > or [30;20] assigned not something mixed.
> > 
> > That said I think using read-lock here would be a bug.
> 
> Yes it sounds so. However, it was down_read before
> ddf1d398e517e660207e2c807f76a90df543a217 ("prctl: take mmap sem for writing
> to protect against others"). And, that commit is for fixing the concurrent
> writing to arg_* and env_*. I just checked that commit, but omitted the brk
> part. The potential issue mentioned by you should exist before that commit,
> but might be just not discovered or very rare to hit.
> 
> I will change it back to down_write.

down_read before was a bug ;) And it was not discovered earlier simply
because not that many users of this interface exist, namely only criu
as far as I know by now.
