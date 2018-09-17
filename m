Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04361ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A233D2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YToh0SeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A233D2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeIRERI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:17:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38943 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeIRERI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:17:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so8089548plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 15:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M+dRHYuAPScmCO8QuacNwKCgBp5JHK4yXncLETnnWyM=;
        b=YToh0SeSYkSlGgY3hl3Mm4chhbX4WUtXfA94rg8076HGzCdAb7dfQzqOaHaTDbM+7L
         +FyxEqvXK/R1g4QtUUE2Bz+xypmStUOLabRWA9ohCVZJ8JVDN9HNOVbj+QTAtbLgqLIZ
         mTFLAdYvRTMisKi2sr7siw9/2yokyVYE5ZKo5g+TxlNdcorDtBQCRwz8I4HE4fztaV2h
         xUwCbhDcVd2pjtSAUg4FP3yXiiCiq7LInjjbK5cBLam3v9aFbVdTaQoe7n0mMLgBHVKo
         h73fHVOhjDPrB+tK6OoLgpRQh4BxATr3wT/339liUny+9wUGOAHurXY8HKcOB/ezHtw1
         s27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M+dRHYuAPScmCO8QuacNwKCgBp5JHK4yXncLETnnWyM=;
        b=HxLQdz1rufzvnlYivPIocV2auufwWMViCNzRemUjLx82nhjvbRv32iv4flgrNnywC0
         lnzWqcjf1MISJAhM45OnWwt+7SgvS0yQICC3/dcAyYmb1IKcyxb7zk7IYiRlybiiEv8+
         6FSkiu4keTrYYckniWOHcB/CwSHuq1iZ4RR3A8l0MqT1wHmO6WQ3mus+hiscHKqXVRSd
         zhjeKQw9cBmEFOjkqgUQFE040jmLLwkWnmL8bFKIWTnGx0+VZ/s6OdJ0NlunLDZnNeys
         XeJFkliSpq8sxNokcgx8mQ0rw9V/b6UtMQeerS7xyjPhZNGl92H3cBYobwqFC0CLGqlF
         i6lA==
X-Gm-Message-State: APzg51BXwqpYQtaOBjR9XUVhIyZSDlGeGj2y+mQJJz7tvU2+KFIgdchi
        p4OOrfcWRCqf7gq+MAEx0rKxdA==
X-Google-Smtp-Source: ANB0Vdapb0lNc7cZJrX2b2oBLWQP4nJZdhDXqIpsGwuzcqDO91J8h41taRn65vgWcgAvT3L92hT6Pw==
X-Received: by 2002:a17:902:a716:: with SMTP id w22-v6mr26926341plq.334.1537224465087;
        Mon, 17 Sep 2018 15:47:45 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id p4-v6sm23368073pfd.65.2018.09.17.15.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 15:47:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g22Ix-0002eY-Ne; Mon, 17 Sep 2018 16:47:43 -0600
Date:   Mon, 17 Sep 2018 16:47:43 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Walker, Benjamin" <benjamin.walker@intel.com>
Cc:     "Howell, Seth" <seth.howell@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monis@mellanox.com" <monis@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
Message-ID: <20180917224743.GG11367@ziepe.ca>
References: <20180814223303.83556-1-seth.howell@intel.com>
 <20180815225021.GB31799@ziepe.ca>
 <EA913ED399BBA34AA4EAC2EDC24CDD008611724E@FMSMSX105.amr.corp.intel.com>
 <20180816180126.GB10507@ziepe.ca>
 <EA913ED399BBA34AA4EAC2EDC24CDD0086118B12@FMSMSX105.amr.corp.intel.com>
 <11f85f780435a5ded567bc8559d7c770d3bc4464.camel@intel.com>
 <20180917210824.GF11367@ziepe.ca>
 <0df4e4958250fd6cdb978005ace970c877269535.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0df4e4958250fd6cdb978005ace970c877269535.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 10:29:18PM +0000, Walker, Benjamin wrote:
> On Mon, 2018-09-17 at 15:08 -0600, Jason Gunthorpe wrote:
> > On Mon, Sep 17, 2018 at 08:38:16PM +0000, Walker, Benjamin wrote:
> > > We've recently run into this same issue on i40iw, which appears to make the
> > > same
> > > mistake of using the kernel version of the enum instead of the userspace
> > > version. 
> > 
> > Confused by this?? i40iw_upost_send does not handle the kernel numbers
> > at all, as far as I can see? How does it develop a kernel dependency??
> > 
> > > What's the current status here? Can it be merged? I just checked and
> > > do not see it merged to Linux master.
> > 
> > Oh! This apparently got lost, thanks for bringing it up again.
> > 
> > > Running a user-space NVMe-oF target with RDMA and a recent Linux kernel
> > > initiator is not currently possible on rxe or i40iw because it requires send
> > > with invalidate support.
> > 
> > Okay, but i40iw doesn't seem to support send with invalidate at all in
> > userspace?
> > 
> > i40iw_upost_send() swithces on opcode, doesn't handle SEND_INV and
> > then blows up in the default clause - how does this patch make any
> > difference???
> 
> It appears I've read the error message incorrectly and was looking at the kernel
> version (i40iw_post_send) as opposed to the user version (i40iw_upost_send).
> Indeed, the NIC does not support SEND_WTIH_INVAL at all in that function. The
> NIC does support SEND_WITH_INVAL in the kernel i40iw_post_send.

OK
 
> What is the correct way for a user space application to check whether a NIC
> supports SEND_WITH_INVAL? We are currently examining the device_cap_flags in the
> structure returned by ibv_query_device. Specifically, we're looking at
> IBV_DEVICE_MEM_MGT_EXTENSIONS. However, for i40iw, that flag is set. I'm
> concerned that the feature support flags are common between user space and the
> kernel, but the actual support differs in this case.

That is the correct thing to do. Sadly the i40iw driver is broken, it
should be fixed to either mask those flags or implement the
functionality.

Jason
