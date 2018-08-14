Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B970C4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B8F2159D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="js3Huzd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B8F2159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbeHNDNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 23:13:06 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40044 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeHNDNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 23:13:05 -0400
Received: by mail-yw1-f67.google.com with SMTP id z143-v6so14979285ywa.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5oqwfup2I58M8VNSjFe/oH2yEVa9Y56R1Sq+5mxBGK4=;
        b=js3Huzd/D/sUiIaO4FOpXLWfVwGD6urg7X6E+6XJWbgZaKTJ32sbKhFgck5ddf0sSu
         riKB0CYqT3l/HbebX55lTna9VKan2HzIfDfdtk84nABCBM/CpTE+X78vTdVv60fRvQO0
         /RAUVyo/icqrb4jrcRlVWNll5rnXgdcUK6KbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5oqwfup2I58M8VNSjFe/oH2yEVa9Y56R1Sq+5mxBGK4=;
        b=hJovWZH4PaDnmOw2vfehYbSpeoPNmsHx1cs3bFWg2CLjsoNHQxcI7dmJFr6FV4bT2h
         d3tj8HfNTylYLT/+WgtQP+vgiTicN617Iz+UFBSHmz/hKt9OusEyRdKrf0N58pk8h/dz
         5v0PFtPwRltzecZZ+xxpBNFG6+TEdmInY05eNiriXORoKpFnZgM8htjvL+E0tEa8xxSY
         tezR/zeDkrRASkqvn/+Qae9gHwuM2BU1ND03ufZ2KreuYoIgvqqtG8orb8MiE/FvIgOq
         At5aMZ1dXRYdvskGWE1H0vVPindrT8E7SZSWRPCAkjEpEEJIBTa/N87DTSzPcNIm/wZG
         /TTQ==
X-Gm-Message-State: AOUpUlEOH8UFGE6DR/6IrhvoZmSTl+p4bdA0UwsXxAd0CixMB6B6yN2R
        +w9E8aylfhLoq6f2/Jw1/P8qUVa+Rak=
X-Google-Smtp-Source: AA+uWPytuz5+OREb4bKwbdY6sS8S/Efiq7k7BhDq8b147dCQy3jtgv6Uuvlrdnx4Q/kXOfuUmG9Teg==
X-Received: by 2002:a25:3f83:: with SMTP id m125-v6mr10123932yba.342.1534206507206;
        Mon, 13 Aug 2018 17:28:27 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id b135-v6sm17973229ywh.24.2018.08.13.17.28.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 17:28:26 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id l189-v6so14977242ywb.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:28:25 -0700 (PDT)
X-Received: by 2002:a25:afce:: with SMTP id d14-v6mr9958720ybj.343.1534206505041;
 Mon, 13 Aug 2018 17:28:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2316:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 17:28:24
 -0700 (PDT)
In-Reply-To: <20180813223910.26276-1-surenb@google.com>
References: <20180813223910.26276-1-surenb@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 13 Aug 2018 17:28:24 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJGxr8fEJDEVciDo1VcF95brx31fAWV0ydYQj6Nq81MqQ@mail.gmail.com>
Message-ID: <CAGXu5jJGxr8fEJDEVciDo1VcF95brx31fAWV0ydYQj6Nq81MqQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFC: Fix possible memory corruption when handling
 SHDLC I-Frame commands
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Security Officers <security@kernel.org>, kdeus@google.com,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Allen Pais <allen.pais@oracle.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 3:39 PM, Suren Baghdasaryan <surenb@google.com> wrote:
> When handling SHDLC I-Frame commands "pipe" field used for indexing
> into an array should be checked before usage. If left unchecked it
> might access memory outside of the array of size NFC_HCI_MAX_PIPES(127).
>
> Malformed NFC HCI frames could be injected by a malicious NFC device
> communicating with the device being attacked (remote attack vector),
> or even by an attacker with physical access to the I2C bus such that
> they could influence the data transfers on that bus (local attack vector).
> skb->data is controlled by the attacker and has only been sanitized in
> the most trivial ways (CRC check), therefore we can consider the
> create_info struct and all of its members to tainted. 'create_info->pipe'
> with max value of 255 (uint8) is used to take an offset of the
> hdev->pipes array of 127 elements which can lead to OOB write.
>
> Suggested-by: Kevin Deus <kdeus@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Nice find!

Acked-by: Kees Cook <keescook@chromium.org>

> ---
>  net/nfc/hci/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
> index ac8030c4bcf8..19cb2e473ea6 100644
> --- a/net/nfc/hci/core.c
> +++ b/net/nfc/hci/core.c
> @@ -209,6 +209,11 @@ void nfc_hci_cmd_received(struct nfc_hci_dev *hdev, u8 pipe, u8 cmd,
>                 }
>                 create_info = (struct hci_create_pipe_resp *)skb->data;
>
> +               if (create_info->pipe >= NFC_HCI_MAX_PIPES) {
> +                       status = NFC_HCI_ANY_E_NOK;
> +                       goto exit;
> +               }
> +
>                 /* Save the new created pipe and bind with local gate,
>                  * the description for skb->data[3] is destination gate id
>                  * but since we received this cmd from host controller, we
> @@ -232,6 +237,11 @@ void nfc_hci_cmd_received(struct nfc_hci_dev *hdev, u8 pipe, u8 cmd,
>                 }
>                 delete_info = (struct hci_delete_pipe_noti *)skb->data;
>
> +               if (delete_info->pipe >= NFC_HCI_MAX_PIPES) {
> +                       status = NFC_HCI_ANY_E_NOK;
> +                       goto exit;
> +               }
> +
>                 hdev->pipes[delete_info->pipe].gate = NFC_HCI_INVALID_GATE;
>                 hdev->pipes[delete_info->pipe].dest_host = NFC_HCI_INVALID_HOST;
>                 break;
> --
> 2.18.0.597.ga71716f1ad-goog
>



-- 
Kees Cook
Pixel Security
