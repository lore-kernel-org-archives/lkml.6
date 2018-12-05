Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DAFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AAC2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lupK/Yyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26AAC2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeLEVxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:53:12 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43843 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeLEVxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:53:12 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so11873605eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rgtewlOoPF2c3Zq1XxP7/V7Mqh5zIxHCqCIDjAjkI+M=;
        b=lupK/Yyh3ML1Jg9EVnd7UpER/MqHpXYXWE0JgciS/vgDds9FTyaoJOCVrHFaNlbKPe
         Fd5rd20bQctnulcyBZcchmRVGlycJD7NTP3/gK44WaMIymAAFiklOrmw+xqsLnGsnD27
         DqYJqDm7iTlrzn0BXEGOe9EjGB/iLbHXSD0OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgtewlOoPF2c3Zq1XxP7/V7Mqh5zIxHCqCIDjAjkI+M=;
        b=nXuGmYS4lB9IiUv3TixMyudAkhJUEQnFDr231nTsgHaOhRnskEAKZcbWQfUhgMAxm9
         mHYB51CdawYYG485B+w4lF8ECTlZSMP7g2gn6ozETvHrw8rwd69qf/tnqT2YZJtKpQPw
         b2QRkWFdoGOozt2VeHf9E0QA5KGLp6mTA8VQivCZKhAUHnhLnL+WIv2tSmTdi8x9rkDX
         Q3dEQ4OCuJbpIWpHkjEZH+i214DKEJtLul/l8oxutyDh0nhTy5Im5VEkNpiOl7XTOz1t
         krD4g8haJ5aizUZE2SXJHGzVNJSn9yZiaf1uMnrgv+6ysKUW//3seLi+cgEOoA1c9Ti8
         9rfA==
X-Gm-Message-State: AA+aEWZuuONiLSLE40j0l0s8pa0fcFd5MQOhkNN+eGedhaFxQlPa2Zmc
        WfaCm3pEDvRcMPTr1BOsoLzWSeCjX/0=
X-Google-Smtp-Source: AFSGD/W2zSnDOu76Y7/ceB55+7faYsWbperQ8kBz1IuA4pzyFKcT/TOksYxcZHjGFL+eJFQhxCKqaw==
X-Received: by 2002:a50:b667:: with SMTP id c36mr23435074ede.190.1544046790602;
        Wed, 05 Dec 2018 13:53:10 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id x30sm3629555edd.30.2018.12.05.13.53.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 13:53:08 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id p4so21234437wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:53:07 -0800 (PST)
X-Received: by 2002:a5d:504f:: with SMTP id h15mr23329121wrt.83.1544046786773;
 Wed, 05 Dec 2018 13:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20181205004228.10714-1-peter.hutterer@who-t.net> <20181205004228.10714-8-peter.hutterer@who-t.net>
In-Reply-To: <20181205004228.10714-8-peter.hutterer@who-t.net>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Wed, 5 Dec 2018 13:52:54 -0800
X-Gmail-Original-Message-ID: <CA+jURcuR8LzsQUPL4OMfx+OGV5DkADibO_LS_YPmA5pCGRkk8Q@mail.gmail.com>
Message-ID: <CA+jURcuR8LzsQUPL4OMfx+OGV5DkADibO_LS_YPmA5pCGRkk8Q@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, 4 Dec 2018 at 16:43, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> Changes to v2:
> - m560 now has REL_HWHEEL_HI_RES (untested, I don't have the device)

I just tested with my M560, and it now reports REL_HWHEEL_HI_RES correctly.

Verified-by: Harry Cutts <hcutts@chromium.org>

Thanks,

Harry Cutts
Chrome OS Touch/Input team
