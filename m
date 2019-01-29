Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143A2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D970120844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kBLt7Pt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfA2SxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:53:02 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39333 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfA2SxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:53:01 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so16876904edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ne3/pZn84TgQpMnCsKdjR/xQBD4QmW9srnZyxCcRvp8=;
        b=kBLt7Pt6h1JdF4e6Uosih3sXSt/p3Rkw6TWiHxknI+gkw2S7neD4LuB72nHYoDbLuZ
         jXrvDxaGt/Q34FehM5dno73j8YzNutS21T1uhepAmAG7gS7+kLcbp+P85IpQv5CANsPW
         dAw2XFYWdH7KAhgzB+906hq4NXiWx5opE5A5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ne3/pZn84TgQpMnCsKdjR/xQBD4QmW9srnZyxCcRvp8=;
        b=dGJi44i5ytiHYNH4swKYNr1n2CckKyye3v6KV6Z31xBPQCTeeKKCAYNE+xlY1R1ze6
         C4tEktplu4vgioQkjRYSZEEWzxYNkNxngstJMI5GoTdAeaPyruR/LpaNwspBednrp+VP
         QOw5uipT/SR2IXF3Ev+43O3Q8qSh9CI/71HA1kfpGIbRKbBmHz9g7Iv7YQfsdQKOR0Sm
         v/R17R8/Zw4mSZ4MHWp0RobFRzRhFykbEI0BjMX2kdgcQlO6IIsNOD3I7t9RSvBJGl7U
         d6KdG2zCBvzZD+ZssT5/VAdnYB/W0CuB/NUBmBHkdjKeV1fLNV7WCW76nmH67wilpJn7
         i7vw==
X-Gm-Message-State: AJcUukdlHAceD1z/xiuVqyHb9Qh6q9XssGfpsnDVtfGu++a7Mggkp0Nu
        Sh20whphrvpH5uYqI/ZhbkK8rP2vtuA=
X-Google-Smtp-Source: ALg8bN5XRRWIjuuMrbbhRwEkSjFUnEpOezoQwAqb4ZtDDTOinDnNjF5qvoxpgEtEsVF5aH6sdgz4BA==
X-Received: by 2002:a50:e691:: with SMTP id z17mr25912202edm.275.1548787979820;
        Tue, 29 Jan 2019 10:52:59 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id w56sm14856088edb.72.2019.01.29.10.52.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 10:52:56 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id y20so16861000edw.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:52:56 -0800 (PST)
X-Received: by 2002:a50:951a:: with SMTP id u26mr26638799eda.4.1548787976141;
 Tue, 29 Jan 2019 10:52:56 -0800 (PST)
MIME-Version: 1.0
References: <20190128154310.17322-1-stefan@agner.ch>
In-Reply-To: <20190128154310.17322-1-stefan@agner.ch>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 29 Jan 2019 10:52:44 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPawX9QnHG-y6HYdhKSZbzzTzYpwt_oMaXPz5+pqC5Ddg@mail.gmail.com>
Message-ID: <CA+ASDXPawX9QnHG-y6HYdhKSZbzzTzYpwt_oMaXPz5+pqC5Ddg@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: don't print error message on coex event
To:     Stefan Agner <stefan@agner.ch>
Cc:     amit karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>, huxinming820@gmail.com,
        Kalle Valo <kvalo@codeaurora.org>, davem@davemloft.net,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 7:43 AM Stefan Agner <stefan@agner.ch> wrote:
>
> The BT coex event is not an error condition. Don't print an error
> message in this case. The same even in sta_event.c prints a
> message using the debug level already.

For some reason, that one (and a handful of others) uses dev_dbg()
instead of mwifiex_dbg() with an appropriate mask (e.g., EVENT). But
mwifiex_dbg() seems preferable for consistency.

> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Brian Norris <briannorris@chromium.org>

> ---
>  drivers/net/wireless/marvell/mwifiex/uap_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/uap_event.c b/drivers/net/wireless/marvell/mwifiex/uap_event.c
> index e86217a6b9ca..ca759d9c0253 100644
> --- a/drivers/net/wireless/marvell/mwifiex/uap_event.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_event.c
> @@ -300,7 +300,7 @@ int mwifiex_process_uap_event(struct mwifiex_private *priv)
>                 mwifiex_11h_handle_radar_detected(priv, adapter->event_skb);
>                 break;
>         case EVENT_BT_COEX_WLAN_PARA_CHANGE:
> -               dev_err(adapter->dev, "EVENT: BT coex wlan param update\n");
> +               mwifiex_dbg(adapter, EVENT, "event: BT coex wlan param update\n");
>                 mwifiex_bt_coex_wlan_param_update_event(priv,
>                                                         adapter->event_skb);
>                 break;
> --
> 2.20.1
>
