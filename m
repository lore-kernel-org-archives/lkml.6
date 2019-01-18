Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2EFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0930E20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfARCAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:00:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfARCAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:00:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2FA7BC06021F;
        Fri, 18 Jan 2019 02:00:16 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B3405ED5A;
        Fri, 18 Jan 2019 02:00:10 +0000 (UTC)
Date:   Fri, 18 Jan 2019 10:00:06 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v3 0/2] let kexec_file_load use platform keyring to
 verify the kernel image
Message-ID: <20190118020006.GB2814@dhcp-128-65.nay.redhat.com>
References: <20190116101654.7288-1-kasong@redhat.com>
 <1547773684.4026.10.camel@linux.ibm.com>
 <20190118013530.GA2814@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190118013530.GA2814@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 18 Jan 2019 02:00:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/18/19 at 09:35am, Dave Young wrote:
> On 01/17/19 at 08:08pm, Mimi Zohar wrote:
> > On Wed, 2019-01-16 at 18:16 +0800, Kairui Song wrote:
> > > This patch series adds a .platform_trusted_keys in system_keyring as the
> > > reference to .platform keyring in integrity subsystem, when platform
> > > keyring is being initialized it will be updated. So other component could
> > > use this keyring as well.
> > 
> > Remove "other component could use ...".
> > > 
> > > This patch series also let kexec_file_load use platform keyring as fall
> > > back if it failed to verify the image against secondary keyring, make it
> > > possible to load kernel signed by third part key if third party key is
> > > imported in the firmware.
> > 
> > This is the only reason for these patches.  Please remove "also".
> > 
> > > 
> > > After this patch kexec_file_load will be able to verify a signed PE
> > > bzImage using keys in platform keyring.
> > > 
> > > Tested in a VM with locally signed kernel with pesign and imported the
> > > cert to EFI's MokList variable.
> > 
> > It's taken so long for me to review/test this patch set due to a
> > regression in sanity_check_segment_list(), introduced somewhere
> > between 4.20 and 5.0.0-rc1.  The sgement overlap test - "if ((mend >
> > pstart) && (mstart < pend))" - fails, returning a -EINVAL.
> > 
> > Is anyone else seeing this?
> 
> Mimi, should be this issue?  I have sent a fix for that.
> https://lore.kernel.org/lkml/20181228011247.GA9999@dhcp-128-65.nay.redhat.com/

Hi, Kairui, I think you should know this while working on this series,
It is good to mention the test dependency in cover letter so that reviewers
can save time.

BTW, Boris took it in tip already:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=993a110319a4a60aadbd02f6defdebe048f7773b

> 
> Thanks
> Dave
