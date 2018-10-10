Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C79BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC16E2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3nXxpGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC16E2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeJJWw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:52:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33964 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJJWw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:52:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id o17-v6so6133962qtr.1;
        Wed, 10 Oct 2018 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i8iEAIHLbO9bLrDqEHJNt+SfqHalCg0oFqROqkdt32s=;
        b=p3nXxpGXwOookxGsAz4Ke7xwqXiRXUtW8pafDRW0UtZHS9tUQ+iY0CeCbTt7DEccKr
         rlfuB1kFG6fsRMyNsuCNV6zO9jL2u2nX2UNSRf9Gb08m+lfDYpRFw7U78zPekOSdO2SJ
         IjXm6lUhLeiWdQaoamEBbBlq5oYKcP2xr+/h6xGx7tui5wLQb3DR9qpOz6ifmjvySTRs
         LQ1TcdqZHNAyYjEUrBeDKFzN5aUWtypvAWu9sgo57yNWixKzpA2uIDwxuZ74Y68ahE8X
         vTXnNayHiFJm6snjSiGRX/ggC8BqGNgg5skgcZUapX5RyITcOFI6KDLU7NZ9SqfW8iUy
         w3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=i8iEAIHLbO9bLrDqEHJNt+SfqHalCg0oFqROqkdt32s=;
        b=Ii79i3vw59vPjWS2G+aVEe0qISGmPLnXz0dAN+iPwMzkh26cjKXd/Imz1yedjhbFgU
         wzmmN+VTXV3d56wBCSxEYxwI8oV/pwYy1Zwp//UhUppteFgh5tiZkGHL7nYBoRJJavwY
         zkX7EGbl9HLf5qIqZ6Ljtdr4BEO6l7EIp93UqY7Xef0So/ancfwr0wpJ0DHmFYl0jJl0
         M5RFBg+p5tmt6RjT4nQVMpiukx4oPnINPTShT26jAvsSFb2yvE3mMpply63C/CIfdZRh
         p3CN0l3SWT45Z5/4wMgVEJZFWEjMTVvG1FbF9kRqPiYAcjrqkSWWV1pEuqeHi1ttmH5x
         h1aA==
X-Gm-Message-State: ABuFfogrizFveBwd5XKzNepjr/KUTRG99nGoI/GTc/UBYs5aopd8bSCV
        kWHGTSQNzNPDGKmU6dvSeqE=
X-Google-Smtp-Source: ACcGV63NfdcvgIzWA8hSdc0NyiWrNJTSWJC8dGsWlYL6/llw0Tj549/9UfuWdwTmawz3JTwgrunB9g==
X-Received: by 2002:a0c:f042:: with SMTP id b2-v6mr26733949qvl.232.1539185416864;
        Wed, 10 Oct 2018 08:30:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::6:78ae])
        by smtp.gmail.com with ESMTPSA id 128-v6sm11313864qko.7.2018.10.10.08.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 08:30:15 -0700 (PDT)
Date:   Wed, 10 Oct 2018 08:30:11 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
Subject: Re: [workqueue/driver-core PATCH 1/5] workqueue: Provide
 queue_work_near to queue work near a given NUMA node
Message-ID: <20181010153011.GM270328@devbig004.ftw2.facebook.com>
References: <20181005183239.8790.28631.stgit@localhost.localdomain>
 <20181005183406.8790.70621.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005183406.8790.70621.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> +static int workqueue_select_cpu_near(int node)
> +{
...
> +	/* Use "random" otherwise know as "first" online CPU of node */
> +	cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);

Maybe we wanna round-robin within the node?

> +bool queue_work_near(int node, struct workqueue_struct *wq,
> +		     struct work_struct *work)

Can we name it queue_work_node() to stay consistent with numa-aware
memory interface?

Thanks.

-- 
tejun
