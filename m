Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8741ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825A92150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtnfGqSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825A92150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbeISWyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:54:02 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:39455 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731569AbeISWyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:54:01 -0400
Received: by mail-wr1-f41.google.com with SMTP id s14-v6so6593602wrw.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=yqIlwsBJWB0rcs4w2CQqXmkBGz3k88yqahSgNB4Q4UY=;
        b=gtnfGqSDu093nWKDK8GJtO2R1PdUsTXYRBfSTCxImuOblUd0Ojs6b7mpAl/mgg0Aqr
         AQtg4OGWxwoMZZR9l+Yjprz2f8BsMJsmpPAgSAQi9igIEuqgSc0h5nLF6QFGFeUvA95t
         99IpKdzU/eSauL9ehzl0DO432VBTEnTcsv76w4pqUri4dYrusB+wLdh3f5jJHgEcAJTW
         p+px3Eb5iC3c/8EZu0H8ACnqFyItv0dQB/N6npexCMJZdKaDFVoDDZtFhkt2N5XivntU
         VUC3JlmnYafCyufwJ8+wq1cVYTZgPps2M5na+HL6TTO3aqfiw9jyZ8qgf7Qoz2lI1A4m
         pl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yqIlwsBJWB0rcs4w2CQqXmkBGz3k88yqahSgNB4Q4UY=;
        b=Ifor0ZuDifDEF6D5sWWKx5JuJJ5gks5+lf5c8jkTm7IkyLBnEZiW21XoKaTt54wgGo
         Uo0614cEIH0d2leEeYfmsHj6OM2kvFlIJEAx6zrVvGMcslcigm5xK84Tokh9WBKKyTiB
         GyPr8Hqvpo1anxvHlSkLXKiI1wqnF1Yqosk63exgD28AKxo3VXufuD4UYVOjInue0PNY
         x54Joz2Yvlan0wnaDYWmi2maBG8lwO1pbonsBfE2zTOrM18cpSGhmOjtgRrecSwTOWmf
         WXYZ5EthBI9p8xd3OigT8Y0OTR6I0quE+TKZWz4pHIrNNjGMVSAtDWCUHy20YbBc/rQ4
         p6QQ==
X-Gm-Message-State: APzg51BcEWHOXiinfRIFizbE2VmQqQo6WFdcJm3fZXqKmVmQdMAQuTGu
        Z+GE0I2xRPR3OSgRUm4g08z6IB8wtjWf6mBrK9k=
X-Google-Smtp-Source: ANB0VdZK+QlwRk2JM91v15fJI0dArIkKHhUGJLlg5IyIMINKAFFBhApt0ruWDeU0muxknmHAwFlfsE724zsckYl41HI=
X-Received: by 2002:adf:add0:: with SMTP id w74-v6mr30555979wrc.73.1537377308482;
 Wed, 19 Sep 2018 10:15:08 -0700 (PDT)
MIME-Version: 1.0
From:   Dhaval Giani <dhaval.giani@gmail.com>
Date:   Wed, 19 Sep 2018 10:14:57 -0700
Message-ID: <CAPhKKr9vWJ4d8yV7N4=XqaEyKEjC_ZiPX_2RJSR9ZiR9k6yS1w@mail.gmail.com>
Subject: [Announce] LPC 2018: Testing and Fuzzing Microconference
To:     alexander.levin@microsoft.com, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, alice.ferrazzi@gmail.com,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>, dvyukov@google.com,
        Laura Abbott <labbott@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        gustavo.padovan@collabora.co.uk,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        knut.omang@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Sasha and I are pleased to announce the Testing and Fuzzing track at
LPC [ 1 ]. We are planning to continue the discussions from last
year's microconference [2]. Many discussions from the Automated
Testing Summit [3] will also continue, and a final agenda will come up
only soon after that.

Suggested Topics

- Syzbot/syzkaller
- ATS
- Distro/stable testing
- kernelci
- kernelci auto bisection
- Unit testing framework

We look forward to other interesting topics for this microconference
as a reply to this email.

Thanks!
Dhaval and Sasha

[1] https://blog.linuxplumbersconf.org/2018/testing-and-fuzzing-mc/
[2] https://lwn.net/Articles/735034/
[3] https://elinux.org/Automated_Testing_Summit
