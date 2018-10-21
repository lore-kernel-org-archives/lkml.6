Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1016ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 05:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5095D2083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 05:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzyb0Mzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5095D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJUNnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 09:43:52 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39984 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbeJUNnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 09:43:52 -0400
Received: by mail-yb1-f193.google.com with SMTP id w7-v6so14875576ybm.7;
        Sat, 20 Oct 2018 22:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A05h2qBIh1fbv6NiTfaQadO0PFchS102DEvfshxSG90=;
        b=Yzyb0Mzk/Chv2u5oshZaMweBa4i6rCFDwfjXKBCmdgf9sF2Fy53emS2cZxgk7NaY6P
         vB9cfDzmhkODUv/PxXujrZwYiYMUzyVdBxUDgEq9zZFrAk4G4ip77V8vJuy/V4FTCDoX
         KLHlP+0RA2mlMIAJDGJ6vPZwzxidrG/ESbMwTf1CW0xyOR6ItfCdIKWtgN+kXCKVQqOM
         TqZrvofc5NU4Te0WtdiAJX6TiH5BInr7o/VQBW+lU6JwnwivqmoOlt6UZnVo7NVsMk4r
         N9UMmS5/DxTmgeSQMr9oIIeLuXgglR9gJLrwg6FP31UMqLC5AV9UwqZeF6k//DlDzTQw
         oIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A05h2qBIh1fbv6NiTfaQadO0PFchS102DEvfshxSG90=;
        b=Zk/CXfbjda45IANNXnkTOBT+XXr7KiwHctr0wYs1GE5Hcsw8fCE1kPBNzc9AMlyzNT
         pWUJv67Y6tHsiuwLgYDkPkphAXqUA66ODLIS7zmY4x7YxQHXKtBasWfVPMhJcMbmeYAD
         y0lMySxBulgG5+G5GqZCqrxal7o7H1HJ2dkuBFOUJaDLkjmIA7alLHkOtbmAsg064RBa
         lQQR7zl/Ppi/skUROstdKvs0sIZ00C1DfKZfG5NYVqgMrmNle9fsixQHRI71DCjC0X3w
         fKNEnbM2oXabb13pPz/NR7FoZj9ZxJutXX1eOm3/rHROkaVMws22xwgiVh5e1Wi6hJaB
         B/8A==
X-Gm-Message-State: ABuFfohY5tRn8/aCgGFcKn99FeS/zkQl3XEM67TWiJtaoFhQ9BCe7e8B
        sQTqOelmVw0DJ2/eBf1Cl1PCnfmwVWxAV8iufEk=
X-Google-Smtp-Source: ACcGV60Piz9+Khg7WNTE7+edDRAzeUCJ6tnef1YBFjaKB52xJY1BdKLeb031fsz7B4sU3lJEPM1hLbrJIRBOjP/ObBQ=
X-Received: by 2002:a25:3a82:: with SMTP id h124-v6mr27051290yba.32.1540099846348;
 Sat, 20 Oct 2018 22:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181020220957.GA7267@pathfinder> <20181020222637.GA3477@bombadil.infradead.org>
In-Reply-To: <20181020222637.GA3477@bombadil.infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 21 Oct 2018 08:30:35 +0300
Message-ID: <CAOQ4uxhO_-B12280jT5RHX3oMjoSTHG73=PyDDVfURs-ey-EkA@mail.gmail.com>
Subject: Re: [PATCH] fs: ufs: Remove switch statement from ufs_set_de_type function
To:     Matthew Wilcox <willy@infradead.org>
Cc:     phil@philpotter.co.uk, Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>, David.Laight@aculab.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 1:27 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Oct 20, 2018 at 11:09:57PM +0100, Phillip Potter wrote:
> > Remove switch statement from ufs_set_de_type function in fs/ufs/util.h
> > header and replace with simple assignment. For each case, S_IFx >> 12
> > is equal to DT_x, so in valid cases (mode & S_IFMT) >> 12 should give
> > us the correct file type. It is expected that for *nix compatibility
> > reasons, the relation between S_IFx and DT_x will not change. For
> > cases where the mode is invalid, upper layer validation catches this
> > anyway, so this improves readability and arguably performance by
> > assigning (mode & S_IFMT) >> 12 directly without any jump table
> > or conditional logic.
>
> Shouldn't we also do this for other filesystems?  A quick scan suggests
> someone should at least look at xfs, ubifs, squashfs, romfs, ocfs2,
> nilfs2, hfsplus, f2fs, ext4, ext2, exofs, coda, cifs & btrfs.
>

I've tried to do that 2 years ago, not even for readability, but to
fix a lurking
bug in conversion table implementation that was copy&pasted from ext2 to
many other fs:
https://marc.info/?l=linux-fsdevel&m=148217829301701&w=2
https://marc.info/?l=linux-fsdevel&w=2&r=1&s=amir73il+file+type+conversion&q=b

The push back from ext4/xfs maintainers was that while all fs use common
values to encode d_type in on disk format, those on-disk format values
are private to the fs.

Eventually, the fix that got merged (only to xfs) did the opposite, it converted
the conversion table lookup to a switch statement:
https://marc.info/?l=linux-fsdevel&m=148243866204444&w=2

Some fs maintainers were happy about the initial version, but I did not
pursue pushing that cleanup:
https://marc.info/?l=linux-fsdevel&m=148243866204444&w=2

Phillip, you are welcome to re-spin those patches if you like.
Note that the generic conversion helpers do not rely on upper layer
to catch invalid mode values.

Cheers,
Amir.
