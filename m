Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7334C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DEE2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mdjtFntG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfBSRjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:39:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35790 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfBSRjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:39:13 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1JHT4eG144171;
        Tue, 19 Feb 2019 17:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=6fJGNQ+ZGPRuyfkEBLNdXDDLMHkU6ATzUEjggNVV4ps=;
 b=mdjtFntGflMeDWn2SdNvk/avKSqPMh5L0Av+lj0KhSvO4Z6NZLfZ7FSJUHudL2za51UD
 wzQ7EECCuj2JhwtAiMTRSBJXCuPL+jJQJWMn1ywGagcIpb/ObPl50WKSoq6UTAV91glQ
 PER8zNPjID5KMB+UAU+MCnTHYpjA+3yS0uxpriFomm7MLxQpsCYK/CC55I4SiFIUZOoI
 P4uUD483ZtSaUg4IOj1Itaya3yaMadXDdAJMGKaXSoq5Z6DuF5qF+o+reyO8MwnSqQ7w
 GmU78IlEy5J5vsbxkrcfGWzqCZF3WlZkTWJy/7fzIAgbIH0l1EHvJbZ35seJpbBdnB8+ xA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qp9xtvrdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 17:39:05 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1JHd4jH009474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 17:39:05 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1JHd4Va030437;
        Tue, 19 Feb 2019 17:39:04 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Feb 2019 09:39:04 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] RDMA/mlx4: Spread completion vectors for proxy CQs
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <66C92ED1-EE5E-4136-A7D7-DBF8A0816800@oracle.com>
Date:   Tue, 19 Feb 2019 12:39:02 -0500
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, jackm@dev.mellanox.co.il,
        majd@mellanox.com, OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <692D2301-5738-4B60-B80D-901F0D2040E9@oracle.com>
References: <20190218183302.1242676-1-haakon.bugge@oracle.com>
 <38187795-4082-42C2-AF56-E6C89EE7DE39@oracle.com>
 <66C92ED1-EE5E-4136-A7D7-DBF8A0816800@oracle.com>
To:     =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902190128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 19, 2019, at 12:32 PM, H=C3=A5kon Bugge =
<haakon.bugge@oracle.com> wrote:
>=20
>=20
>=20
>> On 19 Feb 2019, at 15:58, Chuck Lever <chuck.lever@oracle.com> wrote:
>>=20
>> Hey H=C3=A5kon-
>>=20
>>> On Feb 18, 2019, at 1:33 PM, H=C3=A5kon Bugge =
<haakon.bugge@oracle.com> wrote:
>>>=20
>>> MAD packet sending/receiving is not properly virtualized in
>>> CX-3. Hence, these are proxied through the PF driver. The proxying
>>> uses UD QPs. The associated CQs are created with completion vector
>>> zero.
>>>=20
>>> This leads to great imbalance in CPU processing, in particular =
during
>>> heavy RDMA CM traffic.
>>>=20
>>> Solved by selecting the completion vector on a round-robin base.
>>=20
>> I've got a similar patch for NFS and NFSD. I'm wondering if this
>> should be turned into a core helper, simple as it is. Perhaps
>> it would be beneficial if all participating ULPs used the same
>> global counter?
>=20
>=20
> A global counter works for this commit, because the QPs and associated =
CQs are (pretty) persistent. That is, VMs doesn't come and go that =
often.
>=20
> In the more general ULP case, the usage model is probably a lot more =
intermittent. Hence, a least-load approach is probably better. That can =
be implemented in ib core. I've seen in the past an enum =
IB_CQ_USE_LEAST_LOAD_VECTOR for signalling this behaviour and define =
that to e.g. -1, that is, outside of 0..(num_comp_vectors-1).

Indeed, passing such a value to either ib_create_cq or ib_alloc_cq
could allow the compvec to be selected automatically. Using a
round-robin would be the first step towards something smarter, and
the ULPs need be none the wiser when more smart-i-tude eventually
comes along.


> But this mechanism doesn't know which CQs that delivers the most =
interrupts. We lack an ib_modify_cq() that may change the CQ to EQ =
association, to _really_ spread the interrupts, not the CQ to EQ =
association.
>=20
> Anyway, Jason mentioned in a private email that maybe we could use the =
new completion API or something? I am not familiar with that one (yet).
>=20
> Well, I can volunteer to do the least load approach in ib core and =
change all (plain stupid) zero comp_vectors in ULPs and core, if that =
seems like an interim approach.

