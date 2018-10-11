Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B49C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AD12085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BppfUWbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AD12085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJKOW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:22:59 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35204 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbeJKOW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:22:59 -0400
Received: by mail-it1-f193.google.com with SMTP id p64-v6so11733563itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 23:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sk4UrchFgVWUAW+PMrc23gRpBcPa7t62brDesCvdbC0=;
        b=BppfUWbnkYjYmJw+MgXzy5dwjrpu2El5RLYt7Wea6/m+t0FGoH7IlZDZZfg2hKzWaD
         bcQsIdUQo2lYdkFp+OplH39srmcsEuZK5yI3mPNfpPprwzpBi6kurnjw7UaZ342phigV
         WzhWn4tyZGi/AQxoB/pIQiAY/wmF+vhLmGA8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sk4UrchFgVWUAW+PMrc23gRpBcPa7t62brDesCvdbC0=;
        b=f2UZGpyOZ75TYRrhC1OA3M+0TuW0VR/gEfLripP1n5/CtDRBwVp2TAfJcINfQln3lx
         im+eagVVLtpGZDKaxEaY9DU4nuwEZMSPbB8nrHUg4lBo4VoFNxVvuTQaVDTv7zf7NbwQ
         WJnsuz20df1c2MI/IyVmd4kchtGpIVwc50HQgvgNQyML7Dk4IEC834Ym+tzjCwGFPZQj
         NxRsPNDVJ6KpsZj1S3NldyEpJg3aZypWw25zgyiE+xHuzBXZs7pHZoBOE+KCZmSFmfjt
         DpKlN50BN/UH8rTmIwQWBcL2cpL8pWzwaN1b2W0+xy15y/5tWg+5tldY21QUuYWdeVmz
         6xLw==
X-Gm-Message-State: ABuFfohC8R1z2z71IKWVVtkDqoxaHRoF5vtSfXyMGxqndznrQx9V+f4V
        5CbcJqEDg5WGl5PJv0f9HxqnmXj3ADYdsw==
X-Google-Smtp-Source: ACcGV62uF2lRLFSBBXViz/pYHIrqoQ7O+yfkYd1apLxSfl6YnVYg2IYGunBL1mSGAXURK3qLjLSOQg==
X-Received: by 2002:a24:81d7:: with SMTP id q206-v6mr446093itd.94.1539241025581;
        Wed, 10 Oct 2018 23:57:05 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id u21-v6sm8555672ioc.43.2018.10.10.23.57.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 23:57:04 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id p4-v6so5809361iom.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 23:57:03 -0700 (PDT)
X-Received: by 2002:a6b:de1a:: with SMTP id v26-v6mr214279iog.86.1539241023569;
 Wed, 10 Oct 2018 23:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <1539071557-1500-1-git-send-email-mgottam@codeaurora.org>
In-Reply-To: <1539071557-1500-1-git-send-email-mgottam@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 11 Oct 2018 15:56:52 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVHVH=3G0XjuVnr_CFX7HG484of0tFokDkcyk7t9VZkuw@mail.gmail.com>
Message-ID: <CAPBb6MVHVH=3G0XjuVnr_CFX7HG484of0tFokDkcyk7t9VZkuw@mail.gmail.com>
Subject: Re: [PATCH] media: venus: add support for USERPTR to queue
To:     mgottam@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 4:52 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>
> Add USERPTR to queue access methods by adding this
> support to io_modes on both the planes.
>
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>

Tested-by: Alexandre Courbot <acourbot@chromium.org>
