Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598C7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14373216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="b/ghY+IN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14373216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeI0Uel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:34:41 -0400
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:35182 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727676AbeI0Uel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1538057771;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=0iO2WnbAnWpGnBvmthhOKoLwM5UIpUu7PDZu1J7oxj0=;
        b=b/ghY+INcyNOGuGzy7Y6aDqvSsf026jl9uogX00ZDa01s+KEPSESBS0JDciHTtKP
        FwTwW8S0oQCwfe6BKa/CFEa+i3/z5uxwd5p3vKUF1JaDNyqisiv+jL4vPEb9dYN4FTC
        tT/QdXKJRiNxHWai47oUo/EiQguSJzJbc/xwSqBQ=
Date:   Thu, 27 Sep 2018 14:16:11 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Dmitry Vyukov <dvyukov@google.com>
cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        syzbot+87829a10073277282ad1@syzkaller.appspotmail.com,
        Pekka Enberg <penberg@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
In-Reply-To: <CACT4Y+aUdAmRmgiV5-KWXF-eGoCUCMhUC+ddLU-heQTQ53PhRA@mail.gmail.com>
Message-ID: <010001661b631a3e-f398fc0a-127c-4c6e-b6ca-b2bd63bc4a9a-000000@email.amazonses.com>
References: <000000000000e5f76c057664e73d@google.com> <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com> <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com> <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com>
 <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com> <010001660c4a8bbe-91200766-00df-48bd-bc60-a03da2ccdb7d-000000@email.amazonses.com> <20180924184158.GA156847@dtor-ws> <CACT4Y+ZPrngv8GTC-Cw68PBDxZ2T5x1kKMNXL3DmP24Xd0m_5g@mail.gmail.com>
 <01000166110bb882-0b1fa048-fe1c-4139-a1ba-702754bbc267-000000@email.amazonses.com> <CACT4Y+aUdAmRmgiV5-KWXF-eGoCUCMhUC+ddLU-heQTQ53PhRA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.09.27-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018, Dmitry Vyukov wrote:

> On Tue, Sep 25, 2018 at 4:04 PM, Christopher Lameter <cl@linux.com> wrote:
> > On Tue, 25 Sep 2018, Dmitry Vyukov wrote:
> >
> >> Assuming that the size is large enough to fail in all allocators, is
> >> this warning still useful? How? Should we remove it?
> >
> > Remove it. It does not make sense because we check earlier if possible
> > without the warn.
>
> Mailed "mm: don't warn about large allocations for slab" to remove the warning.
>

Hoe it arrives here at some point.

