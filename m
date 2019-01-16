Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0AEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1222A20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547673077;
	bh=a0qEFIkhY05RjuQaSO88Esq1kRmSAuAziPlRIb6TY7Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=qoJqik+RXpMQ5dfUe0dVCbiq4IeXxXelycld0/nKDSg6uKu6tZ2J+RJgfP1sdlpAp
	 iaf4c/qctC29U96HQp78g/nec5VYnVAvsrgM2EdMHKG85MCMeXpLkwK0vuK9THmVkl
	 fAPpDR9p/lHXryKOcT/C6eiDTAnfcWTgp3UXMbTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfAPVLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:11:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:48982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726924AbfAPVLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:11:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 764A5AFFB;
        Wed, 16 Jan 2019 21:11:13 +0000 (UTC)
Date:   Wed, 16 Jan 2019 22:11:12 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
cc:     jpoimboe@redhat.com, jeyu@kernel.org, pmladek@suse.com,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] livepatch: Send a fake signal periodically
In-Reply-To: <20190115164507.14676-2-mbenes@suse.cz>
Message-ID: <nycvar.YFH.7.76.1901162210090.6626@cbobk.fhfr.pm>
References: <20190115164507.14676-1-mbenes@suse.cz> <20190115164507.14676-2-mbenes@suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019, Miroslav Benes wrote:

> An administrator may send a fake signal to all remaining blocking tasks
> of a running transition by writing to
> /sys/kernel/livepatch/<patch>/signal attribute. Let's do it
> automatically after 15 seconds. The timeout is chosen deliberately. It
> gives the tasks enough time to transition themselves.
> 
> Theoretically, sending it once should be more than enough. However,
> every task must get outside of a patched function to be successfully
> transitioned. It could prove not to be simple and resending could be
> helpful in that case.
> 
> A new workqueue job could be a cleaner solution to achieve it, but it
> could also introduce deadlocks and cause more headaches with
> synchronization and cancelling.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
[ ... snip ... ]
> @@ -400,6 +408,7 @@ void klp_try_complete_transition(void)
>  		 */
>  		schedule_delayed_work(&klp_transition_work,
>  				      round_jiffies_relative(HZ));
> +
>  		return;
>  	}

I somehow didn't like the newly added newline here :) so I've removed it, 
and applied both patches to for-5.1/fake-signal.

Thanks,

-- 
Jiri Kosina
SUSE Labs

