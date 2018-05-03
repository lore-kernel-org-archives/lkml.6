Return-Path: <alexander.duyck@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525355166; cv=none;
        d=google.com; s=arc-20160816;
        b=p2g93bx2JVQjrBGtqzX0hL7X7JTeTWKh2eeuNNjMd+dGViqCCvg3pdlVYskOmDGg0i
         asZz/+kM07Ijih//3eQBUAHqJbNtcHf74bzMNMDyjMET90R684atg1gS5VMscN6HR3P9
         fpwnj7zt2CIlisI1Ws7XR7igeplVK0ZWiSwXLpMFG2jK0u0x+u6A0ATeR3dcMeAiZ3AE
         pLdOL/dcchuEGu4oNaxnrOdshrRcp6ibzim6pDhfoypGZgoTkYAKTmEPFCWOxtTd+x7D
         URaoBjHcAXjIDDHf1rlMrvOkWeopAqD7/juQTvZqbEavhnYI3aYMISy3LUO/bB7qLVzA
         nqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=9ECBiFHJ8d5e+C50YsEcb6XgHwzcDaje4JoU0TpPNOw=;
        b=C9JelkydPaNBkAOEo3X5FIcEecDUL83LoO09Gds10ew2KS71OSZHZTOkw/u8iQtQ/4
         B6g+rfoOVF+aBtlERNzi0MssON8TSb6/wQdv2W4HgYd/8ltCWlbthI/iNd+G7aaWXCQ4
         IdGQbvC28QCcHOMaGxE/c4XBjphSMkEMLkk9Vj2I5r8zsIc+fJTIUMsSFdbwARI+0any
         ofWe+J2ophJCfNRX3rqStcVKh3b1CXwdbuPAIiQ1q8UZxe3T2VQ2mgawF21pf/uPEoXO
         WdGpf6bRUZDczvOe+f1Hw2Rex6XuNmRd2jf68oXJP0FMBC4EonO2rm7KAnKZzHQSnXfV
         fNag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SwED7mwE;
       spf=pass (google.com: domain of alexander.duyck@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=alexander.duyck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SwED7mwE;
       spf=pass (google.com: domain of alexander.duyck@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=alexander.duyck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoGskE1JcleAXyrVQr61rLl6Fuk3DOrD6S6zANuTuqXv6FFm3kgG0AEQJ/qjd3KExzuRIqMNOFoEEEpp8drWtw=
MIME-Version: 1.0
In-Reply-To: <CAGM2rea3XXJ7OqGeAdexyOUb1_7W_84t5HAb_hp7Rb=TkTM86Q@mail.gmail.com>
References: <20180503035931.22439-1-pasha.tatashin@oracle.com>
 <20180503035931.22439-2-pasha.tatashin@oracle.com> <CAKgT0UdocfEm9oXZ1dkEMari8m3OA4uVTrYg45uj9fk2V41bxQ@mail.gmail.com>
 <CAGM2rea3XXJ7OqGeAdexyOUb1_7W_84t5HAb_hp7Rb=TkTM86Q@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 3 May 2018 06:46:05 -0700
Message-ID: <CAKgT0UfNBugQywBZuepUJ6deEYsSWmTw3b6VbQBJLn-kKXe7ng@mail.gmail.com>
Subject: Re: [PATCH 1/2] ixgbe: release lock for the duration of ixgbe_suspend_close()
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	intel-wired-lan <intel-wired-lan@lists.osuosl.org>, Netdev <netdev@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599413925684033451?=
X-GMAIL-MSGID: =?utf-8?q?1599450819788776675?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 3, 2018 at 6:30 AM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
> Hi Alex,

Hi Pavel,

>> I'm not a fan of dropping the mutex while we go through
>> ixgbe_close_suspend. I'm concerned it will result in us having a
>> number of races on shutdown.
>
> I would agree, but ixgbe_close_suspend() is already called without this
> mutex from ixgbe_close(). This path is executed also during machine
> shutdown but when kexec'ed. So, it is either an existing bug or there are
> no races. But, because ixgbe_close() is called from the userland, and a
> little earlier than ixgbe_shutdown() I think this means there are no races.

All callers of ixgbe_close are supposed to already be holding the RTNL
mutex. That is the whole reason why we need to hold it here as the
shutdown path doesn't have the mutex held otherwise. The mutex was
added here because shutdown was racing with the open/close calls.

>
>> If anything, I think we would need to find a replacement for the mutex
>> that can operate at the per-netdev level if you are wanting to
>> parallelize this.
>
> Yes, if lock is necessary, it can be replaced in this place (and added to
> ixgbe_close())  with something scalable.

I wouldn't suggest adding yet another lock for all this. Instead it
might make more sense for us to start looking at breaking up the
locking since most of the networking subsystem uses the rtnl_lock call
it might be time to start looking at doing something like cutting back
on the use of this in cases where all the resources needed are
specific to one device and instead have a per device lock that could
address those kind of cases.

- Alex
