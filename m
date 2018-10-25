Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11A3C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6422082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="kX6r4G4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6422082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeJYPPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:15:00 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.158]:32850 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeJYPPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:15:00 -0400
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <x220.localdomain>
Received: from x220.localdomain (unknown [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Thu, 25 Oct 2018 08:43:36 +0200 (CEST)
Date:   Thu, 25 Oct 2018 08:43:56 +0200
From:   Slawomir Stepien <sst@poczta.fm>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface
Message-ID: <20181025064356.GA18633@x220.localdomain>
References: <20181024145051.GA18490@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181024145051.GA18490@nishad>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1540449818;
        bh=239/D5Q8v37uT5nYCxcdYXlj5HBO69ulOP7dpERi6H4=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Date:From:To:Cc:
         Subject:Message-ID:References:MIME-Version:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         User-Agent:X-Interia-Antivirus;
        b=kX6r4G4efJbEBinxkgAFjEyjzEMpO27MshRF223V4XX/Dw4PF7qQlofVfZiz3CeyC
         iqRm6dsoRUSnoxZDv4L/SsN6XnI+Yt6c3H9USpwnGlke6eTuvPFPYu2e36/i8okvRp
         565hsu0+AEgOpY3YngdAiCQXmBYvD961Oy4yZlBA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On paź 24, 2018 20:20, Nishad Kamdar wrote:
> Use the gpiod interface instead of the deprecated old non-descriptor
> interface.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
> Changes in v4:
>  - Add spaces after { and before } in gpios[]
>    initialization.
>  - Check the correct pointer for error.
>  - Align the dev_err msg to existing format in the code.
> Changes in v3:
>  - Use a pointer to pointer for gpio_desc in
>    struct ad2s1210_gpio as it will be used to
>    modify a pointer.
>  - Use dot notation to initialize the structure.
>  - Use a pointer variable to avoid writing gpios[i].
> Changes in v2:
>  - Use the spi_device struct embedded in st instead
>    of passing it as an argument to ad2s1210_setup_gpios().
>  - Use an array of structs to reduce redundant code in
>    in ad2s1210_setup_gpios().
>  - Remove ad2s1210_free_gpios() as devm API is being used.
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 92 ++++++++++++++-----------
>  drivers/staging/iio/resolver/ad2s1210.h |  3 -
>  2 files changed, 50 insertions(+), 45 deletions(-)

Looks good to me.

Reviewed-by: Slawomir Stepien <sst@poczta.fm>

-- 
Slawomir Stepien
