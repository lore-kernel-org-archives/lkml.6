Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeCYWBK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:01:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39092 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeCYWBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:01:08 -0400
X-Google-Smtp-Source: AG47ELvHfONtHy9k3M/nnrqgy2sIDy7L2OxP7AtFxDDnx00fCTRkH8jvONHSxfxc4CCv39HfGH09cw==
From: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH 2/2] send-email: supply a --send-delay=1 by default
References: <20180325182803.30036-1-avarab@gmail.com> <20180325182803.30036-3-avarab@gmail.com> <20180325210132.GE74743@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180325210132.GE74743@genre.crustytoothpaste.net>
Date: Mon, 26 Mar 2018 00:01:05 +0200
Message-ID: <87605jyfvi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Mar 25 2018, brian m. carlson wrote:

> On Sun, Mar 25, 2018 at 06:28:03PM +0000, Ævar Arnfjörð Bjarmason wrote:
>> The earlier change to add this option described the problem this
>> option is trying to solve.
>>
>> This turns it on by default with a value of 1 second, which'll
>> hopefully solve it, and if not user reports as well as the
>> X-Mailer-Send-Delay header should help debug it.
>>
>> I think the trade-off of slowing down E-Mail sending to turn this on
>> makes sense because:
>>
>>  * GMail is a really common client, git.git's own unique authors by
>>    %aE are ~30% @gmail.com, ~20% for linux.git. That's just patch
>>    submitters, my guess is this it's much more common among those who
>>    mostly read the list, and those users who aren't using mu4e / mutt
>>    etc. anyway.
>>
>>  * There's really no point in having this feature at all if it's not
>>    made the default, since the entire point is to be able to read a
>>    list like the git ML or the LKML and have patches from others show
>>    up in order.
>>
>>  * I don't think anyone's really sensitive to the sending part of
>>    send-email taking longer. You just choose "all" and then switch to
>>    another terminal while it does its thing if you have a huge series,
>>    and for 1-3 patches I doubt anyone would notice this anyway.
>
> I'm not sure that this is going to have the effect you want it to have.
> Let me give an example to demonstrate why.
>
> If I send a series to the list, in order for this to work, you need my
> SMTP server (Postfix) to essentially send mails slowly enough to
> vger.kernel.org (ZMailer) that it doesn't batch them when it sends them
> to GMail.  The problem is that with my mail server, due to filtering and
> such, already takes at least a second to accept, process, and relay
> submitted messages.  vger still batched them and delivered them back to
> me out of order.  This will be even worse with large series.
>
> You are also assuming that my mail server will not have batched them and
> delivered them out of order, which it might well do, since Postfix uses
> a connection cache to machines that don't do STARTTLS (which, much to my
> annoyance, vger doesn't offer).
>
> In short, I don't think this is going to be especially helpful because
> it won't change the status quo for a lot of senders.  You'd have to
> insert some significant delay in order to get the effect you desire, and
> even then things could still be delivered out of order.

Good point. I also see that (via git log --author=Ævar --grep='^\[PATCH
') that this series itself arrived out of order (0 -> 2 -> 1), but I
don't know to what extent public-inbox itself might be batching things.

It would be interesting to get reports from other GMail users as to what
order these mails were shown in, but I think as soon as they're replied
to that info's gone, at least for 2/2, which is the potentially out of
order one in this case.

In general I realize that this won't be a general solution that'll work
in all cases. E.g. I have a local SMTP on my laptop, if I'm on a plane
it wouldn't matter if the delay was 2 hours, it would be batched up
locally and sent all at once.

I was hoping we could find some sweet spot where the systems along the
way (common smtpd's, majordomo, public-inbox's git repo) would as a
result get this right most of the time for the purposes of appeasing
this really common mail client, but maybe that's not going to work out.
