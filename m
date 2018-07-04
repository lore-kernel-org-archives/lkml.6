Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE965C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CB823E3F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RBlpq9hO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CB823E3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752889AbeGDOn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:43:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36165 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752615AbeGDOnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:43:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so6110474wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9cR5vFosKf4pOYy2kLbnrG5yXGupQHRfZtmrhhqsd9A=;
        b=RBlpq9hOfSzNZvTMBVSfBUQhfc8ADKA+9DfrOXTxZxxqYvGzQ2J04tHLnSyRy2ej1c
         LAsqUUOG5x9npjPxQtXh9aUghef4aQ+stg9Zy1hDJksxjRj7qos2wlApHQCP+doPaPwA
         0mCrozk4M64pCd9rpAByknUSOW7JIi6GM+w9X85mOnn51ndV9BNrSxbo2v4Yrs8aKehW
         017J349Qkm7hJ1bxVio2Cl+m99vcJXyO+kBtXY9Dc+ETcYmqIEks+uJqW2oaTwlGKxjj
         oRag11INxpYd8zwT2rpRco7CckaMCtm7qIwGzkaiHK5VfTyVOhmD3nC/NVGhPRgrItsI
         L3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9cR5vFosKf4pOYy2kLbnrG5yXGupQHRfZtmrhhqsd9A=;
        b=jXHcI7wc94KMH/cxTMNIO80wfCEFQGpaHyKIf+UMiU1sEw9sLokM9/DRdZpCe/BlN2
         v0Q+AhSNPlji7p1xZlorOH3j8lAFU/z823sstJXRKclSCidKb8q9pwWcIR5PPeotH9D6
         gpLYsfTCBxD4cO75b1mPJY727xaXYo1bDLWBHZTdNJYdU+7Cb9ACS7Or14V3jnSbLAYv
         ITET3Jsnq40oNAwgaLp8sS25RUloNLRXJtuG+R4De1gXHOcZyrWWM2B3tmr9ikw0I0SC
         pGIxKN6uCYyazVVOGbcTpZy/epB3yUwlFCIJXfWGMX8DP2B3MszaOoV/QictpZ2Wb95+
         L9PQ==
X-Gm-Message-State: APt69E29OThbVLBuRaPorGxjVkfgZB21IUgR+s9O1rLlLwz/UZPr+z0A
        no9nr2dUI8EQfs2SXouT+I4m2w==
X-Google-Smtp-Source: AAOMgpeJti9qGdl+M+nmJCZlrs1hNKNzKLLIzMDpteWZpebtGo+hvrUk64aK2UFGwEru9cDI5pbUTg==
X-Received: by 2002:adf:a015:: with SMTP id k21-v6mr1819375wrk.202.1530715430239;
        Wed, 04 Jul 2018 07:43:50 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 77-v6sm2350695wmq.22.2018.07.04.07.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 07:43:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1faj0S-0007qF-Vc; Wed, 04 Jul 2018 08:43:44 -0600
Date:   Wed, 4 Jul 2018 08:43:44 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shirish S <shirish.s@amd.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Fix NULL pointer dereference in tpm_transmit()
Message-ID: <20180704144344.GA30037@ziepe.ca>
References: <1530695020-21888-1-git-send-email-shirish.s@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530695020-21888-1-git-send-email-shirish.s@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 02:33:40PM +0530, Shirish S wrote:
> During system shutdown,
> tpm_class_shutdown() when called with TPM_CHIP_FLAG_TPM2
> flag set, makes chip->ops NULL.
> 
> However tpm_chip_unregister() called later in shutdown
> sequence tries to access chip->ops in tpm_try_transmit()
> leading the NULL pointer dereference.
> 
> This patch fixes this issue.
> Below is the trace for reference:
> 
> BUG: unable to handle kernel NULL pointer dereference at
> 0000000000000048
> IP: tpm_transmit+0x267/0x565
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> ...
> task: ffff937c847fe580 task.stack: ffffa79f80b04000
> RIP: 0010:tpm_transmit+0x267/0x565
> RSP: 0018:ffffa79f80b07c08 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff937ca9bc8000 RCX: ffff937c847fe580
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffffff98e3cd40
> RBP: ffffa79f80b07c88 R08: 000000000001fff4 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffa79f80b07cd4
> R13: 000000000000008c R14: ffffffffffffffc3 R15: 0000000000000000
> FS:  00007ef31f747740(0000) GS:ffff937caed00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000048 CR3: 00000001243d2000 CR4: 00000000001406e0
> Call Trace:
> tpm_transmit_cmd+0x25/0x70
> tpm2_shutdown+0x69/0xa3
> ? __radix_tree_replace+0xd9/0x120
> ? idr_replace_ext+0x92/0xb6
> tpm_chip_unregister+0xaa/0xdb
> cr50_i2c_shutdown+0x1e/0x41

It makes no sense to call something like tpm_unregister from shutdown.

Jason
