Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15387C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F1B2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PAhSupFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F1B2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeJaB1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:27:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33636 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeJaB1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:27:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id i26so5061802lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJrZvfDPlqNi80HTlahaDqK3DS/iMpx/ysfAKavNggw=;
        b=PAhSupFRk2y4kQZsGCXYibTwSofl0ae0KII52G7IQtCXYtMAjp6GA6EJvyNU5Ss8T8
         8291y7NNw8ygExgPzGifNqwEWCpCFI/uNZewXYU+s+k271UBq6TfSBOmZGbv2KNkMCgN
         M60nqmwPbpl4xfvxFyP+TlUCpSqjKkt4bLp+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJrZvfDPlqNi80HTlahaDqK3DS/iMpx/ysfAKavNggw=;
        b=Kvj2ZdTXVyvAh82VC7cGlarwB/gsOIALypY+2Fu5WAUGIH1rCrq+gFTKy1Xsz114xr
         a5yUSuXLyrOB5of8+BFhtykMicXL3GTxPxZI+kghgy9vR/TeKw97flN0gQmLMXgp4x4E
         8T/6j58CuB9S2OXgef2QBgGf886b4MMnB3tK2xLWE3N4F8J5ATFv1LmzHp4/exDX4wsE
         3le0YqB0K4chKZZlHMBAsAC3E539S6sJLvnW9v2D6hiiVAi6aTSmvWzV1NgDY0IagyF1
         8DJo3febWXSR5Pj0f5+vkeEtVgesF0OR/EqPLQQdQTTVdlf1nHtUCVEa58NJtMgMyTGH
         QPjg==
X-Gm-Message-State: AGRZ1gKDSDF5I8mWgG9X8lobOqigiXMAGjDdxegLy2DOfzX/vnZuUpXx
        Ue/onRZWInVOlq3ntIad4okBcBmQC+aWYg==
X-Google-Smtp-Source: AJdET5dUk5ase8yIfvmXwFUvgg9VzRhtvU/kejHNt1kRzkwqTFx2qmEwWrPcWK3wVEwvJ/bkncmKrQ==
X-Received: by 2002:a19:690d:: with SMTP id e13mr2327749lfc.84.1540917184207;
        Tue, 30 Oct 2018 09:33:04 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id c22sm3611785lfd.88.2018.10.30.09.33.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 09:33:03 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id g26-v6so10727718lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:33:02 -0700 (PDT)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr7632057ljj.6.1540917182332;
 Tue, 30 Oct 2018 09:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181030074420.17905-1-jgross@suse.com>
In-Reply-To: <20181030074420.17905-1-jgross@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Oct 2018 09:32:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiWPqTxQuND8zVpYe7gEKhnZnPtd02up4i7C_tDVPrdA@mail.gmail.com>
Message-ID: <CAHk-=wgiWPqTxQuND8zVpYe7gEKhnZnPtd02up4i7C_tDVPrdA@mail.gmail.com>
Subject: Re: [GIT PULL] xen: fixes for 4.20-rc1
To:     jgross@suse.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 12:44 AM Juergen Gross <jgross@suse.com> wrote:
>
> It contains only several small fixes and cleanups this time.

Pulled,

                     Linus
