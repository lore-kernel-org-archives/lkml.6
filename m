Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F216C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC47217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390168AbfBRQt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:49:57 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36244 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfBRQt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:49:57 -0500
Received: by mail-qt1-f193.google.com with SMTP id p25so19630572qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 08:49:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1KF4cWLuZSrWs0pIbc/fe56fXH4h3PVBY4eBUKkxDcs=;
        b=AUbEDgITm4INu8K+HJE4/2kyljk7Asbm9CqFZDsc4YfInVkD0bH7tqqRSokLQeaC4q
         OIbIRyRerFtLD+lgdH0IEwiTmO8g4B+6LBsWvii0JKblZ+vluF/2pFF5h84Ksz8ZQ1Fz
         W5vclb+VOoXU8oP69wNbCChcY6iAKyDywQTbwhXGkzpJWdAfrJYuf0OCv34Terwf3bWW
         mQWDyRAZF2s3GfH9WBJ7zaR/vCQ5X5Ak/0wPaGBT+nwf5aUpjF30hM6k6nbJkOZ399VK
         yy4Uq8pWSBjH8wM7L5rwMuu5uvXc37AiFUmbRtgFQHLnQYYyCU0lW74/vl7vLEYi81vj
         dURg==
X-Gm-Message-State: AHQUAub2ozTxea+95MK/VLmFIUEMKjRxeO/oyj6T54dGSW7ZyAhQRWTO
        Ux0p68tedQxo35zFKHVFXBt3NA==
X-Google-Smtp-Source: AHgI3IZEUAQWaMgS4TmrCSg8g3Pxrkywm/dVrWGPsltVA2gjGpgMc/eBYcCUJG50OEm8buVM3PJVmw==
X-Received: by 2002:ac8:365a:: with SMTP id n26mr8714353qtb.18.1550508596281;
        Mon, 18 Feb 2019 08:49:56 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id b24sm8393870qta.76.2019.02.18.08.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 08:49:55 -0800 (PST)
Date:   Mon, 18 Feb 2019 11:49:53 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
        yang.zhang.wz@gmail.com, riel@surriel.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Message-ID: <20190218114601-mutt-send-email-mst@kernel.org>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 10:40:15AM +0100, David Hildenbrand wrote:
> It would be worth a try. My feeling is that a synchronous report after
> e.g. 512 frees should be acceptable, as it seems to be acceptable on
> s390x. (basically always enabled, nobody complains).

What slips under the radar on an arch like s390 might
raise issues for a popular arch like x86. My fear would be
if it's only a problem e.g. for realtime. Then you get
a condition that's very hard to trigger and affects
worst case latencies.

But really what business has something that is supposedly
an optimization blocking a VCPU? We are just freeing up
lots of memory why is it a good idea to slow that
process down?

-- 
MST
