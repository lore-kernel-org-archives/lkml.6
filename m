Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCB3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDA5214FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="R2beDN+8";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AP79HR+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDA5214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbeIZRrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:47:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51018 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726937AbeIZRq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:46:59 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QBY5X0013400;
        Wed, 26 Sep 2018 04:34:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=iTZY7z7EbK89RZs5pz0hWTaECA2EGWY65xIzQKUmUTU=;
 b=R2beDN+8E3oazJ3ashla1zCdDAFYrtK6x/AcJxuE+P879scqLFN1GPLoyGZguw5r1W3P
 JCJq6kIZ7xnAXpxEhvQ2pBRSS1N2fXykh0G1mIZYfQwE1YcPPDvFHuqLdvRzy2lmKwcI
 iU75EmIKZWEMPl0ibaX/6YahR7wbuuuGlAw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mr8ha03wu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 04:34:05 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 26 Sep 2018 07:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTZY7z7EbK89RZs5pz0hWTaECA2EGWY65xIzQKUmUTU=;
 b=AP79HR+7a/J1tyWqLKXSfcyiOg5X7LOIYshg5jn9/CJSyDlmtaw76Zs49DpPcLIAYayy4CbQJ+R9AATHUS73/6BFVp2ngFV3CJYKE2hiwBhPLXgi5pyIPhWU93qnd07KmoqPKMTslfWh+EE1MceblrX9BRuRRGtb5mE+URG1Oik=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:15cb) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.20; Wed, 26 Sep
 2018 11:33:57 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 bpf-next 07/10] selftests/bpf: add verifier per-cpu cgroup storage tests
