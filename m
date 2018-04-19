Return-Path: <longman@redhat.com>
X-Google-Smtp-Source: AB8JxZpW3iv7NG5YdAZJrktxXsxpBJzYXE6ylBv7FkiXR2YqCibZbWscqGOYUY5BIrlV94mmiuLs
ARC-Seal: i=1; a=rsa-sha256; t=1524167874; cv=none;
        d=google.com; s=arc-20160816;
        b=DiZSDwDaW3Y97ke3pqyH/WalTXmTJY4rRE7j1i2D08iilCDUUKgARsNdCmeweXlIhD
         n57ZWV94Wu+4TRQN3aAx0uoXJ1cetT0yyqk26PSovgVYgC1f9Lz07y8uNDHw61N4Ag6I
         7/AHv+oDdHpmHHJe3Fh2PIHrm3atJMowIZpib5AuhYsdTEwkp2qGYccMtSz/dLt7BUPc
         iee2aWnXDGtgqHXI2ywzFqmdmP7kFXA/Lw4InzzND3zlihPe26q4ejbhRxF+LIfl4opP
         UJB8FrtdOflIeuNCjr2Flp7GwnC+8HGoKp9ktuo/DC+3th+GB7nP2p8Nx9kr9FreMBGh
         e8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=/pDaCIO5SrTuP309JiiSyAChHT1YPLfWjH0p922EaPA=;
        b=wbe1o3qAF3uuw9JZ+BemJ8SlBhBMdF3jiZEYj/5wamo8fdkrQCOtQlpzadcFwnQwjI
         GtAXDeeu+CKcIJHuRxiv48adTUeTc3N1TZiBfeFjWh6TbXnkD2OumqRsYuHxbxsxQMDk
         tdtYyEWzn9m/FITkLiTYv+MGPgLG3fHGCfoezoxdtyvQsAExKhIr7/cl7j0XYSGK0YTS
         G9s94n2kJDAiGOEtHHQhsH33Dpk7wcAHQPot0h8b3pbTCtjyN6hcbOa+PVKq6Jk2g6I4
         vfLSfmY9qk+TRB9IgUFv8KJWZ3ZPNDEMkImbpKewQKRr7Bu6cY5+Gvm5Nz0PP/iXlRAv
         jrwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of longman@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=longman@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of longman@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=longman@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH] proc/stat: Separate out individual irq counts into
 /proc/stat_irqs
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
References: <1524157769-30775-1-git-send-email-longman@redhat.com>
 <20180419124319.8e329eb25234c045bf161cd5@linux-foundation.org>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2003cebf-20e8-5347-902b-6a6f5586e04a@redhat.com>
Date: Thu, 19 Apr 2018 15:57:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180419124319.8e329eb25234c045bf161cd5@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598195278130024579?=
X-GMAIL-MSGID: =?utf-8?q?1598205852838572150?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/19/2018 03:43 PM, Andrew Morton wrote:
> On Thu, 19 Apr 2018 13:09:29 -0400 Waiman Long <longman@redhat.com> wro=
te:
>
>> It was found that reading /proc/stat could be time consuming on
>> systems with a lot of irqs. For example, reading /proc/stat in a
>> certain 2-socket Skylake server took about 4.6ms because it had over
>> 5k irqs. In that particular case, the majority of the CPU cycles for
>> reading /proc/stat was spent in the kstat_irqs() function.  Therefore,=

>> application performance can be impacted if the application reads
>> /proc/stat rather frequently.
>>
>> The "intr" line within /proc/stat contains a sum total of all the irqs=

>> that have happened followed by a list of irq counts for each individua=
l
>> irq number. In many cases, the first number is good enough. The
>> individual irq counts may not provide that much more information.
>>
>> In order to avoid this kind of performance issue, all these individual=

>> irq counts are now separated into a new /proc/stat_irqs file. The
>> sum total irq count will stay in /proc/stat and be duplicated in
>> /proc/stat_irqs. Applications that need to look up individual irq coun=
ts
>> will now have to look into /proc/stat_irqs instead of /proc/stat.
>>
> (cc /proc maintainer)
>
> It's a non-backward-compatible change.  For something which has
> existing for so long, it would be a mighty task to demonstrate that no
> existing userspace will be disrupted by this change.
>
> So we need to think again.  A new interface which omits the per-IRQ
> stats might be acceptable.

OK, how about a new /proc/stat2 file that is the same as /proc/stat
except that it omits per-IRQ stats. BTW, do you have any suggestion for
a better name?

> Or, conceivably, a new /proc knob which disables the per-IRQ stats in
> /proc/stat.  That would allow operators to opt in to this disabling and=

> would avoid the need to alter
> whatever-application-it-is-that-is-having-trouble.  This seems a bit ug=
ly
> though.
>
> Also, the changelog is rather vague.  "application performance can be
> impacted".  Well, *are* applications impacted?  What is the real-world
> performance gain which this change provides, in a real-world workload?

Will clarify that in the next version.

-Longman
