Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C37C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32EA20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SOlYUEeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32EA20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeJCNku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:40:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41939 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJCNku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:40:50 -0400
Received: by mail-io1-f68.google.com with SMTP id q4-v6so4154488iob.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 23:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cQqfP4i7piZTeCWQHmtcxAIwoJQv/GM/NyXXmV5wpeA=;
        b=SOlYUEeR3OSZJSl2LcUsT9iOR8oZUhZGM2MJm2hYupd4MGykUIUzuG2cwWxY2FzDRa
         LzzitwIxGr6oSQOaPMBEiLBc02u18yW/8JpLI3T2j8wmorWn2RUEEU9CCW1O8IUQhJKB
         /418uDCLrHLzyjn1CPmRXL6dZPNr9VYa0wsm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cQqfP4i7piZTeCWQHmtcxAIwoJQv/GM/NyXXmV5wpeA=;
        b=BFXTKyqLKY+ihLqoN8nGQaY1xCkoDaDxOUgaU7IQyuE/+qG5QNtNcQDkkqHIwJo4Cn
         1ioi31MlLkfPKOBqMulCdPGLyfsDff45Qm8TlSJN0gQuzbW/iHORwkK5AVAPyXTMDtSm
         QEP9kfBDl9p8fCpo557kXpM9Z+yXWFgtSybz5DuCUDvvsNeUpmgL/+vR5BNFo6De2npt
         lVizQ7yf27qZKBA15sl+nhtiGTUp/yPkRD8JOYwYncdVdrtmvK/oW3KzlSXRMd8yZKZk
         RSFcr7BOULCH/bMcLsXfPS6VLuXDxfJQzROgFABNIveUvCA7nAwCSdKSs8qQwEHhV5mQ
         s8bw==
X-Gm-Message-State: ABuFfohigH3OjVjCv9gOL2yq613rZINfuw+wRLC6isB58niE6joylZsL
        k2CN8bjSIFy6Et2bnItVZXLoaZR6XRC8GYC7/+401w==
X-Google-Smtp-Source: ACcGV606iXC5GeF1slrbWmknBNU4fJJm9T3tamhQr9YyXyrlDjqbPD5BY/Hh22KWZoBaxzvz1EdKyt9y1QsXifa9Wrs=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr32035ioa.277.1538549628541;
 Tue, 02 Oct 2018 23:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk> <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
In-Reply-To: <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Oct 2018 08:53:37 +0200
Message-ID: <CACRpkdaeYU+Crr75T49WftyOHqCrsyBLBPDBBsJF-RCjmAQEdw@mail.gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
To:     Paolo Valente <paolo.valente@linaro.org>,
        Johannes Thumshirn <jthumshirn@suse.de>, aherrmann@suse.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, mgorman@suse.com,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 8:29 AM Paolo Valente <paolo.valente@linaro.org> wrote:

> So, I do understand your need for conservativeness, but, after so much
> evidence on single-queue devices, and so many years! :), what's the
> point in keeping Linux worse for virtually everybody, by default?

I understand if we need to ease things in as well, I don't intend this
change for the current merge window or anything, since v4.19
will notably have this patch:

commit d5038a13eca72fb216c07eb717169092e92284f1
Author: Johannes Thumshirn <jthumshirn@suse.de>
Date:   Wed Jul 4 10:53:56 2018 +0200

    scsi: core: switch to scsi-mq by default

    It has been more than one year since we tried to change the default from
    legacy to multi queue in SCSI with commit c279bd9e406 ("scsi: default to
    scsi-mq"). But due to issues with suspend/resume and performance problems
    it had been reverted again with commit cbe7dfa26eee ("Revert "scsi: default
    to scsi-mq"").

    In the meantime there have been a substantial amount of performance
    improvements and suspend/resume got fixed as well, thus we can re-enable
    scsi-mq without a significant performance penalty.

    Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
    Reviewed-by: Hannes Reinecke <hare@suse.com>
    Reviewed-by: Ming Lei <ming.lei@redhat.com>
    Acked-by: John Garry <john.garry@huawei.com>
    Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

I guess that patch can be a bit scary by itself. But IIUC it all went
fine this time!

But hey, if that works, that means $SUBJECT patch will enable BFQ on all
libata devices and any SCSI that is single queue as well, not just
"obscure" stuff like MMC/SD and UBI, and that is
indeed a massive crowd of legacy devices. But we're talking
v4.21 here.

Johannes, you might be interested in $SUBJECT patch.
It'd be nice to hear what SUSE people have to add, since they
are pretty proactive in this area.

Yours,
Linus Walleij
