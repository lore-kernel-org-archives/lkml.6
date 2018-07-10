Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14E2C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B038208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B038208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbeGJXcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:32:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:34579 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732305AbeGJXcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:32:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6ANV51b013493;
        Tue, 10 Jul 2018 18:31:07 -0500
Message-ID: <e3076a3ea9265be8b14a4ccbe2a6c47418fd25e2.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] drivers: core: Remove glue dirs from sysfs
 earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Jul 2018 09:31:05 +1000
In-Reply-To: <20180710145519.GA11703@kroah.com>
References: <CA+55aFx7wgjx+d0Vdtpgzc46HM-4vN2r-Hyf2ZC4gQU-nxopMQ@mail.gmail.com>
         <1303e511c44f639c562a02ae28aa530144277c99.camel@kernel.crashing.org>
         <b15584ccdfcb3bf6d42665635aaa9150ed3244ba.camel@kernel.crashing.org>
         <CA+55aFzKmzC-2_6+RsRRu9KfK_r=UGgLN2Q0hSNBV=ScGR7=8g@mail.gmail.com>
         <6e3ca577f8dd5f3621d1054447d3f928a73dfcf9.camel@kernel.crashing.org>
         <CA+55aFy+ZSu5cPzk887N-ZgXqvTB=Bp1JQYMWT1SZY81MqLH6Q@mail.gmail.com>
         <1bc873980e7f63291fbe19dbc7e1607b8e126241.camel@kernel.crashing.org>
         <20180707164241.GB16279@kroah.com>
         <CA+55aFx-UX8nxewRFFWdBgYfPqfipnxaqJuJCUni9h4JvhoPFw@mail.gmail.com>
         <70f1312e76a9f53bf7749525ea881272c7007a34.camel@kernel.crashing.org>
         <20180710145519.GA11703@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 16:55 +0200, Greg Kroah-Hartman wrote:
> 
> > +/**
> > + * kobject_has_children - Returns whether a kobject has children.
> > + * @kobj: the object to test
> > + *
> > + * This will return whether a kobject has other kobjects as children.
> > + *
> > + * It does NOT account for the presence of attribute files, only sub
> > + * directories. It also assumes there is no concurrent addition or
> > + * removal of such children, and thus relies on external locking.
> > + */
> > +static inline bool kobject_has_children(struct kobject *kobj)
> > +{
> > +	WARN_ON_ONCE(kref_read(&kobj->kref) == 0);
> 
> Why warn on?  Who is going to hit this and how are you going to fix up
> the syzbot reports?  :)

Well, that's it, the hope is nobody ever hits it ... but if one does it
would be useful to get a backtrace to figure it out. You can shoot the
reports my way I suppose :-)

> Anyway, this looks good, I can just take this and not the 1/2 patch now,
> right?  I really didn't like that patch.

Yes, it will fix the practical problem. As for patch 1, it's rather
funny, you and Linus seem to have a completely opposite idea of how
this stuff should work :-)

Cheers,
Ben.

> thanks,
> 
> greg k-h
