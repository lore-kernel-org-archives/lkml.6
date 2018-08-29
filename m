Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA00C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCA920850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Go/8MVQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCA920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeH2S1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:27:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42045 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeH2S1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:27:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id l5so1448569edw.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pzgaPuO9tgy2qtNRy5vNoP9Ex/yw+binTUp3baA5rQk=;
        b=Go/8MVQe9TF+MxHRtTkHDH1umFqKVpM9mA4y0nExDVow2oVwqVX9vvXBLiluLy8jQK
         IynmIhtlRTunrcIkKszv7yFCU5g5S7Y2oxIuZN2rqmgDxeZHnbRqxaqvvpNxIJccZtiO
         511EQ+NCnEDbgfmtuQ1347UNgnC+CmsrsAC4+V5ACA350gMLDnWDiRZ8vhceLqEUWBAL
         dGn6hDpq3cv6u0KTAfHm0k5J79KvoNeiY7nO37ECAHO5X7Y8uH69SiRed+oZs+IGl6jC
         9jJpdummlsKXBs/aKPiItoxLrUH/nwgZSF3+TH4AJ5mA0Mk/aZxSPlHC/2sm41aEKHTA
         uJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pzgaPuO9tgy2qtNRy5vNoP9Ex/yw+binTUp3baA5rQk=;
        b=HQsfhLNMvSk1BcetAe8zO38gINdnXFpbJzeEqSfqgG5Tbmf3E9mU7OP/xE+uqvx7iX
         dadW/SPiuNYqCi9CXtlD1XCAXGqXFbozXTr+X39sLL8E5nWyLXhdG8kWMCJ2FngVvUpT
         44ZBYJ9xDFMu8cXkelF6j17AVWhcQ97h1yhVIy0WgfA/Yul+uoGQn21jPaEoljak0W3c
         I8FdkOOZxQ287AXnAoiAjS/spEJQWPtPxG3MjS1jW/YQyZQDmniyyofC3zX4xGSHUzwl
         0n+yzG9TwkcQJ0B+H8yOToKgLhHTrz6CXN7ljryd++sGx5RYOlM5d8ct/AIuqB6QHyRm
         l2GA==
X-Gm-Message-State: APzg51AbIgkFkL2/quVM4GEm1CmFQuu8L3T41t962Ui66U+ik1RDtNQi
        4kxKamhzaH10/ra/y2wTHaK/TA==
X-Google-Smtp-Source: ANB0Vdb7VvmLiLfrQFiJxuErSnQUw4eY+Mgg7vCiy9Q3OmlYeNJfY7/HyV6Hd8U22Erbl5bGoZWZlg==
X-Received: by 2002:a50:88a4:: with SMTP id d33-v6mr8040933edd.239.1535553023040;
        Wed, 29 Aug 2018 07:30:23 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z30-v6sm2127391edb.4.2018.08.29.07.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 07:30:22 -0700 (PDT)
Message-ID: <1535553021.23560.50.camel@arista.com>
Subject: Re: [PATCH 2/4] tty: Hold tty_ldisc_lock() during tty_reopen()
From:   Dmitry Safonov <dima@arista.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Wed, 29 Aug 2018 15:30:21 +0100
In-Reply-To: <20180829043430.GB13049@jagdpanzerIV>
References: <20180829022353.23568-1-dima@arista.com>
         <20180829022353.23568-3-dima@arista.com>
         <20180829043430.GB13049@jagdpanzerIV>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Wed, 2018-08-29 at 13:34 +0900, Sergey Senozhatsky wrote:
> Hi,
> 
> Cc-ing Benjamin on this.

Thanks!

> On (08/29/18 03:23), Dmitry Safonov wrote:
> > BUG: unable to handle kernel paging request at 0000000000002260
> > IP: [..] n_tty_receive_buf_common+0x5f/0x86d
> > Workqueue: events_unbound flush_to_ldisc
> > Call Trace:
> >  [..] n_tty_receive_buf2
> >  [..] tty_ldisc_receive_buf
> >  [..] flush_to_ldisc
> >  [..] process_one_work
> >  [..] worker_thread
> >  [..] kthread
> >  [..] ret_from_fork
> 
> Seems that you are not the first one to hit this NULL deref.
> 
> > I think, tty_ldisc_reinit() should be called with ldisc_sem hold
> > for
> > writing, which will protect any reader against line discipline
> > changes.
> 
> Per https://lore.kernel.org/patchwork/patch/777220/
> 
> : Note that we noticed one path that called reinit without the ldisc
> lock
> : held for writing, we added that, but it didn't fix the problem.

Probably, it's worth to know what exactly has he tried and what was the
backtrace he got in the result..
Hopefully, we'll hear more.

It might be also worth to review tty_ldisc_deinit(), I thought it's
safe to destroy ldisc there under tty lock during tty release, but may
be that is another non-safe place.

-- 
Thanks again,
             Dmitry
