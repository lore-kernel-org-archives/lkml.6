Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B37BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4723B2089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4723B2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754649AbeGJBh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:37:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:39526 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754580AbeGJBhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:37:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6A1bDE9031131;
        Mon, 9 Jul 2018 20:37:14 -0500
Message-ID: <7c05462c54a7542a263b64f20c512b10bbbcba26.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] drivers: core: Remove glue dirs from sysfs
 earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 10 Jul 2018 11:37:13 +1000
In-Reply-To: <CA+55aFzwjnL5C+kASzsP1rPOg+2BUanBAJsrOJKCKrJuhSwFUQ@mail.gmail.com>
References: <CA+55aFyzYXSTTuVoGfVeC574-7i0zp3q39RTsiPn3GoRceuwAQ@mail.gmail.com>
         <213dd8fa77629e04277e68552068581da881e7e4.camel@kernel.crashing.org>
         <CA+55aFy927VYjFDwe9Zy_M+XFNxSFh2HLFcQ25pm8AMNXBUoQA@mail.gmail.com>
         <CA+55aFx7wgjx+d0Vdtpgzc46HM-4vN2r-Hyf2ZC4gQU-nxopMQ@mail.gmail.com>
         <1303e511c44f639c562a02ae28aa530144277c99.camel@kernel.crashing.org>
         <b15584ccdfcb3bf6d42665635aaa9150ed3244ba.camel@kernel.crashing.org>
         <CA+55aFzKmzC-2_6+RsRRu9KfK_r=UGgLN2Q0hSNBV=ScGR7=8g@mail.gmail.com>
         <6e3ca577f8dd5f3621d1054447d3f928a73dfcf9.camel@kernel.crashing.org>
         <CA+55aFy+ZSu5cPzk887N-ZgXqvTB=Bp1JQYMWT1SZY81MqLH6Q@mail.gmail.com>
         <1bc873980e7f63291fbe19dbc7e1607b8e126241.camel@kernel.crashing.org>
         <20180707164241.GB16279@kroah.com>
         <CA+55aFx-UX8nxewRFFWdBgYfPqfipnxaqJuJCUni9h4JvhoPFw@mail.gmail.com>
         <70f1312e76a9f53bf7749525ea881272c7007a34.camel@kernel.crashing.org>
         <CA+55aFzwjnL5C+kASzsP1rPOg+2BUanBAJsrOJKCKrJuhSwFUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-09 at 17:33 -0700, Linus Torvalds wrote:
> On Mon, Jul 9, 2018 at 5:29 PM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> > For devices with a class, we create a "glue" directory between
> > the parent device and the new device with the class name.
> > 
> > This directory is never "explicitely" removed when empty however,
> 
> explicitly
> 
> Is the mis-spelling why you had the quotes? I do find that spelling in
> the kernel, but not in drivers/base/.

No idea :-) Just my poor english, I'm not sure why I put quotes, I
think I meant *explictly* as enphasis, not sure.

> > This fixes it by instead doing an explicit kobject_del() when
> > the glue dir is empty, by keeping track of the number of
> > child devices of the gluedir.
> 
> Ack. This looks good to me.
> 
> I didn't see your 1/2 - you should probably re-send that one too so
> that Greg doesn't have to fish for it. But I'll Ack that one too in
> this same email regardless.

OK, I didn't re-send it. Greg just nak'ed it though :-)

Cheers,
Ben.
