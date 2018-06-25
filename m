Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCB7C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AD72587B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AD72587B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933768AbeFYMK1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:10:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:42124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932444AbeFYMFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:05:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AC909ABF7;
        Mon, 25 Jun 2018 12:04:58 +0000 (UTC)
Date:   Mon, 25 Jun 2018 14:04:54 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        David Miller <davem@davemloft.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RESEND] lib/test_printf.c: call wait_for_random_bytes()
 before plain %p tests
Message-ID: <20180625120454.rtf7ram4euvgdc6w@pathway.suse.cz>
References: <20180604113708.11554-1-thierry.escande@linaro.org>
 <20180607122434.i4x7b5ij4p6dpx7w@pathway.suse.cz>
 <20180622205346.owyjk33wplzh7nhs@home.goodmis.org>
 <a2f0729c-593e-b747-a22f-6468ea88882e@linaro.org>
 <20180625075020.xcb6jqup3dhq2agf@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625075020.xcb6jqup3dhq2agf@pathway.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-06-25 09:50:20, Petr Mladek wrote:
> On Fri 2018-06-22 23:50:20, Thierry Escande wrote:
> > On 22/06/2018 22:53, Steven Rostedt wrote:
> > > On Thu, Jun 07, 2018 at 02:24:34PM +0200, Petr Mladek wrote:
> > > > On Mon 2018-06-04 13:37:08, Thierry Escande wrote:
> > > > > If the test_printf module is loaded before the crng is initialized, the
> > > > > plain 'p' tests will fail because the printed address will not be hashed
> > > > > and the buffer will contain '(ptrval)' instead.
> > > > > This patch adds a call to wait_for_random_bytes() before plain 'p' tests
> > > > > to make sure the crng is initialized.
> > > > 
> > > > Hmm, my system did not boot with this patch and
> > > > CONFIG_TEST_PRINTF=y
> > > 
> > > And neither does my test box. It killed my tests I was running, as one of the
> > > configs I test has this set.
> > > 
> > > It appears that Andrew pulled it in and sent it to Linus, as it is in
> > > 4.18-rc1, and I need to now revert this patch to make my tests work.
> > 
> > This patch has been superseded with a v2 and a v3 pushed into Petr
> > printk.git tree (https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-4.19&id=ce041c43f22298485122bab15c14d062383fbc67).
> > Sorry for the mess...
> 
> Andrew,
> 
> should I send the revert and the better fix to Linus or would you like
> to do so?

Below is the proposed revert-commit just in case people want to add
Reviewed-by tags or so.


From 043f891b70e6197bc181f3b087c2bd04c60fddd2 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Mon, 25 Jun 2018 13:28:06 +0200
Subject: [PATCH] Revert "lib/test_printf.c: call wait_for_random_bytes()
 before plain %p tests"

This reverts commit ee410f15b1418f2f4428e79980674c979081bcb7.

It might prevent the machine from boot. It would wait for enough
randomness at the very beginning of kernel_init(). But there is
basically nothing running in parallel that would help to produce
any randomness.

Reported-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/test_printf.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index b2aa8f514844..cea592f402ed 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -260,13 +260,6 @@ plain(void)
 {
 	int err;
 
-	/*
-	 * Make sure crng is ready. Otherwise we get "(ptrval)" instead
-	 * of a hashed address when printing '%p' in plain_hash() and
-	 * plain_format().
-	 */
-	wait_for_random_bytes();
-
 	err = plain_hash();
 	if (err) {
 		pr_warn("plain 'p' does not appear to be hashed\n");
-- 
2.13.7

