Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521503867; cv=none;
        d=google.com; s=arc-20160816;
        b=Ey86cDG5wyZpOa/mRHLXgG7klI3XAgjMKfDE7BAwE6rcWp6QE9RevAgCB2kfUq3nRl
         ZogwhhgFHm3I4QK6yNMRGKBYKmPJsfZQ7eZHOa2DHWBKrJn14J88XS8oUylO63batmDO
         DhcYEufZ2uVaEr+TdTZncokg4HTK+r4eH0lkR+JUvM/+w9bru/xkbbZBieww9OUoUgEU
         YcWnWlreOHaNb3RG+TM9sOzzw9plS+VPb1kp+8R7X76UEDXindGqtkV5UhseFj/JK+CO
         EeHf5rZdpKLac0SF9KbTt0SWRtJ3Feoqea3f5ShTR3O4CTzGrZUiVsyizJzkC9Y+Jczj
         mF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ysTKuyCvSaNvspZXBao4iUxzHbA0FoVr7wlYGu1tMeU=;
        b=dk+vnOxagXiTbpysI7Tmr8oa2zi/A8vS0HnA/VPqPP3+kLAiLNfu+1s98PYXCejXo8
         k/XucLdBwCibwEWF8K067Ysv7aWKh9LBqfMsTbxWDB/8lHBEu30V7SmBdRxjDX+TzgSn
         S+v3EkN20sDXPIMjDdM/PUG0wrNA4uY5Ex3vfzzDCGsevH8vBYN+yNX9djGf7KJid1Wc
         1zhCapenysRlw9CGmCpfzgCmkk51iAMUuBCYEM+2F/G+frbV/+IRGUo9O1dMcwP7gPc0
         TuRO4O27B4qFI2sSXOA0BsfC6kqH821Ya9DWYhdw/uhRMRiI5bWDRDiQ7gRBKkUVlxiT
         rbsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YBPP3qsF;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YBPP3qsF;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELv0w0Gabb/aTpOfPiLuLjNZQJrZoqGcV9znuEAYc/lNWqw8fs/10aJEoMPKRrAZBRXdWo/hibdV9A96i1iGalU=
MIME-Version: 1.0
In-Reply-To: <s5h1sggvxkn.wl-tiwai@suse.de>
References: <1521423963-24677-1-git-send-email-ruslan.bilovol@gmail.com>
 <1521423963-24677-3-git-send-email-ruslan.bilovol@gmail.com> <s5h1sggvxkn.wl-tiwai@suse.de>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Tue, 20 Mar 2018 01:57:46 +0200
Message-ID: <CAB=otbQ-5_G3Y8i5AmRcWE6KuLb_aEYEO1-ZDcNLH73ojCEE-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ALSA: usb: initial USB Audio Device Class 3.0 support
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jorge <jorge.sanjuan@codethink.co.uk>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595328661372171880?=
X-GMAIL-MSGID: =?utf-8?q?1595412438882288214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 6:28 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 19 Mar 2018 02:46:03 +0100,
> Ruslan Bilovol wrote:
>>
>> Recently released USB Audio Class 3.0 specification
>> introduces many significant changes comparing to
>> previous versions, like
>>  - new Power Domains, support for LPM/L1
>>  - new Cluster descriptor
>>  - changed layout of all class-specific descriptors
>>  - new High Capability descriptors
>>  - New class-specific String descriptors
>>  - new and removed units
>>  - additional sources for interrupts
>>  - removed Type II Audio Data Formats
>>  - ... and many other things (check spec)
>>
>> It also provides backward compatibility through
>> multiple configurations, as well as requires
>> mandatory support for BADD (Basic Audio Device
>> Definition) on each ADC3.0 compliant device
>>
>> This patch adds initial support of UAC3 specification
>> that is enough for Generic I/O Profile (BAOF, BAIF)
>> device support from BADD document.
>>
>> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>
> Most code changes look fairly straightforward, and not breaking the
> UAC1/UAC2 stuff.  So the stuff is good enough through a quick glance.
>
> I suppose it's better to merge via sound git tree.
> Greg, could you check include/linux/usb/* (and uapi) stuff and give an
> ack if it's OK?
>
> In anyway, I'll check the specs and compare with the definitions in
> this patch.

Please note that I took "A.12 CHANNEL RELATIONSHIP
DEFINITIONS" values from previous Pierre's email (they were
in a draft UAC3 spec but disappeared in the final version).
I've sent an email with my quiestions to audio-chair@usb.org but
didn't get any reply from them yet.

>
>
> And, just minor nitpicking regarding the code change:
>
> it's better to drop the parentheses in a line like below
>
>> +             if ((protocol == UAC_VERSION_1) || (protocol == UAC_VERSION_2)) {
>
> that is,
>                 if (protocol == UAC_VERSION_1 || protocol == UAC_VERSION_2) {
>
> The indentation became so deep in some functions, and it's better to
> refactor, but this can be done later once after all implementations
> are finished.

Sure, I fixed these and also kbuild test robot's complaint; if there
will no any more comments, I'm going to send v3 tomorrow.

Thanks,
Ruslan
