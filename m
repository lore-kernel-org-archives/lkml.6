Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AIpwx48FlDTOsZ+PN2p65K23FLEvOJQqOCbxjU/VT6V5PZE6PmnrCBuU9Q+j45EY4KSJ7yqzu/5c
ARC-Seal: i=1; a=rsa-sha256; t=1523901541; cv=none;
        d=google.com; s=arc-20160816;
        b=eJJohHuUzLbA6p3+/KWKeCEI9Ck5qyUAPAKuZ2JYuTCIF0wA0nnMmeK7mcoveiEVW/
         LDZk3VloUkX6pFjRrvOHnzwdf+z/i3N3B6l/mx47kWbdmd4BFThOIZXbrSJOUhQRix/M
         uvmJY2h9Gk9Qbpe9rVFr1c+5nQeUaDY/vlWnykdI72xyd75o5J1azvXb1YWT7OLdt3qC
         YvORS12yJpb09IJnB/r0cNIsvE2buT6RhpSYTL86CLBdLQuxHobwuuzGG63m32ogV1nF
         v9kT/IEN20ewFKxiLDjHouXMmBiB72pB5aHnXIyEILQe+ILgM3cZcp5ElvM/bPtqVqe+
         B+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=sAGPPRKwLgz3Y3kNX/dRXwbRyfgcXvZhG+WgvJ7wGaw=;
        b=UZY/afJHKTkQbgyn3N3t5aFvXN2PNVH8wAO9jLA/rXB3aSy6AQUiaWMMq58ZVy2S09
         HmD4LpZavEBOhcgbHq6OM7g/ThJxqIJPPcUgXNd6cGX3vHKN49EVkPFiBNcjiq0qHY1j
         MUZdOQ4/5du6FcSc7Iq1dtWyJ0WHIihOgep880pvSXDWXpIhGq9kja41+1YKlBlZYeP+
         Src/Bp6kpR27gn7DWm41nNkD5ZwezdgbfIMfk+jFmUKFTuXT6jh/fvgMrmMEhgzESJBZ
         vGBUYGeH3X+NfWcLkKWhrKTBA/mJ2aJG+yzTuEnqMypVAoyOvMZOK/h0NZXaueHsu4yu
         oDdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,459,1517904000";
   d="scan'208";a="191934707"
Subject: Re: Linux 4.17-rc1 - kernel paging errors running x86 selftests
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Shuah Khan <shuahkh@osg.samsung.com>
References: <1dcd116c-9384-6885-2d9e-f620c14bd955@osg.samsung.com>
 <CA+55aFwE1SR87+Xkkmfr+D0Yq3R0HRkdf1GdgScEfXXWN4ba6w@mail.gmail.com>
 <CA+55aFzotCBw7S=dNzyFjZkNqS7MMeKVgUoK6Dgb9gRPV_ywVQ@mail.gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <8c0a94b7-763d-16be-6401-23a3064ee55a@linux.intel.com>
Date: Mon, 16 Apr 2018 10:58:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFzotCBw7S=dNzyFjZkNqS7MMeKVgUoK6Dgb9gRPV_ywVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597922964171604923?=
X-GMAIL-MSGID: =?utf-8?q?1597926583083102202?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/16/2018 10:56 AM, Linus Torvalds wrote:
> On Mon, Apr 16, 2018 at 10:43 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I don't see *why* it would be badly set up, and that test works fine
>> for me, though.
> 
> AHHAH!
> 
> I'm wrong. I can see it too. My desktop was running 18b7fd1c93e5 (my
> kernel from Saturday, I hadn't rebooted it since), but I had 4.17-rc1
> in kvmtool and on my laptop, and I see the problem in both cases.
> 
> So this came in recently, and I bet it's the global pages series from
> Dave Hansen, although there were a few other things that came in
> during the last day.

Joerg just found and fixed something that would be poked by the x86
selftests:

https://lkml.org/lkml/2018/4/16/230
