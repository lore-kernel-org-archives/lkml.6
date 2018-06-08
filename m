Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NX/mHlHyGlt0LQAAmS7hNA
	; Fri, 08 Jun 2018 21:17:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6F7756089E; Fri,  8 Jun 2018 21:17:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EC081601D2;
	Fri,  8 Jun 2018 21:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC081601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeFHVRC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:17:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752992AbeFHVRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:17:01 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 30413927;
        Fri,  8 Jun 2018 21:17:01 +0000 (UTC)
Date: Fri, 8 Jun 2018 14:16:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Davidlohr Bueso <dbueso@suse.de>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] ipc: Limit sysctl value to IPCMNI
Message-Id: <20180608141659.8a517b128c756b4d0b813c9e@linux-foundation.org>
In-Reply-To: <20180608134949.12672-1-tiwai@suse.de>
References: <20180608134949.12672-1-tiwai@suse.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Jun 2018 15:49:49 +0200 Takashi Iwai <tiwai@suse.de> wrote:

> Currently shmmni proc entry accepts all entered integer values, but
> the practical limit is IPCMNI (32768).  This confuses user as if a
> bigger value were accepted but not applied correctly.
> 
> This patch changes the proc entry to use *_minmax variant to limit the
> accepted values accordingly.

Waiman Long was working on a (vastly more complicated) patchset to
address this.

> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -99,6 +99,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
>  static int zero;
>  static int one = 1;
>  static int int_max = INT_MAX;
> +static int ipcmni = IPCMNI;
>  
>  static struct ctl_table ipc_kern_table[] = {
>  	{
> @@ -120,7 +121,9 @@ static struct ctl_table ipc_kern_table[] = {
>  		.data		= &init_ipc_ns.shm_ctlmni,
>  		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
>  		.mode		= 0644,
> -		.proc_handler	= proc_ipc_dointvec,
> +		.proc_handler	= proc_ipc_dointvec_minmax,
> +		.extra1		= &zero,
> +		.extra2		= &ipcmni,
>  	},
>  	{
>  		.procname	= "shm_rmid_forced",

What is the back-compatibility situation here?
