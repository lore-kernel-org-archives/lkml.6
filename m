Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BB408C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7020F208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFEGv+lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7020F208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935629AbeFMNQ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:16:28 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33443 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935375AbeFMNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:16:26 -0400
Received: by mail-lf0-f67.google.com with SMTP id y20-v6so3919941lfy.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ldBvsljY0FNj7QsJ4vmm+0gDFxd2nEx0SWMhHY0uwA0=;
        b=CFEGv+lhDnp0wUhNOlxDoA8wjRBuT9jWghRagdn6Kpfo26OjQQ+q2LYHIVvrMuXAC5
         2HjTaYDqdeyrJtz9wa7qNAo/LQvplqYdpa6j4OvqWc5+IyC5Tg4R0QoA57M1uZgrxJjl
         /r6NzWMDCnNTv8KgKMnrNQJ1gr1s/W6AlFOvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ldBvsljY0FNj7QsJ4vmm+0gDFxd2nEx0SWMhHY0uwA0=;
        b=ZqDMlcm3nrviyAH+T6Ur8C+wWSad34QrOPIlQ+kTJN9RA/pMVNKsvn6ZI7UYMW0SV+
         jTk1206DEK+5T4UdTxXAA+DdTANHI1MbmduC4iEjBOXAdXpymkyrR2PQfD2WyVOSqseX
         ZYuJ8XV734IHsqbtt+lr7xyjseLJwOVvRnL9KtrmWm1aLjw85nD2ccv5ex1h2ix/8BH8
         hkZSpo6b3epG89hOjsPJ84pVc9crTK9tOekVRhNE5fJZ/20VjeM8S6qZgaxJCDd145wy
         4ut1nOE8EsCwHwfDO7WAAKdhYOqwhO40I2UTA/SI0iw9gHHphdlsb76UB1RJ0UA8Vumj
         LVqA==
X-Gm-Message-State: APt69E2T0+/UltVYojQcweeU6WmLS0chTgPTC+vBscMUaYVVbNuUK72K
        viyOCZ2k9/3pz1W+CgeLY/KDBQ==
X-Google-Smtp-Source: ADUXVKLk5RoVkSdJ1SVx8sQSiuhv9CkdL4bnQuRCohIojmTHlygUjfEc89v6vN05R5FK64erOXlAWA==
X-Received: by 2002:a2e:9614:: with SMTP id v20-v6mr3128139ljh.127.1528895784835;
        Wed, 13 Jun 2018 06:16:24 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id i28-v6sm576411lfb.89.2018.06.13.06.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 06:16:24 -0700 (PDT)
Date:   Wed, 13 Jun 2018 15:16:22 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        andy.gross@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/5] rpmsg: smd: Add missing include of sizes.h
Message-ID: <20180613131622.GA12260@centauri.ideon.se>
References: <20180613125401.11734-1-niklas.cassel@linaro.org>
 <20180613125401.11734-2-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180613125401.11734-2-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 02:53:56PM +0200, Niklas Cassel wrote:
> Add missing include of sizes.h.
> 
> drivers/rpmsg/qcom_smd.c: In function ‘qcom_smd_channel_open’:
> drivers/rpmsg/qcom_smd.c:809:36: error: ‘SZ_4K’ undeclared (first use in this function)
>   bb_size = min(channel->fifo_size, SZ_4K);
>                                     ^~~~~
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---

Argh, my git send-email scripts were too stupid to add Andy
and linux-arm-msm to this patch.

Some of the drivers in drivers/soc/qcom depended on this file.

Not sure if this patch should go via Andy's tree or Bjorn's.

Regards,
Niklas
