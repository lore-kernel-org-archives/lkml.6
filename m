Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B891BECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503CF2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EVNja8mn";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="N6ZMxb/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503CF2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbeGTSgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:36:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38264 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387881AbeGTSgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:36:04 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KHhh0p025812;
        Fri, 20 Jul 2018 10:46:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=JLY4YhEmv2Q0OMvBg1KWpD1OGkIDUDn+eQMEK5i9oog=;
 b=EVNja8mnCTilNyerWL+fhIW8Z8dvTpGF2iECUoksu3jTFdQdiQJ5qiRmqdqcf/XKbtfr
 5+TFgXNljT7w8Uoc12VQETf+MsRs6ImOr9A/6VyZIzVt7Q+J12scDro2WzptLY8CP5iq
 XCfdAZZ7VBa79z5UdU3h9P0mc3xGwgmfPU0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kbmbv80dv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 10:46:25 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 20 Jul 2018 13:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLY4YhEmv2Q0OMvBg1KWpD1OGkIDUDn+eQMEK5i9oog=;
 b=N6ZMxb/zklntjPOQftXc7P7T3ykiF+/+4WiOmwSk00JSCeaH48iwtxn2L2Iign1WjzuaFM4PLRRfuMr+Kx8Z5043cEbO/vvmAqbt+uAc9XXr05/OI+L5YBQ4v5SLK96BQw6APgE8LxiJY8YMCVRA1lWlUq2vUTMeuBa4D8XfRtY=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:ca05) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 17:46:17 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 bpf-next 04/14] bpf: allocate cgroup storage entries on attaching bpf programs
Date:   Fri, 20 Jul 2018 10:45:48 -0700
Message-ID: <20180720174558.5829-5-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720174558.5829-1-guro@fb.com>
References: <20180720174558.5829-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:ca05]
X-ClientProxiedBy: MWHPR17CA0096.namprd17.prod.outlook.com
 (2603:10b6:300:c2::34) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d683ea4c-1203-452d-864e-08d5ee68b2a4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:gbFhgdxoY53OcjU6q36QvMqubWaNNKVC66B+Vs/Ha+uOt7CkGJw7tRfL4hcfF3YPKTbuAfHNUTtNUU6CfVbFA3KGW/rwvDZm/ke8DrTNom121QCIhhlN895KvCeGSoAHF1enJ0B3+qUGT/HU3ok+TtxmQk1O7shJiCdWzoaKaClyCkWr6EZ7dVBp64K9Ja6mh+eJVN5sdTC0WlZskd0H/H/atJBFRhmMTX7OKDffLi0+vbhH28wLijtBC6Y5wATs;25:EPg1wIKjT9uJGmgqAE3jXYtlMI6ZpAzLudNVUIRVTXqIYXTb8crBOUH0eg3XcDdPke95UPl8fuTBzpz8nnvmfzRyn+HO+lVZ49u2Enqeizxrbtd8/Qqf+h1o4h1d6ixhN2BOI6ytC3BiWTKskzPUrEUuFQXVXSLX7qXptWgqaIkpN+T0JbKvozRBSMB/aINu3ocg3MHLdoOM4sMTgTJIh6+hfl65XsbadlcKoFkw3Qcqm58EHA7LOyjGP5z7IiYB+GEnisTP6d2S6Zhf/OrPc1Qd17UrNIHnQqqCHzERfAUx9s52KGJuz0cImmZJSerac97rKRfyrk1aggRKT5Z8DA==;31:yLnL3bohJL3gPFpHAokf5MDNWTxC3lSZyGqhdVGI1xpIYu8zwiGe8iKPx4QKbFSS484KDQ+JQ7v2Du4AmvO7gJrNupeIn3255GMjF7FlrvliHGdsnIM34R1tl5C2Z+QfwhK0Ljn3HbUmrJCxITaGLhF8ZxGQegV4/q9wK8JsZ8BIWE3RgLh8FtjOVfQ/zpgv9V/aKa0FofyhkeAOWvaywVdGhOQfkXvFZKwpR0UOir4=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:6JPICDUElr1glSEfgrDWDYI5gGTBnGA40GKxTrUtJGqs+8DfFzAn7I2R2pQoO2y3pJNoXWm/jwvGyZsSty6wApd1nTh8mlcK6KBvCr0Gio2TT/xmUAvHWrHhRnvezue9CRk5swpSOAGYnYg+Imv+StTC5GHb6iR+qTR4udkf/XdY/tWTGOffsaNKoiJ+32b+3mqCUjO8qFSp+KHr5naJGEjkAK68Y39d6OygNcSrqhUGogqEhu4VpulOsZN0N5TsAECdOfhs9jQYBAjg+bK9S8PEZvIVsA0+hnr4Vs+8Tc/7KE30QiLpFlnRQmZJrr0e0HoukBMqIm6FXw5aS3GKG+KR/5TDE5CvTLDqvrPyBtCLORHsMAIPkC9reIRn8bWamyUfIS2mLPfzvhzNzpAj/LKaiSXmaDk2FWDIohxWATXUy3XtKnJO2O9hxQ2iUh/0//bSkW5+FfXCMPORiB5xAEYKgw+CVJRCtajixxKI80NFPA1fJph+B8lQZhv2Kn4V;4:/r0FBQo7ykVb46qhLnWqpCHCkvsrU2bGd4TOMgV4jTwwXVbCpYl+b6E7CxZYKqTRoJwdUZKm0Ko8cxhuVeYfn2qQMsG2T5SjCbGEyW8x+ogym2uRD3tZ/44fWl92Ct+/Db3VCFJAMAQgQq5FVURDdkX+4w3ZGYMLv2lApvSKgZpgvpYD9J0PBGzH7E62iMgYgHFIZ9lueI2fM724KR8qVc10PHaLdDuqyYtMZm+cjKgwt6akMIE5m3USF/s8Rpg36eNQc3rTxG+eQDXwtKAyraqWeLaEZk58yWwok5oKMIB0WTYNwn5eLme1sb9Wus2J
