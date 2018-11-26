Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25636C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0ADE20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0cSNRTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0ADE20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeKZWRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:17:10 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34444 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeKZWRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:17:09 -0500
Received: by mail-oi1-f193.google.com with SMTP id h25so15478609oig.1;
        Mon, 26 Nov 2018 03:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wh72EPnqaGyYgk3Gl1t4ySpWdc0RnFKuyA6do15oDBU=;
        b=t0cSNRTb9Qf1nGwX6gx4h4nrf71b3kRURxcYARpHFDvZ8bMQ3se5ScHTe8PVJCg3Sy
         017OgVpp1G9B1nBsYUQijPo69XTA5R9ExlGG+xJQsnF5TCL1MTOS/MD303kzoSbS5ZwE
         vlLtsnbxSYZ9a7G2ehtu1ezyw6Hpi2TYD3bm7G3HJnhm6Z2lpar4J1eSifv/UfZTO19p
         DF85+mZRHCPX9d6jNgkGkli+iQBVaPD3VQdSLTEDtWfWmTs6xlLSlA+NVVdId9pWGsY1
         zyDduYBVx2jMpRt0jIhvqhs/1is7NjloyCVmywWhgvg5ZCI0cB5hiwHTQ7kp98n97llu
         jw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wh72EPnqaGyYgk3Gl1t4ySpWdc0RnFKuyA6do15oDBU=;
        b=XHwpVtxod6X6pcom2RHsoL/HcuoEaqU3rrpdLAEo19Igl0+Op8N989oW42fds+l6c9
         74nyliwc3s3kqFBI4O8OWQHEvjewvn8t1rzrhzPmA3cWqGyYm+zHTWiAY49A7V5tRKa/
         l0KXLpiF81xehB47kB4J9PAUiVLA+0TpsxhEAZDWyaVmFWxqYQWh18gG9rpMbVomG6My
         IxuwsjBMBHg0qfqSCoO/rfZpdzgJUpqNkPnrLa6Hx518lUG5PvFvpJobfFujvlAf1AJJ
         gWiryFJUHNSbH6rGbl630EqwRBEULamHclJ14rFHRbdd5oDMZLnMA6C7+TAZdA8NMsrm
         c2YA==
X-Gm-Message-State: AGRZ1gKgsGXJxlKwAFLqdjyHwd/31BPoP+iYVB9hZb8fmRWb/3TC2xRJ
        67w9fK7thDeqJ85M7L8KiPJQ8eJ81+4O1/7mHz3CCOgd
X-Google-Smtp-Source: AJdET5fvpi4l0e4i0KMJ/CT50/KxQ8u2EFx2TrY7IgwGpp8mm9/HIi5LPeB7XRzZUibU+rJ5S7dRbrSDzHY0yHknrP0=
X-Received: by 2002:aca:47c6:: with SMTP id u189mr15437722oia.250.1543231399015;
 Mon, 26 Nov 2018 03:23:19 -0800 (PST)
MIME-Version: 1.0
References: <5A23C871-B30F-44C4-898B-C138EFDB4893@holtmann.org> <1542245517-150977-1-git-send-email-zumeng.chen@gmail.com>
In-Reply-To: <1542245517-150977-1-git-send-email-zumeng.chen@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Nov 2018 13:23:07 +0200
Message-ID: <CABBYNZL3Z0qL4F=uC1j5BYfARs2ByRMvc7uudTEPxs8GTuqoag@mail.gmail.com>
Subject: Re: [PATCH 1/1 v2] Bluetooth: make the balance of judgement condition
 to fix a false report
To:     zumeng.chen@gmail.com
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,
On Thu, Nov 15, 2018 at 3:37 AM Zumeng Chen <zumeng.chen@gmail.com> wrote:
>
> This patch is to balance the condition scope between hci_get_cmd_complete and
> hci_event_packet about orig_skb as follows:
>
>         if (req_complete_skb || event == HCI_EV_CMD_STATUS ||
>             event == HCI_EV_CMD_COMPLETE)
>                 orig_skb = skb_clone(skb, GFP_KERNEL);
>
> And hci_get_cmd_complete will bt_dev_err out when HCI_EV_CMD_STATUS, so a lot
> of asymmetric conditions are triggered. Since both of them are the entry into
> hci_get_cmd_complete, we'd better get STATUS into judge the false out there.
>
> Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> ---
>
> v2: remove redundant braces and adjust the indentation.
>
> Cheers,
> Zumeng
>
>  net/bluetooth/hci_event.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 235b5aa..1d2a8fe 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5217,7 +5217,8 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
>                 return true;
>         }
>
> -       if (hdr->evt != HCI_EV_CMD_COMPLETE) {
> +       if (!(hdr->evt == HCI_EV_CMD_COMPLETE ||
> +             hdr->evt == HCI_EV_CMD_STATUS)) {
>                 bt_dev_err(hdev, "last event is not cmd complete (0x%2.2x)",
>                            hdr->evt);
>                 return false;
> --
> 2.7.4

It appears we need this also for enabling vendor_diag with intel controllers:

[399314.236288] hci_cmd_status_evt:3138: hci0 opcode 0xfc43
[399314.236291] Bluetooth: hci0: last event is not cmd complete (0x0f)
[399314.236359] Bluetooth: hci0: Changing Intel diagnostic mode failed (-16)


-- 
Luiz Augusto von Dentz
