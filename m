Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33014C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EC520842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PA4rfw16";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="W0vJ8ZrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EC520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390116AbeG0XR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:17:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52386 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390063AbeG0XR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:17:28 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLjQuM006591;
        Fri, 27 Jul 2018 14:53:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ccUkIiuy+r9fHc6FqtW+NV/batrBqZJEIjW+tLZ/ydU=;
 b=PA4rfw16/mnRDb9QdGtEFzi3i1154nmPWBUFcweWmFqAoRys9SNCgNhIJHYW2Ngl19Yn
 741ufUXUCrT2rm63IX/pWJYrJ6V1ZdvvJU7+E9ZLS1j3KMysFyvPxfWoACVOjqT6R9qN
 zRtJPIeMh2VqT1sYvE0uFhN6MPPxxoUHeJE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kgb58r2mv-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 14:53:17 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 17:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccUkIiuy+r9fHc6FqtW+NV/batrBqZJEIjW+tLZ/ydU=;
 b=W0vJ8ZrX8/RT41JRAqpBfTAzb1hsx2C1GvZW84hBUynnrq+ouAVIHr0YnDf2G/e4IR72TNVjHTiVoQjlXS8UaQUT0Gg5x8avm9IDpRjr/bwvhZLr5rdXXDGbMCW9JFTZ6CPiTfcbU4aFbRkHWhJ4K/TQtsnSaGzDAmJDFnOcGxo=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:fd07) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 21:53:11 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 bpf-next 14/14] samples/bpf: extend test_cgrp2_attach2 test to use cgroup storage
