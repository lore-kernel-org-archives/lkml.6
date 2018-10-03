Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94117C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD6221470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD6221470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeJDAYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:24:20 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53883 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeJDAYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:24:19 -0400
Received: by mail-it1-f196.google.com with SMTP id q70-v6so9447411itb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I5BnZLPzbXUWdyMCNxcJTEsVfsjPpKhernmBohTxbCA=;
        b=syxZEytrRE+wLJIen/Mst8afwb/hrJEzwrpiy+oEqWnyOPHn69KBsPoZeasb0fUnte
         rh88i6aBw+HaF7DNej2/hEXgHGH0b9WpfJ/SlXb6gJmOf6nN5Hn1iZD5wl0IIBHPwVdc
         6r++D6iK9YhyzQrf4Y7heyzrZAIOV/8Ocp40nCoE9H2RQdFYxDJXrWY/R/F/QQFf3Jas
         F3MuVhS/o1yrI9D4diG7yyH9cfwhOn6QNFhNPks1cK4ccOr7GsN073VNh//Zbi9m1h1X
         JG2OGEntBfxoOo/A1Pvnse3yzMLEVorVryrcWgN9t+4LAZ2qAzM9Ua7QRiTHKLkL0WPz
         i+Nw==
X-Gm-Message-State: ABuFfojozMiqb9Nkho7CoD6TML8v6XCwJWWPjJz4gXkZLeKxg/tRHp30
        P98I0BdPtUiTet2fTOgRwdQSPXOpYGCtWZnjc6wBFw==
X-Google-Smtp-Source: ACcGV62da0d98QmI+MA+BldsPRz1IVMHQnp8+9DofLJLt4CGPCV9fnYbyPvlO8Ut8WlbTCohAzG/j9+Ae4+C5MM+8ho=
X-Received: by 2002:a24:ac53:: with SMTP id m19-v6mr1974013iti.147.1538588097288;
 Wed, 03 Oct 2018 10:34:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:998e:0:0:0:0:0 with HTTP; Wed, 3 Oct 2018 10:34:56 -0700 (PDT)
In-Reply-To: <1E24731C-13E1-41CC-A96A-ABDAA6175849@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk> <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com> <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <CACRpkdbHiq9bstRzyg-fJfXKnXr8wD1YzAooLAwQKM0OzP=HVA@mail.gmail.com> <1E24731C-13E1-41CC-A96A-ABDAA6175849@linaro.org>
From:   Bryan Gurney <bgurney@redhat.com>
Date:   Wed, 3 Oct 2018 13:34:56 -0400
Message-ID: <CAHhmqcRbz+UsgDsHzJzKDWqZ_JMNp1UYq3M2rAf1vqfmO+wRyg@mail.gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, Damien.LeMoal@wdc.com,
        Artem Bityutskiy <dedekind1@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 11:53 AM, Paolo Valente <paolo.valente@linaro.org> wrote:
>
>
>> Il giorno 03 ott 2018, alle ore 10:28, Linus Walleij <linus.walleij@linaro.org> ha scritto:
>>
>> On Wed, Oct 3, 2018 at 9:42 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>>
>>> There is another class of outliers: host-managed SMR disks (SATA and SCSI,
>>> definitely single hw queue). For these, using mq-deadline is mandatory in many
>>> cases in order to guarantee sequential write command delivery to the device
>>> driver. Having the default changed to bfq, which as far as I know is not SMR
>>> friendly (can sequential writes within a single zone be reordered ?) is asking
>>> for troubles (unaligned write errors showing up).
>>
>> Ah, that is interesting.
>>
>> Which device driver files are we talking about here, specifically?
>> I'd like to take a look.
>>
>> I guess what you say is not that you are looking for the deadline
>> scheduling per se (as in deadline scheduling is nice), what you want is
>> the zone locking semantics in that scheduler, is that right?
>>
>> I.e. this business:
>> blk_queue_is_zoned(q)
>> blk_req_zone_write_lock(rq);
>> blk_req_zone_write_unlock(rq);
>> and mq-deadline solves this with a spinlock.
>>
>> I will augment the patch to enforce mq-deadline
>> if blk_queue_is_zoned(q) is true, as it is clear that
>> any device with that characteristic must use mq-deadline.
>>
>> Paoly might be interested in looking into whether BFQ could
>> also handle zoned devices in the future, I have no idea of how
>> hard that would be.
>>
>
> Absolutely, as I already wrote in my reply to Damien.
>
> In the meantime, Linus, augmenting your patch as you propose seems
> a clean and effective solution to me.
>
> Thanks,
> Paolo
>
>> The zoned business seems a bit fragile. Should it even be
>> allowed to select any other scheduler than deadline on these
>> devices? Presenting all compiled in schedulers in
>> /sysblock/device/queue/scheduler sounds like just giving
>> sysadmins too much rope.
>>
>> Yours,
>> Linus Walleij
>

Right now, users of host-managed SMR drives should be using "deadline"
or "mq-deadline", to avoid out-of-order writes in sequential-only
zones.

I'm running into a situation right now on a test system (Fedora 28,
4.18.7 kernel) where I copied test data onto an F2FS filesystem, but I
accidentally forgot to add my "udev rule" file:

# cat /etc/udev/rules.d/99-zoned-block-devices.rules
ACTION=="add|change", KERNEL=="sd[a-z]",
ATTRS{queue/zoned}=="host-managed", ATTR{queue/scheduler}="deadline"

...and now, I see these messages when that specific SMR drive is mounted:

kernel: F2FS-fs (sdc): IO Block Size:        4 KB
kernel: F2FS-fs (sdc): Found nat_bits in checkpoint
kernel: F2FS-fs (sdc): Mounted with checkpoint version = 212216ab
kernel: mpt3sas_cm0: log_info(0x31080000): originator(PL), code(0x08),
sub_code(0x0000)
kernel: mpt3sas_cm0: log_info(0x31080000): originator(PL), code(0x08),
sub_code(0x0000)
kernel: scsi_io_completion: 20 callbacks suppressed
kernel: sd 7:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE
kernel: sd 7:0:0:0: [sdb] tag#0 Sense Key : Aborted Command [current]
kernel: sd 7:0:0:0: [sdb] tag#0 Add. Sense: No additional sense information
kernel: sd 7:0:0:0: [sdb] tag#0 CDB: Write(16) 8a 00 00 00 00 00 3d d4
ec 99 00 00 00 80 00 00

I was also running into problems with creating new directories on this
F2FS filesystem.  However, "fsck.f2fs" reports no problems.  So at
this point, I created a new F2FS filesystem on a second SMR drive, and
am currently copying the data from the "bad" F2FS filesystem to the
"good" one.

I wouldn't call zoned block devices "fragile"; they simply have I/O
rules that didn't previously exist: all writes to sequential-only
zones must be sequential.  And one of the things that schedulers do is
reorder writes.  After 4.16, sd stopped being the "gatekeeper" of
ensuring sequential writes, but the only "zoned-aware" schedulers were
deadline and mq-deadline.  Since my test system defaulted to "cfq", I
ran into problems.

So I welcome any changes that make it impossible for the user to
"accidentally use the wrong scheduler".

At least this time, I didn't "brick" my test system's BIOS, like I did
back in May of this year [1].


Thanks,

Bryan


[1] https://www.spinics.net/lists/linux-block/msg26798.html
