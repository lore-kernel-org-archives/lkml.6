Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB185ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D00D208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvenssNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D00D208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeIOTFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 15:05:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41316 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeIOTFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 15:05:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26-v6so10081889lfc.8;
        Sat, 15 Sep 2018 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zU40XNtpoMy08u4cdL3z/BgIoUlqbIHxPz9WcgFbrjg=;
        b=dvenssNhEFh8y8qOPsQxH/U6IVakRZB8KDOFi2uRgW4BRb6Eec11JUD6RSXcbcAH7U
         Sf1I/hb4hWTzyZOdP7nEojyKP02mG6O5OEXmHKb7oKplPib6Jmn5Kev5MSkKVCOJEQQm
         SJuux8DjY6OIVupobHQQxjLrL/I5zM71JM1Uz2Wp4ohq/8ToYm/pXCFOWiu0+5e9UDoC
         YO3IWFlTXSdg3bk8lsPH9edNbC2dmgmcGSTrVi2g92WRZKRDnBR7z/BK8NNVEr0rednd
         ySTCtlN4l8ORulNhQQ8nnTO1QMWvf5uK7i5D5I8GN0jmJEuWm8nwmloZAyGaQt5vYjTV
         2GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zU40XNtpoMy08u4cdL3z/BgIoUlqbIHxPz9WcgFbrjg=;
        b=qD/0uT4KCqwD/IYDAQM6WZp6EvPSlEkG+42kU3I00VuiWCR6dn0la+o7qQF0J6tL91
         BzNxbN3dcY6FW9Ign7KdAZ6s1XCRkPytmXH3vtt3WYvUcjWLrVGcZTLOvK8lAlZy6Kx5
         YZXzbUAO1R81cnOr6CW+yxJpbRxxQMRckZEpd1eWbH+5xU5GZnn0Z4Hq/aKorQHH6vF8
         t2kO7HT3DZvExhjODohaRYEJc4qBqfUSqBfGYJFDsHRx8RtzarnuSTj+lsF2HnbNtbCR
         oTZV6Mooz+Zg88ZKCCxMvANeCC9Qw1emNPWL2BOVBEDCqJ+3s1Bv5xPFY9B+b7o+w3ea
         NICA==
X-Gm-Message-State: APzg51DFBO1czawcc3aUAF7x5O0lUdOos0GlP0AKJfqSwgBdPHgr+PTY
        42DtGPFQ6vXVhe8ha+CguMxWxNuDYj4=
X-Google-Smtp-Source: ANB0VdYEydGlB1Os4tIm8nX8LsJHQ5lY9qFkIfsbPNvz6MrDTm3klNxMnV9iJl2J/Z6TzINnCLcb3A==
X-Received: by 2002:a19:1ac8:: with SMTP id a191-v6mr5396867lfa.29.1537019171509;
        Sat, 15 Sep 2018 06:46:11 -0700 (PDT)
Received: from gmail.com (c-2ec27db1-74736162.cust.telenor.se. [46.194.125.177])
        by smtp.gmail.com with ESMTPSA id s74-v6sm1876280lfg.79.2018.09.15.06.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 06:46:10 -0700 (PDT)
Date:   Sat, 15 Sep 2018 15:46:01 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Romain Izard <romain.izard.pro@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: sama5d4: fix timeout-sec usage
Message-ID: <20180915134601.GA947@gmail.com>
References: <20180914101339.7382-1-romain.izard.pro@gmail.com>
 <20180914101339.7382-2-romain.izard.pro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180914101339.7382-2-romain.izard.pro@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 12:13:38PM +0200, Romain Izard wrote:
> When using watchdog_init_timeout to update the default timeout value,
> an error means that there is no "timeout-sec" in the relevant device
> tree node.
>=20
> This should not prevent binding of the driver to the device.
>=20
> Fixes: 976932e40036 ("watchdog: sama5d4: make use of timeout-secs provide=
d in devicetree")
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
