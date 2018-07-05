Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF8FC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B0A23FEA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="m0m3gYTB";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CXTNtzPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B0A23FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932311AbeGEUxm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:53:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44156 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754371AbeGEUws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:52:48 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65KmLwj015379;
        Thu, 5 Jul 2018 13:52:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ccUkIiuy+r9fHc6FqtW+NV/batrBqZJEIjW+tLZ/ydU=;
 b=m0m3gYTBTXdTZit6wdB+zs4MWufZfzSwxmCGlyyRgg41xny0o7Bzzr9vQUiIVJt7GgLn
 oVFN0XU2kP5ByixOLqlerpR4KV5xHNZb5axlgzNmPy+h6gOdHPRuejV/PI7z6DKmvSsX
 uBbu3h8hhpYkO6WYHZ8lNeUZPF3Hkmyjel4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k1r3m0euw-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 13:52:26 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 16:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccUkIiuy+r9fHc6FqtW+NV/batrBqZJEIjW+tLZ/ydU=;
 b=CXTNtzPRgg9F2lB7VuJntPzeQG1w1lXtsNTBcUjiWEkMPbHN/gjg2T0l0lZ8D6KPCqrG7d7RRW0YJI70mAQfOzQjBDvFBgQe8hPF1gNQAj4DAtgTi9DaCOEYOIvYYOup1AD228kk+uJocnO6puku3SOtDsEstt983R5Gg8Njxw4=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:9a3d) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 20:52:21 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 14/14] samples/bpf: extend test_cgrp2_attach2 test to use cgroup storage
