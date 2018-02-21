Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeBUAAh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 19:00:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:57378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeBUAAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 19:00:36 -0500
Date: Tue, 20 Feb 2018 16:00:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] proc/kpageflags: add KPF_WAITERS
Message-Id: <20180220160034.db7a3122c44e274ef562002e@linux-foundation.org>
In-Reply-To: <cd7b5099-0575-81ce-9f48-2efd664f2fc2@yandex-team.ru>
References: <151834540184.176427.12174649162560874101.stgit@buzz>
        <20180216155752.4a17cfd41875911c79807585@linux-foundation.org>
        <cd7b5099-0575-81ce-9f48-2efd664f2fc2@yandex-team.ru>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2018 11:14:10 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> On 17.02.2018 02:57, Andrew Morton wrote:
> > On Sun, 11 Feb 2018 13:36:41 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
> > 
> >> KPF_WAITERS indicates tasks are waiting for a page lock or writeback.
> >> This might be false-positive, in this case next unlock will clear it.
> > 
> > Well, kpageflags is full of potential false-positives.  Or do you think
> > this flag is especially vulnerable?
> > 
> > In other words, under what circumstances will we have KPF_WAITERS set
> > when PG_locked and PG-writeback are clear?
> 
> Looks like lock_page() - unlock_page() shouldn't leave longstanding
> false-positive: last unlock_page() must clear PG_waiters.
> 
> But I've seen them. Probably that was from  wait_on_page_writeback():
> it test PG_writeback, set PG_waiters under queue lock unconditionally
> and then test PG_writeback again before sleep - and might exit
> without wakeup i.e. without clearing PG_waiters.
> 
> This could be fixed with extra check for in wait_on_page_bit_common()
> under queue lock.
>
> ...
>
> This bit tells which page or оffset in file is actually wanted
> by somebody in the system. That's another way to track where major
> faults or writeback blocks something. We don't have to record flow
> of events - snapshot of page-flags will show where contention is.
> 

Please send a v2 and let's get all this info into the changelog?