Date:   Wed, 26 Sep 2018 12:33:23 +0100
Message-ID: <20180926113326.29069-8-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926113326.29069-1-guro@fb.com>
References: <20180926113326.29069-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:15cb]
X-ClientProxiedBy: AM6P193CA0005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::18) To BLUPR15MB0162.namprd15.prod.outlook.com
 (2a01:111:e400:5249::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f831459e-46b4-4169-e6d0-08d623a3f304
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:0y4Zk37jJSbVU1iGpiM6oDyhX1vqw6ZvkQB14Y2mbifx8itYq8IHf+mUqKTCT4+Vo46peQ4Kts6zYmS/kk1JiFSyJ7KvPTiLZhmOMEeTsUlqAWQ5FnAjBTQoSwxvK3MHQE+G/aD1lWYyAfDJr7TDGVccKEiJfU5BlsvQ9dF2+EIkTndEN7ztuhLQuB/SBokeTIvqJUTtVAFTRBTcv1c4MjmxzdSgdbI+e5KtPKDMaAKQXfS+VpJiTETTcckXuysa;25:KnHLnm3/TN/koeLi2M0XvMfKzP8Ql2AGYayAHb0yOzIK5Qh1uOM6ghVRx68WdP15RwSraD3LCzfsjYBYFcNIGmoZjGta0kpXruzDK/3GCJMluDh67WCZUx7otA7H0AYWOiPdEOURaDP5ENzY8+gyjOR/zPAn3fKFnLfrE0uaQi6jpcMHeS182BTCXzzdVF7k8iI7zGm0vgZd7675NmysUmEl8udBOxyjDUT/ec8zayYs3w6WCMYBLYhQ2pASQFrJKgjSWglQ1V197psu6Djr/aLDinfaSzYdF8QloEBnHnvgbMQIuWMZIMS/jaA+2IqvbAgNDO2sHQtcEX+XqXgAlY3pKRWJB35b0xXvCkFU6/Y=;31:s/Z6cr+OC3NrAgYUMs/Yaf3+QcjGhdu0ZlgE+gyUim1EaWF0VkuB8dKn57o6qx/7IOmrDcmpmLKBrRIu/9/cdO0m5kC69e5uFzpm1gJi+xPoWsHCqF80V2xxXnw3X/8/SuG/0l/hhxqGO0EV/1AbG61cEFwDzmSJ1Sy9aea6hfb+fUuc1oDvtly1nIebz39oPWBgql6JXLXWldscnITfPGxDDmwXRYYfj/uSuLNapMM=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:kQPj2Vv+QAWP4VQ41Vn6YJ3A5tBvE9ha4/GoqgfctwEhyb002m0TIYo+EgBJIyQqmayVPajYhqgs4zb+JLhk7Li0h6CB6GmDxqzgDANXfpdwCyxQN5xFZdwojBt7Ci8HFATrSOwfSUHVMumG8T0O9+XxXbR5XFv5ikOKxlP5HL6m//k07qzM72Dam+K7EDE3xTaNG/an/CVYGyQszRpaP9AGW4WRfp6jS4gSsSJ4L3wh9lc1s58thLYlicE/JBG7JLKDWMtp3+nogwSaTqCxxbaGbn33HdvQDNIVFBkcuQbxIJ5s4gSY2Q2Bauvvr46WBH7RG/y3wi+ctdWGoSWs+U1ryBIsTU26gshgSWqnC86fUMxRlGkehoHbM36jgsOREtGh45BX8XtEWAGRSNBSigFZWvrVv9bRUbrbgfXLjmyaxPRoAOIc0njn7y6s7q+wRAcbu+EWTf2UrU2K1XZXJhJ1+uo9PzJDGlrk+ugRCFoZ2mWndxU6ZJdsfzZvB5gk;4:pBhTYZQSLyixVEA/HjOf9li94DJBctCmf6eaimco4iqy2Kr8eB2WJ1l4l8f/WxLtDDs68qn8bvajn+GbrLh9OY0EZnjnIsd7F2kD2C+AIIwmwbrRpC+Gi/gpb6YfsMvKdfgiJAVk9fjV+W8hujSDoipqIIQNHpYy7S7pdpu7SAxneeSWfe52+j10V2F4sfAb246kEqDX5eACIpEgmJjFvbnxYDFNZEEb9AuVXQrnbgSYLvRTc7oh0pOhFh0H1w4kedlsBTGr3V9Ijfo7qCHq15XUyAibB3Q7E+NSKBVcaNijHkFlmvB82jrVMw3u3mFI
X-Microsoft-Antispam-PRVS: <BLUPR15MB016247903B3F8795EB97EE28BE150@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302057)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(446003)(16526019)(478600001)(8936002)(46003)(186003)(11346002)(36756003)(52116002)(51416003)(52396003)(76176011)(97736004)(2616005)(4326008)(7736002)(50226002)(305945005)(476003)(2906002)(486006)(106356001)(6512007)(2351001)(48376002)(69596002)(6116002)(50466002)(1076002)(53416004)(47776003)(105586002)(53936002)(6506007)(8676002)(16586007)(386003)(54906003)(25786009)(6486002)(2361001)(81166006)(316002)(81156014)(86362001)(14444005)(5660300001)(6916009)(6666003)(34290500001)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:Dsynhg6M3wazJADB8m9vz9VlXF1yjPvecE7XByiru?=
 =?us-ascii?Q?4BjPQFKYiGBzL5qlNA1Er67w2kXsrP1TnQ54N21GkGjgMhPHC4rBBNIlFVtv?=
 =?us-ascii?Q?44XHUmYjwUjr/fA3eC7HSPvrqP+GJiN0ZsDN6vavGCwdvCGtXKzGjZ5egY65?=
 =?us-ascii?Q?AUSPl3ObcAu16fyQaqisCrVjmQ2MQMeBXzLx6ezOEKHdK6om3g1ON5Xof47t?=
 =?us-ascii?Q?lXV4vgccmUZDFrmc8uh9YG1FMWoOD9ZzG11c/UgTrq7NcQBeHEHfjeH/9MRU?=
 =?us-ascii?Q?80cfVyUQq6+ZmJ/KKEIhk/wBc8YusPcVcPVl4MIfCFr0CHpen9xgVv5feLj9?=
 =?us-ascii?Q?yJTqw/D8LNAqPrGtuS9tV7I5QprBl3mDXNvyZwArkv+UNsfPgV3FSL+k1PHA?=
 =?us-ascii?Q?u5oGpISXkhQ3/X5Iyioy62cknOvy+0zvxRPP3tqQymP7id+Tx4mo4ceBEtCj?=
 =?us-ascii?Q?3O+FDNFVzuzqzAPHEkjrlbJvQoLpl0ew3CjKlE9SsNJ5oy9GBjzt38WERZJ6?=
 =?us-ascii?Q?4ftx7x9wMf6L6Mq/Hq2CU94bTsOO6RKhATzAU2USlyGxzFPcKH3M29TqotCP?=
 =?us-ascii?Q?YFLWD/4t4mmzlyBd5oU4RM2C0Q5QqQeaWE5KBWmC6ZSQa3zh2ZdpOAW+6Oy8?=
 =?us-ascii?Q?8BDfLGIwANg8qsptn6lJgzr6vyJVgKDlV81xRoUtBSTkXMZo6NBNzvfS4Pd2?=
 =?us-ascii?Q?ljDBJPTwBdokuds8nXeyXo0oEHAdtYBBjxEQWDD1xJJLXWJz/Q578g06NdpD?=
 =?us-ascii?Q?3NnZWvcnqv+v/mHgEkkvIjR/VkAlF1FDVMQGlyVJdraq2xsEgkTwpnKcxKpX?=
 =?us-ascii?Q?l+xFzgKFiLWRBkOeQiXcZr0eGvnZUilPkk+qBLt/CFlhX/il+YNyAVzTOhtX?=
 =?us-ascii?Q?u/xt8yuHs2DBgCoxFktQZ9DNoQIaXcOSDndycljc5NR9cE3WQc4ukS0vm2fg?=
 =?us-ascii?Q?KDH6uDGE/ek57doLHv7IWktLQjsQ7KnCBsLryoypbVK79Mg0ajwhUii+5gQs?=
 =?us-ascii?Q?hIfOP3StbXF2IwCDsCgEj9w1luOJfXH6RS64K6OjAUBDFBEirqTof9wFKosg?=
 =?us-ascii?Q?EvJgyV0bRMB1USGoFtTToCuDiAoKEEpguPnARHbcaa+IKauy9qr7ManfTwqj?=
 =?us-ascii?Q?Nowd3b1k/7nmiayfB48aWTD/SjZ3/Wa5ZSqmBuXHxUzEN5xXfnlRRz7wNdut?=
 =?us-ascii?Q?OMJn+4qW8egE6bg+yAVpZLmaNHRsmdcE43aCHVEmKsFgAKDLk0lKJw0GjroV?=
 =?us-ascii?Q?p50WH+5DxcF60IZSZ3pDamzAKBa8UrJUN8VS4QjLsjaHpY18tzqfOmidz4jP?=
 =?us-ascii?Q?/Ooxqr9kboWnbklZPRltpg=3D?=
