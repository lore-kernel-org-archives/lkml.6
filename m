Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FE3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E330F2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E330F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbeGPNI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:08:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728524AbeGPNI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:08:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42B4877885;
        Mon, 16 Jul 2018 12:41:40 +0000 (UTC)
Received: from treble (ovpn-122-49.rdu2.redhat.com [10.10.122.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0F6F7C4D;
        Mon, 16 Jul 2018 12:41:39 +0000 (UTC)
Date:   Mon, 16 Jul 2018 07:41:38 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Remove reliable stacktrace check in
 klp_try_switch_task()
Message-ID: <20180716124138.pyqbiviqoxcbs44g@treble>
References: <1531382706-9732-1-git-send-email-kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531382706-9732-1-git-send-email-kamalesh@linux.vnet.ibm.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 16 Jul 2018 12:41:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 16 Jul 2018 12:41:40 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:35:06PM +0530, Kamalesh Babulal wrote:
> Support for immediate flag was removed by commit d0807da78e11
> ("livepatch: Remove immediate feature").  We bail out during
> patch registration for architectures, those don't support
> reliable stack trace. Remove the check in klp_try_switch_task(),
> as its not required.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

> ---
>  kernel/livepatch/transition.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index 7c6631e693bc..5bc349805e03 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -310,13 +310,6 @@ static bool klp_try_switch_task(struct task_struct *task)
>  		return true;
>  
>  	/*
> -	 * For arches which don't have reliable stack traces, we have to rely
> -	 * on other methods (e.g., switching tasks at kernel exit).
> -	 */
> -	if (!klp_have_reliable_stack())
> -		return false;
> -
> -	/*
>  	 * Now try to check the stack for any to-be-patched or to-be-unpatched
>  	 * functions.  If all goes well, switch the task to the target patch
>  	 * state.
> -- 
> 2.7.4
> 

-- 
Josh
