Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0F6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A816D214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UqC0Uozu";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NfmqJW4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A816D214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeIZRqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:46:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42922 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728101AbeIZRqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:46:49 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QBX3aI019774;
        Wed, 26 Sep 2018 04:33:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=LSkTcnRrd3uLpDU4ITYybN/wy8vDLhlE4OZguhupMfU=;
 b=UqC0UozuDM7/YPUweA5qUBwzMPgXbUNuOI47NeJXikBruRiJkpEYQHcTNXDt/eNk8FCq
 /QsEfCsJYOQxJTUahjnAeAJtMSftCVTtiOF377kns7RYLWEarKtT/cUG47SPwIVJVfRq
 LFqUqrVOcuz8pjs96v+YxicRfHq2vsVPO7c= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mr4vc0njr-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 04:33:56 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 26 Sep 2018 07:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSkTcnRrd3uLpDU4ITYybN/wy8vDLhlE4OZguhupMfU=;
 b=NfmqJW4Emd6v0EoGr9lhek/RVQd0+EB/BIlG2nOLChWwABWNpZ1s4/0eFJy7RLEByllDs+BGt6+L+lNSue7rwyB9y71SDRAN32FcAINcsXG/Vy9TIVHi8QHJlCF+pIhxDzqrHZbilMACGV/qnzkgofZYa8hC7Zr8FVEqtq5ShWE=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:15cb) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.20; Wed, 26 Sep
 2018 11:33:53 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 bpf-next 04/10] bpf: don't allow create maps of per-cpu cgroup local storages
