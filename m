Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD64C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE8020866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547661286;
	bh=2WEx89wuZi3BpK3TnQMdYQDOKkaPo+xKSX6ZDgd9KBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LI9FdPdfcA/v7du77Ft0lM1VKLlArwUTN8VX3+OXbulhUl861uMY1meXiWGa31ZcD
	 /AdHSfSpbUCNarZTO453zVcloNDrqGuKaTBgBFcbW9zbUSGCYHgCIg8S2LUa8dnxdD
	 GQpKsRB5KLfws0i8FgyuDAwNTwre2LuheVSxxvSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfAPRyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:54:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfAPRyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:54:44 -0500
Received: from localhost (lfbn-ncy-1-66-34.w83-194.abo.wanadoo.fr [83.194.157.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09FBB20859;
        Wed, 16 Jan 2019 17:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547661283;
        bh=2WEx89wuZi3BpK3TnQMdYQDOKkaPo+xKSX6ZDgd9KBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xVUqNn7yTWmoOwZIF8aZQaHer0ZURA/DlPfa+mMsGDM+jYoES7EVIAKRIZjhvmBUb
         Jp6HHrFzjzwDo1dSn/hTMygaCvYC8a+0k3Dxoz4sI4mWwI5iXlT5KqERDtj9Sehvks
         NKgNIqLoxruC/TFuOvY68rlYCpAgQ1xR7f3r7294=
Date:   Wed, 16 Jan 2019 18:54:40 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Michael Neuling <mikey@neuling.org>
Subject: Re: [RFC PATCH] time/nohz: allow the boot CPU to be nohz_full
Message-ID: <20190116175440.GB26169@lenoir>
References: <20190114064745.27306-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114064745.27306-1-npiggin@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 04:47:45PM +1000, Nicholas Piggin wrote:
> We have a supercomputer site testing nohz_full to reduce jitter with
> good results, but they want CPU0 to be nohz_full. That happens to be
> the boot CPU, which is disallowed by the nohz_full code.
> 
> They have existing job scheduling code which wants this, I don't know
> too much detail beyond that, but I hope the kernel can be made to
> work with their config.
> 
> This patch has the boot CPU take over the jiffies update in the low
> res timer before SMP is brought up, after which the nohz CPU will take
> over.
> 
> It also modifies the housekeeping check code a bit to ensure at least
> one !nohz CPU is in the present map so it comes up at boot, rather
> than having the nohz code take the boot CPU out of the nohz mask.
> 
> This keeps jiffies incrementing on the nohz_full boot CPU before SMP
> init, but I'm not sure if this is covering all races and platform
> considerations. Sorry I don't know the timer code too well, I would
> appreciate any help.
> 
> Thanks,
> Nick

We used to allow that and that broke hibernation :)

So, since we need to have at least one CPU alive to handle the
timekeeping updates on behalf of nohz CPUs, we forbid it to go idle
and offline, for simplicity. Now hibernation requires to disable
non-boot CPUs. So if the timekeeper is not the boot CPU, it's going to
refuse the hotplug operation and break hibernation.
