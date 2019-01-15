Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA51C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AB520659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfAODKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:10:40 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39925 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfAODKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:10:40 -0500
Received: by mail-io1-f67.google.com with SMTP id k7so980222iob.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 19:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uy3xsSEkdFItylJFlXuflVfudm2wfRKBNUCSc1wA8iY=;
        b=c1v55vWPqffWXhOMUcEEo0rOWfG6caH7vi9iAdTvuT++QOEP2PpMKD0BdeklV3UggK
         Xj4ODMs2f258IzXfv7DYA3sZs7TMS/tWn+Jz8jXqe59/dIAfA9gNqRD0S6E+eyoI7rsm
         ij8lmvRouEY2bGOIWEFBuYcSE+tJko8tcE5i8XjQWNGX1neabigkyRTVjnkYZWFMe90D
         zKfziZXgy9ez/vhZVmeMNFkeG4JilY+rJamRhxhhcUj75BZHMdCRTGTEyyewZlMnZpoX
         jYMLZH63TDbfgHEJk8roOPEyfw8F8VUB+trLqxKleR6K8b/yddL00zgpQTw6cPacHsFv
         wQHA==
X-Gm-Message-State: AJcUukd87pDMkoiYSGfylm90NfnqQn9gXazCzidqTHzdOEN/haAZ7Bcd
        7HTn3WqfAeJuZSpd4dZM5Ea321cn9a2APmr4hP1i2g==
X-Google-Smtp-Source: ALg8bN4cJ7cvjpuC+kWOhjityi9IfExPxd6vaMwXU4FAZG5IdvT/3aDpFlcDMpJq0MJg+s2qarwVewxONVss1GsP0hw=
X-Received: by 2002:a5e:de01:: with SMTP id e1mr892468iok.137.1547521838805;
 Mon, 14 Jan 2019 19:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20190109164824.19708-1-kasong@redhat.com> <20190109164824.19708-3-kasong@redhat.com>
 <20190111134303.GA12760@dhcp-128-65.nay.redhat.com> <1547223220.19931.471.camel@linux.ibm.com>
 <20190113013958.GA14019@dhcp-128-65.nay.redhat.com> <1547482251.4156.127.camel@linux.ibm.com>
 <20190115024243.GA9199@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190115024243.GA9199@dhcp-128-65.nay.redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Tue, 15 Jan 2019 11:10:27 +0800
Message-ID: <CACPcB9etik_o1SbyROKdFYTkJfpGKbTx5oANFZEi7AAvBv3NXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:42 AM Dave Young <dyoung@redhat.com> wrote:
>
> On 01/14/19 at 11:10am, Mimi Zohar wrote:
> > On Sun, 2019-01-13 at 09:39 +0800, Dave Young wrote:
> > > Hi,
> > >
> > > On 01/11/19 at 11:13am, Mimi Zohar wrote:
> > > > On Fri, 2019-01-11 at 21:43 +0800, Dave Young wrote:
> > > > [snip]
> > > >
> > > > > Personally I would like to see platform key separated from integrity.
> > > > > But for the kexec_file part I think it is good at least it works with
> > > > > this fix.
> > > > >
> > > > > Acked-by: Dave Young <dyoung@redhat.com>
> > > >
> > > > The original "platform" keyring patches that Nayna posted multiple
> > > > times were in the certs directory, but nobody commented/responded.  So
> > > > she reworked the patches, moving them to the integrity directory and
> > > > posted them (cc'ing the kexec mailing list).  It's a bit late to be
> > > > asking to move it, isn't it?
> > >
> > > Hmm, apologize for being late,  I did not get chance to have a look the
> > > old series.  Since we have the needs now, it should be still fine
> > >
> > > Maybe Kairui can check Nayna's old series, see if he can do something
> > > again?
> >
> > Whether the platform keyring is defined in certs/ or in integrity/ the
> > keyring id needs to be accessible to the other, without making the
> > keyring id global.  Moving where the platform keyring is defined is
> > not the problem.
>
> Agreed, but just feel kexec depends on IMA sounds not good.
>
> >
> > Commit a210fd32a46b ("kexec: add call to LSM hook in original
> > kexec_load syscall") introduced a new LSM hook.  Assuming
> > CONFIG_KEXEC_VERIFY_SIG is enabled, with commit b5ca117365d9 ("ima:
> > prevent kexec_load syscall based on runtime secureboot flag") we can
> > now block the kexec_load syscall.  Without being able to block the
> > kexec_load syscall, verifying the kexec image signature via the
> > kexec_file_load syscall is kind of pointless.
> >
> > Unless you're planning on writing an LSM to prevent the kexec_load
> > syscall, I assume you'll want to enable integrity anyway.
>
> User can disable kexec_load in kernel config, and only allow
> kexec_file_load.  But yes, this can be improved separately in case no
> IMA enabled.
>
> For the time being we can leave with it and fix like this series do.
>
> >
> > Mimi
> >
>
> Thanks
> Dave

Yes, for now, I think it's good to fix the problem by following this
patch series and get kexec_file_load work with platform keyring first.
Will adopt suggestion from Mimi in the previous reply and update the
patch series.

For other remaining potential issues, kexec_load not being protected,
it could be disabled by config, and the improvement may require more
discussion. And issues like where the keyring is located, dependency
to making the keyring available for more general use could be
discussed later.

--
Best Regards,
Kairui Song
