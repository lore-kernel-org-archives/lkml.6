Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520446197; cv=none;
        d=google.com; s=arc-20160816;
        b=coawRgr3o+79dakU00cNe/+nQLYImGSBxBOTxAbPShekjMZacUKnpvbnOER9Y3jN+g
         hDK+c7wohQnhDcJnPHaCF0TFdzGXHKqobRmSboJQuY+H6JHfrwpaA8YEfH3C5ONRWeL5
         uSzrupwUS9OqLLkZPYwRtD/IjiIeG1LBL53/IKJO+M8v6+3gTdfaNBEA6dhfrTLyAE2B
         +kB/NBC6/Kstj1qtEVrZIxBhA0we6QBbW+uVxJcilJCftlWuOWg+BLA+nj70nMtk8soZ
         zG+OZLFOY7KMU5z2PbKC2EjXcxun28MMtILTDjNHTvDNRjKdUyNsy+pazukHl9WpOGXN
         Fv5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=ErqPBS5FANjdsyGXmsKdh88KV7uymDFWL6R/rKOUmiY=;
        b=W3Z5lZJZSmO3SiGUVcphstZkJEwo21jIFB107aYEnF20gOa+0qMYdpXKe/ooqY7D5S
         RXvfwFpa3PJs6iFllbCvAy3go8GrLghg/Qj0onVr/auSxlIPOMxtafnxwxTfa8wiadks
         0+31dvNV1GkQXhZ+JAnXq1KIKvE3FeCsqBGcPl+zBevs03HGbj1xYPeXl8nYUBWGD3H+
         Imbt2wn0YIX2HkQLmb6s3l6B4oOD9ZYFhemOsnfEEoDLvJ+LOEmeLoXYnW9zL6dMbYE1
         5LRAyKuuJErSb5ODJ9INib11HZOYkjlKC5072EKMOm1tyfb8ch6lL8N2+T1oCjRPpU9t
         cNHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aswWMdDA;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=UTgiR0Nv;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aswWMdDA;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=UTgiR0Nv;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELsd9QzXvJiFZmxLiroOK5X/Wjwa51V7Zf8JzsqQwI6qGGp3nj9n7hJtDh0A8DxkJ/aoH3rGzeOWeC+37TphaVM=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jJaVPPjqtpOLapk8ABT93zaUoaKR-i7Ga6LVSK2OiX_tQ@mail.gmail.com>
References: <CAGXu5jJaVPPjqtpOLapk8ABT93zaUoaKR-i7Ga6LVSK2OiX_tQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Mar 2018 10:09:56 -0800
X-Google-Sender-Auth: evU0AfsZgupTNjR34z4hlfES2ZA
Message-ID: <CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com>
Subject: Re: VLA removal (was Re: [RFC 2/2] lustre: use VLA_SAFE)
To: Kees Cook <keescook@chromium.org>, Joern Engel <joern@logfs.org>
Cc: "Tobin C. Harding" <tobin@apporbit.com>, "Tobin C. Harding" <me@tobin.cc>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Tycho Andersen <tycho@tycho.ws>,
	Oleg Drokin <oleg.drokin@intel.com>, Andreas Dilger <andreas.dilger@intel.com>,
	James Simmons <jsimmons@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594301344989798721?=
X-GMAIL-MSGID: =?utf-8?q?1594303391609429432?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 9:37 AM, Kees Cook <keescook@chromium.org> wrote:
>
> Building with -Wvla, I see 209 unique locations reported in 60 directorie=
s:
> http://paste.ubuntu.com/p/srQxwPQS9s/

Ok, that's not so bad. Maybe Greg could even add it to one of those
things he encourages new people to do?

Because at least *some* of them are pretty trivial. For example,
looking at the core code, I was surprised to see something in
lib/btree.c

And that is just garbage: it uses

        unsigned long key[geo->keylen];

which looks really dangerous, but that "struct btree_geo" is internal
to that file, and there are exactly three instances of it, with 32, 64
and 128 bit keys respectively. Note that "keylen" isn't actually
number of hits, but how many long-words you need.

So in actual fact, that array is limited to that 128 bits - just 16
bytes. So keylen is at most 4 (on 32-bit architectures) or 2 (on
64-bit ones).

Using

   #define MAXKEYLEN BITS_TO_LONGS(128)

or something like that would be trivial.

AND USING VLA'S IS ACTIVELY STUPID! It generates much more code, and
much _slower_ code (and more fragile code), than just using a fixed
key size would have done.

Ok, so lib/btree.c looks more core (by being in lib/) than it actually
is - I don't see the 128-bit btree being used *anywhere*, and the
others are only used by two drivers: the qla2xxx scsi driver and the
bcm2835-camera driver in staging.

Anyway, some of these are definitely easy to just fix, and using VLA's
is actively bad not just for security worries, but simply because
VLA's are a really horribly bad idea in general in the kernel.

Added J=C3=B6rn Engel to the cc, since I looked at that lib/btree.c thing.

But that is just three of the 209 instances. Some of the others might
be slightly more painful to fix.

                  Linus
