Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24E2C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8759520834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PYYzwo0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8759520834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeLAGyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:54:00 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:46035 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeLAGx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:53:59 -0500
Received: by mail-lj1-f177.google.com with SMTP id s5-v6so5990793ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 11:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fFziNXyQiaQ1gvrUPztS5FG34FXTL1N9RRdX0cNN0I=;
        b=PYYzwo0tMsYcbfvIwf5RJHUWXOgcVNaoJMWTqvQHUXo6niteO0eX+YGc9YbavQQZ4o
         A3xhEHVVs3h8icNVlNAfkkD18bgt6X8F/+ZxJmD6Dohzfq+w2vLdqOs3NbA9JWYuqqhV
         ggiiYzO4IlKiR7LYTtwCRapGsYtr1FAz+wjs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fFziNXyQiaQ1gvrUPztS5FG34FXTL1N9RRdX0cNN0I=;
        b=oaLmNO+7Aj6T4zHun9bArz0XyXhKwX5Wbx6S2lau07ohclmCxLG8YmE1gC83qblGXR
         mgEHT5ha4Tuacklu7wKnlQ0D/o87EcwdXW1HMNUH5XRigQnSRcSU15X4ueexH02QfpSN
         zYfhbTh9bvxOusHSZioXXbElSKyA8dgWoq82FHis+63MtwzlUNCfApOCDlxuqZudhI4X
         l6BHRL/CQ29Ag6hsrMOA0ytEADnsr0GBRHO8pJmZpc8suyqINVlw2jNmNw8gjAcGb2mm
         dPVW6ZY2GPCOonFFXL2jmP8H7D2SNgGTYhe1Q9TD6HpvlZaKCwSPIHgA3owVlGkisgGR
         q16g==
X-Gm-Message-State: AA+aEWab8QeJXWAbgXGxiXQ8rl5UbnPRHG6MvY21Boa07cWt5yuJk6ro
        pdGRBgUC76PleMQUhSFiQzRp06dFPQE=
X-Google-Smtp-Source: AFSGD/VvdHBR6uWaAxMwtwfBQvpi/je+PYOIU4BxgQ9CXDuM5/e8/JqktR6aLh4qEUmlrZMgLpMi9A==
X-Received: by 2002:a2e:85d3:: with SMTP id h19-v6mr4525212ljj.82.1543607016147;
        Fri, 30 Nov 2018 11:43:36 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id y14-v6sm934072ljj.55.2018.11.30.11.43.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 11:43:35 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id p6so4957548lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 11:43:34 -0800 (PST)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr4584103lfg.117.1543607014101;
 Fri, 30 Nov 2018 11:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20181130132231.16512-1-hch@lst.de>
In-Reply-To: <20181130132231.16512-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Nov 2018 11:43:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wia7wykuDu-mzbhF+rL1M9FnJfnoidsvkz5TPMPHUep7g@mail.gmail.com>
Message-ID: <CAHk-=wia7wykuDu-mzbhF+rL1M9FnJfnoidsvkz5TPMPHUep7g@mail.gmail.com>
Subject: Re: remove the ->mapping_error method from dma_map_ops V3
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, jdmason@kudzu.us,
        joro@8bytes.org, David Woodhouse <dwmw2@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        robin.murphy@arm.com, "the arch/x86 maintainers" <x86@kernel.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 5:23 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Error reporting for the dma_map_single and dma_map_page operations is
> currently a mess. [..]

I don't see anything objectionable there, but it's not like I checked
any of the context of the patches. For all I know there are odd corner
cases where some zero vs DMA_MAPPING_ERROR confusion lurks, but I
guess we'll find out..

So you can add my acked-by, fwiw.

                Linus
