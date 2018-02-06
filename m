Return-Path: <luto@kernel.org>
X-Google-Smtp-Source: AH8x2264dXRTEWXSKtVKTc8EBXSaTkD0JNV3/WXgGHj62nQ1c/3TDiDzjo3Vy4FkqtYsf525LpqR
ARC-Seal: i=1; a=rsa-sha256; t=1517950200; cv=none;
        d=google.com; s=arc-20160816;
        b=N2jjdsDoYtqmEaqcBVkXygiSAs/ok/zIEFN8noZVjYEGUQ6IAWNdqP9BPbQI35jyMw
         GHrJ8Q3FhAVsCPnwuOuLhd1xUivx6ln10Ik5SYhlVW7GO0EOqif4oMffrEn+N9ioieSf
         oRFSKFyHtR8zu5Cy61GLz53e1A8iOeDeNbxrSm2r2FtkW2OSd6+htyX6HrmXtl2kCZGp
         fvdeEY7NeQZZfpzdxCm/T0iIzS+J+0QJfsnnpErNtaAyyFU1sivCSKQFbya5IpVT+cCt
         sajBHrvl7IQN4hCGt1zYmKFuTbEhqVy4LSC0M4H0Z2pG5PXBNduV3JLVuhQOitW5Ppri
         QEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=nqTrhbuLlL3a8qX2YbigiL7uDL3wnGGFW4MF2X3vcMs=;
        b=bFc91TS5FLoBTE3rI5weLX/L6k3ShPviLEqj6GyYH/SV+uFpW8I9M/zj5rWRLgUVce
         JvcLeQdqPWTwfFaDBC+UzWSMQZhu9fGtZpkmLp9uN10OEPhEVIjpDWKCVPmNWoFVTkmQ
         +1X01KwDqxO831bhHXjM5LrvUMmfabkR9t4Ri9njqei1unnLLoUuHi3mfpkqEdC2kOXr
         CoGco3j0zE1v3Kh4cUeXrGGxTZ06xY3z5MmFnKhCvVNXmPYH33h4Qx+6fm0vRJWt5c6J
         Tu2E4TqH+RXXvKJbbUi/VQ509poCsGWCemGQ9YvlPXyEUzabtBPUGfyuUSvWKrdFigGs
         d4ww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F2D21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <CA+55aFzZVL=WVuhJAQDazj59jwnmhUrRRwNgzXS+c-q5yva0iw@mail.gmail.com>
References: <151632009605.21271.11304291057104672116.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151632014097.21271.16980532033566583357.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206192925.qkmghwsbaysr4iv2@hermes.olymp> <CAPcyv4ihN6fy5-vBtfA0PuwXvCAj8-rMhtQmevh5sdYxbH3Yfw@mail.gmail.com>
 <CA+55aFxYHX3=HN4P5M0ziSJ08WfjccyhE2T7epS-EC6ZJ6LyjQ@mail.gmail.com>
 <CAPcyv4i5oORdk-Fzypxw_+gCLUa8f=w1e_n0=47P7uHR-jT6GQ@mail.gmail.com> <CA+55aFzZVL=WVuhJAQDazj59jwnmhUrRRwNgzXS+c-q5yva0iw@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 6 Feb 2018 20:49:39 +0000
X-Gmail-Original-Message-ID: <CALCETrXV3rHb7Z8iaoieAJ5hRY0+UT7eTknxe4-FiOoke9XoGg@mail.gmail.com>
Message-ID: <CALCETrXV3rHb7Z8iaoieAJ5hRY0+UT7eTknxe4-FiOoke9XoGg@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] x86: narrow out of bounds syscalls to sys_read
 under speculation
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Luis Henriques <lhenriques@suse.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Greg KH <gregkh@linuxfoundation.org>,
	X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589977480308913684?=
X-GMAIL-MSGID: =?utf-8?q?1591686150315042616?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 8:42 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Feb 6, 2018 at 12:37 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> Are there any compilers that would miscompile:
>>
>>     mask = 0 - (index < size);
>>
>> That might be a way to improve the assembly.
>
> Sadly, that is *very* easy to miscompile. In fact, I'd be very
> surprised indeed if any compiler worth its name wouldn't combine the
> comparison with the conditional branch it accompanies, and just turn
> that into a constant. IOW, you'd get
>
>         mask = 0 - (index < size);
>         if (index <= size) {
>                  ... use mask ..
>
> and the compiler would just turn that into
>
>         if (index <= size) {
>                 mask = -1;
>
> and be done with it.
>
>                Linus

Can you use @cc to make an asm statement that outputs both the masked
array index and the "if" condition?  I can never remember the syntax,
but something like:

asm ("cmp %[limit], %[index]\n\tcmovae %[zero], %[index]" : [index]
"+" (index), "@ccb" (result));

Then you shove this into a statement expression macro so you can do:

if (index_mask_nospec(&nr, NR_syscalls)) {
  ... sys_call_table[nr] ..;
}

(Caveat emptor: I can also *ever* remember which way the $*!& AT&T
syntax cmp instruction goes.)

A down side is that nr actually ends up containing zero outside the
if.  *That* could be avoided with jump labels.

--Andy
