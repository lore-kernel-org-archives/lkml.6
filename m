Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3848C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E7B2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rDMZN+B8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KEa3DpKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E7B2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeIEFkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 01:40:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44754 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbeIEFkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 01:40:16 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8517N67016355;
        Tue, 4 Sep 2018 18:12:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=rTLbBnCGPzdLCKxAQyUbzt+Nf4Axpj7urDT0jcCo51A=;
 b=rDMZN+B8MfXU0HIgScKE8hmfAtK+dBsuVgRMPwQ9cIZ9+d1EzjouYz10KG5HKkpSs8N5
 5O9lRIQa7wrteMzX1W674qhdmDRqkK2vtDgutNtQj0E1xaWvof7VlXWCbOAUkyAj6vci
 QEaQdpeDvr7sR8PTMLIlGlrUfIFUsXSFAlQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ma4w302k5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 04 Sep 2018 18:12:34 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 4 Sep 2018 21:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTLbBnCGPzdLCKxAQyUbzt+Nf4Axpj7urDT0jcCo51A=;
 b=KEa3DpKrc9niiH8T+jYgfLNat/g/RVOVaCjKNeV8f6TAbFmZL/cc/QIbgGlX4U7zo1aOSkZp812xF/xJkrsEw8kA2a4Y504EfomNeZXF2EaqO2m2mf9YTScRROlySkiS88LDnMNgnkQ7fmuaZyRy2Z3GwvaL2uCAn3ezznvuuUU=
