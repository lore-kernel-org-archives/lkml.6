Return-Path: <kernel-hardening-return-13041-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49XqRWB4BEqfss77KM20ovrxoeZ1QeGjN8ZKgDV+sOXxWQx0ZgmlO2BpFs7m/qjYBACIdK1
ARC-Seal: i=1; a=rsa-sha256; t=1524069507; cv=none;
        d=google.com; s=arc-20160816;
        b=HVXO4W+BslOEvUf/n4Fu8dsjo8XLBV8wD9tDj0AYl7Hd2v1XyWt0AXxJHhC1ad99b4
         lQN7Vaa7L+EaQsrT2BQMjY8bLSxGf0qM+mNl2K8DfPkJD6/S4bLv1ARkKAgnaP2VA5d4
         5IMKgqdden+5iaYi3/oFhAAdOMRYhZs8sHRQrBdFDisWkEOXLUEa5ijEvtxvDXjINPFt
         KR9btmvwXlaADkOgNX8Zrr1N6slf5k6Agcfm0HA+Kwpu3Nq97H2DZ4OImGc2wN86ouA+
         Who/15oFPk5ElycptnPMa2vndfiSTgEPY2GhJHP2qKkqbeJPmSlGuld5uhWfG419+xcA
         vsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=3QUj4WEjRtjUW5fPTaWrQRKfHpEgCk+DgF5WdtC+nbE=;
        b=bzylrhrd0hcdGX5BOFMShaQ415DtP9PU7lIpYT8eGygX+ZsdDhp0RZ7XPGiOhdY1ok
         DmhtM2BbdQf3ADmDp+7g3XloorfE96k8tE7ykso0HvCclwdHDYO9K1nwNQ1LtmKkKPSp
         d322VZ49kBw6palKDIKqEkfm+C0btAdqA/nkp4WU1nk0Ti8qXPBINPGxmKDkk3AkCFKK
         LSuBfPggA3EU4tGIpzx3PKK5c+zxsASQArTy/46z0J88M3sLJ1tclSOMQXCnk+IGe/P5
         EZpt4j+TPjUWTngzewWCY+7R3s/Cu8isHKpySGTfBLBbnE5I4OEpHajllEHRHiacIrIa
         v7UA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=NA38PUB0;
       dkim=pass header.i=@chromium.org header.s=google header.b=JAVTmRIm;
       spf=pass (google.com: domain of kernel-hardening-return-13041-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13041-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=NA38PUB0;
       dkim=pass header.i=@chromium.org header.s=google header.b=JAVTmRIm;
       spf=pass (google.com: domain of kernel-hardening-return-13041-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13041-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAGXu5j+dc=y+1M=unyvEvCo+QrX3MCW5Hm=2Z+q0a6iC3pgN6g@mail.gmail.com>
References: <20180221021659.GA37073@beast> <20180221102933.GD2231@dhcp22.suse.cz>
 <20180221125914.dc95830eada5fb958c13e36b@linux-foundation.org> <CAGXu5j+dc=y+1M=unyvEvCo+QrX3MCW5Hm=2Z+q0a6iC3pgN6g@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 18 Apr 2018 09:38:07 -0700
X-Google-Sender-Auth: 8Ryd9NbXHNyeoZQQO4H5VnsvAlA
Message-ID: <CAGXu5j+PmPUg9-gx3769X+kjXJo+markuPA3FwredM7jU8CdXg@mail.gmail.com>
Subject: Re: [PATCH v2] fork: Unconditionally clear stack on fork
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Laura Abbott <labbott@redhat.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592975104699087561?=
X-GMAIL-MSGID: =?utf-8?q?1598102707738489381?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 6:15 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Feb 21, 2018 at 12:59 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
>> On Wed, 21 Feb 2018 11:29:33 +0100 Michal Hocko <mhocko@kernel.org> wrote:
>>
>>> On Tue 20-02-18 18:16:59, Kees Cook wrote:
>>> > One of the classes of kernel stack content leaks[1] is exposing the
>>> > contents of prior heap or stack contents when a new process stack is
>>> > allocated. Normally, those stacks are not zeroed, and the old contents
>>> > remain in place. In the face of stack content exposure flaws, those
>>> > contents can leak to userspace.
>>> >
>>> > Fixing this will make the kernel no longer vulnerable to these flaws,
>>> > as the stack will be wiped each time a stack is assigned to a new
>>> > process. There's not a meaningful change in runtime performance; it
>>> > almost looks like it provides a benefit.
>>> >
>>> > Performing back-to-back kernel builds before:
>>> >     Run times: 157.86 157.09 158.90 160.94 160.80
>>> >     Mean: 159.12
>>> >     Std Dev: 1.54
>>> >
>>> > and after:
>>> >     Run times: 159.31 157.34 156.71 158.15 160.81
>>> >     Mean: 158.46
>>> >     Std Dev: 1.46
>>>
>>> /bin/true or similar would be more representative for the worst case
>>> but it is good to see that this doesn't have any visible effect on
>>> a more real usecase.
>>
>> Yes, that's a pretty large memset.  And while it will populate the CPU
>> cache with the stack contents, doing so will evict other things.
>>
>> So some quite careful quantitative testing is needed here, methinks.
>
> Well, I did some more with perf and cycle counts on running 100,000
> execs of /bin/true.
>
> before:
> Cycles: 218858861551 218853036130 214727610969 227656844122 224980542841
> Mean:  221015379122.60
> Std Dev: 4662486552.47
>
> after:
> Cycles: 213868945060 213119275204 211820169456 224426673259 225489986348
> Mean:  217745009865.40
> Std Dev: 5935559279.99
>
> It continues to look like it's faster, though the deviation is rather
> wide, but I'm not sure what I could do that would be less noisy. I'm
> open to ideas!

Friendly ping. Andrew, can you add this to -mm?

-Kees

-- 
Kees Cook
Pixel Security
