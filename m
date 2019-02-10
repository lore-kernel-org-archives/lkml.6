Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6B7C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6482145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdDS7LWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfBJWDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 17:03:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42411 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfBJWDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 17:03:34 -0500
Received: by mail-ot1-f68.google.com with SMTP id i5so3939797oto.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 14:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZbFEtMRAHlQjjK1Rxo/FhZal8/vyQI89TUl7Lr92HI=;
        b=sdDS7LWR9SYiItw3LWHbM04ueS1K94o7YyeHbClOS340fpCTKe1Ziv3LfdtSPwPa4y
         nsCmqsCpu9fW4i0NRkvGMWhFjyzgjwWoIb5tWZMs0OM11R5DDm/rSovj64O4FwhJc6Kh
         kabgYI17yM6EONCdU+RDdln0ne6xEybkQaEQJCeDy6lgxw/B47TLQY9Gt0tPla/9jR2p
         KMf9Cxji4nmNbSBsY057hR8HH6UC/Tjlx/1yDbDSFb4798As3cN347uAO2HFKrlHO/Du
         GOKmEauOkQLWvjP1GN6FV+avErdI+xC29FN1MVXxtt/cxB+3oi3cSbNHWcUQvwsNJ8tB
         j9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZbFEtMRAHlQjjK1Rxo/FhZal8/vyQI89TUl7Lr92HI=;
        b=AVFco7lIlv3NMZ8R3ontVcggVR9ieHzaF2Dg+obVpjDOMzKgB2bg5fC2SWvuHWJ1Gu
         veG8FXJauYdXaagQEb3Kv8gpRyLWr7vE/F+jXS879BAScMpRgXsmjD55o4ZsFkneHtTm
         bsjYmZfV4oNfa2ZQS8WRsZ2jU8b/3m1aifDAYHzkdT6Aq5cmTLOnwIZLM4bn4yawCA38
         +tjPrAwgrfItDk+o88wKdE/kCKn/Dr18dS9dZ2xPauG5vFTcD1CwyyxEC8J5GakxtcMA
         SILyRTU9JMs2jI2Y1vbIJgxtX4QCbHHFjxSxyDKR4HsQuiz8FFGMRj3bBgXtUhplGh5E
         EJSA==
X-Gm-Message-State: AHQUAubX8xWnRvdVqHi37PZ32jc7wNnR7731Bbrr/I1hZrvHznuOoJd7
        T1gqWAolWWfID74D7PKDty4HQekU6CsMVjWTSAk=
X-Google-Smtp-Source: AHgI3IYyzgSeWe1pSI+Aku5dlfjuhk5ouzjN3j446nV6fFZ6adl70qxAsqDSfwowyRITGs4qO8JLikq+XqyruTPDl9g=
X-Received: by 2002:a9d:74c3:: with SMTP id a3mr17806014otl.107.1549836213694;
 Sun, 10 Feb 2019 14:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20190209001522.GA11769@gmail.com>
In-Reply-To: <20190209001522.GA11769@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sun, 10 Feb 2019 17:03:22 -0500
Message-ID: <CAGngYiXS0w1-z=o60aA-yfGPB1k6JejaUgU78g5eFDnxchZf9A@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: ht16k33: fix potential user-after-free on
 module unload
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 7:15 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On module unload/remove, we need to ensure that work does not run
> after we have freed resources. Concretely, cancel_delayed_work()
> may return while the callback function is still running.
>
> From kernel/workqueue.c:
>
>     The work callback function may still be running on return,
>     unless it returns true and the work doesn't re-arm itself.
>     Explicitly flush or use cancel_delayed_work_sync() to wait on it.
>
> Link: https://lore.kernel.org/lkml/20190204220952.30761-1-TheSven73@googlemail.com/
> Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Yes, this should do the trick.

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
