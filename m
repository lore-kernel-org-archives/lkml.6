Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8140C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D8A20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1e6SM07j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D8A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeH3TPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbeH3TPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:15:35 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB3E205F4;
        Thu, 30 Aug 2018 15:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535641977;
        bh=UEdj/Gvxc1E4fi6Ekzt0jkGxF/qoD117BFuS/9wgM6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1e6SM07jZRZcEwfwdDjn8diIvaHEUJPwRAiVkWpHeHe58f2d5UoCQdbwNdbNeTR6b
         rYYhk2+M76qsSMWitj1cGXWt3uId8wEZsWKYwAJJGBvk03BUuS24LYr8qbxMh5BvEs
         T/xbKu/wHm42BK/4FU4g2Q7QT4j7uSWR+RDOkJII=
Date:   Thu, 30 Aug 2018 17:12:54 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Crispin <john@phrozen.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH stable] tick/nohz: Prevent bogus softirq pending warning
Message-ID: <20180830151253.GB27947@lerouge>
References: <alpine.DEB.2.21.1808301702450.1210@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808301702450.1210@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 05:05:19PM +0200, Thomas Gleixner wrote:
> Commit 0a0e0829f990 ("nohz: Fix missing tick reprogram when interrupting an
> inline softirq") got backported to stable trees and now causes the NOHZ
> softirq pending warning to trigger. It's not an upstream issue as the NOHZ
> update logic has been changed there.
> 
> The problem is when a softirq disabled section gets interrupted and on
> return from interrupt the tick/nohz state is evaluated, which then can
> observe pending soft interrupts. These soft interrupts are legitimately
> pending because they cannot be processed as long as soft interrupts are
> disabled and the interrupted code will correctly process them when soft
> interrupts are reenabled.
> 
> Add a check for softirqs disabled to the pending check to prevent the
> warning.
> 
> Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Reported-by: John Crispin <john@phrozen.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Tested-by: John Crispin <john@phrozen.org>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks for cooking the patch!