X-Microsoft-Antispam-PRVS: <SN1PR15MB01757CA9EDA6E2EEAAFB7D51BE510@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(6666003)(50466002)(81166006)(53416004)(8676002)(48376002)(2351001)(68736007)(81156014)(106356001)(8936002)(25786009)(105586002)(1076002)(5660300001)(6512007)(6486002)(575784001)(36756003)(478600001)(86362001)(69596002)(7736002)(6116002)(305945005)(97736004)(2361001)(16586007)(316002)(52116002)(51416003)(52396003)(446003)(50226002)(46003)(54906003)(14444005)(47776003)(2616005)(5024004)(476003)(486006)(6916009)(11346002)(386003)(76176011)(16526019)(53936002)(6506007)(186003)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:RVSPFlTSmgNDT/Zs7L/0AYV8CFpjsr2CGfZBTefXF?=
 =?us-ascii?Q?cvgbodJmrOkl/QaTb2P6W3Q+ivT3tnvPLmosYo7u27Nx9OxOrmajPzaTzXXd?=
 =?us-ascii?Q?gwnhr9G2pRnk0Wm3TerfDj1vCQCwL1v9lj4jemf8aW4DV4cIrTkYED92vF6+?=
 =?us-ascii?Q?q4nbHL4yqOekA43Z10fiKDZnDm0xeG8OptWAnKFfWaFRYrdNXxYbFXMHNSK5?=
 =?us-ascii?Q?VPVyfR4h/99hCtwUHEBj8s/sZhpzBDCubpnd6K7wf1gnvH6nEidFGhsi5jBT?=
 =?us-ascii?Q?NY2OkZc9l5WzAp7wut1i7kJybQUu7tJs7Jyba4lKO70aD1gzIKqEOHpIoSb/?=
 =?us-ascii?Q?/cIm7yAV6nqLbb/WZzoiw4/GvSolOpWMkO/yKqp4o8zGg/yUUM7UGIX9fb6o?=
 =?us-ascii?Q?WCLhO+TGeF23lHns4sHO01qvuQi5kCa+1KpkM92N7mFPl/Wf+NCNEVhMAjtu?=
 =?us-ascii?Q?yWijfyUouT02DHnoaBhjAqKlqfhjAygTrVY/otIKN0xsk7A+AJlFsHWeBjxg?=
 =?us-ascii?Q?wLR5DkWOyL2wioMOekFUQOsdTf00glUZyc512ccs5IpVKyxal4+e14eu0n32?=
 =?us-ascii?Q?kgxYzjtfNFIfVb5pzsRqAMsUhGH7AxYE1oYTtv3s5QB3vrT0zuJJRmqMFqoh?=
 =?us-ascii?Q?ieBcosHP5w/EaCVLdEOYhA1f7CxJZn92GtAoeE9YdyI/A3n1FNcD+X6JEyNq?=
 =?us-ascii?Q?qiy0qc5wWtcO0DVeN5VY8jW7iIUSeKdcVgSY22rgVRTH8aPq452XPSc/zjWl?=
 =?us-ascii?Q?b8tMikeRA3q0YuLrIvH3BxYR9aKYALqrtmWvSL/HeHE5CwTQ0UWL4pt/Lv5i?=
 =?us-ascii?Q?xuAAVojeMWAUCJOcE36Or3f08GWWBCLjJZjNZri0yAYL95bldzYrVqd6OULh?=
 =?us-ascii?Q?BRS6HiIv+BGdW+DT+UVacM5OtgzRG6S6hPw2yrgoeJeR9KMT317FfgYuCUGb?=
 =?us-ascii?Q?rdvCWn2PbJ3FVZlQoqfauNpC/QKFr70ivry2vnesi26iN3u6WVgK0iLpiK2k?=
 =?us-ascii?Q?1OTZIW7zcZUGeul4nsM8hJ0BmXHZ25v/jtOrO+77ybfXhZOXd4OT2wYSS37E?=
 =?us-ascii?Q?3oJQ2EZcZo3xXWgD69Tz7CMIPFDLU9Z1azEYFrVmMmcFo4vxTqukShz/oAMa?=
 =?us-ascii?Q?8WIQBfalwos/1qM36j1T+UsNq8cSjsCPSYCmh2Y/rZMvFalPdjbdB8AHa2yI?=
 =?us-ascii?Q?E0Yc/GilfRKLR9WM1j6Guk7MeVrc3gwmShTe1j1gDMeUwIIZoa7niehEiAmD?=
 =?us-ascii?Q?ty//YRx3UcG+gU7jqbfettZ7Gcd6TRbg1OgWldACcxT3zM0hrIPbNvj6Fsv7?=
 =?us-ascii?Q?2YEh3/5W0h6mseEndaPReRtvK/GtYt3F9UeG4KxzjwK?=
