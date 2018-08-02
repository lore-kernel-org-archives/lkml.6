Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0D4C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCD8214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCD8214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbeHBSnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:43:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:60601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbeHBSnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:43:11 -0400
Received: from homer.simpson.net ([185.221.150.28]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lug4m-1fuF2Z2F2u-00zk5h; Thu, 02
 Aug 2018 18:50:51 +0200
Message-ID: <1533228650.12550.15.camel@gmx.de>
Subject: Re: [rt-patch 4/3] arm,KVM: Move phys_timer handling to hard irq
 context
From:   Mike Galbraith <efault@gmx.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Thu, 02 Aug 2018 18:50:50 +0200
In-Reply-To: <20180802123104.7fed73b4@gandalf.local.home>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532764179.9882.14.camel@gmx.de> <1532768853.9882.73.camel@gmx.de>
         <1533192980.11791.8.camel@gmx.de>
         <20180802123104.7fed73b4@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:L/h4LdVzwALVIipIpTc3Rp/obQTQfvhbTriZZZ8nroOC0i5hFI2
 sbBxxLrky/SWc/V4yE/izibi8USz2MTvubEVt/cuYhul5FOp1OkZ6RdbfOU5NXybLx1HmLb
 cje/De1O/qsngGVxvZIWIR9SXWmC/VRyGVdQKfra0leXoUDr4GqAnAewo9TWQ/rOpcAotCu
 fpHdz4c7L48u5biehK8LA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g4mjiNxvZw0=:VOi8JoVBtGsHFTZrM8YlI4
 mo+simXF9QtauxgbWS2jg3Z7VjwLUVAExnkQvtR+HkWeirl6p+HXAES2dSBvYJY3qUtEQ3z5T
 fvJwPmUKoFqkFk+BakR+MZ4kX2sR4+8lT7dapG7fZcpTewG3b5kvQPW0sUGyhZGI9Px0fZjOG
 8FrAATYx+GpCJlbko4z3iOjS/9MlumSXgqen6cga+ci3Cc0cRZrhsgOtrbRe0ZKMD4SfY/gej
 naGW0AQlqtjRN+ZdgTfAhgymgwA8OgCVWrDXnaOewfNf7u7ACqMVjFkLF903Iw9nSBwJ2B1IU
 DXm9UFbDap7HEJ/rZmWj5uV8avp98s/BDFFkVnel4HG1Zk+hnAFCKdwUbBxr2/jM0LQuP64e9
 biSDtGeX4SKHGv15ur0PVKff7MWTRPayCccyP9hjgzPtBGr1oq4H3BCY0y0FMT++hvvxAL0GZ
 miJOuHIfW+XrunBatCn9E3nicH5IAVRgFqlwESJHM/e8Ih026mUDyFvZljn69SdHepKVZN3xS
 ngWO/4EvUOpS0wEuVFZG2bF9p0nonUZ5L+/Q4zIA9QDGnTq5WGPgmMQaS+pivhEkDx/dLvACl
 E0wogOuxxqdcYyvj3ZOLw5ld+0Js/EYo9ReJ5G5BbPJ83c3dFqkyRJfix6dOkwwOGjprIx9WC
 bGEAneYPXXEvWsZRQ/S0XLlJljZJO6pUKhfULPfVrnSjBbBni1vg2Gf9SCoC64hdUtLJFp/Xk
 kpEN21rLacEZlrom21w+CdpAAOJ71uxgVu1edDBWP3QqbOJHmm7MjSw9p9medhuF434j7S2aX
 03WRdMB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 12:31 -0400, Steven Rostedt wrote:
> On Thu, 02 Aug 2018 08:56:20 +0200
> Mike Galbraith <efault@gmx.de> wrote:
> 
> > (arm-land adventures 1/3 take2 will have to wait, my cup runeth over) 
> > 
> > v4.14..v4.15 timer handling changes including calling kvm_timer_vcpu_load()
> 
> I take it that this should be added to v4.16-rt and marked stable-rt?

Yeah, barring way sexier ideas of course.

	-Mike
