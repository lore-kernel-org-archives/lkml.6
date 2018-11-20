Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86013C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9F3206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q9JcuHaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9F3206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeKTVKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:10:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48580 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbeKTVKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:10:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAKAfM4F162972;
        Tue, 20 Nov 2018 10:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : sender : to : cc : subject : references :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ZRvJh9x3cVXMK5NhxU36PEd9NnuY1dH0bUZ8xvCYRoY=;
 b=Q9JcuHaYofS/5Li90jiJ7RysYSbo5qRgRp+wnhMNKzKfOL0cf+jgZc+MLV5+oAabj962
 s3XIzo+nEGBG9Tu60GxamsSWj9U63CHJGEQHFOhpqxzBxywCSnyeDYBqai17rb90CPfI
 JkQHGpOZXSAzf7zjkdoKlNohSFBhvTj8zE1vx9G6k0sgqTeEx8hsqvd5WoVq9YM/HKe2
 yaCnlH1bYQSeP1uyy166q/LyEdl6jhl5uBZKUaeODgNmtno1IvdCGdgwo9blSp23eD/3
 99e4jH/xD3sNdWaaIJlk9RfhdCPh8zO3yvIJWbT1pJsEKDQ52SDzQ2iFuAsLSHx/7qTX +g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2ntaxq36p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Nov 2018 10:41:55 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAKAfsVT025681
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Nov 2018 10:41:55 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAKAfslY015062;
        Tue, 20 Nov 2018 10:41:54 GMT
MIME-Version: 1.0
Message-ID: <f44a64cc-c267-48e9-8838-4bc7c34fcbda@default>
Date:   Tue, 20 Nov 2018 02:41:52 -0800 (PST)
From:   Manish Kumar Singh <mk.singh@oracle.com>
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, eric.dumazet@gmail.com,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        linux-kernel@vger.kernel.org
Subject: RE: [PATCH] bonding:avoid repeated display of same link status change
References: <20181031105729.7442-1-mk.singh@oracle.com>
 <20181102.233138.738200505012734856.davem@davemloft.net>
 <20181104194121.GA29914@unicorn.suse.cz>
In-Reply-To: <20181104194121.GA29914@unicorn.suse.cz>
X-Priority: 3
X-Mailer: Oracle Beehive Extensions for Outlook 2.0.1.9.1  (1003210) [OL
 14.0.7214.0 (x86)]
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9082 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811200097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Michal Kubecek [mailto:mkubecek@suse.cz]
> Sent: 05 =E0=A4=A8=E0=A4=B5=E0=A4=AE=E0=A5=8D=E0=A4=AC=E0=A4=B0 2018 01:1=
1
> To: David Miller
> Cc: Manish Kumar Singh; netdev@vger.kernel.org; eric.dumazet@gmail.com;
> j.vosburgh@gmail.com; vfalico@gmail.com; andy@greyhouse.net; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] bonding:avoid repeated display of same link status
> change
>=20
> On Fri, Nov 02, 2018 at 11:31:38PM -0700, David Miller wrote:
> > From: mk.singh@oracle.com
> > Date: Wed, 31 Oct 2018 16:27:28 +0530
> >
> > > -=09=09=09if (slave->delay) {
> > > +=09=09=09if (slave->delay &&
> > > +=09=09=09    !atomic64_read(&bond->rtnl_needed)) {
> >  ...
> > > +=09=09=09    !atomic64_read(&bond->rtnl_needed)) {
> >  ...
> > > +=09=09=09atomic64_set(&bond->rtnl_needed, 1);
> >  ...
> > > +=09=09atomic64_set(&bond->rtnl_needed, 0);
> >  ...
> > > @@ -229,6 +229,7 @@ struct bonding {
> > >  =09struct=09 dentry *debug_dir;
> > >  #endif /* CONFIG_DEBUG_FS */
> > >  =09struct rtnl_link_stats64 bond_stats;
> > > +=09atomic64_t rtnl_needed;
> >
> > There is nothing "atomic" about a value that is only set and read.
> >
> > And using a full 64-bit value for something taking on only '0' and
> > '1' is unnecessary as well.
>=20
> Part of the misunderstanding is caused by the fact that this is actually
> a v4 but not marked as such:
>=20
>   v1: https://patchwork.ozlabs.org/patch/955789/
>   v2: https://patchwork.ozlabs.org/patch/970421/
>   v3: https://patchwork.ozlabs.org/patch/988241/
>=20
> When commenting v3, I didn't know about the v2 discussion where Eric
> Dumazet NACKed the patch because of potential conflict issues:
>=20
>   https://patchwork.ozlabs.org/patch/970421/#1992397
>   https://patchwork.ozlabs.org/patch/988241/#2017317
>=20
> On the other hand, there is no need for atomic64_t. Simple atomic_t
> (with explaining comment) would suffice. On architectures allowing
> atomic read/write for 32-bit integers, there would be no performance
> penalty. On architectures not allowing it, atomic_read() and
> atomic_set() are implemented to be safe.

Sorry for late response, I was off to work for couple of weeks.

v3: https://patchwork.ozlabs.org/patch/988241/  was sent with atomic_t and =
after seeing your comment, I sent it with atomic64_t.
Please let me know if v3 was fine ?=20

Thanks,
Manish
>=20
> Michal Kubecek
