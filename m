Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8FAC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D5B20824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D5B20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeJZBpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:45:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44162 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeJZBpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:45:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3-v6so4295301pgs.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 10:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V54atRZfQ9mgxs1Lv9O+di2ZH2zboFQaGnaiwMQvyb0=;
        b=NUF7HEPpfyv+rAFdAlXZn6EuOLH1j90BE36BNcndipnhuHcU2dR8IPJYVHS0yeHTpa
         0mlw15tGTSL7SG85fm4fEXOcTxWejng4wVkDvbN9csxHvEadv5boo1yrkHdtNkJCVxbu
         E1Oj9cZNlMMNJED7xFzmh43Y6J8mwEBEVyPN9+W6DKU1x/AsX/JNq/vgZfLYwdOBZ+dM
         Qc6dZ+Lxgoc9QP9RqI2jhCWyFnUmnPhvlkXMFjv0UGEq6TdfQI/uYzTJibfYgtFtYQgw
         JzJ1PViFCyw4x14fq7H3uAdpygiHgR2jAKcL5seQiI5AlUj3PFUKb4/AcZGSW8FMpRNx
         a98Q==
X-Gm-Message-State: AGRZ1gJ0NdNswZutdO28e6gIj3mOujFJzo5EqVpVstyWOm+sE/ziWilz
        JDUWUIX7PvlApjjhnWlwA7U=
X-Google-Smtp-Source: AJdET5ewxZRAvzTrH98ivHI6VqDfzRcWUcFoESvWWHDsiCfsaoAwWZ1Mq7L7MGOY0hteI10hynhhNQ==
X-Received: by 2002:a65:5b07:: with SMTP id y7-v6mr57590pgq.125.1540487514356;
        Thu, 25 Oct 2018 10:11:54 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id x73-v6sm19266847pfk.139.2018.10.25.10.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 10:11:53 -0700 (PDT)
Message-ID: <1540487511.66186.31.camel@acm.org>
Subject: Re: [PATCH 3/3] kernel/workqueue: Suppress a false positive lockdep
 complaint
From:   Bart Van Assche <bvanassche@acm.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "tytso@mit.edu" <tytso@mit.edu>
Date:   Thu, 25 Oct 2018 10:11:51 -0700
In-Reply-To: <2cebeb88640433ce473bc40f9a5c7e06d0661e4d.camel@sipsolutions.net>
References: <20181025150540.259281-1-bvanassche@acm.org>
         <20181025150540.259281-4-bvanassche@acm.org>
         <2cebeb88640433ce473bc40f9a5c7e06d0661e4d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 19:02 +-0200, Johannes Berg wrote:
+AD4 On Thu, 2018-10-25 at 15:05 +-0000, Bart Van Assche wrote:
+AD4 +AD4 It can happen that the direct I/O queue creates and destroys an empty
+AD4 +AD4 workqueue from inside a work function.
+AD4 
+AD4 So, thinking about this more, can you guarantee (somehow) that the
+AD4 workqueue is empty at this point?

In general, no. But for the direct I/O case this can be guaranteed. Please
have a look at the code in sb+AF8-init+AF8-dio+AF8-done+AF8-wq() if you would not yet have
done this.

+AD4 Do you know how to reproduce this?

The lockdep complaint in the patch description is easy to reproduce. The
way I reproduce it is as follows:

git clone https://github.com/osandov/blktests
(cd blktests +ACYAJg ./check -q nvmeof-mp)

Bart.