X-Microsoft-Antispam-Message-Info: PNOhc7bTLBUpWmKHRDGeO/UYg5drvh5TCtS3RSj7GZ4E1glhR+Tos5qpSgNNw9H6vyERghOWhe3pCgHDYaO8F+lwcLI13EqLVKo/ySvt9lPZXAq/UW011fW/rzUiMpXr5FjjybMtscRPmXrmdQQgCtd5/kb/1178KpQIZ57irKQomkijxeT26sTGeO9J+yn/2WL6a0BiM1YMmTVC4gS5EfyNZBkIxazqHcO37vNDMLVV1lbxP9CVDHZdzVsBXNtaHaLI/fCO5HdPzNhAGWvtVYTqPS0jdM3n5YRVWD0uFVgGpXx2t2MaapxLTANMfvl60zsxqEx01DLIKvjaJeVMqcbqRTCd8rob082XKq0SJ5s=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:bsdMSbx/CDtGtvfUu//C2XUDf139KcjIeslzDqJEYmEnEvERx+GGSKIl2Y0dExXo2ENcRgTCTi2gUYDzbP6IJIV7Vh8dt5AZZUxVBDS1hkYiXQtC0pssF9EWl73tsXjiIxdl1W4vtVOiGRAT+0GzmPgChdZsZaRB6UKuECnG2ph5E1wCE0yMsF/yfdAQezaQiWuPD4r43Evrfz5J1pG0Xv2KbS7WhXLnWP16A753vgoTldccSIbGmUPV1iteJfv1ELIdw9bHYSRhQBBjYJDw1Lf7TvGhhYomX53aVYVQz+biHx4RMeumo4YdLTFDyYVtVmrDupcqAye/0aaLLMiDLaKyWPTT06G/nbuJBvrhTfDmxMgyNHxjHkW58ym1o/oE5MsQu9xHYlxzn51tBeyWrhPGNE81ZRfFDO0bS20qXvPhEPcb89cgglSuotemQPt77KV2O5HEkOJq/pqs0S247w==;5:WI4Jp8qUvAmyFWkBbhuvlecEDv6NkQ6hS8gVKRbjEk+E03/bFqjFF6+Nuei/1AROTHOsZurgpZgvipmcA/rtTGdbl0dST+SddNy82tHT4Q/E7RchcxRWJDeuxBWikdf91lkpp/bJ3fvsF2CPPGhsLdA/2ddSVlmr2UYWw3OupC0=;7:LLooj4pfhu695UVXf1lZ5zTsXcM2drL9KufHjfIntKP41vjepTExfWX/SKLD31ugvr3OZ6xWAhHbgGgOIVa4i7vCVKPAoUpB1BxVosB/iGtdK+jidJhy3tIX67wDsPLfBSMjbTczKCC6+BARa4uMjzKk2hOEt/KH/cl7cc1YDO/paARu30EK6x2SiVmXiHugmYYK9K09CSjX8b5RZwcDTyaZDb0dvuKwXBDvwfbrxe8IpJyllXm1BYeb+rNPOt7W
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:DUTbDAcd+O5Qgxh76AoLANkHQIeKv4kuykf95l+BW/U6h73Jd0QrZkDyw3Cvo1u5bvExJlPmA7Cjc9MBkLED932nlIc4W79Ysp2oemO88+C1WpPqDS3d7RMsNOpgMpL9KuqkDlrR1AA7Wv5WbyXlleFtaETzFeA2rqCPTQV0BjQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:46:17.6893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d683ea4c-1203-452d-864e-08d5ee68b2a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a bpf program is using cgroup local storage, allocate
a bpf_cgroup_storage structure automatically on attaching the program
to a cgroup and save the pointer into the corresponding bpf_prog_list
entry.
Analogically, release the cgroup local storage on detaching
of the bpf program.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h |  1 +
 kernel/bpf/cgroup.c        | 28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 1b1b4e94d77d..f37347331fdb 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -42,6 +42,7 @@ struct bpf_cgroup_storage {
 struct bpf_prog_list {
 	struct list_head node;
 	struct bpf_prog *prog;
+	struct bpf_cgroup_storage *storage;
 };
 
 struct bpf_prog_array;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index badabb0b435c..986ff18ef92e 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -34,6 +34,8 @@ void cgroup_bpf_put(struct cgroup *cgrp)
 		list_for_each_entry_safe(pl, tmp, progs, node) {
 			list_del(&pl->node);
 			bpf_prog_put(pl->prog);
+			bpf_cgroup_storage_unlink(pl->storage);
+			bpf_cgroup_storage_free(pl->storage);
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key);
 		}
