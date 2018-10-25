Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321F2C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D6420834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VRRQPRt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D6420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeJYWPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:15:24 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:35222 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbeJYWPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:15:24 -0400
Received: by mail-lf1-f41.google.com with SMTP id d7-v6so6848901lfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 06:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YP10kUcef9CXu5lmOwjHrfwCbhuK8Y9LOlhlihamies=;
        b=VRRQPRt257zG+sF1AcQMn9osUGA7hYYrWT7rLy80DruNvcQESs/4Zee5MIgKoVVsqe
         NLQtADMBl6CNvbRQvU0DFPrxxq6swrGsr0oPOspxF+q5xLiTRZfQGflubTiG513a8SR9
         /3pcutkE7ghG9p4A4OUeA6lyxhhnVQFiKUzZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YP10kUcef9CXu5lmOwjHrfwCbhuK8Y9LOlhlihamies=;
        b=rj0Nld+iQHUcDcsAra7OqdS+hCmNkRFPwoYsdbwm18UBHogDpesfe4awhx+NpOjP7H
         aRW7JVkaLoxVbaxL3uWHGLBRjoa2oCdLfRHl5f/CFz1NVKAVpJcEhL+az4rpExxjRTvk
         yhZRdU1J5j+OmcyVIzW9ir7o2BTSbpAmySJbCf/HVb0O7y3438z+5yEMKePPFkyn8KOy
         QKl3euBmBOBgxGxuUAA/+3DvCnYV/CFfJIIrw2D0Cw/S7Bbk/kTIwi19el080D7I2fHV
         Y5lYTQqfe85mlrQpiUkIpNLZ+y1wi4mH3LbrX+UA1Yu9rCX0ZM8qDtIkYvKXHvNOsglf
         5h5Q==
X-Gm-Message-State: AGRZ1gI5dYxN7D4fbIWZOBjA/KETfllKf09jxSgbOSiGsqZEkdAI8L6p
        8pYsjVI9oK8SOW1JgmcQ2vgxBszjBYz1GEFt
X-Google-Smtp-Source: AJdET5dz5dlXPf0NCnv60Nb81fk77d55LdlbFRfZ0Z6z3TYUjzP/UxgYwzHaap426CVuVs4IKGs0tw==
X-Received: by 2002:a19:2203:: with SMTP id i3mr1316857lfi.2.1540474953280;
        Thu, 25 Oct 2018 06:42:33 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id t6-v6sm1113537ljd.2.2018.10.25.06.42.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 06:42:32 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id c4-v6so8269611lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 06:42:32 -0700 (PDT)
X-Received: by 2002:a2e:9dc4:: with SMTP id x4-v6mr1409328ljj.133.1540474951612;
 Thu, 25 Oct 2018 06:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181025073832.GA13240@nazgul.tnic>
In-Reply-To: <20181025073832.GA13240@nazgul.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 06:42:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnVbsw1DD8fzpw2i_0HnnXUuwBeJes+8nF1UVwvNnxUQ@mail.gmail.com>
Message-ID: <CAHk-=whnVbsw1DD8fzpw2i_0HnnXUuwBeJes+8nF1UVwvNnxUQ@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC updates for 4.20
To:     bp@suse.de
Cc:     qiuxu.zhuo@intel.com, rjw@rjwysocki.net, tglx@linutronix.de,
        tony.luck@intel.com, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:38 AM Borislav Petkov <bp@suse.de> wrote:
>
> the EDAC tree was busier than usual this cycle as the shortlog below
> shows.

Pulled,

                   Linus