X-Microsoft-Antispam-Message-Info: bXSrEsHECkp4fRvjgpoKNdXiBl0FraUpcyanwavXgzKwsIJ+VSwrjE5RzPM8LLm2yQxcC1E+eVah7Mp+zCBa+uGL5nD6oDm+ucO9jfr5sTbL0AHuds/oRHr0xnRGTCYYl6fhgbJ8CxLMrtPCCYHrmZQLYuJsY62dPP9NPSf04QXeDNMck/QtiuYVrfXtkD596CWuNwzLPTsd0juX2knUmPSiL9XtmHuxJRXZBjESJweHK8HjDcfCnAb2IUN8c0X5g7fTs5vTU2lH3g7d7n6rcjfRsg94qeE9I3xF8AMhbE5OtTLl1Bxjls2fpaqIaygTJWX1Lcc26x1Ns1D6eFZTVAFTcRpF8CbGab626+Qk9no=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:Y16Glwe2KWrHWPI9m9U77FRmhIp9iIpGqAtNj4vEWJU5xtvCO01a1wLrM8OE+Cerc8+hxxZzXtql2kPxctGrBmE74LP3YYeSm1i2iMmKoIgYvMYpqChpeBOaiKYbuHH4mkmFgFiplmw0ZV1tK80Zy6UXQjM/1sqi/fnvhiGmxafVCXKLi2Lbuxffi4/r/T9hmrdNFSvRF48eomBA7RX0E5J1rdPyo+YBA6TGfgzlSOVoATPPcg6mKc+Yb/NUA3mDAef3ioLJuEaFcZoDHBIp9V1Tk4ZBnVKFNrYIR49HPAR0rTycO7g+LpVkF2LZKZYl1FNGCjbXCFC79D0dM5Ihs9WnhHbOTjscA/L6Jk9G1IeDMjSnGmtn3cQrk505V1QkvSlpWtGy+YJpYEUfV8BW9Z/0U6j6/G9wYMj7Xmf1cl0aWpOjR8oJLqICVeM2leWg1dQ+XfHE7rNfRcZev+NmGw==;5:dBNP3mglYJSAyHiGC5JEdsB5vbWhEoMEiSSoLxn6ejUQLDOaG8phN63pq5cMl4DKEP6EQlElJH/N+sWd66bKXlE1zV80EXYhERx4ikT/720DU/n/IgMMvDN3Q02OVRNT5OD3U/CO9X+fYWXfR3cLEruxhmgKXD/uwPNKN5Rl58c=;7:CK6b99ULo2oFYaLzRf11Nti7Ox75K8+OY3/0H4sPadM5ojASqdbk4EBhP8awFB1aRqiexIZyRQT5X1KFZDYKQl/CfkYY6uFEvq8zArALfpeFaUjqCJ9EUXfzzkGt0rjd8PvcspSz+Gdxs8PeIJFS3m6tiEe2EUefjEGo1VA10GnhpkaOnRaBe6xixVRPig2Atfdf5iuTgX4kbbQuIP7ETWBMyqrNdAe3oc8TGv0DYx9KwloXmYFTKd5g5SAE3QQg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:zlv8+Aai4jdHzyqRABedO5CVSjDg6JOcFGWxAd241HTAT8uGr5qDYJSw6ohEe7enPduvNAYycUlU7imuHyIMgisRL8fMmJiW8pU1Z4BA7DmhtolR+qae7Mxo9B9Vouyc+Wvnh4pJlJ0GBg3q1hgNG6OFuClz+PhtCkM7VUr/dZc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 11:33:57.4372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f831459e-46b4-4169-e6d0-08d623a3f304
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0162
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits adds verifier tests covering per-cpu cgroup storage
functionality. There are 6 new tests, which are exactly the same
as for shared cgroup storage, but do use per-cpu cgroup storage
map.

