Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbeA3VWX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:22:23 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:44624 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbeA3VWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:22:16 -0500
X-Google-Smtp-Source: AH8x227Uto2iOiB3lbgvrxS3teeq103iy0GqiwHq9lWOTQblq1bP44+Tlsejn8TlVLy9TN16rLDWWQ==
Date: Tue, 30 Jan 2018 13:22:13 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        syzbot
        <bot+427f0a9138719ba183c0d37d8c2d070567f7761a@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in xfrm_state_fini
Message-ID: <20180130212213.gvskfv3afboqp4uy@gmail.com>
References: <001a11352f4a2b4fca055e7b441e@google.com>
 <CAM_iQpXBDfdZe4bUu-taidaC1djz7N=AOizEjCpzCeDxuEjPBA@mail.gmail.com>
 <20171127115535.mlsjbrj7pt3d4jvo@gauss3.secunet.de>
 <CAM_iQpVigHJX6hWDGCiJJD0-UouXd3f164e9u6zNCH6+OoNeCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpVigHJX6hWDGCiJJD0-UouXd3f164e9u6zNCH6+OoNeCg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2017 at 09:37:07AM -0800, Cong Wang wrote:
> On Mon, Nov 27, 2017 at 3:55 AM, Steffen Klassert
> <steffen.klassert@secunet.com> wrote:
> > On Tue, Nov 21, 2017 at 06:44:04PM -0800, Cong Wang wrote:
> >> User-space uses proto==0 as a wildcard, but xfrm_id_proto_match()
> >> doesn't consider it as a match with IPSEC_PROTO_ANY, in this case
> >> it should match all. Not sure if the following patch is the best way to
> >> fix it, or perhaps x->id.proto should be initialized to some of these 3
> >> values, but looking into ->init_temprop() it is not the case.
> >
> > x->id is copied from the policy template and it seems that we don't
> > validate the id of the template when inserting the policy. iproute2
> > checks for a valid IPsec proto but the kernel does not do so. I think
> > we should check the policy template and reject inserting if the proto
> > is invalid.
> >
> 
> Oh, I thought 0 is used as wildcard, so it is not.
> 
> Something like below?
> 
> @@ -1445,6 +1446,15 @@ static int validate_tmpl(int nr, struct
> xfrm_user_tmpl *ut, u16 family)
>                 default:
>                         return -EINVAL;
>                 }
> +               switch (ut[i].id.proto) {
> +               case IPPROTO_AH:
> +               case IPPROTO_ESP:
> +               case IPPROTO_COMP:
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +
>         }
> 
>         return 0;
> 

I assume this is supposed to be fixed by the following, so marking it closed for
syzbot:

#syz fix: xfrm: check id proto in validate_tmpl()

But syzbot has been hitting a WARN_ON() in xfrm_state_fini() even after that
fix, so it should get reported as a new bug.
