Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756935AbeEJIw0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 04:52:26 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46249 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756379AbeEJIwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 04:52:23 -0400
X-Google-Smtp-Source: AB8JxZrjFIFBFu3XqHExhZOvPQWoIbqjdmD4psagnbeTiBtH9FZ6/sRqqlZitcfr9ReWkX0dZmlXKg==
Date: Thu, 10 May 2018 16:48:31 +0800
From: Wang YanQing <udknight@gmail.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: illusionist.neo@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, daniel@iogearbox.net, ast@fb.com
Subject: Re: [PATCH] bpf, arm32: Correct check_imm24
Message-ID: <20180510084831.GA31194@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        illusionist.neo@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, daniel@iogearbox.net,
        ast@fb.com
References: <20180510032013.GB26016@udknight>
 <20180510075656.GS16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510075656.GS16141@n2100.armlinux.org.uk>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 08:56:57AM +0100, Russell King - ARM Linux wrote:
> On Thu, May 10, 2018 at 11:20:13AM +0800, Wang YanQing wrote:
> > imm24 is signed, so the right range is:
> > [-(2<<(24 - 1)), (2<<(24 - 1)) - 1]
> 
> 2 << (24 - 1) is the same as 1 << 24.
> 
> > -#define check_imm(bits, imm) do {				\
> > -	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
> > -	    (((imm) < 0) && (~(imm) >> (bits)))) {		\
> > -		pr_info("[%2d] imm=%d(0x%x) out of range\n",	\
> > -			i, imm, imm);				\
> > +#define check_imm_range(min, max, imm) do {			\
> > +	if (imm < min || imm > max) {				\
> > +		pr_info("[%2d] imm=%d is out of range\n",	\
> > +			i, imm);				\
> >  		return -EINVAL;					\
> >  	}							\
> >  } while (0)
> > -#define check_imm24(imm) check_imm(24, imm)
> > +#define check_imm24(imm) check_imm_range(-16777216, 16777215, imm)
> 
> How is this any different?
> 
> If imm is 16777216, then "imm > max" in your version is true.
> In the original version, "imm > 0" is true, so we then test for
> "16777216 >> 24" being non-zero.  That's also true, so the test
> condition fires.
> 
> If imm is 16777215, then "imm > max" is false in your version.
> In the original version, the conditions also evaluate to false.
> 
> For the -16777217 case, "imm < min" in your version is true.
> In the original version, "imm < 0" is true, so we then test for
> "~(-16777217) >> 24" being non-zero.  This is the same as
> "16777216 >> 24" being non-zero, which is true so the condition
> fires.
> 
> With -16777216, the same thing happens, both end up evaluating
> to false.
> 
> So, the two cases end up producing identical results, and there
> is no actual effect from this change.
> 
> However, your commit message is correct - there is a bug here.
> That's obvious when you mask the "imm" value with 0x00ffffff,
> and realise that an imm value of -16777216 ends up having the
> same value in the instruction as an imm value of 0.  So, the
> range of "imm" is _half_ that.
> 
>  #define check_imm(bits, imm) do {				\
> -	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
> -	    (((imm) < 0) && (~(imm) >> (bits)))) {		\
> +	if ((((imm) > 0) && ((imm) >> (bits - 1))) ||		\
> +	    (((imm) < 0) && (~(imm) >> (bits - 1)))) {		\
>  		pr_info("[%2d] imm=%d(0x%x) out of range\n",	\
>  			i, imm, imm);				\
> 
> would fix it.  Alternatively:
> 
>  #define check_imm(bits, imm) do {				\
> -	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
> -	    (((imm) < 0) && (~(imm) >> (bits)))) {		\
> +	if ((imm) >= (1 << ((bits) - 1)) ||			\
> +	    (imm) < -(1 << ((bits) - 1))) {			\
>  		pr_info("[%2d] imm=%d(0x%x) out of range\n",	\
>  			i, imm, imm);				\
> 
> would also fix it.

Hi!

Sorry for confusion, I make a mistake here, the real fix I want to
submit is [8388607, -8388608], this range has the same effect as your
suggestion.

Will you fix it? or I resend another version?

Thanks.
