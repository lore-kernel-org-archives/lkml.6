Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38407C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0412F20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Crwq9fHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbfAPWOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:14:24 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:34531 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732666AbfAPWOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:14:23 -0500
Received: by mail-wm1-f42.google.com with SMTP id y185so2115600wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 14:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TjmBWavRoT6NZg7djeTl9O5w8CKm06oyg1WxPg2yiOo=;
        b=Crwq9fHqHOPNtZwjMsazILH00UR1mMaA14O82zFatjOs1v8cZ/TMMIy7nDC0O/3kMn
         XPKg4GhybgzXmuuLOyorpDNXzdj2w8NMdgAFK2I3AAFcsf81fMQ7R+YMrj0Ker/kzmhD
         60lwzqnxF1DbhhVwlj6aSwlaRzsEhJfwBmmck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjmBWavRoT6NZg7djeTl9O5w8CKm06oyg1WxPg2yiOo=;
        b=a2bIALV6CNBRj7knUpHD7rKo07CXHAwT+uVdtp2SzwNof5boyYqrZmizDhz/GBb60x
         f3Z69wu9itm7zQC27ZcS6HtaLPURzLLzzVqior9eJaaDutxsIVDbOvwsMq+POJbct9Pi
         hP1KNhvuiUaN8IXbcQwHvcB3LftILCCDI4fOAT5SMVRPuABmb/gep+HvSw4YOaq81W04
         i4XeZ+R1jOJFhZtHRdhH8L7H/v0zrgtGOYvTtfHxK4KXbe5RFIi5rizQS9l5QDpoZPRP
         BWXYs9wZ0SjCyPNrNkGac8p6UCvUDuuzeJYfDEHJxBbe4C3SmD6Vg1MhRGDvFH4hob/2
         ARnA==
X-Gm-Message-State: AJcUukfzkgJkFisCEaMB5PJiKAs4zcDlTvOPyD2abHzlsvaFDMqZOz9j
        e5ZOM7iP5nXEFhNByeP+wtTYsuPwakwD12g5I+CQVQ==
X-Google-Smtp-Source: ALg8bN77sOFDjC61WIa+XaIoyfoORbzZn+YOBYxme/nJuV6z6UMJEObNjAugVlDf/gyywmGijEn0LuHMbK+bio59Z8U=
X-Received: by 2002:a1c:6657:: with SMTP id a84mr8645694wmc.23.1547676861165;
 Wed, 16 Jan 2019 14:14:21 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLURfQcSy2w7F7NCPtGaChka4U5LmvufLd0VZ73S=AzHkA@mail.gmail.com>
 <SN6PR04MB4925CA2AFE5F060469E6F018FC850@SN6PR04MB4925.namprd04.prod.outlook.com>
 <20190114032444.GA124121@hisi.inhuawei.com>
In-Reply-To: <20190114032444.GA124121@hisi.inhuawei.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 16 Jan 2019 14:14:09 -0800
Message-ID: <CALAqxLXhR2Fny4L4wqEHnZ+w0ktTp=ntvxuPU8h-vLwZW51k0Q@mail.gmail.com>
Subject: Re: ufshcd_queuecommand() triggering after ufshcd_suspend()?
To:     Zang Leigang <zangleigang@hisilicon.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>, Wei Li <liwei213@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Evan Green <evgreen@chromium.org>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 7:25 PM Zang Leigang <zangleigang@hisilicon.com> wrote:
>   I think there are two different issues:
>
>   1. clk_gating's state(including state's trace event) and is_suspended is not
>      wrapped by ufshcd_is_clkgating_allowed which Hisilicon's kirin platoform
>      soc does not need but is set and checked in a regular path.
>   2. I think SCSI is necessary to block queue to stop sending to ufs after
>      system suspend or, add a new state for ufs like UFSHCD_STATE_SUSPENDING
>      or what else. hba->is_sys_suspended is too late to stop ufshcd_queuecommand
>

Hey Zang,
  Thanks for the suggestions. I'm not sure I have enough context to
try to come up with a patch. I'll try to take a stab at it, but I'd
appreciate it if  you have any more specific suggestions or patches
for me to try. :)

thanks
-john
