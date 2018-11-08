Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65446C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2002086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HMOHCfGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2002086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeKHVoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:44:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37697 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeKHVoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:44:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id p17so13967898lfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 04:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOw5lo1YzhAEOnsqhLPIirFUGQEuwK1ymOTIG+4zuXU=;
        b=HMOHCfGoQmFsLecjDCGdrA51bTNzkyv2IU1Gmkjq7PYhuIgNAZE7BMFeBVIXIuc47M
         s76brHYh1toNu+h9N/62woBO61gwRG7VQfSTGSdshdKJFgwTFb7V8ydOkUXqKcu+PV/D
         7tZi/tdtr0ofnF7sGRCYc0gk4HsBWwOYzwBxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOw5lo1YzhAEOnsqhLPIirFUGQEuwK1ymOTIG+4zuXU=;
        b=UibbDyVAlnOjZcDqpMXGd5WgKpMkXhXqbUI96Z8RqtYxrbXFYY0rBawRpspw0SnJyu
         EYd1svRW39ZZlozVjlKXg0xnqL3RAJAE33Iih9m4CSYQ8ZaHUdCM20i7IfnNUSEdycQN
         z8JgGoLkYqxRJQ50aSIx7PPTRIFP4p+adl/X9jvxS5vngZUo91fab9x1wUUpeFEb2ClG
         t5yH+8v5R1bnUbDg3SsR0MBl0s1SRRYrpCvAdDn5Q4sz2esOefJThCaJI9thdtnyZnJc
         Yuljb0VVfn6McaJJw5jC0DWWpe6b3pjH6qcyY2UJE45HM0Jn7XCieLuhGtkXvhETqSij
         1qKA==
X-Gm-Message-State: AGRZ1gJoJVRqsvSYtKqT7cNKV66l0J+zOEL88RwuY+7IOfdjkTIYKvb9
        UzDez7WuKWhvkfPYFs+pXfF8TOfAd9E=
X-Google-Smtp-Source: AJdET5ci8loCgg6i4Y9tk1DYolyfZy4+mL+1oMeeY87dJSUKR/KG1SM+NlHPRv4CKhzXSul4dj6Iew==
X-Received: by 2002:a19:2395:: with SMTP id j143mr2494595lfj.107.1541678942070;
        Thu, 08 Nov 2018 04:09:02 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id v64sm652502lfa.48.2018.11.08.04.09.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 04:09:01 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id p86so14001613lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 04:09:01 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr2164415lff.16.1541678940479;
 Thu, 08 Nov 2018 04:09:00 -0800 (PST)
MIME-Version: 1.0
References: <20181108110004.GA14625@gmail.com>
In-Reply-To: <20181108110004.GA14625@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Nov 2018 07:08:44 -0500
X-Gmail-Original-Message-ID: <CAHk-=wgfg1Earpr81awn9AiMw5Wtn6W0JDRcUHXCyCxqt_UHnA@mail.gmail.com>
Message-ID: <CAHk-=wgfg1Earpr81awn9AiMw5Wtn6W0JDRcUHXCyCxqt_UHnA@mail.gmail.com>
Subject: Re: [GIT PULL] Compiler Attributes for v4.20-rc2
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 6:00 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> A small patch for compiler-gcc.h and a trivial one for compiler_attributes.h.

Pulled,

                Linus
