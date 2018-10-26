Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB48ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEA020868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AG2oLHGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEA020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeJ0Duz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:50:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33510 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbeJ0Duz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:50:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id z21-v6so2157333ljz.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/NAyzj41miMsepMCgm8N+ws9aVNabRWSiKHNaYbXYOM=;
        b=AG2oLHGvTG6OGqGlZ+auVv28hTUxCic0WDIQJ3C6aWHwuYXArPBhPUX88cnSdTtdg/
         q6EnNoamPHjFKg1ATAAlDWsKXwtpIo2qLNiNcfsZ7eR9mTib2ouik+pmJVzonq2lWT0V
         uHR6WpDO+dtQdHtoPXYQPnNePB1v7rDn1jaMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/NAyzj41miMsepMCgm8N+ws9aVNabRWSiKHNaYbXYOM=;
        b=LlL8GQFlWq+CAzReqmnjysQ2FReMy9aEUtOSyLA888GLR6i7KjL4FaLfT0dvl9dqiw
         Je0fc5V7/bprjX+Ad1N9wvQXB6NKTTUL8w4LwLyze2TLKmSUE4x+8/X+F74hSaAjXUud
         62izVfUEW+IpYd9CYxPI2pd1A74taOkfzMRx+FytPMBnbfJ1uBg6yZx9XiFkjHwZEF62
         rHMK76XLJJnfCt/SPe9LSI9zrklV3wmZmf1oQdQO4JUQUFbCsXSRfXxwyW7kTDxg2cBj
         B27Z9Y4Y7QsJ/+H0nBaWGcQsQHBe95L1G31UxkNOrf0v0R413rH0gu6mw7b7uynVSE7X
         lsgg==
X-Gm-Message-State: AGRZ1gI+ta9MoRpAXye4v6B4dsvLqRsXHvnKVmMfmsWL4XT3jMNFAKMF
        kKlELvJPytkrHqRLltUJuPPgDlx5eFSiYw==
X-Google-Smtp-Source: AJdET5c+cI3+dGuM2O4gGCnW3hlZg0DiOg7tiDmC/wijK+RM0DJJd8SKyrR3d6n/LEmR2mrDj+PCIg==
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr3198463ljb.176.1540581158539;
        Fri, 26 Oct 2018 12:12:38 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id o19-v6sm1686635ljj.81.2018.10.26.12.12.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:12:37 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id s15-v6so2151426lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:12:37 -0700 (PDT)
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr3436285ljj.80.1540581156773;
 Fri, 26 Oct 2018 12:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_JsqJKkPiHBbJWMF5=JzxZyO+UTN0qLFLnjvd9txkUQPdznw@mail.gmail.com>
In-Reply-To: <CAL_JsqJKkPiHBbJWMF5=JzxZyO+UTN0qLFLnjvd9txkUQPdznw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Oct 2018 12:12:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVXRfxpkMFo8kiLjEv-ma94DOFv7cgbr8FQ-hOfK_hoQ@mail.gmail.com>
Message-ID: <CAHk-=wjVXRfxpkMFo8kiLjEv-ma94DOFv7cgbr8FQ-hOfK_hoQ@mail.gmail.com>
Subject: Re: [GIT PULL] Devicetree updates for 4.20
To:     robherring2@gmail.com
Cc:     frowand.list@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 9:07 AM Rob Herring <robherring2@gmail.com> wrote:
>
> Please pull DT updates for 4.20.

Pulled,

              Linus
