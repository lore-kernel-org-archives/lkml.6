Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C89ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AF12087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qrPFMVsI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IcgAde+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AF12087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbeGMT6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:58:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39668 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731931AbeGMT6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:58:01 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DJcpc5013895;
        Fri, 13 Jul 2018 12:41:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=4Lsi5GAdZP1wE3Hjf8KgvldXn+ptljenMCFMwiFsQLg=;
 b=qrPFMVsIbv4TRzxyte9oCM4CvnAGkV+QLpPRj6QSua+Ws4wSC5WH72ziPEDr5fOpPnlU
 89jy5j759+RhRijKfrsXHdf0HvazWEs7BQwK9dMFdqOjE1LCOi0G2HMP2Lp1AfI+nILW
 dr+9smgVDLWEBD05A1y7RUbYnjoPHJ98ImM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k7075rd26-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 13 Jul 2018 12:41:39 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 13 Jul 2018 12:41:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Lsi5GAdZP1wE3Hjf8KgvldXn+ptljenMCFMwiFsQLg=;
 b=IcgAde+IVffUcCUDoHGHB5M0TILeHDjR+LZhnC9823Z8tmf7WdEq8XAuyYP53+lV1y1AGr7I+F+t4q5YqOJif+f32fA7coNQpjOoadx8ayCLKlsh8dox2ky4sGlL/kCaKCc/fbPCAcKdmfin0zM33DkhPH9AUYm4ObD4/BpdC5g=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:1cec) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Fri, 13 Jul
 2018 19:41:31 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf 3/5] bpf: bpf_prog_array_free() should take a generic non-rcu pointer
