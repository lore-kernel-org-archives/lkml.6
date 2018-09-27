Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42338C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED7F2156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UNfqD23i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED7F2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeI0LWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:22:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32812 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbeI0LWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:22:10 -0400
Received: by mail-io1-f68.google.com with SMTP id l25-v6so1047917ioj.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 22:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K0dpec8DegBsRt1Ph4poszlyIbo4YfIMEdgzA8VRMo8=;
        b=UNfqD23iLJG9st2UmgNWY1ZQYMji2I25Ve+n/1idB5CSJZYGg4TgDZ3ODIgMAQohjU
         ShqhgKSILxjZuItV+GKTSJIPhw8m70/u3ksWC7vcKCX7QWvlRL+lMlHJgzv2Ty4R+IYe
         lxCxmmcMAsx0u5yw6EIWUQuw5gVcpRqD2yQx4ZyTtyCu1BDrvkHKHkBBN2Y/V0B2/RWR
         KNEgO0FH/lRjDuNtQaPvPuX5qU4zIFyKjNwfUfEFSinxrrZ9aMV3avRYswx2dPBmOjVS
         bwLx4A75RHAT8DxPPQMpysv9OdBXUUX0q0CUT/K4fEbLOvrDWmzaZT8MgfQUNS9iPMVW
         tn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K0dpec8DegBsRt1Ph4poszlyIbo4YfIMEdgzA8VRMo8=;
        b=AA4CuIGD+PxIHFDD5olLeMxOgV4S/CqHpK504MOgSA2/numEBL/b6Pg0h/ZB7U+o5i
         ojT42K6od9EkpIpKqtjnAlV8AXXFhiFKx3HIkCperQQflPAVBtn2MYFfybU6s/u133Tb
         lizocmlcEabZe5dYirkgnPUXH1r2tIUJscHUF07lugzVF+wWemg8kJ8OFjhfCH44Y0Z4
         nZ0+47f+37qZw97rcW8mlF0S3S+D79UdDt9v1WyrtKDAgpRuTs0TLYQT2TKcj6tpGmmH
         EkGD5QA02xe6igCqP90fNCT+YnyG1WPaVg6jcr+pahgKW84TtJJUgbSlPaJymwpBvORY
         SD+w==
X-Gm-Message-State: ABuFfojocy9vWLzwsqfDuACIz8k4fQX97z0IpL8eWVtaQYTtZ50hdnrd
        5SpnsVpY7F0Y3+OPbF2J5yXa5w==
X-Google-Smtp-Source: ACcGV61LR6mLE6X8RaP0Ed88zjLEMSa5XSvE10ZjRQEOcDn/jN10RjJWVzozkBWH6fXlxd2ijqHjEg==
X-Received: by 2002:a6b:93d4:: with SMTP id v203-v6mr7475116iod.171.1538024748649;
        Wed, 26 Sep 2018 22:05:48 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v82-v6sm396712iod.14.2018.09.26.22.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 22:05:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g5OUl-0006sM-6H; Wed, 26 Sep 2018 23:05:47 -0600
Date:   Wed, 26 Sep 2018 23:05:47 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] IB/rxe: Avoid implicit enum conversions in rxe_init
 functions
Message-ID: <20180927050547.GD24889@ziepe.ca>
References: <20180927011010.8373-1-natechancellor@gmail.com>
 <20180927050156.20023-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927050156.20023-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:01:57PM -0700, Nathan Chancellor wrote:
