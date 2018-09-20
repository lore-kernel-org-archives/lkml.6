Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D07ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E162E21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E162E21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbeITP1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:27:48 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:36522 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726669AbeITP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:27:48 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1g2vW6-0002MW-Ca; Thu, 20 Sep 2018 11:44:58 +0200
Date:   Thu, 20 Sep 2018 11:44:58 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Christian =?iso-8859-15?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     fw@strlen.de, casey@schaufler-ca.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, davem@davemloft.net,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, jmorris@namei.org,
        serge@hallyn.com, selinux <selinux@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] netfilter: nf_tables: add SECMARK support
Message-ID: <20180920094458.6hwaw3vgfsxvcgb4@breakpoint.cc>
References: <20180919231402.4482-1-cgzones@googlemail.com>
 <75b3fed9-e549-4ed0-c435-ec4795fc1e39@schaufler-ca.com>
 <20180920085048.tps2v4jkko7zjav4@breakpoint.cc>
 <CAJ2a_DfGCRXaH9BkBj=0R1Cr3jiHQHgq-pU2HGuWudvWCSKLQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ2a_DfGCRXaH9BkBj=0R1Cr3jiHQHgq-pU2HGuWudvWCSKLQg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Göttsche <cgzones@googlemail.com> wrote:
> > Fixes should go into nf.git whereas feature goes to nf-next.git.
> 
> No, that should not be a unroll fix.
> Currently there are no objects registered by the main nf_tables
> module, so for nft_secmark_obj_type I had to introduce this new logic.

I see, ok.

> > > > +   if (err) {
> > > > +           if (err == -EINVAL)
> > > > +                   pr_notice_ratelimited("invalid security context \'%s\'\n", priv->ctx);
> > > > +           else
> > > > +                   pr_notice_ratelimited("unable to convert security context \'%s\': %d\n", priv->ctx, -err);
> > > > +           return;
> > > > +   }
> >
> > Please remove these printks(), they do not really help as user can't
> > take any action anyway.
> 
> Aren't they helpful?
> "invalid security context" can pop up if someone supplies an invalid
> SELinux context (nft add secmark inet filter sshtag
> \"this_is_invalid\") and uses it

Can't that be caught at ->init() time?
We can then reject this via plain -EINVAL.

No need for printk because caller knows which expression/object caused
the error.

> "unable to convert security context" can pop up if no LSM is enabled

Can that be done at ->init() time when we can still reject the (invalid)
rule?

> "unable to map security context" should never happen, but one never knows

Ok, but what is user supposed to do?
This just causes perpetual spew of warnings in the kernel ring buffer.

> "unable to obtain relabeling permission" can pop up if e.g. the
> SELinux permission "kernel_t ssh_server_packet:packet relabelto" is
> missing

Makes sense, but this will need to be a plain
return -EPERM, this function can only be used in process context.
