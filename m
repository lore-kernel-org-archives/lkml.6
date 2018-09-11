Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38267C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDFC20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZwpqqKlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDFC20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeIKMSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:18:38 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41150 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeIKMSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:18:37 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so45246596oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 00:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3o4b3xlkT8qc40LF58gNWPpvPlnMI3lYGqx5rpDtc6s=;
        b=ZwpqqKlNpiSTDN1c8qAjsqE6uD+hV0R/ICpLZBPwknPBTjVG2a8VUMknIubefw1B4U
         n+6BNXvSJZkpvA6WuTTlbXWzUdffc5PTd3iO/DDc4Qxg+/LELOkUsOA8UevW7Y/hafBa
         UioN42SxBhtZ+zb0hEOsPob24dKnf9sXoTHJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3o4b3xlkT8qc40LF58gNWPpvPlnMI3lYGqx5rpDtc6s=;
        b=ajYJ/dpuTG9dx5GdmzYtkf0MOXaLT2ZQ01nmXKmkcsiHvkCevyVqbuQ5S4v0qg6EQK
         SvOaoAENs9+q/PXSz3FGEcWZIHKwbWfMgrX4tHUhbBfoHf637VXcZN+xpCiURvVVOAlx
         D0WRbJ6d/HhWtNfUaqgV8+KJW8N6EUjL5wsoc7mfOzfNmnhcOjOVXC+ne35IurISrM+6
         QmJm0H/qiOg3Fj2Rt9ZHfV2JN2g28qCBL2LUo+JUP1sOKYtNgjHoTIzI2tSuyI8ptqj7
         NWRNSRLWdCJN3WxZWOXTsrTPPizsEGXiVheYnczvmB0OXG5Z5orkxhcQKs8Vbvq371PQ
         59ZA==
X-Gm-Message-State: APzg51ArtFEDvmybR0XLmAKjreizA502LV+6RoavYhZpH4UMDoor9yAu
        /JfpeIps0KRrC4PQOWnSUmkaFW44jspQ7d8h/ybflA==
X-Google-Smtp-Source: ANB0VdabYd328xk90WUoZf+a6w1J2Wm3gLy3H2p3Lx3fo6kGB37rMfHoNgg9k4O0GLZ1QwSxQDKPNTlzLEjoFVrrJ64=
X-Received: by 2002:aca:aa8d:: with SMTP id t135-v6mr23477131oie.218.1536650441463;
 Tue, 11 Sep 2018 00:20:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:24a3:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 00:20:40
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <20180911063335.GA3315@infradead.org>
References: <000000000000cbb35d05757f7a3a@google.com> <20180910165317.GA3237@infradead.org>
 <CAJfpeguWqJgU8EfjvOtsBYRbbY2J7Ck2oNUcLNS8my9g2eNZfA@mail.gmail.com> <20180911063335.GA3315@infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Sep 2018 09:20:40 +0200
Message-ID: <CAJfpegtS8QMfhNMFV3i6GycqmXsLNYXvKjRm3wG79PFuF1VvuA@mail.gmail.com>
Subject: Re: possible deadlock in aio_poll
To:     Christoph Hellwig <hch@infradead.org>
Cc:     syzbot <syzbot+5b1df0420c523b45a953@syzkaller.appspotmail.com>,
        bcrl <bcrl@kvack.org>, linux-aio <linux-aio@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 8:33 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Sep 10, 2018 at 08:14:20PM +0200, Miklos Szeredi wrote:
>> Why do pollable waitqueues need to disable interrupts generally?
>
> Any waitqueue needs to disable interrupts for consistency.  We
> always use spin_lock_irqsave in __wake_up_common_lock() for example.

There are the _locked (non _irq) variants that do not.

And poll/select/etc don't impose non-interuptibility on wakeups
either.  So it looks like it's just aio that has weird spin lock
dependencies that forces this requirement on a waitq used in ->poll().

Thanks,
Miklos
