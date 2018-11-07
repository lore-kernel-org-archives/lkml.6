Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED52C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A6C2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A6C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbeKHCJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:09:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41692 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbeKHCJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:09:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so18101554wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 08:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oxAyYKk4ZUdTcgphyhxBz3Mw8M/Glz83iSK7x/ZcXHo=;
        b=cp+/J/fGNFRFFPENNdOHOPEsLViKELMZI0w/n1hzq2Kine7jG/IHKbRIsLOZ3koQWJ
         7OPwVG8ihyZpOXJD2wL8UxuzkiaGuFciHcbwS7iPt8KCi6KwG2Y//9L6+pWzNNkjr6xm
         DYgXdaDo7HpFIbb//8+v+3bM8mzXcZCHARd1hziP9X6OBNw3f+Y3xsZ/E5DLi7wU92Ok
         TFGHcjZUEstaFAxoOEYbDyY4vqetZrXReayxWSHklMKUnoqsSCSR9HYaiHZJA/onBTtI
         lJzEPHbEuS+V3G6r7qcj0QyeladZ3ppw4G649iFjXA1tswbza/Eb3wDRj1u5W2wO6i8z
         oiWA==
X-Gm-Message-State: AGRZ1gKa46DXug5OK9rdvP/505nIkF0oQrr5K3fXbQnLG2+USHxveUbw
        OQAHmqs+yHholeCPbgWi254JGQ==
X-Google-Smtp-Source: AJdET5c60rQd9hnDrD4BI0jNNB+VZlNFfT04p04OI3/WkOzgIuhL/pQxJ0tMSyV02sh162FjkRuqew==
X-Received: by 2002:a5d:69ce:: with SMTP id s14-v6mr954531wrw.177.1541608726500;
        Wed, 07 Nov 2018 08:38:46 -0800 (PST)
Received: from localhost.localdomain ([151.35.177.55])
        by smtp.gmail.com with ESMTPSA id 137-v6sm2122692wmo.43.2018.11.07.08.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 08:38:45 -0800 (PST)
Date:   Wed, 7 Nov 2018 17:38:41 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan@huawei.com, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, cgroups@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        longman@redhat.com
Subject: Re: [PATCH v5 3/5] cgroup/cpuset: make callback_lock raw
Message-ID: <20181107163841.GA18091@localhost.localdomain>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
 <20180903142801.20046-4-juri.lelli@redhat.com>
 <20180925143416.GD25664@localhost.localdomain>
 <20181107155330.GA2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107155330.GA2509588@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/11/18 07:53, Tejun Heo wrote:
> Hello,
> 
> On Tue, Sep 25, 2018 at 04:34:16PM +0200, Juri Lelli wrote:
> > It would be great if you could please have a look at the proposed change
> > below (and the rest of the set of course :-).
> 
> Yeah, looks good to me.  Please feel free to add
> 
>  Acked-by: Tejun Heo <tj@kernel.org>

Thanks!

> > Another bit that I'd be more comfortable after hearing your word on it
> > is this one (discussed over 5/5):
> > 
> > https://lore.kernel.org/lkml/20180925130750.GA25664@localhost.localdomain/
> 
> Can you please loop Waiman Long <longman@redhat.com> into discussion?
> He's working on cgroup2 cpuset support which might collide.

Sure, I've been originally working on this on top of his series, but
didn't try with latest version. Hopefully the two series don't generate
too much collisions. I'll try to find some time soon to check again.

In the meantime, Waiman Long, how do you feel about it? :-)

Thread starts at (you if missed it)

https://lore.kernel.org/lkml/20180903142801.20046-1-juri.lelli@redhat.com/

Best,

- Juri
