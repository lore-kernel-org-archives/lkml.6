Return-Path: <brgerst@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519928681; cv=none;
        d=google.com; s=arc-20160816;
        b=cIItRkfu0zny/S5V3VhRI307vN8G9x+/KEeU7AHFRjuLv+M4c1YSEaGn/7rN5BsG47
         TDLhvUSf7U6QBDASGbqp+pfZRz/eVaNEAi/zqiPUbel6qWd6Q+XVL9GsQc6K8TpzJPnF
         gz+gUjO+/oDRr9cPuKqkc/DzxvYGwMoKNd7m/knax3Oq2MG1rjs+T80jWRvRizJRRqND
         uh85HBV3+0L44Jn0WcmIM3cyWoDIzlbZLsMesy90Ped6B9G3rtJ4RchG49aXx9homRqE
         KtL6dPPqoRf89gQlcl7pqAkU/9bjbYQhDW7a/v6FXQpHvAXn1Jlzyq01M3MsJemobYw0
         EZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Fk3EvFVrZdFjGvOD02Dx9y/du6U8qlXs5wPTryupU7E=;
        b=IhrWEVDzF+9A8eaKLFeito7qVa+ujwS16qGTwywVx/WnePkNbuHauT7cWyj4kLAhYO
         Z4j2L0KB5WHtt0s/bSTJvVdIDavepSLbW6swI7kbE4qWrqH+1hMOYDygpUuxXnrxyWk6
         I0Kjq+b59qmF286nlFnMXWd7cUOD1LzUQ+jabYP73eVeiLMkhOZ0HSfbmGHWfpND7SYG
         xlq2p5PCfddZH3HCi4YM0xXE+9nN9BzEl1M/cAfmUzySfWS1PUZLI71tly3rmFJIy1R9
         nYhGMzWKkH6FpJLORBfHzlKcX2Y8TRebJs+m8Ei8xwc/0K2MXz9xcMjsn/h6G4VNGSkP
         QArg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dij5cWWl;
       spf=pass (google.com: domain of brgerst@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=brgerst@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dij5cWWl;
       spf=pass (google.com: domain of brgerst@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=brgerst@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELt2L5qjT0qMlvFXEZNDujvOWEVc8pyScKXsPRorQGkpLMJCtpKQiAmaekhq/HXf0l17D2tx6HvtGTrhC59Usmk=
MIME-Version: 1.0
In-Reply-To: <20180301165019.kuynvb6fkcwdpxjx@suse.de>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-13-git-send-email-joro@8bytes.org> <afd5bae9-f53e-a225-58f1-4ba2422044e3@redhat.com>
 <20180301133430.wda4qesqhxnww7d6@8bytes.org> <2ae8b01f-844b-b8b1-3198-5db70c3e083b@redhat.com>
 <20180301165019.kuynvb6fkcwdpxjx@suse.de>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 1 Mar 2018 13:24:39 -0500
Message-ID: <CAMzpN2gxVnb65LHXbBioM4LAMN2d-d1-xx3QyQrmsHECBXC29g@mail.gmail.com>
Subject: Re: [PATCH 12/31] x86/entry/32: Add PTI cr3 switch to non-NMI
 entry/exit points
To: Joerg Roedel <jroedel@suse.de>
Cc: Waiman Long <longman@redhat.com>, Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>, Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904588119761?=
X-GMAIL-MSGID: =?utf-8?q?1593760736742445641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 11:50 AM, Joerg Roedel <jroedel@suse.de> wrote:
> On Thu, Mar 01, 2018 at 09:33:11AM -0500, Waiman Long wrote:
>> On 03/01/2018 08:34 AM, Joerg Roedel wrote:
>> I think that should fix the issue of debug exception from userspace.
>>
>> One thing that I am not certain about is whether debug exception can
>> happen even if the IF flag is cleared. If it can, debug exception should
>> be handled like NMI as the state of the CR3 can be indeterminate if the
>> exception happens in the entry/exit code.
>
> I am actually not 100% sure where it can happen, from the code it can
> happen from anywhere, except when we are running on an espfix stack.
>
> So I am not sure we need the same complex handling NMIs need wrt. to
> switching the cr3s.

The IF flag only affects external maskable interrupts, not traps or
faults.  You do need to check CR3 because SYSENTER does not clear TF
and will immediately cause a debug trap on kernel entry (with user
CR3) if set.  That is why the code existed before to check for the
entry stack for debug/NMI.

--
Brian Gerst