> Clang warns when an emumerated type is implicitly converted to another.
> 
> drivers/infiniband/sw/rxe/rxe.c:106:27: warning: implicit conversion
> from enumeration type 'enum rxe_device_param' to different enumeration
> type 'enum ib_atomic_cap' [-Wenum-conversion]
>         rxe->attr.atomic_cap                    = RXE_ATOMIC_CAP;
>                                                 ~ ^~~~~~~~~~~~~~
> drivers/infiniband/sw/rxe/rxe.c:131:22: warning: implicit conversion
> from enumeration type 'enum rxe_port_param' to different enumeration
> type 'enum ib_port_state' [-Wenum-conversion]
>         port->attr.state                = RXE_PORT_STATE;
>                                         ~ ^~~~~~~~~~~~~~
> drivers/infiniband/sw/rxe/rxe.c:132:24: warning: implicit conversion
> from enumeration type 'enum rxe_port_param' to different enumeration
> type 'enum ib_mtu' [-Wenum-conversion]
>         port->attr.max_mtu              = RXE_PORT_MAX_MTU;
>                                         ~ ^~~~~~~~~~~~~~~~
> drivers/infiniband/sw/rxe/rxe.c:133:27: warning: implicit conversion
> from enumeration type 'enum rxe_port_param' to different enumeration
> type 'enum ib_mtu' [-Wenum-conversion]
>         port->attr.active_mtu           = RXE_PORT_ACTIVE_MTU;
>                                         ~ ^~~~~~~~~~~~~~~~~~~
> drivers/infiniband/sw/rxe/rxe.c:151:24: warning: implicit conversion
> from enumeration type 'enum rxe_port_param' to different enumeration
> type 'enum ib_mtu' [-Wenum-conversion]
>                                 ib_mtu_enum_to_int(RXE_PORT_ACTIVE_MTU);
>                                 ~~~~~~~~~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~~
> 5 warnings generated.
> 
> Use the appropriate values from the expected enumerated type so no
> conversion needs to happen.
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> v1 -> v2:
> 
> * Don't cast, just use the expecting enumerated value directly, per
>   Jason's request
> 
>  drivers/infiniband/sw/rxe/rxe.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 10999fa69281..2f4e57886b89 100644
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -103,7 +103,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>  	rxe->attr.max_res_rd_atom		= RXE_MAX_RES_RD_ATOM;
>  	rxe->attr.max_qp_init_rd_atom		= RXE_MAX_QP_INIT_RD_ATOM;
>  	rxe->attr.max_ee_init_rd_atom		= RXE_MAX_EE_INIT_RD_ATOM;
> -	rxe->attr.atomic_cap			= RXE_ATOMIC_CAP;
> +	rxe->attr.atomic_cap			= IB_ATOMIC_HCA;
>  	rxe->attr.max_ee			= RXE_MAX_EE;
>  	rxe->attr.max_rdd			= RXE_MAX_RDD;
>  	rxe->attr.max_mw			= RXE_MAX_MW;
> @@ -128,9 +128,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>  /* initialize port attributes */
>  static int rxe_init_port_param(struct rxe_port *port)
>  {
> -	port->attr.state		= RXE_PORT_STATE;
> -	port->attr.max_mtu		= RXE_PORT_MAX_MTU;
> -	port->attr.active_mtu		= RXE_PORT_ACTIVE_MTU;
> +	port->attr.state		= IB_PORT_DOWN;
> +	port->attr.max_mtu		= IB_MTU_4096;
> +	port->attr.active_mtu		= IB_MTU_256;
>  	port->attr.gid_tbl_len		= RXE_PORT_GID_TBL_LEN;
>  	port->attr.port_cap_flags	= RXE_PORT_PORT_CAP_FLAGS;
>  	port->attr.max_msg_sz		= RXE_PORT_MAX_MSG_SZ;
> @@ -147,8 +147,7 @@ static int rxe_init_port_param(struct rxe_port *port)
>  	port->attr.active_width		= RXE_PORT_ACTIVE_WIDTH;
>  	port->attr.active_speed		= RXE_PORT_ACTIVE_SPEED;
>  	port->attr.phys_state		= RXE_PORT_PHYS_STATE;
> -	port->mtu_cap			=
> -				ib_mtu_enum_to_int(RXE_PORT_ACTIVE_MTU);
> +	port->mtu_cap			= ib_mtu_enum_to_int(IB_MTU_256);
>  	port->subnet_prefix		= cpu_to_be64(RXE_PORT_SUBNET_PREFIX);
>  
>  	return 0;

These are the only place some of these values are used, so declaration
should be eliminated as well.

Jason
