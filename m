Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DAEECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDD620882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P6VRPEwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDD620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeGOUzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:55:22 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37155 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbeGOUzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:55:21 -0400
Received: by mail-it0-f66.google.com with SMTP id p17-v6so18342863itc.2;
        Sun, 15 Jul 2018 13:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68SHLh/hXjBRMiabg9htmHZmFUPGkp/Hncywmk3RhIQ=;
        b=P6VRPEwS6p6SCjOBLzRGe2ykuZGIsean3LQHtiVDjsyNwycIOuU2WKKM/KN18V61p3
         uWvQ2c332d90v2dzDeTZIG01DvAcDg2p6TVIq4ScKQ5tkoONS3mGgwWeBOBsXtKq3G6A
         /k3FxnFqqT45IOSQdgyTJ0ElGEzZXg0AHV+g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68SHLh/hXjBRMiabg9htmHZmFUPGkp/Hncywmk3RhIQ=;
        b=AXnWU0Saae2s+cqXHfIYckB2GWCsVJPnps3nljcI6agyCADy9VWbWjWtE8ibbs+ere
         nX8mBIbawggMVW/NmQnFqbuzKKQqZqVZwsg45uyGkVO/5RacbazPbnOksdEmCglXaZtt
         iuMp71mgzKNPVXb0Nl18nWbOFNU3gAxyCxvQZX3aGp0mSunhjylWfCLY8ytHKGeLSVDw
         m4Hlc53XRC1JVrShy6KaEp47vN4fJ9LAKswwZnN+orApkUJ6LBRFuLdPY7333XnbPjyc
         7LUdwcCwRX5bmgUQFf00tTKSMg+6uu1pPMBNfdzL5cYmy2tTa7YO0rlc74QsqiY0EkVJ
         bzWg==
X-Gm-Message-State: AOUpUlHGy5auDE0Cg3kKDKaVMrb1bin7HeiiNnQyIbG1ojQesh2ijBC+
        cxA02cf1K42LYS4LqWBdXqSw0VSGQputx6E6XA0=
X-Google-Smtp-Source: AAOMgpdVibOB6ReqLq/YuKMsJZrWv4L858HjWFOdHrV6WJG5JbbvieO3GN/Pne9lztGJhj8f2UKLDcQ9R54psxGQ4S0=
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr12206600jaa.10.1531686674892;
 Sun, 15 Jul 2018 13:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <1530601587-160436-1-git-send-email-xiaqing17@hisilicon.com> <CAPDyKFrPw63KD5mESDmm2pya6bsz01jHiKguMP1GPhWDDZ644Q@mail.gmail.com>
In-Reply-To: <CAPDyKFrPw63KD5mESDmm2pya6bsz01jHiKguMP1GPhWDDZ644Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Jul 2018 13:31:04 -0700
Message-ID: <CA+55aFxONTOE8A+Mm=V2mieqnJ=Zypvu+NJeede2aR7kLu5SMA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: fix card threshold control configuration
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     xiaqing17@hisilicon.com, Jaehoon Chung <jh80.chung@samsung.com>,
        Evgeniy.Didin@synopsys.com, shawn.lin@rock-chips.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 2:00 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On 3 July 2018 at 09:06, Qing Xia <xiaqing17@hisilicon.com> wrote:
> > From: x00270170 <xiaqing17@hisilicon.com>
> >
> > Card write threshold control is supposed to be set since controller
>> [..]
> > Signed-off-by: Qing Xia <xiaqing17@hisilicon.com>
>
> Thanks, applied/moved to fixes for 4.18!

.. and during making my 4.18-rc5 announcement, I saw the odd name in
the shortlog.

Now Qing Xia is forever attributed as "x00270170". Very odd.

Oh well.

                Linus
