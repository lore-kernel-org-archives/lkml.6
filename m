Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeDIMZ5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:25:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751988AbeDIMZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:25:55 -0400
Date: Mon, 9 Apr 2018 14:25:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: fix use-after-free in uprobe_perf_close
Message-ID: <20180409122553.GA24920@redhat.com>
References: <20180409100346.6416-1-bhole_prashant_q7@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409100346.6416-1-bhole_prashant_q7@lab.ntt.co.jp>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09, Prashant Bhole wrote:
>
> It occurs because task_struct is freed before perf_event which refers
> to the task and task flags are checked while teardown of the event.
> perf_event_alloc() assigns task_struct to hw.target of perf_event,
> but there is no reference counting for it.
>
> As a fix we get_task_struct() in perf_event_alloc() at above mentioned
> assignment and put_task_struct() in _free_event().
>
> Signed-off-by: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>

Agreed, lets make a simple fix for the start. I'd suggest cc:stable,
afaics this fixes the commit 63b6da39bb38e8f1a1ef3180d32a39d6
("perf: Fix perf_event_exit_task() race").

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
