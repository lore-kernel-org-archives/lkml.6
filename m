Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A7EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1392B20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1392B20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeKCBJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:09:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35223 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeKCBJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:09:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id z2-v6so1235657pfe.2;
        Fri, 02 Nov 2018 09:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzVNQhTl4NUlQKdUtPgrW/Ou908GyflDFmAN7hdwvpQ=;
        b=pjybNbzCFpHcljkvABG72v2OPYEY8l8qTvmczQWZFNmBJRfxGFYXiYzpoN9WW45gKQ
         NHvitDt2MEu/bHTsZMqDgUtjcZK2mHY4mzj7xrSsgHW3L6+uuxWG9VaQWyl964Fzt1UK
         G/++ONo6JZx7WPQVSYKjMWj+CkBuyNnjtQL18HKy1cqQjqFpLczrzoMFvYH7zAQrq89c
         R0WwjRvtUdquGFZwdKTckrijUM039kdipfJZ2mxmq/d1xVUjtd6gMRspS5BFFhpEk4CV
         gwXJtSBQYA1zBjeLRynkBR9ACt3zpO4qesx1KuW5+toNKPbLv3VB9Asya4qA+gsh19ON
         Us5w==
X-Gm-Message-State: AGRZ1gLX5KU3g6kuXZIKXpNGPZ19CI0mrCgWEa984oIJKKP0ewkD/Lbi
        aqnZP6qRt/5eAuLjgNojhSM=
X-Google-Smtp-Source: AJdET5fYwHN8vYrJiCuFe8Wxfobk1ExJAkD+dzK3tvOd+dkH9oUfqEDYrk40pcXdjYCmefC7yBhK5Q==
X-Received: by 2002:a62:90db:: with SMTP id q88-v6mr12162184pfk.98.1541174535558;
        Fri, 02 Nov 2018 09:02:15 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id e4-v6sm19518399pfg.152.2018.11.02.09.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 09:02:14 -0700 (PDT)
Message-ID: <1541174532.196084.146.camel@acm.org>
Subject: Re: [PATCH 0/2] loop: Better discard for block devices
From:   Bart Van Assche <bvanassche@acm.org>
To:     Gwendal Grignou <gwendal@chromium.org>, evgreen@chromium.org
Cc:     axboe@kernel.dk, asavery@chromium.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 02 Nov 2018 09:02:12 -0700
In-Reply-To: <CAPUE2uuhfk7kstwO2kp_Rs=9QQPgGQGY+QqR76zpZpTkKp5Mig@mail.gmail.com>
References: <20181030230624.61834-1-evgreen@chromium.org>
         <1540943443.196084.131.camel@acm.org>
         <CAE=gft4xwXuJ=aHbF08SxFxtSRX_6KBzPHxCCMbA6F7RnGQ8jA@mail.gmail.com>
         <CAPUE2uuhfk7kstwO2kp_Rs=9QQPgGQGY+QqR76zpZpTkKp5Mig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-01 at 15:44 -0700, Gwendal Grignou wrote:
+AD4 On Thu, Nov 1, 2018 at 11:15 AM Evan Green +ADw-evgreen+AEA-chromium.org+AD4 wrote:
+AD4 +AD4 
+AD4 +AD4 On Tue, Oct 30, 2018 at 4:50 PM Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 On Tue, 2018-10-30 at 16:06 -0700, Evan Green wrote:
+AD4 +AD4 +AD4 +AD4 This series addresses some errors seen when using the loop
+AD4 +AD4 +AD4 +AD4 device directly backed by a block device. The first change plumbs
+AD4 +AD4 +AD4 +AD4 out the correct error message, and the second change prevents the
+AD4 +AD4 +AD4 +AD4 error from occurring in many cases.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Hi Evan,
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Can you provide some information about the use case? Why do you think that
+AD4 +AD4 +AD4 it would be useful to support backing a loop device by a block device? Why
+AD4 +AD4 +AD4 to use the loop driver instead of dm-linear for this use case?
+AD4 +AD4 +AD4 
+AD4 +AD4 
+AD4 +AD4 Hi Bart,
+AD4 +AD4 In our case, the Chrome OS installer uses the loop device to map
+AD4 +AD4 slices of the disk that will ultimately represent partitions +AFs-1+AF0. I
+AD4 +AD4 believe it has been doing install this way for a very long time, and
+AD4 +AD4 has been working well. It actually continues to work, but on block
+AD4 +AD4 devices that don't support discard operations, things are a tiny bit
+AD4 +AD4 bumpy. This series is meant to smooth out those bumps. As far as I
+AD4 +AD4 knew this was a supported scenario.
+AD4 +AD4 
+AD4 +AD4 -Evan
+AD4 +AD4 +AFs-1+AF0 https://chromium.googlesource.com/chromiumos/platform/installer/+-/master/chromeos-install
+AD4 
+AD4 The code has moved to
+AD4 https://chromium.googlesource.com/chromiumos/platform2/+-/master/installer/chromeos-install
+AD4 but the idea is the same. We create a loop device to abstract the
+AD4 persistent destination. The destination can be a block device or a
+AD4 file. The later case is used for creating master images to be flashed
+AD4 on memory chip before soldering on the production line.
+AD4 It is handy when the final device is 4K block aligned but the builder
+AD4 is using 512b block aligned device, we can mount a device over a file
+AD4 that will behave like the real device we will flash the image on.

Hi Evan and Gwendal,

Since this is a new use case for the loop driver you may want to add a test
for this use case to the blktests project. Many block layer contributors run
these tests to verify their own block layer changes. Contributing a blktests
test for this new use case will make it easier for others to verify that
their changes do not break your use case.

Bart.
