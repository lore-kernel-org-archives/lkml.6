Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB411C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7020021564
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FCJuww/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7020021564
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeHWWVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:21:35 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41877 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeHWWVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:21:35 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so11061056oiw.8;
        Thu, 23 Aug 2018 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5NrqDvN7sUXxkgBkD5I+URLGpb862gT9/XcV7qJ2Yg=;
        b=FCJuww/UxfY5iasZ6sYDHQpTrSqOjeAkZV2KvwjHa5SMpF4XEgFV0DoIi5+RcxS9HM
         MQ714pZt3f4cUPck6qt/VaX2+F0Thz7wHA4oBCIrbMneAmoznNO389jCA9XTjjw4E/D7
         CHZhYh/nxMwNG4VRhMI9qtwZKo5Dk8rdUW2yJ8prgJb3kPaWPudIojx+P7/ngNsrEZ5/
         TfOrNQSGh0/2scN8DI/SPS/mGwt4v1dwY/OR2vKh3s0eDJGBI5ApO6dduCru3rMTrIoJ
         BHjLm+6uzSvA7K6IY1Qo1i33jkTTEgsR9xYYO7jUXXQQ9sNCcpgzc76hEZq0kjhdtvph
         /e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5NrqDvN7sUXxkgBkD5I+URLGpb862gT9/XcV7qJ2Yg=;
        b=k4tuHmRkFdHsqZkPVS3AuBdCsT6t0IadzXQDoYpXUMfy9VybiuSpVRV1F6Ejpo3lFk
         ZL+ka3TVhlD38HvuoDps1z9tBMEdWdd0IyUpCoKJ0kyjtxnBsb+m/CnW8syr52Ob3WHU
         5ZYg4LOX6z3ck/ng7AFvqDKCA3Db5dLvWEs3Oh4M0KfT9YocPwarlXYtmWFSR0PaFuP/
         NApJN0BjkqqpGaZVWZTJ3Ges2qIjTs46d1muTV5GubTNEesa7NVJR6GCtWvUzfri8dfV
         3t3NnH8m0rtSKrPrQUW4pnPelGW6i0GxbwyyI97kdlhjuTp219rTBnSdgywWq6iLojMz
         TGCA==
X-Gm-Message-State: APzg51DaIj76AgGtCGwQKraNTNjBfbU+96wHssbYUf2GwQzvvKVDy9+Y
        C8RJ1vP/OOMjlrmLHrfswwKhcQ34Hrqv8UB7lYwQ2i4Y
X-Google-Smtp-Source: ANB0VdYqVa2/bhDcyQcNPb3B9FRslstwvpiup5vtxHH8FuyVqwu91eobfxmYtRzbicAnPC3EKSUQNlRe8brCxDTtogQ=
X-Received: by 2002:aca:7c5:: with SMTP id 188-v6mr10192504oih.58.1535050233986;
 Thu, 23 Aug 2018 11:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180822105547.9634-1-johan@kernel.org> <20180822105547.9634-5-johan@kernel.org>
In-Reply-To: <20180822105547.9634-5-johan@kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 23 Aug 2018 20:50:23 +0200
Message-ID: <CAFBinCAKNUA5_fz4bXqj-aCaDEHk--Ax5GXJt+nzVKSjbVHxLg@mail.gmail.com>
Subject: Re: [PATCH 4/9] mmc: meson-mx-sdio: fix OF child-node lookup
To:     johan@kernel.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        carlo@endlessm.com, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On Wed, Aug 22, 2018 at 12:57 PM Johan Hovold <johan@kernel.org> wrote:
>
> Use the new of_get_compatible_child() helper to lookup the slot child
> node instead of using of_find_compatible_node(), which searches the
> entire tree and thus can return an unrelated (i.e. non-child) node.
that new helper is much appreciated, thank you!

> This also addresses a potential use-after-free (e.g. after probe
> deferral) as the tree-wide helper drops a reference to its first
> argument (i.e. the node of the device being probed).
>
> While at it, also fix up the related slot-node reference leak.
not sure why both issues went unnoticed so far - good that they're now
both fixed. thank you!

> Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
> Cc: stable <stable@vger.kernel.org>     # 4.15
backporting only works if the patch introducing
of_get_compatible_child is also backported
do we have to inform Greg somehow?

> Cc: Carlo Caione <carlo@endlessm.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Regards
Martin
