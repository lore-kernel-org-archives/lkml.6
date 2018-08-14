Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D6DC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEE92173F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+zgB2Lp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEE92173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbeHNNtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:49:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51876 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbeHNNtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:49:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so11844774wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 04:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=V2/3s6cngq773nz4wBqlSj0xFtVMDhstUrAzj65tRUg=;
        b=d+zgB2LpIWQldgqrhyDyywvjJh48ery13MtSZOWsO+dxGKcy7R6I3JjJsSyPYwTOP9
         SqCX5tdklroWVNDtk5TTHKYIdUcZhfNbbQzS1QrEKNqo9Kgv1HNZAIaNCuJojMYGcoJ/
         CPSQ1s2Mz+SwrqMZkTuO3rxcE5r1tbFC0O8RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=V2/3s6cngq773nz4wBqlSj0xFtVMDhstUrAzj65tRUg=;
        b=thseUmSQB005jSIezf4Ui8OOPhGUx3JOZz9asiKmbk3D7cUpixuJPN+GN3PJhHPnIf
         9LGoRHgFtEslAOH86PfNanKkbQ/MuoDpnnDvpTVy7Y4CQrI9rUcwqg8A9rM6kvNDrfHs
         yj24NWKk0VskSWcbxkxRI4OHGcUCd49TaoxCbYCD3P6jHuA6Wew3X19XSCSX6u7X5oIH
         /A0BNn+wdqbefyha+V7NJoUBfgpOI8KrzbnZGcJdwdcWDL7LMBj50oy5YMbcqlWPonzl
         KexUdlOkoqsdooaYL1gsLWBwUu3uIaDznFsazrnzP0o0z1ZFs1WoT8UMAqcxM93MY4PK
         tDCA==
X-Gm-Message-State: AOUpUlHllKhPnhPgV8qnFIb+4uz3+ueKQkiBaOtFzyQoQN0FJODT0/9N
        yLyq8QKJjbdbTLAM5BCjX44thA==
X-Google-Smtp-Source: AA+uWPy3Ub52LyZD3pken6aMEXiEiyXhSaTIKyVdXah5pIrZbxJQg7cTuJ4mcz459Jx04XntNQ/VNg==
X-Received: by 2002:a1c:3743:: with SMTP id e64-v6mr10204546wma.63.1534244544109;
        Tue, 14 Aug 2018 04:02:24 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 132-v6sm2113487wmd.13.2018.08.14.04.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 04:02:23 -0700 (PDT)
Date:   Tue, 14 Aug 2018 12:02:20 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Joseph Salisbury <joseph.salisbury@canonical.com>
Cc:     ard.biesheuvel@linaro.org, mathias.nyman@linux.intel.com,
        gregkh@linuxfoundation.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] usb: xhci: Add XHCI_TRUST_TX_LENGTH for Renesas
 uPD720201
Message-ID: <20180814110220.brkfyjbtibuwzunx@holly.lan>
References: <703dd682-d740-d964-242d-43d8d26c8f87@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <703dd682-d740-d964-242d-43d8d26c8f87@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 12:13:53PM -0400, Joseph Salisbury wrote:
> Hi Daniel,
> 
> A kernel bug report was opened against Ubuntu [0].  It was found the
> following patch introduced the regression:
> 
> da9970668948 ("usb: xhci: Add XHCI_TRUST_TX_LENGTH for Renesas uPD720201")

I can see nothing in http://pad.lv/1773704 that indicates a regression
in this patch. How could there be? The patch does not not alter the
behaviour of uPD720202 devices (pdev->device == 0x0015).

 
> The bug reporter claims there is a typo in the patch that caused the
> regression.  I built a test kernel with a change to the suspected typo
> and the bug reporter claims it resolved the regression.  My test kernel
> had the following change:
> 
> -                       pdev->device == 0x0014)
> +                       pdev->device == 0x0015)
> 
> I was hoping to get your feedback, since you are the patch author.  Do
> you think this is an actual typo, or maybe there really needs to be two
> quirks?

No, it is a not a typo (and the change above *does* introduce a regression
;-) ). From this git logs I believe that:

  0x0014 -> uPD720201
  0x0015 -> uPD720202


Daniel.
