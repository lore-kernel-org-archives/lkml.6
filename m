Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5557C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC952086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfANOzn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:55:43 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35760 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfANOzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:55:42 -0500
Received: by mail-qk1-f193.google.com with SMTP id w204so10676561qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 06:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yRl+5VTR5AQ/tH5rQP5s+7pz+O6bgheGx6ESfnHQJcc=;
        b=p6PrILU72YpfB18sOgpa6DbYUPzr1iQl5EK0CRJDjK9EBg43wTNABmkFNehf5RzxMk
         GvmXkocu8iZdeqDW3qcjV0Q7mQkqCS2g+yxZIpcu002EXbfLV4LIQOug49B6dYYJRX9+
         +//O8wayRY+zsvT8xGTHXSMkvUd7RtSXi3keQDjRGzwHxVqLdi3xrwNpn3NvM8MFRNVW
         ++GiufAlzMvSDmMsF+VcyDvBQ+By5Zwq5t6SjgEvMo61cetnMobKHc+HyxAgq3Gl7W4g
         1wJJ2wstc3eZRk3uTyzP6tIK0w41ZhLOyqqusJ0G5GmcVk41h/efQdlL//oJZqzq0rjo
         C1+A==
X-Gm-Message-State: AJcUukeaiqHY9vkfW4v7RQphmSItF712zSRrCnQcYb2bBXIH281mUVI7
        AoKG4DY8Us+p8OjjcOl+4+xqbaMBbRyT7M1TgYSlnQ==
X-Google-Smtp-Source: ALg8bN7wuL3vpD0z8/xMcBmQETBmr25GoJitVp7EK2h3s8t3bgmG0pk3pOlOLA0vxGf5clBRdCmwjzKgFTupCUchvdM=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr21447769qkm.343.1547477741257;
 Mon, 14 Jan 2019 06:55:41 -0800 (PST)
MIME-Version: 1.0
References: <CAE5jQCch70ZSmGZeA6RQxjXhL=LjgShdj_VZAGmqUzVRPSQBZw@mail.gmail.com>
 <CAO-hwJK29V7gT3WQXLvsM5qaQgRLsgm2HAnR81vtkrrQAsCuEg@mail.gmail.com>
 <20190113230946.GA18710@amd> <CAE5jQCd+HBh3hCkQW4SR4QOHAGRS3wEuZfT4q1N6V8g9rrpBuA@mail.gmail.com>
In-Reply-To: <CAE5jQCd+HBh3hCkQW4SR4QOHAGRS3wEuZfT4q1N6V8g9rrpBuA@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 14 Jan 2019 15:55:28 +0100
Message-ID: <CAO-hwJKxRBdctUf59TJLW0G81gKXLiEoueheUxgtPO4x_=YieQ@mail.gmail.com>
Subject: Re: NULL pointer dereference when writing fuzzed data to /dev/uhid
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Roderick Colenbrander <thunderbird2k@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 3:23 PM Anatoly Trosinenko
<anatoly.trosinenko@gmail.com> wrote:
>
> > fuzzed data is hard to discriminate from valid data.
>
> Just in case it can be helpful... If it is about manually "parsing"
> descriptors to understand what is wrong by hands, then maybe Kaitai
> Struct parser generator can help. I understand it is probably not
> suited well for in-kernel binary parsing, but given a text-form
> description of a format, it can visualize parsed binary data as a
> hierarchical structure.

Well, the data and parsing is pretty straightforward (see
http://who-t.blogspot.com/2018/12/understanding-hid-report-descriptors.html
if you want to have an entertaining understanding, instead of reading
the specs). The problem is the fuzzed data looks like a correct one,
but there is garbage in the middle.

And we can not simply rely on some global CRC that would prevent
fuzzing because there is none. And the report descriptor is in the
device, so we can't upgrade all of them.

So in the end, sending a fuzz HID report descriptor is like sending a
language grammar that doesn't mean anything. The parser says, "well,
yes, why not", but sometime the rest of the drivers expect a little
bit more, and this is where it gets hard to see.

Cheers,
Benjamin

>
> Best regards
> Anatoly
>
> пн, 14 янв. 2019 г. в 02:09, Pavel Machek <pavel@ucw.cz>:
>
> >
> > Hi!
> >
> > I just want to note that while these may not be high-priority, they
> > are still security holes to be fixed.
> >
> > > > When writing the attached file to /dev/uhid, a NULL dereference occurs
> > > > in kernel. As I understand, the problem is not UHID-specific, but is
> > > > related to HID subsystem.
> > >
> > > Thanks for the report.
> > > I wanted to tell you that I started investigating the other private
> > > report you sent us, but couldn't find the time to properly come with a
> > > fix as the fuzzed data is hard to discriminate from valid data.
> > >
> > > A couple of notes though:
> > > - writing to uhid needs to be done by root. Any distribution that
> > > doesn't enforce that is doomed to have several security issues
> >
> > We want to protect kernel from root, too.
> >
> > > - we could somehow reproduce those fuzzed data on a USB or Bluetooth
> > > connection, but that would require physical access to the device, so
> > > you are doomed also
> >
> > Not neccessarily. Imagine a kiosk where PC is protected but keyboard
> > uses USB connection. If our USB stack is buggy, you are doomed... but
> > you should not be ;-).
> >                                                                         Pavel
> > --
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
