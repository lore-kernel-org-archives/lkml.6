Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730ECC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D27420849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D27420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbeLMOBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:01:04 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:52285 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbeLMOBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:01:03 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 0BE9F5C22C4; Thu, 13 Dec 2018 15:00:58 +0100 (CET)
Date:   Thu, 13 Dec 2018 15:00:58 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: handle kzalloc failure
Message-ID: <20181213140057.GA29272@osadl.at>
References: <1544699390-15673-1-git-send-email-hofrat@osadl.org>
 <20181213123139.oukmwpkw2yfap6oa@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213123139.oukmwpkw2yfap6oa@pathway.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 01:31:39PM +0100, Petr Mladek wrote:
> On Thu 2018-12-13 12:09:49, Nicholas Mc Guire wrote:
> > kzalloc() return should always be checked - notably in example code
> > where this may be seen as reference. On failure of allocation
> > livepatch_fix1_dummy_alloc() should return NULL.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > ---
> > 
> > Problem was located with an experimental coccinelle script
> > 
> > Patch was compile tested with: x86_64_defconfig + FTRACE=y
> > FUNCTION_TRACER=y, EXPERT=y, LATENCYTOP=y, SAMPLES=y, SAMPLE_LIVEPATCH=y
> > (with some unrelated sparse warnings on symbols not being static)
> > 
> > Patch is against 4.20-rc6 (localversion-next is next-20181213)
> > 
> >  samples/livepatch/livepatch-shadow-fix1.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
> > index 49b1355..a0e8f04 100644
> > --- a/samples/livepatch/livepatch-shadow-fix1.c
> > +++ b/samples/livepatch/livepatch-shadow-fix1.c
> > @@ -89,6 +89,9 @@ struct dummy *livepatch_fix1_dummy_alloc(void)
> >  	 * pointer to handle resource release.
> >  	 */
> >  	leak = kzalloc(sizeof(int), GFP_KERNEL);
> > +	if (!leak)
> > +		return NULL;
> 
> It should be:
> 
> 	if (!leak) {
> 		kfree(d);
> 		return NULL;
> 	}
> 
> Note that The check is not strictly needed in this artificial
> example because we never read/write any data there. But I agree
> that we should add the check to promote the the right programming
> patterns.
>
thanks for catching this !
will send a V2.

thx!
hofrat 
