Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76F7C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FFA27E48
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sj4ZZtrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FFA27E48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965175AbeF2U1v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:27:51 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35105 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937359AbeF2U1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:27:49 -0400
Received: by mail-vk0-f66.google.com with SMTP id o202-v6so6047331vko.2;
        Fri, 29 Jun 2018 13:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7MegwICDCW0a7zovTooM+UO42JJGMqBHmkKbNO9iiQ4=;
        b=sj4ZZtrqBTu+oDGpCDakPI26yVTAkDcY+DXiVa3G4QnqCg9KEM2enoS55VxaHdQBb7
         YiXvWfzE6zVQynNhQ77F2uEeqT+dwgAwglJITGU86gCRux2ZzaMwNqGAD+pkmtj4h1xM
         7Hsdo+OJU6Ka+WkCM/ZUD1+dCQ0ISI656EnFOM3k2MBwVbjVSjk0sVJ7yXVFB8Y42UkK
         su7KVugH6YGFe0f4wLlsWzhf6di++I1FPsdezte6WG+6Mklw5PYMWIJhvcotJXaLKFrF
         D1mbDhE1DjVmdN5+gO6Yrxnrc+LMYbACMYUYqR+cKOdoOtID0sE6mYodJRS+hThq5b8S
         qiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7MegwICDCW0a7zovTooM+UO42JJGMqBHmkKbNO9iiQ4=;
        b=bcwHXPXilAAEAXXHApgFcsjTjZ69U+TvfK/yI/Q6cs+XULmMNy44ZlLvsT067GBLqM
         nroxrfTpxFf2lGvcdS1AQDMw4V5uXHwiysFoNEC8NnWehW+U/z2HsQpaTGCY0hRByOnh
         Xi5B87bTri5FWogHAtfvTzp5XA+913eQHMB57Bm8qShQtJZ5QB6AkWgnopI6f4IRMGC1
         EhHp5Ti6xBkKRA5hkjaJcOSRBtbtnt47jdzs9nJMTDYib+zigMCaL2QkuCbbsmA9RULQ
         hCIXEKKFAgz4RhrOXhFZljreAYmyuAkuzVy1XC81OkfPnth7TVdYABD/n6na5TVwoiGC
         ebpA==
X-Gm-Message-State: APt69E3ubeZo+AwJUvJgQzbPoJT9buUANqZxZ1m/QCGusd74k49T1WW4
        KAcBDls69oW4InOFqRqiZxhb8bPn362619dCoLU=
X-Google-Smtp-Source: AAOMgpfsAtqbNDuiwuWo3qCpR7F6MBAHuYFU9VBGTL0ligMjg32LYyQZBF/7j/2mX7FIMsVeIi/x6QrjK/iIhFk1BXQ=
X-Received: by 2002:a1f:7d09:: with SMTP id y9-v6mr4156088vkc.15.1530304067524;
 Fri, 29 Jun 2018 13:27:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 13:27:46
 -0700 (PDT)
In-Reply-To: <CACRpkdbhxjahYaVnQN0xqD0NLPouO8VCW8w-GZD0sbLFtFtY5g@mail.gmail.com>
References: <20180622043134.18238-1-benh@kernel.crashing.org>
 <20180622043134.18238-2-benh@kernel.crashing.org> <CACRpkdbhxjahYaVnQN0xqD0NLPouO8VCW8w-GZD0sbLFtFtY5g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jun 2018 23:27:47 +0300
Message-ID: <CAHp75VfshFLuvOSB4deALX=EUf2Z_RW4Ct-K5cMsAj4yifF-cg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/14] devres: Add devm_of_iomap()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-aspeed@lists.ozlabs.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 12:14 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> I wonder if it is easy to find these cases and replace them with
> this neat function...

Would be reasonable easy by using coccinelle.

-- 
With Best Regards,
Andy Shevchenko
