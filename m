Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2101ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBC620848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BKKbY5fI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBC620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeJ0Cht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:37:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38783 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbeJ0Cht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:37:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id x24-v6so1566921lfe.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VqvrzmOimtlJBp9eGsLDyaYWv/+YuUZNlZVvnb8l9yk=;
        b=BKKbY5fICjs0M9z8HcqjxWB2j2A1y6Gej6U/KmPLEerrzJf3ZHdDu6EU7cbd2y1BJR
         NahblR6nu3NWhgdCWl5sfzdwxji/XpgOCUbx1dciNLzbm7UmEY+UZC5GVwrsA7BEjiRv
         R99yJJlfjSG8SSAnuWSNVFWbAIjDcxUQXU+dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqvrzmOimtlJBp9eGsLDyaYWv/+YuUZNlZVvnb8l9yk=;
        b=fw0mM919bmlIHm2BPUFvrYaRRSgQ70yPoPxH60hV22T7FykHctqjAcZm5d1KmKF9/G
         gH2St0Fro95j46WWlJ9Dq271tnN8P4u7M+QxHIxKDHJ2GkpBAfizC2rNVM/1iNJgHjyn
         zdu84Hnl+MVf1fll/JVU69H+6Wg1euT9ODx56hsIQjcsKkDy6pLCu49MoSRhBLR1Fsud
         bWkIsmcWa4MCXs6TLTXwaipexrwJKhGKQbWhO490hXWSsxWOZnj5F0g3msfJzLrXcDjR
         wobPihv2Q7BQRZ8R4xvEJon4kJDjkj8DDxLpmJD5Q1AuacjRcfkV0k5KyDzcIwFQEimH
         jQKw==
X-Gm-Message-State: AGRZ1gKDrM6eR2dPWS1EksFFEdywITY7MmPHer6hT4czAumy5VvWRycY
        BsYM0xlbttl3GZSdjmBSWwsuoef74QGkWA==
X-Google-Smtp-Source: AJdET5f12gyJo4Mgcjh4SJ2C+t9MDDkylU/OwjxrbFgeRfLvC4/qOp1WUn6OIzjtnIGIjnJE1Mhbaw==
X-Received: by 2002:ac2:4299:: with SMTP id m25-v6mr2725603lfh.115.1540576316442;
        Fri, 26 Oct 2018 10:51:56 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id t6-v6sm1627640ljd.2.2018.10.26.10.51.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 10:51:55 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id j4-v6so1911903ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:51:55 -0700 (PDT)
X-Received: by 2002:a2e:980f:: with SMTP id a15-v6mr3377939ljj.6.1540576314926;
 Fri, 26 Oct 2018 10:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181026112710.iot2ti47chcf6w5f@8bytes.org>
In-Reply-To: <20181026112710.iot2ti47chcf6w5f@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Oct 2018 10:51:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKcUShuiJhh04xA0TKw8ssWL=o8O3mAxa+pJqy75EkaA@mail.gmail.com>
Message-ID: <CAHk-=wgKcUShuiJhh04xA0TKw8ssWL=o8O3mAxa+pJqy75EkaA@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v4.20
To:     joro@8bytes.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 4:27 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> IOMMU Updates for Linux v4.20

Thanks, pulled,

                   Linus
