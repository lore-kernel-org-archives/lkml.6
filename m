Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C52CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C30208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="GX/Xho8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfAJRu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:50:56 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:34590 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbfAJRu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:50:56 -0500
Received: by mail-qt1-f169.google.com with SMTP id r14so14326320qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=AG6V4lRzJB107s+d99RRgxHAzIRM6UdIwyiG3MNrIGE=;
        b=GX/Xho8Zvxg8LB0OqwvGMI/+gjIWobqV5CbVTN/R9p/CliA/KjJ0i2ymVGlfVbHDOU
         Bw47V5F3hbtkfvTI8YRAHKlc7tDum4MSKw1Xd4GCNOyCnp74Fp8jD/rjupVCZNreuA7H
         2Z34d+zea62sx4mbK3GEBaZ99nooxQqMVrnXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=AG6V4lRzJB107s+d99RRgxHAzIRM6UdIwyiG3MNrIGE=;
        b=psUhb25sWNU/Nl/+Y2dswBbfNAUxhmIsE8WMMWd9EuJtxWAE9rtJokc11dP+RV6DX7
         8BrB5Lfi4cdCtL7b9wqR24glxOFlpl0rNHP3BEN9N/cLsp6W/xWwGUvuL6NXkbb11TBq
         Nl9qG+cnBlaBpqR6jccfGWmcKfZFQSkZSf+J1JpOp4HFs1igp8Gx+u3XCoD37Rvmc3+5
         yZ26/Vcz7WbfxXPHvRd5Vk4k3/U02C5BFVwq7nWKId3x0sH2+aiTrwUvCvqVWnY9PaZh
         6mN6kckhxdPvhvYNBFX840mEvxQpZJ73ILH5lpQCViGEbGA35YkscDZjoC9LnuwDGDKU
         DKZw==
X-Gm-Message-State: AJcUuke5tgQePwM7+wncIjrylUJFFSwXuOkMCL2MgESTNNscH0eWb6qW
        YqGZC9P6ZIQH31NjShlqLq79MQ==
X-Google-Smtp-Source: ALg8bN4Y8pgCs+29qHtJTTbwblAAS05maY0Ai1RmkKcKihy3aql7ArjmEm+PhT992w3NTj74yWTfFg==
X-Received: by 2002:a0c:d2f7:: with SMTP id x52mr10710778qvh.35.1547142655542;
        Thu, 10 Jan 2019 09:50:55 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id z8sm45990322qth.34.2019.01.10.09.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:50:54 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 10 Jan 2019 12:50:53 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Peter Zijlstra <peterz@infradead.org>
cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf: rdpmc bug when viewing all procs on remote cpu
In-Reply-To: <alpine.DEB.2.21.1901101229010.3358@macbook-air>
Message-ID: <alpine.DEB.2.21.1901101246340.3358@macbook-air>
References: <alpine.DEB.2.21.1901101229010.3358@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019, Vince Weaver wrote:

> However if you create an all-process attached to CPU event:
> 	perf_event_open(attr, -1, X, -1, 0);
> the mmap event index is set as if this were a valid event and so the rdpmc
> succeeds even though it shouldn't (we're trying to read an event value
> on a remote cpu with a local rdpmc).

For a test case, try the
	tests/rdpmc/rdpmc_attach_other_cpu
test found in my perf_event_tests suite
	git clone https://github.com/deater/perf_event_tests

I can trigger it with current git on an intel machine, but not on an AMD 
machine.  Possibly because it is defaulting to one of the fixed counter 
slots?

Vince
