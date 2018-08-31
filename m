Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D250C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE08220661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="STVBA0C4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE08220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeHaMda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:33:30 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:56179 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeHaMda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:33:30 -0400
Received: by mail-it0-f67.google.com with SMTP id d10-v6so6130350itj.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/uO2yUjEs9fRJpUD0GczrOmUQ6mfM6VxBFqAxlyYXQ8=;
        b=STVBA0C4FYnNBVCzNnqEg5jmX+zoQM+0rXBiIQWHPVnmbBPN8bKf+aQuNNr16PgXUQ
         SKvx67Em6dsbkxTsZY1fee/1NnwZC9gapBpXrC8HKcQ3BzmeIve3aICYBmj1Z7hY6rUV
         Kmm08YgSabUTCDlNdx8vfCGmtyYoW4V5lkY1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uO2yUjEs9fRJpUD0GczrOmUQ6mfM6VxBFqAxlyYXQ8=;
        b=RoT1Cv5I2rf4IHLzZXg8CZ7AWOzKuWNEyoZ+/k+ER2QC4PgdSIamQ6r5Qgs3WRvJQA
         CWvtPiganhS0PRwUjdsyr4DZFFl8aq9zHg+RMHMEqZyHvhJM1GErAAbt8m6WOlJBdtqa
         Qqc7V1aijbuz9VhBU+7Q1/fv/CSVoX9/LCHct1ZkCKSqIC8akPZSMh3inaJqT22M7BTX
         q+BGz/uAezuAmwjdwl3EHtczxRN6M1sbmYxyg8U84QZknG8k8yYpTKr6RqgWkaOHQ0Lc
         esVAsft/3vL9fcsisijuAf8pGsUxXQz+C3R5Y9irT4O3MU26ZbBqXDvQPbkgyuEs4Lrd
         xbVA==
X-Gm-Message-State: APzg51CobYDNV4sTJCCsMJJs47nfWUWZv3FBdscO1LfYdNeaEgds9M+g
        ijm9nmVHGotnQaPXkq8OaQUNbDVULFA=
X-Google-Smtp-Source: ANB0VdbrQMGqpfNWnUUXCvySVzZM7enCBqC+6wl26qlg/By5XqH/hlDVny7fcXWzASa8hN4+ovl9Sw==
X-Received: by 2002:a24:1196:: with SMTP id 144-v6mr4764386itf.45.1535704030540;
        Fri, 31 Aug 2018 01:27:10 -0700 (PDT)
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com. [209.85.223.172])
        by smtp.gmail.com with ESMTPSA id q6-v6sm3748896iob.65.2018.08.31.01.27.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 01:27:09 -0700 (PDT)
Received: by mail-io0-f172.google.com with SMTP id y10-v6so9785552ioa.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 01:27:08 -0700 (PDT)
X-Received: by 2002:a6b:2387:: with SMTP id j129-v6mr11141298ioj.86.1535704028001;
 Fri, 31 Aug 2018 01:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-2-tfiga@chromium.org>
In-Reply-To: <20180724140621.59624-2-tfiga@chromium.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 31 Aug 2018 17:26:56 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXT4jiQXfgzq8fpXSQTsdcF0UZLB=RQ6itH5-JZx-27FA@mail.gmail.com>
Message-ID: <CAPBb6MXT4jiQXfgzq8fpXSQTsdcF0UZLB=RQ6itH5-JZx-27FA@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Pawel Osciak <posciak@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, p.zabel@pengutronix.de,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        andrew-ct.chen@mediatek.com, todor.tomov@linaro.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org, ezequiel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz, just a few thoughts I came across while writing the
stateless codec document:

On Tue, Jul 24, 2018 at 11:06 PM Tomasz Figa <tfiga@chromium.org> wrote:
[snip]
> +****************************************
> +Memory-to-memory Video Decoder Interface
> +****************************************

Since we have a m2m stateless decoder interface, can we call this the
m2m video *stateful* decoder interface? :)

> +Conventions and notation used in this document
> +==============================================
[snip]
> +Glossary
> +========

I think these sections apply to both stateless and stateful. How about
moving then into dev-codec.rst and mentioning that they apply to the
two following sections?
