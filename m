Return-Path: <chiu@endlessm.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518145789; cv=none;
        d=google.com; s=arc-20160816;
        b=tQHYcwmD+wGUVGzWhdnn/Rnk+rFGbEOup4zXYOVme1Iec52Lc01FVfAhoWEjUv5VQT
         icQAqVq7d0qD+SvCg/M3hdtSOKEIej9rr8mzI7mmOBgdKYX198rm4OnFKgrxlzBzy6n0
         n8GelVMVnQq0IGbhCoEZ6TIjxHGx+9YzZPMAiXzpw9rrVTC1OGG9FWViosyQ4X/n+Ifr
         qpGtOZ7Wdl4mV9Y+YL7PiHa45pLN0dTgq2AYy9YHaXyK6LHwtV7jqKBA8pQJdFZspXjJ
         f9islH2Axfvh80sL2kv1HAHBNMq+BiPEVSvj4Cmvoy909OxL7YgEPqwax7sUfjGXWSi/
         B2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ndR7i6zij4HSeMYLhP7GL4759zSQxs3Ootmhf9ntDTY=;
        b=ZmKHqmvekpjP0KK/alJSxgEAF/RgiFXfKVIwZh0yU/g9fxzBHn6RXjX51z1U8A5tfQ
         CpqBpLCSbUjwDdnoG7RQneN0aAcm4WtJ9mpcBMRTS4c4J6CEzpGcMiDvedjuzW8GTKTv
         snYX52e30RmgB3zxF5lsTwGSyAm8shLte92FyrMyd2Z406fCBU7VSaijla9/HwZOw8Ge
         NlnCTmdkf/ocaheL8xQ7Z1gC1ZTVPeIf9L7GQhKPivWDAKjum19XWtDApH4iLk94WePm
         2t7LokJ7uH14t9A4K2x0+QHMjRNv+y7heaqmnGT2/EQD6hgOyLuejwkTG8kc/dJqdCcO
         1M8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@endlessm-com.20150623.gappssmtp.com header.s=20150623 header.b=lZ7P7eNV;
       spf=pass (google.com: domain of chiu@endlessm.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=chiu@endlessm.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@endlessm-com.20150623.gappssmtp.com header.s=20150623 header.b=lZ7P7eNV;
       spf=pass (google.com: domain of chiu@endlessm.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=chiu@endlessm.com
X-Google-Smtp-Source: AH8x225LtGJCijLG1oiB9OuObPTESH2cnqVdTfCSVvLDzXvbXqyOvpdcfhPcAqMk8oydx3xQnOYiCHGWsvlvbwFPnJo=
MIME-Version: 1.0
In-Reply-To: <3b812894-46a0-3c87-1b9f-468fc63ea5bd@acm.org>
References: <CAB4CAwfino0JaeeZV1byp3aoaRrOGL1=BYgkruvxYMr6=c=5PQ@mail.gmail.com>
 <3b812894-46a0-3c87-1b9f-468fc63ea5bd@acm.org>
From: Chris Chiu <chiu@endlessm.com>
Date: Fri, 9 Feb 2018 11:09:48 +0800
Message-ID: <CAB4CAwdTa=A78hr4ZrHNpCwJBo3-kmdK8nq1ZS_k0VanPm0dMw@mail.gmail.com>
Subject: Re: ipmi_si fails to get BMC ID
To: Corey Minyard <minyard@acm.org>
Cc: Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
	openipmi-developer@lists.sourceforge.net,
	Linux Kernel <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591800098576670064?=
X-GMAIL-MSGID: =?utf-8?q?1591891238953653106?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 8, 2018 at 11:53 PM, Corey Minyard <minyard@acm.org> wrote:
> On 02/07/2018 09:01 PM, Chris Chiu wrote:
>>
>> Hi,
>>      We are working with a new desktop Acer Veriton Z4640G and get
>> stumbled on failing to enter S3 suspend with kernel version 4.14 even
>> the latest 4.15+. Here's the kernel log
>> https://gist.github.com/mschiu77/76888f1fd4eb56aa8959d76759a912bb.
>
>
> This is a little strange, nobody had reported this before.  Can you
> reproduce this
> at will, or was it a one-time thing?

It can be reproduced on each reboot.
>
> Does the IPMI driver always take this long to issue that error, even if you
> are not
> entering sleep state?
>
Yep, it will always print "ipmi_si 0000:02:00.3: There appears to be
no BMC at this
location" few minutes after boot.

> And it started with 4.14, and didn't occur before then, right?
>

I haven't try pre-4.14 kernel. Will do that and update here.

> There's a bug in the PCI utils database, I submitted a report a while ago.
> This is
> a KCS, not a SMIC interface.
>
> It looks like the driver is trying to detect that there is a device out
> there and
> there is something that kind of works, but doesn't work completely. The
> interface
> specific code was all split out into separate files in 4.14.  It is possible
> the
> detection code got messed up in the process.  Nothing jumps out looking at
> the code differences, and I know it works on some PCI machines.
>
> Assuming this is reproducible, can you send the the output of a pre-4.14
> kernel?  If that doesn't make it obvious I may have to have access to the
> machine itself.
>
> -corey
>
>
It's an All-in-One machine so I think it would be difficult for
shipment. I'll see what
I can do. Thanks for help.

Chris

>>      As you see, it is due to "ipmi_probe+0x430/0x430 [ipmi_si]". After
>> the message "ipmi_si 0000:02:00.3: There appears to be no BMC at this
>> location" shows up, then it can really go to suspend w/o problem.
>> Although it took around 3 mins. The IPMI device is probed from PCI and
>> here's the output of lspci
>> https://gist.github.com/mschiu77/33f0372be41670d8a69c97e64f833087. The
>> IPMI device is "02:00.3 IPMI SMIC interface [0c07]". We get stuck here
>> because we don't really know why it took so long in try_get_dev_id() /
>> ipmi_si_intf.c. Any suggestion about this to help us moving forward?
>> Thanks
>>
>>
>> Chris
>
>
>
