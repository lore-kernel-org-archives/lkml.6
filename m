Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9C1ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2FF2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hBO42Eyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2FF2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeJ0DIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:08:45 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:44515 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeJ0DIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:08:44 -0400
Received: by mail-lj1-f175.google.com with SMTP id v6-v6so2010125ljc.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/Y4SmCfdfFyBdNkHNeBtD+aXA8o6vymANiVuTZmD+E=;
        b=hBO42EyggHSoryq4ws1d7n6jthF9WF6NyCfTmlQDJn8+aX/LHo49XurWNh1+GJjf58
         IOAaYc9CgT/u/QlgFHFO7d14f5lOysrbQ1cbU/ocXlWGMC7/iaIk1yZbzwofTKSF46hb
         HAg1eyus+kke11Ar9I4wRT7KfaRlbXJIP5Olw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/Y4SmCfdfFyBdNkHNeBtD+aXA8o6vymANiVuTZmD+E=;
        b=msRM7hlCR6hb/ZWdh7y+/zJ85YWK6+xe25PQUty0OUHEKw3Y5kT7BIsuNALDIRcplx
         ZO1AGnHrCMQd4pgPC8upxv/bbTMiEZM6/JC7jy0sq4Pc4dUlgHBzLJb+OyDstfK3xb/J
         oRt43P+OaYSgv+AQP3cHXUKrk+z5B3OeZ06KOCbNm3ObSTnPxdCgAX1jiN8dpZy1Qa17
         IcjnD28FMmcn4rdV7kGQ33KUw11uEtmt/TMKPGHiNBVyh4+Z4sCIvOrNPbT6F5/gmETq
         /piXsiBfK/1LK1p5RDhZA+Pg5n9qJLYK/fOsklxXngHgJoPq69/2glC4inQVTf4ZzT5y
         O7rw==
X-Gm-Message-State: AGRZ1gKqsuJZPs6YIvyYflpMp5vx9+ehtYu/YeX5660FkbjsxP8+u1bb
        PXbhkMQ3qFcc8uszidLfZDAL+ovtBnSVGg==
X-Google-Smtp-Source: AJdET5fY3bDbBDLbPy/CZIkgTH4K994yoqP+HSOQ9hmNwNbgm6ZM22oNMxNGQDsWuOpuiz5SYsqPvw==
X-Received: by 2002:a2e:5317:: with SMTP id h23-v6mr3017773ljb.26.1540578637312;
        Fri, 26 Oct 2018 11:30:37 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id f197-v6sm1880166lfe.49.2018.10.26.11.30.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 11:30:36 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id p1-v6so2027966ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 11:30:36 -0700 (PDT)
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr3349134ljj.80.1540578635848;
 Fri, 26 Oct 2018 11:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181026132403.GA23693@infradead.org>
In-Reply-To: <20181026132403.GA23693@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Oct 2018 11:30:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPr1PLVcCpXDMUqu1FcyFBp4XOw9i9zue8hkJY8fZgOg@mail.gmail.com>
Message-ID: <CAHk-=wjPr1PLVcCpXDMUqu1FcyFBp4XOw9i9zue8hkJY8fZgOg@mail.gmail.com>
Subject: Re: [GIT PULL] second round of dma mapping updates for 4.20
To:     Christoph Hellwig <hch@infradead.org>
Cc:     iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 6:24 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Second batch of dma-mapping updates for 4.20:

Pulled,

                Linus
