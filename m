Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C5CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF40F214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="F45y+ihs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF40F214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeIZJIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:08:55 -0400
Received: from imap.thunk.org ([74.207.234.97]:47828 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbeIZJIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Tgf3YksX2X7Z0UsiEGNoZFlM1QP5EvQDTJqia08SUs4=; b=F45y+ihsfy2niSGyqzE7tV0NGR
        IZQl7rKrx2ci2DlkhMzyjL+sLhdQhb0f78S03u6yzts76nQ6ESTA/wxOd9iYScc26dV5LeGiWqmHZ
        +QBDpiLEQ9ngPLfj6x7j2LU3gV7C7iOnogoyLAgfSIRa4jkNvp2bUDyRb8G4+MWw+h+8=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g501h-0005qo-W2; Wed, 26 Sep 2018 02:58:10 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B901C7A5107; Tue, 25 Sep 2018 22:58:08 -0400 (EDT)
Date:   Tue, 25 Sep 2018 22:58:08 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Tong Zhang <ztong@vt.edu>, gregkh@linuxfoundation.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
Subject: Re: leaking path in android binder: set_nice
Message-ID: <20180926025808.GA3321@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Stephen Smalley <sds@tycho.nsa.gov>, Tong Zhang <ztong@vt.edu>,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
References: <56B089F7-3656-4335-BBD2-D8B3CFD70996@vt.edu>
 <d38229cb-eb38-19fa-f5d6-30e6389ade3b@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d38229cb-eb38-19fa-f5d6-30e6389ade3b@tycho.nsa.gov>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 01:52:57PM -0400, Stephen Smalley wrote:
> On 09/25/2018 01:27 PM, Tong Zhang wrote:
> > Kernel Version: 4.18.5
> > 
> > Problem Description:
> > 
> > When setting nice value, it is checked by LSM function security_task_setnice().
> > see kernel/sched/core.c:3972 SYSCALL_DEFINE1(nice, int, increment)
> > 
> > We discovered a leaking path in android binder which allows using binder’s interface to change
> > a process’s nice value. This path is leaked from being monitored by LSM.
> > see drivers/android/binder.c:1107 binder_set_nice.
> 
> Not sure you want to invoke the LSM hook (or at least the same hook) when
> binder is performing priority inheritance.  There is a difference between a
> userspace process switching its own priority and the kernel binder driver
> performing it.  IIUC, the can_nice() check is more about honoring
> RLIMIT_NICE than anything else.

I agree with Stephen; it doesn't make sense to subject the binder PI
mechanism to the LSM hook.

					- Ted
