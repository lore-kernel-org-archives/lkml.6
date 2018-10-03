Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D2DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74142082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74142082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJCVrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:47:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40963 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCVrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:47:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id m77-v6so1810384pfi.8;
        Wed, 03 Oct 2018 07:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTGBLSnh0CRsokaJ9tV8vfG+xryHa8lau6FyTzHJLoo=;
        b=Cy92NeL3FpTvkcJGYFlSP32uZ0m47hE05zpSTeVCi2khvBFyPZlpQoZBDrsVq8+6RF
         bBgjJisJdpel15+kQ+79YGjJw1ZTjaA1un2q4wPtwGmf3bxdjbprTmOZ33eID8FimSus
         uRHydO96mb+pvHSo/LllQnGqG5YyK8t+phxbrNIQwjepqDZ7fwsl72XemirCVbF50ukd
         Sa0NeYlM2Air0xrcWpaY9vUKpAR+Kr59+T+hX4RuRGGY2Qsx99YFVy3+eGT9v0jPAEQn
         CNSV8HDpsCyj1aNxmYrUMkpyyV3Hg47ffNZQj7o2AHrj6dNrDmezw25QjVKx3jH8Dc/O
         k3fg==
X-Gm-Message-State: ABuFfojAjGuUkH9PXN7XdCLc0PTpqGT5kHhuGZb9y5DyhJU92CyrhspV
        tLCGiOHA8MJN7rBazrwIh+Q=
X-Google-Smtp-Source: ACcGV61lpSONFeHu2ZWyL/DWU6q3o12cwSPEsV7iPKSO1bW3JfMlqh5lbod1a46ErUJWJ02Fsnh7Xw==
X-Received: by 2002:a63:ce56:: with SMTP id r22-v6mr1694494pgi.217.1538578734653;
        Wed, 03 Oct 2018 07:58:54 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id d65-v6sm3734098pfe.42.2018.10.03.07.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 07:58:53 -0700 (PDT)
Message-ID: <1538578732.205649.0.camel@acm.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
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
Date:   Wed, 03 Oct 2018 07:58:52 -0700
In-Reply-To: <20181003125146.GA9313@infradead.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
         <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
         <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
         <1538550325.14984.108.camel@gmail.com>
         <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
         <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
         <20181003125146.GA9313@infradead.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-03 at 05:51 -0700, Christoph Hellwig wrote:
+AD4 On Wed, Oct 03, 2018 at 07:42:15AM +-0000, Damien Le Moal wrote:
+AD4 +AD4 Of note also is that host-managed like sequential zone devices are also likely
+AD4 +AD4 to show up soon with the work being done in the NVMe standard on the new +ACI-Zoned
+AD4 +AD4 namespace+ACI feature proposal. These devices will also require a scheduler like
+AD4 +AD4 mq-deadline guaranteeing per-zone in-order delivery of sequential write
+AD4 +AD4 requests. Looking only at the number of queues of the device is not enough to
+AD4 +AD4 choose the best (most reasonnable/appropriate) scheduler.
+AD4 
+AD4 We actually have a plan to avoid the need for a non-reordering scheduler
+AD4 there (including a Linux prototype for it).  Lets see if it survives the
+AD4 committee.

Has the work with the T10 committee to standardize the SCSI equivalent of anonymous
writes already started?

Thanks,

Bart.

