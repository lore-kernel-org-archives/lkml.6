Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A52C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AB820854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AB820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbeIMTKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:10:50 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34447 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731005AbeIMTKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:10:49 -0400
Received: by mail-qt0-f193.google.com with SMTP id m13-v6so5452386qth.1;
        Thu, 13 Sep 2018 07:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tX/Jy+qAKmM1fo9np0H7nAsmcVAsa1M3UpTaz/yAEvA=;
        b=dlgcJWp9Gemabc5XMz/MSqs5Cb9+btAp984WqRmJ1iWLMXLfOcRo8Rx1GYlqtDF7zT
         MKd+Zc5Tv2NjmlK9DcUZJz594AnxLpirm22sB7/m0WS87hCckZXE6wK2kqfBNVS9zisf
         njDDM/tfMou7BlV/ris96eckbJMC2wkqxwpQzvNM9JAWknI433IpvWKK2fx49RROoJwO
         y8/Ub+kVFgew8U+0M+TwKxlM75oNElWWxf2w8tBTHjLb5+kKENeY5wXqHwJWz7zZIH0s
         uhCNA2qLL7Xeprm+pL5zlaa3miXr2vx4gLr4vT/eSZKEyrq7X4VXEM9DRNwy3ocUTq1O
         hffw==
X-Gm-Message-State: APzg51C3u3A1FBiQCYyZl3nTeTf3FIXERrM+4ageiygJ12GJ7f9GhXxZ
        cLjpNenfU26SDUhIE/KDuOycVwdnjbaFyzjk7Y9Rig==
X-Google-Smtp-Source: ANB0VdZDZeOzQJPaLEtAjIESaWZLQpWAbymsKEWfJlLXSdQPm1MYHu5GuH6LbIYGWuMZhKMl6lKEoAq5J7uFqKF8jy8=
X-Received: by 2002:aed:2b47:: with SMTP id p65-v6mr5258447qtd.132.1536847271503;
 Thu, 13 Sep 2018 07:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <1536842907-51732-1-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1536842907-51732-1-git-send-email-andrew.murray@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Sep 2018 16:00:54 +0200
Message-ID: <CAK8P3a27Qx=A9zNheYNF2oZaRUQm-4h_8nPUF2xTdL+kqFrV5g@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: io: Fix ioport_map() for !CONFIG_GENERIC_IOMAP
 && CONFIG_INDIRECT_PIO
To:     andrew.murray@arm.com
Cc:     Will Deacon <will.deacon@arm.com>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>,
        dann.frazier@canonical.com,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        jean-philippe.brucker@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 2:48 PM Andrew Murray <andrew.murray@arm.com> wrote:
>
> The !CONFIG_GENERIC_IOMAP version of ioport_map uses MMIO_UPPER_LIMIT to
> prevent users from making I/O accesses outside the expected I/O range -
> however it erroneously treats MMIO_UPPER_LIMIT as a mask which is
> contradictory to its other users.
>
> The introduction of CONFIG_INDIRECT_PIO, which subtracts an arbitrary
> amount from IO_SPACE_LIMIT to form MMIO_UPPER_LIMIT, results in ioport_map
> mangling the given port rather than capping it.
>
> We address this by aligning more closely with the CONFIG_GENERIC_IOMAP
> implementation of ioport_map by using the comparison operator and
> returning NULL where the port exceeds MMIO_UPPER_LIMIT. Though note that
> we preserve the existing behavior of masking with IO_SPACE_LIMIT such that
> we don't break existing buggy drivers that somehow rely on this masking.
>
> Fixes: 5745392e0c2b ("PCI: Apply the new generic I/O management on PCI IO hosts")
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Looks good to me,
Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Can you take this through the arm64 tree?
