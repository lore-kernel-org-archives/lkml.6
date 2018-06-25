Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25DDC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D0725BFE
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D0725BFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934712AbeFYPEA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:04:00 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:48647 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934544AbeFYPD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:03:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id AFD14837F252;
        Mon, 25 Jun 2018 15:03:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wing75_55bd6ac0c559
X-Filterd-Recvd-Size: 2254
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Jun 2018 15:03:56 +0000 (UTC)
Message-ID: <e067d2ffe025e280761650d19782b43ff678edb2.camel@perches.com>
Subject: Re: [PATCH v2] arch/x86: get rid of KERN_CONT in show_fault_oops()
From:   Joe Perches <joe@perches.com>
To:     Dmitry Vyukov <dvyukov@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        sergey.senozhatsky.work@gmail.com
Cc:     Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 Jun 2018 08:03:55 -0700
In-Reply-To: <20180625123808.227417-1-dvyukov@gmail.com>
References: <20180625123808.227417-1-dvyukov@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 14:38 +0200, Dmitry Vyukov wrote:
> From: Dmitry Vyukov <dvyukov@google.com>
> 
> KERN_CONT leads to split lines in kernel output
> and complicates useful changes to printk like
> printing context before each line.
> 
> Only acceptable use of continuations is basically
> boot-time testing.
> 
> Get rid of it.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> 
> ---
> 
> Changes since v1:
>  - use pr_alert() instead of printk(KERN_ALERT)
> ---
>  arch/x86/mm/fault.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
[]
> @@ -671,13 +671,9 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
>  			printk(smep_warning, from_kuid(&init_user_ns, current_uid()));
>  	}
>  
> -	printk(KERN_ALERT "BUG: unable to handle kernel ");
> -	if (address < PAGE_SIZE)
> -		printk(KERN_CONT "NULL pointer dereference");
> -	else
> -		printk(KERN_CONT "paging request");
> -
> -	printk(KERN_CONT " at %px\n", (void *) address);
> +	pr_alert("BUG: unable to handle kernel %s at %px\n",
> +		(address < PAGE_SIZE ? "NULL pointer dereference" :
> +		"paging request"), (void *) address);

Perhaps remove the used-once KERN_CRIT uses of
nx_warning and smep_warning strings and maybe the
unnecessary parentheses and spaces used here too.

