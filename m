Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66E1C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31A820815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="npaSBprR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbfACKPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:15:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49846 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfACKPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:15:46 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x03ADhoW033367;
        Thu, 3 Jan 2019 10:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=idOepDtgJ7tjD1tjKHB6BFOc3UICwOu0C0kHa1ZpCG8=;
 b=npaSBprRz0uOZdg0rgPAjpTkGj13a7JxbYUmcm/kgSYN6HYa21oEi6ZBeeU4oAO+DKTp
 taNYRHFq73Ydx5//ZnxTFeqQxeYhr6cOOGmK4LPdlNmv0oGU2JjrlH2cLoe1BxDsI771
 bwzKfTOq256s+/2GtsM6dafNn76w+Daj5Wp8iTZ3LZLEi21qZ/lVjW4Z2bK9YK08Beqw
 wP08rN7SERACNJzCY7xSgOAtJgyrEH2dFnE840W3Y8h+p6OXgVW4txsXXjKF5AX1lRcv
 8/0UX/CMd5PZP1+HcY8nTLVB0lvFBmXqbRXdn+MTpssyc1M43YnSwW0V4CRGQ3wF2hDT qQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2pp1jr68dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jan 2019 10:15:09 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x03AF8qO013477
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Jan 2019 10:15:08 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x03AF5Wo006857;
        Thu, 3 Jan 2019 10:15:06 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 02:15:05 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] netfilter: account ebt_table_info to kmemcg
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190103031431.247970-1-shakeelb@google.com>
Date:   Thu, 3 Jan 2019 03:14:56 -0700
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Westphal <fw@strlen.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <313C6566-289D-4973-BB15-857EED858DA3@oracle.com>
References: <20190103031431.247970-1-shakeelb@google.com>
To:     Shakeel Butt <shakeelb@google.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9124 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901030091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 2, 2019, at 8:14 PM, Shakeel Butt <shakeelb@google.com> wrote:
>=20
> 	countersize =3D COUNTER_OFFSET(tmp.nentries) * nr_cpu_ids;
> -	newinfo =3D vmalloc(sizeof(*newinfo) + countersize);
> +	newinfo =3D __vmalloc(sizeof(*newinfo) + countersize, =
GFP_KERNEL_ACCOUNT,
> +			    PAGE_KERNEL);
> 	if (!newinfo)
> 		return -ENOMEM;
>=20
> 	if (countersize)
> 		memset(newinfo->counters, 0, countersize);
>=20
> -	newinfo->entries =3D vmalloc(tmp.entries_size);
> +	newinfo->entries =3D __vmalloc(tmp.entries_size, =
GFP_KERNEL_ACCOUNT,
> +				     PAGE_KERNEL);
> 	if (!newinfo->entries) {
> 		ret =3D -ENOMEM;
> 		goto free_newinfo;
> --=20

Just out of curiosity, what are the actual sizes of these areas in =
typical use
given __vmalloc() will be allocating by the page?

   =20

