Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDE5C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EF5218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="YKWa4jgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfAXQ4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:56:38 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40657 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfAXQ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:56:37 -0500
Received: by mail-yw1-f65.google.com with SMTP id g194so2685744ywe.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/n5RO3ynJj5/bNE9tmIzk4EgTVnmQBOVPbiCNZWucCY=;
        b=YKWa4jgiYZ79VkYeO8kCZgz1L1IMeQnAHkMW+GVd2NfaNUXvRA6B7g/3RPcFoQVc6O
         0tvrfJrA8IDHOdaGmgsDJ8trxGoio6EUvlkDrQBuR0wQIpBM/6QhLqHCdRbvUJlt9tTd
         PZ7QeIDKBV9N5XPgf+MVl1Ix8wDc2uxHANCMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/n5RO3ynJj5/bNE9tmIzk4EgTVnmQBOVPbiCNZWucCY=;
        b=sic550JQ6aQ26jndwdSgUyiR06zu66ss4DK5yU+EP4qtAuSTe1ivNw/GDhOTMrROq/
         rxcxUdcSUf0qHRRX8JsGvSZRWOQIk8b8IuPguekxHRqKbwLGUNPkhsmXO+SGS9CEI6Uo
         kYhMPPbbYMHAKawLas4NDsDQbIQDgTZ/vjgBuik+7n3wZCwBRVp3tepwXB05xLCBD+9c
         i6wONP84Tpt3h8C7gschfOKi+AI4KWRk5wwdAA4ew+3R+H8dBESvH5EaA6emX2pkIBNV
         CgfsvEynhalouw2ioztLSfX0Wc67Ed4iQLU5g9Pp4EN5LQ8cMl8CK2xR90f90dagGR7h
         +jZQ==
X-Gm-Message-State: AJcUukefsmLf9ctDFj42x26lmkKwEylOMlvbHPbyz63qtIcknAw0oANK
        T3vBHSArwDuB6IIUVy44xpQ5ZAK6kzoh8Q==
X-Google-Smtp-Source: ALg8bN5e7Z+JldJoN/Hhx7DEKL55g8txj4wDHl1/WoeTBZfLIH2ZnDu/pegPTziiRcUN8+jdwXnnwA==
X-Received: by 2002:a81:1492:: with SMTP id 140mr7035640ywu.333.1548348996097;
        Thu, 24 Jan 2019 08:56:36 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:d7cc])
        by smtp.gmail.com with ESMTPSA id n2sm10876374ywe.37.2019.01.24.08.56.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 24 Jan 2019 08:56:35 -0800 (PST)
Date:   Thu, 24 Jan 2019 11:56:34 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: Move maxable seq_file logic into a single place
Message-ID: <20190124165634.GA13549@chrisdown.name>
References: <20190124061718.GA15486@chrisdown.name>
 <20190124160935.GB12436@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190124160935.GB12436@cmpxchg.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner writes:
>I think this increases complexity more than it saves LOC,
>unfortunately.
>
>The current situation is a bit repetitive, but much more obviously
>correct. And we're not planning on adding many more of those memcg
>interface files, so I this doesn't seem to be an improvement re:
>maintainability and future extensibility of the code.

Hmm, my main goal in the patch was not really reduction of LOC, but more around 
centralising logic so that it's clear where these functions are unique and 
where they are completely the same. My initial reaction upon reading these was 
mostly to feel like I'm missing something due to the large amount of similarity 
between them, wondering if the change in mem_cgroup/page_counter access is 
really the only thing to look at, so my goal was primarily to reduce confusion 
(although of course this is subjective, I can also see your point about how 
having "memory.low" and the like without context can also be confusing).

I think using a macro is not ideal, but unfortunately without it a lot of the 
complexity can't really be abstracted easily.

If not this, what would you think about a patch that adds two new functions:

1. mem_cgroup_from_seq
2. mem_cgroup_write_max_or_val

This won't be able to reduce as much of the overlap as the macro, but it still 
will centralise a lot of the logic.
