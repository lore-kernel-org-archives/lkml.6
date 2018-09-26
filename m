Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6304C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E66A20833
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="bXlBr6C9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E66A20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbeIZJ2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:28:19 -0400
Received: from imap.thunk.org ([74.207.234.97]:47880 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbeIZJ2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gKJr/Bcof96UA+bEBcUC4Qrhue0Gy7wnfxneGLMlAKc=; b=bXlBr6C9foUkqvwPCUbfpeaD1W
        /4F7oFbmjmf0BhoMfjj5VX+K2n5XacrXqnQQeLguvHL2sLfSMUo6jeI2t5+D9Cvg3l9s4XfCwJ0xI
        z0lkq+1pLbTpTPyGcPRE0C83dIqS5NlFkytf4StPKrDId3SZ641cILUCh1bSrUapWcRo=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g50Jl-0006Ax-Mr; Wed, 26 Sep 2018 03:16:51 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9F5A37A5107; Tue, 25 Sep 2018 23:16:45 -0400 (EDT)
Date:   Tue, 25 Sep 2018 23:16:45 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     TongZhang <ztong@vt.edu>
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>, adobriyan@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
Subject: Re: Leaking path for set_task_comm
Message-ID: <20180926031645.GB3321@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        TongZhang <ztong@vt.edu>, Cyrill Gorcunov <gorcunov@gmail.com>,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
References: <F7DFF547-5267-4EF3-8BF3-70DAF6C2A53A@vt.edu>
 <20180925183953.GI15710@uranus>
 <0CD63E6E-7512-4DD6-8858-4408416DC730@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0CD63E6E-7512-4DD6-8858-4408416DC730@vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 08:44:39PM -0400, TongZhang wrote:
> Yes, this is exactly what I am saying.
> A process can change its own name using prctl or /proc/self/comm.
> prctl is protected by security_task_prctl, whereas /proc/self/comm is not protected by this LSM hook.
> 
> A system admin may expect to use security_task_prctl to block all attempt to change process name, however, it can still change name using /proc/self/comm.

None of the in-tree LSM's try to affect PR_SET_NAME.  Looking at
security/commoncap.c, it's clear what is of interest is to checking
things relating to security sensitive things relating to capabilities, such as:

       PR_SET_SECUREBITS
       PR_CAPBSET_*
       PR_*_SECUREBITS
       PR_*_KEEPCAPS
       PR_CAP_AMBIENT

Trying to depend on task name for anything security sensitive is at
_really_ bad idea, so it seems unlikely that a LSM would want to
protect the process name.  (And if they did, the first thing I would
ask is "Why?  What are you trying to do?  Do you realize how many
*other* ways the process name can be spoofed or otherwise controlled
by a potentially malicious user?")

					- Ted
