Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BE3C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A03E23D8D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A03E23D8D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932429AbeGDBKf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 21:10:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:35532 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932074AbeGDBKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 21:10:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w641AN6p012589;
        Tue, 3 Jul 2018 20:10:24 -0500
Message-ID: <db5b4e4237fa3d4de883ca540895faf97038f743.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Date:   Wed, 04 Jul 2018 11:10:23 +1000
In-Reply-To: <20180703154610.GR533219@devbig577.frc2.facebook.com>
References: <36fb9c9f873629abb7bf3758033cce00e463f768.camel@kernel.crashing.org>
         <CA+55aFzUhe7j+6XL_BB+gvSnCvMCOePZhanTBk5tq=zqvFFWSw@mail.gmail.com>
         <d56f1c255f7caa913ad77a174e1e3bde08043ac0.camel@kernel.crashing.org>
         <0dc3c0632b1821bd07abdf0224ccd9f32a4f250d.camel@kernel.crashing.org>
         <CA+55aFyzYXSTTuVoGfVeC574-7i0zp3q39RTsiPn3GoRceuwAQ@mail.gmail.com>
         <213dd8fa77629e04277e68552068581da881e7e4.camel@kernel.crashing.org>
         <CA+55aFy927VYjFDwe9Zy_M+XFNxSFh2HLFcQ25pm8AMNXBUoQA@mail.gmail.com>
         <CA+55aFx7wgjx+d0Vdtpgzc46HM-4vN2r-Hyf2ZC4gQU-nxopMQ@mail.gmail.com>
         <1303e511c44f639c562a02ae28aa530144277c99.camel@kernel.crashing.org>
         <b15584ccdfcb3bf6d42665635aaa9150ed3244ba.camel@kernel.crashing.org>
         <20180703154610.GR533219@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 08:46 -0700, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jul 03, 2018 at 03:22:47PM +1000, Benjamin Herrenschmidt wrote:
> > +bool kernfs_has_children(struct kernfs_node *kn)
> > +{
> > +	bool has_children = false;
> > +	struct kernfs_node *pos;
> > +
> > +	/* Lockless shortcut */
> > +	if (RB_EMPTY_NODE(&kn->rb))
> > +		return false;
> 
> Hmm... shouldn't it be testing !rb_first(kn->dir.children)?  The above
> would test whether @kn itself is unlinked.

Ah possibly, the rb tree usage got me confused a few times in there.

> > +
> > +	/* Now check for active children */
> > +	mutex_lock(&kernfs_mutex);
> > +	pos = NULL;
> > +	while ((pos = kernfs_next_descendant_post(pos, kn)) && pos != kn) {
> > +		if (kernfs_active(pos)) {
> > +			has_children = true;
> > +			break;
> > +		}
> > +	}
> > +	mutex_unlock(&kernfs_mutex);
> > +
> > +	return has_children;
> 
> The active ref is there to synchronize removal against in-flight reads
> so that kernfs_remove() can wait for them to drain.  On return from
> kernfs_remove(), the node is guaranteed to be off the rbtree and the
> above test isn't necessary.  !rb_first() test should be enough
> (provided that there's external synchronization, of course).

Ok. Yes there's external synchronization. So a simple !rb_first test
doesn't need the mutex I suppose ?

Cheers,
Ben.

> 
> Thanks.
> 
