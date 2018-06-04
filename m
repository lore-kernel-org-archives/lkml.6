Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeFDSDb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:03:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751445AbeFDSD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:03:28 -0400
Date: Mon, 4 Jun 2018 13:03:25 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: jikos@kernel.org, jeyu@kernel.org, pmladek@suse.com,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: Send a fake signal periodically
Message-ID: <20180604180325.yeewbafxpjkt6gi5@treble>
References: <20180604141636.11523-1-mbenes@suse.cz>
 <20180604141636.11523-2-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604141636.11523-2-mbenes@suse.cz>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 04:16:35PM +0200, Miroslav Benes wrote:
> An administrator may send a fake signal to all remaining blocking tasks
> of a running transition by writing to
> /sys/kernel/livepatch/<patch>/signal attribute. Let's do it
> automatically after 10 seconds. The timeout is chosen deliberately. It
> gives the tasks enough time to transition themselves.
> 
> Theoretically, sending it once should be more than enough. Better be safe
> than sorry, so send it periodically.

This is the part I don't understand.  Why do it periodically?

Instead, might it make sense to just send the signals once, and if that
doesn't work, reverse the transition?  Then we could make patching a
synchronous operation.  But then, it might be remotely possible that the
reverse operation also stalls (e.g., on a kthread).  So, maybe it's best
to just leave all these controls in the hands of the user.

All that said, a few code review comments:

- AFAICT, it does an 8 second delay instead of a 10 second delay,
  because
  
  a) try_complete_transition() is first called before there's any delay;

  b) the preincrement operator used on signals_cnt.

- I think 15 seconds might be a better default.  I've seen longer
  patching delays on a system with 100+ CPUs.

- If a kthread or idle task is sleeping on a patched function, the
  pr_notice("signaling remaining tasks\n") will be repeated continously.

- It might be cleaner to do it from the delayed work function
  (klp_transition_work_fn).

-- 
Josh
