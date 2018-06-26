Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D20EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2369E26E58
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q+lAYVgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2369E26E58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934187AbeFZUtN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:49:13 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35085 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934149AbeFZUtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:49:11 -0400
Received: by mail-pl0-f67.google.com with SMTP id k1-v6so9111459plt.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WzcTC852i/Yl3Lgxn3ZzphKcY/4lPfRKNmQWfOiFKoc=;
        b=Q+lAYVgwZsthN+7k4dGkNdDxIikLeBGcxBqgDoPpihaoj1cGvZTFldiG10z1gfGe58
         UpJYgeoPcwoGUVJEZspmvqJ+mw7extVZRm46SgJfnVq888tyWyT19UO6RBu7fFFxdPA1
         6jKQsFUnPFWYj0FFZsWLD4DdjCNxFPmJG37ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WzcTC852i/Yl3Lgxn3ZzphKcY/4lPfRKNmQWfOiFKoc=;
        b=NRZWFlPFw2I1KaGTvPlNSahJMw4RcoBpYcKmBnJTxyR0eq8VTQVBvkxQT44hT5rB/h
         HugBhKAduwfhTPpBhOvICkWjEpDNSdUrO78uQl69+RbpZzaKziYRR7UP8ednkwr8X27h
         iuJ37DhgbiYC02jnzblAxiecCf5Oht2/e56+ecopofrR1zZxbYRj5RnOCoIlnDt7J4AW
         NXlSoH9ehF4YnZSqF9Evt7hJnoAkGpvQ7qTdvoqTcsYWChxaq4dk6Wbwc3goow5wH74w
         VqO//aGlQlMbWuFD7Ost0AKJux4qeZ0RvKjOWT5IsmbIyTo1hRr99cAMzK43W8Yo+9nB
         GpTQ==
X-Gm-Message-State: APt69E0ZgCW12MXcd4lGyucppjGSdHi9Q/gWPih3jDZgaskh1yH6r8rN
        7DxuHfwSZvek311HFyS8siYT3Q==
X-Google-Smtp-Source: ADUXVKJ/oVVfC/vMxqayDYRf3zS3bMFFUtyosSoiksMJcI6hTvDyA/bpZG6v2vp9Ef3VvqEP3OyPcg==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61-v6mr3111395plb.274.1530046150830;
        Tue, 26 Jun 2018 13:49:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id v26-v6sm3646033pfe.13.2018.06.26.13.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 13:49:10 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:49:09 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>
Subject: Re: [PATCH] Bluetooth: hci_qca: Replace open-coded msleep()
Message-ID: <20180626204909.GP129942@google.com>
References: <20180626170654.96831-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180626170654.96831-1-swboyd@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:06:54AM -0700, Stephen Boyd wrote:
> These three lines make up what msleep() already does, i.e. setting the
> task to uninterruptible, sleeping for so many jiffies, and then
> schedule() already puts the task state back to TASK_RUNNING when it
> returns. Make things clearer by just calling msleep() instead.
> 
> Cc: Thierry Escande <thierry.escande@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-off-by: Matthias Kaehlcke <mka@chromium.org>
