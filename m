Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC32C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E897B20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E897B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbeHAIsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:48:08 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:56177 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387445AbeHAIsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:48:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0799C18229425;
        Wed,  1 Aug 2018 07:03:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: flock12_4ae2e3065c08
X-Filterd-Recvd-Size: 3344
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed,  1 Aug 2018 07:03:52 +0000 (UTC)
Message-ID: <afa25468e62ae3259878d8a95e9ac96f6be9f88a.camel@perches.com>
Subject: Re: [PATCH v3 5/9] powerpc/traps: Print signal name for unhandled
 signals
From:   Joe Perches <joe@perches.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Alastair D'Silva <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 01 Aug 2018 00:03:50 -0700
In-Reply-To: <631e9a9b-dbbe-ede7-eb81-81520cc36ad5@c-s.fr>
References: <20180731145020.14009-1-muriloo@linux.ibm.com>
         <20180731145020.14009-6-muriloo@linux.ibm.com>
         <631e9a9b-dbbe-ede7-eb81-81520cc36ad5@c-s.fr>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 08:37 +0200, Christophe LEROY wrote:
> Le 31/07/2018 à 16:50, Murilo Opsfelder Araujo a écrit :
> > This adds a human-readable name in the unhandled signal message.
> > Before this patch, a page fault looked like:
> >    pandafault[6303]: unhandled signal 11 at 100007d0 nip 1000061c lr 7fff93c55100 code 2 in pandafault[10000000+10000]
> > After this patch, a page fault looks like:
> >    pandafault[6352]: segfault (11) at 13a2a09f8 nip 13a2a086c lr 7fffb63e5100 code 2 in pandafault[13a2a0000+10000]
]]
> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
[]
> > @@ -96,6 +96,41 @@ EXPORT_SYMBOL(__debugger_fault_handler);
> >   #define TM_DEBUG(x...) do { } while(0)
> >   #endif
> >   
> > +static const char *signames[SIGRTMIN + 1] = {
> > +	"UNKNOWN",
> > +	"SIGHUP",			// 1
> > +	"SIGINT",			// 2
[]
> I don't think is is worth having that full table when we only use a few 
> of them. (As discussed in v1 https://patchwork.ozlabs.org/patch/948802/)
> 
> I would suggest to instead use a function like this:
> 
> static const char *signame(int signr)
> {
> 	if (signr == SIGBUS)
> 		return "bus error";
> 	if (signr == SIGFPE)
> 		return "floating point exception";
> 	if (signr == SIGILL)
> 		return "illegal instruction";
> 	if (signr == SIGILL)
> 		return "segfault";
> 	if (signr == SIGTRAP)
> 		return "unhandled trap";
> 	return "unknown signal";
> }

trivia:

Unless the if tests are ordered most to least likely,
perhaps it would be better to use a switch/case and
let the compiler decide.

	switch (signr) {
	case SIGBUS:	return "bus error";
	case SIGFPE:	return "floating point exception";
	case SIGILL:	return "illegal instruction";
	case SIGSEGV:	return "segfault";
	case SIGTRAP:	return "unhandled trap";
	}
	return "unknown signal";
}
