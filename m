Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC99ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3585520848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tWrEqNJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3585520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJZSdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:33:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33250 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeJZSdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7xgOBhIV84R3NpYql/jkh1mbbx8m+kry9kTYf0pKJ4Q=; b=tWrEqNJ+UI1qQvK1coEIG27bZ
        lWi0ep0c8oURa7uP0nZ95XzDiEjL+KFLVHZPhNXb70m58UMqKitVtmilaYjYm7gBVlkHVV4Sruirb
        h2fnbJO2BXL8LUj07r+EyiVEyHpVWD5XuxmshFxlx6CfZV+B+lSGazyKV3rHzkT6G5Rcj94c5zINL
        tSx2KBo1iRMM8Xm8fkG/90AZjoNMZri4TZuW+7ekgpUyM0D1r2pDhmt+Gm5FLgmXpPUk57Vxnu1Px
        w4nHohYZK4h402lMFbL7EW+Ut+Ggjd43TZJe6bfyAiozmTzrgpUG+GQC0/xL0zt9M2gmyn4FPq4Dv
        f8E0B17kw==;
Received: from [167.98.65.38] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFyqk-0001HE-V6; Fri, 26 Oct 2018 09:56:15 +0000
Received: by worktop (Postfix, from userid 1000)
        id CF15C6E07BE; Fri, 26 Oct 2018 11:38:04 +0200 (CEST)
Date:   Fri, 26 Oct 2018 11:38:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/17] prmem: llist, hlist, both plain and rcu
Message-ID: <20181026093804.GD3126@worktop.c.hoisthospitality.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-15-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023213504.28905-15-igor.stoppa@huawei.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:35:01AM +0300, Igor Stoppa wrote:
> In some cases, all the data needing protection can be allocated from a pool
> in one go, as directly writable, then initialized and protected.
> The sequence is relatively short and it's acceptable to leave the entire
> data set unprotected.
> 
> In other cases, this is not possible, because the data will trickle over
> a relatively long period of time, in a non predictable way, possibly for
> the entire duration of the operations.
> 
> For these cases, the safe approach is to have the memory already write
> protected, when allocated. However, this will require replacing any
> direct assignment with calls to functions that can perform write rare.
> 
> Since lists are one of the most commonly used data structures in kernel,
> they are a the first candidate for receiving write rare extensions.
> 
> This patch implements basic functionality for altering said lists.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Kate Stewart <kstewart@linuxfoundation.org>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Philippe Ombredanne <pombredanne@nexb.com>
> CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> CC: Josh Triplett <josh@joshtriplett.org>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Lai Jiangshan <jiangshanlai@gmail.com>
> CC: linux-kernel@vger.kernel.org
> ---
>  MAINTAINERS            |   1 +
>  include/linux/prlist.h | 934 +++++++++++++++++++++++++++++++++++++++++

I'm not at all sure I understand the Changelog, or how it justifies
duplicating almost 1k lines of code.

Sure lists aren't the most complicated thing we have, but duplicating
that much is still very _very_ bad form. Why are we doing this?
