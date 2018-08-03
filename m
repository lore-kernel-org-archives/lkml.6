Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0996CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B031E217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BaUVBrGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B031E217A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbeHDBFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 21:05:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36768 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731741AbeHDBFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 21:05:03 -0400
Received: by mail-lf1-f65.google.com with SMTP id b22-v6so5207403lfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 16:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ugr4IvFNcAdu+NS6IpxtCRVJwoNCdyGr5eJ/ytQdEgo=;
        b=BaUVBrGPE7cRWBH7K8BJR7FUteqmErx0WhMgVyes7CTmgGvK9yvZz/B20XNkhPle83
         YQj0a1kqTEgMeotBlmZKsI+cIYTKw4SN2FQBz0fKXdnZcYX87xz9BwlCl1AYNpmfqH6Z
         PXLTu7hcA2H7mYOqJHoM83swljiEciF2TU2OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugr4IvFNcAdu+NS6IpxtCRVJwoNCdyGr5eJ/ytQdEgo=;
        b=EgxGjCaqs5Ti+dJYeFtqn6HjMq+yNaTLYiqFs6UhS86RnK0evsIhFF4ILrFSe/9T4j
         ImjDKFJio1w3RKCbvsQrSJOZ0r5Y18xCFrSos2enE0eMCt6R1ciPyIhZJVRvXRAiKFvx
         b/75q7XxoOs6ZKiGp63YPy8ERy3VWRl+2+ivi5eynXiDu5IeLCzPZEpZNMBVBJfyaROk
         IsgiFCs5eUugVCpiXqMJnFq5zVuz5x1d7qFiyJ4ju55/aQqLjt7WOs6b9SAJbzNovE0R
         RBzgM2tDi7HLANqYnGAvFi5jzdwwjqCGgsGQph3VMzFshur+hH0Dutkay8L6w/R6pDGc
         5cww==
X-Gm-Message-State: AOUpUlEFUS2MhM8hvEqZL673I8r3D3W9zBSvW6kjiM+HO2QtnY8eJlsh
        R9hY0ko2d8FbI9wa+wYiYQIrKsUuIsI=
X-Google-Smtp-Source: AAOMgpfopavOtyGQDDZoidiZlfbx3BvxpfZf6iIeFz9Dczuff8owfSvqf7hNFvMTQrMhAvc7qR3gcg==
X-Received: by 2002:a19:c64c:: with SMTP id w73-v6mr6047948lff.2.1533337600745;
        Fri, 03 Aug 2018 16:06:40 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id n3-v6sm1074694lji.96.2018.08.03.16.06.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 16:06:40 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id y17-v6so6153977ljy.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 16:06:40 -0700 (PDT)
X-Received: by 2002:a2e:9a95:: with SMTP id p21-v6mr6708025lji.60.1533337232747;
 Fri, 03 Aug 2018 16:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180731161340.13000-1-georgi.djakov@linaro.org> <20180731161340.13000-9-georgi.djakov@linaro.org>
In-Reply-To: <20180731161340.13000-9-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 3 Aug 2018 15:59:56 -0700
X-Gmail-Original-Message-ID: <CAE=gft7+3n-Phh-FdamSFRZVq49Z234_HfU3Ze0MGJiYXGEmcw@mail.gmail.com>
Message-ID: <CAE=gft7+3n-Phh-FdamSFRZVq49Z234_HfU3Ze0MGJiYXGEmcw@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] interconnect: Allow endpoints translation via DT
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 9:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Currently we support only platform data for specifying the interconnect
> endpoints. As now the endpoints are hard-coded into the consumer driver
> this may lead to complications when a single driver is used by multiple
> SoCs, which may have different interconnect topology.
> To avoid cluttering the consumer drivers, introduce a translation function
> to help us get the board specific interconnect data from device-tree.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c  | 62 ++++++++++++++++++++++++++++++++++++
>  include/linux/interconnect.h |  7 ++++
>  2 files changed, 69 insertions(+)
>

FWIW I don't have any strong opinions on whether of_icc_get returns an
error or NULL, other than to suggest following suit with what other
frameworks have chosen to do. Though perhaps most other frameworks are
not quite as optional for a particular driver.

Reviewed-by: Evan Green <evgreen@chromium.org>
