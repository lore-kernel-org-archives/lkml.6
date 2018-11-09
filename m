Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4984DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B5C20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B5C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeKJBBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:01:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbeKJBBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:01:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D22C585A07;
        Fri,  9 Nov 2018 15:20:41 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C1575D738;
        Fri,  9 Nov 2018 15:20:41 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1AEA02239AE; Fri,  9 Nov 2018 10:20:41 -0500 (EST)
Date:   Fri, 9 Nov 2018 10:20:41 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v8 2/2] overlayfs: override_creds=off option bypass
 creator_cred
Message-ID: <20181109152041.GC28565@redhat.com>
References: <20181106230117.127616-1-salyzyn@android.com>
 <20181106230117.127616-2-salyzyn@android.com>
 <20181108200106.GB3663@redhat.com>
 <b057da99-adc6-b355-fb57-b314a29f298f@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b057da99-adc6-b355-fb57-b314a29f298f@android.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 09 Nov 2018 15:20:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:28:32PM -0800, Mark Salyzyn wrote:
> On 11/08/2018 12:01 PM, Vivek Goyal wrote:
> > On Tue, Nov 06, 2018 at 03:01:15PM -0800, Mark Salyzyn wrote:
> > > By default, all access to the upper, lower and work directories is the
> > > recorded mounter's MAC and DAC credentials.  The incoming accesses are
> > > checked against the caller's credentials.
> > Ok, I am trying to think of scenarios where override_creds=off can
> > provide any privilege escalation. How about following.
> > 
> > $ mkdir lower lower/foo upper upper/foo work merged
> > $ touch lower/foo/bar.txt
> > $ chmod 700 lower/foo/
> > 
> > # Mount overlay with override_creds=off
> > 
> > $ mount -t overlay -o
> > lowerdir=lower,upperdir=upper,workdir=work,override_creds=off none merged
> > 
> > # Try to read lower/foo as unpriviliged user. Say "test"
> > # su test
> > # ls merged/foo/
> > ls: cannot access 'merged/foo/': Operation not permitted
> > 
> > # Now first try to do same operation as root and retry as test user.
> > $ exit
> > $ ls merged/foo
> > bar.txt
> > $ su test
> > $ ls merged/foo
> > bar.txt
> > 
> > lower/foo/ is not readable by user "test". So it fails in first try. Later
> > "root" accesses it and it populates cache in overlayfs. When test retries,
> > it gets these entries from cache.
> > 
> > With override_creds=on this is not a problem because overlay provides
> > this as functionality as long as mounter as access to lower/foo/.
> > 
> > But with override_creds=off, mounter is not providing any such
> > functionality and we are exposing an issue where cache will make
> > something available which is not normally available.
> > 
> > I think it probably is a good idea to do something about it?
> > 
> > Thanks
> > Vivek
> > 
> Good stuff.
> 
> That sounds like a bug in cache (!) to not recheck caller's credentials.
> Currently unsure how/where to force bypass of the cache (performance hit) as
> it is wired in throughout the code without a clear off switch, or rechecking
> of the credentials at access. This does need to be addressed to make this
> 'feature' more useful/trusted for non-MAC controlled, use cases.

DAC is just an example. There is no reason same issue will not happen
with MAC? Proacess A with correct MAC priviliges will fill overlay
cache and process B without correct MAC priviliges will still be able
to get information about dentry.

As Amir suggested, for now documenting this probably is fine. I can't
think of any other good options either. May be Miklos has some ideas here.

Thanks
Vivek

