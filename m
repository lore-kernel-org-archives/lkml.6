Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932524AbeBLCPj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 21:15:39 -0500
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:43966 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbeBLCPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 21:15:37 -0500
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Mon, 12 Feb 2018 11:15:34 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
Subject: Re: [PATCH 17/18] tracing: Add indirect to indirect access for
 function based events
Message-ID: <20180212021534.GH31513@sejong>
References: <20180202230458.840252014@goodmis.org>
 <20180202231019.582037880@goodmis.org>
 <20180209051301.GE28206@sejong>
 <20180209104758.093d31ad@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180209104758.093d31ad@gandalf.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 10:47:58AM -0500, Steven Rostedt wrote:
> On Fri, 9 Feb 2018 14:13:01 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > On Fri, Feb 02, 2018 at 06:05:15PM -0500, Steven Rostedt wrote:
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > 
> > > Allow the function based events to retrieve not only the parameters offsets,
> > > but also get data from a pointer within a parameter structure. Something
> > > like:
> > > 
> > >  # echo 'ip_rcv(string skdev+16[0][0] | x8[6] skperm+16[0]+558)' > function_events
> > > 
> > >  # echo 1 > events/functions/ip_rcv/enable
> > >  # cat trace
> > >     <idle>-0     [003] ..s3   310.626391: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
> > >     <idle>-0     [003] ..s3   310.626400: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
> > >     <idle>-0     [003] ..s3   312.183775: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
> > >     <idle>-0     [003] ..s3   312.184329: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
> > >     <idle>-0     [003] ..s3   312.303895: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
> > >     <idle>-0     [003] ..s3   312.304610: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
> > >     <idle>-0     [003] ..s3   312.471980: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
> > >     <idle>-0     [003] ..s3   312.472908: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
> > >     <idle>-0     [003] ..s3   313.135804: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
> > > 
> > > That is, we retrieved the net_device of the sk_buff and displayed its name
> > > and perm_addr info.
> > > 
> > >   sk->dev->name, sk->dev->perm_addr
> > > 
> > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > ---  
> > 
> > [SNIP]
> > > +static unsigned long process_redirects(struct func_arg *arg, unsigned long val,
> > > +				       char *buf)
> > > +{
> > > +	struct func_arg_redirect *redirect;
> > > +	int ret;
> > > +
> > > +	if (arg->indirect) {
> > > +		ret = probe_kernel_read(buf, (void *)val, sizeof(long));
> > > +		if (ret)
> > > +			return 0;
> > > +		val = *(unsigned long *)buf;
> > > +	}
> > > +
> > > +	list_for_each_entry(redirect, &arg->redirects, list) {
> > > +		val += redirect->index;
> > > +		if (redirect->indirect) {
> > > +			val += (redirect->indirect ^ INDIRECT_FLAG);
> > > +			ret = probe_kernel_read(buf, (void *)val, sizeof(long));
> > > +			if (ret)
> > > +				return 0;
> > > +		}
> > > +	}
> > > +	return val;
> > > +}
> > > +
> > > +static long long __get_arg(struct func_arg *arg, unsigned long long val)
> > >  {
> > >  	char buf[8];
> > >  	int ret;
> > >  
> > >  	val += arg->index;
> > >  
> > > -	if (!arg->indirect)
> > > -		return val;
> > > +	if (arg->indirect)
> > > +		val += (arg->indirect ^ INDIRECT_FLAG);
> > >  
> > > -	val = val + (arg->indirect ^ INDIRECT_FLAG);
> > > +	if (!list_empty(&arg->redirects))
> > > +		val = process_redirects(arg, val, buf);
> > > +
> > > +	if (!val)
> > > +		return 0;
> > >  
> > >  	/* Arrays and strings do their own indirect reads */
> > > -	if (arg->array || arg->func_type == FUNC_TYPE_string)
> > > +	if (!arg->indirect || arg->array || arg->func_type == FUNC_TYPE_string)
> > >  		return val;  
> > 
> > It seems the indirect is processed twice with redirects.  Consider
> > "x64 foo[0]+4", the process_redirects() will call probe_kernel_read()
> > and then here again.
> > 
> 
> 
> Good catch!
> 
> It should have been:
> 
> 		return process_redirects(arg, val, buf);

But I think you need to consider data type of the arg when
dereferencing the last redirect.

Thanks,
Namhyung
