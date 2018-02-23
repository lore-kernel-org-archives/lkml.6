Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x22436HEgFTVgZHI1CmNwFC+mx5Y74DklyXpAP8kXhvATxcNVdzBNmehMVEhOMb/Pb5IVcrQk
ARC-Seal: i=1; a=rsa-sha256; t=1519379029; cv=none;
        d=google.com; s=arc-20160816;
        b=zLc19I/gyQ1wTJKBMcJweWGx2cWYiQwGBipscr/8mkPdQOt8LL3GKSWRZu61mO+7So
         fqY1EjrG9ZP8elKUCan3stftyklUWypFcdZ7Zk4scBxznF3D9ZfQNbJku0oDTv7c0kxr
         SBpsU6twgHFGaXFk5mFt4T3b9jvQEVxqpDJEPRxplVYF2z9lU6IBeutblKQRloHKtfEV
         XN0fpKaSEtcfQL9m5P7uZFNBEVN4SsipbxdQtZ4YOJbpUhjY4+/xSWS1P7xS2PSe6Hk1
         XrdcJQ9NGXEp4D1Q2PvPigSMsFYg29J7Irkm54ZggK4ebo3clyAjGsVr5HYGjj8B6ZsA
         cLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=f4pPvrbgEe0OASO2AqAwPTg1th1JG+vzfYzY/ZTsBwE=;
        b=ZzX9LIytCBqohQn1VgAhRMSqDJs0uBBwuUl0H4M09HxkXCuzaAfNLgTLQoWfF9aNGy
         KiLngIGRcU12k+juoZ+YAcSUq4HxfDZzDs/4NAtaR4PeTcAMMD7cI1JgpEqddo67SwOB
         PODtjB7jkcUuLvLssXwiFWTNslTzRF10zubvRSUi/jE9qdtEDRQH7INP2ozUGOsUWH9H
         hqZgjQuvZ8ylQ5qUu7riEVeotDo6VOzPnwDzGQ1ltMa4Mu3i3PdEUBtSljzhPT7gcGof
         Ww9VvMbajc90iqaBDYJui1APVQrpk9u8JH0+6uCYq5+j3QTTqmgIQiCpiSz040y+xa2k
         5XmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeBWJnt (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 23 Feb 2018 04:43:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750879AbeBWJns (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Feb 2018 04:43:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9835C217A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Fri, 23 Feb 2018 18:43:44 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v2 07/17] tracing: probeevent: Introduce new argument
 fetching code
Message-Id: <20180223184344.6cbcfd826dc2468ad5e58ac4@kernel.org>
In-Reply-To: <20180223043003.GA26085@sejong>
References: <151922484560.6217.1143686155616343906.stgit@devbox>
        <151922505665.6217.12572130633964212527.stgit@devbox>
        <20180223043003.GA26085@sejong>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593022961949505365?=
X-GMAIL-MSGID: =?utf-8?q?1593184385259864746?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 13:30:03 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> On Wed, Feb 21, 2018 at 11:57:36PM +0900, Masami Hiramatsu wrote:
> > Replace {k,u}probe event argument fetching framework
> > with switch-case based. Currently that is implemented
> > with structures, macros and chain of function-pointers,
> > which is more complicated than necessary and may get
> > a performance penalty by retpoline.
> > 
> > This simplify that with an array of "fetch_insn" (opcode
> > and oprands), and make process_fetch_insn() just
> > interprets it. No function pointers are used.
> 
> I think it'd be nice to split this commit to 3 parts:
> 
>  * convert to the fetch_insn
>  * remove fetch methods (now unused)

Hmm, I think we can do above 2 parts at a time, because fetch
methods are internal implementation, which is closed among
probe-event.

>  * unify fetch type table

Sure. this is an actual cleanup.

Thank you,

> 
> Thanks,
> Namhyung
> 
> 
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  Changes in v2:
> >   - Allow $comm:string.
> > ---
> >  kernel/trace/trace_kprobe.c     |  314 +++++++++++-----------------
> >  kernel/trace/trace_probe.c      |  441 ++++++++++++---------------------------
> >  kernel/trace/trace_probe.h      |  232 ++++-----------------
> >  kernel/trace/trace_probe_tmpl.h |  120 +++++++++++
> >  kernel/trace/trace_uprobe.c     |  150 +++++++------
> >  5 files changed, 517 insertions(+), 740 deletions(-)
> >  create mode 100644 kernel/trace/trace_probe_tmpl.h
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index a96328dfc012..5dd2d470cc7e 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/error-injection.h>
> >  
> >  #include "trace_probe.h"
> > +#include "trace_probe_tmpl.h"
> >  
> >  #define KPROBE_EVENT_SYSTEM "kprobes"
> >  #define KRETPROBE_MAXACTIVE_MAX 4096
> > @@ -121,184 +122,6 @@ static int kprobe_dispatcher(struct kprobe *kp, struct pt_regs *regs);
> >  static int kretprobe_dispatcher(struct kretprobe_instance *ri,
> >  				struct pt_regs *regs);
> >  
> > -/* Memory fetching by symbol */
> > -struct symbol_cache {
> > -	char		*symbol;
> > -	long		offset;
> > -	unsigned long	addr;
> > -};
> > -
> > -unsigned long update_symbol_cache(struct symbol_cache *sc)
> > -{
> > -	sc->addr = (unsigned long)kallsyms_lookup_name(sc->symbol);
> > -
> > -	if (sc->addr)
> > -		sc->addr += sc->offset;
> > -
> > -	return sc->addr;
> > -}
> > -
> > -void free_symbol_cache(struct symbol_cache *sc)
> > -{
> > -	kfree(sc->symbol);
> > -	kfree(sc);
> > -}
> > -
> > -struct symbol_cache *alloc_symbol_cache(const char *sym, long offset)
> > -{
> > -	struct symbol_cache *sc;
> > -
> > -	if (!sym || strlen(sym) == 0)
> > -		return NULL;
> > -
> > -	sc = kzalloc(sizeof(struct symbol_cache), GFP_KERNEL);
> > -	if (!sc)
> > -		return NULL;
> > -
> > -	sc->symbol = kstrdup(sym, GFP_KERNEL);
> > -	if (!sc->symbol) {
> > -		kfree(sc);
> > -		return NULL;
> > -	}
> > -	sc->offset = offset;
> > -	update_symbol_cache(sc);
> > -
> > -	return sc;
> > -}
> > -
> > -/*
> > - * Kprobes-specific fetch functions
> > - */
> > -#define DEFINE_FETCH_stack(type)					\
> > -static void FETCH_FUNC_NAME(stack, type)(struct pt_regs *regs,		\
> > -					  void *offset, void *dest)	\
> > -{									\
> > -	*(type *)dest = (type)regs_get_kernel_stack_nth(regs,		\
> > -				(unsigned int)((unsigned long)offset));	\
> > -}									\
> > -NOKPROBE_SYMBOL(FETCH_FUNC_NAME(stack, type));
> > -
> > -DEFINE_BASIC_FETCH_FUNCS(stack)
> > -/* No string on the stack entry */
> > -#define fetch_stack_string	NULL
> > -#define fetch_stack_string_size	NULL
> > -
> > -#define DEFINE_FETCH_memory(type)					\
> > -static void FETCH_FUNC_NAME(memory, type)(struct pt_regs *regs,		\
> > -					  void *addr, void *dest)	\
> > -{									\
> > -	type retval;							\
> > -	if (probe_kernel_address(addr, retval))				\
> > -		*(type *)dest = 0;					\
> > -	else								\
> > -		*(type *)dest = retval;					\
> > -}									\
> > -NOKPROBE_SYMBOL(FETCH_FUNC_NAME(memory, type));
> > -
> > -DEFINE_BASIC_FETCH_FUNCS(memory)
> > -/*
> > - * Fetch a null-terminated string. Caller MUST set *(u32 *)dest with max
> > - * length and relative data location.
> > - */
> > -static void FETCH_FUNC_NAME(memory, string)(struct pt_regs *regs,
> > -					    void *addr, void *dest)
> > -{
> > -	int maxlen = get_rloc_len(*(u32 *)dest);
> > -	u8 *dst = get_rloc_data(dest);
> > -	long ret;
> > -
> > -	if (!maxlen)
> > -		return;
> > -
> > -	/*
> > -	 * Try to get string again, since the string can be changed while
> > -	 * probing.
> > -	 */
> > -	ret = strncpy_from_unsafe(dst, addr, maxlen);
> > -
> > -	if (ret < 0) {	/* Failed to fetch string */
> > -		dst[0] = '\0';
> > -		*(u32 *)dest = make_data_rloc(0, get_rloc_offs(*(u32 *)dest));
> > -	} else {
> > -		*(u32 *)dest = make_data_rloc(ret, get_rloc_offs(*(u32 *)dest));
> > -	}
> > -}
> > -NOKPROBE_SYMBOL(FETCH_FUNC_NAME(memory, string));
> > -
> > -/* Return the length of string -- including null terminal byte */
> > -static void FETCH_FUNC_NAME(memory, string_size)(struct pt_regs *regs,
> > -						 void *addr, void *dest)
> > -{
> > -	mm_segment_t old_fs;
> > -	int ret, len = 0;
> > -	u8 c;
> > -
> > -	old_fs = get_fs();
> > -	set_fs(KERNEL_DS);
> > -	pagefault_disable();
> > -
> > -	do {
> > -		ret = __copy_from_user_inatomic(&c, (u8 *)addr + len, 1);
> > -		len++;
> > -	} while (c && ret == 0 && len < MAX_STRING_SIZE);
> > -
> > -	pagefault_enable();
> > -	set_fs(old_fs);
> > -
> > -	if (ret < 0)	/* Failed to check the length */
> > -		*(u32 *)dest = 0;
> > -	else
> > -		*(u32 *)dest = len;
> > -}
> > -NOKPROBE_SYMBOL(FETCH_FUNC_NAME(memory, string_size));
> > -
> > -#define DEFINE_FETCH_symbol(type)					\
> > -void FETCH_FUNC_NAME(symbol, type)(struct pt_regs *regs, void *data, void *dest)\
> > -{									\
> > -	struct symbol_cache *sc = data;					\
> > -	if (sc->addr)							\
> > -		fetch_memory_##type(regs, (void *)sc->addr, dest);	\
> > -	else								\
> > -		*(type *)dest = 0;					\
> > -}									\
> > -NOKPROBE_SYMBOL(FETCH_FUNC_NAME(symbol, type));
> > -
> > -DEFINE_BASIC_FETCH_FUNCS(symbol)
> > -DEFINE_FETCH_symbol(string)
> > -DEFINE_FETCH_symbol(string_size)
> > -
> > -/* kprobes don't support file_offset fetch methods */
> > -#define fetch_file_offset_u8		NULL
> > -#define fetch_file_offset_u16		NULL
> > -#define fetch_file_offset_u32		NULL
> > -#define fetch_file_offset_u64		NULL
> > -#define fetch_file_offset_string	NULL
> > -#define fetch_file_offset_string_size	NULL
> > -
> > -/* Fetch type information table */
> > -static const struct fetch_type kprobes_fetch_type_table[] = {
> > -	/* Special types */
> > -	[FETCH_TYPE_STRING] = __ASSIGN_FETCH_TYPE("string", string, string,
> > -					sizeof(u32), 1, "__data_loc char[]"),
> > -	[FETCH_TYPE_STRSIZE] = __ASSIGN_FETCH_TYPE("string_size", u32,
> > -					string_size, sizeof(u32), 0, "u32"),
> > -	/* Basic types */
> > -	ASSIGN_FETCH_TYPE(u8,  u8,  0),
> > -	ASSIGN_FETCH_TYPE(u16, u16, 0),
> > -	ASSIGN_FETCH_TYPE(u32, u32, 0),
> > -	ASSIGN_FETCH_TYPE(u64, u64, 0),
> > -	ASSIGN_FETCH_TYPE(s8,  u8,  1),
> > -	ASSIGN_FETCH_TYPE(s16, u16, 1),
> > -	ASSIGN_FETCH_TYPE(s32, u32, 1),
> > -	ASSIGN_FETCH_TYPE(s64, u64, 1),
> > -	ASSIGN_FETCH_TYPE_ALIAS(x8,  u8,  u8,  0),
> > -	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
> > -	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
> > -	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
> > -
> > -	ASSIGN_FETCH_TYPE_END
> > -};
> > -
> >  /*
> >   * Allocate new trace_probe and initialize it (including kprobes).
> >   */
> > @@ -490,14 +313,11 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
> >  /* Internal register function - just handle k*probes and flags */
> >  static int __register_trace_kprobe(struct trace_kprobe *tk)
> >  {
> > -	int i, ret;
> > +	int ret;
> >  
> >  	if (trace_probe_is_registered(&tk->tp))
> >  		return -EINVAL;
> >  
> > -	for (i = 0; i < tk->tp.nr_args; i++)
> > -		traceprobe_update_arg(&tk->tp.args[i]);
> > -
> >  	/* Set/clear disabled flag according to tp->flag */
> >  	if (trace_probe_is_enabled(&tk->tp))
> >  		tk->rp.kp.flags &= ~KPROBE_FLAG_DISABLED;
> > @@ -830,8 +650,7 @@ static int create_trace_kprobe(int argc, char **argv)
> >  
> >  		/* Parse fetch argument */
> >  		ret = traceprobe_parse_probe_arg(arg, &tk->tp.size, parg,
> > -						is_return, true,
> > -						kprobes_fetch_type_table);
> > +						 is_return, true);
> >  		if (ret) {
> >  			pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
> >  			goto error;
> > @@ -985,6 +804,133 @@ static const struct file_operations kprobe_profile_ops = {
> >  	.release        = seq_release,
> >  };
> >  
> > +/* Kprobe specific fetch functions */
> > +
> > +/* Return the length of string -- including null terminal byte */
> > +static nokprobe_inline void
> > +fetch_store_strlen(unsigned long addr, void *dest)
> > +{
> > +	mm_segment_t old_fs;
> > +	int ret, len = 0;
> > +	u8 c;
> > +
> > +	old_fs = get_fs();
> > +	set_fs(KERNEL_DS);
> > +	pagefault_disable();
> > +
> > +	do {
> > +		ret = __copy_from_user_inatomic(&c, (u8 *)addr + len, 1);
> > +		len++;
> > +	} while (c && ret == 0 && len < MAX_STRING_SIZE);
> > +
> > +	pagefault_enable();
> > +	set_fs(old_fs);
> > +
> > +	if (ret < 0)	/* Failed to check the length */
> > +		*(u32 *)dest = 0;
> > +	else
> > +		*(u32 *)dest = len;
> > +}
> > +
> > +/*
> > + * Fetch a null-terminated string. Caller MUST set *(u32 *)buf with max
> > + * length and relative data location.
> > + */
> > +static nokprobe_inline void
> > +fetch_store_string(unsigned long addr, void *dest)
> > +{
> > +	int maxlen = get_rloc_len(*(u32 *)dest);
> > +	u8 *dst = get_rloc_data(dest);
> > +	long ret;
> > +
> > +	if (!maxlen)
> > +		return;
> > +
> > +	/*
> > +	 * Try to get string again, since the string can be changed while
> > +	 * probing.
> > +	 */
> > +	ret = strncpy_from_unsafe(dst, (void *)addr, maxlen);
> > +
> > +	if (ret < 0) {	/* Failed to fetch string */
> > +		dst[0] = '\0';
> > +		*(u32 *)dest = make_data_rloc(0, get_rloc_offs(*(u32 *)dest));
> > +	} else {
> > +		*(u32 *)dest = make_data_rloc(ret, get_rloc_offs(*(u32 *)dest));
> > +	}
> > +}
> > +
> > +/* Note that we don't verify it, since the code does not come from user space */
> > +static int
> > +process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
> > +		   bool pre)
> > +{
> > +	unsigned long val;
> > +	int ret;
> > +
> > +	/* 1st stage: get value from context */
> > +	switch (code->op) {
> > +	case FETCH_OP_REG:
> > +		val = regs_get_register(regs, code->param);
> > +		break;
> > +	case FETCH_OP_STACK:
> > +		val = regs_get_kernel_stack_nth(regs, code->param);
> > +		break;
> > +	case FETCH_OP_STACKP:
> > +		val = kernel_stack_pointer(regs);
> > +		break;
> > +	case FETCH_OP_RETVAL:
> > +		val = regs_return_value(regs);
> > +		break;
> > +	case FETCH_OP_IMM:
> > +		val = code->immediate;
> > +		break;
> > +	case FETCH_OP_COMM:
> > +		val = (unsigned long)current->comm;
> > +		break;
> > +	default:
> > +		return -EILSEQ;
> > +	}
> > +	code++;
> > +
> > +	/* 2nd stage: dereference memory if needed */
> > +	while (code->op == FETCH_OP_DEREF) {
> > +		ret = probe_kernel_read(&val, (void *)val + code->offset,
> > +					sizeof(val));
> > +		if (ret)
> > +			return ret;
> > +		code++;
> > +	}
> > +
> > +	/* 3rd stage: store value to buffer */
> > +	switch (code->op) {
> > +	case FETCH_OP_ST_RAW:
> > +		fetch_store_raw(val, code, dest);
> > +		break;
> > +	case FETCH_OP_ST_MEM:
> > +		probe_kernel_read(dest, (void *)val + code->offset, code->size);
> > +		break;
> > +	case FETCH_OP_ST_STRING:
> > +		if (pre)
> > +			fetch_store_strlen(val + code->offset, dest);
> > +		else
> > +			fetch_store_string(val + code->offset, dest);
> > +		break;
> > +	default:
> > +		return -EILSEQ;
> > +	}
> > +	code++;
> > +
> > +	/* 4th stage: modify stored value if needed */
> > +	if (code->op == FETCH_OP_MOD_BF) {
> > +		fetch_apply_bitfield(code, dest);
> > +		code++;
> > +	}
> > +
> > +	return code->op == FETCH_OP_END ? 0 : -EILSEQ;
> > +}
> > +NOKPROBE_SYMBOL(process_fetch_insn)
> > +
> >  /* Kprobe handler */
> >  static nokprobe_inline void
> >  __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 37bdd56b4988..cd87490b3492 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -73,176 +73,29 @@ int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, void *data, void *ent)
> >  
> >  const char PRINT_TYPE_FMT_NAME(string)[] = "\\\"%s\\\"";
> >  
> > -#define CHECK_FETCH_FUNCS(method, fn)			\
> > -	(((FETCH_FUNC_NAME(method, u8) == fn) ||	\
> > -	  (FETCH_FUNC_NAME(method, u16) == fn) ||	\
> > -	  (FETCH_FUNC_NAME(method, u32) == fn) ||	\
> > -	  (FETCH_FUNC_NAME(method, u64) == fn) ||	\
> > -	  (FETCH_FUNC_NAME(method, string) == fn) ||	\
> > -	  (FETCH_FUNC_NAME(method, string_size) == fn)) \
> > -	 && (fn != NULL))
> > -
> > -/* Data fetch function templates */
> > -#define DEFINE_FETCH_reg(type)						\
> > -void FETCH_FUNC_NAME(reg, type)(struct pt_regs *regs, void *offset, void *dest)	\
> > -{									\
> > -	*(type *)dest = (type)regs_get_register(regs,			\
> > -				(unsigned int)((unsigned long)offset));	\
> > -}									\
> > -NOKPROBE_SYMBOL(FETCH_FUNC_NAME(reg, type));
> > -DEFINE_BASIC_FETCH_FUNCS(reg)
> > -/* No string on the register */
> > -#define fetch_reg_string	NULL
> > -#define fetch_reg_string_size	NULL
> > -
> > -#define DEFINE_FETCH_retval(type)					\
> > -void FETCH_FUNC_NAME(retval, type)(struct pt_regs *regs,		\
> > -				   void *dummy, void *dest)		\
> > -{									\
> > -	*(type *)dest = (type)regs_return_value(regs);			\
> > -}									\
> > -NOKPROBE_SYMBOL(FETCH_FUNC_NAME(retval, type));
> > -DEFINE_BASIC_FETCH_FUNCS(retval)
> > -/* No string on the retval */
> > -#define fetch_retval_string		NULL
> > -#define fetch_retval_string_size	NULL
> > -
> > -/* Dereference memory access function */
> > -struct deref_fetch_param {
> > -	struct fetch_param	orig;
> > -	long			offset;
> > -	fetch_func_t		fetch;
> > -	fetch_func_t		fetch_size;
> > -};
> > -
> > -#define DEFINE_FETCH_deref(type)					\
> > -void FETCH_FUNC_NAME(deref, type)(struct pt_regs *regs,			\
> > -				  void *data, void *dest)		\
> > -{									\
> > -	struct deref_fetch_param *dprm = data;				\
> > -	unsigned long addr;						\
> > -	call_fetch(&dprm->orig, regs, &addr);				\
> > -	if (addr) {							\
> > -		addr += dprm->offset;					\
> > -		dprm->fetch(regs, (void *)addr, dest);			\
> > -	} else								\
> > -		*(type *)dest = 0;					\
> > -}									\
> > -NOKPROBE_SYMBOL(FETCH_FUNC_NAME(deref, type));
> > -DEFINE_BASIC_FETCH_FUNCS(deref)
> > -DEFINE_FETCH_deref(string)
> > -
> > -void FETCH_FUNC_NAME(deref, string_size)(struct pt_regs *regs,
> > -					 void *data, void *dest)
> > -{
> > -	struct deref_fetch_param *dprm = data;
> > -	unsigned long addr;
> > -
> > -	call_fetch(&dprm->orig, regs, &addr);
> > -	if (addr && dprm->fetch_size) {
> > -		addr += dprm->offset;
> > -		dprm->fetch_size(regs, (void *)addr, dest);
> > -	} else
> > -		*(string_size *)dest = 0;
> > -}
> > -NOKPROBE_SYMBOL(FETCH_FUNC_NAME(deref, string_size));
> > -
> > -static void update_deref_fetch_param(struct deref_fetch_param *data)
> > -{
> > -	if (CHECK_FETCH_FUNCS(deref, data->orig.fn))
> > -		update_deref_fetch_param(data->orig.data);
> > -	else if (CHECK_FETCH_FUNCS(symbol, data->orig.fn))
> > -		update_symbol_cache(data->orig.data);
> > -}
> > -NOKPROBE_SYMBOL(update_deref_fetch_param);
> > -
> > -static void free_deref_fetch_param(struct deref_fetch_param *data)
> > -{
> > -	if (CHECK_FETCH_FUNCS(deref, data->orig.fn))
> > -		free_deref_fetch_param(data->orig.data);
> > -	else if (CHECK_FETCH_FUNCS(symbol, data->orig.fn))
> > -		free_symbol_cache(data->orig.data);
> > -	kfree(data);
> > -}
> > -NOKPROBE_SYMBOL(free_deref_fetch_param);
> > -
> > -/* Bitfield fetch function */
> > -struct bitfield_fetch_param {
> > -	struct fetch_param	orig;
> > -	unsigned char		hi_shift;
> > -	unsigned char		low_shift;
> > +/* Fetch type information table */
> > +static const struct fetch_type probe_fetch_types[] = {
> > +	/* Special types */
> > +	__ASSIGN_FETCH_TYPE("string", string, string, sizeof(u32), 1,
> > +			    "__data_loc char[]"),
> > +	/* Basic types */
> > +	ASSIGN_FETCH_TYPE(u8,  u8,  0),
> > +	ASSIGN_FETCH_TYPE(u16, u16, 0),
> > +	ASSIGN_FETCH_TYPE(u32, u32, 0),
> > +	ASSIGN_FETCH_TYPE(u64, u64, 0),
> > +	ASSIGN_FETCH_TYPE(s8,  u8,  1),
> > +	ASSIGN_FETCH_TYPE(s16, u16, 1),
> > +	ASSIGN_FETCH_TYPE(s32, u32, 1),
> > +	ASSIGN_FETCH_TYPE(s64, u64, 1),
> > +	ASSIGN_FETCH_TYPE_ALIAS(x8,  u8,  u8,  0),
> > +	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
> > +	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
> > +	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
> > +
> > +	ASSIGN_FETCH_TYPE_END
> >  };
> >  
> > -#define DEFINE_FETCH_bitfield(type)					\
> > -void FETCH_FUNC_NAME(bitfield, type)(struct pt_regs *regs,		\
> > -				     void *data, void *dest)		\
> > -{									\
> > -	struct bitfield_fetch_param *bprm = data;			\
> > -	type buf = 0;							\
> > -	call_fetch(&bprm->orig, regs, &buf);				\
> > -	if (buf) {							\
> > -		buf <<= bprm->hi_shift;					\
> > -		buf >>= bprm->low_shift;				\
> > -	}								\
> > -	*(type *)dest = buf;						\
> > -}									\
> > -NOKPROBE_SYMBOL(FETCH_FUNC_NAME(bitfield, type));
> > -DEFINE_BASIC_FETCH_FUNCS(bitfield)
> > -#define fetch_bitfield_string		NULL
> > -#define fetch_bitfield_string_size	NULL
> > -
> > -static void
> > -update_bitfield_fetch_param(struct bitfield_fetch_param *data)
> > -{
> > -	/*
> > -	 * Don't check the bitfield itself, because this must be the
> > -	 * last fetch function.
> > -	 */
> > -	if (CHECK_FETCH_FUNCS(deref, data->orig.fn))
> > -		update_deref_fetch_param(data->orig.data);
> > -	else if (CHECK_FETCH_FUNCS(symbol, data->orig.fn))
> > -		update_symbol_cache(data->orig.data);
> > -}
> > -
> > -static void
> > -free_bitfield_fetch_param(struct bitfield_fetch_param *data)
> > -{
> > -	/*
> > -	 * Don't check the bitfield itself, because this must be the
> > -	 * last fetch function.
> > -	 */
> > -	if (CHECK_FETCH_FUNCS(deref, data->orig.fn))
> > -		free_deref_fetch_param(data->orig.data);
> > -	else if (CHECK_FETCH_FUNCS(symbol, data->orig.fn))
> > -		free_symbol_cache(data->orig.data);
> > -
> > -	kfree(data);
> > -}
> > -
> > -void FETCH_FUNC_NAME(comm, string)(struct pt_regs *regs,
> > -					  void *data, void *dest)
> > -{
> > -	int maxlen = get_rloc_len(*(u32 *)dest);
> > -	u8 *dst = get_rloc_data(dest);
> > -	long ret;
> > -
> > -	if (!maxlen)
> > -		return;
> > -
> > -	ret = strlcpy(dst, current->comm, maxlen);
> > -	*(u32 *)dest = make_data_rloc(ret, get_rloc_offs(*(u32 *)dest));
> > -}
> > -NOKPROBE_SYMBOL(FETCH_FUNC_NAME(comm, string));
> > -
> > -void FETCH_FUNC_NAME(comm, string_size)(struct pt_regs *regs,
> > -					       void *data, void *dest)
> > -{
> > -	*(u32 *)dest = strlen(current->comm) + 1;
> > -}
> > -NOKPROBE_SYMBOL(FETCH_FUNC_NAME(comm, string_size));
> > -
> > -static const struct fetch_type *find_fetch_type(const char *type,
> > -						const struct fetch_type *ftbl)
> > +static const struct fetch_type *find_fetch_type(const char *type)
> >  {
> >  	int i;
> >  
> > @@ -263,58 +116,27 @@ static const struct fetch_type *find_fetch_type(const char *type,
> >  
> >  		switch (bs) {
> >  		case 8:
> > -			return find_fetch_type("u8", ftbl);
> > +			return find_fetch_type("u8");
> >  		case 16:
> > -			return find_fetch_type("u16", ftbl);
> > +			return find_fetch_type("u16");
> >  		case 32:
> > -			return find_fetch_type("u32", ftbl);
> > +			return find_fetch_type("u32");
> >  		case 64:
> > -			return find_fetch_type("u64", ftbl);
> > +			return find_fetch_type("u64");
> >  		default:
> >  			goto fail;
> >  		}
> >  	}
> >  
> > -	for (i = 0; ftbl[i].name; i++) {
> > -		if (strcmp(type, ftbl[i].name) == 0)
> > -			return &ftbl[i];
> > +	for (i = 0; probe_fetch_types[i].name; i++) {
> > +		if (strcmp(type, probe_fetch_types[i].name) == 0)
> > +			return &probe_fetch_types[i];
> >  	}
> >  
> >  fail:
> >  	return NULL;
> >  }
> >  
> > -/* Special function : only accept unsigned long */
> > -static void fetch_kernel_stack_address(struct pt_regs *regs, void *dummy, void *dest)
> > -{
> > -	*(unsigned long *)dest = kernel_stack_pointer(regs);
> > -}
> > -NOKPROBE_SYMBOL(fetch_kernel_stack_address);
> > -
> > -static void fetch_user_stack_address(struct pt_regs *regs, void *dummy, void *dest)
> > -{
> > -	*(unsigned long *)dest = user_stack_pointer(regs);
> > -}
> > -NOKPROBE_SYMBOL(fetch_user_stack_address);
> > -
> > -static fetch_func_t get_fetch_size_function(const struct fetch_type *type,
> > -					    fetch_func_t orig_fn,
> > -					    const struct fetch_type *ftbl)
> > -{
> > -	int i;
> > -
> > -	if (type != &ftbl[FETCH_TYPE_STRING])
> > -		return NULL;	/* Only string type needs size function */
> > -
> > -	for (i = 0; i < FETCH_MTD_END; i++)
> > -		if (type->fetch[i] == orig_fn)
> > -			return ftbl[FETCH_TYPE_STRSIZE].fetch[i];
> > -
> > -	WARN_ON(1);	/* This should not happen */
> > -
> > -	return NULL;
> > -}
> > -
> >  /* Split symbol and offset. */
> >  int traceprobe_split_symbol_offset(char *symbol, long *offset)
> >  {
> > @@ -341,7 +163,7 @@ int traceprobe_split_symbol_offset(char *symbol, long *offset)
> >  #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
> >  
> >  static int parse_probe_vars(char *arg, const struct fetch_type *t,
> > -			    struct fetch_param *f, bool is_return,
> > +			    struct fetch_insn *code, bool is_return,
> >  			    bool is_kprobe)
> >  {
> >  	int ret = 0;
> > @@ -349,33 +171,24 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
> >  
> >  	if (strcmp(arg, "retval") == 0) {
> >  		if (is_return)
> > -			f->fn = t->fetch[FETCH_MTD_retval];
> > +			code->op = FETCH_OP_RETVAL;
> >  		else
> >  			ret = -EINVAL;
> >  	} else if (strncmp(arg, "stack", 5) == 0) {
> >  		if (arg[5] == '\0') {
> > -			if (strcmp(t->name, DEFAULT_FETCH_TYPE_STR))
> > -				return -EINVAL;
> > -
> > -			if (is_kprobe)
> > -				f->fn = fetch_kernel_stack_address;
> > -			else
> > -				f->fn = fetch_user_stack_address;
> > +			code->op = FETCH_OP_STACKP;
> >  		} else if (isdigit(arg[5])) {
> >  			ret = kstrtoul(arg + 5, 10, &param);
> >  			if (ret || (is_kprobe && param > PARAM_MAX_STACK))
> >  				ret = -EINVAL;
> >  			else {
> > -				f->fn = t->fetch[FETCH_MTD_stack];
> > -				f->data = (void *)param;
> > +				code->op = FETCH_OP_STACK;
> > +				code->param = (unsigned int)param;
> >  			}
> >  		} else
> >  			ret = -EINVAL;
> >  	} else if (strcmp(arg, "comm") == 0) {
> > -		if (strcmp(t->name, "string") != 0 &&
> > -		    strcmp(t->name, "string_size") != 0)
> > -			return -EINVAL;
> > -		f->fn = t->fetch[FETCH_MTD_comm];
> > +		code->op = FETCH_OP_COMM;
> >  	} else
> >  		ret = -EINVAL;
> >  
> > @@ -383,10 +196,12 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
> >  }
> >  
> >  /* Recursive argument parser */
> > -static int parse_probe_arg(char *arg, const struct fetch_type *t,
> > -		     struct fetch_param *f, bool is_return, bool is_kprobe,
> > -		     const struct fetch_type *ftbl)
> > +static int
> > +parse_probe_arg(char *arg, const struct fetch_type *type,
> > +		struct fetch_insn **pcode, struct fetch_insn *end,
> > +		bool is_return, bool is_kprobe)
> >  {
> > +	struct fetch_insn *code = *pcode;
> >  	unsigned long param;
> >  	long offset;
> >  	char *tmp;
> > @@ -394,14 +209,15 @@ static int parse_probe_arg(char *arg, const struct fetch_type *t,
> >  
> >  	switch (arg[0]) {
> >  	case '$':
> > -		ret = parse_probe_vars(arg + 1, t, f, is_return, is_kprobe);
> > +		ret = parse_probe_vars(arg + 1, type, code,
> > +					is_return, is_kprobe);
> >  		break;
> >  
> >  	case '%':	/* named register */
> >  		ret = regs_query_register_offset(arg + 1);
> >  		if (ret >= 0) {
> > -			f->fn = t->fetch[FETCH_MTD_reg];
> > -			f->data = (void *)(unsigned long)ret;
> > +			code->op = FETCH_OP_REG;
> > +			code->param = (unsigned int)ret;
> >  			ret = 0;
> >  		}
> >  		break;
> > @@ -411,9 +227,9 @@ static int parse_probe_arg(char *arg, const struct fetch_type *t,
> >  			ret = kstrtoul(arg + 1, 0, &param);
> >  			if (ret)
> >  				break;
> > -
> > -			f->fn = t->fetch[FETCH_MTD_memory];
> > -			f->data = (void *)param;
> > +			/* load address */
> > +			code->op = FETCH_OP_IMM;
> > +			code->immediate = param;
> >  		} else if (arg[1] == '+') {
> >  			/* kprobes don't support file offsets */
> >  			if (is_kprobe)
> > @@ -423,8 +239,8 @@ static int parse_probe_arg(char *arg, const struct fetch_type *t,
> >  			if (ret)
> >  				break;
> >  
> > -			f->fn = t->fetch[FETCH_MTD_file_offset];
> > -			f->data = (void *)offset;
> > +			code->op = FETCH_OP_FOFFS;
> > +			code->immediate = (unsigned long)offset;  // imm64?
> >  		} else {
> >  			/* uprobes don't support symbols */
> >  			if (!is_kprobe)
> > @@ -434,10 +250,19 @@ static int parse_probe_arg(char *arg, const struct fetch_type *t,
> >  			if (ret)
> >  				break;
> >  
> > -			f->data = alloc_symbol_cache(arg + 1, offset);
> > -			if (f->data)
> > -				f->fn = t->fetch[FETCH_MTD_symbol];
> > +			code->op = FETCH_OP_IMM;
> > +			code->immediate =
> > +				(unsigned long)kallsyms_lookup_name(arg + 1);
> > +			if (!code->immediate)
> > +				return -ENOENT;
> > +			code->immediate += offset;
> >  		}
> > +		/* These are fetching from memory */
> > +		if (++code == end)
> > +			return -E2BIG;
> > +		*pcode = code;
> > +		code->op = FETCH_OP_DEREF;
> > +		code->offset = offset;
> >  		break;
> >  
> >  	case '+':	/* deref memory */
> > @@ -445,11 +270,10 @@ static int parse_probe_arg(char *arg, const struct fetch_type *t,
> >  	case '-':
> >  		tmp = strchr(arg, '(');
> >  		if (!tmp)
> > -			break;
> > +			return -EINVAL;
> >  
> >  		*tmp = '\0';
> >  		ret = kstrtol(arg, 0, &offset);
> > -
> >  		if (ret)
> >  			break;
> >  
> > @@ -457,36 +281,28 @@ static int parse_probe_arg(char *arg, const struct fetch_type *t,
> >  		tmp = strrchr(arg, ')');
> >  
> >  		if (tmp) {
> > -			struct deref_fetch_param	*dprm;
> > -			const struct fetch_type		*t2;
> > +			const struct fetch_type *t2 = find_fetch_type(NULL);
> >  
> > -			t2 = find_fetch_type(NULL, ftbl);
> >  			*tmp = '\0';
> > -			dprm = kzalloc(sizeof(struct deref_fetch_param), GFP_KERNEL);
> > -
> > -			if (!dprm)
> > -				return -ENOMEM;
> > -
> > -			dprm->offset = offset;
> > -			dprm->fetch = t->fetch[FETCH_MTD_memory];
> > -			dprm->fetch_size = get_fetch_size_function(t,
> > -							dprm->fetch, ftbl);
> > -			ret = parse_probe_arg(arg, t2, &dprm->orig, is_return,
> > -							is_kprobe, ftbl);
> > +			ret = parse_probe_arg(arg, t2, &code, end, is_return,
> > +					      is_kprobe);
> >  			if (ret)
> > -				kfree(dprm);
> > -			else {
> > -				f->fn = t->fetch[FETCH_MTD_deref];
> > -				f->data = (void *)dprm;
> > -			}
> > +				break;
> > +			if (code->op == FETCH_OP_COMM)
> > +				return -EINVAL;
> > +			if (++code == end)
> > +				return -E2BIG;
> > +			*pcode = code;
> > +
> > +			code->op = FETCH_OP_DEREF;
> > +			code->offset = offset;
> >  		}
> >  		break;
> >  	}
> > -	if (!ret && !f->fn) {	/* Parsed, but do not find fetch method */
> > -		pr_info("%s type has no corresponding fetch method.\n", t->name);
> > +	if (!ret && code->op == FETCH_OP_NOP) {
> > +		/* Parsed, but do not find fetch method */
> >  		ret = -EINVAL;
> >  	}
> > -
> >  	return ret;
> >  }
> >  
> > @@ -495,22 +311,15 @@ static int parse_probe_arg(char *arg, const struct fetch_type *t,
> >  /* Bitfield type needs to be parsed into a fetch function */
> >  static int __parse_bitfield_probe_arg(const char *bf,
> >  				      const struct fetch_type *t,
> > -				      struct fetch_param *f)
> > +				      struct fetch_insn **pcode)
> >  {
> > -	struct bitfield_fetch_param *bprm;
> > +	struct fetch_insn *code = *pcode;
> >  	unsigned long bw, bo;
> >  	char *tail;
> >  
> >  	if (*bf != 'b')
> >  		return 0;
> >  
> > -	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
> > -	if (!bprm)
> > -		return -ENOMEM;
> > -
> > -	bprm->orig = *f;
> > -	f->fn = t->fetch[FETCH_MTD_bitfield];
> > -	f->data = (void *)bprm;
> >  	bw = simple_strtoul(bf + 1, &tail, 0);	/* Use simple one */
> >  
> >  	if (bw == 0 || *tail != '@')
> > @@ -521,18 +330,24 @@ static int __parse_bitfield_probe_arg(const char *bf,
> >  
> >  	if (tail == bf || *tail != '/')
> >  		return -EINVAL;
> > +	code++;
> > +	if (code->op != FETCH_OP_NOP)
> > +		return -E2BIG;
> > +	*pcode = code;
> >  
> > -	bprm->hi_shift = BYTES_TO_BITS(t->size) - (bw + bo);
> > -	bprm->low_shift = bprm->hi_shift + bo;
> > +	code->op = FETCH_OP_MOD_BF;
> > +	code->lshift = BYTES_TO_BITS(t->size) - (bw + bo);
> > +	code->rshift = BYTES_TO_BITS(t->size) - bw;
> > +	code->basesize = t->size;
> >  
> >  	return (BYTES_TO_BITS(t->size) < (bw + bo)) ? -EINVAL : 0;
> >  }
> >  
> >  /* String length checking wrapper */
> >  int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
> > -		struct probe_arg *parg, bool is_return, bool is_kprobe,
> > -		const struct fetch_type *ftbl)
> > +		struct probe_arg *parg, bool is_return, bool is_kprobe)
> >  {
> > +	struct fetch_insn *code, *tmp = NULL;
> >  	const char *t;
> >  	int ret;
> >  
> > @@ -556,25 +371,67 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
> >  	 */
> >  	if (!t && strcmp(arg, "$comm") == 0)
> >  		t = "string";
> > -	parg->type = find_fetch_type(t, ftbl);
> > +	parg->type = find_fetch_type(t);
> >  	if (!parg->type) {
> >  		pr_info("Unsupported type: %s\n", t);
> >  		return -EINVAL;
> >  	}
> >  	parg->offset = *size;
> >  	*size += parg->type->size;
> > -	ret = parse_probe_arg(arg, parg->type, &parg->fetch, is_return,
> > -			      is_kprobe, ftbl);
> > -
> > -	if (ret >= 0 && t != NULL)
> > -		ret = __parse_bitfield_probe_arg(t, parg->type, &parg->fetch);
> >  
> > -	if (ret >= 0) {
> > -		parg->fetch_size.fn = get_fetch_size_function(parg->type,
> > -							      parg->fetch.fn,
> > -							      ftbl);
> > -		parg->fetch_size.data = parg->fetch.data;
> > +	code = tmp = kzalloc(sizeof(*code) * FETCH_INSN_MAX, GFP_KERNEL);
> > +	if (!code)
> > +		return -ENOMEM;
> > +	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
> > +
> > +	ret = parse_probe_arg(arg, parg->type, &code, &code[FETCH_INSN_MAX - 1],
> > +			      is_return, is_kprobe);
> > +	if (ret)
> > +		goto fail;
> > +
> > +	/* Store operation */
> > +	if (!strcmp(parg->type->name, "string")) {
> > +		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_IMM &&
> > +		    code->op != FETCH_OP_COMM) {
> > +			pr_info("string only accepts memory or address.\n");
> > +			ret = -EINVAL;
> > +			goto fail;
> > +		}
> > +		/* Since IMM or COMM must be the 1st insn, this is safe */
> > +		if (code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM)
> > +			code++;
> > +		code->op = FETCH_OP_ST_STRING;	/* In DEREF case, replace it */
> > +		parg->dynamic = true;
> > +	} else if (code->op == FETCH_OP_DEREF) {
> > +		code->op = FETCH_OP_ST_MEM;
> > +		code->size = parg->type->size;
> > +	} else {
> > +		code++;
> > +		if (code->op != FETCH_OP_NOP) {
> > +			ret = -E2BIG;
> > +			goto fail;
> > +		}
> > +		code->op = FETCH_OP_ST_RAW;
> > +		code->size = parg->type->size;
> >  	}
> > +	/* Modify operation */
> > +	if (t != NULL) {
> > +		ret = __parse_bitfield_probe_arg(t, parg->type, &code);
> > +		if (ret)
> > +			goto fail;
> > +	}
> > +	code++;
> > +	code->op = FETCH_OP_END;
> > +
> > +	/* Shrink down the code buffer */
> > +	parg->code = kzalloc(sizeof(*code) * (code - tmp + 1), GFP_KERNEL);
> > +	if (!parg->code)
> > +		ret = -ENOMEM;
> > +	else
> > +		memcpy(parg->code, tmp, sizeof(*code) * (code - tmp + 1));
> > +
> > +fail:
> > +	kfree(tmp);
> >  
> >  	return ret;
> >  }
> > @@ -596,25 +453,9 @@ int traceprobe_conflict_field_name(const char *name,
> >  	return 0;
> >  }
> >  
> > -void traceprobe_update_arg(struct probe_arg *arg)
> > -{
> > -	if (CHECK_FETCH_FUNCS(bitfield, arg->fetch.fn))
> > -		update_bitfield_fetch_param(arg->fetch.data);
> > -	else if (CHECK_FETCH_FUNCS(deref, arg->fetch.fn))
> > -		update_deref_fetch_param(arg->fetch.data);
> > -	else if (CHECK_FETCH_FUNCS(symbol, arg->fetch.fn))
> > -		update_symbol_cache(arg->fetch.data);
> > -}
> > -
> >  void traceprobe_free_probe_arg(struct probe_arg *arg)
> >  {
> > -	if (CHECK_FETCH_FUNCS(bitfield, arg->fetch.fn))
> > -		free_bitfield_fetch_param(arg->fetch.data);
> > -	else if (CHECK_FETCH_FUNCS(deref, arg->fetch.fn))
> > -		free_deref_fetch_param(arg->fetch.data);
> > -	else if (CHECK_FETCH_FUNCS(symbol, arg->fetch.fn))
> > -		free_symbol_cache(arg->fetch.data);
> > -
> > +	kfree(arg->code);
> >  	kfree(arg->name);
> >  	kfree(arg->comm);
> >  }
> > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > index de928052926b..89d853ef5174 100644
> > --- a/kernel/trace/trace_probe.h
> > +++ b/kernel/trace/trace_probe.h
> > @@ -91,25 +91,50 @@ static nokprobe_inline void *get_loc_data(u32 *dl, void *ent)
> >  	return (u8 *)ent + get_rloc_offs(*dl);
> >  }
> >  
> > -/* Data fetch function type */
> > -typedef	void (*fetch_func_t)(struct pt_regs *, void *, void *);
> >  /* Printing function type */
> >  typedef int (*print_type_func_t)(struct trace_seq *, void *, void *);
> >  
> > -/* Fetch types */
> > -enum {
> > -	FETCH_MTD_reg = 0,
> > -	FETCH_MTD_stack,
> > -	FETCH_MTD_retval,
> > -	FETCH_MTD_comm,
> > -	FETCH_MTD_memory,
> > -	FETCH_MTD_symbol,
> > -	FETCH_MTD_deref,
> > -	FETCH_MTD_bitfield,
> > -	FETCH_MTD_file_offset,
> > -	FETCH_MTD_END,
> > +enum fetch_op {
> > +	FETCH_OP_NOP = 0,
> > +	// Stage 1 (load) ops
> > +	FETCH_OP_REG,		/* Register : .param = offset */
> > +	FETCH_OP_STACK,		/* Stack : .param = index */
> > +	FETCH_OP_STACKP,	/* Stack pointer */
> > +	FETCH_OP_RETVAL,	/* Return value */
> > +	FETCH_OP_IMM,		/* Immediate : .immediate */
> > +	FETCH_OP_COMM,		/* Current comm */
> > +	FETCH_OP_FOFFS,		/* File offset: .immediate */
> > +	// Stage 2 (dereference) op
> > +	FETCH_OP_DEREF,		/* Dereference: .offset */
> > +	// Stage 3 (store) ops
> > +	FETCH_OP_ST_RAW,	/* Raw: .size */
> > +	FETCH_OP_ST_MEM,	/* Mem: .offset, .size */
> > +	FETCH_OP_ST_STRING,	/* String: .offset, .size */
> > +	// Stage 4 (modify) op
> > +	FETCH_OP_MOD_BF,	/* Bitfield: .basesize, .lshift, .rshift */
> > +	FETCH_OP_END,
> >  };
> >  
> > +struct fetch_insn {
> > +	enum fetch_op op;
> > +	union {
> > +		unsigned int param;
> > +		struct {
> > +			unsigned int size;
> > +			int offset;
> > +		};
> > +		struct {
> > +			unsigned char basesize;
> > +			unsigned char lshift;
> > +			unsigned char rshift;
> > +		};
> > +		unsigned long immediate;
> > +	};
> > +};
> > +
> > +/* fetch + deref*N + store + mod + end <= 16, this allows N=12, enough */
> > +#define FETCH_INSN_MAX	16
> > +
> >  /* Fetch type information table */
> >  struct fetch_type {
> >  	const char		*name;		/* Name of type */
> > @@ -118,13 +143,6 @@ struct fetch_type {
> >  	print_type_func_t	print;		/* Print functions */
> >  	const char		*fmt;		/* Fromat string */
> >  	const char		*fmttype;	/* Name in format file */
> > -	/* Fetch functions */
> > -	fetch_func_t		fetch[FETCH_MTD_END];
> > -};
> > -
> > -struct fetch_param {
> > -	fetch_func_t		fn;
> > -	void 			*data;
> >  };
> >  
> >  /* For defining macros, define string/string_size types */
> > @@ -154,66 +172,12 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(x64);
> >  
> >  DECLARE_BASIC_PRINT_TYPE_FUNC(string);
> >  
> > -#define FETCH_FUNC_NAME(method, type)	fetch_##method##_##type
> > -
> > -/* Declare macro for basic types */
> > -#define DECLARE_FETCH_FUNC(method, type)				\
> > -extern void FETCH_FUNC_NAME(method, type)(struct pt_regs *regs, 	\
> > -					  void *data, void *dest)
> > -
> > -#define DECLARE_BASIC_FETCH_FUNCS(method) 	\
> > -DECLARE_FETCH_FUNC(method, u8);			\
> > -DECLARE_FETCH_FUNC(method, u16);		\
> > -DECLARE_FETCH_FUNC(method, u32);		\
> > -DECLARE_FETCH_FUNC(method, u64)
> > -
> > -DECLARE_BASIC_FETCH_FUNCS(reg);
> > -#define fetch_reg_string			NULL
> > -#define fetch_reg_string_size			NULL
> > -
> > -DECLARE_BASIC_FETCH_FUNCS(retval);
> > -#define fetch_retval_string			NULL
> > -#define fetch_retval_string_size		NULL
> > -
> > -DECLARE_BASIC_FETCH_FUNCS(symbol);
> > -DECLARE_FETCH_FUNC(symbol, string);
> > -DECLARE_FETCH_FUNC(symbol, string_size);
> > -
> > -DECLARE_BASIC_FETCH_FUNCS(deref);
> > -DECLARE_FETCH_FUNC(deref, string);
> > -DECLARE_FETCH_FUNC(deref, string_size);
> > -
> > -DECLARE_BASIC_FETCH_FUNCS(bitfield);
> > -#define fetch_bitfield_string			NULL
> > -#define fetch_bitfield_string_size		NULL
> > -
> > -/* comm only makes sense as a string */
> > -#define fetch_comm_u8		NULL
> > -#define fetch_comm_u16		NULL
> > -#define fetch_comm_u32		NULL
> > -#define fetch_comm_u64		NULL
> > -DECLARE_FETCH_FUNC(comm, string);
> > -DECLARE_FETCH_FUNC(comm, string_size);
> > -
> > -/*
> > - * Define macro for basic types - we don't need to define s* types, because
> > - * we have to care only about bitwidth at recording time.
> > - */
> > -#define DEFINE_BASIC_FETCH_FUNCS(method) \
> > -DEFINE_FETCH_##method(u8)		\
> > -DEFINE_FETCH_##method(u16)		\
> > -DEFINE_FETCH_##method(u32)		\
> > -DEFINE_FETCH_##method(u64)
> > -
> >  /* Default (unsigned long) fetch type */
> >  #define __DEFAULT_FETCH_TYPE(t) x##t
> >  #define _DEFAULT_FETCH_TYPE(t) __DEFAULT_FETCH_TYPE(t)
> >  #define DEFAULT_FETCH_TYPE _DEFAULT_FETCH_TYPE(BITS_PER_LONG)
> >  #define DEFAULT_FETCH_TYPE_STR __stringify(DEFAULT_FETCH_TYPE)
> >  
> > -#define ASSIGN_FETCH_FUNC(method, type)	\
> > -	[FETCH_MTD_##method] = FETCH_FUNC_NAME(method, type)
> > -
> >  #define __ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, _fmttype)	\
> >  	{.name = _name,				\
> >  	 .size = _size,					\
> > @@ -221,17 +185,6 @@ DEFINE_FETCH_##method(u64)
> >  	 .print = PRINT_TYPE_FUNC_NAME(ptype),		\
> >  	 .fmt = PRINT_TYPE_FMT_NAME(ptype),		\
> >  	 .fmttype = _fmttype,				\
> > -	 .fetch = {					\
> > -ASSIGN_FETCH_FUNC(reg, ftype),				\
> > -ASSIGN_FETCH_FUNC(stack, ftype),			\
> > -ASSIGN_FETCH_FUNC(retval, ftype),			\
> > -ASSIGN_FETCH_FUNC(comm, ftype),				\
> > -ASSIGN_FETCH_FUNC(memory, ftype),			\
> > -ASSIGN_FETCH_FUNC(symbol, ftype),			\
> > -ASSIGN_FETCH_FUNC(deref, ftype),			\
> > -ASSIGN_FETCH_FUNC(bitfield, ftype),			\
> > -ASSIGN_FETCH_FUNC(file_offset, ftype),			\
> > -	  }						\
> >  	}
> >  
> >  #define ASSIGN_FETCH_TYPE(ptype, ftype, sign)			\
> > @@ -243,42 +196,10 @@ ASSIGN_FETCH_FUNC(file_offset, ftype),			\
> >  
> >  #define ASSIGN_FETCH_TYPE_END {}
> >  
> > -#define FETCH_TYPE_STRING	0
> > -#define FETCH_TYPE_STRSIZE	1
> > -
> >  #ifdef CONFIG_KPROBE_EVENTS
> > -struct symbol_cache;
> > -unsigned long update_symbol_cache(struct symbol_cache *sc);
> > -void free_symbol_cache(struct symbol_cache *sc);
> > -struct symbol_cache *alloc_symbol_cache(const char *sym, long offset);
> >  bool trace_kprobe_on_func_entry(struct trace_event_call *call);
> >  bool trace_kprobe_error_injectable(struct trace_event_call *call);
> >  #else
> > -/* uprobes do not support symbol fetch methods */
> > -#define fetch_symbol_u8			NULL
> > -#define fetch_symbol_u16		NULL
> > -#define fetch_symbol_u32		NULL
> > -#define fetch_symbol_u64		NULL
> > -#define fetch_symbol_string		NULL
> > -#define fetch_symbol_string_size	NULL
> > -
> > -struct symbol_cache {
> > -};
> > -static inline unsigned long __used update_symbol_cache(struct symbol_cache *sc)
> > -{
> > -	return 0;
> > -}
> > -
> > -static inline void __used free_symbol_cache(struct symbol_cache *sc)
> > -{
> > -}
> > -
> > -static inline struct symbol_cache * __used
> > -alloc_symbol_cache(const char *sym, long offset)
> > -{
> > -	return NULL;
> > -}
> > -
> >  static inline bool trace_kprobe_on_func_entry(struct trace_event_call *call)
> >  {
> >  	return false;
> > @@ -291,8 +212,8 @@ static inline bool trace_kprobe_error_injectable(struct trace_event_call *call)
> >  #endif /* CONFIG_KPROBE_EVENTS */
> >  
> >  struct probe_arg {
> > -	struct fetch_param	fetch;
> > -	struct fetch_param	fetch_size;
> > +	struct fetch_insn	*code;
> > +	bool			dynamic;/* Dynamic array (string) is used */
> >  	unsigned int		offset;	/* Offset from argument entry */
> >  	const char		*name;	/* Name of this argument */
> >  	const char		*comm;	/* Command of this argument */
> > @@ -324,12 +245,6 @@ static inline bool trace_probe_is_registered(struct trace_probe *tp)
> >  	return !!(tp->flags & TP_FLAG_REGISTERED);
> >  }
> >  
> > -static nokprobe_inline void call_fetch(struct fetch_param *fprm,
> > -				 struct pt_regs *regs, void *dest)
> > -{
> > -	return fprm->fn(regs, fprm->data, dest);
> > -}
> > -
> >  /* Check the name is good for event/group/fields */
> >  static inline bool is_good_name(const char *name)
> >  {
> > @@ -355,8 +270,7 @@ find_event_file_link(struct trace_probe *tp, struct trace_event_file *file)
> >  }
> >  
> >  extern int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
> > -		   struct probe_arg *parg, bool is_return, bool is_kprobe,
> > -		   const struct fetch_type *ftbl);
> > +		   struct probe_arg *parg, bool is_return, bool is_kprobe);
> >  
> >  extern int traceprobe_conflict_field_name(const char *name,
> >  			       struct probe_arg *args, int narg);
> > @@ -366,68 +280,6 @@ extern void traceprobe_free_probe_arg(struct probe_arg *arg);
> >  
> >  extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
> >  
> > -/* Sum up total data length for dynamic arraies (strings) */
> > -static nokprobe_inline int
> > -__get_data_size(struct trace_probe *tp, struct pt_regs *regs)
> > -{
> > -	int i, ret = 0;
> > -	u32 len;
> > -
> > -	for (i = 0; i < tp->nr_args; i++)
> > -		if (unlikely(tp->args[i].fetch_size.fn)) {
> > -			call_fetch(&tp->args[i].fetch_size, regs, &len);
> > -			ret += len;
> > -		}
> > -
> > -	return ret;
> > -}
> > -
> > -/* Store the value of each argument */
> > -static nokprobe_inline void
> > -store_trace_args(int ent_size, struct trace_probe *tp, struct pt_regs *regs,
> > -		 u8 *data, int maxlen)
> > -{
> > -	int i;
> > -	u32 end = tp->size;
> > -	u32 *dl;	/* Data (relative) location */
> > -
> > -	for (i = 0; i < tp->nr_args; i++) {
> > -		if (unlikely(tp->args[i].fetch_size.fn)) {
> > -			/*
> > -			 * First, we set the relative location and
> > -			 * maximum data length to *dl
> > -			 */
> > -			dl = (u32 *)(data + tp->args[i].offset);
> > -			*dl = make_data_rloc(maxlen, end - tp->args[i].offset);
> > -			/* Then try to fetch string or dynamic array data */
> > -			call_fetch(&tp->args[i].fetch, regs, dl);
> > -			/* Reduce maximum length */
> > -			end += get_rloc_len(*dl);
> > -			maxlen -= get_rloc_len(*dl);
> > -			/* Trick here, convert data_rloc to data_loc */
> > -			*dl = convert_rloc_to_loc(*dl,
> > -				 ent_size + tp->args[i].offset);
> > -		} else
> > -			/* Just fetching data normally */
> > -			call_fetch(&tp->args[i].fetch, regs,
> > -				   data + tp->args[i].offset);
> > -	}
> > -}
> > -
> > -static inline int
> > -print_probe_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
> > -		 u8 *data, void *field)
> > -{
> > -	int i;
> > -
> > -	for (i = 0; i < nr_args; i++) {
> > -		trace_seq_printf(s, " %s=", args[i].name);
> > -		if (!args[i].type->print(s, data + args[i].offset, field))
> > -			return -ENOMEM;
> > -	}
> > -	return 0;
> > -}
> > -
> >  extern int set_print_fmt(struct trace_probe *tp, bool is_return);
> >  
> >  #ifdef CONFIG_PERF_EVENTS
> > diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> > new file mode 100644
> > index 000000000000..c8a5272abf01
> > --- /dev/null
> > +++ b/kernel/trace/trace_probe_tmpl.h
> > @@ -0,0 +1,120 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Traceprobe fetch helper inlines
> > + */
> > +
> > +static nokprobe_inline void
> > +fetch_store_raw(unsigned long val, struct fetch_insn *code, void *buf)
> > +{
> > +	switch (code->size) {
> > +	case 1:
> > +		*(u8 *)buf = (u8)val;
> > +		break;
> > +	case 2:
> > +		*(u16 *)buf = (u16)val;
> > +		break;
> > +	case 4:
> > +		*(u32 *)buf = (u32)val;
> > +		break;
> > +	case 8:
> > +		//TBD: 32bit signed
> > +		*(u64 *)buf = (u64)val;
> > +		break;
> > +	default:
> > +		*(unsigned long *)buf = val;
> > +	}
> > +}
> > +
> > +static nokprobe_inline void
> > +fetch_apply_bitfield(struct fetch_insn *code, void *buf)
> > +{
> > +	switch (code->basesize) {
> > +	case 1:
> > +		*(u8 *)buf <<= code->lshift;
> > +		*(u8 *)buf >>= code->rshift;
> > +		break;
> > +	case 2:
> > +		*(u16 *)buf <<= code->lshift;
> > +		*(u16 *)buf >>= code->rshift;
> > +		break;
> > +	case 4:
> > +		*(u32 *)buf <<= code->lshift;
> > +		*(u32 *)buf >>= code->rshift;
> > +		break;
> > +	case 8:
> > +		*(u64 *)buf <<= code->lshift;
> > +		*(u64 *)buf >>= code->rshift;
> > +		break;
> > +	}
> > +}
> > +
> > +/* Define this for each callsite */
> > +static int
> > +process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs,
> > +		   void *dest, bool pre);
> > +
> > +/* Sum up total data length for dynamic arraies (strings) */
> > +static nokprobe_inline int
> > +__get_data_size(struct trace_probe *tp, struct pt_regs *regs)
> > +{
> > +	struct probe_arg *arg;
> > +	int i, ret = 0;
> > +	u32 len;
> > +
> > +	for (i = 0; i < tp->nr_args; i++) {
> > +		arg = tp->args + i;
> > +		if (unlikely(arg->dynamic)) {
> > +			process_fetch_insn(arg->code, regs, &len, true);
> > +			ret += len;
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +/* Store the value of each argument */
> > +static nokprobe_inline void
> > +store_trace_args(int ent_size, struct trace_probe *tp, struct pt_regs *regs,
> > +		 u8 *data, int maxlen)
> > +{
> > +	struct probe_arg *arg;
> > +	u32 end = tp->size;
> > +	u32 *dl;	/* Data (relative) location */
> > +	int i;
> > +
> > +	for (i = 0; i < tp->nr_args; i++) {
> > +		arg = tp->args + i;
> > +		if (unlikely(arg->dynamic)) {
> > +			/*
> > +			 * First, we set the relative location and
> > +			 * maximum data length to *dl
> > +			 */
> > +			dl = (u32 *)(data + arg->offset);
> > +			*dl = make_data_rloc(maxlen, end - arg->offset);
> > +			/* Then try to fetch string or dynamic array data */
> > +			process_fetch_insn(arg->code, regs, dl, false);
> > +			/* Reduce maximum length */
> > +			end += get_rloc_len(*dl);
> > +			maxlen -= get_rloc_len(*dl);
> > +			/* Trick here, convert data_rloc to data_loc */
> > +			*dl = convert_rloc_to_loc(*dl, ent_size + arg->offset);
> > +		} else
> > +			/* Just fetching data normally */
> > +			process_fetch_insn(arg->code, regs, data + arg->offset,
> > +					   false);
> > +	}
> > +}
> > +
> > +static inline int
> > +print_probe_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
> > +		 u8 *data, void *field)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < nr_args; i++) {
> > +		trace_seq_printf(s, " %s=", args[i].name);
> > +		if (!args[i].type->print(s, data + args[i].offset, field))
> > +			return -ENOMEM;
> > +	}
> > +	return 0;
> > +}
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index 887da2bb63aa..9fc0123c721f 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/rculist.h>
> >  
> >  #include "trace_probe.h"
> > +#include "trace_probe_tmpl.h"
> >  
> >  #define UPROBE_EVENT_SYSTEM	"uprobes"
> >  
> > @@ -109,37 +110,19 @@ static unsigned long get_user_stack_nth(struct pt_regs *regs, unsigned int n)
> >  /*
> >   * Uprobes-specific fetch functions
> >   */
> > -#define DEFINE_FETCH_stack(type)					\
> > -static void FETCH_FUNC_NAME(stack, type)(struct pt_regs *regs,		\
> > -					 void *offset, void *dest)	\
> > -{									\
> > -	*(type *)dest = (type)get_user_stack_nth(regs,			\
> > -					      ((unsigned long)offset)); \
> > -}
> > -DEFINE_BASIC_FETCH_FUNCS(stack)
> > -/* No string on the stack entry */
> > -#define fetch_stack_string	NULL
> > -#define fetch_stack_string_size	NULL
> > -
> > -#define DEFINE_FETCH_memory(type)					\
> > -static void FETCH_FUNC_NAME(memory, type)(struct pt_regs *regs,		\
> > -					  void *addr, void *dest)	\
> > -{									\
> > -	type retval;							\
> > -	void __user *vaddr = (void __force __user *) addr;		\
> > -									\
> > -	if (copy_from_user(&retval, vaddr, sizeof(type)))		\
> > -		*(type *)dest = 0;					\
> > -	else								\
> > -		*(type *) dest = retval;				\
> > +static nokprobe_inline int
> > +probe_user_read(void *dest, void *src, size_t size)
> > +{
> > +	void __user *vaddr = (void __force __user *)src;
> > +
> > +	return copy_from_user(dest, vaddr, size);
> >  }
> > -DEFINE_BASIC_FETCH_FUNCS(memory)
> >  /*
> >   * Fetch a null-terminated string. Caller MUST set *(u32 *)dest with max
> >   * length and relative data location.
> >   */
> > -static void FETCH_FUNC_NAME(memory, string)(struct pt_regs *regs,
> > -					    void *addr, void *dest)
> > +static nokprobe_inline void
> > +fetch_store_string(unsigned long addr, void *dest)
> >  {
> >  	long ret;
> >  	u32 rloc = *(u32 *)dest;
> > @@ -160,8 +143,9 @@ static void FETCH_FUNC_NAME(memory, string)(struct pt_regs *regs,
> >  	}
> >  }
> >  
> > -static void FETCH_FUNC_NAME(memory, string_size)(struct pt_regs *regs,
> > -						 void *addr, void *dest)
> > +/* Return the length of string -- including null terminal byte */
> > +static nokprobe_inline void
> > +fetch_store_strlen(unsigned long addr, void *dest)
> >  {
> >  	int len;
> >  	void __user *vaddr = (void __force __user *) addr;
> > @@ -174,7 +158,7 @@ static void FETCH_FUNC_NAME(memory, string_size)(struct pt_regs *regs,
> >  		*(u32 *)dest = len;
> >  }
> >  
> > -static unsigned long translate_user_vaddr(void *file_offset)
> > +static unsigned long translate_user_vaddr(unsigned long file_offset)
> >  {
> >  	unsigned long base_addr;
> >  	struct uprobe_dispatch_data *udd;
> > @@ -182,44 +166,79 @@ static unsigned long translate_user_vaddr(void *file_offset)
> >  	udd = (void *) current->utask->vaddr;
> >  
> >  	base_addr = udd->bp_addr - udd->tu->offset;
> > -	return base_addr + (unsigned long)file_offset;
> > +	return base_addr + file_offset;
> >  }
> >  
> > -#define DEFINE_FETCH_file_offset(type)					\
> > -static void FETCH_FUNC_NAME(file_offset, type)(struct pt_regs *regs,	\
> > -					       void *offset, void *dest)\
> > -{									\
> > -	void *vaddr = (void *)translate_user_vaddr(offset);		\
> > -									\
> > -	FETCH_FUNC_NAME(memory, type)(regs, vaddr, dest);		\
> > +/* Note that we don't verify it, since the code does not come from user space */
> > +static int
> > +process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
> > +		   bool pre)
> > +{
> > +	unsigned long val;
> > +	int ret;
> > +
> > +	/* 1st stage: get value from context */
> > +	switch (code->op) {
> > +	case FETCH_OP_REG:
> > +		val = regs_get_register(regs, code->param);
> > +		break;
> > +	case FETCH_OP_STACK:
> > +		val = get_user_stack_nth(regs, code->param);
> > +		break;
> > +	case FETCH_OP_STACKP:
> > +		val = user_stack_pointer(regs);
> > +		break;
> > +	case FETCH_OP_RETVAL:
> > +		val = regs_return_value(regs);
> > +		break;
> > +	case FETCH_OP_IMM:
> > +		val = code->immediate;
> > +		break;
> > +	case FETCH_OP_FOFFS:
> > +		val = translate_user_vaddr(code->immediate);
> > +		break;
> > +	default:
> > +		return -EILSEQ;
> > +	}
> > +	code++;
> > +
> > +	/* 2nd stage: dereference memory if needed */
> > +	while (code->op == FETCH_OP_DEREF) {
> > +		ret = probe_user_read(&val, (void *)val + code->offset,
> > +				      sizeof(val));
> > +		if (ret)
> > +			return ret;
> > +		code++;
> > +	}
> > +
> > +	/* 3rd stage: store value to buffer */
> > +	switch (code->op) {
> > +	case FETCH_OP_ST_RAW:
> > +		fetch_store_raw(val, code, dest);
> > +		break;
> > +	case FETCH_OP_ST_MEM:
> > +		probe_user_read(dest, (void *)val + code->offset, code->size);
> > +		break;
> > +	case FETCH_OP_ST_STRING:
> > +		if (pre)
> > +			fetch_store_strlen(val + code->offset, dest);
> > +		else
> > +			fetch_store_string(val + code->offset, dest);
> > +		break;
> > +	default:
> > +		return -EILSEQ;
> > +	}
> > +	code++;
> > +
> > +	/* 4th stage: modify stored value if needed */
> > +	if (code->op == FETCH_OP_MOD_BF) {
> > +		fetch_apply_bitfield(code, dest);
> > +		code++;
> > +	}
> > +
> > +	return code->op == FETCH_OP_END ? 0 : -EILSEQ;
> >  }
> > -DEFINE_BASIC_FETCH_FUNCS(file_offset)
> > -DEFINE_FETCH_file_offset(string)
> > -DEFINE_FETCH_file_offset(string_size)
> > -
> > -/* Fetch type information table */
> > -static const struct fetch_type uprobes_fetch_type_table[] = {
> > -	/* Special types */
> > -	[FETCH_TYPE_STRING] = __ASSIGN_FETCH_TYPE("string", string, string,
> > -					sizeof(u32), 1, "__data_loc char[]"),
> > -	[FETCH_TYPE_STRSIZE] = __ASSIGN_FETCH_TYPE("string_size", u32,
> > -					string_size, sizeof(u32), 0, "u32"),
> > -	/* Basic types */
> > -	ASSIGN_FETCH_TYPE(u8,  u8,  0),
> > -	ASSIGN_FETCH_TYPE(u16, u16, 0),
> > -	ASSIGN_FETCH_TYPE(u32, u32, 0),
> > -	ASSIGN_FETCH_TYPE(u64, u64, 0),
> > -	ASSIGN_FETCH_TYPE(s8,  u8,  1),
> > -	ASSIGN_FETCH_TYPE(s16, u16, 1),
> > -	ASSIGN_FETCH_TYPE(s32, u32, 1),
> > -	ASSIGN_FETCH_TYPE(s64, u64, 1),
> > -	ASSIGN_FETCH_TYPE_ALIAS(x8,  u8,  u8,  0),
> > -	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
> > -	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
> > -	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
> > -
> > -	ASSIGN_FETCH_TYPE_END
> > -};
> > +NOKPROBE_SYMBOL(process_fetch_insn)
> >  
> >  static inline void init_trace_uprobe_filter(struct trace_uprobe_filter *filter)
> >  {
> > @@ -538,8 +557,7 @@ static int create_trace_uprobe(int argc, char **argv)
> >  
> >  		/* Parse fetch argument */
> >  		ret = traceprobe_parse_probe_arg(arg, &tu->tp.size, parg,
> > -						 is_return, false,
> > -						 uprobes_fetch_type_table);
> > +						 is_return, false);
> >  		if (ret) {
> >  			pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
> >  			goto error;
> > 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
