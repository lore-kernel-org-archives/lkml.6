Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C4120659
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C4120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeH1Qqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:46:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38301 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeH1Qqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:46:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so1322816ljc.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 05:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jJ91tDEmfrAuyJMYmwnbXGVkdksIT+3U/yB4C2ilmPI=;
        b=N/trtRjCTkXXlsFwM3pLAPYhGzq0UGQ9RAPsIXmRMjAlBKq5Kdq6d2yXZxt/b9iwcz
         gTap7FFdt8LKtRi9tf/e3+g8mWt/8MrsjDGFSdjyzbhIbCWqfCxDFsBlgzt603lsAwyv
         rvYq8+hkPJPl3RsZgX847ZODtbnek0fbe1NqiGwmb2FrUU5Elrz3TC3XpA5gl1PqgySS
         +Rhv9UAHKvjrUFEYCChchnGBOBS6U5PAlG5KNQZ/bYqhNfEa4XquVRk/Q+kfGXwZ5FAi
         J0QIFJv8KxtHmB/ar7lY0L1SY8VRja40sTCVLkF+TPIPmU7ryesHVT/FEgJ9DrnWJrOv
         lv6A==
X-Gm-Message-State: APzg51AS8Gf7jz3CV5opTCSkgiTlemWlk9mokUSgV5ed9qKFipA4I6WR
        P5TM5PwmQSJoSZ6+wFNDZbXw42eTJF28vN9Bs9ol5A==
X-Google-Smtp-Source: ANB0VdZwpYRlyFZQdUzB8d92rKNJO8huDVCtZkHkA5BjltLPlqbeCdBCj5/ztlNuXbXeOIIwBiqJ1DEcBrbNIohbGEQ=
X-Received: by 2002:a2e:55dd:: with SMTP id g90-v6mr1213507lje.4.1535460884117;
 Tue, 28 Aug 2018 05:54:44 -0700 (PDT)
MIME-Version: 1.0
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 28 Aug 2018 12:54:08 +0000
Message-ID: <CAGnkfhzjeYU_jmhNkLEayL1FSq5rWkT7T+Nm1ky9QS-vWHUhyw@mail.gmail.com>
Subject: VirtIO console hangs
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With kernel 4.19.0-rc1 virtio_console hangs very often.
I can always trigger the bug by pasting some characters in the
terminal window, the console will stop receiving keypresses, but I can
still see output from the console.
Stangely, logging in the VM via SSH and sending lot of data to hvc0,
like 'dmesg >/dev/hvc0' will fix the issue until the next paste.

I did a git bisect and I've found that this is the offending commit,
reverting it fixes it.

Cheers,

commit ec97eaad1383ab2500fcf9a07ade6044fbcc67f5
Author: Nicholas Piggin <npiggin@gmail.com>
Date:   Tue May 1 00:55:54 2018 +1000

    tty: hvc: hvc_poll() break hv read loop

    Avoid looping with the spinlock held while there is read data
    being returned from the hv driver. Instead note if the entire
    size returned by tty_buffer_request_room was read, and request
    another read poll.

    This limits the critical section lengths, and provides more
    even service to other consoles in case there is a pathological
    condition.

    Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
-- 
Matteo Croce
per aspera ad upstream
