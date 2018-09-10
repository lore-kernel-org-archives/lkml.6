Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F634C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A35B20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9AD8UD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A35B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeIJSti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728308AbeIJSti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:49:38 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 588F720855
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 13:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536587724;
        bh=c5IKRwdEKTKgP75ZS44+5PMamgf9QOclPkp1XJpTsjQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F9AD8UD131IxYIB+piIUJEy9SM64pkNQihCxW21dIn6uOKB2T+trUXvFbxu3woGkT
         /8ARKrxOwdbVK+fUZAjY9wB5wGMrW4bQKPsOg1cjSOmwp8RFTQ2EIbpa+K3NoXGAQs
         BMAp4rgyFRFs7s6QGFPZlGLzMl247aw0/bxRPBAk=
Received: by mail-qk1-f169.google.com with SMTP id f17-v6so14362673qkh.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 06:55:24 -0700 (PDT)
X-Gm-Message-State: APzg51AeUP2xGStVKnJC4RynXQVa6oyV1ZlJ0u3YMI+m+c4HRf3WfSF3
        YB9fici5vViFdHXQFT5rboxp96mlMiX/w47Pfw==
X-Google-Smtp-Source: ANB0VdZb7JsNfQT+F0zJfv6eUQ/FwstmqBKPIXC83whOMkWOLJivgnuMR85lVNFMrmmctnAXQ0z5YZ4k+tLzYKLvNNA=
X-Received: by 2002:a37:56c7:: with SMTP id k190-v6mr14209560qkb.29.1536587723570;
 Mon, 10 Sep 2018 06:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-24-robh@kernel.org>
 <alpine.DEB.2.21.1809081414150.1402@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809081414150.1402@nanos.tec.linutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 10 Sep 2018 08:55:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJVbc4ecRfSp4=crH0Ci9duP-2_mZmKW-5NW-zZv4QwQw@mail.gmail.com>
Message-ID: <CAL_JsqJVbc4ecRfSp4=crH0Ci9duP-2_mZmKW-5NW-zZv4QwQw@mail.gmail.com>
Subject: Re: [PATCH] irqchip: Convert to using %pOFn instead of device_node.name
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 27 Aug 2018, Rob Herring wrote:
>
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Should I take it or do you want to take it with others? If the latter,
> acked-by-me.

Please take it. There's no dependency.

Rob
