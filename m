Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E9CC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C737F21534
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SB4W5l5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C737F21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeHMT6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:58:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44138 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbeHMT6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:58:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id g6-v6so11758792lfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7nSzP2V3+5GZ9xIaPOnxQcrfFzf7lMDS57Gg3JwOek=;
        b=SB4W5l5FH3wLkm4tWqRIucoDAPSffWhXrrzzLwUAVd3TsNlRu+ZYjScJ34Is5U2Zen
         XiQUedEQCObmWvM2oNx4g5nRF29ot1fkA5Ue8cdafcICxTfp7srTTb71X1TMRncwa8W8
         JK6jHrgAb7QYjAi9n+mP1BvctiP/iFdIvapkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7nSzP2V3+5GZ9xIaPOnxQcrfFzf7lMDS57Gg3JwOek=;
        b=qE2xVYEFsETNKjBfK+PT3hYdgM8HJCjtDmObVhY0uGZOB9i0m6hpf/V/muVk4uk8Cx
         YvJUCds6k9sKu3wRQT1zW64aff2sof18OTQEHiG2tA9Tt1krKy/uUWmK1byz4eVAcULN
         wqI6Y095AOpUl24nk4IjCIWtCxnRwns+i6yW94PbLPkIVkrFivEguasAjyQs6iZ+9UDy
         /+HL3aE4PF7ikIuh2PHEtDZqey0Cvk4zni+KWLpjZ1D22++LhqNq998p8l6Q3Vjhg73E
         eZ8Y0ON1nrG7lIf9EGb0k2fwQvWjCKBg8n+b3j7E0L+aWb6RoX5+KPVaFIJlLEBy4m+R
         C3EA==
X-Gm-Message-State: AOUpUlGkCQpY/p/Px0eNfmqzmt4JBZPccIGqfKyCe3UmInlElwjYBOz+
        fLTgtqvLSykXqNuDItiEL1+RTv5bzLE=
X-Google-Smtp-Source: AA+uWPyJ0gM9cIlH7GG9cZXQwaYwyS6slorm8i702LSlV2uXXnLr6g1oUEXZkKWiGvTgHzD9jANGpw==
X-Received: by 2002:a19:8f10:: with SMTP id r16-v6mr11831993lfd.92.1534180499280;
        Mon, 13 Aug 2018 10:14:59 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id t24-v6sm3172612ljb.89.2018.08.13.10.14.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 10:14:58 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 203-v6so13140457ljj.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 10:14:56 -0700 (PDT)
X-Received: by 2002:a2e:8514:: with SMTP id j20-v6mr12251465lji.10.1534180496357;
 Mon, 13 Aug 2018 10:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180810233948.144792-1-briannorris@chromium.org> <5B6F2A47.7070502@broadcom.com>
In-Reply-To: <5B6F2A47.7070502@broadcom.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 13 Aug 2018 10:14:44 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOeybJAsWJtVBdLdQ=6xThJja5MaEoa3dERKZ-shkbDkg@mail.gmail.com>
Message-ID: <CA+ASDXOeybJAsWJtVBdLdQ=6xThJja5MaEoa3dERKZ-shkbDkg@mail.gmail.com>
Subject: Re: [PATCH] ath10k: retrieve MAC address from firmware if provided
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Kalle Valo <kvalo@qca.qualcomm.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, govinds@codeaurora.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 11:26 AM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 8/11/2018 1:39 AM, Brian Norris wrote:
> > Devices may provide their own MAC address via system firmware (e.g.,
>
> You got me confused by using just "firmware" in the subject.

Yeah...I started by writing this patch with device tree specifically
(of_get_mac_address()), and then later found that there were generic
"device" helpers for this, which can assist with other sorts of
firmware nodes. It was easier to put a name on a device tree patch
than on a "device" patch. I suppose "system firmware" might be a
better description?

> > device tree), especially in the case where the device doesn't have a
> > useful EEPROM on which to store its MAC address (e.g., for integrated
> > Wifi).
> >
> > Use the generic device helper to retrieve the MAC address, and (if
> > present) honor it above the MAC address advertised by the card.
>
> But this put me back on track ;-)

Let me know if you have a better way to clarify. I can resend with a
slightly modified subject (s/firmware/system firmware/), or let Kalle
do it, if that's the only thing to change.

Brian
