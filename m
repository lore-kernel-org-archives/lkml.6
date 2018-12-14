Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5956AC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA012054F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ww7eik0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA012054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbeLNA70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 19:59:26 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39075 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbeLNA7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 19:59:25 -0500
Received: by mail-vs1-f68.google.com with SMTP id h78so2391577vsi.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 16:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgsD9ciJgYkwLnc5LxoTiPqRPu3UU+7P/7miboedbXk=;
        b=Ww7eik0yCVL5JFp4NtYOx2Aq2VI4rj89hzTtAboCxccPjNz6pn7Y17/eJAng6yM529
         ngP0P73QK8L294XgxAxZ5xtPCr+ZVAv7JoB6SL5LKDl4hWfJN9Dg8KjB4q0sQoPfaLD/
         k3RvxIy2ksh5UNbQ/pDbmDchYC3guUpTT8/wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgsD9ciJgYkwLnc5LxoTiPqRPu3UU+7P/7miboedbXk=;
        b=lvVSAzVRVTkEp9TMTFkmJAU8UmYkzVkNiqCOcWOeaj22WzYn8qMxscb/0unwEDqRnA
         lW+ozFA4UkpVDP1+0SI0eu05XuHyNkpSsDoaX+8KqZwoZJPRinYeN/M3ZLohCfPNPyVT
         UVBvBGfMmepi8DxqE3j3ImZfp6de69yvIab4u3v8NfKQZi/LolMeC+ILQUipa+8GqioP
         aqcnuaaAmkv+3RWJRbT2mpSp2s37eAhdizYofz7JoqgKLKF5OXZ2rgUWupnJi/Q9nu/T
         mpuT5MqleNGQIdy02D2X1r/DJ/jiOlmYtKqAgl4hdWYue7xRof7XBEdHrrgZ7LIxWh9I
         Lc7g==
X-Gm-Message-State: AA+aEWYKhnOpiVEv3yzKAA8QXl8f0uhTFDntqdaHHOocYk+z0U4UxS0G
        ctBvb02K6I/h6XFezzJBXNkaTbLWvbA=
X-Google-Smtp-Source: AFSGD/WhMz/whJqvB9pc2grE7/t54Yo3M6RlEU8YsGJjNr8Z5TBNEujcvQnE51IgZ/Ks6LXNtK4vIw==
X-Received: by 2002:a67:4541:: with SMTP id s62mr455568vsa.25.1544749163898;
        Thu, 13 Dec 2018 16:59:23 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id n206sm1503097vkn.36.2018.12.13.16.59.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 16:59:23 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id e16so1413915uam.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 16:59:23 -0800 (PST)
X-Received: by 2002:a9f:3ba6:: with SMTP id r38mr477595uah.52.1544749162723;
 Thu, 13 Dec 2018 16:59:22 -0800 (PST)
MIME-Version: 1.0
References: <20181213194321.240148-1-ryandcase@chromium.org>
In-Reply-To: <20181213194321.240148-1-ryandcase@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Dec 2018 16:59:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XoZKLppEzh+MSK7wMTCNvzE174aLYTtjvbgY00dDTLCQ@mail.gmail.com>
Message-ID: <CAD=FV=XoZKLppEzh+MSK7wMTCNvzE174aLYTtjvbgY00dDTLCQ@mail.gmail.com>
Subject: Re: [PATCH v2] tty: serial: qcom_geni_serial: Remove interrupt storm
To:     Ryan Case <ryandcase@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 13, 2018 at 11:43 AM Ryan Case <ryandcase@chromium.org> wrote:
>
> Disable M_TX_FIFO_WATERMARK_EN after we've sent all data for a given
> transaction so we don't continue to receive a flurry of free space
> interrupts while waiting for the M_CMD_DONE notification. Re-enable the
> watermark when establishing the next transaction.
>
> Also clear the watermark interrupt after filling the FIFO so we do not
> receive notification again prior to actually having free space.
>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
> Changes in v2:
> Addressed Doug's comments
>  - Avoid M_TX_WATERMARK_EN writes when values already match
>  - Added note about M_TX_WATERMARK_EN triggering and latching
>
>  drivers/tty/serial/qcom_geni_serial.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)

Thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>

If I echo something out the serial port I now see 2 interrupts fire.
That seems about right compared to before where we'd get boatloads.
Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>


-Doug
