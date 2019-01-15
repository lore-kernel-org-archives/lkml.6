Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48EBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A808020659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPG1dyMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfAODDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:03:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35442 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfAODD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:03:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so577222pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 19:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=llQ/WO6aBYQmA3ECJADngHCNOifsSUIBhGz/Oonn9kU=;
        b=NPG1dyMGdN2G9PuP0sFJcCvLl/fNSHBt8Yv3RZ5awTSS69Xeyw2KB6qLjMuhi21240
         ONcOP1XAlfua6sDhbVngA9tc1TGYArrHcffOMZOpzGPa83yfSWHTueBbtcVkpDfc7hJs
         igg5qr67rlysZ4IcbCRkej2LWszw8pl59PjYr0fKMpPlTU67J6ECyirvQDVR5jHijSJE
         l7hID1Z+DGSyaXGjRJrLm1OXmq+FZ4rKIuTjqVJW74hc42t35HAIFI5RGsWVX25SLJ/o
         ZMd/uSW+9OXbqk2qCC+nPJtrRdyQwwkJkcF+hPvZ4nltOgVWnp01YYq09CaHuHBKNZ1e
         3pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=llQ/WO6aBYQmA3ECJADngHCNOifsSUIBhGz/Oonn9kU=;
        b=bZuSKxtcb45hq/MxGSiEKqCrosoazh3a1ZZH5/LA7W9hSuh4oN3sRXDUZe4/2LEaHX
         kZrhzYvcJ3m8rW3e3loZbYJk+clcyrGOryz9Ho7sNMHDRWUB/Onhw84TBMmxgEuE5s+S
         rk01HgBj42L6PP4mMWzsZ847m7y7MOToW1hGoAoiOpFoelKzgXh05DAANHSmJR68ml6F
         6bgImsgr2SN5wStY66f8gLtuX6SM/MqPZ9X8yL+cQwizKq3BTpikL6muOdeV+1kHl1dT
         tJq4p1TjeHGvS6moa8PBhZkta+tVJZ3OwBfFm3yZsksOzB89oGDi4fO1zOvaG7wehAhq
         oO4g==
X-Gm-Message-State: AJcUukcLmfeiMCZeJW5hnscoM6PJw2Q4E4Tw60CmjlrEEFn3UFnW53qs
        KhhUMZTV+QQlnApzHAG9Jj0=
X-Google-Smtp-Source: ALg8bN6MgsTGdj3H6oTy1cYkSoSCtA/DrrG69FwYVfVbCS65zdLylJt+oYxmVQ8m1bmdciSafRgHgA==
X-Received: by 2002:a63:c10f:: with SMTP id w15mr1676648pgf.199.1547521408732;
        Mon, 14 Jan 2019 19:03:28 -0800 (PST)
Received: from localhost ([175.223.15.225])
        by smtp.gmail.com with ESMTPSA id w88sm3895492pfk.11.2019.01.14.19.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 19:03:27 -0800 (PST)
Date:   Tue, 15 Jan 2019 12:03:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/3] sysrq: Warn about insufficient console_loglevel
Message-ID: <20190115030324.GA438@jagdpanzerIV>
References: <20190111162038.19771-1-pmladek@suse.com>
 <20190111162038.19771-4-pmladek@suse.com>
 <20190114080522.GA433@jagdpanzerIV>
 <20190114145944.5fhu6zfcjie5nmx6@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114145944.5fhu6zfcjie5nmx6@pathway.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/14/19 15:59), Petr Mladek wrote:
> Yes, it has false positives. On the other hand, I do not think
> that a better message is worth even more complicated code.
> 
> Either we find a better text, for example, use warning style:
> 
>     pr_warn("warning: messages are filtered by console loglevel (%d)%s\n"
> 
> or hint style:
> 
>     pr_info("hint: make sure to see all messages by increasing the
>     console logvel, ...

A box (laptop or desktop) can run X server and read logbuf via
/dev/kmsg or /proc/kmsg, IOW no suppress_message() filtering at
all yet we still will show "you lost some messages" warning. So
we are, sort of, never certain if any messages were filtered out,
in fact. Thus a hint style pr_info() is, probably, the best we
can do, but then I'm not totally sure if we want all that complexity
(exporting another printk() symbol, which somebody someday can
start (ab)using).

I'm not against this patch, so up to you guys.

	-ss
