Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8D7C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D818F20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WXXluZ4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D818F20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeJaEuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:50:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44519 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeJaEuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:50:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so4083689lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOkwOqssMjyafSoai3HcfYwmvF4VbvbnRJ6G5ZW4Cas=;
        b=WXXluZ4cqUIPvnFpEBcgME3yU2q3gJb3h/zbjbL7hECewLvYZSiJO9eQ5Xdg2xYU9f
         6k5JdWPzB58gz2qQVFQ+MFqymmY4E+bHFOysi6vF+/OvS5bmr+bi3DtSvy0/MZJjq1Yi
         ZiN7pEv49JmLBxWdBMNDoRKrEgNVGKkboP4e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOkwOqssMjyafSoai3HcfYwmvF4VbvbnRJ6G5ZW4Cas=;
        b=eS0YYtxNnCVMx/rejJe499Dq+wMR9rjVa5bF76A4e1hbE1QtIanR3s3i+JBHBZLszr
         sPQlhDcMUg/rf5jM5p+uPwS8SidKQ6YNAdnZtgMQ7aH6evTK042X/RlPuUNDf22phus2
         cnCHaCjKwoib2Pe3XziBNLoMOJsy6ADzPopb6USgtl3FQL0woaGjJX8jwpLdjebdu7ze
         HCYMMAuvyo8mXEwX4fjAKJhDYkapxS/QHdTxfROeCm3dl3pzKRQ828VaB8zAwl8HOSMY
         Mlm85gwDq/vdhrdjcNb0jPo8yGy62hMmM9fuK91FRHnAePweyjC6bUgtJz/h3SIzXH+R
         Kq9Q==
X-Gm-Message-State: AGRZ1gLSog/gre7lc+GI3aywnp5h362jitgDKVPF7ueIoouM8QZBL6eF
        jS0kyh/1gJ/L4VF2P0sxllAK1Ns43OZQew==
X-Google-Smtp-Source: AJdET5eO7vuoXQ7RDz3212AKXso4ypoSzgFVFHAGpt8Ef0TdUmQxuFezKElJpWyQKpBLWgsKkoH74A==
X-Received: by 2002:a2e:88cf:: with SMTP id a15-v6mr75572ljk.76.1540929329348;
        Tue, 30 Oct 2018 12:55:29 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id r22-v6sm2524129ljh.77.2018.10.30.12.55.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 12:55:28 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id d7-v6so9882060lfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 12:55:28 -0700 (PDT)
X-Received: by 2002:a19:288c:: with SMTP id o134-v6mr70661lfo.124.1540929327811;
 Tue, 30 Oct 2018 12:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181030191710.GA23042@fieldses.org>
In-Reply-To: <20181030191710.GA23042@fieldses.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Oct 2018 12:55:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+-POnmS41x9SKR+CB9va3ZnmRmCF8S7wNEw0QVATHXA@mail.gmail.com>
Message-ID: <CAHk-=wi+-POnmS41x9SKR+CB9va3ZnmRmCF8S7wNEw0QVATHXA@mail.gmail.com>
Subject: Re: [GIT PULL] nfsd changes for 4.20
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jlayton@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 12:17 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> Please pull nfsd changes for 4.20:

Pulled,

                  Linus
