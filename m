Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FBAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7356420865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgtqcP1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7356420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeIKBpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbeIKBpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:45:05 -0400
Received: from mail-qt0-f169.google.com (mail-qt0-f169.google.com [209.85.216.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7796620865;
        Mon, 10 Sep 2018 20:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536612553;
        bh=qXybzrn47r2UwyUE/7E1D73V+iIG0bGVkgw9Jn9KH88=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VgtqcP1wPYW11FbZIbig7wepKD4wAd+vxUeJH9XU8N3QvLuu+CgPPMhg3/OEIhHA6
         dqyI9WaGtXkpEnKXr74YOEwLT5LOBIC+YKH1Q6aMRJ7sDL8PJ+0Z1TDmZplimG+i5s
         8XxurTik/b2YpxDZe5hosw/MOmH/Q0wNzWiWecOw=
Received: by mail-qt0-f169.google.com with SMTP id l42-v6so590886qtf.13;
        Mon, 10 Sep 2018 13:49:13 -0700 (PDT)
X-Gm-Message-State: APzg51DDXg+ZXeCIIkT4zpnqyqy7d/6wpej6zcdEm+Yb+VLpfj+/s7NZ
        XE9yT/HDG2ozL4sRvRgJrjw6slzrEtqQYnjE/g==
X-Google-Smtp-Source: ANB0VdZvBcqr7DHVc8tHGdSvjDxprKgGHvPlC10mb1bkQ9eIkHiYagj8VoksLLlcSJS7eoHJcUdseItgaOwwpRHdOI8=
X-Received: by 2002:a0c:e9ce:: with SMTP id q14-v6mr16313165qvo.106.1536612552531;
 Mon, 10 Sep 2018 13:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180905193738.19325-1-robh@kernel.org> <20180905193738.19325-9-robh@kernel.org>
 <8b227f8c-f351-18da-b55d-e8979281f510@xilinx.com>
In-Reply-To: <8b227f8c-f351-18da-b55d-e8979281f510@xilinx.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 10 Sep 2018 15:49:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKWy8dmfF2zCAsEVkDdFM14niKtapqnR_K45Kr3-mZhqQ@mail.gmail.com>
Message-ID: <CAL_JsqKWy8dmfF2zCAsEVkDdFM14niKtapqnR_K45Kr3-mZhqQ@mail.gmail.com>
Subject: Re: [PATCH 08/21] microblaze: get cpu node with of_get_cpu_node
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 9:56 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 5.9.2018 21:37, Rob Herring wrote:
> > "device_type" use is deprecated for FDT though it has continued to be used
> > for nodes like cpu nodes. Use of_get_cpu_node() instead which works using
> > node names by default. This will allow the eventually removal of cpu
> > device_type properties.
> >
> > Also, fix a leaked reference by adding a missing of_node_put.
> >
> > Cc: Michal Simek <monstr@monstr.eu>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Please ack and I will take via the DT tree. This is dependent on the
> > first 2 patches.
>
> I have tested it and it is align with the spec and all dtses generated
> before 2015 will work without any issue.
> In 2015 new device tree generator was introduced and it is not adding
> reg property to cpu node which is required by this change.
> This will be fixed but that means that all generated dtses from 2015 are
> affected.

Patch 2 was supposed to handle that case. However, it does expect that
there should be an #address-cells equal to 0 in that case. Is that not
a valid assumption?

> That's why will be great if you can also change that pr_err message to
> mentioned to also check reg property to give users a chance to fix it
> properly. Error log below.

I don't think breaking users is good.

I could make this a find by path (/cpus/cpu) instead or just drop it
for microblaze. It doesn't really affect my plans for removing
device_node.type ptr.

Rob


> Anyway here is my
> Tested-by: Michal Simek <michal.simek@xilinx.com>
>
> Thanks,
> Michal
