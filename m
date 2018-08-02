Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CADC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F5121581
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="m61BFBQV";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iU51iqOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F5121581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbeHBXWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:22:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49774 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727002AbeHBXWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:22:48 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72LSxYh015349;
        Thu, 2 Aug 2018 14:29:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=hvvgO2+GdmjlDs6eeS84Pg+svLLlAWUss8s2fLdl/IM=;
 b=m61BFBQVB2DaB4dSI9jsUxD775Vu+EJSvjcKrHWzo4yTtIKl7vb8BefEfQ7tYphQAvlh
 jKMUwU2ck7N48c0BUPbwfhVWnxILj2PC0Fn8JJKxSj4RKI9s5stPV8tgYIA02WA4b+7n
 Kiertn2CxFs/GThzlvUy2guDw2NGA+YNYZQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2km91w0510-10
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 14:29:36 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB15.TheFacebook.com (2620:10d:c081:35::27) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 2 Aug 2018 14:29:30 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 14:28:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvvgO2+GdmjlDs6eeS84Pg+svLLlAWUss8s2fLdl/IM=;
 b=iU51iqOuTLilXt1kZHEx2W4wcYyh6iKh/S5d/lQF6gLXARtAy9HF5O6PdU3DUKYzkx9n8tuEvcdmsqZzc+6w4oGFUl3ILhU7lQTuY++RpZqgKMAiaXDiWwYkJ9ml8HuES3O7rX9rDUKcfPhGEcc04T5fTF0TyQPGSm3rWO8f1gk=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:28:07 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 12/14] selftests/bpf: add verifier cgroup storage tests
