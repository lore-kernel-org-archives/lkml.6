Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25E1C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9886B20871
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Mi4DMBPD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NtOtAUxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9886B20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbeGLOsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:48:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41752 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732395AbeGLOsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:48:37 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6CEYAca005232;
        Thu, 12 Jul 2018 07:38:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=RKgI/uXzjx4sOl4IQqTu3lTTeB6glCbSdqUPdYg5EaU=;
 b=Mi4DMBPDo1sshCj4Ak0s/GSpPwMYFMgviu2ZOQUmQT4NblMeqAmYk+at+nxL3N+d1Z9l
 rI0JRA94zlIOBUWLhrMRL24e/0JM3/u1EV+RsF51sBmgNDu4AFS3Kz3Esc6i/XEzqi7y
 c2fG4y/gYtCDEeO++YeqDzPrUEIEb+7h7XE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k66tjgavj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 12 Jul 2018 07:38:40 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 12 Jul 2018 07:38:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKgI/uXzjx4sOl4IQqTu3lTTeB6glCbSdqUPdYg5EaU=;
 b=NtOtAUxaysMGcEJ+ck4aKRM3hBTxb0cbrcmyWGBZGXUZg0MYb80bF7T15xpfzPr7f3WmHkLmTx+enWffy0nPY6EH611vJF9A2xQfjLs2LOJOwNkSHHKdweMWqi+1eyYhisav8ailCM0k1NciRxzoRz0R4ZuOhP44eq/x+CmS3rM=
