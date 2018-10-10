Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9FCC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCC32087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBIRfofY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCC32087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJJVZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:25:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46114 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeJJVZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:25:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id d8-v6so5705623qtk.13;
        Wed, 10 Oct 2018 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EcL3PeNbwozYsngXLbTdypvNvxCzbJbfqydNNz1fz1o=;
        b=LBIRfofYGdBmWGBqIZV1IdsqlJWhsyy9N7zai8AmKISg7QUM8NqZDYM4hGEOvw8e80
         x+YFo50JnvCzv3AdTvrqDjchqmAQQXyzeRcZqxi4endlx5JYcNJ3TuzhEVOAjIQ9U29T
         4NzYFkUXQw3o+i2XB1aG6YvlEB7E3th2ZEMUzIOfFK+RhMLyXzpthgcsgwKea39Hf4rA
         0E5HYu0rcXbDtFR7fz8aH4A+zy6CxoUurUtXXw8+bXWZbJIdczzzhFTTCoou6GctfrRM
         do2o8A6IImS6UW2DWPJq5WIf8/ytyESLF/yi0Fvz6Mi5Qc/o3ImPf8x5bT9viEwZqd8W
         7rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EcL3PeNbwozYsngXLbTdypvNvxCzbJbfqydNNz1fz1o=;
        b=LZGPu3NZXLtszHFInQFGGImixtWKBSp9T35HmS6V6eyjgJCpa32GXjysJpqj3Tois0
         EmtSFYcDPXqQc+ST2BsEEUU961tOKlmIkYpxzbMnV3TVqyqb+PrptYvofx2JyL0nY5bs
         lqfptA+i20d90mDIMPnWoqv34JTrb/d8uQu+KUV29hnRSuj7M1B+OAC5Fk8gL6soF1hx
         6PmN8xx4br67LOWeY3xKPIeADtGlSJc7DhyjOMCUoz6VxMjYjLIdcsNhZUJl8iL2PAmY
         4sijfCFPaab9nLcLSS/gLEdu2ekNVmyMz7ydpLdPWNA8o69td9KoM5ELq36z6Blh2RmY
         5efQ==
X-Gm-Message-State: ABuFfogDB41wjmzKW4EshE6k5lBmu9E3Y9NHvVHfLK0lJ9fHT7gC9r08
        P7AG/54gWki5Xp1u82eH0TZaa0c3MrpTMQgZtEY=
X-Google-Smtp-Source: ACcGV638NV58Bj98yXJNllS56nZ/M+RfzgkLGU5HR57ntx4PS4QsmDlg7NPOGrRohYAOd8WAlgzqDbYi9Rm55TysJ1I=
X-Received: by 2002:ac8:1d11:: with SMTP id d17-v6mr4108895qtl.343.1539180194973;
 Wed, 10 Oct 2018 07:03:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:524f:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 07:03:13
 -0700 (PDT)
In-Reply-To: <20181010134317.8466-4-geert+renesas@glider.be>
References: <20181010134036.8296-1-geert+renesas@glider.be>
 <20181010134317.8466-1-geert+renesas@glider.be> <20181010134317.8466-4-geert+renesas@glider.be>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Oct 2018 16:03:13 +0200
X-Google-Sender-Auth: 5Gp1MWAkjb13u1hV3EDPz7IEWPQ
Message-ID: <CAK8P3a1=rWcDaO9eu56us09=yy8CfakgFSGtLW1xfRyVhUT69g@mail.gmail.com>
Subject: Re: [PATCH 3/3] eeprom: at25: Split writes in two SPI transfers to
 optimize DMA
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> Currently EEPROM writes are implemented using a single SPI transfer,
> which contains all of command, address, and payload data bytes.
> As some SPI controllers impose limitations on transfers with respect to
> the use of DMA, they may have to fall back to PIO. E.g. DMA may require
> the transfer length to be a multiple of 4 bytes.
>
> Optimize writes for DMA by splitting writes in two SPI transfers:
>   - The first transfer contains command and address bytes,
>   - The second transfer contains the actual payload data, now stored at
>     the start of the (kmalloc() aligned) buffer, to improve payload
>     alignment.
>
> E.g. for a 25LC040 EEPROM with a page size 16 bytes, a 16-byte write
> aligned to the page size was transferred using an 18-byte write.
> After this change, the write is split in a 2-byte and an aligned 16-byte
> write.
>
> Note that EEPROM reads already use a similar scheme, due to the
> different data directions for command and address bytes versus payload
> data.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Arnd Bergmann <arnd@arndb.de>