@@ -188,6 +190,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 {
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
+	struct bpf_cgroup_storage *storage, *old_storage = NULL;
 	struct cgroup_subsys_state *css;
 	struct bpf_prog_list *pl;
 	bool pl_was_allocated;
@@ -210,6 +213,10 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	if (prog_list_length(progs) >= BPF_CGROUP_MAX_PROGS)
 		return -E2BIG;
 
+	storage = bpf_cgroup_storage_alloc(prog);
+	if (IS_ERR(storage))
+		return -ENOMEM;
+
 	if (flags & BPF_F_ALLOW_MULTI) {
 		list_for_each_entry(pl, progs, node)
 			if (pl->prog == prog)
@@ -217,24 +224,33 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 				return -EINVAL;
 
 		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
-		if (!pl)
+		if (!pl) {
+			bpf_cgroup_storage_free(storage);
 			return -ENOMEM;
+		}
+
 		pl_was_allocated = true;
 		pl->prog = prog;
+		pl->storage = storage;
 		list_add_tail(&pl->node, progs);
 	} else {
 		if (list_empty(progs)) {
 			pl = kmalloc(sizeof(*pl), GFP_KERNEL);
-			if (!pl)
+			if (!pl) {
+				bpf_cgroup_storage_free(storage);
 				return -ENOMEM;
+			}
 			pl_was_allocated = true;
 			list_add_tail(&pl->node, progs);
 		} else {
 			pl = list_first_entry(progs, typeof(*pl), node);
 			old_prog = pl->prog;
+			old_storage = pl->storage;
+			bpf_cgroup_storage_unlink(old_storage);
 			pl_was_allocated = false;
 		}
 		pl->prog = prog;
+		pl->storage = storage;
 	}
 
 	cgrp->bpf.flags[type] = flags;
@@ -257,10 +273,13 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	}
 
 	static_branch_inc(&cgroup_bpf_enabled_key);
+	if (old_storage)
+		bpf_cgroup_storage_free(old_storage);
 	if (old_prog) {
 		bpf_prog_put(old_prog);
 		static_branch_dec(&cgroup_bpf_enabled_key);
 	}
+	bpf_cgroup_storage_link(storage, cgrp, type);
 	return 0;
 
 cleanup:
@@ -276,6 +295,9 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* and cleanup the prog list */
 	pl->prog = old_prog;
+	bpf_cgroup_storage_free(pl->storage);
+	pl->storage = old_storage;
+	bpf_cgroup_storage_link(old_storage, cgrp, type);
 	if (pl_was_allocated) {
 		list_del(&pl->node);
 		kfree(pl);
@@ -356,6 +378,8 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* now can actually delete it from this cgroup list */
 	list_del(&pl->node);
+	bpf_cgroup_storage_unlink(pl->storage);
+	bpf_cgroup_storage_free(pl->storage);
 	kfree(pl);
 	if (list_empty(progs))
 		/* last program was detached, reset flags to zero */
-- 
2.14.4

