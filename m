Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDD5C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C4D20841
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C4D20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeJISCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:02:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49929 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJISCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:02:06 -0400
Received: from 79.184.255.62.ipv4.supernova.orange.pl (79.184.255.62) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 58704f577b1a0e61; Tue, 9 Oct 2018 12:45:44 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 0/6] cpuidle: menu: Fixes, optimizations and cleanups
Date:   Tue, 09 Oct 2018 12:42:38 +0200
Message-ID: <32751210.eVKMK0JPWn@aspire.rjw.lan>
In-Reply-To: <CAJZ5v0h4sVoen++nF1cYvqQeY3qN0B1aP42e8A4SZwxzBV3NVA@mail.gmail.com>
References: <000301d45ecb$4f002a90$ed007fb0$@net> <003801d45f54$3d9b0c50$b8d124f0$@net> <CAJZ5v0h4sVoen++nF1cYvqQeY3qN0B1aP42e8A4SZwxzBV3NVA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 9, 2018 12:26:48 AM CEST Rafael J. Wysocki wrote:
> On Tue, Oct 9, 2018 at 12:14 AM Doug Smythies <dsmythies@telus.net> wrote:
> >
> > On 2018.10.08 00:51 Rafael J. Wysocki wrote:
> > > On Mon, Oct 8, 2018 at 8:02 AM Doug Smythies <dsmythies@telus.net> wrote:
> > >>
> > >> On 2018.10.03 23:56 Rafael J. Wysocki wrote:
> > >>> On Tue, Oct 2, 2018 at 11:51 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> [cut]
> 
> > >> Test 2: pipe test 2 CPUs, one core. CPU test:
> > >>
> > >> The average loop times graph is here:
> > >> http://fast.smythies.com/linux-pm/k419/k419-rjw-pipe-1core.png
> > >>
> > >> The power and idle statistics graphs are here:
> > >> http://fast.smythies.com/linux-pm/k419/k419-rjw-pipe-1core.htm
> > >>
> > >> Conclusions:
> > >>
> > >> Better performance at the cost of more power with
> > >> the patch set, but late August had both better performance
> > >> and less power.
> > >>
> > >> Overall idle entries and exits are about the same, but way
> > >> way more idle state 0 entries and exits with the patch set.
> > >
> > >Same as above (and expected too).
> >
> > I Disagree. The significant transfer of idle entries from
> > idle state 1 with kernel 4.19-rc6 to idle state 0 with the
> > additional 8 patch set is virtually entirely due to this patch:
> >
> > "[PATCH 2/6] cpuidle: menu: Compute first_idx when latency_req is known"
> 
> OK
> 
> > As far as I can determine from all of this data, in particular the
> > histogram data below, it seems to me that it now is selecting
> > idle state 0 whereas before it was selecting idle state 1
> > is the correct decision for those very short duration idle states
> > (well, for my processor (older i7-2600K) at least).
> 
> At least, that's a matter of consistency IMO.
> 
> State 1 should not be selected if the final latency limit is below its
> exit latency and that's what happens in that situation.
> 
> > Note: I did test my above assertion with kernels compiled with only
> > the first 2 and then 3 of the 8 patch set.
> 
> I see.

While at it, could you test the appended patch (on top of the previous 8)
for me please?

I think that this code can be simplified now.

---
 drivers/cpuidle/governors/menu.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -371,12 +371,12 @@ static int menu_select(struct cpuidle_dr
 		if (s->target_residency > predicted_us) {
 			/*
 			 * Use a physical idle state, not busy polling, unless
-			 * a timer is going to trigger really really soon.
+			 * a timer is going to trigger soon enough.
 			 */
 			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-			    i == idx + 1 && latency_req > s->exit_latency &&
-			    data->next_timer_us > max_t(unsigned int, 20,
-							s->target_residency)) {
+			    s->exit_latency <= latency_req &&
+			    s->target_residency <= data->next_timer_us) {
+				predicted_us = s->target_residency;
 				idx = i;
 				break;
 			}

