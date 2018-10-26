Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497B9ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BC82054F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EzPNeJe7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BC82054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeJ0DsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:48:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41717 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeJ0DsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:48:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id c16so1701068lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQzAj0SiHegfNvmB0fTzbc0VcHnuKGRf4+lGTwz6DpU=;
        b=EzPNeJe7zPNBRQDvaK5J9Qya1t1plieBbZPr0TPcyV9yFTbGjBvskSkXve4wTOxXnR
         xrKex8IThP3GWWbH57CiPhsIePNZOxVBg8gfu4rb8ctHhmk+tK2xVrJEDMN0eheUNwJ2
         BermyHimgr2bE68x1s8kwhCpIiHeohJ7qeRis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQzAj0SiHegfNvmB0fTzbc0VcHnuKGRf4+lGTwz6DpU=;
        b=Jmm9ODffSLjUHt2oaoA1IhXAHDSCdTQar9awT7ueSuzZxBuDyzjzhG2wOdKwnjm/D4
         6BDCQKAacpoypY3FNOaxtcOqhr8Q5wIwTN3QUYDmK3nkAAzDV7CabJxXKlz1Myb8Z3yQ
         OCnMDmixOy/RqStHUe/7p2QNPg4jetpG4spbOTaI6K4vBoWHNuEfqPX/eqV2LsOeXRkS
         zMiVp69Lcc6hCHzZOyqgLLEac0tZb3VagbAHPOc4KZ5OozapSD3t8VUSN+Hbmf3chfjj
         1wNeA5QFSCJAroMyUo+RmzIhsqZtHsUhyuPm5cu4LWKf4F0XcLmKci5d4cZcdps/BSS2
         jTCg==
X-Gm-Message-State: AGRZ1gL/kPcQzfG5ESquyZBwzC8MrWpopi0+wqapsYApjRHAqLhVHBWi
        ZxODig1J4F02+Gi1rgwvM5ZLqeYs4zG1ig==
X-Google-Smtp-Source: AJdET5frRMoHZb5Xjw7e5sIEY8XB/x0hxRHmRkcBuu6SEfKLbMQh/rvLEV5kweLrzppWQeDNn/1eaw==
X-Received: by 2002:a19:4345:: with SMTP id m5mr2942321lfj.142.1540580984940;
        Fri, 26 Oct 2018 12:09:44 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id g4-v6sm188086ljb.8.2018.10.26.12.09.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:09:44 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id x24-v6so1710915lfe.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:09:43 -0700 (PDT)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr3076550lfg.117.1540580983207;
 Fri, 26 Oct 2018 12:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181026153901.GA3744@localhost.localdomain>
In-Reply-To: <20181026153901.GA3744@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Oct 2018 12:09:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkjjBrjHZZ6AkrtpFEXjhRVM+S0GSKaTVRCSOdSSDqXw@mail.gmail.com>
Message-ID: <CAHk-=whkjjBrjHZZ6AkrtpFEXjhRVM+S0GSKaTVRCSOdSSDqXw@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.20-rc1
To:     edubezval@gmail.com
Cc:     rui.zhang@intel.com, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 8:39 AM Eduardo Valentin <edubezval@gmail.com> wrote:
>
>  Thermal-SoC Management updates for v4.20-rc1

Pulled,

               Linus
