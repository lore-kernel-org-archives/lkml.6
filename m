Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482EAC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04278219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SURojWFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04278219E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeHFLYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:24:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35724 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbeHFLYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:24:02 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10-v6so10013673ljg.2;
        Mon, 06 Aug 2018 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7o2xnOCKKU/FtNCRK7K5q0SKWiY5oS61VR/pipcER08=;
        b=SURojWFdGREqWwfFpJuiKH0Xjcdtqw2z0WSEhghrRFap3fXQYAdT5wPcrwoKH6Zc9J
         OHRzv2mhac1byJXC5a5y60CDQ2/Fo2uj7fZQ+4XKV+EVf6mZk2XJGQYOCn600d1zqUdj
         uMQV9o8feBEvyqhLDN0cwWEUbycqONFmWBGIQ6uUtSaH3wf8oNqEM/UB1okf1g26rnOJ
         48crZYnVynk//7fvxZg2KHSpXWZxzpbukpcjGYBK2DXPJkxUJ1QXWgJrd6v764ulZM5B
         B0DXd3bjCMDNeBmQaSYy41YscmZ3uVY5I1jpi+HGfWFsHeyViAPfKbN3b9U5sla+iP6q
         edJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7o2xnOCKKU/FtNCRK7K5q0SKWiY5oS61VR/pipcER08=;
        b=ly6QSYLTfgnyxs/j6VEzf5vy8whDFC/m9UYHvYU+LbuAzvgxONyipg9N8ge7+3az2n
         fFE0hgkM9n33TkXwRjGj57kBcrrv1VW12srfCV/ake/uZdHbdTRae5s0Bvz9hJdWVa5g
         BwT+3t6XNqTv7Q/IS0PDmukhbUhZv/7EXEGhaEZkPED92rUI7VLOqdiRcOOuhchJ94m/
         oAxOor0vfgWkjQPpSCKEsxX9ipZeKCSoRFI9CAukyN7NzLnuBTj116+G3NSbVI54D4f+
         TgJegYwoAWiuKaNjsLTMflOcz8f4mHVF52LGHIVLu1ZOt409YJcdQTXIBEe9in2Z7Jwg
         lBBw==
X-Gm-Message-State: AOUpUlGXwx7Lne8wkykgkyYAB8TY1rPAW8bUvkLlA38TypAzd8P0aEOe
        vUY+b8nnF2u2nfraMXuJ3eI=
X-Google-Smtp-Source: AAOMgpd+Ime0mP2y6WUYLphLDIgn0u8/ygMNlBZDz/xHtnS7DbtH/FP5CLzzujD35gY7KnqyT22c5Q==
X-Received: by 2002:a2e:1d50:: with SMTP id d77-v6mr11898513ljd.104.1533546953428;
        Mon, 06 Aug 2018 02:15:53 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id u18-v6sm2114691lfg.14.2018.08.06.02.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 02:15:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] pinctrl: tegra: Move drivers registration to arch_init level
Date:   Mon, 06 Aug 2018 12:15:41 +0300
Message-ID: <2086462.IQpRViTvQm@dimapc>
In-Reply-To: <4576764.PLucfz68jK@dimapc>
References: <20180802111144.12512-1-digetx@gmail.com> <4576764.PLucfz68jK@dimapc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 2 August 2018 16:01:24 MSK Dmitry Osipenko wrote:
> On Thursday, 2 August 2018 14:11:43 MSK Dmitry Osipenko wrote:
> > There is a bug in regards to deferred probing within the drivers core
> > that causes GPIO-driver to suspend after its users. The bug appears if
> 
> I meant "before its users", of course. If the rest of the patches is fine,
> please let me know if re-sending is needed or you'll correct the comment in
> place while applying.

Linus, please pick up the v2.


