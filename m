Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDA8C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4502087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NSboZuQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4502087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeLCQW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:22:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45339 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeLCQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:22:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so6600075pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 08:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=1+jSbq/mwZcXtkckcWnWIXiikFvnkPIT0r9z07orVow=;
        b=NSboZuQouyFHAx2W1YN8eXO/p4qL2quUKsDFGsDptHBbS6miDxXwwPjJNqvsN+IPs3
         nDZE8/I8BcE4ETVyK/USDsJGCbOZ5IVOq6EUps3Iss9w6UnEcBf4U8iiOT34xsiiPEvk
         UycXMWk9+KetWYXcgyCJQmlGKK0tvbnMw792E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=1+jSbq/mwZcXtkckcWnWIXiikFvnkPIT0r9z07orVow=;
        b=hw8THQXrWxIObWxKksfWl+V8FzQu84xDyHtUfFNlHxeyzHV9Y71TuC1juuW0awJnNT
         402tUdbjgUWVq4jWvyxF16vSgnbOhwn719iRfBmQmCjpaLhyjEbx9y0VYj76Xw8sgApB
         ihDMn3V1f6BzzO2UGPF8FLUp59ZVZWZkOavIdzY6u+C/QxWSAolpIXdqlHobhsxsqZGV
         Ob46eT9HjDOM+ecxgu7+vf5laknswXW/15cn2y6scQM3FMxpYMlRqWAgQEPEl9jElJxn
         FEmHS0yQL0nXp9ZrwPwAp+TpJNfeIPOwBwBvif9/zBWiDqHEDqxpCdmU5G6mZCOMGY+d
         gA2g==
X-Gm-Message-State: AA+aEWbVIH2WKTwtNsvT94OLmOXgXLzGJIhMjs/MZf3nK/gLiyZgi74h
        6471Gbz9MrHh0utbFbUzKVFLpw==
X-Google-Smtp-Source: AFSGD/WJ3u8u47IhrMqJi485OZxejxnW7DNxKu6LmDJfzr2HK0FUxH9H3nXxWPnP42mcjKCMgVp8Ug==
X-Received: by 2002:a62:15c3:: with SMTP id 186mr17101128pfv.240.1543854137703;
        Mon, 03 Dec 2018 08:22:17 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 134sm16030678pgb.78.2018.12.03.08.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 08:22:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Ryan Case <ryandcase@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181130021840.75861-1-ryandcase@chromium.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Ryan Case <ryandcase@chromium.org>
References: <20181130021840.75861-1-ryandcase@chromium.org>
Message-ID: <154385413596.88331.2252934244242692154@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3] tty: serial: qcom_geni_serial: Fix softlock
Date:   Mon, 03 Dec 2018 08:22:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Case (2018-11-29 18:18:40)
> Transfers were being divided into device FIFO sized (64 byte max)
> operations which would poll for completion within a spin_lock_irqsave /
> spin_unlock_irqrestore block. This both made things slow by waiting for
> the FIFO to completely drain before adding further data and would also
> result in softlocks on large transmissions.
> =

> This patch allows larger transfers with continuous FIFO additions as
> space becomes available and removes polling from the interrupt handler.
> =

> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

