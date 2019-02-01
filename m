Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39DCC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39F6218F0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="W0Wn44AO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfBATQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:16:40 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36781 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbfBATQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:16:39 -0500
Received: by mail-yb1-f196.google.com with SMTP id 64so3112282ybf.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 11:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ik+nUeP1/vzq94Z7ZicHjBf1u7i2w1Mxdx/p4Q0QLSE=;
        b=W0Wn44AOStTYe+dttllNOONJ0kwMX4EYLQZLRFhf29Z90hnoImF1lG8nSdMLxA0Qvx
         sKvki9e7iBsjP3b+VFMOseTyDlPyfjw7+rS04bf+5SjjcbF/W5qqz2jWs6AhKtXbfKiy
         eLeelp1K2HK81/hAXExiivV4njdyB6k3k+HJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ik+nUeP1/vzq94Z7ZicHjBf1u7i2w1Mxdx/p4Q0QLSE=;
        b=IEHGxe04I720b7zpWCqnRZwi5GbOZtpmiJeqiqfKp25wf7Nl2asFAw9BWBxsy0Rs51
         ZSwM0jTa6RnMQUy/eW4Wt39M+UcVQadwUCKWx9wDVw0xDQfZwIzfK4y/NyEXyZi2ogal
         hRMuJUp9KzP6AubInVkpqj+miEZ/uothtHIP2Q7nVur7VYyYlkop2GSKKa3J4JL3YHj7
         lBKsnQRreQryu7+MUINYXOAODEllLW+dRBu1arg3epE/zK/sRkK0bX6Cc7BqcLq1tiW1
         Np5vFlcDjPyWYprqS8VN7rEp3pojqZiRa6Uk0hILIJde0ieetfhbYL2M3BgjTwy60pgA
         I4Sg==
X-Gm-Message-State: AJcUukcZYYEtpX1GzV4KZFJ2oHVZftIyoNMeHt+d6gJMU+ePHdg6tZzC
        sl+OOr3FHwvKZz9pDX47A9wNCA==
X-Google-Smtp-Source: ALg8bN7jsO17izO4IlN5zvWMlIrkEZZfYnh/+UYorNdvfS8QY9TFgotBLuVYeqKMWYHg+39wibJlWQ==
X-Received: by 2002:a25:e404:: with SMTP id b4mr38643858ybh.494.1549048598793;
        Fri, 01 Feb 2019 11:16:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:99ee])
        by smtp.gmail.com with ESMTPSA id l7sm3055420ywk.24.2019.02.01.11.16.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 01 Feb 2019 11:16:38 -0800 (PST)
Date:   Fri, 1 Feb 2019 14:16:36 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: Throttle allocators when failing reclaim over
 memory.high
Message-ID: <20190201191636.GA17391@chrisdown.name>
References: <20190201011352.GA14370@chrisdown.name>
 <20190201071757.GE11599@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190201071757.GE11599@dhcp22.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko writes:
>How does this play wit the actual OOM when the user expects oom to
>resolve the situation because the reclaim is futile and there is nothing
>reclaimable except for killing a process?

In addition to what Johannes said, this doesn't impede OOM in the case of 
global system starvation (eg. in the case that all major consumers of memory 
are allocator throttling). In that case nothing unusual will happen, since the 
task's state is TASK_KILLABLE rather than TASK_UNINTERRUPTIBLE, and we will 
exit out of mem_cgroup_handle_over_high as quickly as possible.
