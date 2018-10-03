Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9513C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B063821470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MsydNpzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B063821470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeJCWmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:42:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34899 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJCWmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:42:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id o18-v6so6184457wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0lO4lKHVXv2iU6Wm0hyJ9PiGrCjLBEbkUrLpHCqOiqs=;
        b=MsydNpzfQG73Uz+s9qBOg2k6PJPKHJ12tphrHJUGqpR51HaM9SZLg7rzQufAs3atnr
         ah02Q39n/NWwG+fJ3Rs3DaD+sZQSy8a47BIiLhhabxnqZxtdBrxQhdWRpCd1Q5LLqavi
         mcM+kDpbZYKPQzRYTXrs27hvOIh1KawzSJ+jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0lO4lKHVXv2iU6Wm0hyJ9PiGrCjLBEbkUrLpHCqOiqs=;
        b=Mr1EroQzvHD29qbYS0rirr5VZwyY97UxcSNC5chsw1H/ujoy+IcmY04XNmfkYvldUo
         tBTO/f9XeAMmZ8+HHDtZ5WdWp51/wWW1mxnYIaeaLm06z8t6OrajlOhF2DSudmaD8mxv
         hKlPxAeOCJEUgdNIDD14DenbnXzHUYQAWRevg/7Lq+7NIk2MlzKQRGY3OuwUYCftlisy
         gWQZb2zfClgsAE8zwrUhMM0w6Cmrp/AUTp8u3b2WrnWmtMjHwYTHK2321QbLXcDnhXMI
         dqV7hTdGAvyCIb8AqH04Ry39kziF5gxixEQ440wzXA3CdHvN8a2tJvJw/RQlUpNNOg6e
         84AQ==
X-Gm-Message-State: ABuFfojngqDexFmR8fUlF2d2MNXWH7Xhg/ihaaUApnHf8YFw18+SXTxr
        uTQcaXkxiNB+XnA6X1oWpT6ZJA==
X-Google-Smtp-Source: ACcGV61EGFcPemY0+/Pr8C4oQ+AnVLatCpfHG+MeCFXsSeWQrrtpHQMm/jpUlD+Z8r9SEhj5wErp7g==
X-Received: by 2002:a1c:890:: with SMTP id 138-v6mr1846594wmi.128.1538582006299;
        Wed, 03 Oct 2018 08:53:26 -0700 (PDT)
Received: from [192.168.43.112] ([31.157.182.99])
        by smtp.gmail.com with ESMTPSA id w11-v6sm2368521wrn.65.2018.10.03.08.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 08:53:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CACRpkdbHiq9bstRzyg-fJfXKnXr8wD1YzAooLAwQKM0OzP=HVA@mail.gmail.com>
Date:   Wed, 3 Oct 2018 17:53:23 +0200
Cc:     Damien.LeMoal@wdc.com, Artem Bityutskiy <dedekind1@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, aherrmann@suse.com, mgorman@suse.com,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Mark Brown <broonie@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E24731C-13E1-41CC-A96A-ABDAA6175849@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com>
 <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <CACRpkdbHiq9bstRzyg-fJfXKnXr8wD1YzAooLAwQKM0OzP=HVA@mail.gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 03 ott 2018, alle ore 10:28, Linus Walleij =
<linus.walleij@linaro.org> ha scritto:
>=20
> On Wed, Oct 3, 2018 at 9:42 AM Damien Le Moal <Damien.LeMoal@wdc.com> =
wrote:
>=20
>> There is another class of outliers: host-managed SMR disks (SATA and =
SCSI,
>> definitely single hw queue). For these, using mq-deadline is =
mandatory in many
>> cases in order to guarantee sequential write command delivery to the =
device
>> driver. Having the default changed to bfq, which as far as I know is =
not SMR
>> friendly (can sequential writes within a single zone be reordered ?) =
is asking
>> for troubles (unaligned write errors showing up).
>=20
> Ah, that is interesting.
>=20
> Which device driver files are we talking about here, specifically?
> I'd like to take a look.
>=20
> I guess what you say is not that you are looking for the deadline
> scheduling per se (as in deadline scheduling is nice), what you want =
is
> the zone locking semantics in that scheduler, is that right?
>=20
> I.e. this business:
> blk_queue_is_zoned(q)
> blk_req_zone_write_lock(rq);
> blk_req_zone_write_unlock(rq);
> and mq-deadline solves this with a spinlock.
>=20
> I will augment the patch to enforce mq-deadline
> if blk_queue_is_zoned(q) is true, as it is clear that
> any device with that characteristic must use mq-deadline.
>=20
> Paoly might be interested in looking into whether BFQ could
> also handle zoned devices in the future, I have no idea of how
> hard that would be.
>=20

Absolutely, as I already wrote in my reply to Damien.

In the meantime, Linus, augmenting your patch as you propose seems
a clean and effective solution to me.

Thanks,
Paolo

> The zoned business seems a bit fragile. Should it even be
> allowed to select any other scheduler than deadline on these
> devices? Presenting all compiled in schedulers in
> /sysblock/device/queue/scheduler sounds like just giving
> sysadmins too much rope.
>=20
> Yours,
> Linus Walleij

