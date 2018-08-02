Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D97CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E8F21580
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZcXJO9Qr";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FNV75fxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E8F21580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeHBXVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:21:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59128 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727260AbeHBXVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:21:22 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72LROUb012185;
        Thu, 2 Aug 2018 14:28:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=DEgBDb3w0Ad57Uu2oWHbluw6pK8Azl2E0c9fEjwFaqY=;
 b=ZcXJO9QrJXfm1NYlcBr1TdVRLMdMj3A4TiC2DJaoX2jH4bT09lgb2ZOQG/4NE6+FpawA
 pj47v7CHz2xAAEvOktuse9dbklDnx/gyirbXFh8v/MqwGuQmbkeDGmbBGUH+rN4ISajm
 0uDVh1zj/AfQeJmpYMAUv3vH94y3MbaG+10= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2km6jy8nt5-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 14:28:05 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 14:28:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEgBDb3w0Ad57Uu2oWHbluw6pK8Azl2E0c9fEjwFaqY=;
 b=FNV75fxeHi0NQKukCe5zmR2ZCiLnExRiZa5s+GTQCBiYp33G1dzV9Z3r9wPjstXyAZkKnq/V8b5FEJdNQocF1NtOPacP/TmrrdqxUnrGC8npkFa27SXbrOF3y+sgaPWOSsXe3fUXElx5LR1SG8UDv7XTi0MfKmaGIheqPgTd1do=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:27:55 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 03/14] bpf: pass a pointer to a cgroup storage using pcpu variable
