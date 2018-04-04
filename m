Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeDDVpd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:45:33 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:46904 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752134AbeDDVpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:45:31 -0400
X-Google-Smtp-Source: AIpwx4/n0UDfNGQcsEbbHMAeoQFueakeK0LuG6dPVb7ej6VC3BwaSAwHyQ8ytCEZIshDEzziYlTvx8+HcyCFT56fY70=
MIME-Version: 1.0
In-Reply-To: <057239cdf1c34bc69636009c9e099214@XCH-RTP-016.cisco.com>
References: <20180403215526.15934-1-jrosen@cisco.com> <CAF=yD-L8DaS7LW4SAaTRd2RPxVnfrdiVLCdWJxxaTu3Hn8ORSA@mail.gmail.com>
 <057239cdf1c34bc69636009c9e099214@XCH-RTP-016.cisco.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 4 Apr 2018 23:44:49 +0200
Message-ID: <CAF=yD-LP7RjenkfbFq+dG9XFZx2D7-JwqOeVD+1tLjgXxh8SpA@mail.gmail.com>
Subject: Re: [RFC PATCH] packet: mark ring entry as in-use inside spin_lock to
 prevent RX ring overrun
To: "Jon Rosen (jrosen)" <jrosen@cisco.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
        David Windsor <dwindsor@gmail.com>,
        "Rosen, Rami" <rami.rosen@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Mike Maloney <maloney@google.com>,
        Benjamin Poirier <bpoirier@suse.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> >    One issue with the above proposed change to use TP_STATUS_IN_PROGRESS
>> >    is that the documentation of the tp_status field is somewhat
>> >    inconsistent.  In some places it's described as TP_STATUS_KERNEL(0)
>> >    meaning the entry is owned by the kernel and !TP_STATUS_KERNEL(0)
>> >    meaning the entry is owned by user space.  In other places ownership
>> >    by user space is defined by the TP_STATUS_USER(1) bit being set.
>>
>> But indeed this example in packet_mmap.txt is problematic
>>
>>     if (status == TP_STATUS_KERNEL)
>>         retval = poll(&pfd, 1, timeout);
>>
>> It does not really matter whether the docs are possibly inconsistent and
>> which one is authoritative. Examples like the above make it likely that
>> some user code expects such code to work.
>
> Yes, that's exactly my concern.  Yet another troubling example seems to be
> lipbcap which also is looking specifically for status to be anything other than
> TP_STATUS_KERNEL(0) to indicate a frame is available in user space.

Good catch. If pcap-linux.c relies on this then the status field
cannot be changed. Other fields can be modified freely while tp_status
remains 0, perhaps that's an option.
