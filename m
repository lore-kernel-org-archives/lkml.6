Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518203856; cv=none;
        d=google.com; s=arc-20160816;
        b=HkgCfjulsZ9b9Gu6B41ie3cC6IHSKuRYNCh5rz034PiacWkvBX+F0n1Ih6P5BPuBYh
         ZdnfaCvkDXufP7BGWOBWCwYzKk7+2+psUtjEwh+V7ALpXApWDG3Nja/NhYFwmq6wa0XK
         szy1EjbyKBvtFKKAJqdUIDLF27owrgu9iV3vxHZIIgcAEPaTRCRU+MYOOLDpMgWElgTz
         rDQrXxYsmuGdheFY5ZQDJbk45q8mkEW6hCpHjtcr52FjaebjP5o5a2ltEnl250BaZ4N4
         nOPvsOkXYKpJTq8Y9y6ocksx96nuivtXqkxKlcH4hQyleXGf6vyZ/3Htrp+CyzpiqtrN
         2D3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=I/arvUcUKIlpe1kgARr0ggMZ4cFI3JvQrAPM/Y1Yd6A=;
        b=KOnVPndYopsc3aypwRdQ30GsGknBHgP3WNr30CiyMbPDtDpP2a1RpUAjyRm2BNUC0K
         Zk98uuw8HEs6V/zqGOIzdQCoJcSs8NqPlBzgOZIKJtbd7d7Sg4DZ1borEciDMe+OogcJ
         knhzFo5aH/manoqI4WtaRuKt8H2IfPdj5s+ZyXi6LfqixlDuJPIV5bktS3Y2qPnxPptr
         P0GXqVNttiwUhJMKIhuYed/du84VT2AQm2qO2obdgmHCbb04v5gtSGbrXnoVe6VHsG51
         8uK02UtpgEfaA6xtXRpvTlLq0WNmsAG3Cu9+azq/e41OuebFM8xiDIUD6qeMBCnnY9Lq
         GKug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VqxrH8+O;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VqxrH8+O;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x227+a30Oys5WTgoCNgXjmPcVJlTaVxXg0OwUB5wcCR5elkzt2k9paavoa/9oe5sxKpfsZDdy34ANiyA2eR9GGjk=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180209190226.lqh6twf7thfg52cq@suse.de>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-10-git-send-email-joro@8bytes.org> <CA+55aFzB9H=RT6YB3onZCephZMs9ccz4aJ_jcPcfEkKJD_YDCQ@mail.gmail.com>
 <20180209190226.lqh6twf7thfg52cq@suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Feb 2018 11:17:35 -0800
X-Google-Sender-Auth: dE0jcPgjrO-d56xYOmg3SgjsQNA
Message-ID: <CA+55aFzy6ZJDUpgHY0J2_z4kODaiYPgyHuOsMGiXmrhgR3kyPQ@mail.gmail.com>
Subject: Re: [PATCH 09/31] x86/entry/32: Leave the kernel via trampoline stack
To: Joerg Roedel <jroedel@suse.de>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, "the arch/x86 maintainers" <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904027044040?=
X-GMAIL-MSGID: =?utf-8?q?1591952127088498526?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 11:02 AM, Joerg Roedel <jroedel@suse.de> wrote:
>
> Okay, I used movsb because I remembered that being the recommendation
> for the most efficient memcpy, and it safes me an instruction. But that
> is probably only true on modern CPUs.

Yeah, it's only true on the very latest uarchs, and even there it's
not perfect for small copies.

On the older machines that are relevant for 32-bit code, it's often
tens of cycles just for the ucode overhead, I think, and "rep movsb"
actually does things literally a byte at a time.

              Linus
