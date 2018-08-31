Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7189C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFF720837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qeObt2Yw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFF720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeHaLn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:43:29 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:64142 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbeHaLn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:43:29 -0400
Received: from mail-vk0-f48.google.com (mail-vk0-f48.google.com [209.85.213.48]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w7V7avUT027105;
        Fri, 31 Aug 2018 16:36:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w7V7avUT027105
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535701018;
        bh=OF255XcI9d/FOrMt0CaysrVeOW1rdMfuB/ocD6ECB7c=;
        h=From:Date:Subject:To:Cc:From;
        b=qeObt2YwnDeQJmOc6LrWKTZsb2S/h1T5GAGAydMrpeTt+AWHUd9lniZAHDQDBRWig
         8EMTD3P5M0A1iZRxYXShVhYn82A6iqKDvfM0ryqUgQ+XWwZFZVzwQNChV/Oa3UXEU2
         7fkrNMXNNUrfTSXl6klNRlJfAY90VDwTbzRn6ZqFgtV2m7HwvUW3Wc2cWV2FK6Jkzi
         Cex42+937SvNI49myOhq90ytyLY9JWJnXUDqdCwB19VBGQ9jeOpUnPTvL1Y1hIj16M
         OYO7R7KSXRa79P7gsOmjPyMG6Dkgw2YPsJJnbtJbVDJ5h7v/qiVhaBwrGFknBJdRNZ
         0aHpiMVMhtXHw==
X-Nifty-SrcIP: [209.85.213.48]
Received: by mail-vk0-f48.google.com with SMTP id h200-v6so5166176vke.5;
        Fri, 31 Aug 2018 00:36:57 -0700 (PDT)
X-Gm-Message-State: APzg51DN74BHgVbq0KDa8vbULoUQYBi8wGpAqvByZi8Io2ePLwPKtTA6
        nAgGVgvBQgHEHz7I/FC3lnWckhjHsdRTL0Yb1Jk=
X-Google-Smtp-Source: ANB0VdZrPzbVG6APm2+tAWm01Y9d8FrJkT6BputMfwH8woG7CLtcc8O42ha1u1AX0oNF4MPdraT0H6+N9axirtP8PhE=
X-Received: by 2002:a1f:de46:: with SMTP id v67-v6mr8338981vkg.55.1535701016899;
 Fri, 31 Aug 2018 00:36:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5155:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 00:36:16
 -0700 (PDT)
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 31 Aug 2018 16:36:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQO2aYLrtzg82jgKdKcOw20rNWBEY3DrdLcwOhnF9aa3A@mail.gmail.com>
Message-ID: <CAK7LNAQO2aYLrtzg82jgKdKcOw20rNWBEY3DrdLcwOhnF9aa3A@mail.gmail.com>
Subject: [Question] When should a driver issue STOP condition?
To:     linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


A problem was found in my drivers.


Before sending out patches, please let me
ask a question to make sure the right fix.


The problem is, my driver is forcibly setting
STOP condition unless the next message is read.

Please see this line:
https://github.com/torvalds/linux/blob/v4.19-rc1/drivers/i2c/busses/i2c-uniphier-f.c#L405


Obviously, it it disturbing the I2C_RDWR ioctl functionality.

Documentation/i2c/dev-interface says:
ioctl(file, I2C_RDWR, struct i2c_rdwr_ioctl_data *msgset)
  Do combined read/write transaction without stop in between.


So, I want to be sure
what a driver should (or should not) do.

A driver should issue STOP when and only when the I2C_M_STOP flag
is set in msg->flags.

Is this correct?


In other words, do user-space programs need to explicitly set
I2C_M_STOP where the STOP condition is desired?



Then, another question popped up.

User-space programs can send a single transaction
with read() / write().

I2C_M_STOP is not set in this case.


If a driver does not take care of the STOP condition at all,
the I2C bus is never released.
Is this the right thing to do?


-- 
Best Regards
Masahiro Yamada
