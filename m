Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDA1C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CEF2145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XY+czLTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfBJVYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 16:24:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34875 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfBJVYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 16:24:48 -0500
Received: by mail-qk1-f196.google.com with SMTP id w204so5364890qka.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 13:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wkkyoSoLEHExdCv3S3zjnYxqJ3fQjmd0c8cULl7lK4k=;
        b=XY+czLThZASlIpgyozy0wFDciLazcnXpU4Flf7459xpO3F3De9dkcwj3gwfIgAOq+Y
         KNImmyoQ8xU8djpaZMbaAAjZkjOl5SCpNZyPSQLaao2ujTh+xIJSn4TV/LG5OQce9Zwb
         gLRXKLb8Zsku2w+R+WsNvTVpnuGebhRQux/CuAmqg1EX9wDJoLvdKs1JD5Y7TIZWjBpR
         RcMDZ99CvWKnPRgz26XZPOxDl3jRimL38B8uGOX7METwQhsN2kcY6NmeCihc1Uc/GfJg
         miMkDvFOPHCXKkhzWWqjI9LAT3Ya1aYSeQPeimfPiIYRfzg6E64QJ3lPzYixVExfcLOy
         ateQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wkkyoSoLEHExdCv3S3zjnYxqJ3fQjmd0c8cULl7lK4k=;
        b=ZucPyZJ5MJBooZy/EYHGltpUt88ZjHWD5uHiVLt8tw53qkzD7KIbv015jttIgqDlSE
         k2KNvACZKynbuDjqJ9aN3ULAVDdKLaFyaQGQGbGo5L53+Nb6004SnASO3DOk0vUkdhY4
         IZ82M/x0XALaJlDLSFs1uOsa3IorJzAlHb3WogCxMYngoSSftaVlZsn/zdOU35mjt3bk
         y4wapafE/+r/KKm/NCSi6vTFPVhCazwyq68kCJ5n7F+hBnyjv168ASwtjdlGWUt00Oxi
         LoWzRQ71LpX1JCwRLgcZpI4eED5LnNxTrBbUc1p6ToqMZ/6kgWDLfpUAuXbje+ZBbFET
         2BUA==
X-Gm-Message-State: AHQUAuY/DaFIeq/GlH+gYP+bgt8PpQIvIj95KD7isM/8FruYLvZtMf9A
        wQHjGQn6Gr7ZtHd/ysJY9olzjw==
X-Google-Smtp-Source: AHgI3IbBOyxHEIiwd7lMi8oCGLyLrxn0eDbfetqek0DvDVFLF0++WXIh/wrijfmkcRumTyYDoWC0Yg==
X-Received: by 2002:a37:b084:: with SMTP id z126mr22723222qke.154.1549833887205;
        Sun, 10 Feb 2019 13:24:47 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id 55sm9052123qtq.88.2019.02.10.13.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 13:24:46 -0800 (PST)
Date:   Sun, 10 Feb 2019 16:24:45 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Stefan Agner <stefan@agner.ch>
cc:     linux@armlinux.org.uk, ndesaulniers@google.com,
        natechancellor@gmail.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        thierry.reding@gmail.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/5] ARM: convert to unified syntax
In-Reply-To: <cover.1549753425.git.stefan@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1902101620430.2213@knanqh.ubzr>
References: <cover.1549753425.git.stefan@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2019, Stefan Agner wrote:

> This patchset converts all assembly code to unified assembler
> language (UAL) compatible assembly code. From what I can tell,
> this mainly boils down to using conditional infixes instead of
> postfixes.
> 
> Most of the conversion has been done using the following regular
> expression:
>   find ./arch/arm/ -name "*.[hSc]" -exec sed -i -r \
>     "s/^((\s*[._a-zA-Z0-9]*[\:\(])?\s*)([a-z]{3})(eq|ne|cs|hs|cc|lo|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al)([a-z]{1,2})(\s)/\1\3\5\4\6/"
> \
>     {} \;
> 
> The expression resulted in some false positives and missed some
> instances where infix conditionals have been used. With this
> changes applied, I compiled several kernel configurations
> successfully and without a warning.
> 
> The file arch/arm/probes/kprobes/test-arm.c is still using some
> divided syntax assembler.
> 
> This does not allow to use LLVM's integrated assembler just yet,
> there is still some assembler which the integrated assembler does
> not like (yet). But it is a big step towards that direction.

OK....

Please document why you added .syntax unified in the commit log of each 
patch where this is added along with a link to the gcc PR.  Then you may 
add Acked-by: Nicolas Pitre <nico@linaro.org> to the whole series.


Nicolas
