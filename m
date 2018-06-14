Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 12C9BC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1D3208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dN+0uC8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1D3208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755433AbeFNRT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 13:19:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33734 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754616AbeFNRTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 13:19:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5EHIwMw034666;
        Thu, 14 Jun 2018 17:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2017-10-26; bh=gKS3zMrtohvQX3O4VlXqEQI5cU2s0XTUIoi3Kn9Lk5A=;
 b=dN+0uC8Cr/c//7r82cG8v3qcScJK4g33UBqRgpWAwrEd7ejSNg/QWKvC1o1I3pIMvKCl
 qAuC7L9r6rjZe2lQt7JZkg+HSMxbK1QUF4mNHvfCI4lFZHabOIJam6q9oovh1u2df3eR
 oBc3kNTIM+Q0pzJ+sP0oflYssLuNWtwLQfHVxtXggqIMuZBIE74lY8rLmdY3UUKztC4S
 QWNwUx6acADuValwLJjr4EmPpcoX8oW/eJkJjunLwoOovI0Gf7RMVJHAIVNVqVKjffEo
 BEKDt4hqhB0focGrNsNKFU/b7UeVPg+D4ECxOBz7ed1wkdVx0no/N2RUYw3Gi6DuxMD1 6Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jk0xre1k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 17:19:11 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5EHJAIN013568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 17:19:10 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5EHJ9W3015678;
        Thu, 14 Jun 2018 17:19:09 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 10:19:09 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] SUNRPC: Move inline xprt_alloc_xid() up to fix compiler
 warning
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1528891298-26694-1-git-send-email-geert@linux-m68k.org>
Date:   Thu, 14 Jun 2018 13:19:07 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <675726D3-9273-4051-B38F-6377B8445A27@oracle.com>
References: <1528891298-26694-1-git-send-email-geert@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: Apple Mail (2.3445.8.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806140190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 13, 2018, at 8:01 AM, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
>=20
> With gcc 4.1.2:
>=20
>    net/sunrpc/xprt.c:69: warning: =E2=80=98xprt_alloc_xid=E2=80=99 =
declared inline after being called
>    net/sunrpc/xprt.c:69: warning: previous declaration of =
=E2=80=98xprt_alloc_xid=E2=80=99 was here
>=20
> To fix this, move the function up, before its caller, and remove the =
no
> longer needed forward declaration.
>=20
> Fixes: 37ac86c3a76c1136 ("SUNRPC: Initialize rpc_rqst outside of =
xprt->reserve_lock")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> net/sunrpc/xprt.c | 11 +++++------
> 1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index 3c85af058227d14b..60a8b9f91cf94b54 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -66,7 +66,6 @@
>  * Local functions
>  */
> static void	 xprt_init(struct rpc_xprt *xprt, struct net *net);
> -static __be32	xprt_alloc_xid(struct rpc_xprt *xprt);
> static void	xprt_connect_status(struct rpc_task *task);
> static int      __xprt_get_cong(struct rpc_xprt *, struct rpc_task *);
> static void     __xprt_put_cong(struct rpc_xprt *, struct rpc_rqst *);
> @@ -956,6 +955,11 @@ static void xprt_timer(struct rpc_task *task)
> 		task->tk_status =3D 0;
> }
>=20
> +static inline __be32 xprt_alloc_xid(struct rpc_xprt *xprt)
> +{
> +	return (__force __be32)xprt->xid++;
> +}
> +
> /**
>  * xprt_prepare_transmit - reserve the transport before sending a =
request
>  * @task: RPC task about to send a request
> @@ -1296,11 +1300,6 @@ void xprt_retry_reserve(struct rpc_task *task)
> 	xprt->ops->alloc_slot(xprt, task);
> }
>=20
> -static inline __be32 xprt_alloc_xid(struct rpc_xprt *xprt)
> -{
> -	return (__force __be32)xprt->xid++;
> -}
> -

For code organization, we might want to keep xprt_alloc_xid
together with xprt_init_xid. Would it be better to simply
remove the "inline" directive from these two and let the
compiler choose the best optimization?


> static inline void xprt_init_xid(struct rpc_xprt *xprt)
> {
> 	xprt->xid =3D prandom_u32();
> --=20
> 2.7.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-nfs" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
Chuck Lever



