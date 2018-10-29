Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1529CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9C32087A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmNOesas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9C32087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeJ2Vwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:52:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46255 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeJ2Vwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:52:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id v18-v6so7184165edq.13;
        Mon, 29 Oct 2018 06:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HhOss3t/D5OWI5zhM8Hag1e35zlkzx3kXjNsw5TjDaM=;
        b=jmNOesasNQd3E6j+Ym89Ms9Sg0qpFN/L/QQ2Pp1qX2ClJ66cZvfdHqVqjypU93kUtI
         IrZESOQoKUD6DqWWe+EMCdSEFA49rlmRK6NAkIxePFk9OpIGkAOCWUZ+1Q1Rp7k7ueEY
         ctw4OrMAIPCQblkWgTGQvGKq0uRWfGbP4iEYVJ7xWH7RRNUn6SVxCYy5dDIbvMT6vpFS
         qPewHdn5Pk/7hQ3X/Htb/BrIxphSK3t134MjGjU9umqQLlm6N4hIHBevGDSLYGKjOlov
         uCjnE/Wg+fRTAFu+m8shkCg7uNQ60JU7+Sr7Z0/mhZyDmKaZx37Tyfoe5vEwYbgGp6dY
         uSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HhOss3t/D5OWI5zhM8Hag1e35zlkzx3kXjNsw5TjDaM=;
        b=QbJVQMDgGjOPIqCAtWe9EjLckVKcoP8fdBDP2etJ7xvsxRgyjG7Y4+N/K4bCphUp5z
         mnsmNNvW9KasMSAzoFQCc7lmA8GADtFmSLfH/R1Q9NNK4la1YxuhZDQQhTxM3VfnTGtu
         ZyGAryyrfSnWdoFPifq/r28S+oGuiHHQfXoFNnyaJma/BX+dGdmX43YTb0hsBT/iqEVT
         7NbtR86lIvEwOwJI53KC6iGG69SjBM110fD6MUbS1saHz74di1LGJSahhJqcTKVt7/SA
         PDFx4nakVsMdvF2EGOaivGO4iVWZVCKbR4BF2ksGu5Su7J+m+0BacbgzkL8HE0XHFUjj
         4ZQQ==
X-Gm-Message-State: AGRZ1gJfbawmhWiclh1IQwRY8AsGt6g+1EZNK76LV4MyH5pIINFxRqUA
        7tgYa+d1jw8kc2z/nDSMeyrAGRs2
X-Google-Smtp-Source: AJdET5cNU1GlquAV5tuhc5Aabr86M7LqfT2mIgirTpni9U7btTGx1ub9+X+GQADVb/xnrGrsZFv3Tg==
X-Received: by 2002:a17:906:6308:: with SMTP id p8-v6mr4346358ejk.100.1540818255864;
        Mon, 29 Oct 2018 06:04:15 -0700 (PDT)
Received: from dell.be.48ers.dk (d528f5fe4.static.telenet.be. [82.143.95.228])
        by smtp.gmail.com with ESMTPSA id a4-v6sm5829154edt.82.2018.10.29.06.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 06:04:14 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1gH7DJ-0004Uf-Og; Mon, 29 Oct 2018 14:04:13 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Peter Korsgaard <jacmet@sunsite.dk>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] i2c:ocores: add polling interface
References: <20180625161303.7991-1-federico.vaga@cern.ch>
        <4222986.LvGMQbjSbS@pcbe13614> <87woq438li.fsf@dell.be.48ers.dk>
        <5352289.A0jT2G1FDH@pcbe13614>
Date:   Mon, 29 Oct 2018 14:04:13 +0100
In-Reply-To: <5352289.A0jT2G1FDH@pcbe13614> (Federico Vaga's message of "Mon,
        29 Oct 2018 09:50:15 +0100")
Message-ID: <87muqwzyya.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Federico" == Federico Vaga <federico.vaga@cern.ch> writes:

Hi,

 >> >> Where does this 10 come from?
 >> > 
 >> > It's true, it's just a random number. It can be zero as well, and we ask
 >> > the system to just sleep for that amount of time.
 >> > 
 >> > (1) usleep_range(sleep_min, sleep_min);
 >> 
 >> Or just usleep(sleep_min);

 > This does not exist as far as I know; the alternative is an active wait with 
 > udelay. But then, it is not that different from just start polling TIP or BUSY 
 > flags.

Ahh yes.

 > I think that something like this could be better

 > (2) usleep_range(sleep_min, sleep_min * XXX);

 > But.
 > Since it is better to make this patch ready for xfer_irqless, then I will 
 > definitively go for udelay(). The reason is that, xfer_irqless may run in 
 > atomic context where we can't sleep at all.

Great! BTW I noticed that your sleep_min calculation looked odd:

int sleep_min = (8/i2c->bus_clock_khz) * 1000; /* us for 8bits

bus_clock_khz almost certainly will be bigger than 8 (E.G. likely
100KHz), so the above set sleep_min to 0. Please move the * 1000 before
the division.

-- 
Bye, Peter Korsgaard
