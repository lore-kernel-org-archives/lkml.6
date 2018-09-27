Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA02C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C444216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+wPHUM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C444216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeI1DBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:01:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44518 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeI1DBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:01:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so2687467pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=waefzxO7XWDfnKD7dsKPcOYrLxfYYn7c7E2ZBV5Qslk=;
        b=g+wPHUM6/bXLrrm1b2ySl4mCR/5sVJqO+7apHT1IeHKw+xgSLYQ+tuSM9weOk5k9ix
         piYlgIxaMbOjC0eZDsX8OLcqmbTCegP8NhmmiJVXHdhpLjCsxk0Y6X14p+PHT3+nZAOt
         OYSsEdlaG5DNb33OexL/AWtgmg0DNw5l4jJk11u2Po3pYKVUqGxxF07rHsDYZmeDiaRY
         OzEmF4Kpo467wv7jeDi9Z10MPJ9GzmLgPWNoEfpDM8Et2n5zT4UI59DhBE1X20KnDcC7
         wzpX8WJFMwBsz/FvkqGgO2mlSdfd7EIR21V32V9hT8nRHVHXTPRokHFoDqqLbUvqo99t
         PEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=waefzxO7XWDfnKD7dsKPcOYrLxfYYn7c7E2ZBV5Qslk=;
        b=ZNmAXZ2ONCROCkkLoNfuypiOM1IK9lCL2pPDNheHMMhO3TNLbNragTHvvS6R3X00j6
         HNKhJ6zCZzwxv5OY+nolHIYCpQ/EfGeC1NFBeUPfLEyXoMP1qI6gR5AZNjJrqGcGIDfW
         A26EBW8EwVQtZ4CRBo28+a68i0eGmwMg8m/T+e+Ps/laLsm0527DN9NO60AhYafVcWuO
         /m3MWOIg459SAAqdFXWnOEIZRj2lTJjkoyVjqRlthe7mxVOCHXG5HM0kcEos/V5ctzk8
         yStFpIKciFQuAzWKmImRZyQvpaE3DG/pAFfDBGPIJJNHP/idUmxzkoO4A9zCdI37vne4
         m4sw==
X-Gm-Message-State: ABuFfojU9g13qHycf+O5O46fywWJ5XSE6wqOWC5QLt5YpOyUx3Wpl98f
        hw5d+NypDzMliSsajIJFmWa8xpO4jw0KOHYI0RRvnA==
X-Google-Smtp-Source: ACcGV621d5aAybURnKZNqTECEIbFWEFlxqfOu8t3oNMBu1lgWyiI/GQZ5yTlMjnqXBb9AVPMBKrQL782zVSJIBqsl1U=
X-Received: by 2002:a63:2605:: with SMTP id m5-v6mr11374826pgm.225.1538080901894;
 Thu, 27 Sep 2018 13:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180927011820.13608-1-natechancellor@gmail.com>
 <CAKwvOd=Oe1AAbQKcR+6K7LtZGne+-=3zREs_xVMnEbXBZJDJTQ@mail.gmail.com> <20180927203500.GA12450@flashbox>
In-Reply-To: <20180927203500.GA12450@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Sep 2018 13:41:30 -0700
Message-ID: <CAKwvOdkueN6WrQgo9L4BVgDojUNH6v0HC6TE9S7n_dfOt9DvYA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/qedr: Explicitly cast pkt->tx_dest to qed_ll2_tx_dest
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michal.Kalderon@cavium.com, Ariel.Elior@cavium.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 1:35 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Sep 27, 2018 at 01:28:12PM -0700, Nick Desaulniers wrote:
> > On Wed, Sep 26, 2018 at 6:18 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Clang warns when one enumerated type is explicitly converted to another.
> > >
> > > drivers/infiniband/hw/qedr/qedr_roce_cm.c:198:28: warning: implicit
> > > conversion from enumeration type 'enum qed_roce_ll2_tx_dest' to
> > > different enumeration type 'enum qed_ll2_tx_dest' [-Wenum-conversion]
> > >         ll2_tx_pkt.tx_dest = pkt->tx_dest;
> > >                            ~ ~~~~~^~~~~~~
> > > 1 warning generated.
> > >
> > > Avoid this warning by explicitly casting pkt->tx_dest to
> > > qed_112_tx_dest, which has the expected values from the
> > > type qed_roce_ll2_tx_dest.
> >
> > But these enums are different lengths, which is problematic for this
> > patch.  Is this code broken, or that it's ok for ll2_tx_pkt.tx_dest to
> > have a value that's not a valid enumeration value for enum
> > qed_ll2_tx_dest? (QED_LL2_TX_DEST_MAX 's value (3) is outside the
> > enumeration values of enum qed_roce_ll2_tx_dest).
> >
> > include/linux/qed/qed_rdma_if.h:
> >  42 enum qed_roce_ll2_tx_dest {
> >  43         /* Light L2 TX Destination to the Network */
> >  44         QED_ROCE_LL2_TX_DEST_NW,
> >  45
> >  46         /* Light L2 TX Destination to the Loopback */
> >  47         QED_ROCE_LL2_TX_DEST_LB,
> >  48         QED_ROCE_LL2_TX_DEST_MAX
> >  49 };
> >
> > include/linux/qed/qed_ll2_if.h:
> >  64 enum qed_ll2_tx_dest {
> >  65         QED_LL2_TX_DEST_NW, /* Light L2 TX Destination to the
> > Network */
> >  66         QED_LL2_TX_DEST_LB, /* Light L2 TX Destination to the
> > Loopback */
> >  67         QED_LL2_TX_DEST_DROP, /* Light L2 Drop the TX packet */
> >  68         QED_LL2_TX_DEST_MAX
> >  69 };
> >
> > Maybe the maintainers can clarify?
> >
>
> My assumption was that if QED_ROCE_LL2_TX_DEST_MAX was used that the
> packet would be dropped.
>
> Turns out that QED_ROCE_LL2_TX_DEST_MAX isn't actually used anywhere in
> the tree. I suppose that qed_roce_ll2_tx_dest could just be removed and
> all other instances of those values could be converted to
> qed_ll2_tx_dest like the rxe patch. I'll test this now and send a patch
> along if it works out.

Even better.  Sometimes removing code is the correct solution.  Number
of lines of code and number of bugs are positively correlated, so the
less code sometimes the better.

>
> Nathan
>
> > >
> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  drivers/infiniband/hw/qedr/qedr_roce_cm.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/hw/qedr/qedr_roce_cm.c b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> > > index 85578887421b..147e0d69003d 100644
> > > --- a/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> > > +++ b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> > > @@ -195,7 +195,7 @@ static int qedr_ll2_post_tx(struct qedr_dev *dev,
> > >
> > >         ll2_tx_pkt.num_of_bds = 1 /* hdr */  + pkt->n_seg;
> > >         ll2_tx_pkt.vlan = 0;
> > > -       ll2_tx_pkt.tx_dest = pkt->tx_dest;
> > > +       ll2_tx_pkt.tx_dest = (enum qed_ll2_tx_dest)pkt->tx_dest;
> > >         ll2_tx_pkt.qed_roce_flavor = roce_flavor;
> > >         ll2_tx_pkt.first_frag = pkt->header.baddr;
> > >         ll2_tx_pkt.first_frag_len = pkt->header.len;
> > > --
> > > 2.19.0
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