Date:   Thu, 2 Aug 2018 14:27:19 -0700
Message-ID: <20180802212730.18579-4-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6754e32-432a-435d-8c3b-08d5f8bed014
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:NWCCUxhrrOlf1FG14D3SfOOQxohcEjUlw989rBMJrvRlwbOqAy2tjZDDRekJX08GFNRtR7/ir8VUsZre+2jBpc58yl8OYr1osroHc70SJSvte3Z9VePDRFTDFqSQACbQ1QO4eg5Xxh0o77Kz6lNLtk+JkFKjv+rm2UPBCk1q3yqU9DyOmmYtYCLQPhf32sx943WDdeoQ3emWnc2CifWF7iYYLiw4OXkMxy7ZSjcBEFRodHIK3wdG4uX5+u0xaylR;25:awynjoiysyfUYcD63lVdPKmOvffEsIhJr69OyMOs1yZpRwArS1r3EyV3mLynb99flvQK6B/oPofbC6UMKjR2F0SnD86j+YvAqZ3fFR41njK0mfauPap+S9EWXrICuNiFc+Kb4XRp6eokCw4lx8qeZAK8v1QWMOYQ+TQnh0h7+2OTyzlJdJpUio05g9uE6EzwBxzQNrR6bmByaFsHl6PtoEEShdOQPCDNGLx8MVccCim7RfMGCLaKYzeh9wJ25heTK1bN7DGxgdPWSLjs/MaS77tsOKRvKzTZQmmCiUSvieAyjencvzjRYBMllx5jVlxVQDybk+CKFQO9Lat3cJqmZQ==;31:aVoV4BvD41Z9BkSeiA6Hp7plh8u34/lMYBluCPjFSlTF27tdsbCNcP2tSDMGM928uWifiJjaKKyc5JGynBLpeVHRGDinwJ+amDmBJyOL7bcWZMRXJjvf2enO8K0JnpmImV/gFtNeHGz8guTUeKsAim737Xmj69Aps+ppepybqz+tdpOT8EfU4k2b2CANoA7u3XizB5pg8FEzL4D3IZkJZLMTnp8UF8iSSziqVCzm2S8=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:zQHP2N+uSlaCNLB0GPDC3kicEzOqUfUdifKuk99JDHxiDad7v+bBYEzLxHc3qVVmdgK3GLQD1lXNmVUq9UNFXs+QnQ64gcLUsgaizPMkQkEW11jipv6WXr5BO1zqfB9sOc/3MZnXJGi6jvy1/7x1xNGIqBGUCxrgc5YfCddAKJbVmLecCN78K7vEE63lLG1WiDaRn9qKNvXlxDGzU+IuI/0vA2bmodAcuu2pnS6x+gphU9OHZmmmyyb858aQFxltIVY2wNQYgE7gJ+sRi9ZMPYwUZ+2EzIp0pPS9dUq3FU3er+MoZPfjvD8lGyzewDeCn/d9Zow+fRhNh035bOj/wk3MiBTIJ8Da8ldKkUsHftB8M+Q3Z0aibGLYnKH7Qz3ubI0BiYuKVfCN6IMTDXG1UtXueB2TtZlTiUGlg5UFctMhWj0uIBt7uKwcEJAB4hrbCzJ1QNVJmSapZuHCpblVSwazw5plTRu2bcZTuWx9TckL+76T1Ybd/oEv+Uc5uBL4;4:dP166bmEwr6AYJwaiOyO9/5eGeuQSfypV1RZOhE2DcwKdRl3qLjXaGnerslSHQIU86OWa4e7j7EBplBr9arFsNCsYPEA2FBWtHC7Cg3Lz7bW9gFhPcyU1EbGH51ObE26HVqw9vfx9WLVloQQLeJ6espi0fpiDg0fHUKjymCahlrAybKDMLeSXNIPOf+yjvDGoW8rH8Dmm+tVASBiOrk2SkUdmHbqzTiYGua72LK2p03y47yrpFat7ockcg0kKtQtbZhU2F4WF45whaJd7o9yvTRva3B1c/pluoB6LIGQ/OppPG6lBzXxpLYnP1HQRkeL
X-Microsoft-Antispam-PRVS: <BY2PR15MB01673AD23D30098429329116BE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(446003)(48376002)(2906002)(97736004)(86362001)(1076002)(305945005)(8676002)(186003)(8936002)(11346002)(6916009)(6666003)(7736002)(486006)(6116002)(2351001)(476003)(14444005)(106356001)(5024004)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(81166006)(69596002)(47776003)(46003)(53416004)(36756003)(316002)(53936002)(51416003)(4326008)(52116002)(50226002)(16586007)(68736007)(54906003)(50466002)(52396003)(386003)(6506007)(5660300001)(76176011)(6486002)(25786009)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:jVg8/6gHPOMbiRWM5vpEOMVSvTsjypNg2lR9Tw7ok?=
 =?us-ascii?Q?LYMizBCpbRSeQ1akPFQxDE38b+9WTFZtfNa+lHqmgV5kmgW33+l/I+dqcWXA?=
 =?us-ascii?Q?1+BXn++7sCAw+U5lzvb1uDvZIZPqT+AvUqk8DwLhyImwsmhFQg7MPwYKZvOx?=
 =?us-ascii?Q?l5fOgIzicbrPvyIVBbaMNse/I7D4Ih3GD8hRIrYWSHYTT9Aej41AJiYijMuE?=
 =?us-ascii?Q?yL1b0+3QiTBl9Nv+n8zgYbUMITeOuMxaGg2EAftC/vrp3V5OhNRT0nQbuN/J?=
 =?us-ascii?Q?eXJ1ICxViWIPs2Hze/6fWBqjd9T3Gw+jPWTyJyKWLlfsqAPDYwQ6OagnBwFE?=
 =?us-ascii?Q?WSviqBuSqGe0MROQJhZIT/wYurbSCMyFOtPTRknASYr36oAX/XxNokhwHdIZ?=
 =?us-ascii?Q?8Nfdnfg2a+czwuDpcifxLy7xxhjvOlQAdYuGhK1RwklbWOSnlCuWxJseo6/Z?=
 =?us-ascii?Q?ZKzAa5DDc6JPrkvT9uqYjvWPcNEaHtgdB4AHAE6eaeYV4iycT+KcKsa7tjLf?=
 =?us-ascii?Q?oTAKVh19z9UdJN5CjjtdrcsXEEALF4VksDwMWHrHFTpmHwODwyLASogNzbqG?=
 =?us-ascii?Q?2NQ/N9wWg8Px1HwZHu0yRnbbrwByaXNGnvQ/uXEQTUWfK+1wwEvK/M4XB/Iq?=
 =?us-ascii?Q?PwTUq14ilbDRG3j+ktwTNxdoSFNSrZ9VSVuZRMBIljJE/3tI2IADp2sLMpVP?=
 =?us-ascii?Q?rTLODLhzIVU8CZoi4HFRp0wRVPblBayx8WgTu9yTuO9abma+jqSZ5SLxDeLo?=
 =?us-ascii?Q?00gqohdJl+qmL18ohJHsA/hsIa+ab38QsB2YpeP3S+iKuaDqp0a45ZmptkUL?=
 =?us-ascii?Q?lPw4TYRoYtZMrEBiCVi+HEfNF2WOALMw7PfK0FN8DC4iQ2w6CYAyvva7DMvE?=
 =?us-ascii?Q?QsfsmsUXgOJblSNxIJmAPscUl5NxfPtzu6CM2TjxaTq6YA02k7bDhbtTIpXo?=
 =?us-ascii?Q?7BLWa2VHQi2BSHYwYUc+UiJjoZzKaryWKB/gUCxl+080x5037L6TvLO9MMD6?=
 =?us-ascii?Q?xVh5/gHlARne06LSZe+AIbKH4qY9PDcB1YwivxmanvoPNPJ/3mFA/zMEumQP?=
 =?us-ascii?Q?jxpDlfZS+AOywQGwtxKC3PiB2y7nb7GxRDho8ix3WpbECdHH9Es5+OWWrQ/r?=
 =?us-ascii?Q?fG76crIxYG9YNKVR2kHMMvrWS4Q8Q6iShhGchHtRB3tTv1AmoaU/MNSqmPB/?=
 =?us-ascii?Q?qesOJ5P5u3yTXjs7yGoFYuIEScvoeUIfgrjmVU7nsqmTi+Q2gDX0eK/ztOOQ?=
 =?us-ascii?Q?hwSx06ry/54MKuwUA9HLb2xt0JnqdfDYHMDU6V0WygfjLuPpmzpXPlcx3GK4?=
 =?us-ascii?Q?/11lgV4kEJl+3XtOu2fu3c=3D?=
