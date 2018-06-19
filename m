Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B449C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006AA2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmcsiKAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006AA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965880AbeFSI7n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:59:43 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40677 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965732AbeFSI7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:59:38 -0400
Received: by mail-pl0-f68.google.com with SMTP id t12-v6so10587455plo.7;
        Tue, 19 Jun 2018 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qdze1EzkHiIKBaifwDVXCIhkI/2AXUDypdrUSi/bdf4=;
        b=GmcsiKAOdQbEMM7tClX/O0wSEHFwtLmOGyQRfLky4cCp4nBBkewC93kmZ1eh0FRYdZ
         jEXM76MMmPFrnVNWxbMgIySLjpjmtz/fMnYW59DCQ3qaQCx2vlHQF1vZG9lkYk/vo0w2
         nOvG8Fhx96DOtpunax4oiGwN3wpEpdkk5p0Ik+lA5VB3Qkobj4qcTdr3hIlA3sRVzz5j
         tiJmchiJsbYJqoagtwijZDB67HZcBJuUICVuAlTxVe/KViTY3/02ezx9JjfmB/hEc06z
         atK3kiOT+pHEtZqr2434r7rulMrHp+yRe9wMwwB5YubNzEtNz183XnZjMTD1jJ9IDGzi
         i1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qdze1EzkHiIKBaifwDVXCIhkI/2AXUDypdrUSi/bdf4=;
        b=dSi/HpdZv3Byrc9hjzQxjjkcP+sVCUBttTrJi90YjIJHPuaYUYAxXaIEHRncK6ukuS
         5oMs7M19VjSlWEw81/vPZ1QJBK+B6D2XKv/r1Z5Hv8JYrNGvrYW6DY1OtXYAlNZ0jl7h
         J2wKZqjteMX7Qar2VgGvd3h3q7RAcBz/E9z3A1nT5zXK8KUzYpwTPt+nn4yHiCgCuGrS
         dPRVTQUXTWTXEFGiXQBoelwjfmfMMYAm7ZN6np/Y1U06hMSH6cSZJuvZCalv+PKbg9Cx
         CZYzNXOQ2wxNMBFK146vq/PjQrhy3HKDfT+VJ3qNQ+BTARc4en+ZYmj77PjDdZ8evnDd
         5bbw==
X-Gm-Message-State: APt69E1WRpw35aGGbruHxjeW95WXx7cO71+2zhv5eQ5vBZJzAqqv6GMa
        cDeqUqwLOs5G68RVyfUk9vAmaiPC
X-Google-Smtp-Source: ADUXVKL7SjpifJ0hlPdKhtpkLmXBtaCdLIzcsCkE0FOWh6iS71CeROIa1kTh4AmHjcEWs8zlQrxjyA==
X-Received: by 2002:a17:902:9b92:: with SMTP id y18-v6mr17569942plp.57.1529398778390;
        Tue, 19 Jun 2018 01:59:38 -0700 (PDT)
Received: from localhost ([175.223.26.106])
        by smtp.gmail.com with ESMTPSA id z19-v6sm20076991pgv.12.2018.06.19.01.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 01:59:37 -0700 (PDT)
Date:   Tue, 19 Jun 2018 17:59:33 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Message-ID: <20180619085933.GA2631@jagdpanzerIV>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop>
 <20180619005308.GA405@jagdpanzerIV>
 <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/19/18 10:30), Petr Mladek wrote:
> It is re-entrant via printk(). I mean that any printk() called inside
> the locked sections might cause recursion if the same lock is needed
> also by con->write() callbacks.

Perhaps Alan meant that we cannot return back to tty once we passed
the control from tty to printk -> uart serial console. So tty is
probably (but I didn't check) not re-entrant, but uart definitely is
re-entrant: IRQ -> uart console -> tty -> printk -> uart console.

The patch set attempts to address several issues, and re-entrant uart
is just one of them.

[..]
> This patchset forces safe context around TTY and UART locks.

Right.

> In fact, the deferred context would be enough to prevent
> all the mentioned deadlocks.

Agree.
But we can leave it as a printk_safe implementation detail and
change it later, outside of this patch, to avoid further confusion.

> IMHO, the only question is if people might get familiar with
> yet another spin_lock API.

Right. That's why I thought about renaming uart_port and tty_port
->lock to ->____lock. So the naming will suggest [hopefully] that
those locks are not meant to be used directly [anymore] and instead
people should use uart_port_lock/tty_port_lock API.

	-ss
