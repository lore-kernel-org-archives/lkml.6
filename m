Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05365C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7285B208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7285B208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeH1JCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:02:15 -0400
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:36996 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726120AbeH1JCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:02:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id BD2E8181D337B;
        Tue, 28 Aug 2018 05:12:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: map52_148524afc4c28
X-Filterd-Recvd-Size: 2643
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Aug 2018 05:12:20 +0000 (UTC)
Message-ID: <c07f1fd50d25077f62efbe586bfc40428959d175.camel@perches.com>
Subject: Re: checkpatch.pl bug? (was Re: [PATCH] random: Make CPU trust a
 boot parameter)
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 27 Aug 2018 22:12:18 -0700
In-Reply-To: <CAGXu5jL9b3Ks95fpq5tdqS1avQysasaCBDzaA31-FVmJCqz=Og@mail.gmail.com>
References: <CAGXu5jL9b3Ks95fpq5tdqS1avQysasaCBDzaA31-FVmJCqz=Og@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-27 at 14:55 -0700, Kees Cook wrote:
> On Mon, Aug 27, 2018 at 2:51 PM, Kees Cook <keescook@chromium.org> wrote:
> > Instead of forcing a distro or other system builder to choose
> > at build time whether the CPU is trusted for CRNG seeding via
> > CONFIG_RANDOM_TRUST_CPU, provide a boot-time parameter for end users to
> > control the choice. The CONFIG will set the default state instead.
[]
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
[]
> > @@ -779,6 +779,13 @@ static struct crng_state **crng_node_pool __read_mostly;
> > 
> >  static void invalidate_batched_entropy(void);
> > 
> > +static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
> > +static int __init parse_trust_cpu(char *arg)
> > +{
> > +       return kstrtobool(arg, &trust_cpu);
> > +}
> > +early_param("random.trust_cpu", parse_trust_cpu);
> > +
> >  static void crng_initialize(struct crng_state *crng)
> >  {
> >         int             i;
> > @@ -799,12 +806,10 @@ static void crng_initialize(struct crng_state *crng)
> >                 }
> >                 crng->state[i] ^= rv;
> >         }
> > -#ifdef CONFIG_RANDOM_TRUST_CPU
> > -       if (arch_init) {
> > +       if (trust_cpu && arch_init) {
> 
> checkpatch.pl complains:
> 
> ERROR: space prohibited after that '&&' (ctx:WxW)
> #79: FILE: drivers/char/random.c:809:
> +       if (trust_cpu && arch_init) {
>                       ^
> 
> I can't figure out what is going on here. Using "||" doesn't trigger
> the issue; it seems related to the earlier "&trust_cpu" use in the
> patch, but I can't figure out what checkpatch was trying to do with
> this...

It's the __ro_after_init after the declaration of
static bool trust_cpu that confuses checkpatch.

I'll see what can be done for that.
