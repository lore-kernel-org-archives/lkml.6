Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZdpGLxVDHltYfQAAmS7hNA
	; Mon, 11 Jun 2018 09:38:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A3E02607E4; Mon, 11 Jun 2018 09:38:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOm4FCAu"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2034160385;
	Mon, 11 Jun 2018 09:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2034160385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbeFKJi1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932109AbeFKJiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:38:25 -0400
Received: from d217.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57A9D20869;
        Mon, 11 Jun 2018 09:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528709903;
        bh=cSB54k+MC0zORITfszz7vi26YdHoyioCwd2+HOtf+aQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IOm4FCAuLwgfmQ8x78AKWKoqbNXXEq9QKfRP+PkpZlBfmJbL1tmwgCuq6p8p8eQ34
         vDjOR+AxC7+4IezAt9eTS0wnwHP40nvIxbm+mAAL98MOKhhqvH9kNJGe6A/pdVXU0N
         gBQv83y4eehPqAtUbnEKgW1NfaHSd+rbNrmUbIpw=
Date: Mon, 11 Jun 2018 11:38:20 +0200
From: Jessica Yu <jeyu@kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
Cc: jikos@kernel.org, jpoimboe@redhat.com, pmladek@suse.com,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] module: Remove superfluous call to klp_module_going()
Message-ID: <20180611093820.aatem2zkqg7yu67g@d217.suse.de>
References: <20180607092949.1706-1-mbenes@suse.cz>
 <20180607092949.1706-4-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180607092949.1706-4-mbenes@suse.cz>
X-OS: Linux d217 4.12.14-lp150.10-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miroslav Benes [07/06/18 11:29 +0200]:
>Now that patched modules cannot suddenly disappear we could
>theoretically remove klp_module_going() altogether. Unfortunately we
>cannot do that in practice. Loading of a patched module may fail and we
>need to execute right the actions implemented in klp_module_going().
>
>Remove the call from delete_module syscall though, because that one is
>really superfluous.
>
>Signed-off-by: Miroslav Benes <mbenes@suse.cz>

Acked-by: Jessica Yu <jeyu@kernel.org>

>---
> kernel/module.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index a6e43a5806a1..af29a0d3708f 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -1019,7 +1019,6 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
> 		mod->exit();
> 	blocking_notifier_call_chain(&module_notify_list,
> 				     MODULE_STATE_GOING, mod);
>-	klp_module_going(mod);
> 	ftrace_release_mod(mod);
>
> 	async_synchronize_full();
>-- 
>2.17.0
>
