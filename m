Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441FCC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EE520685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xQjcevSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EE520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbeKTWRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:17:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbeKTWRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:17:46 -0500
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AEC020685
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 11:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542714540;
        bh=GNDDljc6kcRxusvIpE62Osbr2A1k9MbBLDdoZFpXdmI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xQjcevSSCr96iwIguUaAPhKOu8zNmFmCBHQr1p2imtNHx/sGOMRRVy+5bXCPMrAJJ
         C5zN5K3bBuwDZ9DmAgAaD/KRXuD+ZEugeWfZRicUPjgUThIEb8lxQbGT6DAqbxdDFH
         DSyWAZC7HvHqzMGchpfcUav44cwthHtBtl02lxr4=
Received: by mail-lf1-f52.google.com with SMTP id a16so1120437lfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 03:49:00 -0800 (PST)
X-Gm-Message-State: AGRZ1gJZ4Do/6MbzSOZrG4HUuEVQq6xqwJeVUF3kSXaYXHK+lLIFKyMP
        RAx/OS+en8gbD89dk35sHqN8g0VrWEGCKsG/+1Q=
X-Google-Smtp-Source: AJdET5cWjCbTeiBDab86I+2MTyE2VWk6cL5tujyZOsURb03g2Y7Ttgz9sfU+KAyUXkWKi/IbsFyQ5Lr89VrjwtxZebk=
X-Received: by 2002:a19:c396:: with SMTP id t144mr926297lff.110.1542714538669;
 Tue, 20 Nov 2018 03:48:58 -0800 (PST)
MIME-Version: 1.0
References: <CAJKOXPdPnha1-1dCRFaPZ-CGzS1OzNcFrxuOJmWstHJcRAMZwg@mail.gmail.com>
 <20181120113326.0d4f061e@xps13>
In-Reply-To: <20181120113326.0d4f061e@xps13>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 20 Nov 2018 12:48:46 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcrVXdCXqmxffJca7HfEV3G3agkzjWu1rfsNDDbMzc_XQ@mail.gmail.com>
Message-ID: <CAJKOXPcrVXdCXqmxffJca7HfEV3G3agkzjWu1rfsNDDbMzc_XQ@mail.gmail.com>
Subject: Re: [BUG BISECT] Missing MTD NAND partitions - mtd: rawnand: Move the
 ->exec_op() method to nand_controller_ops
To:     miquel.raynal@bootlin.com
Cc:     boris.brezillon@bootlin.com, jmkrzyszt@gmail.com,
        Stefan Agner <stefan@agner.ch>, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 at 11:33, Miquel Raynal <miquel.raynal@bootlin.com> wro=
te:
>
> Hi Krzysztof,
>
> Krzysztof Koz=C5=82owski <k.kozlowski.k@gmail.com> wrote on Tue, 20 Nov 2=
018
> 10:46:33 +0100:
>
> > Hi all,
> >
> > Since few days linux-next has problem on Freescale VF500 - MTD seems
> > to be broken.
> >
> > Bisect pointed me to commit 7c27338c728e39ef47c83d101959aa332506969d
> > ("mtd: rawnand: Move the ->exec_op() method to nand_controller_ops")
> > as reason of failure to find MTD partitions.
> >
> > Toradex Colibri VF50 on Iris board (ARMv7, UP, Cortext-A5, NXP VF500,
> > 128 MB RAM, 128 MB NAND, Systemd: v232) booted from NFS root (NFSv4)
> > trying to mount UBIFS from NAND/MTD. Board uses VF610 NAND driver.
> >
> > The MTD partitions are missing entirely (nothing under /dev/mtd).
> > In the logs you can also see:
> > [    1.232161] UBI error: cannot open mtd ubi2, error -2
> >
> > Attached - dmesg.log
> >
> > Let me know if you need defconfig or any other information.
>
> Thank you very much for testing and reporting the bug!
>
> Could you please test with this diff applied [1] please? We discussed
> with Boris and we think it should fix your setup (and all others also
> impacted).
>
> [1] http://code.bulix.org/r1m99i-509201

error: patch failed: drivers/mtd/nand/raw/nand_base.c:4399
error: drivers/mtd/nand/raw/nand_base.c: patch does not apply

Maybe you have a git tree with this somewhere?

Best regards,
Krzysztof
