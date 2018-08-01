Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C36C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4680020841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="e9WQI3sa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QZkQjsbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4680020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbeHAHfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:35:37 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45361 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733166AbeHAHfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:35:37 -0400
Received: by mail-yb0-f194.google.com with SMTP id h127-v6so7103162ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 22:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=d7p/v7PIZEh71aAayytxrAn1H6ibMVnAFkZCOvYJs1A=;
        b=e9WQI3saQXFX9Ed76kPjHHcCscGlXoYXssl/gHIvYlDQmuiYuvW1ohLS1va7UZTjk1
         QKq5iFXtQ5dglbTn8xH+5ooRsW+czKHm1V7GPJ1WAIwUZMt819PQpd2zmS1WgVM4GXG3
         1vAZn+Ah7Z8tXl4X8KOBgID5CWMGL63VHwbLxhjrJh6MXeNk3Winb4HUC7Sws6r6pO3S
         4f9QrH9JL1RhoUPehA5NLhmN4vjU+yylPVB1uNF4sW2vOZUiuNq/Y5oL4MMkj+DYuIJk
         jPVN+yF9HPBD54pnJZ2uY6WvO2sDSSas9O6zEPO8BxsGVV/Y4Q8MtjwQiKsdoQ7xwFi+
         +U6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=d7p/v7PIZEh71aAayytxrAn1H6ibMVnAFkZCOvYJs1A=;
        b=QZkQjsboJxI/bgM1bndaH+5Z0Eluy1WmaAxyxZRFuk+rx0uFhmwAGMSgT/cY6DjQ+K
         8Q8poWkEcO8DTuTwJjmd7DgggGlqcG5dSz0Ducd16HNzL0YsXBjWgCCewCtnK99nU0Xo
         9tz29qWvwXjLnE9hu1CXvbXF3cCKOvfCHhrME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=d7p/v7PIZEh71aAayytxrAn1H6ibMVnAFkZCOvYJs1A=;
        b=QnzzGXC0OVIzCrM7Fz5zVoq7pEJTuyYAwlVnClKnnWMX0hAZEVYcTYCpZUZhE6qIU9
         RNlluIJtUQfq8UtXPq3TuzEqsQNjplapLBa7uEiD4+AKdwX1TwF9p84n2mszVxEVeBeB
         wPcy87PMRx0iN5ERIAokXvT2kc/fOvcomuBXAge2cwFbH8o7FHUc4Ev/xGLOIJyUbxR7
         jj2QxZ0CtYPv478KphhD89pqj8EicU0zi/yP7Z3M4zKW27FsQG1p+q7t2E+bGJdjE0EN
         yFUd3QE8sq8UyBtwJMgxgDOOU9iLsUCF3+BO7wCdyO2sh8O80QGYhu1TIS4DMvnJJORC
         yjgw==
X-Gm-Message-State: AOUpUlFTTpMQU5UTQCJLzagKrcoo+2gg0GpzVJ/2mynEfDtZfzl0Nzcb
        FMxIho1FwjWfjaaPXpMxilzZ8rn9mblDI+ZMPNcHxg==
X-Google-Smtp-Source: AAOMgpfzhqNviRgF7q1857cZkGeMIGErkTDGh3ZfwVvjGVDCkmm4KX+7+40iWufjpU/2LFh7CHRZFt5zP9Ki4eGPAaU=
X-Received: by 2002:a25:a302:: with SMTP id d2-v6mr13363269ybi.193.1533102703450;
 Tue, 31 Jul 2018 22:51:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 22:51:42
 -0700 (PDT)
In-Reply-To: <20180801021353.GA31192@ziepe.ca>
References: <20180801000039.44314-1-keescook@chromium.org> <20180801000039.44314-3-keescook@chromium.org>
 <20180801021353.GA31192@ziepe.ca>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 31 Jul 2018 22:51:42 -0700
X-Google-Sender-Auth: 6nlVoRYXV-jA65tyMFoeW5xXvqg
Message-ID: <CAGXu5jJ5y_0mJ-ijPX-=mf5sDEqwVh_BaV7GVumi5tpirbp19w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] test_overflow: Add shift overflow tests
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 7:13 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Tue, Jul 31, 2018 at 05:00:38PM -0700, Kees Cook wrote:
>> +     /* Overflow: high bit falls off. */
>> +     /* 10010110 */
>> +     err |= TEST_ONE_SHIFT(150, 1, u8, 0, true);
>> +     /* 1000100010010110 */
>> +     err |= TEST_ONE_SHIFT(34966, 1, u16, 0, true);
>> +     /* 10000100000010001000100010010110 */
>> +     err |= TEST_ONE_SHIFT(2215151766U, 1, u32, 0, true);
>> +     err |= TEST_ONE_SHIFT(2215151766U, 1, unsigned int, 0, true);
>> +     /* 1000001000010000010000000100000010000100000010001000100010010110 */
>> +     err |= TEST_ONE_SHIFT(9372061470395238550ULL, 1, u64, 0, true);
>
> This same idea should be repeated with signed outputs and check both
> overflow past the end (<<2) and overflow into the signed bit (<<1)
>
>         /* Overflow, high bit falls into the sign bit or off the end */
>         /* 01001011 */
>         err |= TEST_ONE_SHIFT(75, 1, s8, 0, true);
>         err |= TEST_ONE_SHIFT(75, 2, s8, 0, true);
>
> And also general type mismatch overflow:
>
>         err |= TEST_ONE_SHIFT(0x100, 0, u8, 0, true);
>         err |= TEST_ONE_SHIFT(0xFF, 0, s8, 0, true);

Ah yes, thanks. I've added these for the next version now.

-Kees

-- 
Kees Cook
Pixel Security