Date:   Fri, 27 Jul 2018 14:52:43 -0700
Message-ID: <20180727215243.3850-15-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180727215243.3850-1-guro@fb.com>
References: <20180727215243.3850-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:fd07]
X-ClientProxiedBy: MWHPR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:301:1::30) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0125b6e-6e37-402a-9078-08d5f40b5948
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:cswwqqGtKigmhk4GS0w35QZaXIQoa295zVv946Re/PgpDScBpFQ1lSw72OfQIhMfl82VysCNZVTPIIn6Oxir0QmtSmNXJc9sVGmeWq2tZhyhfncqlAKPJkKmBzX8K9WiOFw0dr+FTRBydYDyNr0JqifbefkjujxYaeabigDt7MLZN7P8HlNq+C2j0vyNbelKtoslznih5tet+P4jtgO39S6VaOa9nRdsNJKXq3740azh3mAtijnd1wQRuhv/f4w7;25:JzuycaQpsOxlPR08YaKT3tzOrLgSx26ayMHB+0UWPNyNyGTjbWuR2v9mAGJeM61/qbFWvi8nxVVUv/fS/5FyujJfSYK349F3r4JA1fa15MQjKAUdK6Sp6b/pzbII/6VV53F7Yu0b3syE+D5idCidTvqvjD91wL3qXNhj6zg5Oaww5CfXZbqpMuDVHKWVoel6QNJD+LIIQpjGTMJW+nkak1+IZ7Qz0ydeuIY3ANhwC56g21TQKdHuoIFJmgTK7O1FIKTL4a4s5Si4Ek6lnGjfIP9U6ZKM54V67Y/ZENF/Eku1BczP3yDEtmajwifkk+G7tJPbvcPgvb7n70SRb8Yf4g==;31:++qCk8Jqj6CDaFagxr4gycRs6IuI0fCMYFHA9GNvlczEofJqkJLilXwisLscvJotHIxn/RWqQqVgbl1/H4l+9u9SGEPM6rt+T68q5mwqLWgHmea1upuEA4qe9ettkLSKYgIffL7wzffHe2xYnD00iDA8UylEfCoLVuRQkzJWxZQlvDPn7iRc1hAyLNfPVCN6qIeds6m41rRxjwQ8BdqXZw4aZ3Qjsvx21ORUx9T0ar8=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:nV4Q5+A0nHvHs37G1gDKUPSs94hN0Jif5SD6YSo54YT4QKziC41ZcXdYclZZ8KbJi+H8GVpesKGcE3DiVRPdTDDlrsVW2fFOkRkPXerZyjzZJW9OdBFBSExvwOoN1qvJDkYkskDrrkbEPrIQmkRTyz3hxRTLpgGOUjSOLHBGCBFNIl0XfNYZuoEwtELYZPJEEPUmIXbv399P3nVKDuH/fcmCow9W9kr67TojY8y0S4Smov/KF/fz4S5am/pQY+YLJGABMCyaMD5uvN+zoEeb8/Kx5/1TLGU/HCT7x0hTzfZUzZ5OwENS6JbM2w9NKzZv0m6QCx6Wb+cceiQPTqgkMrbNFGxA+O04DXkIuwrwOY/bJQX4At4ib81V9ulbXZNjeytGp2Ewziw4oRDk9LrcroDAyCmulRaDAu3bwVmno/yWo4f4ayi/ztaRIvUJ97Ao3hiUD1Unh6Q/jXruGbLfiwQLA/GlfpKbiUzdX6rmtTy50ZF6IL0/jB20/3Yc1hog;4:k43p9uGoAjMavwtKpajmD4itmMm4JbsjvvK6XblGOrrZKFtyvMBhwRdytp7/06HicXcP3Q+mph4kaVXgC8Y5bzJrN0vwIGEqhUtLuIc8Sc7hAs+TQzNhUAS2MdSxqjStR2ISrtMO8rN89AHWX7wVWt8IXsGEY8dV0bjqTVbe8mqU3xMDeuD58ZBlUCK3r6pxj4r5p1e8CITupDInSrqxD8DeNniJz3XFz3RehEpHM6FwghmpD6YUYpwkbBHmvyKRD6mHtXtngEI4xbclEY+TxXPkEMr2iraR+gwqsdIETFqjguE5tQ03jldh3p3tZB3N
X-Microsoft-Antispam-PRVS: <CY1PR15MB017140BF1C14FCA321A62D2ABE2A0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(36756003)(52116002)(76176011)(106356001)(52396003)(316002)(50226002)(53416004)(51416003)(6512007)(68736007)(50466002)(48376002)(105586002)(15760500003)(2361001)(4326008)(53936002)(25786009)(16586007)(54906003)(2351001)(97736004)(6506007)(386003)(305945005)(7736002)(11346002)(446003)(46003)(486006)(2616005)(69596002)(6666003)(186003)(16526019)(5660300001)(47776003)(476003)(6486002)(6916009)(8936002)(5024004)(86362001)(6116002)(14444005)(1076002)(81156014)(8676002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:28wr8VPn4MWrHgBQju+EAEteeDEBq7CPRAULSYUoC?=
 =?us-ascii?Q?9vWUG1HFBzBLWQ8+N0SHjZrx6596XajKr3D4qQdcT45Lr0/MGsxqWFNq4KCc?=
 =?us-ascii?Q?BdwBNfKObNX1WZXdmbo0KLP+wOUtbiRX2jr4brY9Y+xtnxEb78gkPi6InOUj?=
 =?us-ascii?Q?QVBoT3Yx4sblMNiO1cRS7vJ3CDf3o9bKmVasxEx+fbPETsSBb7Ju2+LXlP7U?=
 =?us-ascii?Q?Y1XhQiURe5yTpikP+nulOUPAcvXWxHA3f9BxcpFbCxd7/o+TX7army5al02x?=
 =?us-ascii?Q?BRol9HJJuo3uE+PBxjrw2SFNBDU7vZSiLCEK48///QfZ5ehHJrvxxlbKbSWy?=
 =?us-ascii?Q?lRJQE1voNE0NZQvDkSSja2UlGRdGCmzxnuK33StVccZF/eNtvC8MRuREPEXq?=
 =?us-ascii?Q?EQfatEeocN9vTD2H3BwCQyJF/gqAsyCNgKhsEQjx1H1lVBVIFZnBGbas9dzJ?=
 =?us-ascii?Q?VCJ+aVW63pTv5mhZKwzNiBztxuwLCOxmAPXdssCvykKsOzLM520SNv5OYLa5?=
 =?us-ascii?Q?7ZUVbIfNQRpC5/8T4cjkeRXvoFoUajsfg5VYuS66Zyo0VNg2JOFmSRcv8hTn?=
 =?us-ascii?Q?6AhW9RFALatXevXy5sHNKeCvrpnaONYVE9szCgt7WVJpwx7/p+6OnBQw63tM?=
 =?us-ascii?Q?IJI1xYwuRGe+n1AiHXUmPYJJLAiv7SIwiv99N1w7brfeKLVmqtkBBNS1z090?=
 =?us-ascii?Q?CI2TKNyxdjCCYK0NFFu/TBMuWs+gAQouBYux+btZeJpl3PpZNc6BZKw8yT0e?=
 =?us-ascii?Q?jiUOmmqW51xA3Fpy+IasWLRyE/mfOaaCLhtCEIgP74jxfmVmmyRoJIRfmCKR?=
 =?us-ascii?Q?jUtrTYrwWkfH8e0k/SXp0OpuX0w0Qauj3KEsVRnRvEBH2Qy/153j6XTMpyaa?=
 =?us-ascii?Q?F7d/hiqAJGdtuA1sw5bjNovvoDBZs7HnmaHwdmo0BfMonwcI+p3fZxn+aGa4?=
 =?us-ascii?Q?6RCn7goYLHjAxMknLKIWKogPpcASduSuUP4lSE0coL9kfNkYGs99+2d7/5Jy?=
 =?us-ascii?Q?1WbHhrMf/Xt30Vcd6cFYs5zJ10O7oYMG5+4Ak1E95XxU/ZR7zNbmuIUJ8w96?=
 =?us-ascii?Q?Gl+fYIpHH+JlmPEqGZtCM7dGqN4nN9nrTKDp1cS02XV1ng5kDef3ka5jK+Zt?=
 =?us-ascii?Q?Z64BP501BE8squioxZrFGBMUXDTQ3ARsF5nxLI2TSdQuJsMZL/LI+jmW7tRf?=
 =?us-ascii?Q?G5Uu7v+LtQD97S03P19kIyIgSn2oXNvWjbE46ZjAoMtgdCR3gByeIHuNoccK?=
 =?us-ascii?Q?MBbouycn/mEMp5VMV8TaoCpI7pU3Vj+cKTvDMg9tBxKF4kA2r7wI/8qg5WyI?=
 =?us-ascii?Q?E1tPMfGw8B2ni9//dbdjAJvbFuNw0cIFVlT7k5ImrAZrefvRYSUy+vD5igdb?=
 =?us-ascii?Q?VQvgQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: tsDaa3ejDP9toLNrxpLGAf8dZJW7pmND7oRMJsBDZsYlGr92vwVyz8ZV07B0mk1fPvgbmltsZkB7cSFlO/T4sTPgws+n4oYagD9fEF2iXFYBPMTdvoSCmatZy/2P940b3+xfZDFGyw9Ae+IeLpoplOPXK5TLitevV1JEbB8Pp4MpOw4uehiminRm3aT6165gEyR7OEBkCV81MVX+kOwT54gh+7h2y3XiCLFKUN39RNWoiZXW2bMF5ybemK3Kom81bzwdLKIs9Q79+gWEXfpLVURjatYzhrvGLWUW2coB+tNW2Hpui0KrEIr/r3CyUfnpdswqA0fQQ7ZN8B+EY0iuwbO/oxUypJmn1QGTAwJ/l7A=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:XpcUyd6M5hnqNBb+BRSxjfRhhXmilPd1D7M+nwagHB3YaAVX3pFYtG+0naPcAsIcbRkJk8bWspp7xqEW34RZlGylmGzfs0nA0ToNLs/0wHp3jAn+d4e9YwuELw2osA37+jSWPeflaw/HcNoDC9kvmFptz5aVewbfcUWbjGg/5PQDyPeLSC3yGIUHTI80zz3rIpDpP5Ads/4VdUaUiU1XgnZH2fFg3XCXhq424kQRqFQWPvHlioYvhHz+djd2p6OMOmPDb3SkMZRdWBOFh/+Uw3gpxjQf1+s977B54kFop6ksRwxQGME+c4bE+qc15phI5NNm9RymZpZQgjVP+xS18l7Pbl/1C7xLd5cXmuIXMPI4cAfB7MRuIQ/uE9O3YQkIpRZS/gz/4kSTO3VskiN53useY2PbYHCLEUGhee8wz4idma+urhnoG+Y39UjHrolkzNgN2kJxjynRGZgcIuoPEA==;5:EO3/7l8Y3pTbqQa5LqA7ZMx+fsIVFWH++FXSBXZPN6PzjTLsThdRaYj7ALBuQ97bRIN0BC6NcEpJBb4jm5wVLGsU4aVo2+ap7qHeIY9D1ONFWt2zD+9pcicW758hRQAj9maIyK63xBX/h4/Yb0462zCuz1/rAhNT6I8kjDGx9dw=;7:cvP109sgGX8L59Ab2ifT9ySL456R8MGvAEMybjDNb1Sp1L7jHIRtCU9FClC3mFPtgHp7he+FVw9L+8tJtQH0HvoTqNveu33HiV8RFl4ti2gG6CrzSFhEVICZ/8x+LcPS4erJHasA9gd4t7Mi8n4A4aTVVMgSGZQ7siM2Lofgx84/vyr3Ka9Y9gXw2EIYZ/9hDE/0+lmwBL2Vcb/1UQ3iyEGdxZU/ljycEFSZD+SNNq5D5xr3AG6Gr6ECD6t6v41F
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:ceSg6GodVhcBLqyLN+63e6B6T7GjpkSodz7K3u3LgkATwl203ZkjA+eVthlRWsoETXRsy8y4yq4p/svKKHOfvRitaKGQMuFIII2D8LqHQa+/sJGSErfo2c+LI2pl/zq3Al6LZZJs3VYP1MkOa+QnO9HaNGx8wDeuvmcJfXCl8Y4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:53:11.8094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0125b6e-6e37-402a-9078-08d5f40b5948
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test_cgrp2_attach test covers bpf cgroup attachment code well,
so let's re-use it for testing allocation/releasing of cgroup storage.

The extension is pretty straightforward: the bpf program will use
the cgroup storage to save the number of transmitted bytes.

Expected output:
  $ ./test_cgrp2_attach2
  Attached DROP prog. This ping in cgroup /foo should fail...
  ping: sendmsg: Operation not permitted
  Attached DROP prog. This ping in cgroup /foo/bar should fail...
  ping: sendmsg: Operation not permitted
  Attached PASS prog. This ping in cgroup /foo/bar should pass...
  Detached PASS from /foo/bar while DROP is attached to /foo.
  This ping in cgroup /foo/bar should fail...
  ping: sendmsg: Operation not permitted
  Attached PASS from /foo/bar and detached DROP from /foo.
  This ping in cgroup /foo/bar should pass...
  ### override:PASS
  ### multi:PASS

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 samples/bpf/test_cgrp2_attach2.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/test_cgrp2_attach2.c b/samples/bpf/test_cgrp2_attach2.c
index b453e6a161be..180f9d813bca 100644
--- a/samples/bpf/test_cgrp2_attach2.c
+++ b/samples/bpf/test_cgrp2_attach2.c
@@ -8,7 +8,8 @@
  *   information. The number of invocations of the program, which maps
  *   to the number of packets received, is stored to key 0. Key 1 is
  *   incremented on each iteration by the number of bytes stored in
- *   the skb.
+ *   the skb. The program also stores the number of received bytes
+ *   in the cgroup storage.
  *
  * - Attaches the new program to a cgroup using BPF_PROG_ATTACH
  *
@@ -21,12 +22,15 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <assert.h>
+#include <sys/resource.h>
+#include <sys/time.h>
 #include <unistd.h>
 
 #include <linux/bpf.h>
 #include <bpf/bpf.h>
 
 #include "bpf_insn.h"
+#include "bpf_rlimit.h"
 #include "cgroup_helpers.h"
 
 #define FOO		"/foo"
@@ -205,6 +209,8 @@ static int map_fd = -1;
 
 static int prog_load_cnt(int verdict, int val)
 {
+	int cgroup_storage_fd;
+
 	if (map_fd < 0)
 		map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 8, 1, 0);
 	if (map_fd < 0) {
@@ -212,6 +218,13 @@ static int prog_load_cnt(int verdict, int val)
 		return -1;
 	}
 
+	cgroup_storage_fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
+				sizeof(struct bpf_cgroup_storage_key), 8, 0, 0);
+	if (cgroup_storage_fd < 0) {
+		printf("failed to create map '%s'\n", strerror(errno));
+		return -1;
+	}
+
 	struct bpf_insn prog[] = {
 		BPF_MOV32_IMM(BPF_REG_0, 0),
 		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp - 4) = r0 */
@@ -222,6 +235,11 @@ static int prog_load_cnt(int verdict, int val)
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 = 1 */
 		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /* xadd r0 += r1 */
+		BPF_LD_MAP_FD(BPF_REG_1, cgroup_storage_fd),
+		BPF_MOV64_IMM(BPF_REG_2, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+		BPF_MOV64_IMM(BPF_REG_1, val),
+		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_W, BPF_REG_0, BPF_REG_1, 0, 0),
 		BPF_MOV64_IMM(BPF_REG_0, verdict), /* r0 = verdict */
 		BPF_EXIT_INSN(),
 	};
@@ -237,6 +255,7 @@ static int prog_load_cnt(int verdict, int val)
 		printf("Output from verifier:\n%s\n-------\n", bpf_log_buf);
 		return 0;
 	}
+	close(cgroup_storage_fd);
 	return ret;
 }
 
-- 
2.14.4