Date:   Wed, 26 Sep 2018 12:33:20 +0100
Message-ID: <20180926113326.29069-5-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7979b818-0b2c-46cc-a912-08d623a3f083
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:iQICqtUwrXh8eajg8cxeF0SCNMAoy4L9o4ehL0qLKmHDzujusgmdeo+7foO4gyclHQ4IWSPlQFqE8WnlTIUzzRfy+SEDdBUC7DMx3IdvOa0Bio4ZXGXTcMvAuAeLZunZlDmhcGKXU836T6k4luYmp2MSY6LyJTN7MpQ34kA9ddhrz47CoUyTXEsUO6dQ7b/xemW4GJ6ExdSIeRhzeTl15sfU8BWe66S6MlzzeKUtqf4FwazllZ8xYDG72O9T6WVg;25:3eCFVedmqcbJQ739AS68Kj07vP71mnqJBerzDWSeL7e/Af/22Q2Fs2t5uJKF+xEDEDlQYIu0x0m5+3ttgx5j8R5hc7i49YFCpGv3yKSEQoOvNYA/FsoMlW+yR7VoPZgaOgdT6ZtWbM8e6pG3y0BAwCkrYKNdfgsHdKPqaDEek0HHJPivSZiCpmGhQZE13US0uiWigE56c5ChEOxrU8YWzBwBv58dHW5g0PClp5v76qFu8OpficVk2KdEVxJLgiPkk7fnTQL0VoYsDJA88gi0/nE3orsbfJTSEUy4yEIHxACEEQL/xy4+bmkFQsvCSmtOmF3acO0srC2Yxi4bFe38Lgam/HnqnxkPQmp0ylrO3tM=;31:7rk4fsJL4ERPaU7qNpx764y7rWS5WENF9rzx8ROkWr06Sm7lH3n+jPBwxBsbpZkNNnWRzszoq7ZB4Hr2+CMBpJjLhHC5xOnyAtPJLqtivCxQb3Hu3WuVEnuxzzHZlP2y2zC+dJ0ANGOeFIsleI/ZrscXol5nyvZnXD3PQjUXPbytm3a4LyGsTBdVbRGr9VZOAwHB1xB4qc50AZJLaPaLqi9r92vatVqXsxfwFrpU/NE=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:1d78eNCyH/ss6dCdaxpn/CtMAgDy9KibphSaUtF0eCVM+ubtDN03zbSYy5D3IPxRORG9/2rF9d6H7FjbOmNk5XL/YjOYb5el2aOpzrMtlfSFI5ckjQEph27pEaQLfio3hmvDoC8c+rGYK5VzcwH9KzJpGHDtNBLuemwkpxI3cl5WhbHt3M24fVWj7aGWeuu0moMPFKw8xu3cMLf0O8jmE3elRvw76cZf3fD5I30evsvNG+cL0C/UApT9gd1QEzKKquoHjp4tv1EuJ4zJu/5Ff4cMFT0luuw9QUXFDj3uqjppLraNyWJvrDs67OWcxJCS3G+m1jWYTQgZ4k6NH+g+8ohBAySm2fRJyW1u1s3slr9skTt3OFwJ+u7+WaEFx8n+ujBIXLu4+hIBwv6PqucS5uD6kTuKtX7KOEkrV6t8Ii510AnrCsS3pbIDTA1BKYlL9KYgvoe9Eq0h62mmishOltCEjLURMWyFBKSrNaoloKPS9jFEkm87yZYl4s8530oi;4:FDuim72j6pDT7jLcTtTIHbHm9C6xet11GndFu3x/cACh/FKJ+1F0jlN4WbC1U/84UsWblLrBwlmErovDieyby8LwU0CGSyinMP5z8rwV7dZJZ9kXMQrBqGNMziZLzLPYyWxNP5aA+oW5jRZ9DNLw6VG5jKhme4ch3+lXhHuwE7jVuSdrP8q4Nb+oFdnSen9SgOqUH453qoG3//KDMmbadDAlttrmp7CXdvdwK83n1p9Ce6FXF3bR8bGI/rPUVIh+l6hjlh0VZ7N6oKCbzWWU3TOT8nGsHP2jOar4flVlHSFG8eJgb3vmedhud6Oisa5c
X-Microsoft-Antispam-PRVS: <BLUPR15MB016207129F537782991A265DBE150@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302057)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(446003)(16526019)(478600001)(8936002)(46003)(186003)(11346002)(36756003)(52116002)(51416003)(52396003)(76176011)(97736004)(2616005)(4326008)(7736002)(50226002)(305945005)(476003)(2906002)(486006)(106356001)(6512007)(2351001)(48376002)(69596002)(6116002)(50466002)(1076002)(53416004)(47776003)(105586002)(53936002)(6506007)(8676002)(16586007)(386003)(54906003)(25786009)(6486002)(2361001)(81166006)(316002)(81156014)(86362001)(14444005)(5660300001)(6916009)(6666003)(34290500001)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:7FjxNdCSbWJs6wWtFLqOLZks+JPog2aHGDeVX8+TW?=
 =?us-ascii?Q?Tu+ufum+IBu8nu26ObAnzahocKJbQHw54KIxHm/TfTnaOAAAkrDWlgu8P2ba?=
 =?us-ascii?Q?qWhuJ4RqUmD700ChNsZ1vqv6EbqPJZ5f1CZk92QP3qTy+LRgKlf6B+yeECol?=
 =?us-ascii?Q?gFT+QKUCfre3joSfowFqIcNabOA/w8NdafFUY2KjcXfMDYNGOGPq2IMvO7vG?=
 =?us-ascii?Q?cCG76LptER+jwBsOtC/RkoHTYC97lVYcsVt2XQg5Ro9QiySh+0YtgD7OSmS6?=
 =?us-ascii?Q?v+kzL7ReePn6cBHAZIiZARChKfmjv39sh+bPK9mQjg2ExkB/iUz3/b3ThiM6?=
 =?us-ascii?Q?MGNKFdzx8z4diWYNRT2k4RWTEIj/Xw/uZcgKzsoFxJfsIceA4eV3Q5omjV36?=
 =?us-ascii?Q?jNJtFGFl9GZWC0QwIRE35T04Prc51ZOQutPu1YykONj5IiptBnRBi92bnb57?=
 =?us-ascii?Q?WzBNqAVaOTYSK3MIHoTy37QbXNfK/mkQ0XpRwSk9xykb5cHURghTpe8n9P1i?=
 =?us-ascii?Q?9t5eHL7CZ4PWQkjEmZm1JXfNrAYw6SQTzTHkfw09YZf1fZFoQPL+7bDmfRKD?=
 =?us-ascii?Q?EPxmthnrIy0lLMq5wBZdg0jBovQGShVnP0LrIF/zfNAZ0y5sq4UEjEQTgZAc?=
 =?us-ascii?Q?9+Gn4z65C6T9xDLEPIBQX1IUTXjNL/zLEu7OxS+cz2nhGL6dlcymEKzQnO18?=
 =?us-ascii?Q?Ogu5HOOn1BHfBjecLgnxLcibAH36n4aqFJSdtaTIx6m6WP4Lyg+4gz33YUY8?=
 =?us-ascii?Q?AcrKXOUij7mKmB1MJXh2LVxkxh6bwbvAcEE9elRzhH/EPeyu9tnbcY7Mx4L0?=
 =?us-ascii?Q?AurRnUR4dYEcMKNrMLq/RDGyWfqcuzNOkoiJOY+wYTcIOFydvo8HyFu4IZTK?=
 =?us-ascii?Q?8CE8UfvzkfN6Yfw60ysxTuX4QELRvq371Aj0sP4U+ehXjvrK41dmpZj+ET6Y?=
 =?us-ascii?Q?oNi26uFW+t9sgVFGE3OT6QKC5lQJdUX2gVSqkCk57RHGe29JguNPutLMCfbY?=
 =?us-ascii?Q?aR8lL8ajDOfe+QjEspjPl1lZC73eZEqln8Wtm+4LyJ08WbXNZPff94eGNq35?=
 =?us-ascii?Q?G8k1YXOzcM3rmIM6s6tR4VeFD7SVBICGiB1YYQvnAewkXThkU70ITj5Eixhm?=
 =?us-ascii?Q?SxucPEKlVrG8vW4Qhr233lbP8wTz57PwTIKEJd8UDeDpy7CqLVt4sGGn0YU3?=
 =?us-ascii?Q?eCTJM88bakSAwXazFWjQ6g8xjCsKWpZvYxMhTFHWdlAGiMPeDhHl6Nu6/SVF?=
 =?us-ascii?Q?zKLOPSz7lUIQNTYSW3pfeR0xhDo2OUeQ+4cOoIwAwWK2MGEZAUm/Zh4azx0Q?=
 =?us-ascii?Q?64EzRJn5UWN4VoAX8dt/lM=3D?=