Date:   Thu, 2 Aug 2018 14:27:28 -0700
Message-ID: <20180802212730.18579-13-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180802212730.18579-1-guro@fb.com>
References: <20180802212730.18579-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:6653]
X-ClientProxiedBy: MWHPR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:300:94::20) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e31f8250-d003-4bf1-6161-08d5f8bed6fa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:N4tvHuUpMPZyDqzRSD1Fj+LyUzvAUqULhIebu81uJ3G4+eOrENw3UUqpvckjI1sx51e98u1LePA7qrEe70/DfdN8oH0YsWfNCUWrFdQQzGzvQVLJX7oMV61gZPE5wENkBmRZ6pXX0g4vARgi50W9xWPQreZPyYw0ZTD2r1xyOI4/I44iPGa2ip4ZFzwwtzAPTlKKB9Qb5vSJFxW1qcoGigExi7x3WuIN5ZWrOLBeYjNw6fmsJa6quIyKZcorl+YD;25:00om851nFSL/1T8CtLnkiM9QSSCrNhqwURlobt5jvRiNo3UrMSr4sibDYWvyOEq9mpT1AS5sdXBIy6O//Nhj3tcNOoKVGvc31fnR/jW1jBf3K91iqrqkAkaCmFtlDkjyIXQjuFdjhuYpcpHojDB/Mj1x8jMaJnov7EoMEB5k4GLYCbNa40z9B0HNNGw+JmdGmCTuOE7Mr9Z+q52T18xvSaKMfJiLWCSxkuVHwoaeUPYihjUTEt/kBhh4F6hc+UFSZkMk5cRGebOF6/KHyBLpZ7esFcugf5zJ00VsMvtbPvYo/KFX5U6bLqbVTs/ocPyB4wJ8EWUHbw9BaMSxFQWoDw==;31:LwerMmxDXumG/ZiSIffMCYN3XrPYaniFjdKbQSLitKnLSB7SxQ4JdGVLaP2FRX1a7xXDLHoF0GYy0aSoBD+JtqZQBOMXDAQcl4GkrBYVTXJ11PBlJU+ktW2zjJE28JsdrFrIuklb9E8uF9btglhKaM2Rkdu+yE+tPfl7f9VtsKYHzrRiRkoqShEEf8BH4ew5lRYTOGBVb+yr51CgZyEFUhiRjRyaQqsR458R6seZgUU=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:kzT3AFr5m/wR5CPs+9lc3d7uKBWglAo2Fth5SOQcRGrnumt8hbXTNUAXqQJ+HyeZAHTwxfKsrD58VNqyBfghK51iozN9ZS14Weyd9VQL7R8qW4qKulHwk42LZQXmrW8i1/gKoXQUSslKpyFbWfuy/EPa5uJPkCQBNHw8mOsyYjSbg7oo0DM+X54uvYURUQi/2UjECS98nAhAvMESbHwfC0O95bHcDewTAq3hY3EptppZBbkrekf0KGGYK81M7BvM6mHYUknD05ZHgVjnfRsGIQfEIDRIq8T+3n31Xr8f3DzgsZ0vRJZ7icp7jO43rKx2BRoKmgTo+aBrjvgQosWF82l11EBDbN6eJ0N3a8bCoWnguk+PODYJZbBpoRKYIlI3Wmi+ZzLX3jaqLZVjUnKkjbvEYUpjRIkt0Cr+k2PA6RG58e5qbMeNJnBLp0WkzXNwDoPFP2hKnuXbh+JETjbtSWzqeFI3zSua4xB2Wi5IU/+E1AcKgzgAjui+gVw1WIRE;4:b3zA/6S7fx/17mL5KJCcv0f5UkG0lvCKz2+/Ia0Aq89wmFxCyeYP/C+9pzGGdtVxzOiLEd37sLMBzYSKC2asFHHdj4vM5Vmcn7YAva0YyKjQVketB0A5NgElKef5dSMfJL4j9f8HdNSWwUwiSOy+PDxdBqQXSWFoSaKk2DRi8oWXDm8IxmtkFKes5ZtoPHgKv3iy/lHtbtrsUC+otdMTdmHLcFPAaBoq5XffJKY+yZQH1GXGe4lFvlSSO0GHMlF64OQw1hrKRkOYE7Lq3BFBFcWr1RJNhZAA5mRILuFW41FhHigKGXJODsmUpRdBbZlG
X-Microsoft-Antispam-PRVS: <BY2PR15MB016736191BFA35C34060C1E1BE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(446003)(48376002)(2906002)(97736004)(86362001)(1076002)(305945005)(8676002)(186003)(8936002)(11346002)(6916009)(6666003)(7736002)(486006)(6116002)(2351001)(476003)(14444005)(106356001)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(81166006)(69596002)(47776003)(46003)(53416004)(36756003)(316002)(53936002)(51416003)(4326008)(52116002)(50226002)(16586007)(68736007)(54906003)(50466002)(52396003)(386003)(6506007)(5660300001)(76176011)(6486002)(25786009)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:jGQ8jUmfyWtjaDWD7v/+5z9+q00gIB2Ks1eyQGR3F?=
 =?us-ascii?Q?YGLvMhnXfr3DoebU4w3jrJimKA2Tt05E2oNB2KOgY7NbTVGYNHzrDKMDA2Fk?=
 =?us-ascii?Q?MLVdEJ6cIaXvYb+RJiPXAyCENjdFoyeUj/ndnM4xEXCcBh7+9qA1Ma0be0cZ?=
 =?us-ascii?Q?S/BPpoB2VPYxN3moqU0FUsfg8NbNUSSLFBv2Wx6c5defVgjUosEhBNzPG/wq?=
 =?us-ascii?Q?An/zCAu8C+5hu10giNg00PHpZgxJ7qddIlDpXm0mbgCbDM6sKWQBrU7/w6Cd?=
 =?us-ascii?Q?CfIF8WiDLyLVq+3dtDzJEg2Xs4+OylGS/74sQs/kqy7yEnrTQcHYhXZW6OOO?=
 =?us-ascii?Q?fneSu40+rLrYsrFUP6RdCzvkD/RzONKSCHE1buOTvhPdgjiAuxjElfSd4pyX?=
 =?us-ascii?Q?Hk+gcSZmNm12GtHQABLXkmjvgUsTs3BoXTiEvUL56FS/l/t3Q7JcHY43Mxhx?=
 =?us-ascii?Q?KCTlaEmgZiMBPAkb/T2Cf4txnFibWvBY+XBCui6apjMSwh3BzMVsIfS5X3Qc?=
 =?us-ascii?Q?nudWx5wRUOtyW+mTMIE3Ws/W8aRXKBtHmTOgt5lFD0hfjoLwMfAbK75YBO3o?=
 =?us-ascii?Q?KCZWvL5euG8Ih9qImZ0441HxqcOkgri9gBuowRGhsjBuIBhOCv8cJb6FSV2k?=
 =?us-ascii?Q?SMo35Mm1W7VvP/VAUJU5PNq7/TcBmDU3P6pvMPmHEJa6KgL3Lcn41pMNHhxF?=
 =?us-ascii?Q?6K4wvss4mqr7l8V8qGphtTXuAwGPr/cdG83SPd63y6Z/EjN+RGZOb8T/BOsq?=
 =?us-ascii?Q?qW+UkjeLFh9GwfdQlwDL/L58bn9vwv64BBfrcoUi/cad8X4XG2ed0NpeFc0G?=
 =?us-ascii?Q?XycdeMU+3uTYFOKTDQsRwQ6+PtZPRCi2l9K5NqV4Y/PAp1XA/pVJpwzjIcGm?=
 =?us-ascii?Q?PgdGlV7iixoAEdfjvyNNiDwEy+Mb/4XMS+LXQ0FriuBFjpj1owj1GpQ1kAzG?=
 =?us-ascii?Q?jcuPlE+5hb7fFQM4RK7O63659yr9Wc6KBHVoFd+GpJZtcajw0rkK3TQwy+11?=
 =?us-ascii?Q?51E0R0Opxx20WCea3H6WM1yLjmyqqLAQUF4QmPbGMZnUvnrzMjGhON66cVAq?=
 =?us-ascii?Q?QKikZYiXOuS9WPLe47X9Dl7o9NG9zcan7i4L+z8AOyRwpfokp6m7TQgBF+GL?=
 =?us-ascii?Q?IMpU6ZZRXmCr8SGFL8vLbqOuFmwrSrPhR2QkPEUnjCDy2/feHfFChrIwTjiR?=
 =?us-ascii?Q?d/mBjB6JHWpk49cVg+65/exu6o+RIcfE84wdtEwgH/PA3XfpudZURFWzCpe2?=
 =?us-ascii?Q?IkPXWCHL9PEiVemPjCbmpbV/Dn4IMIrGQFEsBaSbmFxpnGaB4SeK5tE7ot4Y?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: 7Dh9kLAz5Ya1Ah6HP9UbEIXDgnfFQYXb+TcdnGRY+KQNOzw+MBPNehLMnSnVjYkJY22UD8uPyyDWrsvQv28C/j0MDJr3qlPSqHsiClPVfIRiDixTjhSiQtHyFRZzaJ4vRHY8OJbYaehXGIjejDS1YplbPMY3nxYeCVcf+ymWcVSzzWak0shBDKi8HviK+o9ztrM0e+otj1M0LcjX1RlhaQDay0P+rKMTtcQ8f2CkfSFh2Bh96BKfUxI3yQQimmd3gAUiretC7NyA5XuBPCVa9nBnOb/Ao+xIJGQrfU2CeqEeF5QZha8fsgmyGyhSfGB55i7qLsHY4/IWTeWtzuEoKNKq8Q5XUUJjDm3vZkQLj9E=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:uPZkcAflnHkOpQ9M9Ym0clKuYon34tM+W0TCjTLE3y5O+cKx2ZkCMEZg4fRwSVXLrRPIh7XLFRq2J+PrIVitv0pEhoCBrxSuBIbC5xz6gxkDpCx2U2Y0xo6BzC6oNvjNmiw+u8PfZBfs/6La6XTQArygulym9C/ygkBVjivZLB1uQJjvINneVK3E2bozvFIIXB+ZSnZJFntMa4sTOO7KtvU11u23xMFez6UTigCb5JuYgtnKbcZD83bHy6Kk6tx+rKrgMhXWKqQb9T3iF7GZ7ZmMvHya724Yv7UaYPYMahXOSAVo2Wg3MvNxYKF/OZ7D4aGBIHcvBeNNCHWk7FoGnc5KlGKJuwMQgSmS9hwuhn6hoktrtDWq7p4eBhnG05TtvbWQHfNJH2thn+ypPo2jyaQBNQuigx9zyiEfwm9MshZP9rjDcfOaZcpS7ngoL36cH2Z9RLCWy7cix+TEVxjQYg==;5:KrXLbFPQJSubQhlD+3jPa0icERq2qRfRjPBUgoas/6iZbzoNeyNEbXVhDp07xaOc3rdViDuQGpfBLZg5eCGpF8SUgkI0lnA96VbrH4dscrKazs6aSchiQYyL9yH1Oyd0iNqWYr4t0bTbCudrorCLi4xhvZ7VubO6P/jnSggoSuE=;7:ud+9XCH/snC2IO4n/cz2gIC4Vw5bJ7WfhnRETQp7C53R9VWff0USxQ0d+cNczqelS0aJPXPPEgj9WmSqOZFuZjGjnqKePWyG6IHZQYuDw0shoW4fiQ8gL+dvT6K6JY1Ymfdvr8E+s7tZCrG1Ytx2mi+FmqfbD1+1nPtglHmsp/TA8FBFpJN14KXDEaORZv7LAkeENQi0uIUx6FQ2YCrD3nKmDdqEtSF6VbU77m/sFRMSA8QhtyaniCF5UKAV4Teu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:TAWTnFJmio8bNyLl0DkdwTZVBwD5Rv+1+9rSC7JrnVsqEKsTCf+EanCzdmTgVa4m95+1B+jlNFLshrfimJ/1xDZlPawoPlKwuiTQRAe0zSMOfbpVgVrHA+gK+yVcBH90nDN7k/5FbDiqCRSbM8ojNDxnuYDNbFqfa2BGXD+1+pA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:28:07.0314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e31f8250-d003-4bf1-6161-08d5f8bed6fa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the following verifier tests to cover the cgroup storage
