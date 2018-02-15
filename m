Return-Path: <richard@sigma-star.at>
X-Google-Smtp-Source: AH8x226skE+K+kD1LD4zaz/K2YX3XWXPQUukibznoKSM/DTTMgfmSuP91wGBMZOr15PfYP1EsR8/
ARC-Seal: i=1; a=rsa-sha256; t=1518738254; cv=none;
        d=google.com; s=arc-20160816;
        b=b1bW7s2yDcwaniW6RVz7l13KhGEr0pfx0fCwPpnyjKeOeT+M9SU173qnkulRxgL6VT
         UnVLfWUfMOEmUXgDRnset/1jka1PVafrtiBPqWxLn3AyR7+Vnx8IE/IlNigKVxRIed+N
         XCy5tJFaFX81yJ0UpbdSGySC8gro+H6GKiC2c595H2dPycN9dVNsuRQ/aBT1axakhagh
         rZXvHiZVlGF9tMpnyWb4n3i4RfcZVF83jbDeSGp2tVt9+SspfUFDXweURNH4CcJcao9S
         obMNe6+Dw9dCi/UUDGWu+mFFcWmlFhz4O7ujgS8mZ9DyxNoTJ5keDbThV/iM6mjS7krh
         +1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=mOen61VHbGkB9Mzf+na23+IVNOCEM1/B0Za0RU0YHPA=;
        b=X7tOjRmyGxbXwzrAxON1T/1s7BvntJ3Y1YdDGNNzvDv+/JXz6IXI9XsGH+80VSSGDf
         BSjFREviBELigY9kh9l1mOrNBQo3RlwoQeoMp6JLLsU88fHZp7x2UXtQbGJJEadtCZw5
         Sv1CcJNjPmvUAtCeXG2QbnU7Z1L79xHn/G4fiM9Cyph+64JuST4zhgiKCZz9k2WAMO9C
         oN6GKO/SN6jKgi3Egcy1tAL/gHvfYvd/sjIu/ViEpe3vB/tf4gFpjTUDtHdTAnLGBxEG
         W+oFGx9wcbhAFq0drZnP+FAviJhdplM2UgCluosNStWEMNtQ4KDAoR9+fi7Fj+h5RT6c
         wABA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of richard@sigma-star.at designates 109.75.188.150 as permitted sender) smtp.mailfrom=richard@sigma-star.at
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of richard@sigma-star.at designates 109.75.188.150 as permitted sender) smtp.mailfrom=richard@sigma-star.at
From: Richard Weinberger <richard@sigma-star.at>
To: David Woodhouse <dwmw2@infradead.org>
Cc: mingo@kernel.org, luto@kernel.org, arjan@linux.intel.com, bp@alien8.de, dan.j.williams@intel.com, dave.hansen@linux.intel.com, gregkh@linuxfoundation.org, jpoimboe@redhat.com, torvalds@linux-foundation.org, peterz@infradead.org, tglx@linutronix.de, arjan.van.de.ven@intel.com, dave.hansen@intel.com, jmattson@google.com, karahmed@amazon.de, kvm@vger.kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com, sironi@amazon.de, linux-kernel@vger.kernel.org
Subject: Re: Revert "x86/speculation: Simplify indirect_branch_prediction_barrier()" crashes KVM guest
Date: Fri, 16 Feb 2018 00:45:29 +0100
Message-ID: <3378738.8dlq1zuRqp@blindfold>
In-Reply-To: <1518737310.7876.10.camel@infradead.org>
References: <1753460.Vme2X1QhPT@blindfold> <1518737310.7876.10.camel@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592510409183573045?=
X-GMAIL-MSGID: =?utf-8?q?1592512483856498443?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Freitag, 16. Februar 2018, 00:28:30 CET schrieb David Woodhouse:
> On Fri, 2018-02-16 at 00:12 +0100, Richard Weinberger wrote:
> > [    2.791518] Code: 8b 45 00 49 8b 7d 08 49 83 c5 18 31 d2 31 f6 ff
> > d0 49 8b 45 00 48 85 c0 75 e9 eb b1 b9 49 00 00 00 b8 01 00 00 00 ba
> > 00 00 00 00 <0f> 30 e9 68 fd ff ff 9c 58 0f 1f 44 00 00 48 89 c5 fa
> > 66 0f 1f
>=20
>   23:   b9 49 00 00 00          mov    $0x49,%ecx
>   28:   b8 01 00 00 00          mov    $0x1,%eax
>   2d:   ba 00 00 00 00          mov    $0x0,%edx
>   32:   0f 30                   wrmsr =20
>=20
> The faulting instruction is the wrmsr itself. That shouldn't happen; if
> the CPUID bit indicates that the MSR exists, then it should exist.
>=20
> The reverted patch did use the C __wrmsr() macro which contained a
> fixup for this GP# but it was just a side-effect of the "cleanup" =E2=80=
=94 it
> wasn't intentional because that really shouldn't happen. That looks
> like a qemu bug as first glance.

Hmmm, yes seems so. Just gave latest qemu a try, works fine. ;-\

Thanks,
//richard

=2D-=20
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y
