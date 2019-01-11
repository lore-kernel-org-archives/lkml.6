Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7B3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D221C20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="uOWwTQ+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbfAKFBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:01:42 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:63123 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfAKFBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:01:41 -0500
Date:   Fri, 11 Jan 2019 05:01:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1547182897;
        bh=7VC0IcuU5rcqD2aAf8k0ASK6x4ymbI2VV5F+1/feSA4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=uOWwTQ+MkvExMr2iI4ZoaE5DqZlcy8rqniM/sTMDySZ+3iDKUzh22gXKUh2BuD4FE
         HWWGfmcfou24FCHcQrWqw3eHbXQd9W3woLDspBx8olNjixJmwIoK5yXcIdtKUzwf1N
         TgvRtLVHzcHYNA4lQ0LJknne/xfQQ/99BK35W+EQ=
To:     Qian Cai <cai@lca.pw>
From:   Esme <esploit@protonmail.ch>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Reply-To: Esme <esploit@protonmail.ch>
Subject: Re: PROBLEM: syzkaller found / pool corruption-overwrite / page in user-area or NULL
Message-ID: <rYrcPMrGmYbPe_xgNEV6Q0jqc5XuPYmL2AFSyeNmg1gW531bgZnBGfEUK5_ktqDBaNW37b-NP2VXvlliM7_PsBRhSfB649MaW1Ne7zT9lHc=@protonmail.ch>
In-Reply-To: <3b3184e0-d913-6519-0f9d-2f01ef795650@lca.pw>
References: <t78EEfgpy3uIwPUvqvmuQEYEWKG9avWzjUD3EyR93Qaf_tfx1gqt4XplrqMgdxR1U9SsrVdA7G9XeUZacgUin0n6lBzoxJHVJ9Ko0yzzrxI=@protonmail.ch>
 <4u36JfbOrbu9CXLDErzQKvorP0gc2CzyGe60rBmZsGAGIw6RacZnIfoSsAF0I0TCnVx0OvcqCZFN6ntbgicJ66cWew9cOXRgcuWxSPdL3ko=@protonmail.ch>
 <1547154231.6911.10.camel@lca.pw>
 <hFmbfypBKySVyM6ITf55xUsPWifgqJy6MZ-kFJcYna61S-u2hoClrqr87QTF4F2LhW-K42T2lcCbvsEyGAL0dJTq5CndQBiMT6JnlW4xmdc=@protonmail.ch>
 <1547159604.6911.12.camel@lca.pw>
 <olV6qm38nrHhMMH3bq9cY3h60MaHsW5U9n6xn3_PVP1UkFNJBNbVuS-8P_FdCazGJX6GZX_Qqe2Nj8_hbLJsgto76Xo-gLQ8We-hsc_vRKk=@protonmail.ch>
 <7416c812-f452-9c23-9d0c-37eac0174231@lca.pw>
 <fkYi1Hgt2t5U6zQt5Kz4ej-TFyVsn2Qp2OLrMbmt2418U1rn20DPZGqgCN-rmCZgFgGKXhl3-IGciCJ-G9fV_lkBuy_Vb7QFouBhwBE--Eo=@protonmail.ch>
 <3b3184e0-d913-6519-0f9d-2f01ef795650@lca.pw>
Feedback-ID: pQGzDYT_k6dzic_kf3kwsxmTXzjnqMJxtC9J3KGyZBepPHdXRBM0BHuwPfpm1pFdJLAMwtJT5KKNaGlRVnFRQw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Thursday, January 10, 2019 11:52 PM, Qian Cai <cai@lca.pw> wrote:

> On 1/10/19 10:15 PM, Esme wrote:
>
> > > > [ 75.793150] RIP: 0010:rb_insert_color+0x189/0x1480
> > >
> > > What's in that line? Try,
> > > $ ./scripts/faddr2line vmlinux rb_insert_color+0x189/0x1480
> >
> > rb_insert_color+0x189/0x1480:
> > __rb_insert at /home/files/git/linux/lib/rbtree.c:131
> > (inlined by) rb_insert_color at /home/files/git/linux/lib/rbtree.c:452
>
> gparent =3D rb_red_parent(parent);
>
> tmp =3D gparent->rb_right; <-- GFP triggered here.
>
> It suggests gparent is NULL. Looks like it misses a check there because p=
arent
> is the top node.
>
> > > What's steps to reproduce this?
> >
> > The steps is the kernel config provided (proc.config) and I double chec=
ked the attached C code from the qemu image (attached here). If the kernel =
does not immediately crash, a ^C will cause the fault to be noticed. The re=
port from earlier is the report from the same code, my assumption was that =
the possible pool/redzone corruption is making it a bit tricky to pin down.
> > If you would like alternative kernel settings please let me know, I can=
 do that, also, my current test-bench has about 256 core's on x64, 64 of th=
em are bare metal and 32 are arm64. Any possible preferred configuration tw=
eaks I'm all ears, I'll be including some of these steps you suggested to m=
e in any/additional upcoming threads (Thank you for that so far and future =
suggestions).
> > Also, there is some occasionally varying stacks depending on the corrup=
tion, so this stack just now (another execution of test3.c);
>
> I am unable to reproduce any of those here. What's is the output of
> /proc/cmdline in your guest when this happens?

console=3DttyS0 root=3D/dev/sda debug earlyprintk=3Dserial slub_debug=3DQUZ

