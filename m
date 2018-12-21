Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3076C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D697218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389443AbeLULRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 06:17:52 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46766 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbeLULRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 06:17:51 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id e618b23693fccc60; Fri, 21 Dec 2018 12:17:49 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Borislav Petkov <bp@alien8.de>, David Arcari <darcari@redhat.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>
Subject: Re: [PATCH] ACPI/APEI: Clear GHES block_status before panic()
Date:   Fri, 21 Dec 2018 12:17:21 +0100
Message-ID: <1691682.ckC9UJvgEr@aspire.rjw.lan>
In-Reply-To: <20181220192447.GG31403@zn.tnic>
References: <1545238252-79630-1-git-send-email-darcari@redhat.com> <20181220192447.GG31403@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 20, 2018 8:24:47 PM CET Borislav Petkov wrote:
> + James.
> 
> On Wed, Dec 19, 2018 at 11:50:52AM -0500, David Arcari wrote:
> > From: Lenny Szubowicz <lszubowi@redhat.com>
> > 
> > In __ghes_panic() clear the block status in the APEI generic
> > error status block for that generic hardware error source before
> > calling panic() to prevent a second panic() in the crash kernel
> > for exactly the same fatal error.
> > 
> > Otherwise ghes_probe(), running in the crash kernel, would see
> > an unhandled error in the APEI generic error status block and
> > panic again, thereby precluding any crash dump.
> > 
> > Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> > Signed-off-by: David Arcari <darcari@redhat.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/acpi/apei/ghes.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 02c6fd9..f008ba7 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -691,6 +691,8 @@ static void __ghes_panic(struct ghes *ghes)
> >  {
> >  	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
> >  
> > +	ghes_clear_estatus(ghes);
> > +
> >  	/* reboot to log the error! */
> >  	if (!panic_timeout)
> >  		panic_timeout = ghes_panic_timeout;
> 
> Acked-by: Borislav Petkov <bp@suse.de>

Patch applied, thanks!

