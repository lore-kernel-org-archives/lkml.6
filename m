Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719B5C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3089B2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544388343;
	bh=EWLie9oNcpmhnfbfIFE0LOAJanDbXUm9+KCMOqxVkeI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=KdIGrek+ANcp3/RblizsDSK+JCiM5oUdCmH+IuZBdBVQZjgmou+SLexIyFLDP7v3l
	 dzsN24C5d6fFk63AqXnwnLBYlWRF7NC6HH0k4eh8A/x3NfJxRQVhsZmMBcN6WnD4a9
	 NCC7CiYIWjU2eBQ5RWqffoc0uG89OOeL0IB5g3cw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3089B2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeLIUpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:45:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:41900 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbeLIUpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:45:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A7A4AE86;
        Sun,  9 Dec 2018 20:45:40 +0000 (UTC)
Date:   Sun, 9 Dec 2018 21:45:39 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     bianpan2016@163.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: intel-ish-hid: fixes incorrect error handling
In-Reply-To: <CAO-hwJJDhtNqy6gc9OJ+rHnJimrQeAoxxkay5XnfXjxMtvEufQ@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1812092144440.17216@cbobk.fhfr.pm>
References: <1542847953-127599-1-git-send-email-bianpan2016@163.com> <CAO-hwJJDhtNqy6gc9OJ+rHnJimrQeAoxxkay5XnfXjxMtvEufQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018, Benjamin Tissoires wrote:

> > The memory chunk allocated by hid_allocate_device() should be released
> > by hid_destroy_device(), not kfree().
> >
> > Fixes: 0b28cb4bcb1("HID: intel-ish-hid: ISH HID client driver")
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> > ---
> >  drivers/hid/intel-ish-hid/ishtp-hid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
> > index cd23903..e918d78 100644
> > --- a/drivers/hid/intel-ish-hid/ishtp-hid.c
> > +++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
> > @@ -222,7 +222,7 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
> >  err_hid_device:
> >         kfree(hid_data);
> >  err_hid_data:
> > -       kfree(hid);
> > +       hid_destroy_device(hid);
> 
> Looks good to me. Srinivas, any comments?
> FWIW:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Jiri, do you think we should send this one as 4.20/fixes material or
> wait for 4.21?

Given that this has been around since 4.9, I wouldn't be devastated if it 
lands only in next merge window. So I'd just put it to 4.20/fixes and wait 
for other more serious trigger for sending that to Linus eventually.

Thanks,

-- 
Jiri Kosina
SUSE Labs

