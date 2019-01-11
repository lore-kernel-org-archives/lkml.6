Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8791C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9F52183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="bIJ+SWjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfAKVw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:52:26 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35031 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfAKVw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:52:26 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so20526953qtc.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 13:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Rznx8m7oF3vk7OvtYn7TIPy51bBYUCQncQQQG14BSTc=;
        b=bIJ+SWjADDx+zmkSDmbB+mdj7BMAUd+EwHS8D2WLJU5Gikuze5O8djfkayy4uRPsr4
         EMwr4WLjpuQC3Yguw5a74sCZ2D9pqaNJ5GM5Mnc90J9VrD2uSNmzLCwG1L0Tnw+YPeS4
         LeXLLOwbCY/aUE03q4QQIb664QfQxC+fCpy48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Rznx8m7oF3vk7OvtYn7TIPy51bBYUCQncQQQG14BSTc=;
        b=qGFOGbHc43I3coH2B1Y+8i4WMVgjvoEgA+5NL0ryrPTG2HX6PWl2n8mGE0Hx7/kVst
         ST/V4tdVsje9vAOFQbacgPO8FIKdnwchKehWrM4wxMM5nzJ8nAOJVYH2BdgIoZZQ0bVO
         8uh3pXeQIMHplz13miya8g0VVSCcA8kzYEg837oJz2yWcezE11YMEinKY03G585RfLLS
         e6DRcQhuUJwLWvj74EcrikEBu6lANolS/h8t+paMXgBVDWTmHRo4HWGsokmuNmhHq2bs
         kl5fNQ9VRwwd8zjhIqllOab2/bisZZNdJyBYaMK6WzgD/87m9A7VEr7vo3XaI03lbrJ1
         Zohw==
X-Gm-Message-State: AJcUukeIjilI2etOA63cetopUROn4VJ/F1C0eBYqwwfw5kYjIm/FOM9Q
        EDg83qISJ893TeZFx0cCh6jkVw==
X-Google-Smtp-Source: ALg8bN7fmwtR9OElthFN+Ufvpq5laXZGEELE7MMzgx1zJKecNp8Zru3tELzyFuRE8JXZJCstrZmrIA==
X-Received: by 2002:a0c:f8cb:: with SMTP id h11mr15835493qvo.134.1547243544107;
        Fri, 11 Jan 2019 13:52:24 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id m81sm24161384qkl.92.2019.01.11.13.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 13:52:23 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 11 Jan 2019 16:52:22 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Peter Zijlstra <peterz@infradead.org>
cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf: rdpmc bug when viewing all procs on remote cpu
In-Reply-To: <alpine.DEB.2.21.1901101500030.3717@macbook-air>
Message-ID: <alpine.DEB.2.21.1901111649580.6487@macbook-air>
References: <alpine.DEB.2.21.1901101229010.3358@macbook-air> <alpine.DEB.2.21.1901101246340.3358@macbook-air> <alpine.DEB.2.21.1901101500030.3717@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019, Vince Weaver wrote:

> On Thu, 10 Jan 2019, Vince Weaver wrote:
> 
> > On Thu, 10 Jan 2019, Vince Weaver wrote:
> > 
> > > However if you create an all-process attached to CPU event:
> > > 	perf_event_open(attr, -1, X, -1, 0);
> > > the mmap event index is set as if this were a valid event and so the rdpmc
> > > succeeds even though it shouldn't (we're trying to read an event value
> > > on a remote cpu with a local rdpmc).

so on further looking at the code, it doesn't appear that rdpmc events are 
explicitly marked as unavailable in the attach-cpu or attach-pid case, 
it's just by luck the check for PERF_EVENT_STATE_ACTIVE catches most of 
the cases?

should an explicit check be added to zero out userpg->index in cases where 
the event being measured is running on a different core?

Vince
