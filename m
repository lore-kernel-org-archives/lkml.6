Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A22BC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CDB206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Pi+EHYZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbfAIP1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:27:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42156 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730880AbfAIP1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:27:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so3445993pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 07:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2C2snWHRKLn4kJkXeCP/a0zp+l931OoPJBmot/AY+to=;
        b=Pi+EHYZI8+1oSpoFdQsBOc/c6MrQgQnuh5OclYtJ8xs+7ULX+FfM1A4Cjq6EWahovv
         DoZ+qy6g/3Cps2qzTs9+D6QUr+4TqTcLZMM9vepBc9Sfh+5RT3Ey437A0kDaSlozKrZT
         k3c0AWq23fvEd9fOTemTlyISYThWPBBdUbKT6/mnwdHkH209I084DnU0tYtzbMFXm+eb
         vw2MdD2zyhx+YyGFRXUpt9QLLpXO/6Y03RLNj0Y3PCZRerL3gchzOBALO6LjMQzDIWxx
         NIYuDv2FYJ7RC//2nud0BZhT0HINYs81IlQZZ4AziLrs1o4hKw67r1QEpddBiCNPl81X
         5q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2C2snWHRKLn4kJkXeCP/a0zp+l931OoPJBmot/AY+to=;
        b=RjfqVJowY8WLVwh5892UQlw1vclf1kH8rlW1I2pCB+CXG7aLIRLCCv/gGcEAfk3L+q
         jRABLWjpii2nycJct1ncIhdemvlD5i65wzbYsIy8G6yMy7CDKBUZswDxDPG3sac7AFvC
         NQ1sV5+1hOJMQXQT2AKXbODqG7pK6P3uUMircMfc2HJlxGGye7Os9TsiX24kcm00Iw/s
         mCvcPphUB6/HAadtRreNAeh1APZzcM5/1YF3sp1lAfox4X4Qn72BpWJqj/XEt7CJmuqE
         g3ZeThWfa9bDw6TPNE8RlkLwMfALmiWcqYR5RO/zQamrTh0urD45Y2wGgizFz2V4K7g9
         9gWQ==
X-Gm-Message-State: AJcUukd5lR5sPzzhe6yzoh1Ywy/YANrt74ZuhrnoGZ84f5gWeTCxwPi4
        gAVsHzrEojr62vjXuHiWhgbjCw==
X-Google-Smtp-Source: ALg8bN5PTEFkU4DezniC2nJ1wMZFeOhp+djX6Fu+GXxks1fE0U3Rr6SDT2Jtedp2XLffR6m4r01rjA==
X-Received: by 2002:a63:e80e:: with SMTP id s14mr5796633pgh.30.1547047671865;
        Wed, 09 Jan 2019 07:27:51 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id f62sm88015706pgc.67.2019.01.09.07.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 07:27:50 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ghFll-000255-FV; Wed, 09 Jan 2019 08:27:49 -0700
Date:   Wed, 9 Jan 2019 08:27:49 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Leon Romanovsky <leon@kernel.org>, davem@davemloft.net,
        saeedm@mellanox.com, ogerlitz@mellanox.com, tariqt@mellanox.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, sbest@redhat.com, paulus@samba.org,
        Alexey Kardashevskiy <aik@au1.ibm.com>
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
Message-ID: <20190109152749.GA6890@ziepe.ca>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
 <20181206064509.GM15544@mtr-leonro.mtl.com>
 <20190104034401.GA2801@umbus.fritz.box>
 <20190105175116.GB14238@ziepe.ca>
 <c1296ee9120a6a04dc75d0fdb2a641c722cb65d6.camel@kernel.crashing.org>
 <20190108040129.GE5336@ziepe.ca>
 <012d24d58a542ed44c8af9f517f1bd61ab912037.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012d24d58a542ed44c8af9f517f1bd61ab912037.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 04:09:02PM +1100, Benjamin Herrenschmidt wrote:

> > POWER 8 firmware is good? If the link does eventually come back, is
> > the POWER8's D3 resumption timeout long enough?
> > 
> > If this doesn't lead to an obvious conclusion you'll probably need to
> > connect to IBM's Mellanox support team to get more information from
> > the card side.
> 
> We are IBM :-) So far, it seems to be that the card is doing something
> not quite right, but we don't know what. We might need to engage
> Mellanox themselves.

Sorry, it was unclear, I ment the support team for IBM inside Mellanox
..

There might be internal debugging available that can show if the card
is detecting the beacon, how far it gets in renegotiation, etc.

From all the mails it really has the feel of a PCI-E interop problem between
these two specific chips..

Jason
