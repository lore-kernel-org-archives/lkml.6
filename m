Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5523AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 02:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEAD2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 02:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unUAGUnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeLaCIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 21:08:01 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41238 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbeLaCIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 21:08:00 -0500
Received: by mail-oi1-f175.google.com with SMTP id j21so21135686oii.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 18:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NEXHWOeeKtZN1iAtuH4eUcS9htCoebYfynGUmimghoc=;
        b=unUAGUncLAiUY5u7liPRa10ZWd1ZwdevWWHwa0rwMpEYOd8Dh7dBilfOfEhQoKRwly
         LAq5X905PTKMi9tcmzAgghxQ6708Wb9wJqaWt/Ft5cpcuoALvZz0IXeD9Y2BI3R9tBXs
         ZIcPzC3TW3pQV3Jr+wycPBA++IM8AHdGaK+Vq/EK2N2UhPu9FVyF0JE2wN7KUPympOyE
         JFGYOXbHB+kuPshCJoyB/sCUFZIq5JI6dB2CVl5AWFH0g4sFaqNCCVzFZDmZf8NT/r3z
         DFJF9rh6oiw0hvAqu+098dKE5TzabYR/5VSSgcTSA72/IO1lmEz9DmBF88KIApy0ZSK0
         G00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NEXHWOeeKtZN1iAtuH4eUcS9htCoebYfynGUmimghoc=;
        b=YjHBFQkD2erX9YDEgltc7QEG+POxENYfKjceBD5eX+UqthSWu21P03sLuToce0GASP
         4tqZDCdY66FR4YzSes74HoLnM9sIJDdZLEqct0PhyQNdRJOz3nCVEmxrYMAtIDQDX4a7
         tnPrLzOsTw7juZSWI0gTK30BC/4+g527q+DNBLzAp5/WJlXots1iySko3a8U85//w0a5
         nGiUP/4cbUkkIbNTMkTw6+Jz4SQcMjlCpc9u5sEtfOUYag5gORUPLTciQ2u6LOre2hsc
         3DTZoBZLKYbuHZKfHSzeF4BwMa4CZ44OGWSy14SKrViABsxhSq2NSNdKsjxc4Oc5T7pw
         Qrlw==
X-Gm-Message-State: AA+aEWZgQVu7gS2ABuES0RqNm/F8BOpB0Dk+siXgrGAHOqweJzIpZD5E
        XWTN9qFU1+x0Iuwm0stwxsOJgP70v6Luga+0v1safdAqydg=
X-Google-Smtp-Source: AFSGD/XIM9iCa5StG1SoEb7k5ijTBz8YvpD/Q3bVpHLgmsJoSO54sO2YTnyyRKzQRtfPI7bzEoBq4xo+ntjzkWTsG1Q=
X-Received: by 2002:aca:50cf:: with SMTP id e198mr24550383oib.343.1546222079863;
 Sun, 30 Dec 2018 18:07:59 -0800 (PST)
MIME-Version: 1.0
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Sun, 30 Dec 2018 18:07:23 -0800
Message-ID: <CAMe9rOq0K62wcXC76xn10Rb+Ry1p+M4wB5MCNA5QF9oUGZJZSA@mail.gmail.com>
Subject: commit 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94 breaks timer
To:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.19 branch,

commit 82c8dbb376b9fa9b831c157cbb15664cb4a343e3
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Mon Dec 17 13:31:05 2018 +0100

    posix-timers: Fix division by zero bug

    commit 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94 upstream.

    The signal delivery path of posix-timers can try to rearm the timer even if
    the interval is zero. That's handled for the common case (hrtimer) but not
    for alarm timers. In that case the forwarding function raises a division by
    zero exception.

    The handling for hrtimer based posix timers is wrong because it marks the
    timer as active despite the fact that it is stopped.

    Move the check from common_hrtimer_rearm() to posixtimer_rearm() to cure
    both issues.

caused:

https://bugzilla.redhat.com/show_bug.cgi?id=1662602

-- 
H.J.