X-Microsoft-Antispam-Message-Info: H33KspVwBI/j+daP8dzbqOIRPuNFU5ONvI6fhi5UJXYLKsYo1igdmd1cHUAZt2zbXDWucd8OO2FXraQ1Qrvt5wKYUqobmog1FvzAZ5w0MQAdvVkmISm/+j6OPuiW9kNBCC9440DJm20LS7Fg7ykBnn0ehXuyMRNr4VSN4yaXR2P4JGd1HmJ1Ck2+RRwdZfyViqvUrnALH86HPVunpI6JSoUYMjysLectQ9MFKmQRDGjDkRvalKlEa8BoA3zf0jVmlFuuPNdFZkT+isi52rrUg+RyBYhrBBHBDluf5FQO7lIXqNEFtx5nyn9c9PU0nFCMBh2u4cnr8gr9RlBeICZEk2i/jlDULV4c893S0iFb2tI=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:JcxZbW7cQ9F0x7kpM+TpsmDjWGFoNiEeiXe/YZth9stvrLbFpjkYOkK/vPTLyqck1O+VaqYsNdAc7vapHksdp/TZT+m7kzMmMvD4tYbetEJJ2I6NNddp1HMfpj/gC3IIDWej/bBeS2VSSqdgwKM/ABZLKr934U8XME5EoWl6BBfEAldjkvkUKJAVYs8d8xw/GAQsWdtKQ6Ui/ETIoDarJ9TJeHXdcclby+Z81U5/8ZRpPYFWpd9jncBr3VKhyuYzFL7aaqaLhrdUnacnDOYyioV7d/SO0MwJUefS+CdgD5Nkty9JxHSyvRhze5gzDAbEdsz41ui5TCfdN1dG12W8R34asWLUiErfG9NQ8rGcT3Ci+ZQzxVdGRqBn4XGpki2ZGAwDptq49rzrhR1yg277Pq1ZQRSfBCh7EBrx5juXNmMfA1j6McCAgtFUkiBl5P2z/VCzWVZFzQmdFu/0A92oNQ==;5:dMQb6cSdOsWyScBMkIPXRu/yw5SbhSXJpMBK5SaymYVGxQU0rQeuSSRvE0i5nvnT0vtqG8fIagp/KXVko9QH+shdeViJSEXlC9XlcS8i0DB2jJuWkFO2tpW/r+xwMUor7L7TeTB+aIViC6GJAU+yOYPbDbC57glFdmjuaKSIbI8=;7:JOCOqWZ9otq64Jie4wb7hrA5kR3RK4B9DynlRXaadgQ/vwk1yVFrTF9zgSluW9SoryFqkSIISM758lTCUbgZep/OHM9lsZtQ+YJcDJucyU5sMsCJwKrR8VossV0wPAIa2mqt7Duku9TeShj91HUZREO+ZPXjLAMLlsaVBU1aWovJ488AS2TrW8Awe00z8Wu6GHxI/lB2MD8kh9Sf3BS1Bc8G+G13PoudSdGc/+81Xauos2T1Gp6+BQOcv570uU6Z
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:2OW3CZCplFI91a2cwBzDgVmS3KIIg5QFn3Ffh8fsLbV9xlLO8S3gifBWB8qKyegY5tfPRG7JeOLh4NUo5vP0D10ufiA8emUMBkT9WOtt/r36e9mpa2pzSEZM6cDY+24YQFOgb7WR1MyR+fMbmmEaaHZ4iVWnkdrStmhvgFL4krM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:27:55.3878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6754e32-432a-435d-8c3b-08d5f8bed014
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

This commit introduces the bpf_cgroup_storage_set() helper,
which will be used to pass a pointer to a cgroup storage
to the bpf helper.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h | 15 +++++++++++++++
 kernel/bpf/local_storage.c |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 7d00d58869ed..9a144ddbbc8f 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -4,6 +4,7 @@
 
 #include <linux/errno.h>
 #include <linux/jump_label.h>
+#include <linux/percpu.h>
 #include <linux/rbtree.h>
 #include <uapi/linux/bpf.h>
 
@@ -21,6 +22,8 @@ struct bpf_cgroup_storage;
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
 
+DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+
 struct bpf_cgroup_storage_map;
 
 struct bpf_storage_buffer {
@@ -97,6 +100,17 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum bpf_attach_type type);
 
+static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage)
+{
+	struct bpf_storage_buffer *buf;
+
+	if (!storage)
+		return;
+
+	buf = READ_ONCE(storage->buf);
+	this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
+}
+
 struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog);
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
 void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
@@ -250,6 +264,7 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
 	return -EINVAL;
 }
 
+static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage) {}
 static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
 					    struct bpf_map *map) { return 0; }
 static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index f23d3fdeba23..fc4e37f68f2a 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -7,6 +7,8 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
 
+DEFINE_PER_CPU(void*, bpf_cgroup_storage);
+
 #ifdef CONFIG_CGROUP_BPF
 
 #define LOCAL_STORAGE_CREATE_FLAG_MASK					\
-- 
2.14.4

