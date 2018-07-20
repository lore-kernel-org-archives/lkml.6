Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EDAECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0F020652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMuHQ+yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0F020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388128AbeGTRr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:47:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32845 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbeGTRr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:47:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id s12-v6so11702647ljj.0;
        Fri, 20 Jul 2018 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nZmYuRQhBQTE7xiobeBXFqsT8bKP5nH5ygfc1jYq8PM=;
        b=qMuHQ+yjl8JS7ZEkJyzG/yUZ+I+qJth46+70pAaOUz+82fqTpNovsF4MXPdcaPSii/
         FmuppgRfUIm9ToDnYPHXdD3Ghv5e6IkPx6/CPJv676uf30BqF2PlxCa7h+KP+H3TXMO3
         h1BPkVOMVfb26jpCb3wFPh8qqhkft+qy6oYuXk4J7JvpM/vTs73meb7WJVP3xQe51tYK
         J0Q5AHUXoMTC+/oyjI/0Jy9q/qxLqfrxdm5I6LNwUyslM4UKqHQ8Um2QEwJRssbfronx
         ziXZQHsitSvHohlFTfZEBWFF9KrVIwFkfAjP01EN2dT5NjYnCwgGMwab0UghBGvWWoNh
         GokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nZmYuRQhBQTE7xiobeBXFqsT8bKP5nH5ygfc1jYq8PM=;
        b=qArbocMG7VSqrW+M//QTolvSBp/aAkcDmNR/9+v2KR7tU999CGpPRpDWtNrNfZg58y
         mi+hLSeaDISR4nTZfBv0euMspid8B1SNd7QRDzDdM8oB9qXo+LtnunwfuUwTOJp3d+7W
         3XIYeftmbOFrZM0P2K8OpchEE/Kp6iIuXsQQPURSEs6MyRU3g1jHM7h4maN78C3283QF
         LfjkRbkJRkq32FQKhcr70b8VQUYNyacXhCF+7QlcK9MMIvKa67o8Wl/hhhb1t7dC47yz
         ijR+7QJbwaZXURzYdr/X8uO5KIXSt89tQwZJ122pSp5H4rYVYWTLVsRLaQXXUBwR8d20
         dHiA==
X-Gm-Message-State: AOUpUlHAO6w64DqN2w+vEIjn1r/rTzGe0S3V90zO9QEcxGOBI0lrFczB
        uDOxhTkEFWkTqydo1R9BncU=
X-Google-Smtp-Source: AAOMgpdYzwDB9kbmrnhMDZDdh/6IvyBPIWx9pJkHPsidG2MXMC85tBWuSUz5wsQaJGwFWj9t/dwodw==
X-Received: by 2002:a2e:1d50:: with SMTP id d77-v6mr2193335ljd.104.1532105898992;
        Fri, 20 Jul 2018 09:58:18 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id n6-v6sm366008lfi.24.2018.07.20.09.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 09:58:18 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fgYjF-0000sE-0F; Fri, 20 Jul 2018 18:58:05 +0200
Date:   Fri, 20 Jul 2018 18:58:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: cp210x: Implement GPIO support for
 CP2102N
Message-ID: <20180720165804.GG19245@localhost>
References: <20180720101629.GB19245@localhost>
 <20180718212004.11852-1-pados@pados.hu>
 <ea05b80064d32c7beef3f2039adb89aa@pados.hu>
 <6e6b5df11e7671da070195252a474e0f@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e6b5df11e7671da070195252a474e0f@pados.hu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 12:43:09PM +0000, Karoly Pados wrote:
> Thank you very much for squeezing this into your schedule. 
> I've also become a lot more experienced now in contributing to the
> kernel, concerning both planning and code. Next time things should
> work out even smoother.

Sounds good!

> Wish you a great and rewarding vacation!

Thanks!

Johan
