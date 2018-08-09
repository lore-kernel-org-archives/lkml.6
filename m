Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94900C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439D72238D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="br22Sloi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439D72238D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbeHIV6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:58:09 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41246 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeHIV6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:58:09 -0400
Received: by mail-io0-f193.google.com with SMTP id q4-v6so5718360iob.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDckQAimzeGAxvccrwiW7AveOExWg3iD2zTrElbsxs8=;
        b=br22SloilJKBiF+hRy99o4ieSlJt/cwbLLioNTMQ4x08M9xWDyQmOIpPVwv+H8UpUK
         dOOwdeOv07MHF73+uHS0dwnjaVYPC1n+HH0xBgVAsIKxyl7vdrGuQ5pKhBnW/iWWS6Tl
         v/PS6Rv3Yc7kYmKVYhYbidy53ImnucBIABb3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDckQAimzeGAxvccrwiW7AveOExWg3iD2zTrElbsxs8=;
        b=Z6roOCPuhj1+prF3/8fM3NpcJCCy1qwiYh51MvJhQ9XauDX0/AxKSpb1jWwSOkKFM7
         9AhqqDXSvaPoenRfGH1blSuxpJKDzWQy10Auvj9gvxMbei9+A+rsZUxzysjUN35JQ90H
         tzDahe++/fZCgh1F1U/ZEv2fXUZpDFH8BBOZRaYvGCD83vcU85cU8DEH3YwUAc9SVSDX
         kR1tHXT6e/faLoYZECvl6n+uDq4jPzJwX2mBH45pG6pCr2RDQxpzlfEAkVrjKlwQtfr7
         tSwC1qUX65jxwS2lc64kE8hYZeSKdexrg7U0ar1T1JDnauHIXI/8MTvBy8L6sA94TAMY
         ebSw==
X-Gm-Message-State: AOUpUlELW7r+3gGehH/GSfD9M5V1SoPYdzuZuZyLCkQKvpJx0U/kNGqY
        u/DMGmwmaUlX9j+0/V+KYptJzF2v07E8kJQ0JewpJg==
X-Google-Smtp-Source: AA+uWPwIbrJgV+n4hx7PWEYvBK0rVjrQtjrUML/JJLPf/epTqBhN8bnAnXlh2s3ogKmmtoz42n7Ow4ptzduDhJyJvN0=
X-Received: by 2002:a6b:da14:: with SMTP id x20-v6mr2888980iob.102.1533843112331;
 Thu, 09 Aug 2018 12:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180809181103.15437-1-matwey@sai.msu.ru>
In-Reply-To: <20180809181103.15437-1-matwey@sai.msu.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Aug 2018 12:31:40 -0700
Message-ID: <CAADWXX-bXeVdWPrn3BeA=wF3d4rn1S69BYhf398_=T=NF2t44A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] media: usb: pwc: Don't use coherent DMA buffers
 for ISO transfer
To:     matwey@sai.msu.ru
Cc:     linux-media@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        matwey.kornilov@gmail.com, tfiga@chromium.org,
        laurent.pinchart@ideasonboard.com, stern@rowland.harvard.edu,
        ezequiel@collabora.com, hdegoede@redhat.com, hverkuil@xs4all.nl,
        mchehab@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mingo@redhat.com, isely@pobox.com, bhumirks@gmail.com,
        Colin Ian King <colin.king@canonical.com>,
        kieran.bingham@ideasonboard.com, keiichiw@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matwey,
 your DKIM signature is garbage, and it causes your emails to be
marked as spam when they go through a mailing list.

The reason is this:

  DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;

where the problem is that the "sender" field is included in the DKIM
hash calculation.

That is completely incorrect, since a mailing list will - by
definition - change the sender to the list, not the original sender.

This is not a mailing list bug. This is a bug in your DKIM setup on
the sending side.

I'm leaving everybody cc'd., because this problem is starting to be
annoyingly common. We had two people with chromium.org addresses with
the same misconfiguration, and I want people to be aware of this.

I get too much email, and too much spam, and so when people have
misc-onfigured email sending that causes problems for spam systems, it
needs to get fixed.

Your situation *may* be the same as the Chromium guys. Quoting Doug:

 "Looks like it's all fixed.  Both Kees and I setup our chromium.org
  accounts a long time ago.  IIRC during that time the suggested way to
  do things was that you'd use your @google.com SMTP settings even when
  you were sending as your @chroumium.org account.  These days it
  doesn't appear that there's even any UI in gmail to configure things
  that way, so presumably nobody else will be stuck in the same hole
  that Kees and I were in"

and he may have been wrong about that "presumably nobody else will be
stuck in the same hole" guess.

So you might want to check what the SMTP settings are for your setup.

               Linus
