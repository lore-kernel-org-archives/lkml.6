Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8944EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424FD25C88
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424FD25C88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934902AbeFYPVA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:21:00 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:43520 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbeFYPU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:20:58 -0400
Received: by mail-yb0-f194.google.com with SMTP id g3-v6so3313416ybf.10;
        Mon, 25 Jun 2018 08:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q+hPqOVJZNiksjOzh0iI563O0ZNNigWbaSygipBy0Tg=;
        b=cQbURxwgG4vnYdaruAcOMj0NVhYxMgIt5I26ceajoNhe0UvBE37epUJo1wg8nH0wVI
         KkvuAnoqOqxBwKFTCbdht3vTWNJwl1ZaYOC0THcVLgNd4VHSrdWjkW/MPPDJnZHpPGKp
         3j6cakT7IzDvJjC8FpsAyd4LreBe0w16GPJY+ovijCMXWMPEfKnn9FU22syroZKPBHrx
         hg96ziYZLh9mpBwpYs6czd5aDYQxVAYHdeatNpK66iCZYY54ZU8gEb136kxAivkwvGkj
         e5Th79/hEVQBCpNAH5y/lmkXY6spFJEN99lYeO011aRdWKyFHCFOYnrvqKCkSJEEMfwc
         BuzQ==
X-Gm-Message-State: APt69E0IZqvw9fMJLjU1QJJeZOyy+hMa++gBQ33ayUrIqYnWAP7Aoygz
        FtW/V6YbHULjpOZFm9q8iDIfJss=
X-Google-Smtp-Source: ADUXVKLATUuvPyQ6nXj4SWLzT/3hqxgh44S+uI8pfS5iu0cNa1rxoj3ifaGgYHeEbJZT5lK5rARHfw==
X-Received: by 2002:a25:404b:: with SMTP id n72-v6mr6333970yba.428.1529940057841;
        Mon, 25 Jun 2018 08:20:57 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id y4-v6sm396911ywf.70.2018.06.25.08.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:20:56 -0700 (PDT)
Date:   Mon, 25 Jun 2018 09:20:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH v2] drivers: base: initcall_debug logs for driver probe
 times
Message-ID: <20180625152055.GA23270@rob-hp-laptop>
References: <20180621003556.65578-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621003556.65578-1-toddpoynor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 05:35:56PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Add initcall_debug logs for each driver device probe call, for example:
> 
>    probe of a3800000.ramoops returned 1 after 3007 usecs
> 
> This replaces the previous code added to report times for deferred
> probes.  It also reports OF platform bus device creates that were
> formerly lumped together in a single entry for function
> of_platform_default_populate_init, as well as helping to annotate other
> initcalls that involve device probing.
> 
> Remove restriction on printing probe times only during initcalls, since
> initcall_debug now continues to show driver timing info past the boot
> phase.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/base/dd.c | 50 +++++++++++++++++++++--------------------------
>  1 file changed, 22 insertions(+), 28 deletions(-)
> 
> Changes from v1:
> * unsigned long long -> s64
> * use ktime_to_us() instead of ktime_to_ns with shift
> * print probe return value
> * drop code that stopped output on end of initcall processing

Reviewed-by: Rob Herring <robh@kernel.org>
