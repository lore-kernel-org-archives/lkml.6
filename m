Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D7FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEDA208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="GEqBY4dV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbfAJRfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:35:18 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:34160 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfAJRfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:35:18 -0500
Received: by mail-qt1-f171.google.com with SMTP id r14so14231451qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=o6qUe06YqHQTyRo2Af+8txW+aEDBqL66YmFXoMwGjWY=;
        b=GEqBY4dVG+au7h3k/qeJtwlrSHRQVwvvL8SNGbzFHpTIjV/L+A5Q5MO1qQQaFeJ0LP
         ic/6GDzq7YTh6JL41/+Wl5kAcuV8F5TPt6gePdCguJR0lCVxqaqH6HtKS15stiQjBaH7
         KilDG+BKe9FIn9pPQskziEn5ZjqqNbXn/YRqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=o6qUe06YqHQTyRo2Af+8txW+aEDBqL66YmFXoMwGjWY=;
        b=eLyaZHN1FFsqOfKftuoBus6IO5WbSZmCYsMH048rMdsgb73svjStCdwLDgQ84GT1Rr
         vzDJRBseMmSWE/N2o3Z18HIykZHBM+hb4v4EWcOTarirswVLR4NxVEEDb+lVgHrVyYKC
         YJGwUfyzyDNOZLYtIzZNsJceOx2YP4S5H2z1PoU7xwX5eyi/9P/OumWd+aYEgURRVSU9
         PtrA9GUYQJh1erOjvsTRzpGb1UKgKWaiA0U3lVwEy389Nz7o6s5My+TXaMwYmSiZOeLK
         zU0y8LPmpQXCUj4pGXPEvReBB+FIBGvi6zoHlLNCoLa0ofc02575X8MZSk12HACYaVoF
         Ctwg==
X-Gm-Message-State: AJcUukcWfJc+g+lbbvSvnhVbXDahb6pFq7aXl/QJFM/OXF7MBLzYN92P
        etRAHbvWYDX3KsYf9gW5QuTMtTWLgv8=
X-Google-Smtp-Source: ALg8bN79yTwUrpkaMk/Ms3uOWZrPL64HNL3WdCZSJJduEVyFIGbu1xbldIRyI6UgnGp0RRMI29eREA==
X-Received: by 2002:a37:8107:: with SMTP id c7mr9698660qkd.77.1547141717041;
        Thu, 10 Jan 2019 09:35:17 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id y4sm44959932qtc.47.2019.01.10.09.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:35:16 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 10 Jan 2019 12:35:12 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Peter Zijlstra <peterz@infradead.org>
cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: perf: rdpmc bug when viewing all procs on remote cpu
Message-ID: <alpine.DEB.2.21.1901101229010.3358@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I think this is a bug turned up by PAPI.  I've been trying to track down 
where this happens in the perf_event code myself, but it might be faster 
to just report it.

If you create a per-process attached to CPU event:
	perf_event_open(attr, 0, X, -1, 0);
the mmap event index is set to "0" (not available) on all cores but the
current one so the rdpmc read code can properly fall back to read().

However if you create an all-process attached to CPU event:
	perf_event_open(attr, -1, X, -1, 0);
the mmap event index is set as if this were a valid event and so the rdpmc
succeeds even though it shouldn't (we're trying to read an event value
on a remote cpu with a local rdpmc).

so I think somehow in the perf_event_open pid=-1 case rdpmc is not getting 
blocked properly...

Vince

