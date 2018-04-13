Return-Path: <SRS0=YbhT=HC=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AIpwx48ga5xfw9W78XcHK9aXngRuSBv0nHfm2K6PsCZ2lRQJqLtdwbQt86Syq+Pzul8tFP1F/y5f
ARC-Seal: i=1; a=rsa-sha256; t=1523628975; cv=none;
        d=google.com; s=arc-20160816;
        b=n4yoE0i82KvuoVCDkvmn5rSQqtbE8bJrmKL8g4Iw4nNvdRd35Vg8Us2/GhbcSBbXpM
         xwJ2UQQ4RlD2zsCeHM86XXjiIKEuImkh8kOhAVc6rWOh16QWE7K4N0N7gnloD+wX6Ysk
         qobSinjka9ALuFTwVeFpYWJcrToekPTFbxNVbyPK3tL2U6vLkqZqDLo1LJDDAJiXVI3L
         ugWJGS4M2K2UdWcb6gaccu1SgBFg7JbHNhfNE3TaYwwGq4ri9eljZr79H8aHvaFIYV4M
         Ek7vn9jeRnDm/ZCjBa7sfxcgGRAijtQ6KFtZPvozzz08mrVfXmZaJCODXeGbS3InaWLY
         o68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=iFEel/7qDC30MDOqByaiSxUwePdPmJFTw+ccU+zvVf0=;
        b=iOeIzQnHYrD4TLp7zoM1gXXoAItXDLQ/IzX9sTfBRsd09QBhfek5wwE2bFfC2Kz1Rz
         dXfw9pqdDLL44HFNgmRbUaI9KPcfJosC/xcsUYsfHVWvzIwNXz4vXqQ0vr1ln2N/JwRp
         9LH2EcseFm6wxHKdpQmutp8pMVcSJ11ldfUI/+u7HOGZftGdc/ZX1ZNT5tyA3zTfUxUb
         dekxjgslQ2tYIsT09iYw084/8hYw+0TWBQejdprAyhOk2jc/c+plxjhfWrwpBG4AikSE
         GuueC+aNsXj+FjD7c7KIkEoad7Rkdl1JvtFMR56CS1yHdseLiFuxwpBV+0itHS90VZAo
         Fp2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=ybht=hc=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=YbhT=HC=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=ybht=hc=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=YbhT=HC=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C472077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 13 Apr 2018 10:16:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>, Li Zefan
 <lizf@cn.fujitsu.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] tracing/events: block: track and print if unplug
 was explicit or schedule
Message-ID: <20180413101612.3999f742@gandalf.local.home>
In-Reply-To: <20180413130719.22921-2-maier@linux.ibm.com>
References: <20180413130719.22921-1-maier@linux.ibm.com>
	<20180413130719.22921-2-maier@linux.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597636487135013741?=
X-GMAIL-MSGID: =?utf-8?q?1597640775887760539?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 15:07:17 +0200
Steffen Maier <maier@linux.ibm.com> wrote:

> Just like blktrace distinguishes explicit and schedule by means of
> BLK_TA_UNPLUG_IO and BLK_TA_UNPLUG_TIMER, actually make use of the
> existing argument "explicit" to distinguish the two cases in the one
> common tracepoint block_unplug.
> 
> Complements v2.6.39 commit 49cac01e1fa7 ("block: make unplug timer trace
> event correspond to the schedule() unplug") and commit d9c978331790
> ("block: remove block_unplug_timer() trace point").
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> ---
>  include/trace/events/block.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 81b43f5bdf23..a13613d27cee 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -470,6 +470,11 @@ TRACE_EVENT(block_plug,
>  	TP_printk("[%s]", __entry->comm)
>  );
>  
> +#define show_block_unplug_explicit(val)		\
> +	__print_symbolic(val,			\
> +			 {false, "schedule"},	\
> +			 {true,	 "explicit"})

That's new. I haven't seen "true"/"false" values used for
print_symbolic before. But could you please use 1 and 0 instead, because
perf and trace-cmd won't be able to parse that. I could update
libtraceevent to handle it, but really, the first parameter is suppose
to be numeric.

-- Steve

> +
>  DECLARE_EVENT_CLASS(block_unplug,
>  
>  	TP_PROTO(struct request_queue *q, unsigned int depth, bool explicit),
> @@ -478,15 +483,18 @@ DECLARE_EVENT_CLASS(block_unplug,
>  
>  	TP_STRUCT__entry(
>  		__field( int,		nr_rq			)
> +		__field( bool,		explicit		)
>  		__array( char,		comm,	TASK_COMM_LEN	)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->nr_rq = depth;
> +		__entry->explicit = explicit;
>  		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
>  	),
>  
> -	TP_printk("[%s] %d", __entry->comm, __entry->nr_rq)
> +	TP_printk("[%s] %d %s", __entry->comm, __entry->nr_rq,
> +		  show_block_unplug_explicit(__entry->explicit))
>  );
>  
>  /**
