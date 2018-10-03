Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EF4C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B15A20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B15A20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJDBC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:02:57 -0400
Received: from namei.org ([65.99.196.166]:35396 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeJDBC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:02:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w93ID8Ag015144;
        Wed, 3 Oct 2018 18:13:08 GMT
Date:   Thu, 4 Oct 2018 04:13:08 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LSM <linux-security-module@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Subject: Re: [PATCH v4 14/19] LSM: Infrastructure management of the inode
 security
In-Reply-To: <CAGXu5jL1Ek85Hky+PZ2pGQF09_cd_odn-LanYU=vVKgw24b8vg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1810040409280.13517@namei.org>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <f24ab6a2-aa1d-1c36-9e51-22c924ad37e5@schaufler-ca.com> <CAGXu5jL1Ek85Hky+PZ2pGQF09_cd_odn-LanYU=vVKgw24b8vg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018, Kees Cook wrote:

> On Fri, Sep 21, 2018 at 5:19 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:

> > + * lsm_early_inode - during initialization allocate a composite inode blob
> > + * @inode: the inode that needs a blob
> > + *
> > + * Allocate the inode blob for all the modules if it's not already there
> > + */
> > +void lsm_early_inode(struct inode *inode)
> > +{
> > +       int rc;
> > +
> > +       if (inode == NULL)
> > +               panic("%s: NULL inode.\n", __func__);
> > +       if (inode->i_security != NULL)
> > +               return;
> > +       rc = lsm_inode_alloc(inode);
> > +       if (rc)
> > +               panic("%s: Early inode alloc failed.\n", __func__);
> > +}
> 
> I'm still advising against using panic(), but I'll leave it up to James.
> 

Calling panic() is not appropriate here. Perhaps if it was during 
boot-time initialization of LSM infrastructure, but not on the fly.

Use a WARN_ONCE then propagate the error back and fail the operation.


-- 
James Morris
<jmorris@namei.org>

