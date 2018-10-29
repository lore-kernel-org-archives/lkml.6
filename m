Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E5C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCB4205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TtiHgi5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCB4205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbeJ3Hb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:31:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45240 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbeJ3Hb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:31:59 -0400
Received: by mail-lf1-f65.google.com with SMTP id c24-v6so7349137lfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XGQxaeGqsDqt9n2WS3hN9q8IwqqBLrvfyZYm4NvFW0=;
        b=TtiHgi5szNqJG5qohHpEtNHEn/R+3LYcbhAkT0pLYVQQdcCFJ0blRLm3z1BBi8PQMA
         bHfSArhtySnx+lv4ljvmyzBQO/5qp1zg/m3Pcsp6uCOrOo+pFTcLUhrj67M0n7/TABtS
         5OawKI0IGidSy98ZKKH6Ni/sGRIz1VDKG+dZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XGQxaeGqsDqt9n2WS3hN9q8IwqqBLrvfyZYm4NvFW0=;
        b=aGhjSyiN4KKLuJbF7SfcSrjUXkoCPNaeQU3zfQeVhSeHiaWDy+C58T/5+Kb6qM37fk
         3u33M2twC3iUiX2Tc/LuY4DxaFoOJxfoZzBN2OYoKTmOxIo3vz/I3p/Dv4yksOYeYC4y
         /hi2387vCuGgK3FNvECyOgaPJqZ9wbaOFuLizZRmjPh9FgJZyX3gOcPEpfvlQ0QRArbI
         3Ko4Cqia/FaTFvoj6BS6MSKLR8WQmoGycobPK97CB0uOiTo8c5nSUSnz7+6nVeDDh3+e
         rr5GG904X4laS+o0tbYyLcMEAcTrjB8bHcSJiGa49yK9ob5QbdGoDn5AWMDgtjSJipO3
         1jdw==
X-Gm-Message-State: AGRZ1gIkThD3jfg1J5PrEHWGslsxq93ulnlGXI/SSbHjYkAqEsnVN5I+
        qt/thTgY1gu16EMmbQOMEape07OPl0s9uQ==
X-Google-Smtp-Source: AJdET5cM7pQdnE3W+jQlQPsa2AoX9mXBRPnQRRZ1INMOAWLrBzc+PjG6oAGUWNLsM3JuD/hL33hfIQ==
X-Received: by 2002:a19:9844:: with SMTP id a65-v6mr358263lfe.63.1540852872921;
        Mon, 29 Oct 2018 15:41:12 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id j66-v6sm3460867ljb.45.2018.10.29.15.41.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 15:41:12 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id u18so7351626lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:41:11 -0700 (PDT)
X-Received: by 2002:a19:288c:: with SMTP id o134-v6mr373925lfo.124.1540852871412;
 Mon, 29 Oct 2018 15:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0RbZiHCF+krpmPpmH=4yy5G57NoTDpOKE=xz1wbgy78A@mail.gmail.com>
In-Reply-To: <CAK8P3a0RbZiHCF+krpmPpmH=4yy5G57NoTDpOKE=xz1wbgy78A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 15:40:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdG=tSrXoFYrBqNn=EvoJQUC0FW6rR1HrgsNJ5FbpM3A@mail.gmail.com>
Message-ID: <CAHk-=wgdG=tSrXoFYrBqNn=EvoJQUC0FW6rR1HrgsNJ5FbpM3A@mail.gmail.com>
Subject: Re: [GIT PULL 0/4] ARM: SoC changes for 4.20
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, arm@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 2:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Here are the arm-soc changes for the current merge window, with a
> little delay due to the conference travel last week.

All merged. A few conflicts in MAINTAINERS, and a couple of trivial
ones, but nothing that looked too annoying.

Please do check it out, though,

               Linus
