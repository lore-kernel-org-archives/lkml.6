Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE3CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E969C20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfAOCmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:42:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbfAOCmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 21:42:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D38D93DE03;
        Tue, 15 Jan 2019 02:42:53 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-57.pek2.redhat.com [10.72.12.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AF3B84ED;
        Tue, 15 Jan 2019 02:42:47 +0000 (UTC)
Date:   Tue, 15 Jan 2019 10:42:43 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
Message-ID: <20190115024243.GA9199@dhcp-128-65.nay.redhat.com>
References: <20190109164824.19708-1-kasong@redhat.com>
 <20190109164824.19708-3-kasong@redhat.com>
 <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
 <1547223220.19931.471.camel@linux.ibm.com>
 <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
 <1547482251.4156.127.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547482251.4156.127.camel@linux.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 15 Jan 2019 02:42:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/14/19 at 11:10am, Mimi Zohar wrote:
> On Sun, 2019-01-13 at 09:39 +0800, Dave Young wrote:
> > Hi,
> > 
> > On 01/11/19 at 11:13am, Mimi Zohar wrote:
> > > On Fri, 2019-01-11 at 21:43 +0800, Dave Young wrote:
> > > [snip]
> > > 
> > > > Personally I would like to see platform key separated from integrity.
> > > > But for the kexec_file part I think it is good at least it works with
> > > > this fix.
> > > > 
> > > > Acked-by: Dave Young <dyoung@redhat.com>
> > > 
> > > The original "platform" keyring patches that Nayna posted multiple
> > > times were in the certs directory, but nobody commented/responded.  So
> > > she reworked the patches, moving them to the integrity directory and
> > > posted them (cc'ing the kexec mailing list).  It's a bit late to be
> > > asking to move it, isn't it?
> > 
> > Hmm, apologize for being late,  I did not get chance to have a look the
> > old series.  Since we have the needs now, it should be still fine
> > 
> > Maybe Kairui can check Nayna's old series, see if he can do something
> > again?
> 
> Whether the platform keyring is defined in certs/ or in integrity/ the
> keyring id needs to be accessible to the other, without making the
> keyring id global.  Moving where the platform keyring is defined is
> not the problem.

Agreed, but just feel kexec depends on IMA sounds not good.

> 
> Commit a210fd32a46b ("kexec: add call to LSM hook in original
> kexec_load syscall") introduced a new LSM hook.  Assuming
> CONFIG_KEXEC_VERIFY_SIG is enabled, with commit b5ca117365d9 ("ima:
> prevent kexec_load syscall based on runtime secureboot flag") we can
> now block the kexec_load syscall.  Without being able to block the
> kexec_load syscall, verifying the kexec image signature via the
> kexec_file_load syscall is kind of pointless.
> 
> Unless you're planning on writing an LSM to prevent the kexec_load
> syscall, I assume you'll want to enable integrity anyway.

User can disable kexec_load in kernel config, and only allow
kexec_file_load.  But yes, this can be improved separately in case no
IMA enabled.

For the time being we can leave with it and fix like this series do.

> 
> Mimi
> 

Thanks
Dave
