Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbeCOOgA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:36:00 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:52932 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbeCOOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:35:44 -0400
X-Google-Smtp-Source: AG47ELuXLlnpsLDys1z5xLgZ/kt24iDVymqSOQVzJZx8F0rzRGW7bQSl9s8cLK01RdjsvDDuWV2gAQ==
From: Roman Mashak <mrv@mojatatu.com>
To: Liran Alon <liran.alon@oracle.com>
Cc: <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <shmulik.ladkani@gmail.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <yuval.shaia@oracle.com>,
        <idan.brown@oracle.com>
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info only when crossing netns
References: <be0d17cf-12d5-440c-adee-e943ccb199c9@default>
Date: Thu, 15 Mar 2018 10:35:42 -0400
In-Reply-To: <be0d17cf-12d5-440c-adee-e943ccb199c9@default> (Liran Alon's
        message of "Thu, 15 Mar 2018 05:23:41 -0700 (PDT)")
Message-ID: <85woydh0e9.fsf@mojatatu.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liran Alon <liran.alon@oracle.com> writes:


[...]

>> Overall I think it might be nice to not need scrubbing skb in such
>> cases,
>> although my concern would be that this has potential to break
>> existing
>> setups when they would expect mark being zero on other veth peer in
>> any
>> case since it's the behavior for a long time already. The safer
>> option
>> would be to have some sort of explicit opt-in e.g. on link creation to
>> let
>> the skb->mark pass through unscrubbed. This would definitely be a
>> useful
>> option e.g. when mark is set in the netns facing veth via
>> clsact/egress
>> on xmit and when the container is unprivileged anyway.
>> 
>> Thanks,
>> Daniel
>
> I see your point in regards to backwards comparability.
> However, not scrubbing skb when it cross netns via some kernel functions compared to
> others is basically a bug which could easily break with a little bit of more refactoring.
> Therefore, it seems a bit weird to me to from now on, we will force
> every user on link creation to consider that once there was a bug leading
> to this weird behavior on specific netdevs.
> Thus, I suggest to maybe control this via a global /proc/sys/net file instead.

One valid use case could be preserving a source namespace nsid in
skb->mark when a packet crosses netns.
