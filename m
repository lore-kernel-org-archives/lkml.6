Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D46C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E2421904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="awsThBKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfBGPFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:05:42 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43441 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfBGPFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:05:40 -0500
Received: by mail-qk1-f195.google.com with SMTP id z18so75562qkj.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 07:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f7ZDxWz5PmQRqfirx64qTSlszpjf9oFFpAHhhgpwKPo=;
        b=awsThBKxgug24R0KlX9ZyehaBoW4ws5q5wOSav4Mqj36NOUhpukMaNW00zuVJmZXiE
         oMc1WrE+DVgdGqPmD2p1d27WKoUbS+a3IDgHyol1jtB0bo9B0dFFUBThfnxtvIc2kWtx
         XOYX2/0FFLrQHeWYpecSWlwzEbST10nGtXjfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f7ZDxWz5PmQRqfirx64qTSlszpjf9oFFpAHhhgpwKPo=;
        b=BgLiqTYmXekI5HXY5VLT9rovyAs3EUqKyDW6zkFNUehyypSAy/3XpivyUZT5ATcwhi
         gMCXT/v4QjUPKY5btzDniV9qc3wg4xh+RIEjVGB2SHVEada4ecWdZkHfKe4I8IxkHD1E
         1W6TuwlmCzOXIg2J0hBbpD96YvXFnd3kCTW41dsuggjK4QWG221cvgWtP54j/IbHyaMU
         swkhG6PVdHUYVEsEdSjZhQCp686/g+Ym8vSflCa2i2vBXROxrrRhGp/9ThrdiDEuH8un
         H8frFtJ4JWx31Gpq9UDIdunFlj8SFlhMjhJc6/TscWsJEbtOQ9msIrozXC52trZEgK5L
         XS+A==
X-Gm-Message-State: AHQUAuYmqj2zYApEQvY0CAvQAPsF6BwvsCu8FFxfvOYFpLzcHM/hNzzS
        PPt1r+yiBfSUh6fMBHFPF6pe+Q==
X-Google-Smtp-Source: AHgI3IaiJaX2QVRLGXU6BJPkf69R8zVWb0CyaWqp0yQAMQp26NduVLLzOLl3UjYVMS/jMdFS8N+BJA==
X-Received: by 2002:a37:8c04:: with SMTP id o4mr11371079qkd.165.1549551939531;
        Thu, 07 Feb 2019 07:05:39 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id n9sm10272778qtn.59.2019.02.07.07.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 07:05:37 -0800 (PST)
Date:   Thu, 7 Feb 2019 10:05:37 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/wait: use freezable_schedule when possible
Message-ID: <20190207150537.GA180446@google.com>
References: <cover.1548998323.git.hle@owl.eu.com>
 <d9b2ed186ed6fcacaaecd876bb66dca8fa329d8b.1548998323.git.hle@owl.eu.com>
 <20190202183743.GA229953@google.com>
 <20190206233050.GB2092@behemoth.owl.eu.com.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206233050.GB2092@behemoth.owl.eu.com.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 12:30:50AM +0100, Hugo Lefeuvre wrote:
> Hi Joel,
> 
> > I'm curious did you try the freezing process and see if pointless wakeups are
> > reduced?  That would be an added bonus if you did.
> 
> I'm currently testing these changes. I hope to be able to come back with
> more concrete results soon.
> 
> Also, I just noticed that the third patch removes a necessary #include
> <linux/freezer.h>. I will submit an updated version tomorrow.
> 
> Thanks for the review!

Sure, add these test results to the patch as well showing reduced wakeups.

I would say submit the freezable_schedule as a single separate patch
independent of the vsoc series since it can go in separately, and also
benefits other things than vsoc.

Also CC Rafael (power maintainer) on it.

Thank you!

 - Joel

