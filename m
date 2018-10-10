Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A174EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509CC2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W2dZiF8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509CC2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJJOWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:22:23 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37299 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJOWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:22:23 -0400
Received: by mail-it1-f195.google.com with SMTP id e74-v6so6515450ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjelkAhZUIa8JtIhWp5qbOXYTr7fijM7hOHufD5Ksp8=;
        b=W2dZiF8cU9pxrSX8HQcpf7GMx3CaGcOB11lEPtcH+haCDIDGu8NCUlddNhJiTlWnBw
         +siU57Em652b+hGoqn18BKB7h/VPmY0PVtdO6QqiF/qf1UWwK3BmtvaRmRu93NUXmV64
         W0/dH9FQnYfjNfMbPpmZKgeQx4v+WQD2tfxts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjelkAhZUIa8JtIhWp5qbOXYTr7fijM7hOHufD5Ksp8=;
        b=PPQ5xmo5WCGEyg8NJOwamijw1mEOKTdLtjYomnXMJgOd0Esqh3Lzigb/soCCla4pZ7
         oBv8lF6FwC5Af+C/tOV+zQlp/3RYSI3u6d2PGiEooNfDHE7BcUF2KZP+kipCG+oJAQ+/
         GnvHRAnbuguWY9MuuryAuNxNF3pPRluPfkN0X3lp8zuNw60FIF5zcfid2srOrRokwR0g
         GQKnIciUXPmnRTXNt0Q9Tj+0UuA66wzxImi7usjcXQkhKnJhVihAKP6Czmt7VyBK+SfC
         ObFDzPF4eXZwp8RR6azpC0z6ZXyNUWf4rqaALx7CE9gYvN3jGER6SSOeJbMCxpK3wRB8
         wOyg==
X-Gm-Message-State: ABuFfogFM6oFH+npafTvWg6H2+6h4+6TTHseETMLt8fAgviYu3oDPUOx
        SMLHrAnU3y9UtYE8WancK9rljF3NwnA=
X-Google-Smtp-Source: ACcGV61CmY8qgHTNgNGJPOBqJ17MDJqlT6d9PRLKxdVjWrUNrRj0vZX55iuXaREubt/u76piw1QIkQ==
X-Received: by 2002:a05:660c:18d:: with SMTP id v13mr4360729itj.135.1539154897400;
        Wed, 10 Oct 2018 00:01:37 -0700 (PDT)
Received: from mail-it1-f180.google.com (mail-it1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id i129-v6sm7530507ite.18.2018.10.10.00.01.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 00:01:36 -0700 (PDT)
Received: by mail-it1-f180.google.com with SMTP id l191-v6so6505153ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:01:36 -0700 (PDT)
X-Received: by 2002:a02:91c9:: with SMTP id s9-v6mr26489151jag.104.1539154896080;
 Wed, 10 Oct 2018 00:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <1538996944-15042-1-git-send-email-vgarodia@codeaurora.org>
In-Reply-To: <1538996944-15042-1-git-send-email-vgarodia@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 10 Oct 2018 16:01:24 +0900
X-Gmail-Original-Message-ID: <CAPBb6MV3ih-tOr=kt6NvYD4ZQPrs2eRpzdnCOZLhEhXeYMatrQ@mail.gmail.com>
Message-ID: <CAPBb6MV3ih-tOr=kt6NvYD4ZQPrs2eRpzdnCOZLhEhXeYMatrQ@mail.gmail.com>
Subject: Re: [PATCH v2] venus: vdec: fix decoded data size
To:     vgarodia@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 8:09 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>
> Existing code returns the max of the decoded size and buffer size.
> It turns out that buffer size is always greater due to hardware
> alignment requirement. As a result, payload size given to client
> is incorrect. This change ensures that the bytesused is assigned
> to actual payload size, when available.
>
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>

Tested-by: Alexandre Courbot <acourbot@chromium.org>
