Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755306AbeDWNeH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754894AbeDWNeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:34:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C849421746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 23 Apr 2018 09:34:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "Bart.VanAssche@sandisk.com" <Bart.VanAssche@sandisk.com>,
        "rajatja@google.com" <rajatja@google.com>
Subject: Re: [RESEND PATCH v1 2/2] trace: events: block: Add tag in block
 trace events
Message-ID: <20180423093401.30839625@gandalf.local.home>
In-Reply-To: <f28ab517-9172-e585-718c-8a54adbfc3bc@linux.ibm.com>
References: <64d6073b28b140cda3e5870a54e0a7bc@SIWEX5A.sing.micron.com>
        <f28ab517-9172-e585-718c-8a54adbfc3bc@linux.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018 14:43:13 +0200
Steffen Maier <maier@linux.ibm.com> wrote:

> > -	TP_printk("[%s] %d", __entry->comm, __entry->nr_rq)
> > +	TP_printk("[%s] %d %s", __entry->comm, __entry->nr_rq,
> > +		   __entry->explicit ? "Sync" : "Async")
> >   );
> > 
> >   /**  
> 
> This entire hunk does not seem related to this patch description.
> Also, I'm not sure trace-cmd and perf et al. could format it accordingly.

You mean the "?:" operation? trace-cmd and perf can handle it fine.
Just look at the trace event irq_handler_exit:

 print fmt: "irq=%d ret=%s", REC->irq, REC->ret ? "handled" : "unhandled"

# trace-cmd record -e irq_handler_exit
# trace-cmd report
          <idle>-0     [001] 856960.382767: irq_handler_exit:     irq=29 ret=handled
          <idle>-0     [001] 856961.745640: irq_handler_exit:     irq=29 ret=handled
          <idle>-0     [001] 856961.865762: irq_handler_exit:     irq=29 ret=handled


-- Steve
