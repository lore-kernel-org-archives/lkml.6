Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EFDC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F52625EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F52625EBC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934324AbeFYRF6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:05:58 -0400
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:44094 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933724AbeFYRF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:05:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 2127D182CF66B;
        Mon, 25 Jun 2018 17:05:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crook22_336d49961e62c
X-Filterd-Recvd-Size: 3129
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Jun 2018 17:05:53 +0000 (UTC)
Message-ID: <ca7719d7e917623bcd0bfd508add4d1f43c42d53.camel@perches.com>
Subject: Re: [PATCH v2] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>, pbonzini@redhat.com
Cc:     Matthias Kaehlcke <mka@chromium.org>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Jun 2018 10:05:52 -0700
In-Reply-To: <CAKwvOdmmv9EtPB-jhwVruLASFve5d4h0+wx-6iY=ve=T9hbNdg@mail.gmail.com>
References: <20180619192504.180479-1-mka@chromium.org>
         <4dd99306-4fea-24b2-4bea-5b7927ea5e79@redhat.com>
         <CAKwvOdmmv9EtPB-jhwVruLASFve5d4h0+wx-6iY=ve=T9hbNdg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 12:47 -0400, Nick Desaulniers wrote:
> On Mon, Jun 25, 2018 at 12:05 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > 
> > On 19/06/2018 21:25, Matthias Kaehlcke wrote:
> > > update_permission_bitmask() negates u8 bitmask values and assigns them
> > > to variables of type u8. Since the MSB is set in the bitmask values the
> > > compiler expands the negated values to int, which then is assigned to
> > > an u8 variable. Cast the negated value back to u8.
> > > 
> > > This fixes several warnings like this when building with clang:
> > > 
> > > arch/x86/kvm/mmu.c:4266:39: error: implicit conversion from 'int' to 'u8'
> > >   (aka 'unsigned char') changes value from -205 to 51 [-Werror,
> > >   -Wconstant-conversion]
> > >     u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
> > >        ~~                               ^~
> > > 
> > > (gcc also raises a warning (see https://godbolt.org/g/6JWfWk), however it
> > > doesn't seem to be universally enabled)
> > > 
> > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > Changes in v2:
> > > - negate the bitmask at initialization and rename variables to not_X
> > 
> > The patch is not that bad, but I'd like to get confirmation that other
> > maintainers are applying fixes like this.  Honestly I'm not really
> > impressed by most new clang warnings, these days.
> 
> Here's an actual bug this warning caught applied to drivers/input/:
> 
> dae1a432ab1f ("Input: mousedev - fix implicit conversion warning"):
> https://patchwork.kernel.org/patch/9753771/

What bug is that?

$ cat test.c
#include <stdio.h>
#include <stdlib.h>
#include <memory.h>

int main(int argc, char **argv)
{
	static const signed char a[3] = {0x60, 3, 200};
	static const unsigned char b[3] = {0x60, 3, 200};

	printf("a and b are %s\n",
	       memcmp(a, b, 3) == 0 ? "identical" : "different");
}
$ gcc test.c
$ ./a.out
a and b are identical

