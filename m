Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA89C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A997B21700
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A997B21700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeHHLcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:32:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37292 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbeHHLcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:32:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so908232eds.4;
        Wed, 08 Aug 2018 02:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LpD05EKk7VqUzNzSz+INgqNmnWxOWd/ZHOPbpWr4VFU=;
        b=gDSkhwBDy21k4vJKxvFpvYdRDWnKX6SOMCGmyL8i5o5Fx211sNyp+ySk1nMYBaFv0V
         1tjfhzlbmT8MFMDldCUOWZu+KhRZVuazk4Z3KUBGn5BzAIoJMUbt1DRx/5aiixPhtpsq
         j93evf0+6SmAkSw7TDpxRdzTrGtPQ6ez5PDzt7OVFFHyiVUWLYGQar+gB6prLh1J1GqV
         LlXqRFOFDaKxW4JYVAaOBTtNaWdlPW/AEiStLXTaOVZlgIvgNXl1syvzrpINK59X0z3f
         Zst/VHVV8xM94a2bljENDmed7BRK878qSvRrzjDFBlpqd0vFMjqvWdb3xhnNkiDENlgu
         D0Fg==
X-Gm-Message-State: AOUpUlHiYPWFY3FyPiKVXoQct9HGifNqkM43VCcWIM3R6Q5AA7v1fJRY
        Pq+EHhMYma9kIyl83VUqaxT/giUdQpM=
X-Google-Smtp-Source: AA+uWPwnR4U0yrarIpCUCHaKi8mYb9r4n44avk1kkQ8BdhRm4nxnSkmiZu4WOK5PV/McmF0/vzFmtQ==
X-Received: by 2002:a50:a2a6:: with SMTP id 35-v6mr2340076edm.276.1533719608873;
        Wed, 08 Aug 2018 02:13:28 -0700 (PDT)
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com. [74.125.82.42])
        by smtp.gmail.com with ESMTPSA id j23-v6sm2180447edh.29.2018.08.08.02.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 02:13:28 -0700 (PDT)
Received: by mail-wm0-f42.google.com with SMTP id y9-v6so1971128wma.5;
        Wed, 08 Aug 2018 02:13:28 -0700 (PDT)
X-Received: by 2002:a1c:6fdd:: with SMTP id c90-v6mr1271322wmi.16.1533719608030;
 Wed, 08 Aug 2018 02:13:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a101:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 02:13:07 -0700 (PDT)
In-Reply-To: <20180806160635.9293-1-vasilyev@ispras.ru>
References: <20180806160635.9293-1-vasilyev@ispras.ru>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 8 Aug 2018 17:13:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v6481_8sxGzpfzgi7J61OWDw6YFou4Lc3ve4qDTdNM0ayA@mail.gmail.com>
Message-ID: <CAGb2v6481_8sxGzpfzgi7J61OWDw6YFou4Lc3ve4qDTdNM0ayA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: axp209: Fix NULL pointer dereference after allocation
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 12:06 AM, Anton Vasilyev <vasilyev@ispras.ru> wrote:
> There is no check that allocation in axp20x_funcs_groups_from_mask
> is successful.
> The patch adds corresponding check and return values.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>

Acked-by: Chen-Yu Tsai <wens@csie.org>
