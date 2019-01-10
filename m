Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE623C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EEB21738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruy7sYtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfAJBZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:25:34 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:33722 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfAJBZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 20:25:34 -0500
Received: by mail-oi1-f176.google.com with SMTP id c206so8026130oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 17:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BgvlnKDUtC4qIhVYdgUKnPKKhXoQx4BmJ8JgH/bZm+8=;
        b=ruy7sYtr8I1L0HS2zH4AmkrwgDUm+MjXxn9Aw12LKA3hdMjELGJQwuH5S27MZr+i3A
         98kLTeFCAizKMGHAm7Hv7z4VhpHZEViZAbqzZHF8Yhau3amvxCEebu+Z0cQKXv6frmm8
         HjN2+ph674rwJir04i2omwJd4D6mkICasR5nrKQYTaV+mA/qV/hPBDFmTogEAql6sKsj
         apgGBfn4LhgCnnW67oaj6DZ1N//T4DFPVVcOy04wNWgSPTzjA4mQJN38KGEiLx/XLRgu
         lpfRSYF9rEG1GG2QXdmB/6MFpmTcKItSxm//RRU9M3JWRFZjie+NArV6+q1WZJKxMuWR
         Zpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BgvlnKDUtC4qIhVYdgUKnPKKhXoQx4BmJ8JgH/bZm+8=;
        b=sTCV+dj+fMQ5jFl45gASNNzcq1aBYy/92tUe8APJ82njzMgwuBESylLDc7jf2lXntp
         Vv11AQ3GpbKNr2yT/f5c+mxQFvlMwAl+dGEvES38+3obiBNEsFDChfhBi++LpbtvWUJG
         IFz1OB780TqyIzPT/sC+oS10QdDQghu3eVO1TbzOVj0awOIsL5hSSCii3KOYfiYulxGd
         Znof8shjaFqCWPKUawoy4/KCFJjsLz6Evvj0wWFFmcv1jHwgZZCYvjqfF7Kymh6NMzxo
         aQaUWJBKRaxNilxND1L45M0/mtia4Ya4T7riiLDBOslgqppcUnK98m8w80rjYI0IMK3h
         Kv4w==
X-Gm-Message-State: AJcUukd2Yqja1NxOr9dFEFVwkId+2ZQNHteyqozriBE6jgl4LZjYNEct
        tioBRlBLJban/GYjL00NEgxjFgVNSLLr93oUi16fGOb1
X-Google-Smtp-Source: ALg8bN7UrBkl32OrWHlGBlg/fuO7cLxuYEVZWEFoKv+/ZigeIBxTH9Ij1hW2kS5nibYHXacoVZdO/NRTqUEjsUqdtrU=
X-Received: by 2002:aca:b7c2:: with SMTP id h185mr5538721oif.298.1547083532985;
 Wed, 09 Jan 2019 17:25:32 -0800 (PST)
MIME-Version: 1.0
From:   james harvey <jamespharvey20@gmail.com>
Date:   Wed, 9 Jan 2019 20:25:22 -0500
Message-ID: <CA+X5Wn4s2_zEvAHzT+dXToht=TBCyqBxVVnOPCrSTa_=_sxV6g@mail.gmail.com>
Subject: Interpreting /sys/block/<disk>/{,<partition>}/discard_alignment
To:     kernel list <linux-kernel@vger.kernel.org>,
        martin.petersen@oracle.com, jaxboe@fusionio.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-block

Describes discard_alignment as:

"Devices that support discard functionality may internally allocate
space in units that are bigger than the exported logical block size.
The discard_alignment parameter indicates how many bytes the beginning
of the device is offset from the internal allocation unit's natural
alignment."

Q1 - I'm hoping you can clarify how this should be interpreted.

I originally took this to mean the number of bytes into the first
discard_granularity block that the partition resides at.  i.e.  If
discard_granularity_block is 128MB, and partition 1 starts at sector
2048 with 512 byte sectors, that this should return 2048*512=1048576
(1MB.)

However, LVM thin volumes (using device mapper thin pools) are seeming
to give the number of bytes left in the first discard_granularity
block at the beginning of the partition.  i.e. Returning
discard_granularity of 128 * 1024 * 1024 minus the start of the
partition 2048 * 512, or 133169152.  (This is if the thin volume is
created with a chunk size of 128MB.)

Q2 - At https://lkml.org/lkml/2018/12/5/1693 --- I saw you recently
said "... there are not many devices that actually report a non-zero
discard alignment..."  Does this mean that every filesystem needs to
look at the partition table to determine its correct value on its own,
rather than using discard_alignment?
