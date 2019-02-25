Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A570C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78D720684
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tfEY0EfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfBYRXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:23:31 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34046 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbfBYRXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:23:31 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1PHMlVB104195;
        Mon, 25 Feb 2019 17:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=yBekJxAdlkuKuX4YTvX9CLT645PHMBqH5P7Kf1WkjGI=;
 b=tfEY0EfK4yPU8Kq48KfcCH4tqVSFSjBJ0ovBGOSs9tJ/9RH5S8S2SOI4CjUhO79GJ4o+
 BC5W1xqxuubYud7r0sl7trQqQ1zDCXoIC0e7BEFaIiBtfEpzJZLk6hB9YX6kyiOjiUfT
 zvi8dUwMOmEF73r6MOYUgJOHMeGPJXVsOsE1lagKKmxRsEVmCUsgpp8TaGutgNRk2El4
 qnxWt/5bHS2W5Osik4b5T3LCK04/uyI8ixnLMeTnIuxyY6DZXlZRvPbnxBUjHpZKYoee
 CYQi3FQjL9WVzMgd4VFC2PQ0yj31tJyxiaDaIabGlLZbCE2QMyr2UkTb3E8cYEa36xWy Gw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qtupdyq6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Feb 2019 17:23:22 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1PHNGrN017114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Feb 2019 17:23:16 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1PHNFkN005664;
        Mon, 25 Feb 2019 17:23:15 GMT
Received: from dhcp-10-65-172-220.vpn.oracle.com (/10.65.172.220)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Feb 2019 09:23:15 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] RDMA/cma: Make CM response timeout and # CM retries
 configurable
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20190223084930.GJ23561@mtr-leonro.mtl.com>
Date:   Mon, 25 Feb 2019 18:23:10 +0100
Cc:     Doug Ledford <dledford@redhat.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD80B9E9-1A6C-457D-8B51-B4A97DBE3469@oracle.com>
References: <20190217170909.1178575-1-haakon.bugge@oracle.com>
 <20190222163637.GA9819@ziepe.ca>
 <afadc799-b547-5c20-64d2-75fa0f64cd9e@opengridcomputing.com>
 <C7922E85-CA43-479A-8021-DADD59FF5BE7@redhat.com>
 <20190223084930.GJ23561@mtr-leonro.mtl.com>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9178 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902250127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 23 Feb 2019, at 09:49, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Fri, Feb 22, 2019 at 12:51:55PM -0500, Doug Ledford wrote:
