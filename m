Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx49dUcB1lUhTvMRGN9t2gygfRHlBXjMt53AZCXRqbFEmhpGRVkKV200XB1Uho5d1VEAK9Nks
ARC-Seal: i=1; a=rsa-sha256; t=1523062814; cv=none;
        d=google.com; s=arc-20160816;
        b=TqWLMJgq8wR2qflexOYT45XDedCS6AAGvvwfBlvd1brExLs+/JOD2EnP32Nr/6WdsS
         AM2Uon+jTC15WdEHx+kxHue/esSNnSpxidzbuH6HVhuSz/N0ye/Pirl5Gjl0pfneks6D
         2Ftj0EnroKKQNIlQvXn9A/lMoVsTZJGu9HbYuijjM7CCKZbbyMhfyflPtervS5/KKlE6
         SnI76+T7x0ikFrhjHjCDiWuShOUHGJjehfZwIDB32D2bCVUhP632wTzGkxCtJNEE34i2
         +DZ2J4zHTaLeue2G3WaJZSdZGBzuHsx6Bre4Yul5qX0Bp5wmTpv9baQfT0XvvTlM7jhB
         yo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=4Ez/rxmsvFilsi7MUvvVxusgt2bPEIgcIhthrxeuMlE=;
        b=kiVNlu4IGcalQS61GzsDPe3CGDvQ2cMsEXwPh+hPU7PoOTuwH0Kln1N5VAHxQyfvyQ
         tO/vDBY714DPAQoPLfclIt+g+UT4ShLYgrQzFQKOm9F4OVzFdA/i3xdJ75jkT/tUG6GA
         dSYGuBz+TFim19wvbwM6xtkwqc42tXo9+qYorg7NpOxHWEbbExcr70nQmnQ2xdsR+WAF
         akuJybu33wCroDa5W9OViTw4zIfV1/4e8QsA+rR+ReF0x5hoch/qlwua+aSf7milKCrd
         PMGd140Q55O2AfMfBkwSvOc6eq/2jn7lsGTRmVxlJ+XdLNAnXuMXB6Ba7T7GDJnh4pyP
         6WIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=WzWdPuAd;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=WzWdPuAd;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: Differences between builtins and modules
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Harish Jenny K N <harish_kandiga@mentor.com>,
 linux-modules <linux-modules@vger.kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, greg KH <gregkh@linuxfoundation.org>,
 jason.vas.dias@gmail.com
References: <CAKi4VA+1krn9rdBWE69DkhNZSrxJoeYzyPgvn-SUk8U0=CxFkw@mail.gmail.com>
 <54EB4C83.2000500@suse.cz>
 <CAKi4VAJwvtLaF1GTw1dg__CXHGjwOwJqUS=g5B0rbPNp1w8dDg@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4502a7e5-930f-15b6-fbef-929df29d5ef0@infradead.org>
Date: Fri, 6 Apr 2018 18:00:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKi4VAJwvtLaF1GTw1dg__CXHGjwOwJqUS=g5B0rbPNp1w8dDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1493908198172541119?=
X-GMAIL-MSGID: =?utf-8?q?1597047112700755148?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/24/2015 05:02 PM, Lucas De Marchi wrote:
> On Mon, Feb 23, 2015 at 12:51 PM, Michal Marek <mmarek@suse.cz> wrote:
>> On 2015-02-23 15:30, Lucas De Marchi wrote:
>>> This could be particularly bad if in a kernel version an option was
>>> tristate and in a new version it changed to boolean. I'm not sure if
>>> this is common to happen in kernel. Any code that did "modprobe
>>> <module>" would start to fail.
>>
>> I think it's quite uncommon (*) and also the use case for loading
>> builtin modules is not that common. I can think of:
>> 1) building the initramfs, to determine which *.ko files need to be
>>    copied to it. Since such tools are often updated for other reasons,
>>    it's not a big deal.
>> 2) Hardcoded module names in things like softdep -- hopefully not that
>>    common either, plus the kernel-provided soft dependencies can be
>>    fixed together with the change.
>>
>> Until not so long ago, the kernel would return EINVAL if passed a
>> non-existent (renamed, removed) module option to init_module, yet there
>> were no attempts at preserving the module options for compatibility reasons.
>>
>> (*) I now did a quick search:
>> $ git log -p origin/master --no-merges -- '*/Kconfig*' | grep -C3 '^-
>> *tristate' | grep '^+ *bool'
>> +       bool "Intel P state control"
>> +       bool "Intel microcode patch loading support"
>> +       bool "AMD microcode patch loading support"
>> +        bool "STI text console"
>> +       bool "Enable DDC2 Support"
>> +       bool "Enable Console Acceleration"
>>
>> That's only 6 cases in the whole git history. Maybe there are a few more
>> hidden outside the three-line context as part of larger edits, but I'm
>> sure more modules have been *removed* entirely from the kernel over this
>> period.
> 
> thanks for looking in detail into this.
> 
>>
>>
>>> My questions are:
>>> 1) should we put *all* the "modules" in the builtin index?
>>
>> You mean all *.o files that do not end up in some *.ko? That won't work,
>> because unlike module names, the names of object files are not global.
> 
> I was actually meaning anything that can have a directory under
> /sys/module/. I figure we can't easily know this.
> 
>> Plus, there was IIRC an idea to teach lsmod to print builtin modules --
>> listing all *.o would make it rather useless.
> 
> This was one of my ideas... to traverse /sys/module and give more
> information than we actually output right now, including builtin
> modules. However, given the fact that builtin modules only have an
> entry in /sys/module if they have params and now that I'm aware of the
> race between the creation of the directory and the initstate file, I'm
> giving up on this idea for now.
> 
>>> 2) should we actually check /sys/module/<modulename> to report a
>>> module as builtin or just stop doing that and rely solely in the
>>> index? Initially I'd like to do the opposite, but given the race in
>>> deciding this I'm favoring the index.
>>
>> If the race between the creation of /sys/module/<modulename> and
>> /sys/module/<modulename>/initstate is inevitable, then I'm afraid we
>> have to rely on the index.
> 
> So my current plan is to rely solely on modules.builtin to output to
> modprobe that a module is builtin. So things like "modprobe vt" will
> start to fail saying there's no vt module. Any objections here?
> 

Hi,
[sorry to resurrect such as old thread]


Would someone please answer/reply to this (related) kernel bugzilla entry:
  https://bugzilla.kernel.org/show_bug.cgi?id=118661

or I could just close it?

thanks,
-- 
~Randy
