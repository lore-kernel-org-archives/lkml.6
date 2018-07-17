Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8933AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B1520657
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="re3oNLCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B1520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbeGQPCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:02:22 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:36243 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbeGQPCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:02:22 -0400
Received: by mail-lj1-f177.google.com with SMTP id u7-v6so1184836lji.3;
        Tue, 17 Jul 2018 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rHlT8llOxp0mS21QB2Nr8GxwzV53CN5PpxqzVizfUi8=;
        b=re3oNLCgJbaHhXrPtGTIyXimEduJTaCkfPyBeSjJ9gh5fqIWxkGu2fzC9U2fUpf/7c
         IHzeolekHTJAysYjesqqFYOLoVqnhNYc4cY4a3DkqhD7+bO8eixHB7Iua89Ja+eIdiDX
         FPNsljvfN+iYPenRM5YPVrt5Af1+Q1MisB499nQ0rLqHrwT0eKC62eToQnbNKzSofOe2
         o5UOpqv3zfNEJ1rqyvg1GoPMgUg6Io6uBjTdvzV6tsGgVeGYKVM7u/QXeFdo7A+B57hZ
         j5ViHc0FHy3DEsp1pBEhtHb7k8VwJbtR4V1y63vpdEkegw6mCwlJF+xNnhceWJCY3kPY
         te1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rHlT8llOxp0mS21QB2Nr8GxwzV53CN5PpxqzVizfUi8=;
        b=YDBvTYnv8p/xWYP2OKzEfSalnCiV0yIFan5/BD3FTa0pLmKlXWaRFnbtAJC07Oi85z
         Of7jMfqZNh/QlFDo6CEmGKmXCjxEPv7kvWcw48qc6HjArZpixrlwBPyOmNtgOBeGMWg1
         kRHxnPGQmmqrtlZNufswWHv0yQASslPm9xOSPCAPiNUE6Zs5nUTJe9GwAtxkozhZ38Ka
         tst6HQNdw6KhglvlWjjHzYtpVzprifaIQaFhDW5LYUjnTFAqTf/JBpYVgeBf8FFmOePx
         HE0Vl4h6o0NyrdkNV4wwWJJ06PWqnx/kkBTdhNzboyxVcd+wAnI3EWJ68MICyMWyYkWV
         4KdA==
X-Gm-Message-State: AOUpUlFQdjaia02gChkdj9s8HG+BciU/bhuJlacCg3shrAjyHyrFXzA/
        DUgpQqYgcO7DyhANAWtEoT0=
X-Google-Smtp-Source: AAOMgpd0FQs6cfcksfGjKDqzfWCdNJ1jqz41cYT6R9rEM55AQHR25UGTTQ9Mr9ObPEysS2A2OU7D3Q==
X-Received: by 2002:a2e:9e17:: with SMTP id e23-v6mr1653172ljk.14.1531837764866;
        Tue, 17 Jul 2018 07:29:24 -0700 (PDT)
Received: from pi.lan (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id f28-v6sm194089lje.61.2018.07.17.07.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 07:29:23 -0700 (PDT)
X-Google-Original-Sender: <johan@kernel.org>
Received: from johan by pi.lan with local (Exim 4.90_1)
        (envelope-from <johan@pi.lan>)
        id 1ffQxm-00019c-R2; Tue, 17 Jul 2018 16:28:26 +0200
Date:   Tue, 17 Jul 2018 16:28:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     m13297920107 <m13297920107@163.com>
Cc:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moviesong@aten-itlab.cn" <moviesong@aten-itlab.cn>,
        "billli@aten-itlab.cn" <billli@aten-itlab.cn>
Subject: Re: =?utf-8?B?5p2l6IeqbTEzMjk3OTIwMTA355qE?= =?utf-8?B?6YKu5Lu2?=
Message-ID: <20180717142826.GA3464@localhost>
References: <9d354b9.f72d.164a87468d7.Coremail.m13297920107@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d354b9.f72d.164a87468d7.Coremail.m13297920107@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 09:35:58PM +0800, m13297920107 wrote:
> From dcd3f0aafbd3ac40c0bceb8e9d5941a29a1a5edd Mon Sep 17 00:00:00 2001
> From: Movie Song <MovieSong@aten-itlab.cn>
> Date: Tue, 17 Jul 2018 21:13:52 +0800
> Subject: [PATCH] This add a new device for ATEN
> Signed-off-by:MovieSong<MovieSong@aten-itlab.cn>

You're getting closer, but the patch is still whitespace damaged.

Again, try sending the patch to yourself first and make sure you can
apply it with git-am. You can also run checkpatch on the result to catch
some common mistakes.

Please also use a more descriptive commit summary (Subject) by using the
common prefix, for example:

	USB: serial: pl2303: add new device id for ATEN
	
and add a short commit message (which is currently empty).

The link I sent you earlier will show you an example of what the
end-result may look like.

Thanks,
Johan
