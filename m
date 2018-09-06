Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711DAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4BD20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4BD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbeIFUJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:09:16 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:41983 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbeIFUJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:09:16 -0400
Received: by mail-qt0-f180.google.com with SMTP id t39-v6so12721831qtc.8;
        Thu, 06 Sep 2018 08:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pmq0aP8AsZXHxIFUzVAzjm4xPIZGowl9iQfl7lsLmzc=;
        b=ZKem3uGYb93KxlP+QZyaR7Y7aEst6zrv0si9UGBpaRy45en2pEQpqshWIlV3hegsB2
         aOSqOGz4TXKRjwRCDpw6uR5tYH9jBAQLt/ioHKLiQycrShO+rV+AvbDkJGyPbBLITquz
         Pjz4zIwIC6giWcPybIC7Q9R4kblCVyH1T52BFe/jL/8w/VEvdP+yh/jGhDgqmkWzZtj6
         j3GL3GO39ndHNQbMu7XekiIJGN+fSIX1g5H+nJhMHh/L6I9vRD4576/RHVP1E7HhcA/c
         Z5za84q3os0VmrXFEgriWiRP87cC7YeCMH+DZPbeHjIIEfDQgh2UGdeJj34QVCq+Aaa7
         2KHg==
X-Gm-Message-State: APzg51DYwgl+zKMo4m6tq2ta0R+Q0mNE8MpSqN18k7nr2EenCsgjFrf+
        +1vtWn6Z9NLkW7OSdUqkFcbmZZK1Z7etjrNn1PE=
X-Google-Smtp-Source: ANB0VdYiYrGcaE4cDFgTCVzq1kR/KD0BlDXh2ztemuPQ0T7A8UAbwxcu3Dl54fBDxL7/GHv1ADNXvuJqK8ecn/VtbIw=
X-Received: by 2002:a0c:a8cc:: with SMTP id h12-v6mr2554322qvc.161.1536247992716;
 Thu, 06 Sep 2018 08:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org> <1536036087-15260-4-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536036087-15260-4-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 17:32:56 +0200
Message-ID: <CAK8P3a0cfk6MG2SBRhJZ41suHw4D-dyCYGhqV9YeD_1rSMrGqQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] sparc: Add system call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> The system call table generation script is added in
> syscalls directory which contain the script to generate
> both uapi header file system call table generation file
> and syscall_32/64.tbl file which'll be the input for the
> scripts.

I would argue that for sparc we only want a single input
table, since the 32/64 versions are similar enough that the
differences can be addressed with 'abi' flag, rather than
having everything marked as 'common'. Isn't that the
purpose of the abi flag in the first place?

          Arnd
