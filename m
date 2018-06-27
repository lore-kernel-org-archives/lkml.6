Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEA2C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB3426024
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Sj9wu8ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB3426024
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965325AbeF0O53 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:57:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37415 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965237AbeF0O5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:57:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so5321481wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dGgqXOngg5BvY+VX40bU/0+FLY0Mx+CwdhA7ZRuzLAs=;
        b=Sj9wu8agah5AyFu9MfU4MkccwuSfL/iCc+Id+4lgk11RsZWqa8Iy9fim9NIgxExZe2
         PXYaeSMOl1BQL/YSM2/We5RdwXEEFpN2XqUnCLA0PjTNuAKdQ1pckTE3LpQ0bRJ91TLI
         qjFRblOJM84ySEUFNG/+s/nj/f0tUXCH6gDvF/ikpoPHFecF716d2IvphTcKRMwuKWrB
         UejA7m7TY2nHL+f6OMM3PIURC1A2ApLT0rimWwabPq+9v99/SLnCcC5JvgkLvpkWsIyR
         r71xTlbEohdtxdjttB2CzBOW5ApGYpVh4u8KXSlqQdE6OYdX9CNqFqSS6durlDJxwFBa
         mk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dGgqXOngg5BvY+VX40bU/0+FLY0Mx+CwdhA7ZRuzLAs=;
        b=ZB1w8meAjIl6n3ntBTMf9AEGyxXmyz4x+SFHDA1a66WaQ90eJjyjrbZUl1IE+jKP5V
         lyS7STcvDvEsZwhVaXA5koj0rFV2CjKBDvqZ1BY/wKUVtBIGjPNT8CBoKqvsYgh6JLAG
         AG8lseq8m3seCYp5p01MjnOJpp7dR+bA/7Q4QtMtUmBjuC8TDgmC/gBcVC2NRGM2mE4N
         ojbOkJqi5MXY6euM+zvogqXiLnk+KT2BRURvIaHVBGnxE25fM8cxMKiinmHPt/LATpY0
         EtnFNvqfVAl6ZQRZv8TkNQr20LB9WZl2TCWF0013VJsrwONZmuG14qcDBVPns9Bwp0Es
         nwtw==
X-Gm-Message-State: APt69E2cQ/aCEs3L03/FG1muzJMYCIeKlicHMnp1c9uM/RbGWGnaxDg7
        lPwiSL8MNqHEi5sLDxqkhvVuAw==
X-Google-Smtp-Source: AAOMgpdX1sWYNCh2qvn1Nrs0KkLkt5ZVw31i8k17AKOoCeIYEDITz4sAlWhFufZoLnt3+0o95KQHtQ==
X-Received: by 2002:a1c:2e51:: with SMTP id u78-v6mr5014740wmu.101.1530111443738;
        Wed, 27 Jun 2018 07:57:23 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v19-v6sm3470934wmc.9.2018.06.27.07.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 07:57:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fYBsk-0005aW-Kv; Wed, 27 Jun 2018 08:57:18 -0600
Date:   Wed, 27 Jun 2018 08:57:18 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <john.hubbard@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
Message-ID: <20180627145718.GB20171@ziepe.ca>
References: <d4817192-6db0-2f3f-7c67-6078b69686d3@nvidia.com>
 <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
 <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com>
 <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
 <20180626134757.GY28965@dhcp22.suse.cz>
 <20180626164825.fz4m2lv6hydbdrds@quack2.suse.cz>
 <20180627113221.GO32348@dhcp22.suse.cz>
 <20180627115349.cu2k3ainqqdrrepz@quack2.suse.cz>
 <20180627115927.GQ32348@dhcp22.suse.cz>
 <20180627124255.np2a6rxy6rb6v7mm@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627124255.np2a6rxy6rb6v7mm@quack2.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 02:42:55PM +0200, Jan Kara wrote:
> On Wed 27-06-18 13:59:27, Michal Hocko wrote:
> > On Wed 27-06-18 13:53:49, Jan Kara wrote:
> > > On Wed 27-06-18 13:32:21, Michal Hocko wrote:
> > [...]
> > > > Appart from that, do we really care about 32b here? Big DIO, IB users
> > > > seem to be 64b only AFAIU.
> > > 
> > > IMO it is a bad habit to leave unpriviledged-user-triggerable oops in the
> > > kernel even for uncommon platforms...
> > 
> > Absolutely agreed! I didn't mean to keep the blow up for 32b. I just
> > wanted to say that we can stay with a simple solution for 32b. I thought
> > the g-u-p-longterm has plugged the most obvious breakage already. But
> > maybe I just misunderstood.
> 
> Most yes, but if you try hard enough, you can still trigger the oops e.g.
> with appropriately set up direct IO when racing with writeback / reclaim.

gup longterm is only different from normal gup if you have DAX and few
people do, which really means it doesn't help at all.. AFAIK??

Jason
