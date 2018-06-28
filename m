Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F250C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D606823E76
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LjLtWvTR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YdsV2Ga4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D606823E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935866AbeF1Qt2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:49:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54830 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935839AbeF1Qsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:48:45 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SGmNvk016262;
        Thu, 28 Jun 2018 09:48:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=S1Wv96LKcgBVrIcAfQ3GAjew5ejrvQOYWnyD5/kNYvg=;
 b=LjLtWvTRt9biHQ01Rur++sZa4hLXKg6qdslF/dlAG6S+rJfrmOi3t6mCMWt82HqHMN+P
 sBOkNnbZhPX/z1hhp56sJ0FgidLKquJlG5qDbIwmRiuV1CiB2bt1TbxQSl5J4TP1mHtc
 wZ506R8eTxopd/1G0qyQivyyBdsDQIBcp7o= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jw2h4r8jp-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Jun 2018 09:48:24 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 28 Jun 2018 12:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1Wv96LKcgBVrIcAfQ3GAjew5ejrvQOYWnyD5/kNYvg=;
 b=YdsV2Ga4uJ7rGZbmu9MqMgBsaETuhBjVptS69W0iUnKqVk89CQMj/xN9/pKt2TrN5l7sQEFYf1Kircn0AFgnjvH97JyQj/HZGbOWs9zlMyDkcLJrpfm/FXKeQ+IuJz9zNb28BQb4SD6I6OJ8r+PX6vvGI3vBhReaenr8guXoaz0=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4716) by
 DM3PR15MB1081.namprd15.prod.outlook.com (2603:10b6:0:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 16:48:11 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 14/14] samples/bpf: extend test_cgrp2_attach2 test to use cgroup storage
