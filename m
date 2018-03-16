Return-Path: <kernel-hardening-return-12676-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtuBZOAfqSDgRPVdlC+4ogN4wv3EBGdsC/NGx+q8hv3I8Shmit+zmAtwYf75FOq4IDMudk6
ARC-Seal: i=1; a=rsa-sha256; t=1521231582; cv=none;
        d=google.com; s=arc-20160816;
        b=o8kzsba81A+DMZslcKD+sG4GFks8FuhtvPw5avKQUBZvg16ScYgKl0VL59zNP8vVzw
         znCdmjTxsmP+SQTvRvFFRP5Y5DMyvAtSWBaV6+dfdaX7KHeHKoHWYFE8+Xr5yZE+WH98
         xy+f9KaVdFkDzfWSl/D8FavaCvayd6Y4nXD2Glsm0qhRy4auJNGeYleWBRDRlwV4lviX
         XppJqcgCdz/zmkcQ82g5PK5xDVmc6z8vtZJ0N9ArYZD3L0Kz4ppJV5ZBFZ8/zhCmDvPN
         p3jqoayzoUUUQ7s1gw8yGWHqlaZ7QnCO06Q5ILlo2UIvJqNs9kq0o/DYQzpnyQU/XEE+
         WxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=xRyUIWsLZQH4u6jCYEsy8feys5seDvlptq7ujQkRPDI=;
        b=LgWkFsckh7zRQ+yg7x+9DLN8MTo3+9GKMtmGgzUIcdMh1tW2eiW2VaqAqjHF+GV7JE
         KYFKo9v2ubwh8L41avq+PJqysZFI5UnosR3BeLiAgZNIHLRVNy3dJGAXZuljxQDR2mwm
         BP8OSt6hVXYN8chrZ9AmiX+EU0KhuMWxzm2fkXWGRX25Kd9kdyWWvmvkO64lJWLk7jLd
         GhLpX5lenX4QbJ0h8P+x+NslD1/A2cmdGHd3B06fODZ4MnqTBi2kxeIyk7Pi4qjK+gCb
         5ozoqVrC1DpPCeTIg5NEJ9yENZdQ5NeaJEMNhGYmzkHCAP4YxfBiThuVLs03593c4xUe
         QS1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gH9H/K7V;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=OOIwvVTO;
       spf=pass (google.com: domain of kernel-hardening-return-12676-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12676-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gH9H/K7V;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=OOIwvVTO;
       spf=pass (google.com: domain of kernel-hardening-return-12676-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12676-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFxLpdfyfTqhkHQoedQuqTcLRw3bYOgyz1s0eRW6cBmFTA@mail.gmail.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com> <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk> <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <CANiq72mjDQWsPG60JqfuLSY-6SDzB4goP4n35XZxc8bfFx1NDg@mail.gmail.com> <CA+55aFxLpdfyfTqhkHQoedQuqTcLRw3bYOgyz1s0eRW6cBmFTA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Mar 2018 13:19:19 -0700
X-Google-Sender-Auth: zDnxcbBvrFBbrRSFvObEM97ii74
Message-ID: <CA+55aFztfTTVJG3ANetGh_9-iJg=gUeKt4wbibTy=c5DuH_udA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Florian Weimer <fweimer@redhat.com>,
	Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595126928292535726?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 1:14 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It does not work with gcc-4.1.x, but works with gcc-4.4.x.
>
> I can't seem to see the errors any way, I wonder if
> __builtin_choose_expr() simply didn't exist back then.

No, that goes further back.

It seems to be -Wvla itself that doesn't exist in 4.1, so the test
build failed simply because I used that flag ;)

               Linus
