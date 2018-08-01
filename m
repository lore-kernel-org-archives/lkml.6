Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A234C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D5120862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="im9pKlEI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="S1oVP4cq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D5120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbeHBA1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:27:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59478 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732409AbeHBA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:51 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71MZSKj003989;
        Wed, 1 Aug 2018 15:38:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=R6SL8MWP0Mf6kG/U0G20BLxim8z8t80VeHH9u/nOJrs=;
 b=im9pKlEI8oMapPFNIoH8qX53S1i6SI4sHtMvlqqyy5htXrGsU1wFgd2S8Ts5HuRpqBi3
 aak4fmvZxmcWxta8pbWH7M9kIssSzwcbw9QTx9oVhai2o83jH7l8SYj9N4+cX/dKASpY
 i6T+jGLMBOuube2KieD4oJOJbh0IRdyLDy0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kknssr07m-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:38:28 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.21) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 18:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6SL8MWP0Mf6kG/U0G20BLxim8z8t80VeHH9u/nOJrs=;
 b=S1oVP4cqzKWfWXInsQcKLLEIbghgzJWGcbM3p9DjnWwF8JQMXxrjuF91jPja/4jPPoclncygDviGST2v+KWBzYH7K8t+jX0lO3ecHtK5cx4b86gWbxj7qzXKWUe1KXc3MuhsFrS2sKDtoZxARHd6kAF6HxD7pJLu3OuZZB8JcMk=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:7cca) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:38:24 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 10/14] bpftool: add support for CGROUP_STORAGE maps
