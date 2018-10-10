Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65227C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28046214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BK3wkl3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28046214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJJOmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:42:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40187 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeJJOmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:42:43 -0400
Received: by mail-io1-f68.google.com with SMTP id w16-v6so3134062iom.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V4+AD3EwFltS3outCF1jgU65qiPT/+fK8lPv6uY7r0U=;
        b=BK3wkl3jkVWvbo6meUbB+oN6/WuQR9JHZWY4mgARdt4HRlDz7wiUeiDckQTqpkiAbs
         tZR+0vzkwa9o/m7w5YtBA7RCIW1RNH490ngyWzKwtvQagOkyOBJbqK/ojB9alihP6mBm
         /CRfExhB5QCIWbeCl5VzsbEHNb8FnsrS+TSkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4+AD3EwFltS3outCF1jgU65qiPT/+fK8lPv6uY7r0U=;
        b=DneV9D1uby3ZqttCkN/QeInOCfh3sBzD2w0Np1C9+9wXLoUsGhvFt9HqYWL+U6Ublp
         h4OBNd3Fz53mXYLY6u6NDXoZvuclBqI99UGyqiT6GKo7HdSy5YbreM9dEfI5gQ9gjCie
         n59J7lm6rH2m8BQRd0jSdyUeHiqYUnP/Z2ux61xLg6ox3QyM516vvsT64917C8cQySgp
         giifGVJ40vSOJtWXqlm/vRjJ24ZhoQR4ZLxwBUMbamUUSpMfguK0X8Bp9g096MBuzG33
         GdKbZ9oVNuZ+7i8QGySY7DakNN6W5aHlNCVk6dIY3hpcohCzlDv/S4DDhOX2WHn914GC
         Jv0g==
X-Gm-Message-State: ABuFfojJYjTBvUmrpJm9dYtsZOwPjK3Y+swzcOsG0WvlbQ5CDvBnKkuG
        WifNh2gML9IQr911R5a2E3q1gor+sdB+BUlq+kvTGjN5
X-Google-Smtp-Source: ACcGV62Pz3xP4ajPvkmq7o1F2chc4FUTk/UUBgs00owDYuXqUGWdM5bE0i7RHuoTklI+4fFXwjA33EZS7QerUe6kRZw=
X-Received: by 2002:a6b:6302:: with SMTP id p2-v6mr15052660iog.175.1539156113764;
 Wed, 10 Oct 2018 00:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180928131531.4598-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20180928131531.4598-1-Eugeniy.Paltsev@synopsys.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Oct 2018 09:21:41 +0200
Message-ID: <CACRpkdbgOqXdKMnhMVHPsM-YzL5A4R03C+SPRxE4s5zEKW3aKA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] GPIO: add single-register GPIO via CREG driver
To:     Eugeniy.Paltsev@synopsys.com
Cc:     "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 3:15 PM Eugeniy Paltsev
<Eugeniy.Paltsev@synopsys.com> wrote:

> Add single-register MMIO GPIO driver for complex cases where
> only several fields in register belong to GPIO lines and each GPIO
> line owns a field with different length and on/off value.
>
> Such CREG GPIOs are used in Synopsys AXS10x and HSDK boards.
>
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
> Changes v3->v4:
>  * Cleanup 'include' section.
>  * Get rid of 'of_mm_gpio_chip' using.
>  * Get rid of custom 'creg_gpio_xlate' function.
>  * Get rid of dummy 'creg_gpio_get_direction' function.
>  * Small fixies.

Patch applied.

Yours,
Linus Walleij
