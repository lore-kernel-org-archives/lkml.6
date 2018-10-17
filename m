Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDFAECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E8A214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="eV78ha4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E8A214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeJRCVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:21:33 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51565 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeJRCVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:21:33 -0400
Received: by mail-it1-f196.google.com with SMTP id 74-v6so3523971itw.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jEHi1AMjdbAwrev8nCRhSDplTWAP8UBAL9Bfnxo3x5Y=;
        b=eV78ha4C6zx1PXWS8EftW+4ca/GEvZt838JEdrQBh0cqNlr/qGpT12Lf6d3ABMzEEq
         WbK0vVtXU1xQPRZtofd3QguOKyKiI0C9b+kK1FgAnf3PRFhj7Z8o8FIII3Fa8QXF+eRE
         5dnJSTNe/hLahHv+dupFN6/Q6uBE6dME99/jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jEHi1AMjdbAwrev8nCRhSDplTWAP8UBAL9Bfnxo3x5Y=;
        b=D58oLhC43RbRf1kdNJtT57hPOpU7IiEig5gNrszQLzm2r9axlSxiw4IuraNl554+h1
         Mi4zNrlKmxPoJ4mqyrMfuh/Kr7/9s8HHqtuW5xnkcgRmxBYm/vGVqTU9YmfHqPCcOAjy
         qSh3ocZSDtAkqeoc9+k/MOUSD86k9tb/a3/z5noy0GwCZydcI9zcWCcgASeZ8Q9VTSoM
         8KbwH+waMFgvt1GZrNwwV71AXDhlC3QrJ4Sc2Q5KQPErl858H8DEmYQ22M9HxwhDedim
         gGtl6Xo3D6Jsn886CJjKCpjuUyFLh2YM4lWPJz0MCu1LtukP23pUcTTCaqqMgqGSfVtl
         BxtA==
X-Gm-Message-State: ABuFfog2S88yVkOczkR7N15nmESuJvE7Tvzs2IsbmHqIORHKo22GMJc2
        +8gBV4J/c8wWpwnlldTo5LorQZj/ahIKHTEx8LHADREpJ1jEDg==
X-Google-Smtp-Source: ACcGV63mvzUTUPH4hBsjxw4R1F1eWOs1GYAB4Y1FraQtwqjoihaZhpMQ85O1oFCSaxBwnXRs3T0MJUvVJph7WB5ph/M=
X-Received: by 2002:a02:55c1:: with SMTP id e184-v6mr20668657jab.35.1539800679182;
 Wed, 17 Oct 2018 11:24:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Wed, 17 Oct 2018 11:24:38
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 17 Oct 2018 20:24:38 +0200
Message-ID: <CAJfpegsxFUGeczcC-pzK0WWROjv48_PvXtNun-f5QJMoUDn1Dw@mail.gmail.com>
Subject: statx(2) API and documentation
To:     Michael Kerrisk <mtk.manpages@gmail.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to implement statx for fuse and ran into the following issues:

- Need a STATX_ATTRIBUTES bit, so that userspace can explicitly ask
for stx_attribute; otherwise if querying has non-zero cost, then
filesystem cannot do it without regressing performance.

- STATX_ALL definition is unclear, can this change, or is it fixed?
If it's the former, than that's a backward compatibility nightmare.
If it's the latter, then what's the point?

- STATX_ATIME is cleared from stx_mask on SB_RDONLY, and on NFS it is
also cleared on MNT_NOATIME, but not on MNT_RDONLY.  We need some sort
of guideline in the documentation about what constitutes
"unsupported": does atime become unsupported because filesystem is
remounted r/o?  If so, why isn't this case handled consistently in the
VFS and filesystems?

- What about fields that are not cached when statx() is called with
AT_STATX_DONT_SYNC?  E.g. stx_btime is supported by the filesystem,
but getting it requires a roundtrip to the server.  Requesting
STATX_BTIME in the mask and adding  AT_STATX_DONT_SYNC to the flags
means the filesystem has to decide which it will honor.   My feeling
is that it should honor AT_STATX_DONT_SYNC and clear STATX_BTIME in
stx_mask.   Documentation has no word about this case.

Thanks,
Miklos