Date:   Thu, 5 Jul 2018 13:51:39 -0700
Message-ID: <20180705205139.3462-15-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180705205139.3462-1-guro@fb.com>
References: <20180705205139.3462-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:9a3d]
X-ClientProxiedBy: MWHPR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:300:95::11) To BY2PR15MB0166.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a280dcea-ed73-4536-c453-08d5e2b9347a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:i07D7CRy/rKknNkDxe+O8M8oI8e4gxREHHEgLg6FykkE3bHpOjMYcxfusmJms22dEOVoCYzBrp8YUlsl44EQ1V8lpQ8vgw1my4IOm3myyVW4fv7+yizzNBqaojdRmoEa0Oioay/OIP45YPFWeQVr0jpd139fpVTaggd2Ouann46usw7voIXKjxAUtFgdOdySppjlnfm8xSapCfjVTh8o39Zq744zCcbGRbzaZ9g3tsJ1xp719FUTXWHmPkgqQcwU;25:t1PcvEK9htofpM324CZQtmxUsbnLkWIU/0K8c9cfoIEdMpzrYyC/RtfDTldn4d7nanbkNmBhe4JDJ2a6rSe2AETE3rYTNSKIHo7uOXYODJVuvZ6l4ZlMuEt+c82svTbwVtL+/Hi6KjtGCXbSZ4xlnVLhUquGgBh644HZ0famVawYppGewfY2uJiBCSTiq5D4AGx3wxtYAZoTefueUlJ0x0D8m5KESjKVj/j5kylTq+OXXPeopSHCg/ooYdBToz1OCejVxle3xMCXplse3w8NyZaFNoA+51vNNAts6aSr6aEtCGgxgB7UrRK8f0uIx0Vpgg4f1lHYl5EHzCIFdoXEeA==;31:U7wp30AsESGyJFWbnklOQIM76Jf4wR/z2+yU0auJxPF9rL4irKUhOPpRWNXjR3jLDHwn57N+PRWHzRTTBB1cMa/bJ0qsvY3GbDz9np3bvVd4GZXpQKsOi+dIzms7KJU/q5iZaTHUP2g/31GBCWPNEbY+9KRcSgvVYCJ71XylevyBanTO+CLbFU9sD6PcVbExxEl4NuBqlwy3+m9TggAFpt/Uc1mbshUh+8WnrMKNzig=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:9k6CMp18DjGkzkUUzWi0V9UZVgrLJEz41SE5597hti+JZdqfIVw4yaM3x0DmGfPDfEtRlpZXNwNaECNvXMlzxpRA0iTmip6ftw6H5LBP6jtEnix1g9yDRZyUMaQJJryVcPZWZ6VWwLwseFDNux8lFP2L1dEQK6Oga2NwYM5osrvfkvMb3O+I87c4AgfhUO0q0mhE+wCm6vw3MErgYf9vccQQ+gRM5Y9XvDXNE399UzO5Ccdxoj3bbLP405QxTve88v9/iSLcZuhBWoxyBvgUAOZgxK2C0KNVEoEiSr0L71GDQJFRWaRoCpLNwtm6bynLND+AYpyyW7zdXNazI0Rh7UvrODaW46keQJMc3NuDVaEdvvtuBDC7XHuTwh2iVGj85I70o4bioClrYFjFPlISS26lUNIZjGP3HByzig6oJLrYYfe2ODAed3/s0nJYFjHImqVjRS9ZzOeXf1iOGc7rdsIkNEBSqApjCwiMeazC9e8JVxzS06szPuZPcUVvrQnd;4:WRg/q3koVCt6eCi3o+Dks8ALDs5NQRLVRf9V+XM8QQ36T64xBU2jIPGydytJXgL9ZrWyZnYjxcwiIcPybiypVminocirVw5cUtlPGFWh/Kgv9e5Acbo9IsDLfuJ31CTDWbpNmd3OmC/vo1p4w5N4hKGKXYl5yUT9+euxd3WPm4DIgVcDmGWDet+zUUBTBYWvu8fkfHxo/1OJ88RvPWkoKI56CJCq1PBJmt77GM1dTgCEo0JDazTMVXiPRQ0/vc5r4JJIQAHatC4ttK6sCWfe6K/yN5Si/XHVopgkrEmELSMWk2P5YwTd+VFIYLyGkLmX
X-Microsoft-Antispam-PRVS: <BY2PR15MB01661948F6F2FBCE9E6A63A4BE400@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(11346002)(446003)(5660300001)(25786009)(6512007)(4326008)(53936002)(6916009)(6666003)(6116002)(7736002)(16526019)(50466002)(8936002)(48376002)(105586002)(53416004)(486006)(316002)(54906003)(68736007)(1076002)(15760500003)(186003)(16586007)(47776003)(476003)(2616005)(478600001)(106356001)(81166006)(5024004)(69596002)(8676002)(81156014)(305945005)(14444005)(97736004)(51416003)(86362001)(2906002)(46003)(2351001)(50226002)(6506007)(2361001)(52396003)(36756003)(6486002)(76176011)(52116002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:E1kmJBlf6JGBJcSgrckB0QIY2ZvP85EPgkn0pGvsA?=
 =?us-ascii?Q?h9P/RHwwL1xQY4aH1h+Pvs5Es26jArgW5Gx1ROVOnq1VpMM/mwbDCgf953ED?=
 =?us-ascii?Q?VqeV3uul8oZVm78PQ4Fa+VJ97BuLFXflpRhmBuiok7ZiqAdB/AntsD/S6OLd?=
 =?us-ascii?Q?e/qE+AgFfC0e9fpgHTkEP5U22oRKKE24+hsR+kL2rNwU79+xFLqRfGp/IIZs?=
 =?us-ascii?Q?v4qCQAV9jxFPtxDIycF9Yj18I2yA5GTcxF6JGpb6KBKBVbIIyZuHzCeg4lIh?=
 =?us-ascii?Q?yq/axN8jdaOYiV6pCu97Hr+uCvBhTeU3ThOzIVRktH13NllARxT6q08WBxhl?=
 =?us-ascii?Q?bXv72tNbHJoB79wn135QBX44PqMc9tt0yf2Vv5xNhgtSAYABAg3DCGrDL6ve?=
 =?us-ascii?Q?+I1xGKTznf89BR7pAzu2ICTrNMWXwGxdizTZb5RPZrFVXUsItikxP95WwWcN?=
 =?us-ascii?Q?Ur0kG6ZDlVE617vNMf+gLeENXCr4T9vP54tyzFLVV/zQG/KnHW9HkuJ/j0Lv?=
 =?us-ascii?Q?yZ72wb/udPYZW0vOHghXya4joDZ0XduMPYIsKWU1sFM1ictbe+MaFMAp5QQH?=
 =?us-ascii?Q?yDEXQ4GmZi0/tb6DRZko+/euXxV2yFsg9i8V2Hwl70NdSI52/LBCawpDXytt?=
 =?us-ascii?Q?JK1uaDLjyzkb/6h6hsA0GLhSaEwjv4bXWe+48tdjB6zYmvXOxfmGZDd0Ii+b?=
 =?us-ascii?Q?5OhSLiDNjzJxFdH7Q1/jEmx1BLAHHsUg6bGU90Tp+0NaVd/dYyqyQYaCClxa?=
 =?us-ascii?Q?ygZKg+pkuP19Qhh47gHmK4HSbnwc6BQy3taq5PPkpLSXzA3q6A0EFHuo6Mez?=
 =?us-ascii?Q?zojXb+1xin2vNAvf/4e5iHxyIoBCpn/bRfwuGRbMRBXGqHz79lo2Eph5ailh?=
 =?us-ascii?Q?TmoOG1UzO8efZY9yQo6QvyRYfM4VUwpkhp+VQVy9aA0ugGbKVD41xSycGkiD?=
 =?us-ascii?Q?I2Ze847g+/7QYqR6WWuTHNwTGrvkBMNj6cJEuRsTfnqkakzbSMQhlkQNUBvo?=
 =?us-ascii?Q?wt1K1mBAZAn6ikq03AmzF+LpZnBVe5x8Lj+CGQ+AhvyTa5AqlWLLEOxCftbd?=
 =?us-ascii?Q?Vh7GCOalIlB68hG8GF+hxlN//6ywucT20D7b7Ktip0LCCGbTNTT2GqYPtmR6?=
 =?us-ascii?Q?+qKUGRwL1f6H49buSZjm4spnRCudwqQC30gtXeJKIqkYcPvDcbHANJB5pco+?=
 =?us-ascii?Q?7yW6yzCTckVu0xyGW77Y/c55LZ0mMxcCCDG8aJLZyZiRtCsGIegv2IJa+jn5?=
 =?us-ascii?Q?XKBO8m8NU0L9n16K2njMryjphJJTmxgPLYE68Gsrbvt1JTHASjpWfdpA74M6?=
 =?us-ascii?Q?2aOaIEyrIKy31sjidN5ch9VokVn0pf/41ZFd9W9y82EJ/Ja6jboDPdQ68n3h?=
 =?us-ascii?Q?LUyHQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: kkjuYftWU0f4uSIiOCdg2QnX+7uUhY4nw7PaJHY8AaBKsMBs7Csn5yEOq/PcZxowKXuHL9gJPZKZjgGWxqOwD8s/G9SzljVtAWPWb5fU0reSAffmXzqX9ytr4QdoYkwGHW87fajqZ+2Y7ag/wbzyJJrYm/hGqLdgaA58c/VB0dhZMfaKwXncV/Fv15036xfEHmOuu7aM7q8qvbFbgxRnVyVOUgr57fKv4xnAQBTP6dMLk5rEOAJ+xHoASg+hQ+V2H3kcsbNagsOVsSaRfGHWX3Zx1L44hkSXT6sT4l3Z/bejqPMGV4ASk9c6T69PcJYJoue/kJFrLa8c9Ez7BdR0O4tFMIJJhvP3wFdXySCOBr8=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:10V/CURHP/hAC0k8XVXMgBlRBQHEvXNoBl9qjBp4stbP8eMvGlc+P0onV2hlpoLIalYZD43J/vEmxqjhzM8jMBveQ1a261zl5oqIMdQwY2WHdhtmzdLYJW/QLeQ6qiL9hkz1B6NXIY76NyxUfvj/bnfDs4kqvsPgeuXDyJJHMWOHHBgxPcfUkk+4UujFSj/4Cg14ijHmH3AgZPE94Snq8WIVpOuJH33EF6GwSKinhoo2f02PJQgpVDNulWxLfKZ4A8bu8pmM1e5Q8/4msXkFkMO3K1txGmnRqyQq0jS4GD6EfCvw3gxwQmczQ9n6/odZAVy1+B0iLZFNGQW2vXw22lnkNvvZ7OnllI2JJJEPp2xmBXhhTgZIL9o3s4U9Myk2QOUSK0UG7Ec2bNafDFfl+ts/ND1DmfEoP2FUN6VE+UrriQ89nFQiO1WkrOwJR7sBytN2siy/avhxzF356cW9/Q==;5:tpIJJ8nRP1yaLy++ZgbGzz2PPSrkQn576s1l0qFon1gMKofALrbuoCqTPUHFUYKcD6baS9ExJ1LYB6c6Pb+h//0pPLh2l8f7KIYo0fH+6NcWM2FJM/f9fgSZl1C9ouwvq/WqVf+4l8gqhSlrE9ZWM8jAeYcuVrewewKnjE3fl+8=;24:REz2m4JJHa8Miz4zu2df2bRAgqB9VxLziLvdhBnT5VZEzLZRFO1QDlJ1etQ+rOlfuTL5PuWeChIv8p6+4jrXnwRtWkpraCwrzWNx5fTEGjE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;7:HU0pEYdBTBqlnlYOZYvve8+H/bBwYtJKY8iAf593qasReFXCEa4MyfHkwV15LeaoxtGILn4voU0qJpc2rt8kS6DzgTosrAPhB1QbTdRtuup30tPLnlnF57efgR7gS//sriSY5eDQFywOn+TwkcGsYInXz8TqXxtQp/5xoDcuxWZ4e2B47bm528xNynG0nh2TPC1fd8QW3N/SC4hmtc4tlIAMCiLsnWKbNYpb3B2Wi/PqUFS939riD/AjYZtzZgAb;20:tX5kuC/vJH6tAPljQxms+o+WGQVv6QW95lBfZIStQK8MS2VVJ4hoabH+UMv0U98JBtHQnDLE1h7HN5AA7TL2yvXHbh7/TnF7Bh7zxWphM9v5E8IJgdsD+P6XQhLZ2lEa+QEbtQn+4IbgY/Vp6Z3p1MBoooKBLbVrXdZfzdS/lko=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 20:52:21.4346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a280dcea-ed73-4536-c453-08d5e2b9347a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_08:,,
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

