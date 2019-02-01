Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A10C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0E620857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAxpb778"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfBAFGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:06:15 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38472 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfBAFGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:06:14 -0500
Received: by mail-ed1-f49.google.com with SMTP id h50so4426350ede.5;
        Thu, 31 Jan 2019 21:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FSRSNi5MOw4SiSm3JrXZg7KNmGM0qHdGPP9HeFaxeis=;
        b=HAxpb778yYcFtlkN7jJK7AbXoUpGCHojq1b07yGYe8OlmoD+UgGLsAx0zEiWB3vQ8x
         la4LOGuAV3y4r8DypT4kCGgZufNzd4HWtURwsF8lr7E26PFN4DYS/Q9ZGDo8guQIi+tu
         kx8tMBeN13gelkWrwh5pVyYOeM5MrlftM+211daSQu2fC3zmS1dbSzmvxhCOPfEnOPqJ
         qSQ9+jMamjp+JOaCGFlh282HOGSBIwAoSDqIBRjw9Br3vHv9YG/0hZej5cc0A2nfn4OV
         UyhySSDndT5hJVZgGhpfWKD3ypW0ViSPyY40AEr8OVc9/UNfiGmAAa2DVIkwIOCn5DaX
         HHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FSRSNi5MOw4SiSm3JrXZg7KNmGM0qHdGPP9HeFaxeis=;
        b=rBOlyxGlIHuVIE//xIj0C4gXt7QBqzEKk7I5oNv/iolxr+ffMCh46l7HjUHZD/1DQP
         opPi8lSkd6vsmQTUqpgiSnSdizb8lfLxI95ywM2SJNhI1HuZ5D/HxnNKsekpVIX2ux6z
         vKfbRpalih+XHL1sd2nvpkOl7XtEr/WhyRvhEmdbwdgk+MjdZFuzA4Qorm0ynLqrfajl
         Nv3h7Qa4szZdK8w3zn43po6M8W3AZoriLStIUi0uC+iFHmEv0VoX7nuFkTizGJxke+PU
         NEt5DxsYSZ62yCa9uJQ8h3T998GoZBbdPqkIila23WrSYykgMBIUxFMPSHfufQiwH/tC
         VJ8A==
X-Gm-Message-State: AJcUukfduo+oYpCrpNH/RoAc7G5W5UQHVfDOWO2LvcJG09BFWsIKbb1R
        +YedcAJgXe4h2PDgwqF33Ew=
X-Google-Smtp-Source: ALg8bN7u41zUzpyqld69uHpsxAzgboPoZwFTqYRRlcRjut7GpsHy/VMHNqNQ7jPnSYB/HP+/E2axlQ==
X-Received: by 2002:a50:c408:: with SMTP id v8mr36948229edf.144.1548997572449;
        Thu, 31 Jan 2019 21:06:12 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id c26sm1791081edb.15.2019.01.31.21.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 21:06:11 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ray Jui <rjui@broadcom.com>,
        =?iso-8859-1?q?Scott=0A?= Branden <sbranden@broadcom.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] soc: bcm: bcm2835-pm: Make local symbol static
Date:   Thu, 31 Jan 2019 21:06:02 -0800
Message-Id: <20190201050602.27265-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1547617457-60066-1-git-send-email-weiyongjun1@huawei.com>
References: <1547617457-60066-1-git-send-email-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 05:44:17 +0000, Wei Yongjun <weiyongjun1@huawei.com> wrote:
> Fixes the following sparse warning:
> 
> drivers/soc/bcm/bcm2835-power.c:556:32: warning:
>  symbol 'bcm2835_reset_ops' was not declared. Should it be static?
> 
> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Applied to drivers/next, thanks!
--
Florian
