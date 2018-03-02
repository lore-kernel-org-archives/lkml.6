Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELunOhX3vhqIN1S8CYjpYeQuBW4gZdeXx2U2slfINZJfYqH62ZVFfnajm2TLgbKFKHrR9h6m
ARC-Seal: i=1; a=rsa-sha256; t=1519981850; cv=none;
        d=google.com; s=arc-20160816;
        b=fKIf2r8WRLTzpqHLoofyUF6rwTtKloSVFKZgvHVFokyzdrpZH2YlaivUtrl7mepFO2
         TTumrl0rjPF+EFEs2Tu3W1bf8dVuWtuucreXmi8anMXjWT1ifBSqIvwjUmVNVU4EOVEt
         8t3rQ+0SLXJE6vEyX4BGZzhGqzyDE4IG4J1IIC/ig85kbZyUu8+D3/nQOhI6pvUP60yl
         lGlEci6llFMvQvOsDuaUDp4RqrHeJYVSPOv2wvh/mW+2kxCrXDBepxRm9Xj8fxrvWTzp
         4DH9wp6eYwFavg5K8kI8gQyt2gLNacQANTKBCJmfIR3ScVsPPVFqv1ixXbNjzwPpAdlb
         Yzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=QOGtQ77Id52+K+JjEVEiaNSdZ4g9u5jInb+GhtTO97g=;
        b=y0PL8kEcnI0V3ye/n6wHigD6JdFv3GxDHJ+CbpfKZdOHGAifG7OGgQs6v3iao9A97i
         +daDUFiSY9KGcP0vVZ/k5SLpVggUQEWwvHpxRbMPoIGBfbBeBcYTj7nIkdyN8lxab+5z
         ZWPMfFw+wL3PbjM89laBJpQ/DiK9i9bLg3qoHA98Hq+bBlNl755eUsohbCz+KDujVhce
         HWOOwlT1TsCwg+k67g56++tT2hIlBjv+DJ9KhmWtgvpgNpGc/ShTSwv4JchxTPDgs5Lr
         PlatU8Hvu2JlJ/bnaCENsJgiINlT1mEmAtZ69uypKeNxl9F4qHkuckGDAxR46bM1mw7O
         PnVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=OodDZoQk;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=OodDZoQk;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Fri, 2 Mar 2018 10:10:49 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Brian Gerst <brgerst@gmail.com>, Joerg Roedel <jroedel@suse.de>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 12/31] x86/entry/32: Add PTI cr3 switch to non-NMI
 entry/exit points
Message-ID: <20180302091049.GP16484@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-13-git-send-email-joro@8bytes.org>
 <afd5bae9-f53e-a225-58f1-4ba2422044e3@redhat.com>
 <20180301133430.wda4qesqhxnww7d6@8bytes.org>
 <2ae8b01f-844b-b8b1-3198-5db70c3e083b@redhat.com>
 <20180301165019.kuynvb6fkcwdpxjx@suse.de>
 <CAMzpN2gxVnb65LHXbBioM4LAMN2d-d1-xx3QyQrmsHECBXC29g@mail.gmail.com>
 <CA+55aFynSZgf1wnWrweODJiRw5hLkUPzFF7T8QJ7vBo=zWTfqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFynSZgf1wnWrweODJiRw5hLkUPzFF7T8QJ7vBo=zWTfqw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904588119761?=
X-GMAIL-MSGID: =?utf-8?q?1593816489024389496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 10:38:21AM -0800, Linus Torvalds wrote:
> Note that debug traps can happen regardless of TF, Think kgdb etc.
> Arguably kgdb users get what they deserve, but still.. I think root
> can set kernel breakpoints too.

But that seems to be broken right now at least wrt. to the espfix code
where there is no handling for in the #DB handler. Can userspace really
set arbitrary kernel breakpoints?


	Joerg