Date:   Wed, 1 Aug 2018 15:37:36 -0700
Message-ID: <20180801223740.11252-11-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801223740.11252-1-guro@fb.com>
References: <20180801223740.11252-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:7cca]
X-ClientProxiedBy: MWHPR1601CA0016.namprd16.prod.outlook.com
 (2603:10b6:300:da::26) To SN1PR15MB0176.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f56311e-063c-4fe6-8527-08d5f7ff7e25
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:6A8By4DWtyo3Bp0WjgdpfF+xI38Rvj1NR068JKAuI0+j3vDTzS3x5nVMCnw2F7ejQbe110+JNwSiMBiSRWjRaxagXNBin3yVTAyDPla9idkgDxbN9HlXRSGL/ALytBseJ4DCx7xlkBxz3Vm/Em9V3BtswwZ1ISf4G6tklbPlpIY02XcY/IOQjAbuUfbe7/ubhStXXDxFFTwvj4Whu152fXBdMILDXTFF51gsdYPEYubuXijrU8Ha1eAB21tsOtHu;25:WgCsh1+Nh6RxH8Kxzdeh04c/dWCmZlAxqNZ7PtD8oa+tgwLWeC2ufYXx+DNZvWdohBzhUVX79MI3d0zjeNgzBIQUqy7j8ybxnDBw8JkHu6c+N7Kv7n+9aMzWp1nKUv1g6YT+Egu8ndWflzKkBMrxaTGmiagqAYpTzxaEGQEDsjLkTr6w4FC1Y+ApOc+PZgjw6bx8OOVynOt7CV5AJy/xESMMQlP2EZFlgrV8iD5VYLqHnfr8KIfrfWtZnFkfZIAfKBJENcUI9OLzirvOftFZolmTbd9RfDcqIniTC6TAdWazv+mNiGKhJd2wCp0UElveIksehRfZT+tlDxtUDaP1uA==;31:ZlXKzXe82YgyDlDjNW6Yk5BjrTD3Oi0Y6z5wZ+eRv8j7Z9G1yUbxwfKpY/tVn8S7jnMTaSCNfKSSZGEO2jhyNdgbpwVof67GAhLJgPFy9b0EfhX+NAVZT6wdAlsuap9Jj8D8UFx6qR2UFlm25aUXRRjT1HrYDrvq+ZqjuW2mJc8yECMzsHMz/q7bV8GuvbTbexKX5rtKC5V19IPrzAgiVNC9cLDBbBCTDwNpltAiUzU=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:fWc1mbYW83gPhXynThVBCsGtz6kGJoq04rBxfwX+4f+Q9EgoonDGNN04s7he0mn2TnJcoGfNPdSm/1vGH94PgM85E4vGcRaiO4ni5nrhEDHzDkCu2mpqQWzSsHOlzQEx41QxcShzWeBSMUMi/lsVhi1ntc+duKyDo2Gicv1I2UMmdv4JB31JmYEuGzLvoxNx17d0SVf5/nir4AWOAxEFAkYLfsRA0dUuBBBymODmv3D73ixQGKbGavJ6lbrjWhGPI8cvlTjuFMM/tRIQtSPDD2orfdc7uyDbY3Cpc1Y+yeJyt8RH18+jZ/Mgu8M9XJA+r0FzeRTv0aVn4GU84ouZf6fANrrzhCB93Cdr3xYxgMDM0SD4VZAsQLrBrjMHMqNszJCDyHXsfwJR+9qBwYxjP8wOeHeTL3qMYppNzjSoYgCXpX4hH/MJ61svuFMJfUlRn+XBHNUaB40BVZhVRFLyzeKnIMKxU4pSf97KgZ33ynUj7YsIAb2h8MVeaJAl0Yj4;4:5SXfosGkJLqtpNIRHcRFGsP7VXy21zG2UGk+6K5YDPDzhXzjf2VcV0Q13yzATI1uop18avFom//J1GnItF/LRSUbJJjLuQIYFQgujZgX47iPgxy/r/EtvZkLo+CsXxN+CeDPbBz1b5FzunPGt2/Mu1OVIfo2NE9o6iRb37pD+DMinKCDFsyNkkOHwLsoA0OBESIm7MFYxMri+RzTtEoL9Uq8+aYGQu6+JGfPrJz23KlSmbJm7JXMa5XpHOT06ADbqsRlZaB6n8EeqDlnTtX1R6DcmOExKHauKG7iJX/5Ln808y3sgTxfG2Jwkq0vv+cK
X-Microsoft-Antispam-PRVS: <SN1PR15MB0176E1955CEB9501CC88F183BE2D0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(11346002)(6486002)(6512007)(50226002)(6916009)(2361001)(5660300001)(53416004)(68736007)(6666003)(386003)(106356001)(6506007)(76176011)(105586002)(52116002)(51416003)(86362001)(36756003)(486006)(2616005)(8936002)(81166006)(16586007)(54906003)(478600001)(50466002)(316002)(81156014)(6116002)(2351001)(69596002)(7736002)(1076002)(52396003)(14444005)(16526019)(46003)(8676002)(4326008)(476003)(97736004)(47776003)(305945005)(446003)(186003)(2906002)(48376002)(25786009)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:Y31Qil99RQl5l7T+e0o1slG9sWyR0chc0LWl3Wliz?=
 =?us-ascii?Q?8rnWQs66WJkY8CQUtyv3FiYSYCsG4FoacngNAxgfk1yENiskXBIOz1edZYP7?=
 =?us-ascii?Q?DEpr84leEnr/Mi15nUyLnmBO5ehMRUBbi+CIXsL0Ag9jgfdK7J/iGcObZIqE?=
 =?us-ascii?Q?kTXtmhVE+cCdbDFe478MwcLn5brAQpdolv0cNDS8g4n9hOkRsHOrK+8LXgf4?=
 =?us-ascii?Q?yXzj2HlUVnKXeNQdaRb8EzvN8yt/Cc6EyDEZrAWyaoYIVZLuh1aEnK2GtwD8?=
 =?us-ascii?Q?pW3HSsNwwQ58FQIgRMPTLYKu1NGawEnzG7X1YuXwtFfyN3ddB9BzhAsfU4am?=
 =?us-ascii?Q?YuOr7VyhWpC6kLAkMbd3juRIFNTUA1yCTzRtyiq0k3DLZaIyigxtlf4f9xLw?=
 =?us-ascii?Q?rAOe4TYhIlOa3THWw19IUl8Vhfs9WhjCEGGvTHaZzxoGEfneEKKKFMqvEb14?=
 =?us-ascii?Q?GpT484KEdX1OYxSVX1OqAugc4tsAKJqGBzvUsLT+ZWusOnZMhlpTCeoRmgeg?=
 =?us-ascii?Q?J0rIGDrjbcaEYTgWE/OYUPPRVyWWwE1GZ59HtvetJXs/M6uoaUEeX5aGFAKD?=
 =?us-ascii?Q?JW9dLJstbMKAppfU6BGkuRqifhJfsvtK7Z+VxKQM88SBIFDkL5w9ZHtmcK3T?=
 =?us-ascii?Q?5LzytGjE5l2liQTsnRhGui8YrB8mzbleuorFh15nb83MjZ4vLe7KyuC3Jeiy?=
 =?us-ascii?Q?W7YcwvaGcPlUsgDZ0yn2kBluNdNQSn6vwW2X2SHqHij1u+jWT+TUkbJV/XeC?=
 =?us-ascii?Q?Q0/c3wyCzvizX2HZA5bIKu66XlLWwb+JZFC32UvOZT6TiDD3elCroorPFhwS?=
 =?us-ascii?Q?DgtunPrzqG9ldAAOL0/tFhU71QjkJUVUzeOlSAPOp2bthSkpL5Zx7l2OGa2i?=
 =?us-ascii?Q?oqONkuc8EFxJUDNg9RZmEKBvAnXy7r5M0FiYYBiMGXKX+3GTPVSlHGgGiLqI?=
 =?us-ascii?Q?DfG5LegVkO1LQb5adD7wVweZyv46CkVMRpEOTvWfoheZaQFnpFJrYPLMUOW2?=
 =?us-ascii?Q?SEF0nd2j5RvbzLdJT1oUVszCth7fJZr3L5+q8toDEOq9/WWvEDjFoCgVAPgn?=
 =?us-ascii?Q?kU2F6mPhjUtxMLNk+SSoD200MzJcwvvzZP7CsJAP8eMvPrZsb1gUiRMycPFB?=
 =?us-ascii?Q?dXXtP5IQzzN0K8yvYb0UD4/KyGS984BzRz5vbur14WI+vbIaFLY6YWoskzqO?=
 =?us-ascii?Q?63SVdkO4YsxWRhahUfquV9Gczh/TQ7lqVvDSiJ1mf5T/5RsLDX4mlqd47Alc?=
 =?us-ascii?Q?iJnGr/EyWL2N8038oxAA7gUyATeHX/EOjJMsR7jgQibx5g1eMScwTgM/Nnlt?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: 1A/6M2QeFtNu1VlJSMLHowcVF+ALzipV+rffYgaqcVMe3lrb6+oEnRufs42t24eunbqAwyH8Tw6q87XFaqyGuVhJWktOFgsaf+vrLgrDxgM8hKD+CLf0YL2tFfYtkAEcQ4/4rV7yXGImpOWOE3NyMAMPsdfsNjWa4txhq8Cx48NZCItvbCydolk/6gYvm+33XVPlR28kTkzXpKfIf9UJu4wAonPm7KJPMBx9RGJQOahbS0lqRNFBqOMGmmv6ga3VOsDSEmhy2yXQN0xIkdlnw4Rb6x5S9p4rr9yiCmyh7WyPuazn7YGryF/yPVY76oe6rzXixMY0S/VLpjkWSciwqK0Pr13QvHhLCTnwjxZJ8Uc=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:VhPSgMXi872LTiTotLy7U2FSlc/ZmcuEu/yzWdkvWcr2QsaAqIZrIytGhSnv36a8R2iCHR5LBIdqdI2O7mDzvFVW1myxxjkCOOTcHuZ+MGVPW/uGIMMko+yOvXmcC/xT1p2YKCY/HYzqZfvZPG17gpvCVPQFtBVwN0Gi/5O8z3aJ5JWZPmAs0hrzzP7KXBcPrEQls2aqxew1ZrsaWNv1ezhaQIn8YmTniG9DaKAEVBEWhU0m4duyReuHfk9mFxjZhUSl5XsMloQ9BPF8wIt0QNZmxC89QDaBZ6FwvIkg1msH8fHe2jQ5ZJYMFRdhdyi+HAvMJYKL2JuNJYz7qPt9EOjeXBmDl+MKk2ZDsIgiW55TvY50LsjT3pnm3CriS7eEdh3w5IygeL4uWfd+uRUAJxaK8vmdO3/OR9eJ/c5/A7xdksS3CFAcsKMEfMBsaHEFps6td+L8NMyGiWjTxFAGiA==;5:d5t/1agh/LFafZDH/Wj1D6kSIBdr3t4DKonRwyrNdNv8p1qSqh6WMrNg2imY3+ifbk5M9F1On6rL5ljfe3ldwZ/kLwwJJ8HC3YoAl385LSoMH22glZlcxQI5xXXXI0tEA9/qP95BTlSP4MLJNcWhiTucC17RlvAqe6+LgxiyoTU=;7:ljZmxX616ouVvKrLE03EBbXwuQDu7MhlNapvfDiz53kUiwHZu8pTxk8ToRD5OZg/MvHW7VR1J3m7GjYgOUZhg18oiBrgvJz8tEFhYBIG0GCHtOwC0Dt4KY/nc6aB7Hd4XC3BJ17PwXMIgc1pUIxYIYMErS5mOsrAo6AZhwCkv4Cd7WTST7hEv3Q+yBmQMlK7qxxHb1xkEHtRAfPSMEszFZBkMAvbX7t2BxBXTdOcNb5JwLmOqnIQNomUzULNLCIR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:kok/aJcb3mFdRSItRutCD+gKWDEKCh80juSmKcadoeGoRB3+DLlqNsvIJfvuJBERr+aOkeZsDRzqYPMS1Kw1eZwUT9PlCUlOKOSJ6UISifj0gBmXyp6h0264CvheqrECy30cawFdfZqwu9v19V9MMB6rCNgf8cpDznraNV6oB1g=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:38:24.1716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f56311e-063c-4fe6-8527-08d5f7ff7e25
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0176
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BPF_MAP_TYPE_CGROUP_STORAGE maps to the list
of maps types which bpftool recognizes.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/bpf/bpftool/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 0ee3ba479d87..2dd1f8d9cc2d 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -68,6 +68,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_SOCKMAP]		= "sockmap",
 	[BPF_MAP_TYPE_CPUMAP]		= "cpumap",
 	[BPF_MAP_TYPE_SOCKHASH]		= "sockhash",
+	[BPF_MAP_TYPE_CGROUP_STORAGE]	= "cgroup_storage",
 };
 
 static bool map_is_per_cpu(__u32 type)
-- 
2.14.4

