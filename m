Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D977C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F82F22449
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SWA5j+Hi";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NWaFg4ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F82F22449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934503AbeGFSbp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:31:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44246 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934312AbeGFSa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:30:58 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66ISmvB018333;
        Fri, 6 Jul 2018 11:30:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=b3r7SK8rLT6wbUHOCZixTk21LJsJUXAbyjkDeQkGge4=;
 b=SWA5j+Hiy4ncy0i+bY04w8g82TyiL9RsfkJi6TX8vg71kpsenUFkTeWbmZtjwPmOus/8
 SCGgtrKto/MGGUQSTEMXV5tDopE3+kSa7HdxI++IxkcZodL4j/+47UG7EpD/17GmW/vz
 4EhNSA3jahBcsg77XTlWWFGCBhQamvSC5R4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k2b8w8j3b-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 06 Jul 2018 11:30:37 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 6 Jul 2018 14:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3r7SK8rLT6wbUHOCZixTk21LJsJUXAbyjkDeQkGge4=;
 b=NWaFg4ceeFaUqtrC9E+KZ9COKrvpUWB4UuB5Z0/9LAA8VTn4J66frhl7Ug2MJ84WCLKPDvoEiLTik3/gRgbun4lpHY4k1KwF18NdMLrZzWy1AFpeye067+KGa7JHlfryqWfEdNyWSnBcP4toSgNo/mdF4Va2XoQq/jdtDxfqd6A=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:17d7) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Fri, 6 Jul
 2018 18:30:32 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Roman Gushchin <guro@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 bpf-next 3/3] bpftool: add bash completion for cgroup tree command
Date:   Fri, 6 Jul 2018 11:30:12 -0700
Message-ID: <20180706183012.6475-3-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180706183012.6475-1-guro@fb.com>
References: <20180706183012.6475-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:17d7]
X-ClientProxiedBy: MWHPR21CA0067.namprd21.prod.outlook.com
 (2603:10b6:300:db::29) To SN1PR15MB0176.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edacdf60-7b12-4d1a-8f7e-08d5e36e8f5d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:a/OrEfPWoJG12bw0W+Vn850d7tm/+9jmO9SzwEaEhWTVS/XU5Qez9rWtP6VBYwbFA1C7UjbE3XSCXdhdzMRjs8Kn6LZqaRrWdOqyT3rU9+4dXAqE+KT00o9VCxq8ah3/MQtwODvITKAYTQ2sEgfBWd9icaRr+RNth3HYwkS45YillCgnATJylLzSfjyQenwLEIHBQ0h+fp25gKwJquqEPgVuADr6rbDljXhBHyuumClQNpRdBRBUZcZob7NgoWxW;25:vd5qN6QFYf1fyaMjxu/+RTRAEWH0MBtwt1OJZAPKYCqSrIeM0rblPfN7fmjUACn2RikC57wjmA4cJP2fPzwdY/bQoxqJA11eEJkz2O2VOGxnk+/dqSqOi/pJ7rRcaOSDKPPRcrQWbOsWxGzT1YdyJZGkOtWH13+emCdeqpKQEOK+YwbrdKVch5DyjmwEOrekl9NHnRNvVG7TQX1CJ6nMhmTrv347lE1QiHziO/uO+rOz1u7DiHMIKOc6a0wUlXX7AyOwnNFI14n6aPzXWOQf9JH4yz1uu7kuTfCxUpFCIZzplG4iiBt9fCI+d3YCBMEuUQh/qTb/64d+TtBnoFBicA==;31:ySoW4dkW1uiiM+Qtqe/fSBEjmPl9YXrvBtfj2xUmcWfg0Zy8q/0PgwhtmRszuHlnHNnz1bGDgHJqy05liYoM9ELNPTl5jrnyTc6ecsdDuut3/WHAkaHWmRTi8L1L7It54c2fdEHFWQJnCZH2o8Lw+SUbYXag4x/TV5zjt8fwGMq8b7VapuP50k8zX2N4y41fYIRdFQtLvXosmYpDDYc7digMQ1D7ZXZXghqxFAl3VHQ=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:aCSMPjwQaGyK7+1AZGhCWK53gY7lJTQyOG5tqgfcUTxu7MPtfjHQNnIzqjaRgOHm00k5mHgWYAa3mqwwoQMoviyeAIav2LRBJqK+9UK9m41l16OEfKGccVp+utKPrdAojZ/mR/whLCCX38BiEbqboLi+4522zgxgA/itOrfC2V3ZBacCYS7TPBvnwjdCngw28lHjLwWfqD32dq9nRO2xdkPhfCL48nqdvshc3YYPO458zRNtd7vYUbGuW4FiOEk0jj/st036EuM7pZf/1rJrbXc7dq67OkRctGtzX0WKQSh+iUU2GADFpThRnRMfT0yjbdm9rwGPHX/9pHrZS0v71FZ/EBMZVAJq1OsCXPyu/CAMuEibMHSfG3jcF9CPoBCT4zBekRSOzTrNZopXHSUUG5E08sCrIoD9h8n8oQawvzSVDnJsDOi8d7mUFA/WzDM6Vib1cdCXu15tVQUnxZATmOx4LAILddkzN6rJPsGG8vrLBndVtYpWFGIusSnnm3Gp;4:8tvgBtjJ5D/gA4b+bh5PgtSiKStvSAv1hhZl6dLnLZUlpcJ5nIYIi+urImMcPNLdbtEshr0vg3wfdiWM6m9VzIuByNIY1ZnhGJHjOtNIiDNNwHKx2nnDL+JJ/WlJICKnhoAGzMfFmzc5/IkNou2T3Glgd1OuLEiSAIkds5K9L6UKDZLmM/Jhw2bOT35zVaqYmCEMzOUi0Dwz+i/pKJ5EVidGj0Ym3qjUca+chue+L0PAKql23IykxqpbZE0bMHTevxFm5ATtEUmN6j0DG41Am6KYqQNdfQB99dcFWz/06P/ZYTF7b0dYXAs7yoD4TA7p
