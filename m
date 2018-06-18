Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A79C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375B0208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375B0208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935231AbeFRO6v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:58:51 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:37088 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934674AbeFRO6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:58:49 -0400
Received: by mail-wr0-f170.google.com with SMTP id d8-v6so17200949wro.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 07:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dmp897KLH85f0UHihFbQHQP5zAQ+kYBUmXPLMF3Y12M=;
        b=XVpRLYfaa6a1pT1h4sMeNxXZQj6TviJGhbffyygy6tmEksSJiLZSjr1xizXR6A7agh
         PO2T1cItWmQaICnnNkOYiU+jqAZNkep1ucC2zVmXY55EpS97AmK3kXuoBT1wXpTDKbpC
         66esc4yKHwbu2j3aBRCOHnuu8fYA5J7QyjRrQgGujSoXbPW1e3U4JfDkBAM7oBIFVO7O
         6aWLzKLo4fn+xP3rUuvHxJ0H1pF0P20X5rq7znRYMDythATgoeheDOBAh54aAFDiNCt7
         MwAi7LIsNtDpw9YRDGTO++7WkZMG4+uiIPIt7mM2ZjlBynxrroMSKf6fBxhsnf8Z/PLY
         3yBw==
X-Gm-Message-State: APt69E38IoLXT1U8mc2HHcrVQil2BJO2cmP2mKh4WBIhHrqJePYDtcEL
        zk8xMVyE7FGXbqVWhpEmkIVe8w==
X-Google-Smtp-Source: ADUXVKLgErRGhxsvTfNXP1AXRi1WPH+bbsVmr9E+pafr5LWKA262hUACmMwSlK9XhgaI/gGDOKFbBA==
X-Received: by 2002:adf:d84a:: with SMTP id k10-v6mr10675844wrl.26.1529333928009;
        Mon, 18 Jun 2018 07:58:48 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id i10-v6sm10519567wmf.4.2018.06.18.07.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 07:58:47 -0700 (PDT)
Date:   Mon, 18 Jun 2018 16:58:44 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v10 6/9] cpuset: Make generate_sched_domains() recognize
 isolated_cpus
Message-ID: <20180618145844.GB13097@localhost.localdomain>
References: <1529295249-5207-1-git-send-email-longman@redhat.com>
 <1529295249-5207-7-git-send-email-longman@redhat.com>
 <64a0ea0d-c873-f53e-654e-1dd60f833478@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a0ea0d-c873-f53e-654e-1dd60f833478@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/18 22:44, Waiman Long wrote:

[...]

> 
> Sorry, that one is bogus. Please ignore that.
> 

OK, ignoring this should actually "fix" the odd behaviour I was talking
about.
