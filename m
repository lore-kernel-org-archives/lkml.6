Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeEPPcV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:32:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40943 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeEPPcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:32:19 -0400
Date: Wed, 16 May 2018 17:32:14 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>, tom.zanussi@linux.intel.com
Subject: Re: [PATCH RT 3/5] tracing: Restore proper field flag printing when
 displaying triggers
Message-ID: <20180516153213.mh5zgxzd2hwnkvuh@linutronix.de>
References: <20180516133642.521479369@goodmis.org>
 <20180516133836.518686476@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180516133836.518686476@goodmis.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-16 09:36:45 [-0400], Steven Rostedt wrote:
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 9dac8bae4f34..4745ed588607 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -4916,6 +4916,16 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
>  		seq_printf(m, "%s", field_name);
>  	} else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
>  		seq_puts(m, "common_timestamp");
> +
> +	if (hist_field->flags) {
> +		if (!(hist_field->flags & HIST_FIELD_FL_VAR_REF) &&
> +		    !(hist_field->flags & HIST_FIELD_FL_EXPR)) {
> +			const char *flags = get_hist_field_flags(hist_field);
> +
> +			if (flags)
> +				seq_printf(m, ".%s", flags);
> +		}
> +	}
>  }
>  
>  static int event_hist_trigger_print(struct seq_file *m,

For v4.16 I needed commit 0ae7961e75c3 ("tracing: Fix display of hist
trigger expressions containing timestamps") in order to get this one
cleanly applied. Comparing with -rc3 it looks like commit 5e4cf2bf6d1c
("tracing: Fix a potential NULL dereference") would be great addition.

Safe to take them, right?

Sebastian
