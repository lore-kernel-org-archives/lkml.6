Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F60BC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB142238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kNulHAq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB142238B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeHIUg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:36:57 -0400
Received: from mail-yw1-f48.google.com ([209.85.161.48]:39023 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHIUg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:36:56 -0400
Received: by mail-yw1-f48.google.com with SMTP id r184-v6so5706183ywg.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4RrEydDCEio7MWq5+k5opw+Fr0sIad9fGcg/JLTUoA=;
        b=kNulHAq4KNeY1H1lA9l9Pkn9wy60o+D7bPFnqON5aAyGiPmp3wjb1YseK05G220hQs
         ZiXejc03ujVhfXcFJNiS9U0TVPOsgMb6xLpBjFjf2Sr1bX6XnLy4vx2blG3UJ5Ph3BqU
         NZDMEtbrfEwO8DHrPqneTIiTk9CepwO0n4+XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4RrEydDCEio7MWq5+k5opw+Fr0sIad9fGcg/JLTUoA=;
        b=l+SuMRJdOXgRoKBrGtaIcCLLbEryyh10Ul/PWUfUS7TNfEjtx9HJNoPydhAAvVDO/Z
         nOBu+lw+IxL3bxBUsTT73GIzGKrSvO8kGQhQkiOBwu3c02FGwC6XKPuI/OOd9UxAVQEj
         iYWb2/n4+pdIg8bEWKKIKZsqB3l2EaZhbKhNyQt1lMTK9RNRdOHVUHGyMOgAaWrL+WS+
         /3UMxSuBWVWB5QoSZpGRoxXf9wfa/AcJ4OxKV1Kh5QJbbykc6LbzEBNZYSGrOP96NvIc
         dt3aLUElKbuqrRBDaaYFESJlq73gF4k1+PDob4C6WBEny4VyS6g1qzE5+s9k38YlwIqz
         DAPA==
X-Gm-Message-State: AOUpUlE6BFPM6yDXZKbGpV3jgL1iM6HhdLciPQVtN/hjjbbzcovAzWw2
        uoUnqO79CGtoa2BhFtRqAuOgX3QfJDz7uPxExHbTW7Eu
X-Google-Smtp-Source: AA+uWPz2b6+IKIitUpiJFPALz8mJykZJMgJdBXecvoObdT+DRE+XC/CZnv2x1coEjIkw2sGm01hqAiwytAE60f+t/uM=
X-Received: by 2002:a1f:6681:: with SMTP id a123-v6mr1953632vkc.2.1533838255816;
 Thu, 09 Aug 2018 11:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180809171722.144325-1-swboyd@chromium.org> <20180809171722.144325-4-swboyd@chromium.org>
In-Reply-To: <20180809171722.144325-4-swboyd@chromium.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 9 Aug 2018 11:10:42 -0700
Message-ID: <CAODwPW_ZiRMqUehq969UxiyrkNOfaevrE-G03M2z_C+6dNAxyQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] firmware: coreboot: Make bus registration symmetric
To:     swboyd@chromium.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>, samuel@sholland.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -138,8 +136,10 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
>                 ptr_entry += entry.size;
>         }
>
> -       if (ret)
> +       if (ret) {
> +               bus_unregister(&coreboot_bus_type);
>                 iounmap(ptr);
> +       }

nit: maybe cleaner to just do if (ret) coreboot_table_exit(); here?
You're essentially writing the same code again.