Date:   Thu, 28 Jun 2018 09:47:19 -0700
Message-ID: <20180628164719.28215-15-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628164719.28215-1-guro@fb.com>
References: <20180628164719.28215-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:4716]
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To DM3PR15MB1081.namprd15.prod.outlook.com
 (2603:10b6:0:12::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d78ddf3-10f2-49fe-41c8-08d5dd16efa5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:3y7PgdWLRRcOoUW/5iIIsGaBIvC6AuMAuReOt28Xd89yqEVP/Z2M6PMTEkXbi4676bY5qZSzx8OOuSa6595Uu4+uK2MYvb4iKqjR4sW/7XlzNxAWXPbZoUpp+aSgf4IOO/unGb+XQmrB5pKduPbyYMmuIEgh9oEz27U3d8HxSaFKHVHdwJDkoj0lAB6wi5wQ4tMlW17g1oQ3K6Gqa98lGbKacYHhPx+9clwdkXfCCnNjAAXxdq7svIa4tMTG7H7v;25:+9DzzJ0ZBOQ7dFQ+ZTAz5jT/7HX2yBptjfTYJPCpfXo7p/KAxK6d+D+O2moJ3XLnurCOLgCJWFEhzRSNnP6ybxS0jJR7RgunG17U/VUqNdXzGjUUOtubfnk3hVPRpol6Ub8m0NAgIEZi8FFHsGBPPgUWFFq2WncMXXgLLwx0fVzfyXh1ZyM2VIUakSHl0tSUlZ1gLq8UgwJF8YQmQQr3Y6ri5ueNX2NETm5Y0drXkVrryzxlnCnlgw4B/QFW3z1uzlCBnQkCShzWRZbK3LpChlYnUnefCSygqtKyGiDk6yRirTNc0oelqfpvTk+8DnM7u52JAlbpkwWcTLPu+giCmg==;31:URbL84XbmAreyszDLyRBN9bzWuKRUCniMDqgn0TJGhoheakaW7v0lBXgWfWSGMPByVdfMCwBnuk4MQPhnO3EbgmnavC9XDw0hbmof1qIUF/5lW7KrEb2Uwut2kJEy71USio3sP0TlcLODLE/lzVD3S37QbZ922o1MjlCFBXpUEL3zV2M7B27EvCuVSqUgxTG0VT51v7uLehqNL7pp0LgI5G09ecAVOXcZ0Bcvm6fzpE=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:ex8fRagNsqvZg85dAFUirVe+b/kGI9Fp2u6KWynu4DAPrbVp0EDNdP7uzjQPsMT0NhYPmV6jHOUif5ZfLDQboffQbze0QnlRuwxXWKyHmz2XvJQhiQOr8WShx9yotelbZoxU0/iDUUu96hoE9rcP260D9prNvaiB5Qe6TgBFsPQXr5zl8d4MWPD1Si1Mod+bg/7xdSdZRm4Mq/257kjcVY9kTUYKsHXJM5PS94JVmeYjo4GZi0J+6A6zLckfNDul8M+gFMLNnQB+sQQBWksbuOnZp58+yuSNXo0TlTXnZqMKQd+oIPgTUHZCA9IupCaBelK7e193dmFoAMnV0j7aLd52w1xM8IhBQFHKc8PHok6cSlyECzXef2E27k6mQ9TYMtBSsI8qCOpPmbGYEPSRAFVTX1p2SerrRCqCvT72RYni4X1xGaNWnNsiYxu4KWUnJ8RHYf4h7nrWRiMl2OxXb7ikyrS+/63maYzT/McmegLm849OJGJVhDehg2AeW1hh;4:/qHXBxNRQ9lmcRxPuDFQL/jfbR+RlyMUrYbDat8W8TrzIrgnZz4GgCmhZJubKVakdUR++ivK9zEVoAbu1V6PVEkBqjR6WstjTZjnsR/VoMmuHraochG6QM4CjZrM+jXho5pr/qTL9GFSeG4PHeMDzGQWjcwJKeo1UYWfIVuOmGsYAAT5OpjelYEl+8We3fIw7EaEBJGpiXo/IWt42HICBk6eecUozbLjrEF8yzxp/RhEFBe5Iz+ySP2CWJoWDgG6dRXWibrpmiYO1e3iQ6DrePvnCPXUg1O+WLqNpO0xHTjWNH/JdPW1JzWrdZ8R4zG6
X-Microsoft-Antispam-PRVS: <DM3PR15MB1081D61A707B32B56B2B5353BE4F0@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(8676002)(6512007)(4326008)(81166006)(81156014)(69596002)(97736004)(52116002)(2361001)(51416003)(8936002)(76176011)(305945005)(53416004)(186003)(16526019)(6506007)(386003)(106356001)(105586002)(2906002)(25786009)(36756003)(52396003)(7736002)(68736007)(50226002)(5660300001)(53936002)(6916009)(48376002)(50466002)(478600001)(6486002)(1076002)(47776003)(6116002)(15760500003)(86362001)(575784001)(5024004)(14444005)(16586007)(54906003)(46003)(476003)(486006)(446003)(2351001)(11346002)(2616005)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:LLFRKKqPBs61V3idk4JZEhfSiq5b+W4ywycouhG/6?=
 =?us-ascii?Q?FD8xDpZf8VnIapUyuRkakZBml4ilPUPLz38+C/Ti+XWTolE6wvshpbyOhBIV?=
 =?us-ascii?Q?LOgQnMAFGQfm/GAMlJ6W0vu7r4o5zvkghqJpnyhhVBp3E0MzUjhQkhtJPSMV?=
 =?us-ascii?Q?hc7B69apF3LZ/IQfGH1tYyIv9Y434rC2RdYmT+hC4l+D3y9A1WFTekS74o+Y?=
 =?us-ascii?Q?yclffmHEw6jDuVDXBQe/ln6BfhS9VvR2Qi0yOjcbb0DjQzIaLVjfo6wHNex3?=
 =?us-ascii?Q?Dt/ZuXsEyVHDTFhmT3/yhzr03pmOp6ZdU28kXm55PVdagxF8iMMITJU1Ad9X?=
 =?us-ascii?Q?iiHd1ZcpgsFJ9IIc/4/HWU+h0tJstK2Z9OHbyufSQNOwZcziK0Hn97haeoOd?=
 =?us-ascii?Q?K3iJuZ0rPYu4zXRLi8ZvqevLxW/IxmX8KxOciXCEavBVhF6TvN8+t8XYofvR?=
 =?us-ascii?Q?kOiZTOcuPevv0revLtIDsa9dLiAbPqQjisL1Flt7qd7AVFdOs0GZCWO0z11A?=
 =?us-ascii?Q?JMgugkWjqhFaNKXw2hLEdC0SCcxHzV/726JHByAmPnVfsRIpYRhIjCf8tESi?=
 =?us-ascii?Q?AmOaNL2BLQPQcbWhSTjqMOvrTiiovA0QCvyCZNFuPtebhkijl+eivSrWmYv2?=
 =?us-ascii?Q?5oxLTxbctbxBKhaLtJIggnGpDxxkAlsELbXeyeWYZ8ZUr5reV8xgYPQTXwhF?=
 =?us-ascii?Q?NMpl5UWQu62BOw5H+wkaainlU0MMP+c/wasBNEg0dXGhq9HVH5BeX4AZ9LBj?=
 =?us-ascii?Q?qcBz6psPBl4kkGOk/hyzrdS3DWnbTg5PJiWeF5vEqI9McO63BMTgoMKaN/qc?=
 =?us-ascii?Q?c7oHAVqUt+dO1ItzCYhyqDyOEup2lmTAtFuFop2F2V76cfQU/YA4AOik3Mke?=
 =?us-ascii?Q?arliIuSSfnoVEvJhiUhzDb6oj3thr4CQzc+lt5aikEa36nDBXUnn0WR2/m7a?=
 =?us-ascii?Q?bOllkkQr092zPVQiZIqYylsG9lXu/XCkNLga8YrT6SRYT/QGN4LJmoeWJcF1?=
 =?us-ascii?Q?ZnHWbnHHqArMBJGHe+usSxa830YBgmMitVPv48QPzupI5nsNX8t3D7QruhEH?=
 =?us-ascii?Q?J3I20qEXvhpOa0JvU47TEzJxgnvDLxiwO415A/iiCX9MmjFegGVDolPR3hSe?=
 =?us-ascii?Q?FnNry0YeWeR7zqpISHlcj2Byin5FWxdvhn5N1z7r8/I+bq+YRcp5Ugbtpd7y?=
 =?us-ascii?Q?D9BLBhnDXGhuwEJv/RHNfIXPA1l/8uk35l9FHS3odWORJl3GBkFBrvVLT+Wz?=
 =?us-ascii?Q?b6JUa8+IwMktpm5gkuw0IoVnt8WEAqh3VE4QnEgE88l8Vx/oXyxm5b/3KN2I?=
 =?us-ascii?Q?U9Tb2ZTl9cZrixyEgDH8CPW7nswGzu5sTCiF5kz1Rk3qQfKdQurnbmYmBBro?=
 =?us-ascii?Q?1EzYA=3D=3D?=
X-Microsoft-Antispam-Message-Info: GBr38LSW5dIxDNGYwJZyQFbDJ4NbtOuQTEoYGJoR2+LatZYGWWEyUdW7gNOg4M6ViHWnPu/RT8Y9/Ev5miFXefilwP39IYyCA237ql/CF9PRBE/BPHAw/31lc/22j4k5ck+4UnCYt0Jf6BSEzpjzpCV/SkV0XDysoV6h80F4JDyy94DEYkVQ77lUyapzaEZFP+eNS3tjrbktqpnfjV8EE/M346LGt/H2SfjiaTJz4x7vIg0EQlk1FNCfwEPSaQ1AxbnxaPvp6Rl0tMmjr5vidzH74dYgXFX4ODhAeO7BgcMPyjA1ols6iDQnebzhvaJEsBARUiNhKWdDhv3vx3MusnnLaE0YqMwrwrABWX5dAtg=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:ySaW3LD5Fl4WcIqGIWv1Lsx27DlXskD2gvK0Z3IQH8JlQp2LWMGV5xInt/n8RMBft5cg5GkmoxSvIpVfRAYPNWnyeW40K/0qqZ5wlUCSjAthmTRu59gr8RFtaxVXnlQXxu5nY7/eRQRIsYDTnxTCP6ahmkwn3fBn78V9/OMp6bdZB9z8TiI0mq/Zak1Nt6NuiVWmfv5ApjbqSwQanPO8Q9vO0xGAY0uzQz0IQEh+ip3Oa5MBjWjQojreTZUX/puJY0HqnFZO63VgtTUSQMmnXzOyVXWsOQ0ZNpdTZv1PJdNGEGsvyFm2UNBkt8/kZh3zp6stlWN9UMf2r8vNGyjsghQ0xCK7M7wAXGQ4zvDayYra5dh8rMiUPV0ieQ3EijrNO4X3+81ng2/tPOA4ZjHLNsKgvlKwEkX74eB+LGqR+gsXB1FJ1bT1GJpNRNjl6UzFF0+a8VQkZwAjtFfFphO/KA==;5:JjjbtHW/TTWRDX5d/F9iz4gwJnGbUHtZZ/Tse76x51AQQZCLqqteYawuzg1YkAYsqIMcXMaWukOqAPLviOvVjyoP/RN7It0YOaBVO37c3h4lrWpTuhwZioFJ6r8j3X0i79isxsc7VzsJMb20tIN9bqSil3giUAxp/v5i8geIxNs=;24:7v5cTyRNZt7S5SzLfkUctFQQWrOFrnlW6xbIrb1B7/z/i/1V3x2AiMNVokjSEv3YtLjO89iFNjy+gZ8ZIvvMoWk7g+gBKYmmNMb9EJsWpJY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:AbYHNSjmV5+U4XzYJRlDkhKUSzsBDp4j04ycL8QWg2+4M27/MEtGgyPNTgT8goPFDIsOrZGcdtt4/JLxhgO9lbrGb7YXFw18pcooYFUuQnDCyuEDVmFwf3y9Zu0rTh+5/N7o5E66t2tKzULCfEcizEYuazfRKAMOL464OSFWZPNjs/5bdi+9HJAAvFdxzOJGtDl0LloNlMQR9cohkXxCRL/hh6S+7HY9aWdY/Hpp0f6bvQv5hvNqoPSUgNk/Ld6x;20:+vEarm/70aI4AhK39QzOiAePMWP/7VX6h4zYmL35nRGvxhb/grHoN+MREHpSRqnmW0FnLc8fDNz/M6mE7KatLVnIlPn9jkuRAlyhJT/uiDrdqwzrSFMYzovL8HFEO+EE4UHselLxuXA+tOuwLr9u3bKwr9zcehWqkbLAVHZ1bZM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:48:11.5053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d78ddf3-10f2-49fe-41c8-08d5dd16efa5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1081
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
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
 samples/bpf/test_cgrp2_attach2.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/test_cgrp2_attach2.c b/samples/bpf/test_cgrp2_attach2.c
index b453e6a161be..f682e0b8aa83 100644
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
 
@@ -414,6 +433,12 @@ static int test_multiprog(void)
 int main(int argc, char **argv)
 {
 	int rc = 0;
+	struct rlimit r = {1024*1024, RLIM_INFINITY};
+
+	if (setrlimit(RLIMIT_MEMLOCK, &r)) {
+		log_err("Setrlimit(RLIMIT_MEMLOCK) failed");
+		return 1;
+	}
 
 	rc = test_foo_bar();
 	if (rc)
-- 
2.14.4

