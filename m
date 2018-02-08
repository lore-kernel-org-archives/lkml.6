Return-Path: <tcminyard@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518105206; cv=none;
        d=google.com; s=arc-20160816;
        b=GTpudycdxXZKzVGNLnSNxCTPhuTPQCXntHvCN5pKP+MCG//AtSOwzGKADfFsSCvTkP
         IETi60Suuao1i2CGWzYlH7IUcxs3I6jbA68M1QMGUbJZtnz1YbkFl1iS+6s6um9ywrwP
         MteLCH5/q6ZTDwV9uYVF3fAr/jVe2ce2mLq1y19QEXfb5D2ad2ol0CZ+ey7cBqhxfBje
         STpa8/uX5go8R4Du4zSzOL8HtwTU5L3lR9dLvFSmy9H8Y1W6oV/liCD5tuakZTWCUo84
         QwfUDiFnp/khNxcHu4ey2HHV2+PL5Ig2rguXb21oFnp3LHWQE/3sUQBISNAEg+ijfd+I
         BMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:reply-to
         :sender:dkim-signature:arc-authentication-results;
        bh=GA0CrhXUVbrSUWB+MKLzO3oo33ZBWCiP6hZ3hvG6y3M=;
        b=PCxJ0uuEDiq2gbhN9/QciRrnac628ZtlUghj7Gf5Kwi333RNsMvDA/WbbxA5xTCjU+
         8SOA+CesWBYfmHAcYVOeqnBA2UtBuZFrX4MhNFSdLdqNOZB090YWemZ5QxfzLTX6k8Pq
         cDVEnZ39MVucfOadqefcDWdAZSU1uBK3Te5cgUPOJrQR5W8FTndQigJynMnTSuKdIel7
         CDkWnFYUk7bQrGIrplcJqSzG/j+SRCsPR6Gc4JihKqtn1Pa+siEPEIfxmrpVrOdGYmjy
         VxSRGh3pQlBcS9eC+Uuc450gwKUw3rxQJB0y/8Z4IBmr3onu5wVF5nOdq/YiSS+AVzJy
         q8Pw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jN7Yd5k6;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jN7Yd5k6;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
X-Google-Smtp-Source: AH8x226uRz+jyIdMzRtWfzkDNYiFoupANQ8baePXnVOL02YPmAVvNRFa5IU11DpAG6B3Bw/Sa/d02Q==
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
Subject: Re: ipmi_si fails to get BMC ID
To: Chris Chiu <chiu@endlessm.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org, openipmi-developer@lists.sourceforge.net,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Linux Upstreaming Team <linux@endlessm.com>
References: <CAB4CAwfino0JaeeZV1byp3aoaRrOGL1=BYgkruvxYMr6=c=5PQ@mail.gmail.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <3b812894-46a0-3c87-1b9f-468fc63ea5bd@acm.org>
Date: Thu, 8 Feb 2018 09:53:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAB4CAwfino0JaeeZV1byp3aoaRrOGL1=BYgkruvxYMr6=c=5PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591800098576670064?=
X-GMAIL-MSGID: =?utf-8?q?1591848685528145664?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/07/2018 09:01 PM, Chris Chiu wrote:
> Hi,
>      We are working with a new desktop Acer Veriton Z4640G and get
> stumbled on failing to enter S3 suspend with kernel version 4.14 even
> the latest 4.15+. Here's the kernel log
> https://gist.github.com/mschiu77/76888f1fd4eb56aa8959d76759a912bb.

This is a little strange, nobody had reported this before.  Can you 
reproduce this
at will, or was it a one-time thing?

Does the IPMI driver always take this long to issue that error, even if 
you are not
entering sleep state?

And it started with 4.14, and didn't occur before then, right?

There's a bug in the PCI utils database, I submitted a report a while 
ago.  This is
a KCS, not a SMIC interface.

It looks like the driver is trying to detect that there is a device out 
there and
there is something that kind of works, but doesn't work completely. The 
interface
specific code was all split out into separate files in 4.14.  It is 
possible the
detection code got messed up in the process.  Nothing jumps out looking at
the code differences, and I know it works on some PCI machines.

Assuming this is reproducible, can you send the the output of a pre-4.14
kernel?  If that doesn't make it obvious I may have to have access to the
machine itself.

-corey

>      As you see, it is due to "ipmi_probe+0x430/0x430 [ipmi_si]". After
> the message "ipmi_si 0000:02:00.3: There appears to be no BMC at this
> location" shows up, then it can really go to suspend w/o problem.
> Although it took around 3 mins. The IPMI device is probed from PCI and
> here's the output of lspci
> https://gist.github.com/mschiu77/33f0372be41670d8a69c97e64f833087. The
> IPMI device is "02:00.3 IPMI SMIC interface [0c07]". We get stuck here
> because we don't really know why it took so long in try_get_dev_id() /
> ipmi_si_intf.c. Any suggestion about this to help us moving forward?
> Thanks
>
>
> Chris
