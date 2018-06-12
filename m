Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B1ACFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686082089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i76w100/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686082089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934844AbeFLWMm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:12:42 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:55724 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933727AbeFLWMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:12:41 -0400
Received: by mail-wm0-f47.google.com with SMTP id v16-v6so1325500wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 15:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QrRG76F6VztNr3hyktc/xR1i7Kkcp0JSjXEUIKzbhbg=;
        b=i76w100/NReSnB5VHXZi7QgYCuvPnYuMFMkREH7GlNiuXzN9gUhbFc6hFEMznkbBdu
         KfiGWZ+ZvPBhXEsDgRYtvvU8LpZ60vx87nyOY2PNl2J0eeNOZqPk/WreEIWSUPwx00J/
         xBMFbtNhPSH9J/z5uT4DZoN5rcmpxMHbnup0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QrRG76F6VztNr3hyktc/xR1i7Kkcp0JSjXEUIKzbhbg=;
        b=qZDQHwlnD1ccJ/33otsexcv3EGSSGizUS4d5En5aIm/5IWqsBwIRrTLcgmJQDGrAF1
         z+5hwbtTQ3sfsZRD/W1bv1bihLml/nBNgOwzUpmJEQjr70EGMbSPps3y3F11N+oaKBgG
         xhSaEoooBOtCFAEWB0ksVATOxDM+zJk2U7SPRGJ6drpmrGU+AwMiCRBK1k36X/7l4AZ6
         955sZ5wrVi8WIiOPEvrJAWDuA2X0QgEwQyU7POB/ayojqY4YykFdplJoZkHxWA/UIP9D
         LR7EzJeQ9ZSLz9/9a1Ns056xNhgE/HMz0tRWSqSDRzQvIKJfpQnr+72KdHFsv84m1G3z
         jayg==
X-Gm-Message-State: APt69E2nWt8ccHxshiY8XWvyX49Uhf3yVcxnQ8pYVkg4X20vz48lZAoR
        Rf1vmsHyXs95fYDwmb5FPOx86fR4UuEnxRa+qEIeVw==
X-Google-Smtp-Source: ADUXVKIzkEIkCjjfcUzfegWXrKkzP+b6luqmJVLa9qy4NCsWP7+i0iif1P8KsYmh9abdvXlzteM7GCRyI7B3Er3jvTY=
X-Received: by 2002:a1c:da4e:: with SMTP id r75-v6mr1744663wmg.64.1528841559788;
 Tue, 12 Jun 2018 15:12:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8ac3:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 15:12:38
 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 12 Jun 2018 15:12:38 -0700
Message-ID: <CALAqxLW=nrX-S9eibsTc+S_4YsZ166OJgZGj_1TZRWZ2ut7aFQ@mail.gmail.com>
Subject: REGRESSION: "wlcore: sdio: allow pm to handle sdio power" breaks wifi
 on HiKey960
To:     Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalr@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Folks,
  I noticed with linus/master wifi wasn't coming up on HiKey960. I
bisected it down and it seems to be due to:

60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")  and
728a9dc61f13 ("wlcore: sdio: Fix flakey SDIO runtime PM handling")


When wifi fails to load, the only useful error message I see is:
[    8.466097] wl1271_sdio mmc1:0001:2: wl12xx_sdio_power_on: failed
to get_sync(-13)

Reverting those two changes gets wifi working again for me:
[    8.754953] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
[    8.761778] random: crng init done
[    8.765185] random: 7 urandom warning(s) missed due to ratelimiting
[    8.779149] wlcore: loaded
...
[   12.945903] wlcore: PHY firmware version: Rev 8.2.0.0.237
[   13.058077] wlcore: firmware booted (Rev 8.9.0.0.70)


Any suggestions how to resolve this w/o a revert?

thanks
-john
