Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588AEC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A178205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LEQXzfLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A178205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeKBDUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:20:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45280 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbeKBDUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:20:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so18891199ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 11:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5xZyIOrShwdAaHi3Bugpa0giaWfkKbYREcA4+OOIN5c=;
        b=LEQXzfLU5ZAI/8NQcKMJxcC2m3brK7qUuf0+t4Kz/BtLDkmDToRxF1dV2ajudUBZ8h
         wxseLRiTk3RpaRvtlrDebgUKg8gUMGzUGg2KqXphZ60Pbyc5BtGZovdQQcMxbdeImc7z
         YLwmgcRZNaGiNsCJrdLGfjwdoEJ7J5lkS6D0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5xZyIOrShwdAaHi3Bugpa0giaWfkKbYREcA4+OOIN5c=;
        b=aILlI9pDx2GrzUI8RcYyb9uHb1DqoOad0J5y/OeSA8LggZWzpgmj/A9SndCHrXB1Qh
         zbHB3+JYNSMy0zVCIHNBLflZga3Lt4Cih02zuT3HJw+6IlWzDOug7zu/ZPj3C7d525ZX
         VXeZrFx5uBUlIsQbeIJ1ULXv43PxWvhRrTtF5F3KJnjQj04AFXsJvCOEibfocb4Y4RQQ
         o5KTbdcomzGos9iOBf1rqpQ4xuapo0bzs2QgjymqWJAhB2PBhLs9Ugk64P+O+rhI2E4y
         UZZp54aDVi7Z4jBhLoPTr8vXfB9VjOs/uRN+YiOfCYvxFihLn9wn6EVmBEX1Q2/Li+Q+
         rRuw==
X-Gm-Message-State: AGRZ1gKJn9RJYt9uCuOJYfuGaE+T268UwYdl1IvXs6MC1M5YjYtMPqD9
        F6M/RZGmdcpVm8JWi9AuYqYWy/66ir8=
X-Google-Smtp-Source: AJdET5d/Mgm5DEJhYTMRPSsAE+abTFv8eDsYo8aypSkXPnQAtS13pAWyua1/EBLje5yzy9yt6quWZw==
X-Received: by 2002:a2e:197:: with SMTP id f23-v6mr5641965lji.144.1541096154696;
        Thu, 01 Nov 2018 11:15:54 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id u15-v6sm1003993lja.63.2018.11.01.11.15.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 11:15:54 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id n18so6532086lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 11:15:53 -0700 (PDT)
X-Received: by 2002:a19:1019:: with SMTP id f25mr4999730lfi.54.1541096152366;
 Thu, 01 Nov 2018 11:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181030230624.61834-1-evgreen@chromium.org> <1540943443.196084.131.camel@acm.org>
In-Reply-To: <1540943443.196084.131.camel@acm.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 1 Nov 2018 11:15:15 -0700
X-Gmail-Original-Message-ID: <CAE=gft4xwXuJ=aHbF08SxFxtSRX_6KBzPHxCCMbA6F7RnGQ8jA@mail.gmail.com>
Message-ID: <CAE=gft4xwXuJ=aHbF08SxFxtSRX_6KBzPHxCCMbA6F7RnGQ8jA@mail.gmail.com>
Subject: Re: [PATCH 0/2] loop: Better discard for block devices
To:     bvanassche@acm.org
Cc:     axboe@kernel.dk, Gwendal Grignou <gwendal@chromium.org>,
        asavery@chromium.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 4:50 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Tue, 2018-10-30 at 16:06 -0700, Evan Green wrote:
> > This series addresses some errors seen when using the loop
> > device directly backed by a block device. The first change plumbs
> > out the correct error message, and the second change prevents the
> > error from occurring in many cases.
>
> Hi Evan,
>
> Can you provide some information about the use case? Why do you think that
> it would be useful to support backing a loop device by a block device? Why
> to use the loop driver instead of dm-linear for this use case?
>

Hi Bart,
In our case, the Chrome OS installer uses the loop device to map
slices of the disk that will ultimately represent partitions [1]. I
believe it has been doing install this way for a very long time, and
has been working well. It actually continues to work, but on block
devices that don't support discard operations, things are a tiny bit
bumpy. This series is meant to smooth out those bumps. As far as I
knew this was a supported scenario.

-Evan
[1] https://chromium.googlesource.com/chromiumos/platform/installer/+/master/chromeos-install
