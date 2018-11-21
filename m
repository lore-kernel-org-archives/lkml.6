Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACCAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CAC21104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ul3JgptA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CAC21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389648AbeKVHPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:15:53 -0500
Received: from mail-vk1-f171.google.com ([209.85.221.171]:41268 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbeKVHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:15:53 -0500
Received: by mail-vk1-f171.google.com with SMTP id t127so1525458vke.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+F96LWG6CIQCL9JWkLiFQjnA+Wkpy27HflA7sP/xqc=;
        b=Ul3JgptA2hZLguxmzU2TSK07aVbly7umbwg7oz2ejquapKmuVeuZyeBGhXWGRMqJ4X
         6s9fD7iJ9gGb691FDbiomJYZsFnxJ8VSlkueLqrBhsSYLKVeSMmXAJbCPLzUJrGEUy8O
         72k2xhaaZO8mxkwhxsfgRJYElwwIilxIYpHqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+F96LWG6CIQCL9JWkLiFQjnA+Wkpy27HflA7sP/xqc=;
        b=bixy1IDroyV4CyMUIYH1hVszdB7A56Zf0Rj1VqFp2HsOkPmtsrkRCdDsQAzvXCwp2I
         /m4wCbnURzQkoiPTeDHB/i7vaQ8hUjQfbZgQi65dh85k+IBMPnGcPETnNiYgNIM4ajh4
         cUuoI6m9XS3F8O5c8u0eC4yHyihEyBOKY0Xaozbo3k3wQPb72dZCPKKlMKTDPchpYYNK
         KvuY3Fk4rn8CK2UY7IfMaFvKSsONUTvE64TMd6iX94W1hXlTHryOqkVDID4t6vFn+xgN
         z2w5ydKyysl8lQf4jfX9SAhLSJJjUtPTExI/PX4Zc5SZuCz5GySm4YI5OI0tHxmqkhN/
         Ax9A==
X-Gm-Message-State: AA+aEWbNXNWxITAzx6VUE1umTdbXxpxN44pd0DuZz5S9e2lHsvy4bseQ
        s8O52L0O1EE4r7FmOYKbE9BSW/IjFi0=
X-Google-Smtp-Source: AFSGD/Vof8yL7iOtPIyiFtarbj1vddRWAGS58gAYNz2WOT0TebRd8/X64a9QG1ZaSa5KafCsUQTlIA==
X-Received: by 2002:a1f:5cc7:: with SMTP id q190mr3262912vkb.91.1542832798208;
        Wed, 21 Nov 2018 12:39:58 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id s185sm9454316vke.11.2018.11.21.12.39.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 12:39:57 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id h128so1528275vkg.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:39:57 -0800 (PST)
X-Received: by 2002:a1f:e807:: with SMTP id f7mr3337157vkh.16.1542832797010;
 Wed, 21 Nov 2018 12:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20181122072528.11372826@canb.auug.org.au>
In-Reply-To: <20181122072528.11372826@canb.auug.org.au>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 21 Nov 2018 12:39:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WErS73ZLVmnP1o1WYX1VfrhwhCa6yhRC4gS9B=3vPYGg@mail.gmail.com>
Message-ID: <CAD=FV=WErS73ZLVmnP1o1WYX1VfrhwhCa6yhRC4gS9B=3vPYGg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the regulator tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Nov 21, 2018 at 12:25 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   fe115f7fd44b ("regulator: core: Only count load for enabled consumers")
>
> is missing a Signed-off-by from its author.

Argh.  When I squashed two commits together I must have clobbered the
Signed-off-by.  :(  Is there a suggested way that I can fix this?

-Doug
