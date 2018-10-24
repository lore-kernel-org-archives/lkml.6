Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C09DECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12506207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RRuKTB8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12506207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJYBb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:31:59 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:38639 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbeJYBb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:31:59 -0400
Received: by mail-lf1-f42.google.com with SMTP id x24-v6so4554939lfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 10:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CnRgWo1UO4bGmD4InqiDFs61Ck554zCZy6ouI3oj2Q=;
        b=RRuKTB8pA9jtoIpgnI4SlFP1gmq3d6sfJl6gkRtgdQW4+22SW6RtBUeLUfPLG2ZUU4
         Ov86rVSFr9dwn5pfF90tEBYVtcoUs78w8kvz0w4hK4SlnDXgaxQM0JL+AQQUxa+sqBJt
         xGk2GwmWJfgjgjODWWzFY5CI7moB7f0Kf+GDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CnRgWo1UO4bGmD4InqiDFs61Ck554zCZy6ouI3oj2Q=;
        b=PenvATSBWYvVRI88UBKMjt2erNHeoEl5RwnAuf7GZ4nzWFS326OxhfrOtYimXvP+Nw
         wY3KkhZd/muD6OGA0RdUy6/qqq6r8vYkxmvDR436j5ZRZvo0/wYiCHS2izfNO8bOfFdu
         jBfcvYbR+p1mGsam0JQrlwbPMREfc//vMp9DoNmBj+YIT0vuA4Otp9MTC7PQs/28ZVDH
         cpasbTYqnoIJGq7WqZUe/88RCr+9OqXdwXEc6rAfSdpVSyhQaw3zdVAHRr721toMsAGn
         CF1MpHV9ynp8yXrtMxDEYr0mig3qaf1LRj/QeunY50db+uhplMNhqkp7HOAbEq90nPFf
         Y5Rw==
X-Gm-Message-State: ABuFfojzSmh6+LJAyEMQ3GPXm+WXFNaxi8gC1rSC8FbG1ZlYhP8xk0L1
        3aPm1WCI/U6C3I1+6icFedd1P+rmeKdQGCfn
X-Google-Smtp-Source: ACcGV62/3syqXzEwM8pYHDiJBSjqy9z1JfX7AlXV/1V+VU90nT+E5LNcJ7m+gL8NSX/BbqSw8ffT3A==
X-Received: by 2002:a19:d612:: with SMTP id n18-v6mr14841005lfg.4.1540400586512;
        Wed, 24 Oct 2018 10:03:06 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id n3-v6sm792701lfe.8.2018.10.24.10.03.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 10:03:05 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id p11-v6so4539020lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 10:03:05 -0700 (PDT)
X-Received: by 2002:a19:111b:: with SMTP id g27mr16525259lfi.135.1540400584955;
 Wed, 24 Oct 2018 10:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181023021126.41bdb1e0@lwn.net>
In-Reply-To: <20181023021126.41bdb1e0@lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 18:02:47 +0100
X-Gmail-Original-Message-ID: <CAHk-=wiOWBJVC4che1ZN1dyFR7vNiW_C7LrdGe+LjGW+uZs+3A@mail.gmail.com>
Message-ID: <CAHk-=wiOWBJVC4che1ZN1dyFR7vNiW_C7LrdGe+LjGW+uZs+3A@mail.gmail.com>
Subject: Re: [GIT PULL] Documentation for 4.20 (or whatever it's called)
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 9:11 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> This is a fairly typical cycle for documentation.  There's some welcome
> readability improvements for the formatted output, some LICENSES updates
> including the addition of the ISC license, the removal of the unloved and
> unmaintained 00-INDEX files, the deprecated APIs document from Kees, more
> MM docs from Mike Rapoport, and the usual pile of typo fixes and
> corrections.

Pulled,

                Linus