Date:   Fri, 13 Jul 2018 12:41:12 -0700
Message-ID: <20180713194114.2711-3-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180713194114.2711-1-guro@fb.com>
References: <20180713194114.2711-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:1cec]
X-ClientProxiedBy: MWHPR14CA0063.namprd14.prod.outlook.com
 (2603:10b6:300:81::25) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d914f3c0-6c83-4bc6-73b1-08d5e8f8a290
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:ZcaHIGnt1fkQFWb+H5mO0FDoA93A3N1FC38VxsijcXE66f6SfgxCIdcjzZdZkvOMMeGklZCCkoWz43cHnaLTrMwOhRoSAEpJ0FrsD13AyeATmdUWY8N8JQd+gGPJ1Srk8ydbNzdQkgXJAva++thK071KYEL3+3LOOnrCWtscSAKqufWMuCmI61ubHuPGdQWE0qNlWVabx0mBvBuAxQM7yat3PKJcyY2LbmX0gPPu607i4GTTlJ/3VT988jYjuC4p;25:PTS6GXqpt2x1ChUFmM/c/uHnauT71AZ3XpA1iXBTD1yHGG6cg738iqOEkEa7qUjUIMZJ1+4Z+ODTkXzRkNCWim6QMy7wLt+wrJFbs2qJLq46poYNlcQ86m7IhUx1bO9sHfCX+VPRRMRSGdytVxEQy5SnGGL4uyG6jvIQJfhptTGDwn+Xr64GMmmWs1LHpCHV3QWJWnx0YkkwiXZyN71EM8iE4vaxIqLOYA+cK99ck1kZy5nJFr7fkZN7KWuSW3APZP6lEfRM5antIKQDuowH+hMT679ulZPNti/Db2GkPdpugiTaH6RIb9JNOzr81EQgO8ltvA/qvWjIPuoIAuu+Jw==;31:iS4Z6os6RqODwdGcNwwB3lB/aykcmz7HBbPeK7EPkCf3E2szoOMVK7aLv1anB0tjJvhgYQ04CZP9/r7FzVT5IsWM7tFSBPRGHcjx1/eemrvFnn52BfL0cxWdQKKYKBPzDKtPyi147b99amgsMyVGUhPZ/F6bpd+MjIhsltGNXIojla17nGI1dtCiUWPsN7BbxDaZA+O0vgFrSyotj+4Xo8vdoP/UMMM3YXh5A5b4LQQ=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:0JWWa+kzedfBHUoV5HfbnvJ2RpbobP4BXx6/ufvFK3zFh148fdCKvA4AD490Kjj24K9loRcXvvBraalBkRiNM2Yn+HwDxw6FhI0WmBZp7hZy4LEmY+f1vcSOQ7NraDOngFOwPCirBu5fKmqqzcyI3GQpsM6RpeumRtHVzm3ebc1pxJOlEIPqf0Z+iwOjl3kEd85KaFKhbvKP0K9w/SzCcDhxtzMNTDmj1pTtiytwKKCzKHNQkGHTEk/6WvkIJ3DMZSzux9xBcmbI0wegg3WkmdY+6ZxQNZcvdMNKe4kIqnTaIEjTy/RiF92TaGqrMarejiHpOaBAAQB/IYYWv4bVUjCuwO3VZhkPaFN+2KHCLTvlEinApQVkE3yzRULmjT16r7xCq7iqalVfK4yrVk6KBRHwqqD4h2FzBjdkIYxjPB5WmW/PEl1/q//JR5qI12EwsoYUqAutJsQTFkKxQP8/Ri6jZ2FIsdo/zUieRW82hWSGlkXUalU2csuHuYzollRb;4:L6P3DDghEafA5IzBQxR7QIUrnU8SRUpm0NI2s7pwwPnoFhuRsCgLiBS3CvAf5jhCS+Pgx97gJ32+WEQSeiXaqYgrVgeW2C8p1E0PIE3Y0Re82pfDCPLVIRbVMeKk8LJXPp7wo5IklzWpTCXowANyW6eHE7ew7U5mNNZb6ccaZyHFbQfN7sWekvk9CtiT3vlWRxMHnEk7o0iQeHohVVSdfchKs8oPOupex9yxqreU4a+XRiyC5zY1zdaFwF6SPzkjHfqwZy4O2zLxT2jbAQsrlHPEMVuX+Z4CtYtgf26pvrAt/6RpEx/lCl2gmAELvuR0
X-Microsoft-Antispam-PRVS: <CY1PR15MB0171F95FAB03223980913214BE580@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(53416004)(52116002)(16526019)(6506007)(6916009)(14444005)(50466002)(48376002)(386003)(6666003)(1076002)(8676002)(46003)(186003)(86362001)(6116002)(575784001)(5660300001)(69596002)(8936002)(47776003)(6486002)(305945005)(2351001)(7736002)(478600001)(2361001)(81166006)(81156014)(105586002)(50226002)(76176011)(68736007)(106356001)(11346002)(54906003)(51416003)(476003)(52396003)(446003)(5024004)(2616005)(25786009)(16586007)(316002)(36756003)(4326008)(2906002)(97736004)(6512007)(486006)(53936002)(41533002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:SwbGH7y7vs2rEK9I2/ujuTuI9b7LRb8Zo1U7n7xoZ?=
 =?us-ascii?Q?RZI5GF0gLeTrjF53zxry8TxLuP/pNwUC99lXtyh3aq3+1nWJfNY4hwDQC74H?=
 =?us-ascii?Q?5qFabLGf5QGff28HPtBnlXZjQKIOHYfzGvhrn5/itTGpPQ/q8gNTxJa3e1pi?=
 =?us-ascii?Q?xlh+CkHKuPiHkskvst2duNUJR0E4U77nVDnmVYinuhsfL+KDQBUG8Yu34yhK?=
 =?us-ascii?Q?jEiw/GU2CPWibTLyVrj8NqLqLoKiXpdnwIgwvaEb3Axdx/6XqUtC4gOF84Ob?=
 =?us-ascii?Q?PtupGYBLKZ1xnZcYHOUjbSvnuGlvQ3jvQBhXWbUkLbA0GqnQ7dkNJtycvw6Z?=
 =?us-ascii?Q?Pozon8DPKIbB01d1LZfpGd65ldvnmppj/ARhlmI4QI9xR4ZhGsEVU/g9v4P7?=
 =?us-ascii?Q?HKg1A15XVa4BEaOPLuUhaSXJELk+cMAB3XT6+Zd5Z25yQqcmGWi54nNJj1XQ?=
 =?us-ascii?Q?XI5AHekOnYMoaazE0PSpZ+G5jNX8okWkNSKx58rWju4Gu+Puq3LPEiQSN3Rj?=
 =?us-ascii?Q?4ARb8IuanowdK1imlO5EFH8aCMkTbs2ROhGp0TISdaTub+PXz1IxDrpykAXA?=
 =?us-ascii?Q?CFeSrxey7U9/zULNoYZYagZo8MeXmzMOwbHQERcgwRR/J6jR4vRF6xqP+mHS?=
 =?us-ascii?Q?oayyEPvjq/W+kz+qS8OSNS0YkPkwnM6qXF1eaGhBuWT+ZUHENJrR5kBPllcH?=
 =?us-ascii?Q?8fjwRQ0VkEOkodX1bYLtE0pzZ6grgA3mSa+7TH4b5iitxBXMXQn4CEogTN3c?=
 =?us-ascii?Q?XX/0LnAvDEKmw5TXbqqGdFi/magC6ox8mi+fSsO2oMyXI2M2O6LTeBRkDrj7?=
 =?us-ascii?Q?eHY1eGlVE14B20i9fM9srzYMXujyUChHncCqa/GzfsFvHEMgh2m+LTa2X9K1?=
 =?us-ascii?Q?buNzcaJlFnjPmTbLVfHBU/NWESJDR4s8n19OhaRa3ccRxXMS/OIliIxwC/QX?=
 =?us-ascii?Q?kk7EjFlD4jRy9QHCDLqIkTqjrRbnhR/oTahdYMufRDD6yG7zblx8e0sBQ9Kc?=
 =?us-ascii?Q?3ZBU5J3+la7Lo2DYQcw1msirxd21AblqNZxh4uoRK6j1fXgKcWjvGKDDxhH5?=
 =?us-ascii?Q?KNB92NG4/0KZQfnvHzPUF73Ug8anrcdrmyaQPfTdQypf0v2Grpox1hAsfzUJ?=
 =?us-ascii?Q?NFzqEz1O823UYyclVvwspu3nXculhuagsnk1bvnWzrlc+W/JNGoe6i6E9F/O?=
 =?us-ascii?Q?rKfHiLSwLjfvQ3bCM5gjtPmxfrRLh60yhdMz1xJ02zueTGCprdlnV3vqmxrh?=
 =?us-ascii?Q?WaCLOpKY3FpzjPARoJfuLcNUECq12fwTmLuIfoaD4KkL5kKTQF38SM0XzAQJ?=
 =?us-ascii?Q?IQZ5JxgkU+SsyGgSqyg4njEfJxz57l51UDTBS23lEClWpxJuTpM+iW0OW3mz?=
 =?us-ascii?Q?XcGaA=3D=3D?=
X-Microsoft-Antispam-Message-Info: t9CF206BoM6MVUgUun8WuhcBFMxZ4qqOR5Ujevawb7qHF+VuJlsKNYH2e/0cgrk/xog+qRz8pdSyCmxHHe21vXN5e7x19PEJzFvODDZ1z1UHLXPiMKcgj0jRfiyyRiCVTtT7+l9riFtINd2pCDpJNLZXSL3BT2CwhprlZr5RssRCTDKrPa6IZO7G1vM2O8i+wUn979tgTbKDdtrJ/jo6ddwF8SJBO0ubo/+JYsQYRjjvq3y8xuTEWOxGmEpkFah3AhX1CrkhliT0xUuf2JPkq4W475FfHtjuDpObWbA9dSfEWAmVcJr8aP06XbjvHnWrTe/RmQOoO2BHNu6dNL7YKiVU/q0zcRsR+MzQPZc2xig=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:w+xb2jOqyk0yPiMvwKtizCYzYvqGAkuovXNKxws2ibsNadrgDVra5kBDCTKtJfkwU92WU+TabSeJdRTUxyo+S6pAd3LGgxu3N5RAF5fAFIlfPRmTB1ExVpV1bgnBho36f4HUHyKfg0cVPTYEhaPc1h4s/i+mfh8I+9WMmgiaggvJezjNF0owutmTEEi+u1aB7Hts+lWoi709oY8SV3Ws2hgKGDOjHG6Ls4rdLVCTo1LTH4pAPXgTPl1fRlAEmA43KzeKh8hhJ5eC/HslQzy6oiuetuIBYO1fOYqu+sbxeTIHpfJJKWWtd43CiKQOGfCSohJpL0gRmcUxXgyLEFarJSEuZn8PhnKlvUp862jORV9bxhRYeMZ+GiIhqngeHfwSsRFKeV5qQc/G0QwP/eT/yAu4y8DdyHf83d6GIq9sKENafk6746G4RMCHmxChEGq6+2b7KMRFUJ/sCvZdpQ8jPg==;5:L3UE4VqUEmsQP4eKu16iRRfuJcUCswB70gxpb4CVLRugpzQjaXAnvziI8UNf++st4L4NWDxT7ie4qYRSrAvw86nmBssnvWzMmg6v85zWFPgCbT11J6fPYaLbFv7pgHYgCAUgJYoEgWS5QVXEUVFUWpEZ4i0ihl216elzwFsCTS4=;24:Lqo/xCEA91yqGCaFb3heWCx/f2rJgzSKQGE/P/fM8RUt3IFupbdaYtZ/8TESsaDqaCkJmVTVOBir4hGfk+gwHBoRMN7wIsxlJNyFCIwKzLo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;7:pHOljm16bJfNCkvpjufgzG2/7bKRDBN9TTq69Lt36aF2hmA5eLi/WUcE0gr1vOUo/om0AkJx+CvvhIaImdqKgODvJ0+vg2NQRB7JRhvppUzM3fOeO/K1FqAb9gyvGuqbJlWJi5JKXSA2/ksRNr4MIQYQU44oumKQ8h01m7G9F1WU2HKt8Vb4rPZruGYtIF/LjUngWsUcVj5DqbyDWHv0opQQYs5RDFpfhll7T1B1r6YtCZSm0VryRh8Vc7pfsA1T;20:RP01THOdlBlE3JIO+m0VtzWRq4AXOZF2Y+vc1H1JkZ+mkpNb2GLy5VRR1GuLau3MAPieaOwV5xc0H4QCyg8xwWSTrqYO+U8ii8TeJFcHoQpioxCuh1cGCE82ihKUbhI3tnEvDyRiM4Mxcwq9lij41YAoMly956BlFq1MS60n6BM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 19:41:31.2396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d914f3c0-6c83-4bc6-73b1-08d5e8f8a290
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bpf_prog_array_free() should take a generic non-rcu pointer
as an argument, as freeing the objects assumes that we're
holding an exclusive rights on it.

rcu_access_pointer() can be used to convert a __rcu pointer to
a generic pointer before passing it to bpf_prog_array_free(),
if necessary.

This patch eliminates the following sparse warning:
kernel/bpf/core.c:1556:9: warning: incorrect type in argument 1 (different address spaces)
kernel/bpf/core.c:1556:9:    expected struct callback_head *head
kernel/bpf/core.c:1556:9:    got struct callback_head [noderef] <asn:4>*<noident>

Fixes: 324bda9e6c5a ("bpf: multi program support for cgroup+bpf")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 drivers/media/rc/bpf-lirc.c |  6 +++---
 include/linux/bpf.h         |  2 +-
 kernel/bpf/cgroup.c         | 11 ++++++-----
 kernel/bpf/core.c           |  5 ++---
 kernel/trace/bpf_trace.c    |  8 ++++----
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index fcfab6635f9c..509b262aa0dc 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -135,7 +135,7 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
 		goto unlock;
 
 	rcu_assign_pointer(raw->progs, new_array);
-	bpf_prog_array_free(old_array);
+	bpf_prog_array_free(rcu_access_pointer(old_array));
 
 unlock:
 	mutex_unlock(&ir_raw_handler_lock);
@@ -173,7 +173,7 @@ static int lirc_bpf_detach(struct rc_dev *rcdev, struct bpf_prog *prog)
 		goto unlock;
 
 	rcu_assign_pointer(raw->progs, new_array);
-	bpf_prog_array_free(old_array);
+	bpf_prog_array_free(rcu_access_pointer(old_array));
 unlock:
 	mutex_unlock(&ir_raw_handler_lock);
 	return ret;
@@ -204,7 +204,7 @@ void lirc_bpf_free(struct rc_dev *rcdev)
 	while (*progs)
 		bpf_prog_put(*progs++);
 
-	bpf_prog_array_free(rcdev->raw->progs);
+	bpf_prog_array_free(rcu_access_pointer(rcdev->raw->progs));
 }
 
 int lirc_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 943fb08d8287..329026baef6e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -353,7 +353,7 @@ struct bpf_prog_array {
 };
 
 struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
