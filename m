Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeDJJkv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:40:51 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42827 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbeDJJkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:40:49 -0400
X-Google-Smtp-Source: AIpwx4//N7HBAywErKyfVCH/RdGxsuxwYeWNnx+ekCbHXnRaJayI+i61XCLOJTpCpsN0E2q+ViLgGg==
Date: Tue, 10 Apr 2018 12:40:47 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>, adobriyan@gmail.com,
        willy@infradead.org, mguzik@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180410094047.GB2041@uranus.lan>
References: <1523310774-40300-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180410090917.GZ21835@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410090917.GZ21835@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 11:09:17AM +0200, Michal Hocko wrote:
> On Tue 10-04-18 05:52:54, Yang Shi wrote:
> [...]
> > So, introduce a new spinlock in mm_struct to protect the concurrent
> > access to arg_start|end, env_start|end and others except start_brk and
> > brk, which are still protected by mmap_sem to avoid concurrent access
> > from do_brk().
> 
> Is there any fundamental problem with brk using the same lock?

Seems so. Look into mm/mmap.c:brk syscall which reads and writes
brk value under mmap_sem ('cause of do_brk called inside).
