Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAA4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DC22146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wRbkHUNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfBTRrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:47:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52904 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfBTRrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:47:03 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KHhaNA156635;
        Wed, 20 Feb 2019 17:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=KX8NVaF/HUlwqlE97iRCD+1GywFc7Q2ZBAclBI3TSds=;
 b=wRbkHUNTVwSyv+YskEuW+nPbdBjOSWWArslnvyN2rSPVA6PyJQKyMpvBa/CpeCNifbG8
 Egb+9LN8xneiyD+nmldcS+0Lf4Vjd8r5iLbUoCsZdPNBj3JAOV+fy/ECUTQfEFDCdp4H
 R+X9Riblfex3QHyLG3jX7ehPIzEMEYvv5c/HS1/Z9lxN5Ms3AX04Sxn1wOkonoEVzJg4
 nI9vYKwUPdsBcLRDT+xlNxWOjG76tv5gztW/A04rVhv/Kk5cY2FeNSSkDlNcpPgWQ4Ga
 /1tAiOMNdqZQJdly8pf2AFEGtEf7NPJJ6+APXjMLB+1M20pME8MZWa6xebzjAg9rAYlc Xw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qpb5rk1hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 17:46:55 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KHksb4014772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 17:46:54 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KHkrPe026828;
        Wed, 20 Feb 2019 17:46:53 GMT
Received: from [192.168.10.144] (/51.175.236.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 09:46:52 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] RDMA/mlx4: Spread completion vectors for proxy CQs
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20190220171441.GH8429@ziepe.ca>
Date:   Wed, 20 Feb 2019 18:46:47 +0100
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, jackm@dev.mellanox.co.il,
        majd@mellanox.com, OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7FA2738-ACD2-42C7-A0AF-4343583CF87E@oracle.com>
References: <20190218183302.1242676-1-haakon.bugge@oracle.com>
 <38187795-4082-42C2-AF56-E6C89EE7DE39@oracle.com>
 <66C92ED1-EE5E-4136-A7D7-DBF8A0816800@oracle.com>
 <20190220171441.GH8429@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=933 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 20 Feb 2019, at 18:14, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Tue, Feb 19, 2019 at 06:32:50PM +0100, H=C3=A5kon Bugge wrote:
>>   Anyway, Jason mentioned in a private email that maybe we could use =
the
>>   new completion API or something? I am not familiar with that one
>>   (yet).
>=20
> I was thinking of the stuff in core/cq.c - but it also doesn't have
> automatic comp_vector balancing. It is the logical place to put
> something like that though..
>=20
> An API to manage a bundle of CPU affine CQ's is probably what most
> ULPs really need.. (it makes little sense to create a unique CQ for
> every QP)

ULPs behave way differently. E.g. RDS creates one tx and one rx CQ per =
QP.

As I wrote earlier, we do not have any modify_cq() that changes the =
comp_vector (EQ association). We can balance #CQ associated with the =
EQs, but we do not know their behaviour.

So, assume 2 completion EQs, and four CQs. CQa and CQb are associated =
with the first EQ, the two others with the second EQ. That's the "best" =
we can do. But, if CQa and CQb are the only ones generating events, we =
will have all interrupt processing on a single CPU. But if we now could =
modify CQa.comp_vector to be that of the second EQ, we could achieve =
balance. But not sure if the drivers are able to do this at all.

> alloc_bundle()

You mean alloc a bunch of CQs? How do you know their #cqes and =
cq_context?


H=C3=A5kon


> get_cqn_for_flow(bundle)
> alloc_qp()
> destroy_qp()
> put_cqn_for_flow(bundle)
> destroy_bundle();
>=20
> Let the core code balance the cqn's and allocate (shared) CQ
> resources.
>=20
> Jason