>>=20
>>=20
>>> On Feb 22, 2019, at 12:14 PM, Steve Wise =
<swise@opengridcomputing.com> wrote:
>>>=20
>>>=20
>>> On 2/22/2019 10:36 AM, Jason Gunthorpe wrote:
>>>> On Sun, Feb 17, 2019 at 06:09:09PM +0100, H=C3=A5kon Bugge wrote:
>>>>> During certain workloads, the default CM response timeout is too
>>>>> short, leading to excessive retries. Hence, make it configurable
>>>>> through sysctl. While at it, also make number of CM retries
>>>>> configurable.
>>>>>=20
>>>>> The defaults are not changed.
>>>>>=20
>>>>> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>>>>> drivers/infiniband/core/cma.c | 51 =
++++++++++++++++++++++++++++++-----
>>>>> 1 file changed, 44 insertions(+), 7 deletions(-)
>>>>>=20
>>>>> diff --git a/drivers/infiniband/core/cma.c =
b/drivers/infiniband/core/cma.c
>>>>> index c43512752b8a..ce99e1cd1029 100644
>>>>> +++ b/drivers/infiniband/core/cma.c
>>>>> @@ -43,6 +43,7 @@
>>>>> #include <linux/inetdevice.h>
>>>>> #include <linux/slab.h>
>>>>> #include <linux/module.h>
>>>>> +#include <linux/sysctl.h>
>>>>> #include <net/route.h>
>>>>>=20
>>>>> #include <net/net_namespace.h>
>>>>> @@ -68,13 +69,46 @@ MODULE_AUTHOR("Sean Hefty");
>>>>> MODULE_DESCRIPTION("Generic RDMA CM Agent");
>>>>> MODULE_LICENSE("Dual BSD/GPL");
>>>>>=20
>>>>> -#define CMA_CM_RESPONSE_TIMEOUT 20
>>>>> #define CMA_QUERY_CLASSPORT_INFO_TIMEOUT 3000
>>>>> -#define CMA_MAX_CM_RETRIES 15
>>>>> #define CMA_CM_MRA_SETTING (IB_CM_MRA_FLAG_DELAY | 24)
>>>>> #define CMA_IBOE_PACKET_LIFETIME 18
>>>>> #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
>>>>>=20
>>>>> +#define CMA_DFLT_CM_RESPONSE_TIMEOUT 20
>>>>> +static int cma_cm_response_timeout =3D =
CMA_DFLT_CM_RESPONSE_TIMEOUT;
>>>>> +static int cma_cm_response_timeout_min =3D 8;
>>>>> +static int cma_cm_response_timeout_max =3D 31;
>>>>> +#undef CMA_DFLT_CM_RESPONSE_TIMEOUT
>>>>> +
>>>>> +#define CMA_DFLT_MAX_CM_RETRIES 15
>>>>> +static int cma_max_cm_retries =3D CMA_DFLT_MAX_CM_RETRIES;
>>>>> +static int cma_max_cm_retries_min =3D 1;
>>>>> +static int cma_max_cm_retries_max =3D 100;
>>>>> +#undef CMA_DFLT_MAX_CM_RETRIES
>>>>> +
>>>>> +static struct ctl_table_header *cma_ctl_table_hdr;
>>>>> +static struct ctl_table cma_ctl_table[] =3D {
>>>>> +	{
>>>>> +		.procname	=3D "cma_cm_response_timeout",
>>>>> +		.data		=3D &cma_cm_response_timeout,
>>>>> +		.maxlen		=3D sizeof(cma_cm_response_timeout),
>>>>> +		.mode		=3D 0644,
>>>>> +		.proc_handler	=3D proc_dointvec_minmax,
>>>>> +		.extra1		=3D &cma_cm_response_timeout_min,
>>>>> +		.extra2		=3D &cma_cm_response_timeout_max,
>>>>> +	},
>>>>> +	{
>>>>> +		.procname	=3D "cma_max_cm_retries",
>>>>> +		.data		=3D &cma_max_cm_retries,
>>>>> +		.maxlen		=3D sizeof(cma_max_cm_retries),
>>>>> +		.mode		=3D 0644,
>>>>> +		.proc_handler	=3D proc_dointvec_minmax,
>>>>> +		.extra1		=3D &cma_max_cm_retries_min,
>>>>> +		.extra2		=3D &cma_max_cm_retries_max,
>>>>> +	},
>>>>> +	{ }
>>>>> +};
>>>> Is sysctl the right approach here? Should it be rdma tool instead?
>>>>=20
>>>> Jason
>>>=20
>>> There are other rdma sysctls currently:  net.rdma_ucm.max_backlog =
and
>>> net.iw_cm.default_backlog.  The core network stack seems to use =
sysctl
>>> and not ip tool to set basically globals.
>>>=20
>>> To use rdma tool, we'd have to have some concept of a "module" =
object, I
>>> guess.  IE there's dev, link, and resource rdma tool objects =
currently.
>>> But these cma timeout settings are really not per dev, link, nor a
>>> resource.   Maybe we have just a "core" object:  rdma core set
>>> cma_max_cm_retries min 8 max 30.
>>=20
>> I don=E2=80=99t know, I think you make a fairly good argument for =
leaving it as a sysctl.  We have infrastructure in place for admins to =
set persistent sysctl settings.  The per device/link settings need =
something different because link names and such can change.  Since these =
are globals, I=E2=80=99d leave them where they are.
>>=20
>=20
> I have patches from Parav which extend rdmatool to set global to whole
> stack parameters, something like "rdma system ...", so the option to
> set through rdmatool global parameters for modules e.g. "rdma system =
cma set ..."
> exists. But I'm not sure if it is right thing to do.

If decided to for the sysctl flavour, I must just say: ahem, ahem, I =
forgot to put in a unregister_net_sysctl_table() in cma_cleanup(). Will =
send a v2.


Thxs, H=C3=A5kon

>=20
>> --
>> Doug Ledford <dledford@redhat.com>
>>    GPG KeyID: B826A3330E572FDD
>>    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 =
2FDD

