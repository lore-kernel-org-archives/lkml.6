Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0558CECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D2620831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWjT7thn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D2620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeJYDUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbeJYDUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:20:05 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E02EC20834
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 18:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540407053;
        bh=rctWxg59tlU08TpLA4ZQSwL3ZtMAEx1lIshn+sbH+Y4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kWjT7thnePojpiiOjfY+KTe56aAFahI/+ihS8y3t90ZrbHjcUeWUyNsLaOfTYCqtI
         kdn8gN6UqRocnNuXrDodsqJfRDsFyBi1U7MlT4728dzK9pUMdv8FXNnyqJZi1GxUgj
         m7D/ApTpeot3U5rROFWlSZiCMqYIrO1ZQy01jfCU=
Received: by mail-wm1-f48.google.com with SMTP id w186-v6so6466559wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 11:50:52 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJfcYgB9Oo3iveb2/K+erNzhEig75O5gRhkFtrwF7tXTg7fDzAt
        vVAXf6lWzmYd8X597O1qJcT/cD/jzpcGsntGFGpJCw==
X-Google-Smtp-Source: AJdET5fRMEegEytgBVwQxgT//g/lC/nzNQk8iULTcsLPoi0UH8kOjJG+ZE1rOGv/1rOd0d6fkdpxYfhwdz+uPV1kC8I=
X-Received: by 2002:a1c:9355:: with SMTP id v82-v6mr3899423wmd.128.1540407051398;
 Wed, 24 Oct 2018 11:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181023184234.14025-1-chang.seok.bae@intel.com> <20181023184234.14025-2-chang.seok.bae@intel.com>
In-Reply-To: <20181023184234.14025-2-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 24 Oct 2018 11:50:39 -0700
X-Gmail-Original-Message-ID: <CALCETrWpwhe1ioxp_E6HOz1TQHOOat2pcGjGev2_baqsjvjagA@mail.gmail.com>
Message-ID: <CALCETrWpwhe1ioxp_E6HOz1TQHOOat2pcGjGev2_baqsjvjagA@mail.gmail.com>
Subject: Re: [v3 01/12] taint: Introduce a new taint flag (insecure)
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 11:43 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> For testing (or root-only) purposes, the new flag will serve to tag the
> kernel taint accurately.
>
> When adding a new feature support, patches need to be incrementally
> applied and tested with temporal parameters. Currently, there is no flag
> for this usage.

I don't object to this patch per se, but it seems unnecessary to me.
Especially since, once the whole series is applied, this code is again
unused.
