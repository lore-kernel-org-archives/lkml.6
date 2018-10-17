Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AFDECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708F621529
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="InBpz3/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708F621529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeJQXuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:50:18 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:56008 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbeJQXuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1539791638;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=sXqcw/8Tl1jag5M0YZJHDLsO+fcGiWQg4sVmEt0ZSDg=;
        b=InBpz3/yLkcra9vlacsc0/qaMV6bPXXGtE+qqwtxNkLR5ZSVZ0CjaUhhZjX9cZLW
        gcKQPluZquUEwoTIogspjhAq44OHyYuNVu1571YjuiPp6Wdd1InrDNrNd3gXEWAbIvS
        gS86HoKzjwjAV1703U+ZF0lSpJPxf5hU7HYUzszA=
Date:   Wed, 17 Oct 2018 15:53:58 +0000
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
In-Reply-To: <CE3D3608-F320-4DAB-8BEB-3EFDDB54F97E@gmail.com>
Message-ID: <0100016682bbce08-fad65518-19e4-4fa2-a482-0bfdacd3fb42-000000@email.amazonses.com>
References: <000000000000e5f76c057664e73d@google.com> <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com> <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com> <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com>
 <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com> <010001660c4a8bbe-91200766-00df-48bd-bc60-a03da2ccdb7d-000000@email.amazonses.com> <20180924184158.GA156847@dtor-ws> <20180927143537.GB19006@bombadil.infradead.org> <20181017000955.GG230131@dtor-ws>
 <0100016682aaae79-d1382d3d-83f8-4972-b4b9-6220367f4f65-000000@email.amazonses.com> <CE3D3608-F320-4DAB-8BEB-3EFDDB54F97E@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.10.17-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Dmitry Torokhov wrote:

> >What is a "contact" here? Are we talking about SG segments?
>
> No, we are talking about maximum number of fingers a person can have. Devices don't usually track more than 10 distinct contacts on the touch surface at a time.

Ohh... Way off my usual contexts of development. Sorry.

Ok you have my blessing.