functionality:
1) valid access to the cgroup storage
2) invalid access: use regular hashmap instead of cgroup storage map
3) invalid access: use invalid map fd
4) invalid access: try access memory after the cgroup storage
5) invalid access: try access memory before the cgroup storage
6) invalid access: call get_local_storage() with non-zero flags

For tests 2)-6) check returned error strings.

Expected output:
  $ ./test_verifier
  #0/u add+sub+mul OK
  #0/p add+sub+mul OK
  #1/u DIV32 by 0, zero check 1 OK
  ...
  #280/p valid cgroup storage access OK
  #281/p invalid cgroup storage access 1 OK
  #282/p invalid cgroup storage access 2 OK
  #283/p invalid per-cgroup storage access 3 OK
  #284/p invalid cgroup storage access 4 OK
  #285/p invalid cgroup storage access 5 OK
  ...
  #649/p pass modified ctx pointer to helper, 2 OK
  #650/p pass modified ctx pointer to helper, 3 OK
  Summary: 901 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/bpf_helpers.h   |   2 +
 tools/testing/selftests/bpf/test_verifier.c | 140 +++++++++++++++++++++++++++-
 2 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index 19a424483f6e..cb9fcfbc9307 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -135,6 +135,8 @@ static int (*bpf_rc_keydown)(void *ctx, unsigned int protocol,
 	(void *) BPF_FUNC_rc_keydown;
 static unsigned long long (*bpf_get_current_cgroup_id)(void) =
 	(void *) BPF_FUNC_get_current_cgroup_id;
+static void *(*bpf_get_local_storage)(void *map, unsigned long long flags) =
+	(void *) BPF_FUNC_get_local_storage;
 
 /* llvm builtin functions that eBPF C program may use to
  * emit BPF_LD_ABS and BPF_LD_IND instructions
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index c582afba9d1f..4b5e03c25204 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -50,7 +50,7 @@
 
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_FIXUPS	8
-#define MAX_NR_MAPS	7
+#define MAX_NR_MAPS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
 
@@ -70,6 +70,7 @@ struct bpf_test {
 	int fixup_prog1[MAX_FIXUPS];
 	int fixup_prog2[MAX_FIXUPS];
 	int fixup_map_in_map[MAX_FIXUPS];
+	int fixup_cgroup_storage[MAX_FIXUPS];
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t retval;
@@ -4630,6 +4631,121 @@ static struct bpf_test tests[] = {
 		.result = REJECT,
 		.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 	},
+	{
+		"valid cgroup storage access",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = ACCEPT,
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 1",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_map1 = { 1 },
+		.result = REJECT,
+		.errstr = "cannot pass map_type 1 into func bpf_get_local_storage",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 2",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 1),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.result = REJECT,
+		.errstr = "fd 1 is not pointing to valid bpf_map",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cgroup storage access 3",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 256),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "invalid access to map value, value_size=64 off=256 size=4",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 4",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, -2),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "invalid access to map value, value_size=64 off=-2 size=4",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 5",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 7),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "get_local_storage() doesn't support non-zero flags",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 6",
+		.insns = {
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "get_local_storage() doesn't support non-zero flags",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
 	{
 		"multiple registers share map_lookup_elem result",
 		.insns = {
@@ -12462,6 +12578,19 @@ static int create_map_in_map(void)
 	return outer_map_fd;
 }
 
+static int create_cgroup_storage(void)
+{
+	int fd;
+
+	fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
+			    sizeof(struct bpf_cgroup_storage_key),
+			    TEST_DATA_LEN, 0, 0);
+	if (fd < 0)
+		printf("Failed to create array '%s'!\n", strerror(errno));
+
+	return fd;
+}
+
 static char bpf_vlog[UINT_MAX >> 8];
 
 static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
@@ -12474,6 +12603,7 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
 	int *fixup_prog1 = test->fixup_prog1;
 	int *fixup_prog2 = test->fixup_prog2;
 	int *fixup_map_in_map = test->fixup_map_in_map;
+	int *fixup_cgroup_storage = test->fixup_cgroup_storage;
 
 	if (test->fill_helper)
 		test->fill_helper(test);
@@ -12541,6 +12671,14 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
 			fixup_map_in_map++;
 		} while (*fixup_map_in_map);
 	}
+
+	if (*fixup_cgroup_storage) {
+		map_fds[7] = create_cgroup_storage();
+		do {
+			prog[*fixup_cgroup_storage].imm = map_fds[7];
+			fixup_cgroup_storage++;
+		} while (*fixup_cgroup_storage);
+	}
 }
 
 static void do_test_single(struct bpf_test *test, bool unpriv,
-- 
2.14.4

