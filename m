Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DA0C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E3C25B95
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YHX+t7sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E3C25B95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964944AbeGBIqI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:46:08 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37775 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754308AbeGBIqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:46:01 -0400
Received: by mail-it0-f68.google.com with SMTP id p17-v6so10988416itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hu3YB4aTDzQkwHe0CsJ3yqG4TFyhP303lI1XPSQULEo=;
        b=YHX+t7sbHh2Gxjjz9KY0/cI6LI6WdGEh7hse+PA0X1eo49SzE0fyzQj9a0GRJhDEvo
         HypS12/t0a2sFOhxIbAHXPo1O0qdnTftOA3lBP9n62Noua/Trw9EXe70j0t9XXqmJ30W
         jmaAnuzGlP2n2f0QSvL4oTjYI2oqvJ7OMZix4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hu3YB4aTDzQkwHe0CsJ3yqG4TFyhP303lI1XPSQULEo=;
        b=B1vSnfyx85PeUd2B+3cZ5vrrLCcPfDYoKnh046LeCKN13dZIZhLBeqhU5j+ilz5LLw
         LI7MoBtIYanX9La4iyNwheyrgjeNJ0pYKcVIZOGmdsSmon7Yatkq8P0TD7Y3D2Z6I+id
         QMiXU+RlEkY1ifJ4Wed6zqOJP2s0YUYVXWXfSc+fvR0FA0bULWzuJRYMA+CDyxzSc1B+
         0ybnQX0135RWTgamuB1i0X1bSu7mQEJ7NEwoOD2Kx/CtpOuIM8mErsKUl5y9e57qYf3X
         Kw+f28T/1oX91wBbEjV9VNHujlVPHpzs6m1yHL9JG2LT2quiTd15PFXu6XqO1BRpG5nX
         Az9w==
X-Gm-Message-State: APt69E2wzs2qDRaGg11cZAEBkKo3zfXo9CvLGNy3c/hpaLpFobP2Mqhq
        Scu+5XYaJIddbv5AOOg16vwZoujYMUs=
X-Google-Smtp-Source: AAOMgpf3lcjCrTjK2QUZPwBOVM+bSxU1Y+KL01SaQW13SlmA9jGGYQQzltnwMUphCSv3KCwl84Gczg==
X-Received: by 2002:a02:1857:: with SMTP id k84-v6mr20356378jad.3.1530521160545;
        Mon, 02 Jul 2018 01:46:00 -0700 (PDT)
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com. [209.85.223.180])
        by smtp.gmail.com with ESMTPSA id q187-v6sm6875468iof.67.2018.07.02.01.46.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 01:46:00 -0700 (PDT)
Received: by mail-io0-f180.google.com with SMTP id q4-v6so14044315iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:46:00 -0700 (PDT)
X-Received: by 2002:a6b:b342:: with SMTP id c63-v6mr19633605iof.204.1530521159756;
 Mon, 02 Jul 2018 01:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org> <20180627152725.9783-13-stanimir.varbanov@linaro.org>
In-Reply-To: <20180627152725.9783-13-stanimir.varbanov@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 2 Jul 2018 17:45:48 +0900
X-Gmail-Original-Message-ID: <CAPBb6MW8FW4u+8oi8=qyngEzrS6C1nnU6RCySzngcpi81-X6JQ@mail.gmail.com>
Message-ID: <CAPBb6MW8FW4u+8oi8=qyngEzrS6C1nnU6RCySzngcpi81-X6JQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/27] venus: hfi_parser: add common capability parser
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:33 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> This adds common capability parser for all supported Venus
> versions. Having it will help to enumerate better the supported
> raw formars and codecs and also the capabilities for every

s/formars/formats
