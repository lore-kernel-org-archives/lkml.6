Return-Path: <kernel-hardening-return-12887-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48wgapSaZUsB/EOjUe3csUmVglRkdQHkRigNswYbnkiDnSjhCqUAsSchypw9h4tn4Kc5JOr
ARC-Seal: i=1; a=rsa-sha256; t=1523169583; cv=none;
        d=google.com; s=arc-20160816;
        b=Cl8iwtezAILJCzE4rc9fMXxuCFkvf/gEd6/stDj2OIAZ4r7m7Ujxzf38bMOS3mITCS
         07A1kURdukuLbpAABZZlbgk2Hnb5uDS/ItS+ONHSpfqPDuDm3XkC6JGs0iTTUl5a40GO
         /Gy9VDXoRrpY+e0TjfrHAt5rQeTR4k6yBRYlGexm9d3IfSAeB4eNKPp70uTXP/kPdHFr
         7QYK5Unjbxwf/bcLbNN9XK6tS3N1fJDWEjo/IDMiqdZKY45CSioDb1fvHoLJlfPfcxc1
         OVy/tOhAScpK7InVjcdy4s8kcKda+TnHlweOEH7QgG82NfdKU40r80YilVPGuO5YCqoE
         bbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Hscv/Vr1Rxh33bL5rKCK/GxGrZDfWAMbsRuiGpY7zxk=;
        b=gKbuo2Lb4pDAkFgIVD52qXSEWJbK1gwqXCuxH9hOkJgv3eGcIyJyAoefaXGaeSdoL/
         BfOa/9dFeZVulY633sEJp781bFMuwGV8w6HaI66gCj6963F/x+RZAclyQXJQe7saPNMU
         h8/nQK3EvEEldXG/AIVT+QRYNcN0c4RiHk7u7v4dpRZiM6F35E2pzlMwM6CrFguAYVaU
         iIWf/BwYHTVeNQs3RVGU2M0KJWJUwvQKjN4y6OVjxagiTD33AZyiTyaU1S75Hg0UdiLZ
         ZlJ2mIlEJ4E59KQ9viaCdSDWvMiBGn1CPE1ZHzs/7MZNcHKm7c5CfHriojCqBzqRiFGf
         AXaw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ApEAuuqK;
       spf=pass (google.com: domain of kernel-hardening-return-12887-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12887-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ApEAuuqK;
       spf=pass (google.com: domain of kernel-hardening-return-12887-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12887-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKidijcESX2vguQ=m4Fx1S7eKOKXrLTEb3Of1FN9jQbbg@mail.gmail.com>
References: <1519899591-29761-1-git-send-email-kpark3469@gmail.com>
 <1519899591-29761-2-git-send-email-kpark3469@gmail.com> <1519899591-29761-3-git-send-email-kpark3469@gmail.com>
 <CAGXu5jKidijcESX2vguQ=m4Fx1S7eKOKXrLTEb3Of1FN9jQbbg@mail.gmail.com>
From: Keun-O Park <kpark3469@gmail.com>
Date: Sun, 8 Apr 2018 10:39:24 +0400
Message-ID: <CA+KhAHZB2tDpd-EY8har78PWyf=SCN4cNSjLHLpRqZoJgB2TiQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: usercopy: implement arch_within_stack_frames
To: Kees Cook <keescook@chromium.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, keun-o.park@darkmatter.ae,
	Sodagudi Prasad <psodagud@codeaurora.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593731050789508476?=
X-GMAIL-MSGID: =?utf-8?q?1597159069831869977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kees,

On Thu, Apr 5, 2018 at 2:55 AM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Mar 1, 2018 at 2:19 AM,  <kpark3469@gmail.com> wrote:
>> From: James Morse <james.morse@arm.com>
>>
>> This implements arch_within_stack_frames() for arm64 that should
>> validate if a given object is contained by a kernel stack frame.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Reviewed-by: Sahara <keun-o.park@darkmatter.ae>
>
> Looks good to me. Does this end up passing the LKDTM
> USERCOPY_STACK_FRAME_TO and USERCOPY_STACK_FRAME_FROM tests?

Yes, this passes those two LKDTM tests.
Thanks.

BR
Sahara
