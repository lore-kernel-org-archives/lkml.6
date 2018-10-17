Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B39ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3417421528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ZnVRLh5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3417421528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJQXbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:31:31 -0400
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:46158 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727090AbeJQXbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1539790516;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=/9qDFGIlwUfxNvMNzZ/qogVAU8XGQ7J8Th+UdROAvvQ=;
        b=ZnVRLh5jsn91ea4+966PUYDyF8pgjuTLx8IlL7GjuG0Mt7642wXG9+1ZqKRn943/
        RdA6TAd2qCav5ciYPV6ubuxTuHTgsL1kzDcIfp06ekEkss5nZND92yKrjTtEbWDA06I
        pIMoAGN9yL45I9QmCBXxupxBtRteA+pqbtYKO2iE=
Date:   Wed, 17 Oct 2018 15:35:15 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+87829a10073277282ad1@syzkaller.appspotmail.com,
        Pekka Enberg <penberg@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
In-Reply-To: <20181017000955.GG230131@dtor-ws>
Message-ID: <0100016682aaae79-d1382d3d-83f8-4972-b4b9-6220367f4f65-000000@email.amazonses.com>
References: <000000000000e5f76c057664e73d@google.com> <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com> <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com> <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com>
 <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com> <010001660c4a8bbe-91200766-00df-48bd-bc60-a03da2ccdb7d-000000@email.amazonses.com> <20180924184158.GA156847@dtor-ws> <20180927143537.GB19006@bombadil.infradead.org>
 <20181017000955.GG230131@dtor-ws>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.10.17-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018, Dmitry Torokhov wrote:

> On Thu, Sep 27, 2018 at 07:35:37AM -0700, Matthew Wilcox wrote:
> > On Mon, Sep 24, 2018 at 11:41:58AM -0700, Dmitry Torokhov wrote:
> > > > How large is the allocation? AFACIT nRequests larger than KMALLOC_MAX_SIZE
> > > > are larger than the maximum allowed by the page allocator. Thus the warning
> > > > and the NULL return.
> > >
> > > The size in this particular case is being derived from a value passed
> > > from userspace. Input core does not care about any limits on size of
> > > memory kmalloc() can support and is perfectly happy with getting NULL
> > > and telling userspace to go away with their silly requests by returning
> > > -ENOMEM.
> > >
> > > For the record: I definitely do not want to pre-sanitize size neither in
> > > uinput nor in input core.
> >
> > Probably should be using kvzalloc then.
>
> No. No sane input device can track so many contacts so we need to use
> kvzalloc(). Failing to allocate memory is proper response here.

What is a "contact" here? Are we talking about SG segments?

