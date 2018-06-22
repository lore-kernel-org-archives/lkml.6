Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0505EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E0A23D5A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E0A23D5A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeFVGX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:23:58 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:53478 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeFVGX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:23:57 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 22 Jun 2018 15:23:54 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.125 with ESMTP; 22 Jun 2018 15:23:54 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 22 Jun 2018 15:23:51 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: Re: [PATCH] rcu: Refactor rcu_{nmi,irq}_{enter,exit}()
Message-ID: <20180622062351.GC17010@X58A-UD3R>
References: <1529647926-24427-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529647926-24427-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 03:12:06PM +0900, Byungchul Park wrote:
> When passing through irq or NMI contexts, the current code uses
> ->dynticks_nmi_nesting to detect if it's in the ourmost at the moment.
> 
> Here, the thing is that all the related functions, rcu_irq_enter(),
> rcu_nmi_enter(), rcu_irq_exit() and rcu_nmi_exit() are carrying out
> the check within each under the following call relationship so there
> must be redundant conditional branches:
> 
>    rcu_irq_enter()
>       /* A conditional branch with ->dynticks_nmi_nesting */
>       rcu_nmi_enter()
>          /* A conditional branch with ->dynticks_nmi_nesting */
                                               ^
                                  Precisely, ->dynticks
>       /* A conditional branch with ->dynticks_nmi_nesting */
> 
>    rcu_irq_exit()
>       /* A conditional branch with ->dynticks_nmi_nesting */
>       rcu_nmi_exit()
>          /* A conditional branch with ->dynticks_nmi_nesting */
>       /* A conditional branch with ->dynticks_nmi_nesting */
> 
>    rcu_nmi_enter()
>       /* A conditional branch with ->dynticks_nmi_nesting */
                                               ^
                                  Precisely, ->dynticks
> 
>    rcu_nmi_exit()
>       /* A conditional branch with ->dynticks_nmi_nesting */
> 
> In order to make the code more readable and remove redundant
> conditional branches, we need to refactor rcu_{nmi,irq}_{enter,exit}()
> so they use a common function for each like:
> 
>    rcu_irq_enter() inlining rcu_nmi_enter_common(irq)
>       /* A conditional branch with ->dynticks_nmi_nesting */
                                               ^
                                  Precisely, ->dynticks
> 
>    rcu_irq_exit() inlining rcu_nmi_exit_common(irq)
>       /* A conditional branch with ->dynticks_nmi_nesting */
> 
>    rcu_nmi_enter() inlining rcu_nmi_enter_common(nmi)
>       /* A conditional branch with ->dynticks_nmi_nesting */
                                               ^
                                  Precisely, ->dynticks
> 
>    rcu_nmi_exit() inlining rcu_nmi_exit_common(nmi)
>       /* A conditional branch with ->dynticks_nmi_nesting */
