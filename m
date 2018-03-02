Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163932AbeCBBQM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 20:16:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38778 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163425AbeCBBQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 20:16:11 -0500
Date: Thu, 1 Mar 2018 17:16:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infraded.org>,
        Rik van Riel <riel@redhat.com>, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] Detect early free of a live mm
Message-Id: <20180301171609.c1968b89a15320186122e34e@linux-foundation.org>
In-Reply-To: <20180228121458.2230-1-mark.rutland@arm.com>
References: <20180228121458.2230-1-mark.rutland@arm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018 12:14:58 +0000 Mark Rutland <mark.rutland@arm.com> wrote:

> KASAN splats indicate that in some cases we free a live mm, then
> continue to access it, with potentially disastrous results. This is
> likely due to a mismatched mmdrop() somewhere in the kernel, but so far
> the culprit remains elusive.
> 
> Let's have __mmdrop() verify that the mm isn't live for the current
> task, similar to the existing check for init_mm. This way, we can catch
> this class of issue earlier, and without requiring KASAN.

Presumably the results usually aren't disastrous.  But they will be if
we go and add BUG_ON()s!  Can we make this WARN_ON[_ONCE]()?  We should
still get the same info from testers.
