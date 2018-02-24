Return-Path: <miguel.ojeda.sandonis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519430468; cv=none;
        d=google.com; s=arc-20160816;
        b=S9QpOAIJSwICWxQJaggMglLIkphTuUtTZLZebKmEp3i+d2wf+ruTi78o7PrnkXIhjc
         7pDEWRlzxaCjZnWM6yrSMPPIO50liA/fyI3UgmSyw2oHruqfBss1W6QW0RP5lMEDZSXv
         njvq22Fsg4umKxggOhUnnOPlXmuhS+2SI7T17yWqm5KpAM8TuxUu83nVHyUTmZWD5l2L
         7b5wpQJWFQx/X7wYpoiIZh1Tmsw8nN0kJBInDthPqmvGnRSSI39YhhonOvfK8tglO9FX
         NXSlU4kQygjkaKY45KpO7dbfFv3xNdyEnUW4BMQZVo41U/Gf7qxibtfv3b67lKbwbNwa
         1PoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=fVzH3b+seDJbUEtOtN6/TDOtnCpwPcNbN4E0ahurEPY=;
        b=aRJp93tP4eVo5TfiOkodWkNSzxJI8MOnFpxNuBrvqQlhvtCcghnscgvN4xDVCBIqKQ
         /M91TNX32zTMJ2Rkw6e0BXd4/W7Y1knUs0yayN3LZCtgMk5nRsjxFs0/QTpsYtRj3rna
         GsYdPpMArKERSZJAm+xp6SYLCFKiWuTBTN8gkDkVAfmJur+ahI1Kv8ncPiPWzk4TMMwR
         2TsEISOHrc9jOJat4L+NpazF/MTQ1yeno4bQ5YU5tv0Rbdl2Myq2h4/3+VCoRvjsVqQs
         hGbqDl5mNXY93h3zQNpQvdMfHY7uguY/X/uuGcPYWSRh5jnNuI0WrdjCjZxT7ZufA8iT
         AG2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Jj3N/RVa;
       spf=pass (google.com: domain of miguel.ojeda.sandonis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=miguel.ojeda.sandonis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Jj3N/RVa;
       spf=pass (google.com: domain of miguel.ojeda.sandonis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=miguel.ojeda.sandonis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsPzwmNWK8ili5Bc2tURgqYd/9NCy2CmJ+qXhe0iXlRX/AVRuXCaEKh+uacBkP9k8axQMxOP/IcBIjWqUD+UUQ=
MIME-Version: 1.0
In-Reply-To: <b506b4b1-7e7d-abd6-bac2-c45e7c1e0aae@linux.intel.com>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-8-jae.hyun.yoo@linux.intel.com> <20180221182608.GA11635@roeck-us.net>
 <618f34cd-ee43-d8e4-4fb0-3c23bf03835f@linux.intel.com> <20180221214859.GA30263@roeck-us.net>
 <576a50c6-c302-654c-ceb3-aaf820b7738a@linux.intel.com> <20180222003720.GA25250@lunn.ch>
 <b506b4b1-7e7d-abd6-bac2-c45e7c1e0aae@linux.intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 24 Feb 2018 01:00:47 +0100
Message-ID: <CANiq72mjsfJRzfFmhbL7dnih_0=2pFoJDTrmi35x0yLmKrSBFA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] [PATCH 7/8] drivers/hwmon: Add a generic PECI
 hwmon client driver
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Guenter Roeck <linux@roeck-us.net>, joel@jms.id.au, andrew@aj.id.au,
	Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, jdelvare@suse.com,
	benh@kernel.crashing.org, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027891482896135?=
X-GMAIL-MSGID: =?utf-8?q?1593238322816618028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 2:29 AM, Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
> On 2/21/2018 4:37 PM, Andrew Lunn wrote:
>>>
>>> But even with this change, it still needs to use delayed creation
>>> because BMC side kernel doesn't know how many DIMMs are populated on
>>> a remote server before the remote server completes its memory
>>> training and testing in BIOS, but it needs to check the remote
>>> server's CPU temperature as immediate as possible to make
>>> appropriate thermal control based on the remote CPU's temperature to
>>> avoid any critical thermal issue. What would be a better solution in
>>> this case?
>>
>>
>> You could change this driver so that it supports one DIMM.  Move the
>> 'hotplug' part into another driver which creates and destroys
>> instances of the hwmon DIMM device as the DIMMS come and go.
>>
>> Also, do you need to handle CPU hotplug? You could split the CPU
>> temperature part into a separate hwmon driver? And again create and
>> destroy devices as CPUs come and go?
>>
>>         Andrew
>>
>
> That seems like a possible option. I'll rewrite the hwmon driver again like
> that.
>
> Thanks for the good idea. :)

By the way, in the rewrite, please try to avoid the create*workqueue()
functions (they are deprecated :).

Cheers,
Miguel

>
> Jae
