Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965602AbeBMRFs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:05:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965177AbeBMRFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:05:43 -0500
Subject: Re: [PATCH v5 0/2] kprobes: improve error handling when
 arming/disarming kprobes
To: Masami Hiramatsu <mhiramat@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180109235124.30886-1-jeyu@kernel.org>
 <20180119160607.5ed19168be13d27cf7f94531@kernel.org>
From: Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <1e95213f-1b57-00a4-46a3-70e9a9013994@redhat.com>
Date: Tue, 13 Feb 2018 12:05:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180119160607.5ed19168be13d27cf7f94531@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Was this patch ever picked up in the tip tree?  (Maybe I'm not looking
in the right branch?)

Thanks,

-- Joe


On 01/19/2018 02:06 AM, Masami Hiramatsu wrote:
> Hi Ingo,
> 
> Could you pick this to tip tree?
> 
> Thank you,
> 
> On Wed, 10 Jan 2018 00:51:22 +0100
> Jessica Yu <jeyu@kernel.org> wrote:
> 
>> Hi,
>>
>> This patchset attempts to improve error handling when arming or disarming
>> ftrace-based kprobes. The current behavior is to simply WARN when ftrace
>> (un-)registration fails, without propagating the error code. This can lead
>> to confusing situations where, for example, register_kprobe()/enable_kprobe()
>> would return 0 indicating success even if arming via ftrace had failed. In
>> this scenario we'd end up with a non-functioning kprobe even though kprobe
>> registration (or enablement) returned success. In this patchset, we take
>> errors from ftrace into account and propagate the error when we cannot arm
>> or disarm a kprobe.
>>
>> Below is an example that illustrates the problem using livepatch and
>> systemtap (which uses kprobes underneath). Both livepatch and kprobes use
>> ftrace ops with the IPMODIFY flag set, so registration at the same
>> function entry is limited to only one ftrace user. 
>>
>> Before
>> ------
>> # modprobe livepatch-sample 	# patches cmdline_proc_show, ftrace ops has IPMODIFY set
>> # stap -e 'probe kernel.function("cmdline_proc_show").call { printf ("cmdline_proc_show\n"); }'
>>
>>    .. (nothing prints after reading /proc/cmdline) ..
>>
>> The systemtap handler doesn't execute due to a kprobe arming failure caused
>> by a ftrace IPMODIFY conflict with livepatch, and there isn't an obvious
>> indication of error from systemtap (because register_kprobe() returned
>> success) unless the user inspects dmesg.
>>
>> After
>> -----
>> # modprobe livepatch-sample 
>> # stap -e 'probe kernel.function("cmdline_proc_show").call { printf ("cmdline_proc_show\n"); }'
>> WARNING: probe kernel.function("cmdline_proc_show@/home/jeyu/work/linux-next/fs/proc/cmdline.c:6").call (address 0xffffffffa82fe910) registration error (rc -16)
>>
>> Although the systemtap handler doesn't execute (as it shouldn't), the
>> ftrace error is propagated and now systemtap prints a visible error message
>> stating that (kprobe) registration had failed (because register_kprobe()
>> returned an error), along with the propagated error code.
>>
>> This patchset was based on Petr Mladek's original patchset (patches 2 and 3)
>> back in 2015, which improved kprobes error handling, found here:
>>
>>    https://lkml.org/lkml/2015/2/26/452
>>
>> However, further work on this had been paused since then and the patches
>> were not upstreamed.
>>
>> This patchset has been lightly sanity-tested (on linux-next) with kprobes,
>> kretprobes, and optimized kprobes. It passes the kprobes smoke test, but
>> more testing is greatly appreciated.
>>
>> Changes from v4:
>>  - Switch from WARN() to pr_debug() in arm_kprobe_ftrace() so the stack
>>    dumps don't pollute dmesg, as IPMODIFY conflicts can occur in normal usage
>>  - Added Masami's ack to the first patch
>>
>> Changes from v3:
>>  - Have (dis)arm_kprobe_ftrace() return -ENODEV instead of 0 in case of
>>    !CONFIG_KPROBES_ON_FTRACE
>>  - Add total count of all probes tried in (dis)arm_all_kprobes()
>>
>> Changes from v2:
>>  - Add missing synchronize rcu in register_aggr_kprobe()
>>  - s/kprobes/probes/ on error message in (dis)arm_all_kprobes()
>>
>> Changes from v1:
>> - Don't arm the kprobe before adding it to the kprobe table, otherwise
>>   we'll temporarily see a stray breakpoint.
>> - Remove kprobe from the kprobe_table and call synchronize_sched() if
>>   arming during register_kprobe() fails.
>> - add Masami's ack on the 2nd patch (unchanged from v1)
>>
>> ---
>> Jessica Yu (2):
>>   kprobes: propagate error from arm_kprobe_ftrace()
>>   kprobes: propagate error from disarm_kprobe_ftrace()
>>
>>  kernel/kprobes.c | 178 +++++++++++++++++++++++++++++++++++++++----------------
>>  1 file changed, 128 insertions(+), 50 deletions(-)
>>
>> -- 
>> 2.13.6
>>
> 
> 
