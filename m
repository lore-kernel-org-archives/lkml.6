Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F08C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 02:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C3720989
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 02:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cj8XRAwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C3720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeKKMiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 07:38:06 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42108 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeKKMiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 07:38:06 -0500
Received: by mail-qk1-f194.google.com with SMTP id m5so8180193qka.9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 18:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:from:to:cc:mime-version:content-transfer-encoding
         :subject:in-reply-to:references:date;
        bh=9HHMHnwKXnT0qGsqdgVYH+mwLoFMjcGDkreWLbfzpSU=;
        b=Cj8XRAwGTtq3Mjr7ADSzeaUSyNCp6jk78tGPIn2FAdfZb1LwGTnE6K79iFIG2CCeqx
         CQHEyjJQAbtp0tE5MPqcLBGHTLqpXRFQbF5rLv9Edz+413/2tnp9bXqqGbcMjLb20Ezb
         D6uZF/7fR1+lYOHJ2lXIi8xe1LgXJqNpAFALs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:mime-version
         :content-transfer-encoding:subject:in-reply-to:references:date;
        bh=9HHMHnwKXnT0qGsqdgVYH+mwLoFMjcGDkreWLbfzpSU=;
        b=huC2QP7stGgtiGAQzSuGd6gMImEw9VQhhyj/a/0bmcEksF3tx+xhGb/w5K2TXyVpU0
         ObjQ4U01ZsHb6NH79HLISuf791BRFNoCKLyy4mAhHTLu6KudpFbkg/jBcPjnz+f8jyiV
         fvUziLUNPQ1kHSZs8HhvfYb0yC4jDBxksnVnjha/IBoR74iQ1tjion7Ng/UZPvZ3g7pm
         Dd/zKFu9rVEoRUecvson4nQB5WW6nhPTX3HgMw20OciTTb2plT5uhcqj7VKifItG9lhN
         vvG68+SOIqfHGPJIi5P4EPkHCB+KUoDw5K/A1RyXndx3PMSr2OeYnyeJXR6otD6nXB4T
         K2hg==
X-Gm-Message-State: AGRZ1gIqfXnloN9VpCFkktEJJisMv3pwJq+vIdIDJZDsO2cKZ2FkqL8M
        3q17guwO8VXoGcgoYrnInnWmSA==
X-Google-Smtp-Source: AJdET5d9jbz9iLXOYvk6SMrAustBfjXwULTYlKB/BrzJT7CN+5t10viIwMzviEc6qJuS4D1bSovkjg==
X-Received: by 2002:ac8:1add:: with SMTP id h29mr14025890qtk.258.1541904656337;
        Sat, 10 Nov 2018 18:50:56 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id l20sm7480074qke.88.2018.11.10.18.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 18:50:55 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0898E21EDD;
        Sat, 10 Nov 2018 21:50:55 -0500 (EST)
Received: from web3 ([10.202.2.213])
  by compute1.internal (MEProxy); Sat, 10 Nov 2018 21:50:55 -0500
X-ME-Sender: <xms:DpnnW1uT_pLxmDglzqe6HFfnfooVDMMqqVHP4jFgDfubJs0HL6Rnug>
X-ME-Proxy: <xmx:DpnnW2r687vlWW-sn6mLOXBbbkN4wlPa-hxcS7KxyMgbFoOmgtnRZA>
    <xmx:DpnnWwgbUkiBzqKEk0AbM2CBcymKxhIFJONZEGSmady7tUvf-Kr8cA>
    <xmx:DpnnW0DDetyeZVlqOQHmLJZVpvSJbTqzrHMnkF782wv6fbBxVdyfwQ>
    <xmx:DpnnW-v0eHndQUGm2u-IH8sd2dhj-AxKrA7Gal5Wzr60_lfaHxMlkg>
    <xmx:DpnnW-57ePYWaG7an10XPDWOb_WrEbpsNoOtfyHDw7IG9fOWVQMQoQ>
    <xmx:D5nnW1rygcnWQWZKFoLE9-KW2eu5nX989_2t1jrIe1L1SL8OeIe6I8OkwCcDUuie>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id BB0F89E53B; Sat, 10 Nov 2018 21:50:54 -0500 (EST)
Message-Id: <1541904654.858965.1572725472.16816210@webmail.messagingengine.com>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     gorcunov@gmail.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-c0552f07
Subject: Re: [PATCH] proc: fix and merge proc-self-map-file tests
In-Reply-To: <20181110184957.GB18252@avx2>
References: <20181108111105.GC13195@uranus.lan>
 <20181109113036.21512-1-rafael.tinoco@linaro.org>
 <20181110174727.GA26417@avx2>
 <1541872563.3175498.1572453416.153B57C9@webmail.messagingengine.com>
 <20181110184957.GB18252@avx2>
Date:   Sun, 11 Nov 2018 00:50:54 -0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018, at 4:49 PM, Alexey Dobriyan wrote:
> On Sat, Nov 10, 2018 at 03:56:03PM -0200, Rafael David Tinoco wrote:
> > On Sat, Nov 10, 2018, at 3:47 PM, Alexey Dobriyan wrote:
> > > On Fri, Nov 09, 2018 at 09:30:36AM -0200, Rafael David Tinoco wrote:
> > > > Merge proc-self-map-files tests into one since this test should focus in
> > > > testing readlink in /proc/self/map_files/* only, and not trying to test
> > > > mapping virtual address 0.
> > > > 
> > > > Lowest virtual address for user space mapping in other architectures,
> > > > like arm, is *at least* *(PAGE_SIZE * 2) and NULL hint does not
> > > > guarantee that when MAP_FIXED flag, important to this test, is given.
> > > > This patch also fixes this issue in remaining test.
> > > 
> > > > -	p = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE, fd, 0);
> > > > +	p = mmap((void *) (2 * PAGE_SIZE), PAGE_SIZE, PROT_NONE,
> > > 
> > > I don't know ARM. Is this 2 page limitation a limitation of hardware or
> > > kernel's?
> > 
> > Kernel:
> > https://bugs.linaro.org/show_bug.cgi?id=3782#c7
> 
> Ahh. please test the path I've sent, I don't have arm install readily
> available.

I replied to your patch based on some of the discussion we had in this thread.

Thanks

Rafael
-
Rafael D. Tinoco
Linaro Kernel Validation Team
