Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519929502; cv=none;
        d=google.com; s=arc-20160816;
        b=x5G5wvy/L4q6acEzdW+XB87OpGY4Qbl7z7P5eGkwGPXXwJSE5IZ0SCn9g8LwZRmc8F
         zq3mxvUXk8agPs0J8G8DuYwvM7jLzy3Q2TdZf+qFqDAS5AJPecrXy7HWkq6N4U6gY+wb
         Liw7EO60puxf3E9F0W9rbw7cYBLF6cM7bFv2l2S8zEZy67IjjfqNE5FOSpZc1c3ZKAr/
         3GeBuNo29j/bLZXFsfyx+4h4ys1m7oVeMSAtlKw/D9/hAYeXSpojhfvOtI8TJsgoQg9u
         cnJGOWjH+g9fWn7oFh1WHqlAFaGdPhQgdMIEPgMzIGms3M1rVwRsi7bGWqvYniV5oyn7
         UrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=E/9pCxAqP3dGVNcNNKoTGFGiiXGo7HPgsxST8EX9WGc=;
        b=Q08wsW1u4uKMmFnj3Z2OtOuHxK7ocVOokVB1xStDROCMpuVEU24QaLbqU1yZ3JnX/X
         SVC/evjEnr7Nuli2/G96q0xn92QcikToqRXt9LOZJulqBznx6zPm0SF/l5mMcUDRhU4y
         Oq1aNzK7XFgkWFzaMUfcuxq7JWu8OLJM0AQFqZL/15CZ1hp7I22vZVcN3ATVR6ie8cEQ
         YPVDbpMwPWVwv/iWd2RU1cPlniAfFIutFhDw7QvJaGffhiFUXeTP1wWoA8qX/+MsOldD
         Abcb2tL4BGWccjw5yu0G59l+svrQbY6imqu86WDGWxN8dCt5U07L4tAGyTAxp5OjpWZm
         ttWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O4qiNA7t;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=AHSt6fUN;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O4qiNA7t;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=AHSt6fUN;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELvdjAxTsKf0DGtIg4uiVKIUb6R/FfapcJ50tdaiYUOwyO6pOFKeEPqHpkBcpfT4v3EuC8cwIbxNDgjn/m5ILOw=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAMzpN2gxVnb65LHXbBioM4LAMN2d-d1-xx3QyQrmsHECBXC29g@mail.gmail.com>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-13-git-send-email-joro@8bytes.org> <afd5bae9-f53e-a225-58f1-4ba2422044e3@redhat.com>
 <20180301133430.wda4qesqhxnww7d6@8bytes.org> <2ae8b01f-844b-b8b1-3198-5db70c3e083b@redhat.com>
 <20180301165019.kuynvb6fkcwdpxjx@suse.de> <CAMzpN2gxVnb65LHXbBioM4LAMN2d-d1-xx3QyQrmsHECBXC29g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Mar 2018 10:38:21 -0800
X-Google-Sender-Auth: RNdYufNge33fC6cUVDvE1AO0ids
Message-ID: <CA+55aFynSZgf1wnWrweODJiRw5hLkUPzFF7T8QJ7vBo=zWTfqw@mail.gmail.com>
Subject: Re: [PATCH 12/31] x86/entry/32: Add PTI cr3 switch to non-NMI
 entry/exit points
To: Brian Gerst <brgerst@gmail.com>
Cc: Joerg Roedel <jroedel@suse.de>, Waiman Long <longman@redhat.com>, Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904588119761?=
X-GMAIL-MSGID: =?utf-8?q?1593761598607117864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 10:24 AM, Brian Gerst <brgerst@gmail.com> wrote:
>
> The IF flag only affects external maskable interrupts, not traps or
> faults.  You do need to check CR3 because SYSENTER does not clear TF
> and will immediately cause a debug trap on kernel entry (with user
> CR3) if set.  That is why the code existed before to check for the
> entry stack for debug/NMI.

Note that debug traps can happen regardless of TF, Think kgdb etc.
Arguably kgdb users get what they deserve, but still.. I think root
can set kernel breakpoints too.

          Linus
