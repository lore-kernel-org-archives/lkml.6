Return-Path: <jroedel@suse.de>
X-Google-Smtp-Source: AIpwx48ZJ+BD+idygIGt/GDRX6cJMTw4d5QnvkSMvPecOVLU6+gUG0b6tlupSjzZSJuN+gmjGXta
ARC-Seal: i=1; a=rsa-sha256; t=1524506411; cv=none;
        d=google.com; s=arc-20160816;
        b=jynkpU+0+XHRku4+NjoqZ/e9xKpIAXFW50F9kNIhVrjjtUrwiVqFr2zKy9QWh27Are
         eEGx9N8BCTDHeUBrxIWwLgIPa6GGUCob9DcJEW3XUASzzsXMFRmbHbd86jn7KobW1k1A
         0ICbv3LuvjxdkHE3fzT/peFFtoP93PaZeE+ealkheA5QmhDIvUyuCDlzwVdvYrZ7we90
         cK+2tWFcFy1SI23nHUzcNg4IkD5200cUSoCvkcIcQgDUmGE+2Aiaf+pu7Dy6kdI40L1w
         nzRtEL1A09F2k+CG/oVTY5FuBJEDsYFRYfCPdVnQW3Djr5kUGG+g1Ot2in4Y/y6ht32P
         jgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=j5S9liaOUonMLLBiXOi3inFUu9lFdKjlL8gI9/2j1KM=;
        b=SWkjMTWuzDtgYqwgH4BHUO/0LCk17NCzRkjU65yUcoLDx1LcLAhf6QZz6QX+h9jv50
         W+zSsND8+u+s1fjEFKjQOnFkfKzXZD/DkVkrG5iglS8MIEC+spq6Cs8Y//iGxtHNBN2P
         DaE7uiHAqxckcevbSALYeHypDRuFxSIq0Nf7iT1ZbSZ6REdHiKdXIg0vkd11SHT5k4O0
         zHZQUWZsN251doPDtVr2NvJw1i3rPEQFtDi3DSY+1mMJkRiE6R3L/CdAa1kh5XDddtrU
         6Pnw2o83Vvx/vI/Ho1SKkeqe6RSaslwk81GGfVKd9a40o9ee6m/TELPadj/jMigUEmFa
         UZ5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Date: Mon, 23 Apr 2018 20:00:09 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Kees Cook <keescook@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	Anthony Liguori <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>
Subject: Re: [PATCH 27/37] x86/mm/pti: Keep permissions when cloning kernel
 text in pti_clone_kernel_text()
Message-ID: <20180423180009.tubsdgxlmo56usq7@suse.de>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
 <1524498460-25530-28-git-send-email-joro@8bytes.org>
 <CAGXu5jLN_rzmfgM-Xne836ip+qMc8T1QX=mhozo3NFLNssgUfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLN_rzmfgM-Xne836ip+qMc8T1QX=mhozo3NFLNssgUfw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552515043565489?=
X-GMAIL-MSGID: =?utf-8?q?1598560834517022606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 10:06:20AM -0700, Kees Cook wrote:
> Why are there R/W text mappings in this range? I find that to be
> unexpected. Shouldn't CONFIG_DEBUG_WX already complain if that were
> true?

It actually complains, I have seen that with the base-kernel too. I
guess this is because of the different mark_rodata_ro() and
mark_nxdata_nx() implementations between 32 and 64 bit. They actually
protect different regions, I think one reason is that some regions are
not hupe-page aligned on 32 bit and doing the right protections as on 64
bit would require to split the 2M mappings into 4k mappings.

But I havn't looked deeper into that and whether it can be unified and
fixed for 32 bit. It is probably out-of-scope for this patch-set.


Regards,

	Joerg