Received: from localhost (2620:10d:c090:180::1:aef2) by
 MWHPR15MB1133.namprd15.prod.outlook.com (2603:10b6:320:22::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Thu, 12 Jul 2018 14:38:35 +0000
Date:   Thu, 12 Jul 2018 07:38:30 -0700
From:   Dave Watson <davejwatson@fb.com>
To:     Vakul Garg <vakul.garg@nxp.com>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <borisp@mellanox.com>,
        <aviadye@mellanox.com>
Subject: Re: [PATCH net-next][RESEND] net/tls: Use aead_request_alloc/free
 for request alloc/free
Message-ID: <20180712143830.GA15912@macbook-pro-6.local.dhcp.thefacebook.com>
References: <20180711090220.14697-1-vakul.garg@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180711090220.14697-1-vakul.garg@nxp.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::1:aef2]
X-ClientProxiedBy: BN6PR14CA0011.namprd14.prod.outlook.com
 (2603:10b6:404:79::21) To MWHPR15MB1133.namprd15.prod.outlook.com
 (2603:10b6:320:22::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1846bcc-3c56-49c8-1a2e-08d5e8052632
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1133;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1133;3:bN5IBQeaUZYWRv8Lnj9LeQqdXU2pGsPsAwxr4x8UZTWj82sQQvP58XUkEGuyYzLfFhWBMwQVj9vdUDRpwGhYjhU6qyTDounYmgq71HkuZ7Cw1fuS4mdSwdQUkymSERApwr8QxEjpCJR9j5Fw5miNDGXyGa/MFaU6A49LTgQgApEDPEomvJuznPPqy3Urkih8JkRro0w2DVbW02qgubw6o0MFf0wAmdn1ZCGQFR2xm6ZzEci8Tyt4dbm2vlJYX9mJ;25:ETNRFgpss4ZH1quiJtD0fFL/oMYDOcnPvl8g4Dm0+FcQwP2FBffHlxkVV9s0QwZRKhw1nHge3pGZSejMmXn3yWY3TOCWYyLjuYvSShDWDg5KuMDkwbEKJULJp/Dnxty2r8pceIuZIjszKV5+71zI9wD4PPVAAc4hELZ0d17oYYHOXMMql3B2ndrukqD4W26yFbsZ7aRg4i8lyGrUSUznuJxxls4Nnq5zNaVeErS/2HNmFWMKtNoLEvpx3lKdEHYOmtcRMXB46RrYc0g5aSJk5tERtNPtn97dsGzYQOvP4z74Bmme1WNpe5f20bNmQzalUJQXwD/fK0hsIeOECjj84A==;31:TEf/UWrFIYg+LEI2/ySW3FvtbiVz2DRHafSCOOxG/pnKoZrQdysZRbLXtQdg8MMqQU5YNvXJ9cYJxj71QhU+WI2H1AcjjJElUXe49FbbqKlLZVtUGRDjkfo7tfwXis5jfWmeukNsOXqlf2g0wkJv1m/QAgTCs3NkJKaNgGRYlLez1bylrD7/fhYmDygOEYexl+/hXoae6NaSFjQ7rusGutSpt3uluhehR+GrlLQ5SwI=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1133:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1133;20:Mdeto2pqPWa5Q0gNNWrg/AHwhmMZEwDX6Sb+ZLRkOYyQCQ6dlshEbgQTwWTDEWj43cnJPaHkVh+hF+a2TYrf6+nXeggffD3TjrQbJMi0kYuR6IU4SZ7tYbxEiK9vJ99XADf+k35g5aMxFc+3BSjoFxafZSIws9tp/MS8oTnjNPk/2A8SojubbmdejWEd+FDJjpvKpr6qWYKlyfDyZ1PqBxjJpPPKJTnLxsq+G0l1nY9EaogLJTP56p7SY0+LtCZ12sVlxDw4zYK+1cgvM4/CbdT9UMYzVtisAGmm6O2C4yIyrAI4JkkVlPOY1G33fkcogPiyCCwJUFfmCv5ApOLx9Lp97ZHbI7geKWeRDe/BDWnhFmsNxyL3nz/HmXjQMonxvJzYVhJ3qWxOmcnOpblPShz0gmQYNGaZZkNRJFdEv34OqjvssrAugH63OhliuC6w1XDRPlA7LJRRdcdZ+HTpSK0bvwXRj4daH/UH2RD0GVPEXF7ovDZBspj5gN305TIK;4:MOX1K9vTL3g/IzkR6UIwdzwY+n0EU/jAvxVddLRYMnQyuAi3chNGYQywu85VzyInGh04w9sL4LVEvu+JV3dc4qpJPgkj8IDI8MtlB8q3ReblFZZ1Q8k5GBfT9ao5Q0+BVf8lqoV78Wtl4SzvRa1r+Z6QoTSskyEOdslWd5FUqkmQGP254Y8Sfh7manfzwD2cskQWWYuoQ+Ul5YMwWe80lTUOilY7FbQh8N20X+kUZQGcovSlC4xRvr1YcUmq3T5AhskQAHK7gUVVa/9SN8T6QVIM2ovMDGczKkYXR2h+4MuBNsv0+7u6LGMYzEiLRUBkbVtYK07ppOL4cKru7VzqeZ3XDEePsYYMktozQmXxestk+8biy6qhBxiWtE9odSk0
X-Microsoft-Antispam-PRVS: <MWHPR15MB11332A250F6136C6E5E0480ADD590@MWHPR15MB1133.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(67672495146484)(266576461109395);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1133;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1133;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(346002)(136003)(376002)(39860400002)(366004)(199004)(189003)(76506005)(52116002)(6916009)(98436002)(305945005)(25786009)(46003)(4326008)(81156014)(68736007)(33656002)(47776003)(8936002)(97736004)(5660300001)(14444005)(8676002)(7736002)(186003)(476003)(81166006)(486006)(58126008)(105586002)(11346002)(6666003)(446003)(106356001)(16526019)(6116002)(53546011)(9686003)(386003)(6486002)(53936002)(316002)(33896004)(76176011)(1076002)(86362001)(16586007)(6246003)(2906002)(23726003)(52396003)(6496006)(478600001)(229853002)(50466002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1133;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1133;23:g/MvcsJmRcoHgFTr/IksnWfS5yFdivHoqLJDeDfyD?=
 =?us-ascii?Q?CYlzBsIpn4MxcmZWAgPYtY3lqfi3g4XGcxBOq7kjAwgNeYZhs/5Cs4zUa1nq?=
 =?us-ascii?Q?n5wAh5AC18q4rJu8OeJdqbHaLv8LRdyVv4vJj3bvtJcT1vytgaQbGBAWxS6a?=
 =?us-ascii?Q?An3XNOXTYCtEyqhPzjaKnlNH2K+Gmh/E3eETJc+jCE1FDpZ6AeE2x1wtwVcq?=
 =?us-ascii?Q?pc+lXocqPL5KgTmSAQhUw3xXWYW+IdSPHVxQeSLkGUrhbsf7dCfMZSO8zguz?=
 =?us-ascii?Q?pRNaHrHKdBRbycs1EZGEr5uH0RI6QCq0L+K02utzaJ/h3l3W1v7jyPp4uQkW?=
 =?us-ascii?Q?xCfxin2kdWX6130JsLYzrepgqFN1TOcbC6Iu3X0Jxb4yMLNm80oHYbqXqfjZ?=
 =?us-ascii?Q?AwYdQo5cNqBkeDE7CYOgXuMKjmHGhroUGrCFHDx7WN0Mk7Xm1+JoYaDes/j1?=
 =?us-ascii?Q?mwPY9TsxB5OLayUeaP8I9m8lQSqp0DTwk18oBZWmcWy1qs2d9DcGLcdrGm9X?=
 =?us-ascii?Q?QmfTX0WO8rIexWNEkIboL4RRX28KBfzpSJeISeRulDwx6ci7n1OtsAsAOUrp?=
 =?us-ascii?Q?IqejdNzhSd1/NcpsRbSpmHCOtyJMCH01c1R6hUTvKD61kIpq+yyXkoflFx/d?=
 =?us-ascii?Q?5TSpIvbwXINJaXnSPx/usztlt75qLmszhQGulhpVzW5xTbQmcHWh9NGiukw1?=
 =?us-ascii?Q?Hn0RvKeQIL2hXTKgoasHEnb1wqgPIvuVlGPp8pQCZ8MRx2xE0i/Sy4tC1UPg?=
 =?us-ascii?Q?P284dQU36qFCDITHyXvrw9iLoaFFO8gKR+yIrN44K2HMHOpSAC86Z1I1oglp?=
 =?us-ascii?Q?n2N3wtzk5dpJoS0f3vH06RDEBB23c15vtEZTQEZ+4UtXfSgkKC204jPqLxWe?=
 =?us-ascii?Q?kh80lUif5vsVFNzCzcw9SUCRQj7zuUgVGkYXTXf65b+wX4UkO7eG4GgSQprf?=
 =?us-ascii?Q?IpLLZCnzPXZq6smnOhqwTU1C+FftLKH9fjQajo4kgiq9QsuD3M0p9Xaw9sA6?=
 =?us-ascii?Q?9P3GsP5ifFd04/ipQpeLT30gggonm+8TY4RczNqh5QkVa6OsCqTlrYo5HAUj?=
 =?us-ascii?Q?Yn0udRbhffQKc3Ov2CRDUIDfAqe4D+pLmFPaWaLQt1eplPrhjR1phyvYJWjO?=
 =?us-ascii?Q?oREJVv18U2s6gX41pfS2+5VF+1UyHqIyHN3apkmmQxyPEmOzGX/aPlEHU8Qe?=
 =?us-ascii?Q?Ul3MliT2kONcy8rzAHf6Kh96vUtYVMVdgPXQRv2qbnw/+rB9g9FtFbeLxCen?=
 =?us-ascii?Q?fqG0R8R4YPBcZi1eZYkvOEV1/nWRYL4WUFFMSyj811mGc2OZ+adq3a//O4Ut?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: mlAJDHV1jnMayVbB/urXc5J3N6jHcS8LKNOA2zmJHAWvNRbsARuI8/LMzY/Xz7VMY7lTZYKJwxSmHC89IAkfSXh8UHVTypWEAlWTe8j1UNu4jLpTmNkygAnpf4TxKz9+iuu+1cCgzZGrCEenOhbrAx3vHKQY0/WsUI9y13dOalBTX4iAFHcBqpIbR94qbXPeMm+OwJUFaEj2aDMeUsRmjqEK48SzmaBaqVIyvjGhd/9vhTi3AvW8NL8Tkp4wfQpZ4GZrq3IvGXAAuek3XlJ0z9YgUMt/SICJm4i9oDpEIMnlIW/OFIJduCsi6ogpAbRmviUTPyX30UNzbEeykYg5LdcF62xzEg7qtrST4dJMFhY=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1133;6:oLac5lrHji83CUoNdYm2pBmqGlMMX92OPlcOriScbaksxoF7kIxFH4r5uKJD4B0PizeOQzR0vb2uryHPMOJ6JbN2mi72/RHuA58KqQGiWme5umfIwwudv9KCWfij873TD4aPSRImYxq+7+qvYOzR1wJh5Us0CehahPylwVrNzZClJxp328Y30Mp9ZGLCApyZc+dN5RB2yTfteQyWIjBMdqicIUOPo/pj/NNNvySFrshWXMeuUmJFEyzSM88Clq2WKF0P0wySdxCRU/fHFLs527yDDCNCRNuyTo4MZmknZLBOE3L2nir/XUog81X6nUnxSf2cTFbJKwrO0tzOFtqpsfzGwXS8E9BcbtT/43p5/6Yga7frnhCBnMZujIWqvuIToOu2vl2bBNXkqIKTPxQtLiopy/OGsHvmWhb5bn45k/kaRil4mbVoDtiNkUP03vsfQ0jhlHrEguANlDOWFpH8VQ==;5:7CnoOonCUk1Rl59uByyO7TSjKhJyd9mjqj7D767GQ06b6WlnMCl7UDLJVZe8J/mXdmwbZd8+bm9ikbXDDRbSKDrvjILMx+TiOlh275dZd9m6UZurArUycHJDJO03oowwmwnzPFpJXdVnCAJ9jAYvt1r9jX1ePvsdg/uheNmMlXs=;24:MjgKJZyxBoUjK1FxWxbEIKN4mvS9XMYc7vUK4YYuuUQRYiFfvrhYZVdLR114wEtiyyuSKsQJZyd0WepmG+DuH0tRZcWHlN2N2k4ovO+m05c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1133;7:yracjuR334v6MnJ8YSWfu3x/PsWrsgtFlLuc9CFWqMHo5HeFrI35edc+ourHeycAYFc6AZtif7oykvcZK3un/D5NJ9oHQIrTF/GLudUj3cO3gdTwNe/NFcwoMsVj652KcYMPz+U6WNhSmhAECBKKWR9J8xjMXqglMwxFLtZrpBtI9VHYLjYRSdbxTSuE9JoJj8nTFj+nVfWwkRytnxg5bdfC9RhqzgHSSUaLFuZGojVhdRqXqiml7cH+J3SVzDof;20:2XG8kdVjiKoWn+LYy/29YquOFuS+fAJ7nAAXTrTVeu8ekvwo3ioNA9O/UuQerpNpiWSVPqVryE01dQT6EQq7qh1+OhBjrfonCVyueXEwWyCDNqeitg2YF//FuDxb1uIJS4a5u1Oq4bxZEdiy6aMEcRWnI3EF2qFvh0LRi+87ObM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 14:38:35.2308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1846bcc-3c56-49c8-1a2e-08d5e8052632
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1133
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/18 02:32 PM, Vakul Garg wrote:
> Instead of kzalloc/free for aead_request allocation and free, use
> functions aead_request_alloc(), aead_request_free(). It ensures that
> any sensitive crypto material held in crypto transforms is securely
> erased from memory.
> 
> Signed-off-by: Vakul Garg <vakul.garg@nxp.com>

Acked-by: Dave Watson <davejwatson@fb.com>