Please update net/sunrpc/xprtrdma/{svc_rdma_,}transport.c as well.
It should be straightforward, and I'm happy to review and test as
needed.


> Thxs, H=C3=A5kon
>=20
>=20
>=20
>=20
>>=20
>>=20
>>> The imbalance can be demonstrated in a bare-metal environment, where
>>> two nodes have instantiated 8 VFs each. This using dual ported HCAs,
>>> so we have 16 vPorts per physical server.
>>>=20
>>> 64 processes are associated with each vPort and creates and destroys
>>> one QP for each of the remote 64 processes. That is, 1024 QPs per
>>> vPort, all in all 16K QPs. The QPs are created/destroyed using the
>>> CM.
>>>=20
>>> Before this commit, we have (excluding all completion IRQs with zero
>>> interrupts):
>>>=20
>>> 396: mlx4-1@0000:94:00.0 199126
>>> 397: mlx4-2@0000:94:00.0 1
>>>=20
>>> With this commit:
>>>=20
>>> 396: mlx4-1@0000:94:00.0 12568
>>> 397: mlx4-2@0000:94:00.0 50772
>>> 398: mlx4-3@0000:94:00.0 10063
>>> 399: mlx4-4@0000:94:00.0 50753
>>> 400: mlx4-5@0000:94:00.0 6127
>>> 401: mlx4-6@0000:94:00.0 6114
>>> []
>>> 414: mlx4-19@0000:94:00.0 6122
>>> 415: mlx4-20@0000:94:00.0 6117
>>>=20
>>> The added pr_info shows:
>>>=20
>>> create_pv_resources: slave:0 port:1, vector:0, num_comp_vectors:62
>>> create_pv_resources: slave:0 port:1, vector:1, num_comp_vectors:62
>>> create_pv_resources: slave:0 port:2, vector:2, num_comp_vectors:62
>>> create_pv_resources: slave:0 port:2, vector:3, num_comp_vectors:62
>>> create_pv_resources: slave:1 port:1, vector:4, num_comp_vectors:62
>>> create_pv_resources: slave:1 port:2, vector:5, num_comp_vectors:62
>>> []
>>> create_pv_resources: slave:8 port:2, vector:18, num_comp_vectors:62
>>> create_pv_resources: slave:8 port:1, vector:19, num_comp_vectors:62
>>>=20
>>> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>>> ---
>>> drivers/infiniband/hw/mlx4/mad.c | 4 ++++
>>> 1 file changed, 4 insertions(+)
>>>=20
>>> diff --git a/drivers/infiniband/hw/mlx4/mad.c =
b/drivers/infiniband/hw/mlx4/mad.c
>>> index 936ee1314bcd..300839e7f519 100644
>>> --- a/drivers/infiniband/hw/mlx4/mad.c
>>> +++ b/drivers/infiniband/hw/mlx4/mad.c
>>> @@ -1973,6 +1973,7 @@ static int create_pv_resources(struct =
ib_device *ibdev, int slave, int port,
>>> {
>>> 	int ret, cq_size;
>>> 	struct ib_cq_init_attr cq_attr =3D {};
>>> +	static atomic_t comp_vect =3D ATOMIC_INIT(-1);
>>>=20
>>> 	if (ctx->state !=3D DEMUX_PV_STATE_DOWN)
>>> 		return -EEXIST;
>>> @@ -2002,6 +2003,9 @@ static int create_pv_resources(struct =
ib_device *ibdev, int slave, int port,
>>> 		cq_size *=3D 2;
>>>=20
>>> 	cq_attr.cqe =3D cq_size;
>>> +	cq_attr.comp_vector =3D atomic_inc_return(&comp_vect) % =
ibdev->num_comp_vectors;
>>> +	pr_info("slave:%d port:%d, vector:%d, num_comp_vectors:%d\n",
>>> +		slave, port, cq_attr.comp_vector, =
ibdev->num_comp_vectors);
>>> 	ctx->cq =3D ib_create_cq(ctx->ib_dev, =
mlx4_ib_tunnel_comp_handler,
>>> 			       NULL, ctx, &cq_attr);
>>> 	if (IS_ERR(ctx->cq)) {
>>> --=20
>>> 2.20.1
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



