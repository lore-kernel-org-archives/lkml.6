Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA58CC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F9E20676
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F9E20676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeIYFZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:25:50 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:41102 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeIYFZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:25:50 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w8ONL51P018093;
        Tue, 25 Sep 2018 00:21:05 +0100
Date:   Tue, 25 Sep 2018 00:21:04 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        jlayton@redhat.com, R.E.Wolff@bitwizard.nl,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180925002104.2da0140c@alans-desktop>
In-Reply-To: <20180905130845.GE23909@thunk.org>
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
        <20180904075347.GH11854@BitWizard.nl>
        <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
        <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
        <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
        <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
        <CAJDTihzO0Y0ZE8em2LqT-Ac-Kga7W51Uwwb2uv9oTFhkJ8vKgA@mail.gmail.com>
        <20180905130845.GE23909@thunk.org>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The other thing which you seem to be assuming is that applications
> which care about precious data won't use fsync(2).  And in general,
> it's been fairly well known for decades that if you care about your
> data, you have to use fsync(2) or O_DIRECT writes; and you *must*
> check the error return of both the fsync(2) and the close(2) system
> calls.  Emacs got that right in the mid-1980's --- over 30 years ago.
> We mocked GNOME and KDE's toy notepad applications for getting this
> wrong a decade ago, and they've since fixed it.

That's also because our fsync no longer sucks rocks. It used to be
possible for a box under heavy disk I/O to take minutes to fsync a file
because our disk scheduling was so awful (hours if doing a backup to USB
stick).

The problem I think actually is a bit different. There isn't an

	int fbarrier(int fd, ...);

call with more relaxed semantics so that you can say 'what I have done so
far must not be consumed by a reader until we are sure it is stable, but
I don't actually need it to hit disk right now'. That's just a flag on
buffers saying 'if we try to read this, make sure we write it out first',
and the flag is cleared as the buffer hits media in writeback.

All of this is still probabilities. I can do all the fsync's I like,
consume the stable data, cause actions over the network like sending
people goods, and then the server is destroyed by a power surge.
Transactions are a higher level concept and the kernel can't fix that.

Alan
