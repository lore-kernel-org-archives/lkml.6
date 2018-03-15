Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeCOJb1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751864AbeCOJb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:31:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9063620779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Thu, 15 Mar 2018 18:31:23 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, wangnan0@huawei.com, mingo@redhat.com,
        srikar@linux.vnet.ibm.com, oleg@redhat.com, mhiramat@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v2 2/2] trace_uprobe: Simplify probes_seq_show()
Message-Id: <20180315183123.e47cbb238ef59ff964564cbf@kernel.org>
In-Reply-To: <20180315082756.9050-2-ravi.bangoria@linux.vnet.ibm.com>
References: <20180315082756.9050-1-ravi.bangoria@linux.vnet.ibm.com>
        <20180315082756.9050-2-ravi.bangoria@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018 13:57:56 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> Simplify probes_seq_show() function. No change in output
> before and after patch.

Yeah, we don't need this trick anymore.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
>  kernel/trace/trace_uprobe.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 0298bd15be83..544fa10a471b 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -602,24 +602,9 @@ static int probes_seq_show(struct seq_file *m, void *v)
>  	char c = is_ret_probe(tu) ? 'r' : 'p';
>  	int i;
>  
> -	seq_printf(m, "%c:%s/%s", c, tu->tp.call.class->system,
> -			trace_event_name(&tu->tp.call));
> -	seq_printf(m, " %s:", tu->filename);
> -
> -	/* Don't print "0x  (null)" when offset is 0 */
> -	if (tu->offset) {
> -		seq_printf(m, "0x%0*lx", (int)(sizeof(void *) * 2), tu->offset);
> -	} else {
> -		switch (sizeof(void *)) {
> -		case 4:
> -			seq_printf(m, "0x00000000");
> -			break;
> -		case 8:
> -		default:
> -			seq_printf(m, "0x0000000000000000");
> -			break;
> -		}
> -	}
> +	seq_printf(m, "%c:%s/%s %s:0x%0*lx", c, tu->tp.call.class->system,
> +			trace_event_name(&tu->tp.call), tu->filename,
> +			(int)(sizeof(void *) * 2), tu->offset);
>  
>  	for (i = 0; i < tu->tp.nr_args; i++)
>  		seq_printf(m, " %s=%s", tu->tp.args[i].name, tu->tp.args[i].comm);
> -- 
> 2.13.6
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