Expected output:
  $ ./test_verifier
  #0/u add+sub+mul OK
  #0/p add+sub+mul OK
  ...
  #286/p invalid cgroup storage access 6 OK
  #287/p valid per-cpu cgroup storage access OK
  #288/p invalid per-cpu cgroup storage access 1 OK
  #289/p invalid per-cpu cgroup storage access 2 OK
  #290/p invalid per-cpu cgroup storage access 3 OK
  #291/p invalid per-cpu cgroup storage access 4 OK
  #292/p invalid per-cpu cgroup storage access 5 OK
  #293/p invalid per-cpu cgroup storage access 6 OK
  #294/p multiple registers share map_lookup_elem result OK
  ...
  #662/p mov64 src == dst OK
  #663/p mov64 src != dst OK
  Summary: 914 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 139 +++++++++++++++++++-
 1 file changed, 133 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 67c412d19c09..c7d25f23baf9 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -68,6 +68,7 @@ struct bpf_test {
 	int fixup_prog2[MAX_FIXUPS];
 	int fixup_map_in_map[MAX_FIXUPS];
 	int fixup_cgroup_storage[MAX_FIXUPS];
+	int fixup_percpu_cgroup_storage[MAX_FIXUPS];
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t retval;
@@ -4676,7 +4677,7 @@ static struct bpf_test tests[] = {
 		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
 	},
 	{
-		"invalid per-cgroup storage access 3",
+		"invalid cgroup storage access 3",
 		.insns = {
 			BPF_MOV64_IMM(BPF_REG_2, 0),
 			BPF_LD_MAP_FD(BPF_REG_1, 0),
@@ -4743,6 +4744,121 @@ static struct bpf_test tests[] = {
 		.errstr = "get_local_storage() doesn't support non-zero flags",
 		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
 	},
+	{
+		"valid per-cpu cgroup storage access",
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
+		.fixup_percpu_cgroup_storage = { 1 },
+		.result = ACCEPT,
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cpu cgroup storage access 1",
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
+		"invalid per-cpu cgroup storage access 2",
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
+		"invalid per-cpu cgroup storage access 3",
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
+		.fixup_percpu_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "invalid access to map value, value_size=64 off=256 size=4",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cpu cgroup storage access 4",
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
+		"invalid per-cpu cgroup storage access 5",
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
+		.fixup_percpu_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "get_local_storage() doesn't support non-zero flags",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cpu cgroup storage access 6",
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
+		.fixup_percpu_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "get_local_storage() doesn't support non-zero flags",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
 	{
 		"multiple registers share map_lookup_elem result",
 		.insns = {
@@ -12615,15 +12731,17 @@ static int create_map_in_map(void)
 	return outer_map_fd;
 }
 
-static int create_cgroup_storage(void)
+static int create_cgroup_storage(bool percpu)
 {
+	enum bpf_map_type type = percpu ? BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE :
+		BPF_MAP_TYPE_CGROUP_STORAGE;
 	int fd;
 
-	fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
-			    sizeof(struct bpf_cgroup_storage_key),
+	fd = bpf_create_map(type, sizeof(struct bpf_cgroup_storage_key),
 			    TEST_DATA_LEN, 0, 0);
 	if (fd < 0)
-		printf("Failed to create array '%s'!\n", strerror(errno));
+		printf("Failed to create cgroup storage '%s'!\n",
+		       strerror(errno));
 
 	return fd;
 }
@@ -12641,6 +12759,7 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
 	int *fixup_prog2 = test->fixup_prog2;
 	int *fixup_map_in_map = test->fixup_map_in_map;
 	int *fixup_cgroup_storage = test->fixup_cgroup_storage;
+	int *fixup_percpu_cgroup_storage = test->fixup_percpu_cgroup_storage;
 
 	if (test->fill_helper)
 		test->fill_helper(test);
@@ -12710,12 +12829,20 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
 	}
 
 	if (*fixup_cgroup_storage) {
-		map_fds[7] = create_cgroup_storage();
+		map_fds[7] = create_cgroup_storage(false);
 		do {
 			prog[*fixup_cgroup_storage].imm = map_fds[7];
 			fixup_cgroup_storage++;
 		} while (*fixup_cgroup_storage);
 	}
+
+	if (*fixup_percpu_cgroup_storage) {
+		map_fds[8] = create_cgroup_storage(true);
+		do {
+			prog[*fixup_percpu_cgroup_storage].imm = map_fds[8];
+			fixup_percpu_cgroup_storage++;
+		} while (*fixup_percpu_cgroup_storage);
+	}
 }
 
 static void do_test_single(struct bpf_test *test, bool unpriv,
-- 
2.17.1

