Return-Path: <kernel-hardening-return-12675-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuLiONA8Q4dJYcCkKEEx0uIsGPFhLII08NOrFrCHhsyvDbQTOAelaqydaoMpaIHDUToa4Xh
ARC-Seal: i=1; a=rsa-sha256; t=1521231517; cv=none;
        d=google.com; s=arc-20160816;
        b=t3p8ieaNaYM935SI+vi5607Kyj3uP2Vf0WNAXfqv7CyBCFEsmBrjU6bQwwlFP13g7K
         UFPIlnCtiBmNthERTQOUwh5kPxz61fFSI8OuoX561nx/RmilPhESWAn3WVkaqKqflJNz
         /H9daLOAIhhunCiUbHa83ilwC8zBsFwvH1U5kN3xUoNFNFrSB5iclnm+12JGUrs5IhBZ
         mn7uHLQziQb6OF6VTu2G9rhLYvz1T2yu833+UA4bg65QcZvRiHVMG4ZlyPOjwc1OvPzW
         R7kGuI0Y0r/XcJ9Gcl5icFzuzc4xebzUAA+R+uNRArAkP0dAO8S9UKuqHK1LgdBmEfzt
         dPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=bILjwAwgcIMOMb54ca3XiUQ12JGhFrecglq25hOLjJg=;
        b=OsB0Ie4QqDRZ++bTV/ArdLc5K9WNL1NQcdFY4EmAHXZ1AzyTwAU80hiGoZ1yEgoA1G
         dxfkFQDowfOrdkzxTysfZSGO/OTFZFKbp3FSVG5bnzOfcPn5QOqc7PwpQExuzJBJCGhw
         w6sdYGfSeZFCCq2j3qruiOA/p4EAHVsMqYtqR9m/jaSybhMBKPqE7GzwPsxZBJ/gQDLd
         MUB/kZZzeeNdklP8EUuabNFJeC+FodMFY75Reywz9MDv3MnvhkT3DTfVUoNtrcl8DNPx
         ucxLSpR+YxSgxLE0Ls+ioOVajKKOLRenZ6E+CX/SQzA65Osa79Ar4RD0AoyBWkrNKoCy
         ioLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12675-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12675-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12675-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12675-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 16 Mar 2018 20:18:03 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
Message-ID: <20180316201803.GH30522@ZenIV.linux.org.uk>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com>
 <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk>
 <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <20180316201215.GG30522@ZenIV.linux.org.uk>
 <CA+55aFwxWEWya44pVAxSLM8oH8NyrOVf8QfLowSnX4WUXvC0xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwxWEWya44pVAxSLM8oH8NyrOVf8QfLowSnX4WUXvC0xg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: Al Viro <viro@ftp.linux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595126859359212716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 01:15:27PM -0700, Linus Torvalds wrote:
> On Fri, Mar 16, 2018 at 1:12 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > That's C99, straight from N1256.pdf (C99-TC3)...
> 
> I checked C90, since the error is
> 
>    ISO C90 forbids variable length array
> 
> and I didn't see anything there.

Well, yes - VLA are new in C99; C90 never had those...
