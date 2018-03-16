Return-Path: <kernel-hardening-return-12674-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvTorjC4hcY0XmlN2U+x+RsllwvVsin1raBXIxc01FI8wzXOtbcplZuRQYnBXdrXx2uw3TZ
ARC-Seal: i=1; a=rsa-sha256; t=1521231348; cv=none;
        d=google.com; s=arc-20160816;
        b=jKm3EQopybx5gXJTfmDKzZm26dr7R4/wUMNmBXDoRFunLtkJpZFlUBtxj73jr5QUeR
         0dnXeFjBlyh6PZE7Z8tuzZpiIgqqmumeH7sO9HsI4p/e9BPIDZ5ycX4IE/c3DbbepW7H
         6jBFqBGHQivdLDY7Em/34cXLbfzK3ceyQDJcF8G7g72YzuGsIihgJEV62TXYtWM5jalK
         WWD1Mh8+Z0u5SuNSydPJTZDa7r8do0o0G3QTOiDIpbYKhSMsZSHTxFFVW4E/2NOCeCTy
         rZah6GnH1OBC6yQED7VOmRSJsJeZpnrLsfR328QQVH7UYQ9E9N+IFtR8knknkG5qbG5F
         8rXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=G1dlswzfD1eUvKpyavG+scILvSM/Anaax1eKEYonjck=;
        b=BOqijl5hKTqdMyYKiV0tLQvRUF6+RCAodGl0fAR4iVMyPChF7xjJ7RXMsahmU44pya
         oOxzedn0MfeVid7Uyz/qDdrbgJ/fWcPDGbMPHaSmbfqN8OqUVxcr/47x+50XttEPokbt
         v/MCxpxKa8LmDfVrJIeCD5QJf5i0MXEhMzSGJbGoTPE0aLFxCMwfcokLnJAygSmG2K+S
         RMImQIpMWSuDn9mCottoWXwDkZ7vD/g0RQ4hcRtganwN77o2F9YDCMEcoYZsUwy9YZO4
         XNGQ1HqT9Y2v4qkFR/vRfhukww4WJ2EpBOZmdpd6rYx9BmNdNMXe+9VHiCsrydQNCm0z
         9/Ug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OO87X2EI;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=CT/OlC23;
       spf=pass (google.com: domain of kernel-hardening-return-12674-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12674-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OO87X2EI;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=CT/OlC23;
       spf=pass (google.com: domain of kernel-hardening-return-12674-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12674-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180316201215.GG30522@ZenIV.linux.org.uk>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com> <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk> <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <20180316201215.GG30522@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Mar 2018 13:15:27 -0700
X-Google-Sender-Auth: 5oTYQh_BXal4iSScFLe0jNGzPGc
Message-ID: <CA+55aFwxWEWya44pVAxSLM8oH8NyrOVf8QfLowSnX4WUXvC0xg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Florian Weimer <fweimer@redhat.com>, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595126681766218498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 1:12 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> That's C99, straight from N1256.pdf (C99-TC3)...

I checked C90, since the error is

   ISO C90 forbids variable length array

and I didn't see anything there.

Admittedly I only found a draft copy.

                Linus
