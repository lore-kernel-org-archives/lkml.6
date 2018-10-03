Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF88C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8B12089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8B12089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeJCWEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:04:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39141 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbeJCWEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:04:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so1717230pgv.6;
        Wed, 03 Oct 2018 08:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w0FaD5FXIfyYJNJc0anr+UF+cvnWfNj2P9kzcOjUGXM=;
        b=sgIeRMUnuqfQylReKTFwk+SZRpwHQ0y+Ls0tOEfzuY0rkrzhUJCpAkhNv7UHZ63cfy
         dmwZv/XeQJFMNGb+21QKvGhUGLXgHWHtuhIDfuvCMLD6Ae7fj9W3Nk6vasSGI/Qlvx32
         BfMduPmE4Xc/dMOtOaEjcF228xTbAw106DRvA0Z8edi8OXvgLki5Dh3ljlDmUsymHytd
         r6PEAFaqpK/Fe8gcRLdtRttdsCneNOJunJS0rh3A7V/zAg9sViqfiM+ld2x/G9FT7AgO
         99ZgHFTU6N8uJYS64sPwpF8z/7KtN51RH/WiZM9ZZdGBSSUrI3Lr5u9/gmvbImBk8h+q
         hZnA==
X-Gm-Message-State: ABuFfojk97Om6jMUWHXJ+AZ/yJA7tm3+Y89H0dDA+aTxjkVcxo5uPgkv
        rFw7+qvD3puEBzyuzHa/iBE=
X-Google-Smtp-Source: ACcGV63kDmegzCPJEexQHZjegBGk4Tkkw/Lwgad9CRXdbQXML096Y4iSX7iVMiR3pijr6+2v77VjAg==
X-Received: by 2002:a62:8145:: with SMTP id t66-v6mr2050081pfd.192.1538579726670;
        Wed, 03 Oct 2018 08:15:26 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m15-v6sm6940756pfk.149.2018.10.03.08.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 08:15:25 -0700 (PDT)
Message-ID: <1538579724.205649.2.camel@acm.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>,
        "aherrmann@suse.com" <aherrmann@suse.com>,
        "mgorman@suse.com" <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bfq-iosched@googlegroups.com" <bfq-iosched@googlegroups.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        Mark Brown <broonie@kernel.org>
Date:   Wed, 03 Oct 2018 08:15:24 -0700
In-Reply-To: <20181003150131.GA7306@infradead.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
         <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
         <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
         <1538550325.14984.108.camel@gmail.com>
         <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
         <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
         <20181003125146.GA9313@infradead.org> <1538578732.205649.0.camel@acm.org>
         <20181003150131.GA7306@infradead.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-03 at 08:01 -0700, Christoph Hellwig wrote:
+AD4 On Wed, Oct 03, 2018 at 07:58:52AM -0700, Bart Van Assche wrote:
+AD4 +AD4 Has the work with the T10 committee to standardize the SCSI equivalent of anonymous
+AD4 +AD4 writes already started?
+AD4 
+AD4 No, and I don't know of anyone who wants to do that in the short term.

That's unfortunate. I think having such a command available in the SCSI
command set would be a step forward.

Bart.
