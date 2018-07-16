Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E93ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5DE20854
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5DE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeGPPXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:23:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729357AbeGPPXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:23:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD2424022414;
        Mon, 16 Jul 2018 14:55:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 641D2111CB8E;
        Mon, 16 Jul 2018 14:55:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 16 Jul 2018 16:55:43 +0200 (CEST)
Date:   Mon, 16 Jul 2018 16:55:40 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
Subject: Re: [RFC][PATCH 09/11] tty_io: Use do_send_sig_info in __do_SACK  to
 forcibly kill tasks
Message-ID: <20180716145540.GA20960@redhat.com>
References: <877em2jxyr.fsf_-_@xmission.com>
 <20180711024459.10654-9-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711024459.10654-9-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 16 Jul 2018 14:55:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 16 Jul 2018 14:55:43 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10, Eric W. Biederman wrote:
>
> Therefore use do_send_sig_info in all cases in __do_SAK to kill
> tasks as allows for exactly what the code wants to do.

OK, but probably the changelog should also mention that now even the global
init will be killed if it has this tty opened.


> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  drivers/tty/tty_io.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index cec58c53b0c4..42ac168c2a47 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -2747,7 +2747,7 @@ void __do_SAK(struct tty_struct *tty)
>  	do_each_pid_task(session, PIDTYPE_SID, p) {
>  		tty_notice(tty, "SAK: killed process %d (%s): by session\n",
>  			   task_pid_nr(p), p->comm);
> -		send_sig(SIGKILL, p, 1);
> +		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, true);
>  	} while_each_pid_task(session, PIDTYPE_SID, p);
>  
>  	/* Now kill any processes that happen to have the tty open */
> @@ -2755,7 +2755,7 @@ void __do_SAK(struct tty_struct *tty)
>  		if (p->signal->tty == tty) {
>  			tty_notice(tty, "SAK: killed process %d (%s): by controlling tty\n",
>  				   task_pid_nr(p), p->comm);
> -			send_sig(SIGKILL, p, 1);
> +			do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, true);
>  			continue;
>  		}
>  		task_lock(p);
> @@ -2763,7 +2763,7 @@ void __do_SAK(struct tty_struct *tty)
>  		if (i != 0) {
>  			tty_notice(tty, "SAK: killed process %d (%s): by fd#%d\n",
>  				   task_pid_nr(p), p->comm, i - 1);
> -			force_sig(SIGKILL, p);
> +			do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, true);
>  		}
>  		task_unlock(p);
>  	} while_each_thread(g, p);
> -- 
> 2.17.1
> 

