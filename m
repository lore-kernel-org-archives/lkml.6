Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8711ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6346D20881
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TbfKbNBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6346D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeGPSrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:47:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37154 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeGPSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:47:51 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6GIDdZ8020640;
        Mon, 16 Jul 2018 18:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=IslcdKrr3frjPywwQY2QA0lj+1HWaRXYU4i/L5z6OxE=;
 b=TbfKbNBHcpWIV/o822UEY6kBdw1yJDNbjHP6XiencfsjqwRLm1xDPZ7Ssnb7qwWUAuFZ
 u+Yq7zqHKoP6j55gLljIXuFy+O44xhOqHbP9ikl5ycOw1qKNmgxGIKqQ+RgW4b3v9qT0
 lsc+n/ZJNvl4ABD7A+Mr7sCReZh/v5FdSki+On6V3umtOjWK0yd1BBYtynk5k86X53iH
 htVg2PQj8Cdr7gIc0E9Ufg0l6lpangrUwYuWx/+DlTPJo8ZnkK0bUNuZ8MqlzxaN2kB7
 5p3OTcwS9LpMox+Z17qTZWdBXsrGEA8ypmdHK6rZKudNsOCmWnAZUTW2x2oirW/qacOQ zg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2k7a3swnku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 18:18:55 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6GIIrqs023569
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 18:18:53 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6GIIpoR001111;
        Mon, 16 Jul 2018 18:18:51 GMT
Received: from dhcp-10-65-136-189.vpn.oracle.com (/10.65.136.189)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Jul 2018 11:18:51 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] IPoIB: use kvzalloc to allocate an array of bucket
 pointers
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20180716191953.28b7821d@virtuozzo.com>
Date:   Mon, 16 Jul 2018 20:18:29 +0200
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Alex Vesker <valex@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Feras Daoud <ferasda@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Evgenii Smirnov <evgenii.smirnov@profitbricks.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF345418-FC8F-4104-88C5-38B7597453B5@oracle.com>
References: <1531144263-24717-1-git-send-email-jan.dakinevich@virtuozzo.com>
 <20180716191953.28b7821d@virtuozzo.com>
To:     Jan Dakinevich <jan.dakinevich@virtuozzo.com>
X-Mailer: Apple Mail (2.3445.8.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=43 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=581
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807160207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 16 Jul 2018, at 18:19, Jan Dakinevich =
<jan.dakinevich@virtuozzo.com> wrote:
>=20
> On Mon,  9 Jul 2018 16:51:03 +0300
> Jan Dakinevich <jan.dakinevich@virtuozzo.com> wrote:
>=20
>> This table by default takes 32KiB which is 3rd memory order.

Only if PAGE_SIZE is 4KiB...

>> Meanwhile, this memory is not aimed for DMA operation and could be
>> safely allocated by vmalloc.
>>=20
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>

lgtm,

Reviewed-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>


Thxs, H=C3=A5kon

>> ---
>> drivers/infiniband/ulp/ipoib/ipoib_main.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c
>> b/drivers/infiniband/ulp/ipoib/ipoib_main.c index 26cde95..cb752df
>> 100644 --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
>> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
>> @@ -1526,7 +1526,7 @@ static int ipoib_neigh_hash_init(struct
>> ipoib_dev_priv *priv) return -ENOMEM;
>> 	set_bit(IPOIB_STOP_NEIGH_GC, &priv->flags);
>> 	size =3D roundup_pow_of_two(arp_tbl.gc_thresh3);
>> -	buckets =3D kcalloc(size, sizeof(*buckets), GFP_KERNEL);
>> +	buckets =3D kvcalloc(size, sizeof(*buckets), GFP_KERNEL);
>> 	if (!buckets) {
>> 		kfree(htbl);
>> 		return -ENOMEM;
>> @@ -1554,7 +1554,7 @@ static void neigh_hash_free_rcu(struct rcu_head
>> *head) struct ipoib_neigh __rcu **buckets =3D htbl->buckets;
>> 	struct ipoib_neigh_table *ntbl =3D htbl->ntbl;
>>=20
>> -	kfree(buckets);
>> +	kvfree(buckets);
>> 	kfree(htbl);
>> 	complete(&ntbl->deleted);
>> }
>=20
> ping
>=20
> --=20
> Best regards
> Jan Dakinevich
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

