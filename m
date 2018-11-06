Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D216C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0470B20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK9pWdBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0470B20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388562AbeKGDtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:49:16 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39604 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbeKGDtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:49:16 -0500
Received: by mail-qt1-f193.google.com with SMTP id n21so1127942qtl.6;
        Tue, 06 Nov 2018 10:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ehglz/SyCyiPiIl24JwzaivCr8iKB6oaAnyZG/Qd7GE=;
        b=jK9pWdBlPpzVA6kjS+X0tHzVqFpteBRyGacc8orOmVpjC9oQ31J5sV5BZGAaQtVvAt
         cKTlGdqcNshtWMH5giCk/oUEIIlcn4xpJ7FTwCd1CIfsTPbhsSFebX5gAB5b2A4VIE2R
         zOkHhwONGSwxL3a6ElUx+bPF0s+ldpyfovSccY/8cQqgrCyd0VnSZzXpOrdKt507u5LT
         kfRXYICUdPruBa2wpC4H/NIlhfwMfDehtXmCR/WW+JT58OOYBRUFwfU0KrDxfPw9DG73
         iiEChMhWWaM4Pc+Xz+diKCqs4XwhmX1rXnN9w6BJ3iibU60MDXuAWsHBNhPz9G4RTpk1
         OB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ehglz/SyCyiPiIl24JwzaivCr8iKB6oaAnyZG/Qd7GE=;
        b=Z+2zDH4UzkBGfvW5sufQhah/xne5Lts0oa3d5ro0R4IBD8Jw+37TdNJ75lMyNe0uH7
         eOmO2Js+3db4RUPR+rJfT4296z+FmtrFzXucJEY4p8RgUnx+fzgM2o3IiRZiKLqrJS0m
         HOtNjMz9AjpS/2q9dO+wfAMOd0k2G4SiJVOU06N86qDQ/0nriBAbuJR2gMfPgZDabFGZ
         O0pBtCk6Q9AMKA/SbpcrOu6jWwAq3K0wuouJaFcsQJDmHlcsTHTgjmjZQeu2SfGIHuMx
         bBfkYfsJutxB3gDxFDjhymkWNRBhanm7+CsCh7jYCKl66MNbrLpPS2IHFXtHyA0xZzv9
         BBqw==
X-Gm-Message-State: AGRZ1gJuv8y2zUskTr3vUv9zKFy5R3ndEwqvS3PcU6iv6dwazCR28VW+
        +adR8cj3KOpQq8yk9nbTEspkqnmsPpmRQAdoTiI=
X-Google-Smtp-Source: AJdET5cZW5RTKKrzWqzEeQscPVGD0KBUHlXXQD9gFvQmaCQb4VbfjHK0/HqG7UnudlLkpX3fWrODrpJuQscnCd1iz4I=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr18896715qvk.40.1541528564770;
 Tue, 06 Nov 2018 10:22:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Tue, 6 Nov 2018 10:22:44 -0800 (PST)
In-Reply-To: <CAOGqxeX1FckLz7XEm-doh_AHUjvRtn00yZfir6dRNMYNOMY5_g@mail.gmail.com>
References: <1541453493-34981-1-git-send-email-alcooperx@gmail.com>
 <1541453493-34981-7-git-send-email-alcooperx@gmail.com> <CAK8P3a0AoHuaiPsMTqhWm3a4X95NpPTPUHkt9vS9Z2ow8NobhA@mail.gmail.com>
 <CAOGqxeX1FckLz7XEm-doh_AHUjvRtn00yZfir6dRNMYNOMY5_g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Nov 2018 19:22:44 +0100
X-Google-Sender-Auth: y8rPKsh_7lWbvQg5VDtant2rUOM
Message-ID: <CAK8P3a2Xuq77sXKy4QX1YhStOEhm+oAM_AErEGuwqB115pHB_w@mail.gmail.com>
Subject: Re: [PATCH V3 6/6] usb: host: Add ability to build new Broadcom STB
 USB drivers
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        chunfeng yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        DTML <devicetree@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        USB list <linux-usb@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18, Alan Cooper <alcooperx@gmail.com> wrote:
> On Tue, Nov 6, 2018 at 6:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On 11/5/18, Al Cooper <alcooperx@gmail.com> wrote:
>>
>> > +
>> > +config USB_BRCM
>> > +     tristate "Broadcom STB USB support"
>> > +     depends on ARCH_BRCMSTB
>> > +     select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
>> > +     select USB_EHCI_BRCM if USB_EHCI_HCD
>> > +     select USB_XHCI_BRCM if USB_XHCI_HCD
>> > +     select USB_XHCI_PLATFORM if USB_XHCI_HCD
>> > +     select BRCM_USB_PHY if USB_OHCI_HCD || USB_EHCI_HCD ||
>> > USB_XHCI_HCD
>> > +     select GENERIC_PHY if BRCM_USB_PHY
>> > +     default ARCH_BRCMSTB
>>
>> Is there a build time dependency on the PHY layer? If not, I would
>> suggest
>> dropping the last two 'select' statements. I would also suggest
>> making the dependency 'depends on ARCH_BRCMSTB || COMPILE_TEST'
>> to allow building it on other architecture for better build testing, and
>> dropping the 'default' line. Just add this to the defconfig like the
>> other
>> drivers you have.
>
> I added COMPILE_TEST and dropped the last 2 select lines.
> Most of our other drivers default to "y" for "ARCH_BRCMSTB", would it
> be better if I changed it to "default y"?

No, "default ARCH_BRCMSTB" is better than "default y", but I'd recommend
to just not have non-essential drivers default-on.

      Arnd
