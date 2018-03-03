Return-Path: <kernel-hardening-return-12084-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvsAZB/I+wQh9nFjep6iX4kxMiSbztbpv5MlYbgAXcLEdApfN3r4iK8v8tENDvRsKyME7gE
ARC-Seal: i=1; a=rsa-sha256; t=1520070328; cv=none;
        d=google.com; s=arc-20160816;
        b=jh19tXPLKVEC5o8hCl55jAeGCZGuKzBOgtjscVrV9NfUtOxV1bc+qJqRahn37G5rZy
         DnMWSCRc4VCH8dg+GkvdP1Ni5w+E1hKjOI/0wVlmdfxhm01GUSmW293QrbEsKJu3q7rh
         N4hTEeHXsQa/F4wdZ+ablcaoDBw4sxZZBccu121Z/wsYyvsZFsnV5giY/4qjHsxZ/K8C
         uzg+dk3srSMLHJ72beW7uMgDEKHWELCsaOYdKx+TyYUlsNJUVY0DKefUYsnFejG2vcx1
         uPWyOPfxOTej9qKQ7HJSqnJV3dAydIMnN8h8bIa+tYwQgUSpQte6kEU+wCaXUksbd5cJ
         mkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=4jEwDT/Y+hwIw7x54+VzO7gDObYlXzLblbCTJzKKFkA=;
        b=lSHL2MN5Es9fVoD22pW9Eux3doxghrX8VoPnrAe5XQfxZhg2RkV+cwG2lsOQhWw5b7
         /Z+/rNFZYLXIiCQEOOwABs/LFRXBSi4wA8mToU6O2ZHNkgwzjF8n12WhEDVNIr9wYYn9
         /OWTY47/2IOVTHq7rZfw6I74A7B+3anZRLRxuHqXc7zwyfCcWRr7n538l5xF6j9vFuHZ
         yZtry8nqBV2o518WkhMpiuPLHvov2gBxiLqta8Rl+GSFVZ1oN6QF0epc/4nbgQd7KFqn
         4SBe6CFg8oJI0EDZY0sr+wscDtBanIRup5s24/mSnLYJYvutMRLlrypA8bGoCyfOY1WQ
         A88g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=n9+J+b5X;
       spf=pass (google.com: domain of kernel-hardening-return-12084-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12084-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=n9+J+b5X;
       spf=pass (google.com: domain of kernel-hardening-return-12084-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12084-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180301210623.GA15198@eros>
References: <1519706711-18580-1-git-send-email-me@tobin.cc>
 <1519706711-18580-2-git-send-email-me@tobin.cc> <20180301210623.GA15198@eros>
From: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date: Sat, 3 Mar 2018 11:44:26 +0200
Message-ID: <CAJ1xhMWzxX=uuf4S6=augqSgSoh7ATUd=OMotgq3RgMHd13o_A@mail.gmail.com>
Subject: Re: [PATCH 1/3] leaking_addresses: skip all /proc/PID except /proc/1
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, Tycho Andersen <tycho@tycho.ws>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593528026509077926?=
X-GMAIL-MSGID: =?utf-8?q?1593909264558235829?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 11:06 PM, Tobin C. Harding <me@tobin.cc> wrote:
> On Tue, Feb 27, 2018 at 03:45:09PM +1100, Tobin C. Harding wrote:
>> When the system is idle it is likely that most files under /proc/PID
>> will be identical for various processes.  Scanning _all_ the PIDs under
>> /proc is unnecessary and implies that we are thoroughly scanning /proc.
>> This is _not_ the case because there may be ways userspace can trigger
>> creation of /proc files that leak addresses but were not present during
>> a scan.  For these two reasons we should exclude all PID directories
>> under /proc except '1/'
>>
>> Exclude all /proc/PID except /proc/1.
>>
>> Signed-off-by: Tobin C. Harding <me@tobin.cc>
>> ---
>>  scripts/leaking_addresses.pl | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
>> index 6e5bc57caeaa..fb40e2828f43 100755
>> --- a/scripts/leaking_addresses.pl
>> +++ b/scripts/leaking_addresses.pl
>> @@ -10,6 +10,14 @@
>>  # Use --debug to output path before parsing, this is useful to find files that
>>  # cause the script to choke.
>>
>> +#
>> +# When the system is idle it is likely that most files under /proc/PID will be
>> +# identical for various processes.  Scanning _all_ the PIDs under /proc is
>> +# unnecessary and implies that we are thoroughly scanning /proc.  This is _not_
>> +# the case because there may be ways userspace can trigger creation of /proc
>> +# files that leak addresses but were not present during a scan.  For these two
>> +# reasons we exclude all PID directories under /proc except '1/'
>> +
>>  use warnings;
>>  use strict;
>>  use POSIX;
>> @@ -472,6 +480,9 @@ sub walk
>>                       my $path = "$pwd/$file";
>>                       next if (-l $path);
>>
>> +                     # skip /proc/PID except /proc/1
>> +                     next if ($path =~ /\/proc\/(?:[2-9][0-9]*|1[0-9]+)/);
>
> Perhaps the intent of this is clearer?
>
>                         next if (($path =~ /^\/proc\/[0-9]+$/) &&
>                                  ($path !~ /^\/proc\/1$/));
>
>
> thanks,
> Tobin.

Hi Tobin,

The intent is crystal clear now. Thanks.

Here's something that generates the same output as the code above:
next if ($path !~ "^/proc/(1|[^0-9]+)\$");

I'm not insisting this be given any preference whatsoever.

Thanks.
