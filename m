Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeC0SwY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 14:52:24 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:39825 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeC0SwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 14:52:20 -0400
X-Google-Smtp-Source: AIpwx4+yXqBmGrcKGrUxnnpnBUAhLsSLwUWu+ueNc9NPf5OpFg8XSbavp9DVrjoUgg3SkfEzJ6ML2g==
Date: Tue, 27 Mar 2018 21:52:17 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Michal Hocko <mhocko@kernel.org>, adobriyan@gmail.com,
        willy@infradead.org, mguzik@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180327185217.GK2236@uranus>
References: <1522088439-105930-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180327062939.GV5652@dhcp22.suse.cz>
 <95a107ac-5e5b-92d7-dbde-2e961d85de28@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95a107ac-5e5b-92d7-dbde-2e961d85de28@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 02:38:11PM -0400, Yang Shi wrote:
> > Why do we need to hold mmap_sem here and call find_vma, when only
> > PR_SET_MM_ENV_END: is consuming it? I guess we can replace it wit the
> > new lock and take the mmap_sem only for PR_SET_MM_ENV_END.
> 
> Actually, I didn't think of why. It looks prctl_set_mm() checks if vma does
> exist when it tries to set stack_start, argv_* and env_*, btw not only
> env_end.
> 
> Cyrill may be able to give us some hint since C/R is the main user of this
> API.

First and most important it makes code smaller. This prctl call is really
rarely used. Of course we can optimize it, but as I said I would prefer
to simply deprecate this old interface (and I gonne to do so once time
permit).