Received: from vall.thefacebook.com (2620:10d:c090:180::1:e8b3) by
 MWHPR15MB1229.namprd15.prod.outlook.com (2603:10b6:320:23::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Wed, 5 Sep 2018 01:12:28 +0000
From:   <jgkamat@fb.com>
To:     <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <jaygkamat@gmail.com>,
        <jgkamat@fb.com>
Subject: [PATCH 1/2] Fix cg_read_strcmp()
Date:   Tue, 4 Sep 2018 18:08:26 -0700
Message-ID: <20180905010827.27743-2-jgkamat@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905010827.27743-1-jgkamat@fb.com>
References: <20180905010827.27743-1-jgkamat@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:180::1:e8b3]
X-ClientProxiedBy: DM5PR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:3:93::21) To MWHPR15MB1229.namprd15.prod.outlook.com
 (2603:10b6:320:23::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31b951bc-84f0-4a02-a868-08d612cca6c0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1229;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1229;3:zP8IucEMqCtXXmq838NKOwiktMFMIs35sglqs98N5/tVLdHAV3PDhWLYAEvxtuR7T0xeZ0mWKzzZw1uOYGRNUeolafGQzvjo4VKjjuYAd4UsE3AnBDVZ5mORGLi53OleUrIJSdE6HLxB8B2ur9Eq7YT0F03cyhCyMHDIkccjKy4tkefI4oqbGUxjCPrbHY74/irgPRn9bjlHx+Qh5JIC6efuZjHiqgTokmU9eu857995hP0V/KN4uKys3NxoiBs2;25:NqXK8w+e0gh4sWIW8jwPGBW7EtoYez4apF5qyxtT0EZEHuiCuiPppB2VEBeCKnQ4PCg77TN+cOPNH9lRzQWXrAvCZqlcRM8bETwECSMcD0P3X0Niz/EojgDldGbADF4N/3EzGChBDOaRewpJ8EvlEcQ5qXTfV+XblctmxQx/83TkcRYuyKBnfsq2OE4v3TT+0c+1M/uzAxSJJxFzD9vwUCTLycrqxwyJ7BOElpy8CfLpniVG00xztgc3LL/KUNYwcVU1o/7p6ViadVEjIERVtXO7BvcRav85AhdgPsJwDF5LCEtiaseSYAdJC8jkRW5ZnXXrPuo19IOR2XnMV+v35w==;31:qjrZa01+yWv1DfDTloYqIRL9rKUwy6bWQ4sbTMUqRfsK1A9uinT/JVh42EyQ2lOMX1Mr36d6GETqpyhWgHmZRx+xubnJ2WYfYjhypJJ7mMf0PpPlBCAhEIYjZil590FBy1OrB1ZaYV5YK96llsMuKxAB76PcridZfUAhmcZrjG/Zv2dlbICbj3VPiCeEp8lfFUvIG0XDZIB0Ihi2m50RXEdrBFw7I4eyDlPGBtUAzvM=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1229:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1229;20:3nBYjMtjqnUyPbGoGjVOtuy+J+5SwjkZs29wS6kMX8W63J7vDmKZfmAdmxpIcIVOHCC09UiJfzxFB9aoyHQt3Tdj+a+mN2Ee/NiCs9oTEIYD5owBd2OgPADXnJOo6LDT4drDlTyIM50F30dnbZCoaaHzG0FGPKsuBS1JgWYxCOsp8KrZwiPwFu4VKN5pZd/iZiAEDnupfSTwnBLOOxfBinRwXDJPgGEc/kusOMiVSH2A5SDeJfjOuPk4FT4BNL6KRKa90bkf0v6IoHY64GzpkWltvcG7C8yGbdKS2uJKvOyH/ujb1okcuktBOqOTm2pTLe9e+pHqD1qNG+e2XsbbFaOQw3yEwiVYDSa3K1b6ExjSNmm5CPRedqtS9sSiQRQEm0ETKA8Q97BreAWyuu3M1cHMQ8lj5osXuCyhq0AKsqqevvA6Ts3+UTqhhNUbnWmAixmLKVXO/baArdScrTFYsXwXde/5td2D9u8ufTqat0fFhU1eMnV+hWqHUM/QlGpY;4:9A7VN5z01ImQgMkdPFgCX4O+9eRWg/atQIA2wIZWVo+I4BwLJ4jD3RdJ+RZfSCg478/TATapucNTNnKhlKY90/iG7hNxuHKcsGDMVmvWOgHtwJsHi3d/cnNzT+h7f7qPatblYQJXvlyz7TeOkRstq1c8bn7wTs/KXSggkHcg/1d9ru5/fft+oUQ3qo9u8ZYWxX/ztPQvKprRS/fTrR85mjPwvVz3iwtbfqpU9FNioP3XY/GVG5O6tM5IBnPBXSwO7ZYIrlkp4UVWWTKjdHQsQaYGs3ZCcfDSlDqmpL1JGz9IpBNipHJ2Pe7zDI4bMw1m
X-Microsoft-Antispam-PRVS: <MWHPR15MB12297BE04A3540A6888D5010CE020@MWHPR15MB1229.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:MWHPR15MB1229;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1229;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(33896004)(6916009)(86362001)(8936002)(25786009)(54906003)(16586007)(316002)(6506007)(386003)(5660300001)(69596002)(53936002)(85782001)(53416004)(50226002)(68736007)(81156014)(6512007)(81166006)(16526019)(48376002)(46003)(36756003)(47776003)(9686003)(186003)(446003)(97736004)(76176011)(105586002)(8676002)(4326008)(51416003)(39060400002)(1076002)(106356001)(476003)(2906002)(478600001)(52116002)(6486002)(305945005)(7736002)(11346002)(2616005)(2351001)(52396003)(486006)(2361001)(50466002)(6116002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1229;H:vall.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1229;23:GqNTAIZEgXUqxtI7LsYERdbaMi8MTgpNyyjSItbAx?=
 =?us-ascii?Q?AyLqHKtfMsoSpoTREaBD5qcGO//rWWXG4U8Zd8QH6Uxbr41/S/cyVeJOhnHW?=
 =?us-ascii?Q?CC8Yi+s2nW/OW33iKAIGV1HJu1nFyPjT4AxESlz1ITZNv6uEveffhrzvZVsA?=
 =?us-ascii?Q?57NmPyOluTScXtN/OUBdxfu/ejyenDAVdoI88hYBuyD/Xfm+8AaZadA5Jrai?=
 =?us-ascii?Q?DvbPF1S1RG8TGlRdDFggJ7w5So5DpiK7+3PWmiq9cJcje02JGeav+Mj+rJUZ?=
 =?us-ascii?Q?XN7J/Nsz3ln4gWptJiIB2o+AAeG6j48dJ26E8q0fISf9XbGVxRBYOTegb5F1?=
 =?us-ascii?Q?tN5rdEkDxbgWmFthedcR+pAORkCweFHSL08J3c6DyCYHfyfAisuuBMovKy/g?=
 =?us-ascii?Q?E5pMBCSGTKTfIn/3iUJFl1vYGzrKGH2+vAGygm3RrOJtgXu9Z7TvxrUo5NU3?=
 =?us-ascii?Q?p5WLg3zxdoP6zzl39NXccLL3i2O4i8s2X6thsvTw5G113KqbYi6S4UYU3/KV?=
 =?us-ascii?Q?Bbmw2JTv/2+z09iIIrYmdygHQuZpwNmDQs8jmKpJciqTRgrYweqDzOmb0ykw?=
 =?us-ascii?Q?I644IAj/CwhkxwmhhoeOfmlWikh9AXPVpj84rjrNMn9NipdqQDBqxm1J+R0W?=
 =?us-ascii?Q?E/zaKM003mUXosB11ZDwDbUuNRSB7z9AIbqwX+vjbCtGsOy+Y7k4e5R8i4De?=
 =?us-ascii?Q?HO71tY+PntE7YeghrR5qBqpf1dqaYaNwqH2QCHfKJsyUM344mQNO28GWg0lB?=
 =?us-ascii?Q?JDeVwvFJVGag11pTNKA0O1QDzikP0aX/lBt4JKQ2juKKYvP2tNZ3puQYnYlZ?=
 =?us-ascii?Q?uG7O9EmKNdmvN471w+OzZaWbxBVRe8LqnN8lv80DvcdAWpZQZW/e+zpbSuss?=
 =?us-ascii?Q?H5FWrUqwFSXYKA+N+EfKMbCges4jD4g7pIUiyTxjMw/td0J0EYx7HWRp1kUH?=
 =?us-ascii?Q?DZMH3KhdkL8g9MqduWY1Np/vrDIE42qzrXaz3A+cXDuY/IeAyiE+7JJ/ycl+?=
 =?us-ascii?Q?EkM2lO38blUvuDPreBh71uevJAVphNkPGT/tqjbBq22FsYdnBPTG7S2LTFIA?=
 =?us-ascii?Q?FtOZzFVwB8RmRJzlmz3M0OJv3byJmq1oEwdpFHQRRNo84onuJFcXHnqjR2Qy?=
 =?us-ascii?Q?5JIoiXRh6GrztjfKBqLpnmzCkIMdc1wLOxfJW7p8341cV1XzQofm+iwc0xOL?=
 =?us-ascii?Q?dEnsfnpCDTzAT33maFJLOMpXoUoGGJ/DR9uKfiQz6pWlOA0b+tbA94DcSy6r?=
 =?us-ascii?Q?9kXy81gEEW31xi1AcW/YFPkRN6JUQt4AZsKCWHoI0aD8QCRs/PaaVJFDjBJR?=
 =?us-ascii?Q?M4iqZ8GifqbahcqokY/JXYUieiR58LVE0UJT8C1V+6W?=
X-Microsoft-Antispam-Message-Info: ts4j4+95380+6JZY8/wMFd+XpnD+mrf92by3bN23jtwOJ5oK75Vv4OM5IMlKG2iiXGEOjpzeuLyvLZbKIpvqiNEert4jlqnHytSoTuF5dHV49nxNEd5l7muZpg9E/hEqCXGTa5SymG+fUpJKhte+j85t3WZOZ00q6K+Dpw3hSacqPLYrieSeE5ECvhMGdzbTk78NWM/NksIhdwr/vikMI4aPrLqjk00h4XtmNtOKnwKwv7cV61QMYnreMAiWnaRwejgHqRV/0fdLeBQGMB3WciGRguxKulHWXTvDr7PtV0NWCoEH5W1n9+F00pS+wVDGiB1bJJkwIWed570owN5Ou8qd+ogSthnTNJzCjBB+Mfw=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1229;6:1gaTp6yeB2p/SZR+Tg/ahaoNiSu60hPVCIxyI6S1BVIyys0GD6P/X2c2+mk6S0syNeK6ctKRkYz7d3DWWIEv8yU5zDsUEqKmL0bYIhmMmbqgciFCmTW5WWn4ReR7sXQNI/PnFva9XHTigTnuWYvLlbkXvPnWdAB3YFc6+jyWr3UJ7sHYgnl/GbVAisKnhXkPcroJ1m5ULmAnx2EIWah4K86LEQ3TRSXs0+zq7D6yYdGDd7Nb3SXB0vO3LYZH3OS7pXMSuwCobG1B0so235odnondlyGlg0+rmfspuhTEyCNmMjT9Fn8a+fwh46/+v5wGBQIQfznPIXAWOOGqgC5dBKj1stPM3DfyMyd4Lc5ywcqxGRxJQlmdCCeTHHePmBYROgGivjhQIEgIn4x1Fp7/CqVm0Ja6UGI5iODWVbz9sMZpzRYQj7Pri/NPHh0S1L6KsYj67L4sV9zVmgnAZeTleA==;5:gHmp9oDJe6wt/H0djVZ7cBWTv2pBjlQX1wwjlE8R1VzEHIIxgJWWEDoJl6l+mqELSy/GyDxHLrFPkrAA4dlYY+bc+SnSrKWhjKYnifJeADfEMyfEsNwWk0hbFLZ0Gm2WgKdXua51ThiWA2QEQROQf0u5bGk44uAWFbk9pakapZE=;7:r+LWNRlN/dceHr7aI+u7v1jY7OD+QDmfUVRV/lRCFaO+wqzQv3lkbeUcCv6Z+wvUkxafpe3SuYeE4x04ktzVI2uHbiz92ovCmTiwlsRzoHiTpH2kzG5wiEYB45pgbu0GfKoi2ea1GCHcDUVZjcqHXhPV0Fdi2P1JEVOZrWbVW/x1tglpjAYxccXM2XVkoFUcRi08Crp4+JZxHew8sqEDKpvpJ5aZ6RnB5dhfodwdXXRIuuzzBcleC7VPRKEoAf7s
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1229;20:j6oIUemx2kiKmCPQK4jTWHupKxj85rRvlgu2VN+JqJSsUhHC+AD5Ndu0egGKqX8x16HvAaHEbGyW0NupdiQTwrPtYGiMJi9DB88uox49NQ/XSNdGjZZaHtysn2XavAlv/A+G0tp2khKnr3mDTtjqU4tU3S5Q/AMCqSTzvDkfIqs=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 01:12:28.2432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b951bc-84f0-4a02-a868-08d612cca6c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1229
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-04_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jay Kamat <jgkamat@fb.com>

Fix a couple issues with cg_read_strcmp(), to improve correctness of
cgroup tests
- Fix cg_read_strcmp() always returning 0 for empty "needle" strings
- Fix a memory leak in cg_read_strcmp()

Fixes: 84092dbcf901 ("selftests: cgroup: add memory controller self-tests")

Signed-off-by: Jay Kamat <jgkamat@fb.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 1e9e3c470561..4aadf38bcd5d 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -91,15 +91,24 @@ int cg_read_strcmp(const char *cgroup, const char *control,
 {
 	size_t size = strlen(expected) + 1;
 	char *buf;
+	int ret;
+
+	/* Handle the case of comparing against empty string */
+	if (size == 1)
+		size = 32;
 
 	buf = malloc(size);
 	if (!buf)
 		return -1;
 
-	if (cg_read(cgroup, control, buf, size))
+	if (cg_read(cgroup, control, buf, size)) {
+		free(buf);
 		return -1;
+	}
 
-	return strcmp(expected, buf);
+	ret = strcmp(expected, buf);
+	free(buf);
+	return ret;
 }
 
 int cg_read_strstr(const char *cgroup, const char *control, const char *needle)
-- 
2.17.1

