Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E545DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC64218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="kXE5I3qa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbfAXUMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:12:31 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39920 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbfAXTZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:25:55 -0500
Received: by mail-yw1-f65.google.com with SMTP id k188so2899685ywa.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 11:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ghgBouyMlgr0hppUprLH+laQ2Q5C3qhKtj/1pgdB4Pk=;
        b=kXE5I3qaDTEG+JhQtUbG3LO27nMj4ayuUHaSuiitGKn3SJt8rI8Wq+4L/hlYG7wUAP
         jz1785z219Sj/gJwtJ6K3IzdfFYvYsu6E5xDUHLKCmAsuVPhNvX7FLE8amdVA5xh20Zu
         HN0fa/uED5Jtig1m8f5GPnKQ6jFmyewcoOTNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ghgBouyMlgr0hppUprLH+laQ2Q5C3qhKtj/1pgdB4Pk=;
        b=elV2dF+bNsTmkjTnHJnvTJSzh+XbKBbuJ4gb2azFLkc2v/uWp2JLOSBN1IrD4IA9L9
         gioqBw+eSLG4fOJSQU3mlbq2luSFlHRsabNke+4TxaHS+zGsTfBo/K9NV2EWGrygBQEr
         O+qNhOXVUllsvZna6lka6WTMvKEc78iFcJkJcaZxSEV67KFnZMDtocmiSCrn0M5mHkzc
         mE8QseYskWCjqJUK8xqwutC588QFzs29mUiptxiGA3U8vOBZmF/AnflecF/K6TXReEBi
         dHit9L4+bOm/z5sgFa+ecQiafyPhR7b4kJkudH1ttOvefIsdbq5zvuMrreNk2IvE3bv5
         xOOw==
X-Gm-Message-State: AJcUukdvxEoto6J+dWO8wSw8RAkeutyBzboIBOcZIrUISspU2bt3XIhl
        93CF65ELwA+laJBpIlw8eStCRg==
X-Google-Smtp-Source: ALg8bN7qUHjGkMCW7eI/XgVxezAWfHHL+Swemned17NBYGQhH0Rtk0QfoGyF/dqA5oieu0DWD9Wa0w==
X-Received: by 2002:a81:b603:: with SMTP id u3mr7835793ywh.181.1548357953906;
        Thu, 24 Jan 2019 11:25:53 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:d7cc])
        by smtp.gmail.com with ESMTPSA id p71sm14998747ywg.98.2019.01.24.11.25.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 24 Jan 2019 11:25:53 -0800 (PST)
Date:   Thu, 24 Jan 2019 14:25:52 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: Move maxable seq_file logic into a single place
Message-ID: <20190124192552.GA27084@chrisdown.name>
References: <20190124061718.GA15486@chrisdown.name>
 <20190124160935.GB12436@cmpxchg.org>
 <20190124165634.GA13549@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190124165634.GA13549@chrisdown.name>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to abandon this patch in favour of a patch series which does it 
without macros, but still reduces code duplication fairly significantly. I'll 
send it out shortly.
