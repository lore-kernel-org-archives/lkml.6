Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103CDC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD6E20875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD6E20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966502AbeFSOgT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:36:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750816AbeFSOgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:36:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BB027DAC5;
        Tue, 19 Jun 2018 14:36:17 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A63A11166E5;
        Tue, 19 Jun 2018 14:36:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4AED02209E8; Tue, 19 Jun 2018 10:36:17 -0400 (EDT)
Date:   Tue, 19 Jun 2018 10:36:17 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org,
        Daniel Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: overlayfs: caller_credentials option bypass creator_cred
Message-ID: <20180619143617.GC22657@redhat.com>
References: <20180618154222.19279-1-salyzyn@android.com>
 <20180618185448.GA8749@redhat.com>
 <f141f883-0dbd-10ea-83b9-a1b38119b0c5@android.com>
 <20180618194345.GA15973@redhat.com>
 <aecdeaca-74cf-54b1-3ea9-4751972074f5@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aecdeaca-74cf-54b1-3ea9-4751972074f5@android.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 19 Jun 2018 14:36:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 19 Jun 2018 14:36:17 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vgoyal@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 02:59:50PM -0700, Mark Salyzyn wrote:
> On 06/18/2018 12:43 PM, Vivek Goyal wrote:
> > Will it be acceptable to write security policies in such a way so that
> > mounter has access as well.
> Unfortunately No. Policy of minimizing attack surface for a contained root
> service (init in this case). Just because it can mount, does not mean it can
> modify critical content; an attacker could use this to open a hole.
> 
> > Current model does assume that mounter has privileges on underlying files.
> 
> Only ones it appears to need is the workdir AFAIK, had to add ability to
> create in the <wordir> xattr in order to enable r/w mounts later. Although
> not all corners were tested, I did not see any copy_up issues b/c the caller
> had the privs in the Android security model when mounted with this new flag.

So in this system all callers are priviliged and have the capability to
mknod and set trusted xattrs. (Amir mentioned the reason why we switch
creds). If not, then file unlink (Should do mknod), lower non-empty directory
rename (should set trusted REDIRECT) and bunch of other operations should fail.

Thanks
Vivek
