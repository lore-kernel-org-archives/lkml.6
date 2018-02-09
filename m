Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeBIByh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 20:54:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752178AbeBIByg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 20:54:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EB621789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 8 Feb 2018 20:54:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kernel-team@lge.com
Subject: Re: [PATCH 13/18] tracing: Add array type to function based events
Message-ID: <20180208205431.4c0ef9eb@vmware.local.home>
In-Reply-To: <20180209011745.GC28206@sejong>
References: <20180202230458.840252014@goodmis.org>
        <20180202231018.977452228@goodmis.org>
        <20180209011745.GC28206@sejong>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2018 10:17:45 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> > + # echo 1 > events/functions/ip_rcv/enable
> > + # cat trace
> > +    <idle>-0     [003] ..s3   219.813582: __netif_receive_skb_core->ip_rcv(skb=ffff880118195e00, perm_addr=b4,b5,2f,ce,18,65)
> > +    <idle>-0     [003] ..s3   219.813595: __netif_receive_skb_core->ip_rcv(skb=ffff880118195e00, perm_addr=b4,b5,2f,ce,18,65)
> > +    <idle>-0     [003] ..s3   220.115053: __netif_receive_skb_core->ip_rcv(skb=ffff880118195c00, perm_addr=b4,b5,2f,ce,18,65)
> > +    <idle>-0     [003] ..s3   220.115293: __netif_receive_skb_core->ip_rcv(skb=ffff880118195c00, perm_addr=b4,b5,2f,ce,18,65)  
> 
> What about adding braces to indicate array type like below?
> 
> ... ip_rcv(skb=ffff880118195c00, perm_addr={b4,b5,2f,ce,18,65})
> 

That's a nice idea, I'll add it.

> > +	case FUNC_STATE_ARRAY:
> >  	case FUNC_STATE_BRACKET:
> > -		WARN_ON(!fevent->last_arg);
> > +		if (WARN_ON(!fevent->last_arg))
> > +			break;
> >  		ret = kstrtoul(token, 0, &val);
> >  		if (ret)
> >  			break;
> > -		val *= fevent->last_arg->size;
> > -		fevent->last_arg->indirect = val ^ INDIRECT_FLAG;
> > -		return FUNC_STATE_INDIRECT;
> > +		if (state == FUNC_STATE_BRACKET) {
> > +			val *= fevent->last_arg->size;
> > +			fevent->last_arg->indirect = val ^ INDIRECT_FLAG;
> > +			return FUNC_STATE_INDIRECT;
> > +		}
> > +		if (val <= 0)
> > +			break;  
> 
> The val is unsigned long type.

I probably should make it a cap it for the array, as arrays that are
too big will simply fail to allocate on the ring buffer.

But it should only check for zero.

> 
> 
> > +		fevent->last_arg->array = val;
> > +		type = kasprintf(GFP_KERNEL, "%s[%d]", fevent->last_arg->type, (unsigned)val);  
> 
> s/%d/%lu/  and no need to cast it.

Sure.

> 
> 
> > +		if (!type)
> > +			break;
> > +		kfree(fevent->last_arg->type);
> > +		fevent->last_arg->type = type;
> > +		/*
> > +		 * arg_offset has already been updated once by size.
> > +		 * This update needs to account for that (hence the "- 1").
> > +		 */
> > +		fevent->arg_offset += fevent->last_arg->size * (fevent->last_arg->array - 1);
> > +		return FUNC_STATE_ARRAY_SIZE;
> > +
> > +	case FUNC_STATE_ARRAY_SIZE:
> > +		if (token[0] != ']')
> > +			break;
> > +		return FUNC_STATE_ARRAY_END;
> >  
> >  	case FUNC_STATE_INDIRECT:
> >  		if (token[0] != ']')
> > @@ -453,6 +485,10 @@ static long long get_arg(struct func_arg *arg, unsigned long val)
> >  
> >  	val = val + (arg->indirect ^ INDIRECT_FLAG);
> >  
> > +	/* Arrays do their own indirect reads */
> > +	if (arg->array)
> > +		return val;
> > +  
> 
> Not sure about this.  After this change it would make 'x64[1] foo' and
> 'x64[1] foo[0]' equivalent, right?

Yeah, I may need to re-think this. I originally had the "array"
use the "indirect" code, but I'm thinking that isn't necessary.

Thanks for the input.

-- Steve
