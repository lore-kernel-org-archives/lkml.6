Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC4BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CFF2184B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="tsJOvhb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfALAjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 19:39:22 -0500
Received: from mail-40130.protonmail.ch ([185.70.40.130]:61943 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfALAjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 19:39:22 -0500
Date:   Sat, 12 Jan 2019 00:39:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1547253558;
        bh=SrTs9CW5JbaBlOpI50AMxBi8fT2NHsqup6Y3oDTcQiQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=tsJOvhb2jyHLpYTz8chR59WCy2qENkMWLKOt2xdO9IIVWrFmpE5/BqMSTDdBvkpot
         zzdV3lDZeBs6qIDaLIexstK1wRLlpYUenx0HahTcuyWdu1aoBfBkMGOtHQOhkWUxeA
         CVdw7OFZmhQvxcQipggpXmvtwwPBJXrXldNOERug=
To:     Qian Cai <cai@lca.pw>
From:   Esme <esploit@protonmail.ch>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "joeypabalinas@gmail.com" <joeypabalinas@gmail.com>,
        "walken@google.com" <walken@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Esme <esploit@protonmail.ch>
Subject: Re: [PATCH v2] rbtree: fix the red root
Message-ID: <KUuUVBQpzeIgmq4ZQZ9-XpXMPuesw3P5W4RAWrcv1PcYq3JkYhXWq3xhng9p8iCM2L6ec8Bg1hAt5PVh-41wO-hwhyzaxtRbx5tIPdbRwNg=@protonmail.ch>
In-Reply-To: <463fa1f6-4ee6-ef4d-431c-3c392c827792@lca.pw>
References: <20190111181600.GJ6310@bombadil.infradead.org>
 <20190111205843.25761-1-cai@lca.pw>
 <20190111231652.GN6310@bombadil.infradead.org>
 <463fa1f6-4ee6-ef4d-431c-3c392c827792@lca.pw>
Feedback-ID: pQGzDYT_k6dzic_kf3kwsxmTXzjnqMJxtC9J3KGyZBepPHdXRBM0BHuwPfpm1pFdJLAMwtJT5KKNaGlRVnFRQw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been out today but return home tomorrow and can test any suggested fix=
es, or with different kernel settings.  Just let me know.

Esme


Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Friday, January 11, 2019 7:18 PM, Qian Cai <cai@lca.pw> wrote:

> On 1/11/19 6:16 PM, Matthew Wilcox wrote:
>
> > On Fri, Jan 11, 2019 at 03:58:43PM -0500, Qian Cai wrote:
> >
> > > diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
> > > index b7055b2a07d3..afad0213a117 100644
> > > --- a/lib/rbtree_test.c
> > > +++ b/lib/rbtree_test.c
> > > @@ -345,6 +345,17 @@ static int __init rbtree_test_init(void)
> > > check(0);
> > > }
> > >
> > > -   /*
> > > -   -   a little regression test to catch a bug may be introduced by
> > > -   -   6d58452dc06 (rbtree: adjust root color in rb_insert_color() o=
nly when
> > > -   -   necessary)
> > > -   */
> > > -   insert(nodes, &root);
> > > -   nodes->rb.__rb_parent_color =3D RB_RED;
> > > -   insert(nodes + 1, &root);
> > > -   erase(nodes + 1, &root);
> > > -   erase(nodes, &root);
> >
> > That's not a fair test! You're poking around in the data structure to
> > create the situation. This test would have failed before 6d58452dc06 to=
o.
> > How do we create a tree that has a red parent at root, only using inser=
t()
> > and erase()?
>
> If only I knew how to reproduce this myself, I might be able to figure ou=
t how
> it ends up with the red root in the first place.