-void bpf_prog_array_free(struct bpf_prog_array __rcu *progs);
+void bpf_prog_array_free(struct bpf_prog_array *progs);
 int bpf_prog_array_length(struct bpf_prog_array __rcu *progs);
 int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
 				__u32 __user *prog_ids, u32 cnt);
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index badabb0b435c..9ac0c9b51d0d 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -37,7 +37,8 @@ void cgroup_bpf_put(struct cgroup *cgrp)
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key);
 		}
-		bpf_prog_array_free(cgrp->bpf.effective[type]);
+		bpf_prog_array_free(rcu_access_pointer(
+					    cgrp->bpf.effective[type]));
 	}
 }
 
@@ -139,7 +140,7 @@ static void activate_effective_progs(struct cgroup *cgrp,
 	/* free prog array after grace period, since __cgroup_bpf_run_*()
 	 * might be still walking the array
 	 */
-	bpf_prog_array_free(old_array);
+	bpf_prog_array_free(rcu_access_pointer(old_array));
 }
 
 /**
@@ -168,7 +169,7 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
 	return 0;
 cleanup:
 	for (i = 0; i < NR; i++)
-		bpf_prog_array_free(arrays[i]);
+		bpf_prog_array_free(rcu_access_pointer(arrays[i]));
 	return -ENOMEM;
 }
 
@@ -270,7 +271,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	css_for_each_descendant_pre(css, &cgrp->self) {
 		struct cgroup *desc = container_of(css, struct cgroup, self);
 
-		bpf_prog_array_free(desc->bpf.inactive);
+		bpf_prog_array_free(rcu_access_pointer(desc->bpf.inactive));
 		desc->bpf.inactive = NULL;
 	}
 
@@ -372,7 +373,7 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 	css_for_each_descendant_pre(css, &cgrp->self) {
 		struct cgroup *desc = container_of(css, struct cgroup, self);
 
-		bpf_prog_array_free(desc->bpf.inactive);
+		bpf_prog_array_free(rcu_access_pointer(desc->bpf.inactive));
 		desc->bpf.inactive = NULL;
 	}
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 253aa8e79c7b..fdf961f70deb 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1548,10 +1548,9 @@ struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
 	return &empty_prog_array.hdr;
 }
 
-void bpf_prog_array_free(struct bpf_prog_array __rcu *progs)
+void bpf_prog_array_free(struct bpf_prog_array *progs)
 {
-	if (!progs ||
-	    progs == (struct bpf_prog_array __rcu *)&empty_prog_array.hdr)
+	if (!progs || progs == &empty_prog_array.hdr)
 		return;
 	kfree_rcu(progs, rcu);
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0ae6829804bc..5dace25d3088 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -995,8 +995,8 @@ int perf_event_attach_bpf_prog(struct perf_event *event,
 
 	/* set the new array to event->tp_event and set event->prog */
 	event->prog = prog;
-	rcu_assign_pointer(event->tp_event->prog_array, new_array);
-	bpf_prog_array_free(old_array);
+	rcu_swap_protected(event->tp_event->prog_array, new_array, 1);
+	bpf_prog_array_free(new_array);
 
 unlock:
 	mutex_unlock(&bpf_event_mutex);
@@ -1021,8 +1021,8 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 	if (ret < 0) {
 		bpf_prog_array_delete_safe(old_array, event->prog);
 	} else {
-		rcu_assign_pointer(event->tp_event->prog_array, new_array);
-		bpf_prog_array_free(old_array);
+		rcu_swap_protected(event->tp_event->prog_array, new_array, 1);
+		bpf_prog_array_free(new_array);
 	}
 
 	bpf_prog_put(event->prog);
-- 
2.14.4

