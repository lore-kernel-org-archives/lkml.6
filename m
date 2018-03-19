Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521502337; cv=none;
        d=google.com; s=arc-20160816;
        b=W9LiavbD3HwmxwKEGdnzWQwc3OF4r0q0FAoOJgxIfsUbHe6LRMX6D7K84nrvswKBlR
         0u0SqCV3HtoTbRF5r5YV0BthJ6Gx9Yk9+Cq9gQnJvXs3bDDwFBYGXcsjaJbdWIPw8pl5
         ZkK1lJGzf60zBiaJxmvLGVs7+WgQvQetGI7AYgaLCySuOXHEv3bq4qzi3z1vu6W8fiPn
         89yCQX5MKtuXvueWbosUrWUpOPPRp4i4rcZxyLjhJQJZMflqzvYjVZsfOx05VO458Hfx
         1eK4A6+vt4H+LULCOEuM4ETimIlqwkyS3BKnmlVd0cw7wT+/I3k1aTk5of6hk9dCcl11
         62PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=EUVL9Bxc19Zmdf1zgW6RhsP68hL1N48Cb3dQSL+9eO0=;
        b=JR9Yn3E9+amlwuTkAKVEomD+Cx2B/VfHsijyLfTtfzHRc/vg7XOwBn9zkop47iJ9gh
         BeGNCSvEvGyMswQcdN7ZhgqbTLTpdni/C3f59PFJektZm4xeEvWlv5PVJOVsNu/iRlmb
         jj6yFkyJrgLGc6AqyU4/09GRVCT117/UtdsSvy+LLSogCcrI7zo4pPDQj+lvI8gPbjDy
         1fj+X8X9fORncgKIfottHy38j46K/zt+ynGcZ+vDs6ZeqCWBBW+P5rx7f4L5Fyr9qLst
         5MPJjIeUn6MSl7nMyqPCb6EO8H45jYdDs+DY/EUxGRYyroBDmn7YiZItJShZ7wG6gtNQ
         mddA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ONk3sTLD;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ONk3sTLD;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtsobUwN12N7V8U627EFZ+JVmSsxqo8W8s2dujIKe0SJRnVLBfSH7XPOsnlERmLXriGu4Cio2G3/c4Tp4jgvx4=
MIME-Version: 1.0
In-Reply-To: <s5hd100vzl2.wl-tiwai@suse.de>
References: <20180319061108.24178-1-k.marinushkin@gmail.com>
 <20180319074019.GA30688@kroah.com> <s5hzi34o6ai.wl-tiwai@suse.de> <s5hd100vzl2.wl-tiwai@suse.de>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Tue, 20 Mar 2018 01:32:16 +0200
Message-ID: <CAB=otbRC+5CxFAW2doYDps9p14dJXRNSw1-XyW7iqb=NvsMNiQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix parsing descriptor of UAC2
 processing unit
To: Takashi Iwai <tiwai@suse.de>
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
	Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Felipe Balbi <felipe.balbi@linux.intel.com>, Philippe Ombredanne <pombredanne@nexb.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595345312154569888?=
X-GMAIL-MSGID: =?utf-8?q?1595410834598519409?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 5:45 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 19 Mar 2018 08:47:49 +0100,
> Takashi Iwai wrote:
>>
>> On Mon, 19 Mar 2018 08:40:19 +0100,
>> Greg Kroah-Hartman wrote:
>> >
>> > On Mon, Mar 19, 2018 at 07:11:08AM +0100, Kirill Marinushkin wrote:
>> > > Currently, the offsets in the UAC2 processing unit descriptor are
>> > > calculated incorrectly. It causes an issue when connecting the device which
>> > > provides such a feature:
>> > >
>> > > ~~~~
>> > > [84126.724420] usb 1-1.3.1: invalid Processing Unit descriptor (id 18)
>> > > ~~~~
>> > >
>> > > After this patch is applied, the UAC2 processing unit inits w/o this error.
>> > >
>> > > Fixes: 5e1ddb481776 ("UAPI: (Scripted) Disintegrate include/linux/usb")
>> > > Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
>> > > Cc: Mark Brown <broonie@kernel.org>
>> > > Cc: Jaroslav Kysela <perex@perex.cz>
>> > > Cc: Takashi Iwai <tiwai@suse.com>
>> > > Cc: Thomas Gleixner <tglx@linutronix.de>
>> > > Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
>> > > Cc: Philippe Ombredanne <pombredanne@nexb.com>
>> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > > Cc: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>> > > Cc: linux-kernel@vger.kernel.org
>> > > Cc: alsa-devel@alsa-project.org
>> > > ---
>> > >  include/uapi/linux/usb/audio.h | 4 ++--
>> > >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> >     Cc: stable <stable@vger.kernel.org>
>> >  perhaps?
>>
>> Yes, it deserves.  But I'd need to double-check the UAC2
>> specification.  It's interesting that such a basic thing hasn't hit
>> until now.  Maybe just because it's a fairly minor feature.
>
> ... and the patch looks correct, after confirming the UAC2 spec.
> Now I applied it, with a minor correction of Fixes tag, which actually
> was introduced by 23caaf19b11e ("ALSA: usb-mixer: Add support for
> Audio Class v2.0"), and adding Cc to stable.
>

I also checked UAC1/UAC2 spec and the patch looks good.
What's interesting it seems nobody faced this issue (after searching
ower Internet can't find any mention) which was present from the
beginning of UAC2 driver implementation.

Thanks,
Ruslan
