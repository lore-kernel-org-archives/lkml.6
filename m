Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1939AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A94821564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eJwQ/iA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A94821564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeI0UyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:54:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeI0UyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2IBFgxdpikHUVP20APWgKMg8S0VU5HQLIX2ciYIksPE=; b=eJwQ/iA2xWk/yfzYWaimgEEkW
        0KoO5HJZkHvPp9pUlIRHf3Bx2QosEFnY6PXjNQZrskDacdrIYC/jnD9aSk1g2S8DkN//ZS+XRPcQk
        kJ8pvynzyuJVFSwDcyAI6NwPIMEkINTNcVgAElWIAFMjzzSJA4/39ilXF/o2VbSJ1QWgz1i+2TlyO
        1rwqVuSAVCeCscY9DFw5mMLuZD6ExMhHrSUtFc8lpgY8yFQ4O0uCP3TShL/vq790dAsuojPlbCnyN
        ZzjOpuBQo6m9maAU3TL3jrY1orWPfcDo2aoJrXm99T1boU18qd6DFPxV5bFQVj/ic9jymfGqaiKJX
        7TWpiQIRw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5XOE-00013k-61; Thu, 27 Sep 2018 14:35:38 +0000
Date:   Thu, 27 Sep 2018 07:35:37 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Christopher Lameter <cl@linux.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+87829a10073277282ad1@syzkaller.appspotmail.com,
        Pekka Enberg <penberg@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
Message-ID: <20180927143537.GB19006@bombadil.infradead.org>
References: <000000000000e5f76c057664e73d@google.com>
 <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com>
 <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com>
 <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com>
 <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com>
 <010001660c4a8bbe-91200766-00df-48bd-bc60-a03da2ccdb7d-000000@email.amazonses.com>
 <20180924184158.GA156847@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924184158.GA156847@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 11:41:58AM -0700, Dmitry Torokhov wrote:
> > How large is the allocation? AFACIT nRequests larger than KMALLOC_MAX_SIZE
> > are larger than the maximum allowed by the page allocator. Thus the warning
> > and the NULL return.
> 
> The size in this particular case is being derived from a value passed
> from userspace. Input core does not care about any limits on size of
> memory kmalloc() can support and is perfectly happy with getting NULL
> and telling userspace to go away with their silly requests by returning
> -ENOMEM.
> 
> For the record: I definitely do not want to pre-sanitize size neither in
> uinput nor in input core.

Probably should be using kvzalloc then.
