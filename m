Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B8FC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F4D218D9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1JX5DiUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfBHJuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:50:16 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:30117 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfBHJuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:50:15 -0500
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x189oANd032767
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 18:50:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x189oANd032767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549619410;
        bh=5eEFdrqXpbL+j89kaxfwCjisLzIwQBKngAOVuu22ayM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1JX5DiUBhSv4cRk3sL8bGmWH2syPf/rQkg56+o+PpQYAwNFqRkP8emVhysNzMf5bS
         7spCXd64XerOu5MSC2I+/71qRCDcAbEq0LEkxYemYjgPNdNNz4xKNhjKhZ5YRu9vkG
         98jfpN2lGWjKlX16Pf5/CvOmjIuY+tWGmXFpwcmuIppGqNGoYn0/1/UB6VSnXoZLU1
         J9TbnclSkDQARA4cKIyM0fZ3CSWrWTcmMAG0fQe0nVhL1NpFzLtp7rk/7gwSIET8ag
         xvJsNndN3Dbu1VwQ+XTfEF7hj4PQfEs7DnfzVkreQKId9bfm/L41Qp91jifQoUDz9/
         pRUEY8NrrKOsw==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id e16so910431uam.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 01:50:10 -0800 (PST)
X-Gm-Message-State: AHQUAubUJWHgRCDPVUzUpSg0wibVBEk9sMORWBwkdvfinYrvhu5zdQC8
        RZzUGlf58ClnzWZATmTg4Khimkrn7VswSeNaM/M=
X-Google-Smtp-Source: AHgI3IYnNwm3VK/r4QAiJW2ijwLintg0lvF+3SzzV46BnEltgsgYmmShH51unR306PM0+S3Rw0QA1eYFUcaB1uRbKOU=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr7961605uap.6.1549619409590;
 Fri, 08 Feb 2019 01:50:09 -0800 (PST)
MIME-Version: 1.0
References: <1549613335-30319-1-git-send-email-yamada.masahiro@socionext.com> <1549613335-30319-5-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1549613335-30319-5-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 8 Feb 2019 18:49:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNASb7iDMf28TGtn=-Gz40K=PgdPrwG3sOa_3oL-PLhtBfw@mail.gmail.com>
Message-ID: <CAK7LNASb7iDMf28TGtn=-Gz40K=PgdPrwG3sOa_3oL-PLhtBfw@mail.gmail.com>
Subject: Re: [PATCH 04/11] mtd: rawnand: denali: switch over to ->exec_op()
 from legacy hooks
To:     linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 5:09 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Implement ->exec_op().
>
> Remove the deprecated select_chip(), read_byte(), write_byte(),
> cmd_ctrl(), and waitfunc().

I also deleted read_buf(), write_buf().

Will fix the log.




-- 
Best Regards
Masahiro Yamada
