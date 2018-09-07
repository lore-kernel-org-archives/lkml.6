Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE98C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4622083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4622083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeIGPAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:00:01 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:41647 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbeIGPAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:00:01 -0400
Received: by mail-lf1-f43.google.com with SMTP id l26-v6so11606650lfc.8;
        Fri, 07 Sep 2018 03:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=I6IvwwIi8pswwXMZKE90uJXlzAdftABaGQvYx3V8o3M=;
        b=SjmnhfLGouQB+8IJ3n1b2oKuS57ynTopPAHapu7QY/gKnesjFael+oNzH9llZXFUFp
         zykqogUyZ21wAcZ9dK9m86LgJTtlN3zTn/BCFvVVVUflKlTevdlJI7n8e0oxx0GT8gig
         avm3V6/YP2cP5BKpyHLBDFnAeXWbJi2D5fKiosq0D5zgy4sT4us/PsxSuPojtt1f3sPy
         XZ+sTDy9FMS6KdSoVUxQ/g9xt0Z2PYZd+bpaSiJstWyLEhV3P9Zz49D3JHyHWhu9ohnS
         OUCxzntzHsFRBBUtePzXG6smAbyqwOTwnl1lSmk6sXfkZhIW0sNDHglCM4V6p/MUNRqM
         Eibw==
X-Gm-Message-State: APzg51B4nPwcl9gQNuaLb3+j+Xsrf5uBj1DAb7j+J21cXYdQiMlgLGoP
        9cNyQT56nlN0trxnmC5K+Aw=
X-Google-Smtp-Source: ANB0VdZAfwJ8VaCVmdElh0BCnecCnvZ2mxKlcS1TcrtgXEpC9nbob3vLxLQHlUMCmhbJtLfuRXwnnQ==
X-Received: by 2002:a19:5517:: with SMTP id n23-v6mr4781749lfe.101.1536315583094;
        Fri, 07 Sep 2018 03:19:43 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1204858ljd.61.2018.09.07.03.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 03:19:42 -0700 (PDT)
Date:   Fri, 7 Sep 2018 13:19:40 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     zyw@rock-chips.com, mturquette@baylibre.com, sboyd@kernel.org,
        w.egorov@phytec.de
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Does Rockchip RK808 driver unload work as intended?
Message-ID: <20180907101940.GE2472@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dee Ho peeps,

I was browsing through the clk drivers as I tried to do some cleaning.
Few days ago I submitted a patch which would add devm variants for
clkdev lookup registration. I also added devm of_provider registration
for cases where it is actually the parent device which contains clock
definitions in DT. This seems to be quite typical for MFDs.

While doing this I hit to Rockchip RK808 driver which seems to utilize
oarent device (MFD dev) for pretty much all devm releasing. I wonder if
this is safe? What happens if one tries to remove the RK808 clk module?

I guess the clk deregistration and cleanups are not ran as parent device
stays there, right? But is the clk module and clk module code still
unload? So won't clk operation pointers registered to clk core become
invalid?

I guess I don't have any HW to test this mnyself. And as the driver has
been there since 2014 - well, chances are the driver does work and I
just don't get it =)

So can someone please shed some light on this? Is this a bug or am I
just plain wrong?

Br,
	Matti Vaittinen
