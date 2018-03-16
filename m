Return-Path: <luto@kernel.org>
X-Google-Smtp-Source: AG47ELt87j5mdsg7wcJf4BAklIdicAzwxcAKQ/4r4Cz0dHZtlFq4Mfaw36q4qQ7zipJQdB/uUnVB
ARC-Seal: i=1; a=rsa-sha256; t=1521233751; cv=none;
        d=google.com; s=arc-20160816;
        b=AKhZ9LE0qppjTVqv3UBrfy/A/RlIJ4yeU0QZCeRGqg4hZoFZXnrN78adE11d+shaE1
         JS/XJkPGCGc9Se4U4ceYAYvtN21sAyiUr2ujJj/M6vGl37b+9jTa756OiX0QtnUPIud6
         69Abut7rA/T7X3uUfihvfmKxWeluFtywY9reJfxVgWU9k6Dh6/jggleVjZdkHbAalX2Q
         RgKb8g7QBBIuDcoPdI7nESMFF8KV6ilbrWJjdHrY+0jIuGvIW8wb7Wvlx1InYUIn+t/h
         vX7qJgToE2cRaOy9paKOZe0xsk5bWXKz4+jrEE2tvawlIyhT3Xhdg5ruPkxv78+EEzDb
         8e1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=41yrR9n2TaFIZsjH88N0P4juVQjIGUBRRROPHTSCJhg=;
        b=YFif4YgZD8Z0tfZ+ySu023JbCM99OHgbwNPZOlhtQOY80PVmjDlvNCuCKR7OMvAFrz
         2qUNa5YW5aGk6kiVV7CoBzwsJ6YMha7zEZ5EdK8ltXiBI31yaHtDk7HLQFAg9IvXUjQ3
         XgFE8VxfoaEreYgXt8UdHBkq+yEbPaQtEFPF4TK8gbVqJkfaHgpHIUv0uMj0qncBpvSn
         AXEwkHHxt01YiD7zc4T0huK0jnytiEKIaXLGYsyaUvIKdXkjQvqlfbY5W0O7UEUh6xig
         Va9l+YB1LhDhLwE1xiDwT+0BxWynP4KTUuH9IPui6tAmMeRdPcFSMVk+CD8ZPoy4wZ6g
         AxSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4DA217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180302091049.GP16484@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-13-git-send-email-joro@8bytes.org> <afd5bae9-f53e-a225-58f1-4ba2422044e3@redhat.com>
 <20180301133430.wda4qesqhxnww7d6@8bytes.org> <2ae8b01f-844b-b8b1-3198-5db70c3e083b@redhat.com>
 <20180301165019.kuynvb6fkcwdpxjx@suse.de> <CAMzpN2gxVnb65LHXbBioM4LAMN2d-d1-xx3QyQrmsHECBXC29g@mail.gmail.com>
 <CA+55aFynSZgf1wnWrweODJiRw5hLkUPzFF7T8QJ7vBo=zWTfqw@mail.gmail.com> <20180302091049.GP16484@8bytes.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 16 Mar 2018 20:55:28 +0000
X-Gmail-Original-Message-ID: <CALCETrXt9Wc1YVO=v=+J9XaZPOX=wwUJiM30UK59_uBL1arG3w@mail.gmail.com>
Message-ID: <CALCETrXt9Wc1YVO=v=+J9XaZPOX=wwUJiM30UK59_uBL1arG3w@mail.gmail.com>
Subject: Re: [PATCH 12/31] x86/entry/32: Add PTI cr3 switch to non-NMI
 entry/exit points
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>,
	Joerg Roedel <jroedel@suse.de>, Waiman Long <longman@redhat.com>,
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
X-GMAIL-MSGID: =?utf-8?q?1595129202545603411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 2, 2018 at 9:10 AM, Joerg Roedel <joro@8bytes.org> wrote:
> On Thu, Mar 01, 2018 at 10:38:21AM -0800, Linus Torvalds wrote:
>> Note that debug traps can happen regardless of TF, Think kgdb etc.
>> Arguably kgdb users get what they deserve, but still.. I think root
>> can set kernel breakpoints too.
>
> But that seems to be broken right now at least wrt. to the espfix code
> where there is no handling for in the #DB handler. Can userspace really
> set arbitrary kernel breakpoints?
>

As far as I'm concerned, I don't try to support kernel debugger users
setting arbitrary breakpoints in the kernel entry text.
