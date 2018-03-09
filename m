Return-Path: <mail@maciej.szmigiero.name>
X-Google-Smtp-Source: AG47ELsw4YMhpwiVI96QY06dS73PMRtU3gZbMdvnRMs6jcdT3Y5oaR2mlrof9835RmD+UEr9h5oC
ARC-Seal: i=1; a=rsa-sha256; t=1520609656; cv=none;
        d=google.com; s=arc-20160816;
        b=ayjUomXoI35lhemMph1w+ETcVZxokIBnxttiycPxEMq0Z6QbplDpf42rabVp5cs69T
         AD+NgIxgcoOSSI89ksAnWI86sKVrQI8LEHPTg3qTI0CkIDZP8yKx5tXVQGRnX5z4BPQN
         B9u5KZHsiX2n+/FgzB5LCaCXb1qvYI0UkU2GHeiblq/naYSEMuyz2HyPRG73AolufAML
         LXOmgRdzsquuaZPk2UBdrWO7j/iuLbImsteHoRySto0+bfL/u+/KHSgULyKM+nwv9hCr
         pwJ6vB92348J+QNYSTXyThXMfS3Sw7/ZsC4lOigi38JqHJqogkn6kJ3apywZIiXDgike
         fMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:disposition-notification-to:message-id:from
         :references:cc:to:subject:arc-authentication-results;
        bh=MqszzVTXl3lKFxWnKUT1GFCLTqTICtENtPzXFrg7rgc=;
        b=akQ0bdOmkgiE2b4mmfPyHMnyM7AnhfJnH483WgkCBFb6W3UNuqbEYgEp9p6vuoXHlg
         zkNlRoEcDrdIWL5ksTLoGPSW9gPLR7/l/VnUZhkhXVAOnJMAC1AZB6+DWws8uRhQukBq
         U2SfkC5GE4oUIMQYg8z82oySxxzUF+bf92RCqi8iSB3xJAyrDV45lUFimZi28ISEuZDV
         /SNst9L0+LqNkIoHu6PWczw4zFKSxQxA72N4FFZKmTrVNSzwwBYY2mbQtgm3l9Pv7B2S
         P9o9UnHtrmbba3aTu5/AIaozzh40slDzCMpe3zo2LqwwjR5XrYsxsL1M8aaua9EZLUY3
         eK6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 37.28.154.113 is neither permitted nor denied by best guess record for domain of mail@maciej.szmigiero.name) smtp.mailfrom=mail@maciej.szmigiero.name
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 37.28.154.113 is neither permitted nor denied by best guess record for domain of mail@maciej.szmigiero.name) smtp.mailfrom=mail@maciej.szmigiero.name
Subject: Re: x86/retpoline: Fill RSB on context switch for affected CPUs
To: Andi Kleen <ak@linux.intel.com>
Cc: "Woodhouse, David" <dwmw@amazon.co.uk>, Paul Turner <pjt@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>,
 tglx@linutronix.de, Kees Cook <keescook@google.com>,
 Rik van Riel <riel@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@amacapital.net>, Jiri Kosina <jikos@kernel.org>,
 gnomes@lxorguk.ukuu.org.uk, x86@kernel.org, thomas.lendacky@amd.com,
 Josh Poimboeuf <jpoimboe@redhat.com>
References: <1515779365-9032-1-git-send-email-dwmw@amazon.co.uk>
 <f2faf9ff-8955-d8b5-c521-91b9c273128b@maciej.szmigiero.name>
 <20180309151428.GE22087@tassilo.jf.intel.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <f3834e5b-ae79-79b0-f280-fbb3871e0030@maciej.szmigiero.name>
Date: Fri, 9 Mar 2018 16:33:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309151428.GE22087@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589409875989472083?=
X-GMAIL-MSGID: =?utf-8?q?1594474790938973272?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09.03.2018 16:14, Andi Kleen wrote:
>> Shouldn't the RSB filling on context switch also be done on non-IBPB
>> CPUs to protect (retpolined) user space tasks from other user space
>> tasks?
> 
> The comment is actually incorrect. There's no risk to hit user space
> addresses if we have KPTI and NX (which is fairly universal).
> 
> It's mainly needed on Skylake era CPUs.
> 
> Should fix the comment. I'll send a patch.

But what about userspace-to-userspace attacks? - the ones that IBPB on 
context switches currently protects against (at least for high-value, or
as implemented currently, non-dumpable, processes)?

If understand the issue correctly, high-value user space processes can
be protected from other user space processes even on CPUs that lack
IBPB as long as they are recompiled with retpolines and there is no
danger of RSB entries from one process being used by another one after
a context switch.
For Skyklake this would not be enough, but there we'll (hopefully) have
the IBPB instead.

> -Andi
> 

Maciej
