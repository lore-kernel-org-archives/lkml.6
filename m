Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B08C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA6D20848
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AxF+V7nS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA6D20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeJ2FEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:04:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40022 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeJ2FEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:04:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id n3-v6so4487637lfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNPbE+LOaOkj9I25+u+uufWDi67xo8XB59feH9bv7D0=;
        b=AxF+V7nSfwJh0rntlfTRPKD+jZIvhvdLK2goErBsdOWDrK46QXVj0Ta2kaMozKy3Bv
         R0wAbNWYNEQmlgjVfIN0/ktjW2Vj2SsJXZiIF+vxSjKcdSMRXF/iOGp1mZsNuDvVnaZn
         Vt/aqsHc/uKx7TsxzRuhKtk8G7mD1VI50wYZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNPbE+LOaOkj9I25+u+uufWDi67xo8XB59feH9bv7D0=;
        b=E4v5D/zbg6fWWaSPBAGco9sxBFr13CIbNiAU91tRIbhk273WDV5hUkj+dRvc6xRgbU
         hnuboCBo+FwfjEYillZO7QtGVFvQIxnKcSL+rmyvK/QXJXlwNQ2MtCfhyMPiFbwptf/S
         4s4KDFMYr2zoO6dF3SKc8Ek4z27kqPxdG9JXmmQwaXnGrN7LQsxsvWPltesDVlzsg9qF
         QN/90trz1R0j3LSb6oEd9T6JyWR7LvSLtABNdxP7GJuaL56XKQQ1sd9wK11L2CA0kB+M
         e6q0VvSixqDLtwJzgt1ZfuqL9N0zWK6KAl3iSolaqw3WXJZ5TwW2d0g2rsjWYGZfHcpM
         8kGA==
X-Gm-Message-State: AGRZ1gIvdtPpPwSRapX9hhJFB2+xEjRaYxBTwtb1fiRu0YEnrqpojZwA
        LpAPuqWKhFpq7bXNcZftR0wIU3Ss5t0=
X-Google-Smtp-Source: AJdET5fZRN63LqwrwGSR765aBttJJg8FtDZffSF96d2ro2c/6SJ6xwNZzGfqEoFRMAsQFNxMdZDOPA==
X-Received: by 2002:a19:8f45:: with SMTP id r66mr7089086lfd.9.1540757903383;
        Sun, 28 Oct 2018 13:18:23 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 18-v6sm2654602ljo.74.2018.10.28.13.18.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 13:18:22 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id s15-v6so5809390lji.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 13:18:22 -0700 (PDT)
X-Received: by 2002:a2e:7f14:: with SMTP id a20-v6mr7289483ljd.148.1540757901794;
 Sun, 28 Oct 2018 13:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <407e4b9c-36eb-d533-331c-2396460c6f67@kernel.org>
In-Reply-To: <407e4b9c-36eb-d533-331c-2396460c6f67@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Oct 2018 13:18:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWvPGpphQTekU8_vcCgUrq1H=gTfS4sRHq24aJ+NYZCw@mail.gmail.com>
Message-ID: <CAHk-=wjWvPGpphQTekU8_vcCgUrq1H=gTfS4sRHq24aJ+NYZCw@mail.gmail.com>
Subject: Re: [GIT PULL] kselftest update for Linux 4.20-rc1
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rostedt@goodmis.org, mhiramat@kernel.org, sfr@canb.auug.org.au,
        pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 11:36 AM Shuah Khan <shuah@kernel.org> wrote:
>
> Please pull the following kselftest update for Linux 4.20-rc1

Pulled,

                  Linus
