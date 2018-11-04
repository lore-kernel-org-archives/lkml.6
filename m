Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E52C6786F
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA4E2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QkuopuFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA4E2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbeKDLtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 06:49:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44678 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbeKDLtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 06:49:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so2750975plq.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 19:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=cqgc3kcouw24Io2BTHksvvcy14oQkEgewv3gwTE6fP0=;
        b=QkuopuFGWdRaVoDvoACp4k6lciOrM3nXn4WnmYDuZfAHHV5g1sGH/6c4yfwe/7G/mG
         ZWesFh7etLMCR4BucLTqQUw4yE9J07U66hJUOXLoSe7XSrsiY9bw8NCTMTdlTbgGmqPw
         hD8d303HN9rNTNt80BtgzPH7uOe123OPu61Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=cqgc3kcouw24Io2BTHksvvcy14oQkEgewv3gwTE6fP0=;
        b=tHCWt5/kRx8/8CtY5i26Ms6Lasaxfwf081KTkfHra1FHqrhwvu8kkIiy4VQjQl5E6q
         7uF02SeEuSicew/JRfVg/ygzzmT9RXWpug4YCc+IV2ZtQPF76UeoMl+wC+4h82tq6Z2x
         hRkGKuMhxnclooKoEkV77XcvI+syF+rySgwIoBs/1FiNpbTj8LEc+Ax681GoIdks9m23
         1KTM56To+TbRFfjZj5ZltqjMi2B6MlWaxrISX3KpLLbMb4QlxXGnehR0A7TPNkUNYmPN
         oOCPhumFW9BtMl4jBneuuY764tj2EtGB/+yKtVE4EYk5VdvW5xAgFKfvGdRzbCsD6NSt
         YhOA==
X-Gm-Message-State: AGRZ1gIXQLcQvJV8UDG+JyToxly/6dPJyn0NzCx5JEo/zC3OJcEeH75B
        eZ/7uE//WJUjUy+xd9dGeZ7SVg==
X-Google-Smtp-Source: AJdET5flYbV0EO3EzvvlKNa1jzgdpBiGSZqNr8j6P5q3jdZIBosJ1imJh9xcV5RtFS0AkFG4+DKRng==
X-Received: by 2002:a17:902:6948:: with SMTP id k8-v6mr17492031plt.22.1541299000591;
        Sat, 03 Nov 2018 19:36:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id u6sm12537903pgr.79.2018.11.03.19.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 19:36:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alok Chauhan <alokc@codeaurora.org>,
        Mark Brown <broonie@kernel.org>, dianders@chromium.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1540485629-5970-3-git-send-email-alokc@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>
References: <1540485629-5970-1-git-send-email-alokc@codeaurora.org>
 <1540485629-5970-3-git-send-email-alokc@codeaurora.org>
Message-ID: <154129899939.88331.3391593549002723465@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] spi: spi-geni-qcom: Simplify probe function
Date:   Sat, 03 Nov 2018 19:36:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alok Chauhan (2018-10-25 09:40:29)
> Re-arrange existing APIs in probe function to
> avoid using goto and remove redundant variables.
> =

> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

