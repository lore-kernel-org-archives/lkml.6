Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A9AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC39220824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IeyXp0xY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC39220824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeJ3GgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:36:00 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:43400 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbeJ3Gf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:35:59 -0400
Received: by mail-lj1-f179.google.com with SMTP id g26-v6so8078335lja.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmrwnLuXf4o/7Cl0ZIl3Qc53xzKXIrpDScMhKsYgi68=;
        b=IeyXp0xYr6DgSwsNtBPuFcF4eEdMKzuUF0tsVDsWqs62mb5vQkbaePYDVqBqX3BFdQ
         JW9K+fgST4l3ydWIk2qKISZcf/5i3MHDSRM1XJpWz+v3ZiBNGTWRyQmAawPmX3owm3qe
         YxyEYsL2JS+9ZmudLGru2HfajaHc3G5F55Gw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmrwnLuXf4o/7Cl0ZIl3Qc53xzKXIrpDScMhKsYgi68=;
        b=YFHK6byOklx+PxebfQsxvNggZdKZ4Q2voa2TsB0Vd/oWPbEvWrmYTl1zGe4/dDNVlO
         9HUANPIX6wu8tuctywCFCIuBRlXydS3D+1pcBUyW2s7COSzzPBooKD8bpOkc3bxyKAbe
         +jrs5HDIGgfo+xVDEXn72JGNZhY3pJ3mpXuWEbQt+dgeTi0G7jQ+6GvVdV3oq/yWAzQW
         S0se8RBlaBySyztu9tdast+TH7QwlsIb1wCIeZ9D78o0YCUh+ZiQVNs+PydOsINGtLjh
         79Gjj4kKf/oTzZtBxqMWwoKWE8qD5k2CBseB4/q9fbbd+X8A2YkBxYszNfSFbEznFC3x
         lNBw==
X-Gm-Message-State: AGRZ1gJWEJ0Y06J1SELjhhU9+gTyvL19jWIG2u8JT/HK+m0cgV6qXnF0
        ZBc0rumLrPQ/nIU1iWvD+JZni55b1gdhQw==
X-Google-Smtp-Source: AJdET5cMV7u0L7jYE3LDZ4/ncFMEAHFtondUvO/FXdTOzg+pCh8N8KzYmtfzkohz27CpwI0PSqIvZA==
X-Received: by 2002:a2e:7217:: with SMTP id n23-v6mr9104711ljc.71.1540849525232;
        Mon, 29 Oct 2018 14:45:25 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id c81-v6sm3370321lfe.79.2018.10.29.14.45.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 14:45:24 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id q6-v6so7261751lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:45:24 -0700 (PDT)
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr247617lfi.138.1540849523867;
 Mon, 29 Oct 2018 14:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181029190531.GA5319@kunai>
In-Reply-To: <20181029190531.GA5319@kunai>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 14:45:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNsMCp5m4ap_nqEOQzRehbSXfARsCWgp_xuG81FjH6cw@mail.gmail.com>
Message-ID: <CAHk-=whNsMCp5m4ap_nqEOQzRehbSXfARsCWgp_xuG81FjH6cw@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c for 4.20
To:     wsa@the-dreams.de
Cc:     linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        peda@axentia.se, brgl@bgdev.pl
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 12:05 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> I2C has not so much stuff this time. Mostly driver enablement for new
> SoCs, some driver bugfixes, and some cleanups.

Pulled,

                   Linus
