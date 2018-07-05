Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C7DC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8A72404C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Yb4orAKn";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aCCmupGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8A72404C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754618AbeGEU4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:56:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42552 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754132AbeGEUwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:52:39 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65KqIm1026792;
        Thu, 5 Jul 2018 13:52:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=1BZUUe5KwKG4AQ93l8Wn5s7n/kFJC5UyaUAxHJB5OkY=;
 b=Yb4orAKnhMrkahNJgo0bnktC3H/p5yEmBWCsFNgP3jvN14zn7JtZocGnG0S4aviDm59Z
 MoyR/EPGkPCvSVB4A4Hiig5j15MiRUbZKpVoChNUc+dqDIt0/oqspcfXWDXKYjjqQgJ7
 DuWpwJeySG3Xfoknh3d+p6d5BETeslwWTmk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2k1q6urqhd-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 13:52:19 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 13:52:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BZUUe5KwKG4AQ93l8Wn5s7n/kFJC5UyaUAxHJB5OkY=;
 b=aCCmupGoQgittQmGHbrURTxW+xIOlQ0I7qG8MIzcmlqUvLm3Mf8kQ39xA605Wq7V2ZlSMRkYHEZu4J6Y1SKGHkJOvQN1yZB64Wx7W/T/fnwSmo1jtkZYEmuy89SLlM848yO3C0mJDKxi7YUE+CU/z9Kh7kOTSkhAFJ5OCz5QkFs=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:9a3d) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 20:52:12 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 05/14] bpf: extend bpf_prog_array to store pointers to the cgroup storage
