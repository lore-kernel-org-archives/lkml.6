Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164771AbeBOPdE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:33:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56086 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164702AbeBOPdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:33:00 -0500
Date: Thu, 15 Feb 2018 15:33:07 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: arm64/v4.16-rc1: KASAN: use-after-free Read in finish_task_switch
Message-ID: <20180215153307.GA11712@arm.com>
References: <20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com>
 <20180214150739.GH2992@arm.com>
 <20180214165131.o25r3hhrtrjk3ejq@lakrids.cambridge.arm.com>
 <254787533.21950.1518634424009.JavaMail.zimbra@efficios.com>
 <20180215142239.GF16623@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215142239.GF16623@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 02:22:39PM +0000, Will Deacon wrote:
> Assuming others agree with this diagnosis, I'm not sure how to fix it.
> It's basically not safe to set current->mm = NULL with preemption enabled.

One thing we could try would be to leave current->mm alone and just do the
mmdrop in finish_task_switch at the point where we put the task_struct for
DEAD tasks. mm_update_next_owner might need updating so that it doesn't
re-assign current as the owner and run into a BUG_ON.


Will