X-Microsoft-Antispam-PRVS: <SN1PR15MB017664C18C611D0DAE605F45BE470@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(476003)(53416004)(316002)(186003)(2361001)(2616005)(46003)(386003)(6506007)(8936002)(11346002)(5660300001)(16526019)(68736007)(1076002)(7736002)(81156014)(48376002)(69596002)(97736004)(8676002)(478600001)(50466002)(51416003)(486006)(52396003)(52116002)(446003)(81166006)(6916009)(2906002)(6116002)(106356001)(105586002)(6486002)(50226002)(47776003)(86362001)(76176011)(6666003)(2351001)(36756003)(54906003)(6512007)(16586007)(25786009)(4326008)(53936002)(5024004)(39060400002)(305945005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:2/vc1YRug+eQoOtPA7dGvbzjL/Cf9XeCGprYg4hil?=
 =?us-ascii?Q?5Fd4dqqUna9wAQbY5810X5KeiuzSWzQUUGCI9dxEIWtuECjVacenOi5KEX1S?=
 =?us-ascii?Q?lnVcTNqy1nmbHugx1zHsM/mm4jNT61D3AWWAqU8tz6vN1HRlZUy/e7OAWYSo?=
 =?us-ascii?Q?yninwZV1udXkzp4fAIB8Ib6/JtMUs/YFIQ36fh6J3faE92uCpHtQmt32jJWP?=
 =?us-ascii?Q?aAUheGMMpvNslkt/K2xGqxlxMp/CGFekew/W5AjhAxQ9VEyoCX0gmF0tiGKu?=
 =?us-ascii?Q?EzxbbO9E+enL2U4H4FhyonF43YS87TjI+WXBbUEZhfiE5SZf6tAWjZMrIpxg?=
 =?us-ascii?Q?mLpU5hZM10opK+okh0KPzUMjh0Rd2MT3xGUT8Q37qxEgbledqNpv7AgeXrML?=
 =?us-ascii?Q?s6Qq0q0SbY02rWWBKRG8NygVAzCVjwrAvGyLyg+0KKxo0gA0Wl1OI2xBMBnG?=
 =?us-ascii?Q?WkVzAMKWPZc6vcYbI03+aV8uglC5DnSyoZWThywfWqHsV8rxBqEczvtm1hbj?=
 =?us-ascii?Q?yCOU4TfykpscZOSxv9qGPdxZmlexTXOJV8bwcs2WlN89U9uFxwpIHr4spVec?=
 =?us-ascii?Q?jrZg/aKW73I28Ntk+vIR/cBFuuhFJ9DwlKw7Fj3lQs6pUavcygLc7YPvlcFP?=
 =?us-ascii?Q?Fj7Nnb0M3eoeI9VRukQvi9Yzf4gdhkPr8a4x7bAEK8tRUcGSttkiDqp5krKt?=
 =?us-ascii?Q?jnfl33uv/FA1dVJqTsMBhePSRjslisg2DTGzf36Ckis2iWb3al5RC4q6aTOM?=
 =?us-ascii?Q?tMYoYwP7SQ+A5W4q+78pcGLu9oJlL2QIXxCcMDrPRbQdp7J5eUCcF5l0sY11?=
 =?us-ascii?Q?4D25vh67q10Ea0xuvFel5/XV70TKj9AoBJyuBQno5BTVAmF63Kr5gJ/YNPGM?=
 =?us-ascii?Q?uI0ZQXHM1/WaQlcF8B81kk/I/3zrez+OlF1GuduC/lqHHZcw2ffgGNabmotb?=
 =?us-ascii?Q?YJJrCHczV60P5+QWO5P23EHbl8j73NBd+1Qk2ZBvRjf5ajwM6T0rbXOH+T6j?=
 =?us-ascii?Q?LQyEKL9Iz75zQiNohzTzennfYO94Qcr3zSZrCYCy43D6WmZtb3sdiAVOwHaK?=
 =?us-ascii?Q?hwDAsg66o4p2JyrMp9XGZGHt/QiCQMxDfzS9ugwQbT9nQR4G+5CoXKGUknn7?=
 =?us-ascii?Q?XDvzkjFHERJvPDyw4/1KoZJuSVYSPi+QQ0n8WyXk7jZTZe+twzidPHrayugC?=
 =?us-ascii?Q?t5V7qOjLLdLtyic4PyKgXuSy/awe/zvkmG+dLCAelfabBKrYGR44PfusgFZh?=
 =?us-ascii?Q?EiRFBC5D1WYyhDWyIdSlrphDlQTe1MRS1y0mj4KBNmJEHLS+o19AIcFcH7wO?=
 =?us-ascii?Q?dLNjhfNN7dRvXAeK6T19dE=3D?=
X-Microsoft-Antispam-Message-Info: NkDVZBdN1nc0pgKkLM7ePmCnAzZc9IsrKBRgzPDRNU6PQXzJiqTOoID/pnvn+C6r3Oi6tS1QYeRdJZihsZW+x9GIuOqmbqPOy0T43nE0v6OiOE9IFbMGVcXrTVRdSDneIgCx40Y3uKTdB8hYdEW83rrMDhmH0NcK4poPvJUzCr+tXv4AnDxWoeV3FEHO/C9dT/S8F7908pX0MCRaOMLN0qqCvfAM3WhYr2l0G8om5j3iPjso1Im2uWJaqnWkolXzF0meEg8gEDFZFc923JE0e1XuVrJPibjqQefycVQ4UGEnuR4AepSTcsTSfY57JbLzTHCYl696cfuzCBbzL+QpWYlOGTcq+FalfsGhsLe8c2k=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:dmAY5XcbV0MCnCEVacDSPwVy7lrLl+FZoBhaYFSNRTnDL6e5CU1B7BLpipAHhUnzTVMLIJzI+2mzQIha2O32CUNn3QDC3d68I8vkLzs+YIcm1xMYax+AbvoCIwHH0uMfP38GlwbQMMgYmCEXxgPhAnWhwIjDTicITDdrS5XSdd7tN+Pj0/n3ceQyALdBZ1q6XJiHoNatiHECB7ebwilS4Uf3dx7duOjmhVNe0U8dXn/rbuRgA5D7FQBRjB9X5Ta3P4q/km2m9GmWT5YLWVfGn6QK47tji6EI94k3UGGUSeyYFJuzKNkfIDC4f8rzk359IO6FLZVprVJXKp/IE4uUWjDZiP/IfVlgMgEpw7CaLvII6fBRE7txHeQNuR7BiCpAU4wpq9NWiFoBVm8QTSg13k0kK3LNd2MoTUin7YB5v1FyvPqfJrhS7nqq61EMAH3rvhuH2Wla+bGbbDq8ZXmxLg==;5:WUdvp5Eoz0HoWIhFDEmIaSQ5xW4gNnjZRl50Mv3XDQyIdyQLSGEQbhTkNr6EnshVq7aPyutnKx/u6lQfDOgGFNQUAIky4Iqt6gfjJhQYLd63ASZ4uVkuP1uopIFmad/9byoySr9IB9o87Q+lHkbkMaVWN08RksH/4nYlpqSxoAs=;24:PvTPV3kU/T+oFnscf1GPlqBn37EXGSlxW+oKJW81IqP0NS0OUmWz5Etz7j1g8kjvunBaA3yXNyKqW4Ihrqbbd+34NxtOzxww4Bxp4xNyD0I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;7:NhGVpCOi+lxxMXN6tLWdLMqQ9whnCni10tESjetot7FAf6WBTFQJGhJGuiGX+tuzTqGzjZVPtBgZ2CG9swmFvX9vM653MBxigRIpAxYI6dZ9lM3/WdQQcZIR9MagbpjIhK4CHLNIQlqww3z/Fc4oiIXjvf22wWz9It7jqtpb0LjUjpVtWlDiBrMmh1NCDiRrZInj35o4wLkFD/4mAsOCnwGpJ9uA7ewhcYzKuXiwSkKnv9Px21WitpU4AIfKvMPa;20:aTecOvFQjbmMQqgGtz5KAdta2bdsp1ya4/M6k5F/g10m5KApg8OE5IHZNLQseSpYdarmrmXAjxAYlDTnoNMLdocWduLzD/pOVjMu9agSMihMuWTQdvYodAxrWcioGP5LAHquBRmRYisbZl8vXQE2iXhftZodkTD0JUxmQ0APLOY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 18:30:32.3795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edacdf60-7b12-4d1a-8f7e-08d5e36e8f5d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0176
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a bash completion to the bpftool cgroup tree
command.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/bash-completion/bpftool | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index fffd76f4998b..82681eb9c02a 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -414,6 +414,9 @@ _bpftool()
                     _filedir
                     return 0
                     ;;
+		tree)
+		    _filedir
+		    return 0
                 attach|detach)
                     local ATTACH_TYPES='ingress egress sock_create sock_ops \
                         device bind4 bind6 post_bind4 post_bind6 connect4 \
-- 
2.14.4

