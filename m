Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeBZK1A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:27:00 -0500
Received: from www62.your-server.de ([213.133.104.62]:52715 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbeBZK0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:26:55 -0500
Subject: Re: [PATCH bpf-next v2] samples/bpf: Add program for CPU state
 statistics
To: Leo Yan <leo.yan@linaro.org>, Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <1519607952-12299-1-git-send-email-leo.yan@linaro.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1e487d11-4f15-09e5-2f53-08b9b30e1494@iogearbox.net>
Date: Mon, 26 Feb 2018 11:26:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1519607952-12299-1-git-send-email-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/2018 02:19 AM, Leo Yan wrote:
> CPU is active when have running tasks on it and CPUFreq governor can
> select different operating points (OPP) according to different workload;
> we use 'pstate' to present CPU state which have running tasks with one
> specific OPP.  On the other hand, CPU is idle which only idle task on
> it, CPUIdle governor can select one specific idle state to power off
> hardware logics; we use 'cstate' to present CPU idle state.
> 
> Based on trace events 'cpu_idle' and 'cpu_frequency' we can accomplish
> the duration statistics for every state.  Every time when CPU enters
> into or exits from idle states, the trace event 'cpu_idle' is recorded;
> trace event 'cpu_frequency' records the event for CPU OPP changing, so
> it's easily to know how long time the CPU stays in the specified OPP,
> and the CPU must be not in any idle state.
> 
> This patch is to utilize the mentioned trace events for pstate and
> cstate statistics.  To achieve more accurate profiling data, the program
> uses below sequence to insure CPU running/idle time aren't missed:
> 
> - Before profiling the user space program wakes up all CPUs for once, so
>   can avoid to missing account time for CPU staying in idle state for
>   long time; the program forces to set 'scaling_max_freq' to lowest
>   frequency and then restore 'scaling_max_freq' to highest frequency,
>   this can ensure the frequency to be set to lowest frequency and later
>   after start to run workload the frequency can be easily to be changed
>   to higher frequency;
> 
> - User space program reads map data and update statistics for every 5s,
>   so this is same with other sample bpf programs for avoiding big
>   overload introduced by bpf program self;
> 
> - When send signal to terminate program, the signal handler wakes up
>   all CPUs, set lowest frequency and restore highest frequency to
>   'scaling_max_freq'; this is exactly same with the first step so
>   avoid to missing account CPU pstate and cstate time during last
>   stage.  Finally it reports the latest statistics.
> 
> The program has been tested on Hikey board with octa CA53 CPUs, below
> is one example for statistics result, the format mainly follows up
> Jesper Dangaard Brouer suggestion.
> 
> Jesper reminds to 'get printf to pretty print with thousands separators
> use %' and setlocale(LC_NUMERIC, "en_US")', tried three different arm64
> GCC toolchains (5.4.0 20160609, 6.2.1 20161016, 6.3.0 20170516) but all
> of them cannot support printf flag character %' on arm64 platform, so go
> back print number without grouping mode.
> 
> CPU states statistics:
> state(ms)  cstate-0    cstate-1    cstate-2    pstate-0    pstate-1    pstate-2    pstate-3    pstate-4
> CPU-0      767         6111        111863      561         31          756         853         190
> CPU-1      241         10606       107956      484         125         646         990         85
> CPU-2      413         19721       98735       636         84          696         757         89
> CPU-3      84          11711       79989       17516       909         4811        5773        341
> CPU-4      152         19610       98229       444         53          649         708         1283
> CPU-5      185         8781        108697      666         91          671         677         1365
> CPU-6      157         21964       95825       581         67          566         684         1284
> CPU-7      125         15238       102704      398         20          665         786         1197
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Applied to bpf-next, thanks Leo!