X-Microsoft-Antispam-Message-Info: hJR/uKCsM4okziAcjN05kBG4IxoB29v3i+H7n7iXbobnX8ZzuHNy0GdfVrxrwjUYR6UafkGlf1Rs1sBW5HjyecRaR1ZD5j+8qtWKQwjg82QFrwxCF61zzGcAj+PKM/1h5wEv23UxKO+5L4sFfBwotZYsk71MPKnpMZn11miKSgG9MY6/kui7wGgfXib91fD4upG/yAf9Z8b5VFHbkYtienAZqgugErQjnXyaeIdD3CKEZLJV0EdvFkKOMyyHw4pQrHoKauFx0Ora+Cm0OrL1pLdD/YPJhvPy6tfCwGm7fK3bmJjL5BklrKm50oV4Bo4uwffFGRrB+Y0rexvfZ6ZTGefwsH6WsKU2Oq204zUyZ70=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:Vy8AN5ydhmx2uEPgREvAEDGnVBlyJjgCxjvHZtVaRxgRTtvTge1n7WMeBqt5hxvTLb/QACeOqOC2aWVv8cz2/aXkDeQNC3y+M/mhzpHrEfO9XMGUAWwgMnSkTCX4Tglt81Vow5Ryh5gKk3vDHOu0FMih4DDUcYzkxESk7rf4Of/QNuK5l4BPOGeceA7IspAiIthjQaDSrGfuGY7sg8q7pn+mDR/7CVsZouh1NpeNfpSPx+Zmq6pB5D5ahn4V6SzGP/H3u8A2QQ18dJIlxbtwTxAxT/9CmDdp8J+TlxuDoIf8v3ARWU94hFANUDiQveqZvUmKVE7UOgYuiLTNCJVdY/7ZWr5hZuBGMQ0tdrExUalSjsZIZrc73WkkjIJassB9FoqDwK6WC5iRIosOZCEEbKS00mSGNXoZbrvjMdo7JCdcz1pZAHqrFHPlzjOxncSBQJeVIjTqtmkgjdTT5Gy3tA==;5:pMloWjrgrXa0PCHpSk8VLruGIkTWQ+IEBlwQSYFFU9VDHtAZUB8Vmblf0ND5nce4PJ4NfL4Gic1kPuU7CGF374zRF6VzjIfABVq1RgYvmv7HAEIfgcu4RyBWPwa1zvAzTdlzbYsZd2Kx/50YL6kuivg6w8neqhMcPycxKl1PJ1I=;7:UEQU271piZdOKcECaYZ09nmIoJqJKrzVn9XczA1ikdnktob2E4z54Xm6tqhS465z5QOaqzW/MUQFOWa7ebPpKrtoOKyDh0SEwDOn9MNuz2oTBUY3UH7WJP6XmQWvLV7Af30AhTdR+1m6u/I/fKyVNwF2uJzfOAX29m9/qFaLuqNBOxc+PENoVhTL3ijH14DNPyY8aCo+H1TOF/nonqfmAP2ROaITz1QfanRV6mXTV40Y9eJ1utxhuPguSu5Hlq2S
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:MDxxqCQLamUzPwFHM+QU7abUiJzydtNEV+XVlVzsvVo+5x9Zs1ytK1hjS5VlIzAvWbIIHdLwm6ab2Q0nxC29nn1ifuIrO2npCU7CvXE5AMmZQzqJD8Li6d0/fMQVslDMW2g3YpvS5EGycjgWYJOvKNfkxKGLS8ajo7nKACHkX9w=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 11:33:53.2588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7979b818-0b2c-46cc-a912-08d623a3f083
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

Explicitly forbid creating map of per-cpu cgroup local storages.
This behavior matches the behavior of shared cgroup storages.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/map_in_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 3bfbf4464416..99d243e1ad6e 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -24,7 +24,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	 * in the verifier is not enough.
 	 */
 	if (inner_map->map_type == BPF_MAP_TYPE_PROG_ARRAY ||
-	    inner_map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE) {
+	    inner_map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE ||
+	    inner_map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		fdput(f);
 		return ERR_PTR(-ENOTSUPP);
 	}
-- 
2.17.1

