Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbeCVQH5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:07:57 -0400
Received: from www62.your-server.de ([213.133.104.62]:40349 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeCVQHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:07:55 -0400
Subject: Re: [PATCH 1/2] bpf: Remove struct bpf_verifier_env argument from
 print_bpf_insn
To: Jiri Olsa <jolsa@redhat.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20180321150212.5586-1-jolsa@kernel.org>
 <d28f0a7f-3721-88f3-f4e9-97a73a8833e5@netronome.com>
 <20180321183749.GF2707@krava>
 <e30c5b79-c2a9-d0ed-e626-bf81a0705805@iogearbox.net>
 <20180322133222.GB3206@krava>
 <efa1cd74-12f4-2ac6-cc9a-50669b4b69de@netronome.com>
 <20180322155723.GD3206@krava>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <96093da6-9e0f-5d6b-59a4-91a744ad64cb@iogearbox.net>
Date: Thu, 22 Mar 2018 17:07:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180322155723.GD3206@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/2018 04:57 PM, Jiri Olsa wrote:
> On Thu, Mar 22, 2018 at 03:35:42PM +0000, Quentin Monnet wrote:
>> 2018-03-22 14:32 UTC+0100 ~ Jiri Olsa <jolsa@redhat.com>
>>> On Thu, Mar 22, 2018 at 10:34:18AM +0100, Daniel Borkmann wrote:
>>>> On 03/21/2018 07:37 PM, Jiri Olsa wrote:
>>>>> On Wed, Mar 21, 2018 at 05:25:33PM +0000, Quentin Monnet wrote:
>>>>>> 2018-03-21 16:02 UTC+0100 ~ Jiri Olsa <jolsa@kernel.org>
>>>>>>> We use print_bpf_insn in user space (bpftool and soon perf),
>>>>>>> so it'd be nice to keep it generic and strip it off the kernel
>>>>>>> struct bpf_verifier_env argument.
>>>>>>>
>>>>>>> This argument can be safely removed, because its users can
>>>>>>> use the struct bpf_insn_cbs::private_data to pass it.
>>>>>>>
>>>>>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>>>>>> ---
>>>>>>>  kernel/bpf/disasm.c   | 52 +++++++++++++++++++++++++--------------------------
>>>>>>>  kernel/bpf/disasm.h   |  5 +----
>>>>>>>  kernel/bpf/verifier.c |  6 +++---
>>>>>>>  3 files changed, 30 insertions(+), 33 deletions(-)
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>>>>> index c6eff108aa99..9f27d3fa7259 100644
>>>>>>> --- a/kernel/bpf/verifier.c
>>>>>>> +++ b/kernel/bpf/verifier.c
>>>>>>> @@ -202,8 +202,7 @@ EXPORT_SYMBOL_GPL(bpf_verifier_log_write);
>>>>>>>   * generic for symbol export. The function was renamed, but not the calls in
>>>>>>>   * the verifier to avoid complicating backports. Hence the alias below.
>>>>>>>   */
>>>>>>> -static __printf(2, 3) void verbose(struct bpf_verifier_env *env,
>>>>>>> -				   const char *fmt, ...)
>>>>>>> +static __printf(2, 3) void verbose(void *private_data, const char *fmt, ...)
>>>>>>>  	__attribute__((alias("bpf_verifier_log_write")));
>>>>>>
>>>>>> Just as a note, verbose() will be aliased to a function whose prototype
>>>>>> differs (bpf_verifier_log_write() still expects a struct
>>>>>> bpf_verifier_env as its first argument). I am not so familiar with
>>>>>> function aliases, could this change be a concern?
>>>>>
>>>>> yea, but as it was pointer for pointer switch I did not
>>>>> see any problem with that.. I'll check more
>>>>
>>>> Ok, holding off for now until we have clarification. Other option could also
>>>> be to make it void *private_data everywhere and for the kernel writer then
>>>> do struct bpf_verifier_env *env = private_data.
>>>
>>> can't find much info about the alias behaviour for this
>>> case.. so how about having separate function for the
>>> print_cb like below.. I still need to test it
>>
>> I have nothing against splitting the function. This is a solution I
>> considered for verbose() and bpf_verifier_log_write(), before switching
>> to function alias (on Daniel's suggestion) because the code would be
>> identical for the two separate functions at that time. But with your
>> change they would not have the same signature anymore, so it sounds
>> reasonable. Just a note below...
>>
>>>
>>> thanks,
>>> jirka
>>>
>>>
>>> ---
>>>  kernel/bpf/disasm.c   | 52 +++++++++++++++++++++++++--------------------------
>>>  kernel/bpf/disasm.h   |  5 +----
>>>  kernel/bpf/verifier.c | 41 +++++++++++++++++++++++++++++-----------
>>>  3 files changed, 57 insertions(+), 41 deletions(-)
>>>
>>
>> [...]
>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index e9f7c20691c1..69bf7590877c 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -168,23 +168,16 @@ struct bpf_call_arg_meta {
>>>  
>>>  static DEFINE_MUTEX(bpf_verifier_lock);
>>>  
>>> -/* log_level controls verbosity level of eBPF verifier.
>>> - * bpf_verifier_log_write() is used to dump the verification trace to the log,
>>> - * so the user can figure out what's wrong with the program
>>> - */
>>> -__printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
>>> -					   const char *fmt, ...)
>>> +static void log_write(struct bpf_verifier_env *env, const char *fmt,
>>> +		      va_list args)
>>>  {
>>>  	struct bpf_verifer_log *log = &env->log;
>>>  	unsigned int n;
>>> -	va_list args;
>>>  
>>>  	if (!log->level || !log->ubuf || bpf_verifier_log_full(log))
>>>  		return;
>>>  
>>> -	va_start(args, fmt);
>>>  	n = vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, args);
>>> -	va_end(args);
>>>  
>>>  	WARN_ONCE(n >= BPF_VERIFIER_TMP_LOG_SIZE - 1,
>>>  		  "verifier log line truncated - local buffer too short\n");
>>> @@ -197,7 +190,32 @@ __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
>>>  	else
>>>  		log->ubuf = NULL;
>>>  }
>>> +
>>> +/* log_level controls verbosity level of eBPF verifier.
>>> + * bpf_verifier_log_write() is used to dump the verification trace to the log,
>>> + * so the user can figure out what's wrong with the program
>>> + */
>>> +__printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
>>> +					   const char *fmt, ...)
>>> +{
>>> +	va_list args;
>>> +
>>> +	va_start(args, fmt);
>>> +	log_write(env, fmt, args);
>>> +	va_end(args);
>>> +}
>>>  EXPORT_SYMBOL_GPL(bpf_verifier_log_write);
>>> +
>>> +__printf(2, 3) static void print_ins(void *private_data,
>>> +				     const char *fmt, ...)
>>
>> Unless I am mistaken, you could just call this one "verbose()" and
>> simply remove the function alias?
> 
> right you are ;-) I haven't realized that struct bpf_verifier_env *env
> will cleanly cast to void * 
> 
> new version attached.. I'll make some tests and send full patch

When you do so, please make sure to send a full fresh series with the two
patches and also cover letter included, otherwise it's more fragile wrt
potentially applying the wrong patch from one of the replies. :-)

Thanks,
Daniel
