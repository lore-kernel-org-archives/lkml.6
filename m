Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A29C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACDA2468D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHsK5Bm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACDA2468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbeGDGMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:12:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36100 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753608AbeGDGMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:12:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id s14-v6so4394383wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 23:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=v13rdzMsU7wzqO1nN4PxySHbgnrvD2f05OrhsvQw+z8=;
        b=CHsK5Bm1GlbDvocLbv0ZSUBURCkhKBmuFHDibfATGwSGMhwVSx/Nhp1SSc8RBqo8GG
         jvOec49U6OZywmeEMX/P6Ok+S3g0P45kuidkojIAnOpCGO9FDeVNpf4xfGB3SH8k1wTF
         43Jf7JNIeF7Y/vbrXXcZAaWgkVXuHWxjawmdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=v13rdzMsU7wzqO1nN4PxySHbgnrvD2f05OrhsvQw+z8=;
        b=NlrZUkR5rmfF4zd3BZ0fCcbsKHNkvWgS4zdno+rFwozuwx/9vrBjyqNUq6raDUqt5v
         MzbyLN+epxxxIBOSf/gSlkuYx1rfSWA+m1tAZARWPyBIm6GB9S//q8Q6lZYyOozq+b8X
         Y9ucsCEmSp9U0+Yo36Q8r2RSk2mLM5dnhgz0ENUHfe3U7C6xx+A50HZvoOzrHgKbw7SE
         h+vnri3u2QDW2dEJ+8ELHXhRMCrmShNc3nP5vcTyWgpOyVUMtFj39M4MKW1ityMK/9B8
         q1mQ16ISI9Y9R14Hf69zubtQTZB4sGMN4ZXVb9Nux76l7bNwYf0+c2RdDi7iRYz1RyH9
         QIqw==
X-Gm-Message-State: APt69E0B6ycMTxL+l5ZZsh6/prm2CS4aey3NrlXuz6CzIpwupZ1SAG3x
        MjdgZBs9jS4z4etYHfcx3/lLSQ==
X-Google-Smtp-Source: AAOMgpf83pJia7duI8JjduNAp6N2GUM/Dl31GNKw+Xnl920jyihBTgvnT8hQqfOR2wOrp0B20D06/w==
X-Received: by 2002:a1c:d92:: with SMTP id 140-v6mr592537wmn.32.1530684769120;
        Tue, 03 Jul 2018 23:12:49 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id k188-v6sm2728844wmd.47.2018.07.03.23.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 23:12:48 -0700 (PDT)
Date:   Wed, 4 Jul 2018 07:12:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        miguel.ojeda.sandonis@gmail.com, kernel@collabora.com
Subject: [GIT PULL] Immutable branch between MFD and Power? due for the v4.19
 merge window
Message-ID: <20180704061246.GV20176@dell>
References: <20180502154418.2153-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180502154418.2153-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the delay -- these two patches dropped from my radar.

Enjoy!

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-v4.19

for you to fetch changes up to 3144dce72b7c53a0ca9f054c8187925c40381caa:

  mfd: cros_ec_dev: Register cros_usbpd-charger driver as a subdevice. (2018-07-04 07:10:05 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Power? due for the v4.19 merge window

----------------------------------------------------------------
Enric Balletbo i Serra (1):
      mfd: cros_ec_dev: Register cros_usbpd-charger driver as a subdevice.

Sameer Nanda (1):
      mfd: cros_ec: Add USBPD charger commands and struct definitions.

 drivers/mfd/cros_ec_dev.c            |  16 +++++
 include/linux/mfd/cros_ec_commands.h | 132 +++++++++++++++++++++++++++++++++--
 2 files changed, 144 insertions(+), 4 deletions(-)
 
-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
