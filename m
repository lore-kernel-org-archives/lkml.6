Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D79C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD3120831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jX6Rw3By"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD3120831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbeKSWYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:24:55 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38974 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbeKSWYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:24:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so22602987edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 04:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=angNVikouVV1hQggHvxAxK1U/spjX2MVCqjysxUeeGE=;
        b=jX6Rw3ByAgzHKKf+9V/k82nuOuQkZv/gx2z2SEO4L/kWRsjiH1X1hX8F1lgqdLRQsP
         +PGyJ55/Mk/EkHkHIpiu5k7C5H+bImYMqxe0kt8eTBLV8JuoIPOW7bujewHrIWv/3//J
         ty6V8zeHZOsusbiYg8Qz2A9rTaoWGEcCe+Ozo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=angNVikouVV1hQggHvxAxK1U/spjX2MVCqjysxUeeGE=;
        b=aTQLAW6BMLCurJTfd5OvZHT+eWeKZszPAAiB/wE8jhEYyCCwmiDlVJdsc4kMpnMUcb
         RKMBsj1ISPoFQ+sdPea05V0C8W9Cs9MduFt8Z8HF5hwXQG+YxvbB98E1+S8Sp+GTQZZl
         goRQAGgQoui4L1D06ODBGJSvKZJgPX4OairGfjyDS9bwrYFpr2kaVWwsdQN9C1/P/d1H
         CcCOtmonC6Z9UBXXj3iZtE9UVMSMR9VLxsdFrDn7kymyLWRHZMWgY+fF8EwC1oC7ARFe
         7GgbOkK7ZVqox2biEuepZbcAAAx4VRglh2Z4nohc1Kiq3XEEfKTsR2KoorWCXEstIt32
         dq6g==
X-Gm-Message-State: AGRZ1gLa1ysrK8b5wUtyhDP92Y3K98IKt0Swl0i12mdoBXr5tvytLGnh
        cVNmiwfaGVBTnNbr9EPxOKtRJA==
X-Google-Smtp-Source: AJdET5dDlcglUXu8AKlZtkX3P2sZOxA1OhqdXkFXpUzGb6+icZ0QsxRnP5zKVasWMrPzqBMFrwrawA==
X-Received: by 2002:a50:b54e:: with SMTP id z14mr19398260edd.239.1542628888987;
        Mon, 19 Nov 2018 04:01:28 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id x38sm4036758edx.24.2018.11.19.04.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 04:01:28 -0800 (PST)
Date:   Mon, 19 Nov 2018 13:01:20 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tools/memory-model: Add SRCU support
Message-ID: <20181119120120.GA5092@andrea>
References: <Pine.LNX.4.44L0.1811151101310.1308-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1811151101310.1308-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:19:24AM -0500, Alan Stern wrote:
> Paul and other LKMM maintainers:
> 
> The following series of patches adds support for SRCU to the Linux
> Kernel Memory Model.  That is, it adds the srcu_read_lock(),
> srcu_read_unlock(), and synchronize_srcu() primitives to the model.
> 
> 	Patch 1/3 does some renaming of the RCU parts of the
> 	memory model's existing CAT code, to help distinguish them
> 	from the upcoming SRCU parts.
> 
> 	Patch 2/3 refactors the definitions of some RCU relations
> 	in the CAT code, in a way that the SRCU portions will need.
> 
> 	Patch 3/3 actually adds the SRCU support.
> 
> This new code requires herd7 version 7.51+4(dev) or later (now 
> available in the herdtools7 github repository) to run.  Thanks to Luc 
> for making the necessary changes to support SRCU.

Thank you Alan, Luc.

My only suggestion is to integrate changes to explanation.txt (in part.,
Sect. 22), which the above renaming and refactoring make out-of-date.

For this version,

Tested-by: Andrea Parri <andrea.parri@amarulasolutions.com>

  Andrea


> 
> The code does not check that the index argument passed to 
> srcu_read_unlock() is the same as the value returned by the 
> corresponding srcu_read_lock() call.  This is deemed to be a semantic 
> issue, not directly relevant to the memory model.
> 
> Alan
> 
