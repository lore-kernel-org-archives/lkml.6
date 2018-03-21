Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeCUQpG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:45:06 -0400
Received: from www62.your-server.de ([213.133.104.62]:59462 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbeCUQo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:44:56 -0400
Subject: Re: [PATCH 2/2] bpftool: Adjust to new print_bpf_insn interface
To: Jiri Olsa <jolsa@redhat.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20180321150212.5586-1-jolsa@kernel.org>
 <20180321150212.5586-2-jolsa@kernel.org>
 <c27c5c1c-79ee-3ed2-d1c3-a011ead4edea@netronome.com>
 <20180321164324.GD2707@krava>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <774f0eca-72cf-1c70-e025-beea2084ebe0@iogearbox.net>
Date: Wed, 21 Mar 2018 17:44:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180321164324.GD2707@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 05:43 PM, Jiri Olsa wrote:
> On Wed, Mar 21, 2018 at 04:39:09PM +0000, Quentin Monnet wrote:
>> 2018-03-21 16:02 UTC+0100 ~ Jiri Olsa <jolsa@kernel.org>
>>> Change bpftool to skip the removed struct bpf_verifier_env
>>> argument in print_bpf_insn. It was passed as NULL anyway.
>>>
>>> No functional change intended.
>>>
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>> ---
>>>  tools/bpf/bpftool/prog.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>>> index e549e329be82..108001d974ee 100644
>>> --- a/tools/bpf/bpftool/prog.c
>>> +++ b/tools/bpf/bpftool/prog.c
>>> @@ -489,7 +489,7 @@ static struct kernel_sym *kernel_syms_search(struct dump_data *dd,
>>>  		       sizeof(*dd->sym_mapping), kernel_syms_cmp) : NULL;
>>>  }
>>>  
>>> -static void print_insn(struct bpf_verifier_env *env, const char *fmt, ...)
>>> +static void print_insn(void *private_data, const char *fmt, ...)
>>>  {
>>>  	va_list args;
>>>  
>>> @@ -576,7 +576,7 @@ static void dump_xlated_plain(struct dump_data *dd, void *buf,
>>>  		double_insn = insn[i].code == (BPF_LD | BPF_IMM | BPF_DW);
>>>  
>>>  		printf("% 4d: ", i);
>>> -		print_bpf_insn(&cbs, NULL, insn + i, true);
>>> +		print_bpf_insn(&cbs, insn + i, true);
>>>  
>>>  		if (opcodes) {
>>>  			printf("       ");
>>> @@ -590,7 +590,7 @@ static void dump_xlated_plain(struct dump_data *dd, void *buf,
>>>  	}
>>>  }
>>>  
>>> -static void print_insn_json(struct bpf_verifier_env *env, const char *fmt, ...)
>>> +static void print_insn_json(void *private_data, const char *fmt, ...)
>>>  {
>>>  	unsigned int l = strlen(fmt);
>>>  	char chomped_fmt[l];
>>> @@ -628,7 +628,7 @@ static void dump_xlated_json(struct dump_data *dd, void *buf,
>>>  
>>>  		jsonw_start_object(json_wtr);
>>>  		jsonw_name(json_wtr, "disasm");
>>> -		print_bpf_insn(&cbs, NULL, insn + i, true);
>>> +		print_bpf_insn(&cbs, insn + i, true);
>>>  
>>>  		if (opcodes) {
>>>  			jsonw_name(json_wtr, "opcodes");
>>>
>>
>> Hi Jiri, this code has changed in the tree. It was moved to
>> tools/bpf/bpftool/xlated_dumper.c, and there is now a third function to
>> update: print_insn_for_graph(). Could you please rebase the patch?
> 
> sure.. I was over perf tree, I'll check on bpf tree

Just to be sure, it should be bpf-next. bpf is for fixes only.

Thanks,
Daniel