Date:   Thu, 5 Jul 2018 13:51:30 -0700
Message-ID: <20180705205139.3462-6-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 898f178e-20b6-4796-84e9-08d5e2b92ee4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:HhF1VzgTX+F6+dXbnbOxhyBLSElDnkhGxifqn7czc/Ua+2o8XcDBZ0/4w9rpHpFyIvTurbcmZiIdX2YHc7zRQXpku+WEjizzAMfxhR0d5muVnHqaSvb6cBadq0Iu15SRfDkV5/1wPqTKCZUdgaRB84qUyP+ns78LzJZg7ydfJbJrXqmMi62QwVEw39UN9OcwoCe5vIlvHWkFnqlRenoNiMOeYG9j4bMRQ+s/sPYKYdzGvQeUUx/uVwVhTMu1iGt1;25:20Bo5xLlR/o7WRlnej2fxz9xIe0Cke/G0GmAu8Q/H1IHiUfbepthuRd1dwJimYExx1dGXaTUFoNI9LcFepy4sO3S0EZtKI+2F836f6SGEZmq8hcNYbmL/SQUG2MivL4I2XUW8llkdXeHXWU3TrwWDppHIrlBeO7d5qcBjTY6dDum9YiH2t/bppv1WidTfYvqxlzmq8UnJIHzPXSmpbPR4SZTgpKv+KToPQzKnjxC6SYHf0ZCbjpf6PfCo/3hX0WQez9Kegcq6SJs8yHN8gg6V+ClhE+Dz2VRK/iy5HFWWH1P8iCIKrIScERcTQsaZkGVZh9RnNUIEpD+zW4oxhIgMg==;31:rkPBmoGzO3OFCQA9nYxRkKZbliignKE5n0SxUzgkbX1LNoT825uJEGbqgWKnyrNtzlZm29cHvBDNaEZUtj9NUceGUPmdC7yIIrCvBk30ya+9KF1ji1YBXHJEKP98fqCdRxy9XE5E6tvQrhraj/+1KNx+/9rqnd8t85hlFq3VGbLgQ2aJKfkW+ROd3RGEGTx1KGGwhyWNUW1tPI9VDVPM4mh5ksEWwgxEr+fZAVz8Rg4=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:lU6SUmHoc+Oqx9P41bXoIb10PuBRDpnpYmOZold8jQqLxpbOcMCe3nOStteMD4Vs0HYOAYudgUEoDg0qn1LdS/RKMh/WG2miBrK+tHxtaUDX0yaWpN/c203ZNiy4nxXQVNZ3xSqh8nCR/oxJ9RjNEM4N5KiiFmSvWxI6bWxTfaNWhSdPtoPtND4xekPcu4gFI/XMmtjWzhBQzyyP7tV6eIS8qgDRe/yubt8F1T5G9nv83XkAbWEnSRJuG0rMfGaZlFETnr3Vx8pk2pPy+Vzh5OcYTSjCwby4QocFCsioemWCswXF5F46gBfESCs0oPzkle7Yl5icNlIVczrZNPTzpN56O4yxYW2A9w50J/2NRcf9xveWDGsa9TSb7P2eF0hvxyMJl9QT1bo11igk3gZcTxlFjx3meZnUq9sYW+hRymqpSBgRT7BumjIHJgndoF3pvCWXHw5w9Q6Sb8gVMrKeZ0yslE+MYhlYB4fz6w1SEVvriSXNgfBbUyr/n8UrUXtW;4:tyL4aPV+Kf4AN19ZoiGNMmabnUFbDlwJnZu13LvuS5NHLCwQIj+fJvQNtWDs0rhqlUWT1k8irK/A8NRPUzOfvZrS1Rw8y4mlqvNhg6u7cvF4HvCGwVs3wMktDzoT2+d8ebtkA7mv8Iejgd21Gtz+XmCSLCIbIDwdLP/6npYL+H8IDgJI4y9QfV4kSkEDbnGRYuQKWvSwZ4+76LUTyGdqajWbZnf2GnqvpOGQ86NiyM19GTCEdq8ZH9igG0I/tCUu2t2Hz/s/40wIu2zQT3NL+a5CVFSZiiTsjfJOaNpy6FT0/XZMvxMQ1OXhav4h4leK
X-Microsoft-Antispam-PRVS: <BY2PR15MB0166553026BD3620CC531DB7BE400@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(11346002)(446003)(5660300001)(25786009)(6512007)(4326008)(53936002)(6916009)(6666003)(6116002)(7736002)(16526019)(50466002)(8936002)(48376002)(105586002)(53416004)(486006)(316002)(54906003)(68736007)(1076002)(186003)(16586007)(47776003)(476003)(2616005)(478600001)(106356001)(81166006)(5024004)(69596002)(8676002)(81156014)(305945005)(14444005)(97736004)(51416003)(86362001)(2906002)(46003)(2351001)(50226002)(6506007)(2361001)(52396003)(36756003)(6486002)(76176011)(52116002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:XWKgO5xGvKXMcLrq5BTnnKmScYOomn+t1BKUs/EyX?=
 =?us-ascii?Q?2yuABtVaPAk7ZcM2HeNahmofNsElETNDO9h4ogBHSCz4xL1tJC1W75qAhDPn?=
 =?us-ascii?Q?japZCbW/lHlcBHAdPgzAMbxgtFWRfzXtTVbXt+eynT+0fr2qvWg8nOkuzaWe?=
 =?us-ascii?Q?RnX1biK3FNzHGLX/kvcHXn40rmNSPGakhiYYeyI5FPdvjTNSqFTIH/XmGzDp?=
 =?us-ascii?Q?BZSibngwHIh8TFx4f6jqLQxG3Fwpy1Akjprll6C6GelMIc3oa7QDL4pwjgeR?=
 =?us-ascii?Q?J2A1VYbiTZgLGpPQjwKZDw7+p6Slgx1TyFG9EbtqVLMvBD33nkVnLK7qkCEf?=
 =?us-ascii?Q?VN8sRf+Wm7qtCy5JneQpAbhVXkf2XFs2JbSt9R6d4PC8VRbzRbfIpo7Z4DBR?=
 =?us-ascii?Q?UrliyQrS5K8UONQXJCfE7o7qG8lcRSJHLBOzS0q+uuGNExz4orLZbBCR61tM?=
 =?us-ascii?Q?fjc+rLlAOYRBle7xd7CBDS42QySI+rjWMFMCCE3vqMcjk/OApT+lVygsBbSg?=
 =?us-ascii?Q?PbZA0KvY4ab9WFUm1Nt7+cx5kDTTF1qTRCMwClmDO4UqatKsI0WAsA//IRPp?=
 =?us-ascii?Q?woU+CQXs1v4Y/IBN1vuREiny4tXsGe3rYxhE6FtPJxfN21oVX5ORiOchXaO6?=
 =?us-ascii?Q?f30QMBEwDy/qe68orRnADNDdVqq3aKkOJgxi7AdM+7YSXWyuEgtU+0PZN6zi?=
 =?us-ascii?Q?7Bg8T/tYmztboZwkKjIuapH8CsPO9+m37Cxoah07I08MbsT44R6q5yMDPjaK?=
 =?us-ascii?Q?tNp/YI4KqgaqM7aAwGSec3MqgDIysxKdLUGmIBNFFo4gveZHnS/tBe7pW3b/?=
 =?us-ascii?Q?W4qSuSs3NSjzaAPeiNCTqVMtQm+tAWWXznuqxz5Iw2Bl9JSWaw0JaD6iwTJi?=
 =?us-ascii?Q?evHUNCsxHuCloTyU/7V2u4tWJ+JxzPyK/XzdNpLHwVKD1t7DN5k5vs/1GW23?=
 =?us-ascii?Q?TxeRBzMZoILmOulqJiQgo5OjhHD/0D58HkjVoU3gdShM8H0XF7zcC2H2vHwc?=
 =?us-ascii?Q?q2Ej+6odpAieZNBSPu832Dyq1BoSo2e/3Nqa+MGJZarjuX9WUgHRYKi+/RQq?=
 =?us-ascii?Q?m3I9S6nl0NGjL+R2yJDR82utVEow4oymqJKj7T9fnMiAUklFh4i52uJsq4G+?=
 =?us-ascii?Q?6WRL2/D2sZHGKkOUXdCeuFtRBQzL4MRG2Vnb8pGlGfXtzLyn5UuQXPj7UusX?=
 =?us-ascii?Q?o2sU/Ys4FRvVuojqlDNzdabivjFWq1GM8hJ4OAZrUonXry/6ZWbpvYdALiKe?=
 =?us-ascii?Q?p5UoA7tXQKa2t0umVYCXnW7jreRCaiO0BH3qLq/iorlt3fnWnkgIDAWWWhzI?=
 =?us-ascii?Q?KHBeR2pf87cfooBr+d/mUE=3D?=
X-Microsoft-Antispam-Message-Info: V4edp6KXRixy0eM4j7HOjhyp1iRkYahODQ83WEF9q9UkElDRqd1zqkTnKq49PF5e52buW+i337xh3XwNthrc447qaNxifWDColW6ZxqkEBkqiSjXhcrcFfxoAdfAxQl7z50kPlw7GnsjFm57IcuFk9p+8GSF7DjX6LIfAzRnk5yIVkS059QTwWIt1T+rmJOO1DCcOVMIffht6kucYlwJydV23TtGbqA2sWEyb6YJXGX6eHXpl4zkjUvPWzYYnT7VYlXJI9cfymtMFnTDcM4XyjBa1re/iBHL/9oh4Oj8mA1mcN2skEeVRHWbz+JltScGCWOuplcYnuQCF7JUvxdqMmw9U9cw5XgAmPxysQJsjzA=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:G1oNdP4yqt1KDdJe6reTn4Y7BN4iQe02mpEndRaRzNLDf+XJJ6+JX8JuIviquQpq9SqawuBCHerXFQxzU09cPdrQGb15ptA4y9lcqNcdCoXWU+YHL1wvoRchzjcyYHxNJBKES0Ydq4nuoIQ4b0AIrLBXiQpUus8jYeSdWtc0bDBycHUlC0YXymWqBLnOK1f/V9fgP4X6xFLp11/cKngIAgMvEBpt70MtpCgwQZAQHt+8+eZBzug/45TyaihnGshazGZVgVpXatMuE4HlJiZgq7tSq5jymh04HgEGGSCjcRqEoxqE92vEgossbYPt67+LCxs8R82EafFhDhcuzVQHAudrkeO250AQUA6ySYLzn+qbyEd28cdP22hmMJ+z7qaWpI+1wXIbMFNzdoPX1784czRHXqGRqBGT+xndPsWAMjw++nihOh8MVWkTkJ4c7RDxLbkOLS+6GGXbMkN5QG2fXQ==;5:c95ezyoQ/+ajtKYXtODTUGvpB5A/VLDaNQZ/Mb9fYWG2EzqsxXMZxwhp2Y+D7t2Z0lyy67wPCsdxsGH/+diAuqkg63cNQ5b7c15YIe4ZWp3sTP6NSMAcKrFdy9KVUMy3hvA02Wel82JlAgKeR3ng1H3ua1baRdSBn6dtztZnmGs=;24:QVCOCMzb3KUXTPq8tbZ7pz+NX0bhf79JueEh+8r0Fn3vFfmMHA8RIQzu7vpaYYHba6+Lt0VbqWNZnRs24Y8DIWVvaWGEyG8zrbBAlw7JEjY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;7:XbipsWFYIGX7tHSWNGfE/c8QxaJ6XRekZZrsO/ke95xLuqyVRbVfOJVPSCLau7mu4QRaaiIjhngLGboHk+p/TfCkMdxjF7r/GBO5o9NmHIAZxfTa96XhHZPjupDsYPgUAsQ1PRN7GJ7QYYxaWeYE4sONDsj/WIs341no2qyWUq4IGuEt442n34qirwaOl3TitRhoqjHxySd/cYUTF3HMJFGgupIPr1Wl1z148G8cUYbBp4Ybw+GZoNIsNsOHV+HE;20:xj7qHzXPengrDDtE3DuZ2i8fKNmAxw0cCYZuo5uq6S/UEBNxdNhdjioHfpLcEoLmGru3/WuMBJsDa/xgl/2V6QNlbi9rVjZfjJI001O6MxyRu/fzFWc/AVFLc3HS5c6aReerk63InRf3LQ4FmHkN/tuKYwwp+lWeDljTInS+sDU=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 20:52:12.0693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 898f178e-20b6-4796-84e9-08d5e2b92ee4
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

This patch converts bpf_prog_array from an array of prog pointers
to the array of struct bpf_prog_array_item elements.

This allows to save a cgroup storage pointer for each bpf program
efficiently attached to a cgroup.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h | 19 +++++++++-----
 kernel/bpf/cgroup.c | 24 ++++++++++-------
 kernel/bpf/core.c   | 76 +++++++++++++++++++++++++++--------------------------
 3 files changed, 66 insertions(+), 53 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1205e81871d9..31a94a842449 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -348,9 +348,14 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
  * The 'struct bpf_prog_array *' should only be replaced with xchg()
  * since other cpus are walking the array of pointers in parallel.
  */
+struct bpf_prog_array_item {
+	struct bpf_prog *prog;
+	struct bpf_cgroup_storage *cgroup_storage;
+};
+
 struct bpf_prog_array {
 	struct rcu_head rcu;
-	struct bpf_prog *progs[0];
+	struct bpf_prog_array_item items[0];
 };
 
 struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
@@ -371,7 +376,8 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 
 #define __BPF_PROG_RUN_ARRAY(array, ctx, func, check_non_null)	\
 	({						\
-		struct bpf_prog **_prog, *__prog;	\
+		struct bpf_prog_array_item *_item;	\
+		struct bpf_prog *_prog;			\
 		struct bpf_prog_array *_array;		\
 		u32 _ret = 1;				\
 		preempt_disable();			\
@@ -379,10 +385,11 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 		_array = rcu_dereference(array);	\
 		if (unlikely(check_non_null && !_array))\
 			goto _out;			\
-		_prog = _array->progs;			\
-		while ((__prog = READ_ONCE(*_prog))) {	\
-			_ret &= func(__prog, ctx);	\
-			_prog++;			\
+		_item = &_array->items[0];		\
+		while ((_prog = READ_ONCE(_item->prog))) {		\
+			bpf_cgroup_storage_set(_item->cgroup_storage);	\
+			_ret &= func(_prog, ctx);	\
+			_item++;			\
 		}					\
 _out:							\
 		rcu_read_unlock();			\
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 808497a7c911..dd232a276668 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -117,16 +117,20 @@ static int compute_effective_progs(struct cgroup *cgrp,
 	cnt = 0;
 	p = cgrp;
 	do {
-		if (cnt == 0 || (p->bpf.flags[type] & BPF_F_ALLOW_MULTI))
-			list_for_each_entry(pl,
-					    &p->bpf.progs[type], node) {
-				if (!pl->prog)
-					continue;
-				rcu_dereference_protected(progs, 1)->
-					progs[cnt++] = pl->prog;
-			}
-		p = cgroup_parent(p);
-	} while (p);
+		if (cnt > 0 && !(p->bpf.flags[type] & BPF_F_ALLOW_MULTI))
+			continue;
+
+		list_for_each_entry(pl, &p->bpf.progs[type], node) {
+			if (!pl->prog)
+				continue;
+
+			rcu_dereference_protected(progs, 1)->
+				items[cnt].prog = pl->prog;
+			rcu_dereference_protected(progs, 1)->
+				items[cnt].cgroup_storage = pl->storage;
+			cnt++;
+		}
+	} while ((p = cgroup_parent(p)));
 
 	*array = progs;
 	return 0;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1e5625d46414..5903be928722 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1542,7 +1542,8 @@ struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
 {
 	if (prog_cnt)
 		return kzalloc(sizeof(struct bpf_prog_array) +
-			       sizeof(struct bpf_prog *) * (prog_cnt + 1),
+			       sizeof(struct bpf_prog_array_item) *
+			       (prog_cnt + 1),
 			       flags);
 
 	return &empty_prog_array.hdr;
@@ -1556,43 +1557,45 @@ void bpf_prog_array_free(struct bpf_prog_array __rcu *progs)
 	kfree_rcu(progs, rcu);
 }
 
-int bpf_prog_array_length(struct bpf_prog_array __rcu *progs)
+int bpf_prog_array_length(struct bpf_prog_array __rcu *array)
 {
-	struct bpf_prog **prog;
+	struct bpf_prog_array_item *item;
 	u32 cnt = 0;
 
 	rcu_read_lock();
-	prog = rcu_dereference(progs)->progs;
-	for (; *prog; prog++)
-		if (*prog != &dummy_bpf_prog.prog)
+	item = rcu_dereference(array)->items;
+	for (; item->prog; item++)
+		if (item->prog != &dummy_bpf_prog.prog)
 			cnt++;
 	rcu_read_unlock();
 	return cnt;
 }
 
-static bool bpf_prog_array_copy_core(struct bpf_prog **prog,
+
+static bool bpf_prog_array_copy_core(struct bpf_prog_array *array,
 				     u32 *prog_ids,
 				     u32 request_cnt)
 {
+	struct bpf_prog_array_item *item;
 	int i = 0;
 
-	for (; *prog; prog++) {
-		if (*prog == &dummy_bpf_prog.prog)
+	item = rcu_dereference(array)->items;
+	for (; item->prog; item++) {
+		if (item->prog == &dummy_bpf_prog.prog)
 			continue;
-		prog_ids[i] = (*prog)->aux->id;
+		prog_ids[i] = item->prog->aux->id;
 		if (++i == request_cnt) {
-			prog++;
+			item++;
 			break;
 		}
 	}
 
-	return !!(*prog);
+	return !!(item->prog);
 }
 
-int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
+int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *array,
 				__u32 __user *prog_ids, u32 cnt)
 {
-	struct bpf_prog **prog;
 	unsigned long err = 0;
 	bool nospc;
 	u32 *ids;
@@ -1611,8 +1614,7 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
 	if (!ids)
 		return -ENOMEM;
 	rcu_read_lock();
-	prog = rcu_dereference(progs)->progs;
-	nospc = bpf_prog_array_copy_core(prog, ids, cnt);
+	nospc = bpf_prog_array_copy_core(array, ids, cnt);
 	rcu_read_unlock();
 	err = copy_to_user(prog_ids, ids, cnt * sizeof(u32));
 	kfree(ids);
@@ -1623,14 +1625,14 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
 	return 0;
 }
 
-void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
+void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *array,
 				struct bpf_prog *old_prog)
 {
-	struct bpf_prog **prog = progs->progs;
+	struct bpf_prog_array_item *item = array->items;
 
-	for (; *prog; prog++)
-		if (*prog == old_prog) {
-			WRITE_ONCE(*prog, &dummy_bpf_prog.prog);
+	for (; item->prog; item++)
+		if (item->prog == old_prog) {
+			WRITE_ONCE(item->prog, &dummy_bpf_prog.prog);
 			break;
 		}
 }
@@ -1641,7 +1643,7 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 			struct bpf_prog_array **new_array)
 {
 	int new_prog_cnt, carry_prog_cnt = 0;
-	struct bpf_prog **existing_prog;
+	struct bpf_prog_array_item *existing;
 	struct bpf_prog_array *array;
 	bool found_exclude = false;
 	int new_prog_idx = 0;
@@ -1650,15 +1652,15 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 	 * the new array.
 	 */
 	if (old_array) {
-		existing_prog = old_array->progs;
-		for (; *existing_prog; existing_prog++) {
-			if (*existing_prog == exclude_prog) {
+		existing = old_array->items;
+		for (; existing->prog; existing++) {
+			if (existing->prog == exclude_prog) {
 				found_exclude = true;
 				continue;
 			}
-			if (*existing_prog != &dummy_bpf_prog.prog)
+			if (existing->prog != &dummy_bpf_prog.prog)
 				carry_prog_cnt++;
-			if (*existing_prog == include_prog)
+			if (existing->prog == include_prog)
 				return -EEXIST;
 		}
 	}
@@ -1684,15 +1686,17 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 
 	/* Fill in the new prog array */
 	if (carry_prog_cnt) {
-		existing_prog = old_array->progs;
-		for (; *existing_prog; existing_prog++)
-			if (*existing_prog != exclude_prog &&
-			    *existing_prog != &dummy_bpf_prog.prog)
-				array->progs[new_prog_idx++] = *existing_prog;
+		existing = old_array->items;
+		for (; existing->prog; existing++)
+			if (existing->prog != exclude_prog &&
+			    existing->prog != &dummy_bpf_prog.prog) {
+				array->items[new_prog_idx++].prog =
+					existing->prog;
+			}
 	}
 	if (include_prog)
-		array->progs[new_prog_idx++] = include_prog;
-	array->progs[new_prog_idx] = NULL;
+		array->items[new_prog_idx++].prog = include_prog;
+	array->items[new_prog_idx].prog = NULL;
 	*new_array = array;
 	return 0;
 }
@@ -1701,7 +1705,6 @@ int bpf_prog_array_copy_info(struct bpf_prog_array __rcu *array,
 			     u32 *prog_ids, u32 request_cnt,
 			     u32 *prog_cnt)
 {
-	struct bpf_prog **prog;
 	u32 cnt = 0;
 
 	if (array)
@@ -1714,8 +1717,7 @@ int bpf_prog_array_copy_info(struct bpf_prog_array __rcu *array,
 		return 0;
 
 	/* this function is called under trace/bpf_trace.c: bpf_event_mutex */
-	prog = rcu_dereference_check(array, 1)->progs;
-	return bpf_prog_array_copy_core(prog, prog_ids, request_cnt) ? -ENOSPC
+	return bpf_prog_array_copy_core(array, prog_ids, request_cnt) ? -ENOSPC
 								     : 0;
 }
 
-- 
2.14.4

