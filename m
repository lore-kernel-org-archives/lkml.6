Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A1BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2A6251B1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eEoiXllR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2A6251B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeGBTeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:34:14 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37928 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbeGBTeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:34:12 -0400
Received: by mail-io0-f196.google.com with SMTP id v26-v6so3469050iog.5;
        Mon, 02 Jul 2018 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2hDmcghnGHm0FGCNAaGgIwqIJLG8wNI1QNpl5f7fi8=;
        b=eEoiXllRb9TQAkrZoZSuhmP6/P8EEtpJomK9lWStW3NbDmCDvqeSBBRxYspG5kQd/j
         vmm/AoYrRdk8UAv4T4cZniOojMjV7VNax28zQwLTsr3i+anSlx40J59BuKxwwwJJ+fLe
         E94hqK2kf6H6yXXUW/4SJ7y6sUfRqjuObYa1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2hDmcghnGHm0FGCNAaGgIwqIJLG8wNI1QNpl5f7fi8=;
        b=K52d1vZeZGLIqP3yKPwX/cuOE4uNJNQ6rffn4FJZ+Jw3sTOHNZBCvQ9JgW+hnG0IYr
         LWM+Zp+wMvc//BNsDhw4sCFxj/icpoHThsCrAM9fYLuWaLe6yxkKs1A/cDhvbnoenw3A
         SyhIwhyFvwQRwWXi/kFEHNaehPUocOJ+ncNB7k840xYNqGE30CKg2ttcorUYrM0/Ey4h
         3U8X1D+T23z+Oz6noWTal9Jth/7FpmmSZAFjLMBNdMSK6xLdYIT8K/uQKp6+jrMrm0U9
         pn8+9bNEXfdwdh58yLusx3gXE12erCIzSz+zX43e6NvIZZEqub8V7G/CkAZ0JRpJFMYl
         ceHQ==
X-Gm-Message-State: APt69E2kD5EJOMYFX/UNvNxc+Vx7LEBm89jVPPG6ePuS3IcxrXF+kJho
        bEU5IbbqhFMO6yc0RyXY/0xtPf/l1TCvGluMR2w=
X-Google-Smtp-Source: AAOMgpePgk8a4CdnkbvV3WpPjfvfHOMK5PCEcK5O3pwlw13O8i69gq6MX+nFYmMLRVsyrXz1034KHBDnCVFuzqZn6/E=
X-Received: by 2002:a6b:980e:: with SMTP id a14-v6mr17849099ioe.238.1530560051731;
 Mon, 02 Jul 2018 12:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
In-Reply-To: <1530510723-24814-1-git-send-email-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 12:34:00 -0700
Message-ID: <CA+55aFyH6dHw-7R3364dn32J4p7kxT=TqmnuozCn9_Bz-MHhxQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] fs/dcache: Track & limit # of negative dentries
To:     Waiman Long <longman@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 10:52 PM Waiman Long <longman@redhat.com> wrote:
>
> A rogue application can potentially create a large number of negative
> dentries in the system consuming most of the memory available if it
> is not under the direct control of a memory controller that enforce
> kernel memory limit.

I certainly don't mind the patch series, but I would like it to be
accompanied with some actual example numbers, just to make it all a
bit more concrete.

Maybe even performance numbers showing "look, I've filled the dentry
lists with nasty negative dentries, now it's all slower because we
walk those less interesting entries".

              Linus
