Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD5AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2101C20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="YcizbZB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2101C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeIZBT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:19:56 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:58528 "EHLO
        rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeIZBT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1861; q=dns/txt; s=iport;
  t=1537902658; x=1539112258;
  h=mime-version:content-transfer-encoding:to:from:
   in-reply-to:cc:references:message-id:subject:date;
  bh=D+gabMpYOyqdCLtXK8nrcuDoteHIWr6tSZXBbW63aRQ=;
  b=YcizbZB48gfudHFWBxVn0EnIYqu6ZZinmmNqrBl5NJb5YMtSNzqTxujq
   5Nt1AP1EseFZzSfJIsEUEOgm8iSJFFEfRGI/qG2ruOVNuhwftpzUcecs6
   wZrye2BtIq7/MzmmVE6CilFbjZmCrlO2kJcrLMuyEdFb6z58n+6bdzmiz
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AvAACfh6pb/40NJK1bGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBVIILgWQog3SUQ4FoJYhohGKKfguEbAKDZiE3FQEDAQECAQE?=
 =?us-ascii?q?CbSiFOAEBAQECASNWEAsYAgImAgJHEAYBEhuEewUIpEaBLooWFHeJbxeBQT+?=
 =?us-ascii?q?BRYJfhH6DAYJXAo5vjhAJkEAJAo8hlQmBWCKBVXAVeAtWgU6QdB8wjhMBAQ?=
X-IronPort-AV: E=Sophos;i="5.54,303,1534809600"; 
   d="scan'208";a="454071073"
Received: from alln-core-8.cisco.com ([173.36.13.141])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 19:10:57 +0000
Received: from localhost ([10.156.154.24])
        by alln-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id w8PJAvwI029930;
        Tue, 25 Sep 2018 19:10:57 GMT
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
From:   Taras Kondratiuk <takondra@cisco.com>
In-Reply-To: <a185b384-5ef1-5e53-2cc1-066391424dcb@tycho.nsa.gov>
Cc:     linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        xe-linux-external@cisco.com
References: <20180919165248.53090-1-takondra@cisco.com>
 <153741130781.7326.1773144725860636439@takondra-t460s>
 <9a944aea-f35e-5a49-841d-6bfca8f17b9d@tycho.nsa.gov>
 <153748436388.5590.1406237328277739821@takondra-t460s>
 <66ec16b0-a335-d9ef-deb3-ef391cdd66e0@tycho.nsa.gov>
 <CAHC9VhRorkfqRTsssx_eGMy+fJQtoJew7f5i24UBkZ6tGJ5CUw@mail.gmail.com>
 <153785433233.5039.17960184426345262866@takondra-t460s>
 <a23ad753-8fd4-e9c3-cdbf-391ee154794b@tycho.nsa.gov>
 <CAHC9VhRRArA7_ON5P2JfrKxExwzm5Wznj150pfgijBoR+JxYBA@mail.gmail.com>
 <a185b384-5ef1-5e53-2cc1-066391424dcb@tycho.nsa.gov>
Message-ID: <153790265614.6091.7582646556934797699@takondra-t460s>
User-Agent: alot/0.6
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for native labeling
Date:   Tue, 25 Sep 2018 12:10:56 -0700
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.156.154.24, [10.156.154.24]
X-Outbound-Node: alln-core-8.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (2018-09-25 09:39:55)
> On 09/25/2018 12:03 PM, Paul Moore wrote:
> > On Tue, Sep 25, 2018 at 9:58 AM Stephen Smalley <sds@tycho.nsa.gov> wro=
te:

<snip>

> >> I'm inclined to just change the behavior for defcontext=3D uncondition=
ally
> >> and have it apply to both native and xattr labeling.  If that's a no-g=
o,
> >> then the simplest solution is to just leave defcontext=3D behavior
> >> unchanged for xattr labeling and only implement the new semantics for
> >> native labeling.  That's just a matter of adding a flag to
> >> security_context_to_sid_default() and only setting it when calling from
> >> selinux_inode_notifysecctx().
> > =

> > Neither option is very appealing to me, but that doesn't mean I'm sayin=
g "no".
> > =

> >  From a sanity and consistency point of view I think option #1 (change
> > the defcontext behavior) is a better choice, and I tend to favor this
> > consistency even with the understanding that it could result in some
> > unexpected behavior for users.  However, if we get complaints, I'm
> > going to revert this without a second thought.
> =

> In that case, I'd suggest splitting it into two patches; first one only =

> enables the new behavior for native labeling filesystems (as per the =

> above, via a flag to security_context_to_sid_default), and the second =

> patch drops the flag and does it unconditionally.  Then you can always =

> revert the latter without affecting the former.
> =

> > =

> > So to answer your question Taras, go ahead and prepare a patch so we
> > can take a look.  A bit of fair warning that it might get delayed
> > until after the upcoming merge window since we are already at -rc5; I
> > want this to have plenty of time in -next.
> > =

> > Thanks guys.

Thanks. I'll prepare patches is a few days.
