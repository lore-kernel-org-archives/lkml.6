Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA480C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9813A21848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aKP991mn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CtKu/jLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbfAKKhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:37:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfAKKhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:37:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2B47C608CE; Fri, 11 Jan 2019 10:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547203067;
        bh=0jnvXPeTvd+zLe0+T19WVbVNbZUN3iS0HEfwpZX21Xc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aKP991mnU8WFUjcutkWBsaiWhvyUd4jIdCNz5VjF3wkDnP6HGLdvlwP3NGOWZrNnT
         TOLmqOSFi+8a5/Cyu6RKm6dtkbF6x0vvu1l7zFGOzFZRUFbw7cxmH+AyxQQLdXgHsM
         VNupOzwm2XWAyat6sb04JueR4pWbfGbVUZ2bYa2w=
Received: from [10.204.78.166] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 345626089D;
        Fri, 11 Jan 2019 10:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547203066;
        bh=0jnvXPeTvd+zLe0+T19WVbVNbZUN3iS0HEfwpZX21Xc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CtKu/jLTS1SOECio0FTP/yo7w+edso8re6yDlwBKiJ3g78YFo9TL5eSBZ6AxQxMyr
         lJ5zm0yI0uq2wxGHFq2xXWbSBwK6Uc95XzFoQbMpMSohf9byid5KLdgf/RBqj4jo0h
         7b0f4jnOox56PLBPN2pj/8t+O7jCFYUUgZtX0Vsg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 345626089D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: kernel BUG at kernel/sched/core.c:3490!
To:     Oleg Nesterov <oleg@redhat.com>, Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux kernel <linux-kernel@vger.kernel.org>
References: <ba9c5ad8-d78c-904d-0430-a67d8e3ea729@lca.pw>
 <20190107135215.GG14122@hirez.programming.kicks-ass.net>
 <46089f1c-ad72-c96c-2f35-c2f60e726462@lca.pw>
 <20190107175644.GB7636@redhat.com>
From:   "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <3a6d8f4c-d7ed-e888-601b-a379efec306a@codeaurora.org>
Date:   Fri, 11 Jan 2019 16:07:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107175644.GB7636@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/2019 11:26 PM, Oleg Nesterov wrote:
> pr_crit("XXX: %ld %d\n", current->state, current->on_rq);

Can we also add flags, this may help to know the path of problem:

  pr_crit("XXX: %ld %d 0x%x\n", current->state, current->on_rq, 	 
current->flags);

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
