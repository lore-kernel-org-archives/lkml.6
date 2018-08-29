Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864D0C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4948220647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4948220647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeH3Cz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:55:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeH3Cz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:55:58 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0A805C0A;
        Wed, 29 Aug 2018 22:56:49 +0000 (UTC)
Date:   Wed, 29 Aug 2018 15:56:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH resend] uapi/linux/keyctl.h: don't use C++ reserved
 keyword as a struct member name
Message-Id: <20180829155648.e4ec141bf7c66b3f13433ffa@linux-foundation.org>
In-Reply-To: <20180829024224.GA6083@kroah.com>
References: <0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org>
        <20180829024224.GA6083@kroah.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 19:42:24 -0700 Greg KH <gregkh@linuxfoundation.org> wrote:

> > --- lnx-416.orig/include/uapi/linux/keyctl.h
> > +++ lnx-416/include/uapi/linux/keyctl.h
> > @@ -65,7 +65,7 @@
> >  
> >  /* keyctl structures */
> >  struct keyctl_dh_params {
> > -	__s32 private;
> > +	__s32 dh_private;
> 
> Ick ick ick, why not just put the C "namespace" on all uapi files if you
> are including them from c++ code?  I'm sure this isn't the only problem
> that has this problem, right?
> 
> This is valid C, no need to start worrying about C++ reserved names.

We've done this before and it's a simple enough change in order to be
friendly toward others.

That being said, it's been like this for two years so presumably anyone
who is using this header from C++ is already `extern "C" { ...}' around
their #include.

I'm OK with the patch as-is, but if we run into this issue more often,
we might want to look at doing something kernel-wide.

I'm not sure what though. Adding

#ifdef __cplusplus
extern "C" {
#endif

...

#ifdef __cplusplus
}
#endif

into every uapi file might work.  Unpleasing.
