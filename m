Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACD0C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA9E2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fLGy75rA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA9E2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeHOChN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:37:13 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37514 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeHOChM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:37:12 -0400
Received: by mail-yw1-f67.google.com with SMTP id w76-v6so17584847ywg.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 16:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x4PfsOFaxf+JiaWC2eZH5OHGKlA5mbb0Xfvpn5E8YGY=;
        b=fLGy75rA2JHncdI9L1RZ7Zl9KmOAwR+JUmc7IQyTpudhOATk0fcft1rhcycqXqSGUG
         oSt2fg2edX/bLSBFJEjHEqGAL7pTHRiibih9JnjxfUKz3qQjZx3y+xQz7nKC1GtiwBsw
         X/WAzk30SSFTp6LExhxzbrsaxuo9L5F2lGs60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x4PfsOFaxf+JiaWC2eZH5OHGKlA5mbb0Xfvpn5E8YGY=;
        b=CdAJHYCJ8JPEPhEnet3RnqT2frZteGlO9CEhqppn69L5x8fakMe7udqqOv/5q3n5z9
         Y2BS7pXOU2WeUCYPsBnscuQxXy7ENWQIYy/rvOldsg370JtsED+ihgwY8DUd9kppCePQ
         8bnHbkx7p1tHvehSH/4OE0bsX86/WljzbGdITXKbd40LIZJy9/a+nlDoSag8SeH1rGDx
         DVV7Se5nIO3lyLCJ6G+8+ur79HeiBbIzlvcNKBKFS/8YE/LjvVJ48jafFgsLewYaL5T3
         ATj1G2F+6Idb3R26nP7yoVuq0K37zSO+y4wnygP/NIav6xRrl5rWFaiclvZh63lKC75f
         wXXA==
X-Gm-Message-State: AOUpUlFxVgf4ctrQsyK7Yn2jocnU9l+Hv1lxrojAhy6OEpeAdeeTtggM
        pAXM3vacMsTIQfAhHqZQ20vzR2CSj7g=
X-Google-Smtp-Source: AA+uWPzVX2vY0Wuovf1cddt/CLoVnduKVLiO9JQXxQmI2V8AjpDIvGN2VYra7JQlJliC7uTD9aLkfQ==
X-Received: by 2002:a0d:fa42:: with SMTP id k63-v6mr13686075ywf.53.1534290458506;
        Tue, 14 Aug 2018 16:47:38 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id 139-v6sm14423708ywr.61.2018.08.14.16.47.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 16:47:36 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id w76-v6so17584775ywg.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 16:47:36 -0700 (PDT)
X-Received: by 2002:a81:b248:: with SMTP id q69-v6mr12519355ywh.38.1534290455915;
 Tue, 14 Aug 2018 16:47:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cc84:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 16:47:35
 -0700 (PDT)
In-Reply-To: <20180814223519.13610-1-surenb@google.com>
References: <20180814223519.13610-1-surenb@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 14 Aug 2018 16:47:35 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLAJnJpW4JKhfA=y7Nyt+_6svC5-sCAThubFgdCF1JZbA@mail.gmail.com>
Message-ID: <CAGXu5jLAJnJpW4JKhfA=y7Nyt+_6svC5-sCAThubFgdCF1JZbA@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFC: Fix the number of pipes
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Security Officers <security@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kevin Deus <kdeus@google.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 3:35 PM, Suren Baghdasaryan <surenb@google.com> wrote:
> According to ETSI TS 102 622 specification chapter 4.4 pipe identifier
> is 7 bits long which allows for 128 unique pipe IDs. Because
> NFC_HCI_MAX_PIPES is used as the number of pipes supported and not
> as the max pipe ID, its value should be 128 instead of 127.
>
> nfc_hci_recv_from_llc extracts pipe ID from packet header using
> NFC_HCI_FRAGMENT(0x7F) mask which allows for pipe ID value of 127.
> Same happens when NCI_HCP_MSG_GET_PIPE() is being used. With
> pipes array having only 127 elements and pipe ID of 127 the OOB memory
> access will result.
>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/net/nfc/hci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/nfc/hci.h b/include/net/nfc/hci.h
> index 316694dafa5b..008f466d1da7 100644
> --- a/include/net/nfc/hci.h
> +++ b/include/net/nfc/hci.h
> @@ -87,7 +87,7 @@ struct nfc_hci_pipe {
>   * According to specification 102 622 chapter 4.4 Pipes,
>   * the pipe identifier is 7 bits long.
>   */
> -#define NFC_HCI_MAX_PIPES              127
> +#define NFC_HCI_MAX_PIPES              128
>  struct nfc_hci_init_data {
>         u8 gate_count;
>         struct nfc_hci_gate gates[NFC_HCI_MAX_CUSTOM_GATES];
> --
> 2.18.0.865.gffc8e1a3cd6-goog
>



-- 
Kees Cook
Pixel Security
