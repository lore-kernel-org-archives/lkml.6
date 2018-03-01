Return-Path: <dave.hansen@intel.com>
X-Google-Smtp-Source: AG47ELtYErh3n6oLRkzy6OUUM7stPplaZj2SgLisHEwb1c5r6yTLpzhQyvTDLIKKBrNJ8PyU9gBq
ARC-Seal: i=1; a=rsa-sha256; t=1519929384; cv=none;
        d=google.com; s=arc-20160816;
        b=nTmwy7bHmOrPrENsCv0vYLc/4Az27fUh2iPGBWiRyylFUfp8STLeZLKlHnVH6voe/O
         hzVRuBp8fPNI01T44db8kLhbeCDuI5zTS/GXkZOxrv9OejY1aEbECVbbMlJrcqO/9Jsr
         P7/RAxpuMh17TbY2oTyAqRLJU54zQup6qjZmyuyyo9rR9Kg/QqYxfsZPv20JE9Etdz6q
         tBmHTU1yeQ4DlABClyk/EEOmrAphFuHzm1kPSDOo21c0uTBTcu8S1jRQ08ez7edp/qNI
         19gku9AjjoKjGrDUzYo48HjFMh6m4kq2ww3d37FYDV5x87/IKmHqSfZCJVCsEWEaRjiU
         htWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=Uzzx8ygMUerSIHehoE3DQaB0V4Emt8y81bMBwzniV5A=;
        b=NiLkDg7cQ4hiDJ7WfC49s2Kb3XAVl5WLazENpeSA3NftPT1qSI8yp/RFVz5KbYJ70F
         ec7wHOK0VstE+QVMy2OzgJyYnCK5V5SyHYm9XQ+uU3l/ybqVRuL5sHsQbj5DUQDipCdT
         EXdlAfboVszu0c/YGTKn2KLFp7cmk0QwMz9hptR+THMlbTfKy17K3sPESPXdouFYR5Gt
         vF7eupbLjfpvBBdaZA/vP0xy2r3hmZd8ASYEZJVYLfaalb/yEt4bFd43miKENDtg2UI3
         I6TKGq2/BUrJdZVC6ULSrzWyK+85NjCTc5ug2b1B27XjxTXdlwR+EThZaU24TH9QjJ3Z
         MrRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dave.hansen@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=dave.hansen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dave.hansen@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=dave.hansen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="35202692"
Subject: Re: [PATCH 12/31] x86/entry/32: Add PTI cr3 switch to non-NMI
 entry/exit points
To: Brian Gerst <brgerst@gmail.com>, Joerg Roedel <jroedel@suse.de>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-13-git-send-email-joro@8bytes.org>
 <afd5bae9-f53e-a225-58f1-4ba2422044e3@redhat.com>
 <20180301133430.wda4qesqhxnww7d6@8bytes.org>
 <2ae8b01f-844b-b8b1-3198-5db70c3e083b@redhat.com>
 <20180301165019.kuynvb6fkcwdpxjx@suse.de>
 <CAMzpN2gxVnb65LHXbBioM4LAMN2d-d1-xx3QyQrmsHECBXC29g@mail.gmail.com>
Cc: Waiman Long <longman@redhat.com>, Joerg Roedel <joro@8bytes.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers
 <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 Jiri Kosina <jkosina@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 David Laight <David.Laight@aculab.com>, Denys Vlasenko
 <dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>,
 Greg KH <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
 "Liguori, Anthony" <aliguori@amazon.com>,
 Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
 Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <7727356a-7266-1166-1903-c4ebc0002299@intel.com>
Date: Thu, 1 Mar 2018 10:36:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMzpN2gxVnb65LHXbBioM4LAMN2d-d1-xx3QyQrmsHECBXC29g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904588119761?=
X-GMAIL-MSGID: =?utf-8?q?1593761473727230993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/01/2018 10:24 AM, Brian Gerst wrote:
> One thing that I am not certain about is whether debug exception can
> happen even if the IF flag is cleared. If it can, debug exception should
> be handled like NMI as the state of the CR3 can be indeterminate if the
> exception happens in the entry/exit code.

It can happen with IF cleared.  I ran into it during PTI development
more than once.  That's why the debug fault code uses paranoid_entry on
64-bit just like the NMI code.
