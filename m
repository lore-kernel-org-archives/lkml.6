Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE8BECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DA1206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SGA7Eydg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ha2d5rT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DA1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbeGRQlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:41:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44934 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731241AbeGRQlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:41:16 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6IFx0bx028189;
        Wed, 18 Jul 2018 09:02:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=ivyiMGDAOisKROdjgC+uHHIosTQ5uL2UIz9JZJ/SiCI=;
 b=SGA7EydgTEn1/H3TBTpCc2E8OdEMH2wTB5R6QLohtIG75dSFZuqS0lVUKoyTywpH6aD/
 fBg0DGj00Jfqfxpm4/K+qRxetmv96qjsMllnSnkp3jFk7R1pUbxgOvzm6ZxnuVHVk8Uz
 ve/v4O86sApssPanb6FdCsM+Y6b9LDrf/ck= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ka75ugbdx-10
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 18 Jul 2018 09:02:18 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 18 Jul 2018 09:02:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivyiMGDAOisKROdjgC+uHHIosTQ5uL2UIz9JZJ/SiCI=;
 b=ha2d5rT623oSTvjFnxtO/QJ7HPhyk2ChiKojpvBrGyYXQkfNmtPmumL1B6QQPZrr1MKoAeWwPo3FLv2QBl9pR9AwP2w5nY0CdVeo/hLigb355BzFkUztfdmBn++uajJWzbbMRZCEMJd0lZl9y/cnES04SoCjO+oH9HxfEXJvJYY=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:180::1:a4c2) by
 CY1PR15MB0170.namprd15.prod.outlook.com (2a01:111:e400:58bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Wed, 18 Jul
 2018 16:01:37 +0000
Date:   Wed, 18 Jul 2018 09:01:31 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 bpf 3/5] bpf: bpf_prog_array_free() should take a
 generic non-rcu pointer
Message-ID: <20180718160128.GA10652@castle.DHCP.thefacebook.com>
References: <20180713194114.2711-1-guro@fb.com>
 <20180713194114.2711-3-guro@fb.com>
 <41b5f919-3155-5bd4-2774-84efd58650e2@iogearbox.net>
 <20180716225715.GB3898@castle.DHCP.thefacebook.com>
 <1a40b0a8-7440-f2d2-d743-64901b5d1bfe@iogearbox.net>
 <20180717225520.GA15643@castle.DHCP.thefacebook.com>
 <90bc1d99-da1b-065a-cd4f-457b7f17a533@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <90bc1d99-da1b-065a-cd4f-457b7f17a533@iogearbox.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:180::1:a4c2]
X-ClientProxiedBy: MWHPR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:301:3a::25) To CY1PR15MB0170.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8702130-f196-4aa6-15c1-08d5ecc7be77
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0170;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;3:wJwOqENw1A3mKQWueg11QkFajKd9ExLvJmTBFDi7AHObJ+MgyrvDNal7ZuTGnA9WHb0wBdTWf2ziL8xs0dwu1A/DxzmmRHzqNWflZk/KWldpaafsKrxCMWt9aSeduoBUODy8nbuZGA9jghdBjgABW9y0hA9db3xSml65yraQe6AqN6Hg6SpAertAjAvOg6ln6v1XizJFv0vqrWPolDtusXnS1RHMxvh+T1p8sBFGyZdn2B47mzVTi+E0nbz4Zo+k;25:iwP8Gm91MxvNCp5209LyiaPxz8OygV4gCcL57onpJ3NtkiVRtidsbAsrS6nDF61P0wj0gjBhDbgiWQwHi2nHeMMgShwZT3B7C+qcMDN72MZfDoYlvs+y+x8/73Yk3wqqahx7ukKPojmGkNxJJLpTHQCn7tDtIf7kcdbRIueyXWsm5OpYPUc0RNTpxGbWidSGNynfQnUXv8FK5of998WOoNn8Z2NW10nMc2aVRc0eVXJ34lS8YmcMiv0vU+v80fS/wapPDah78jdkvtURjnmZtMg72/XQrJ+4pHhFm0Q0DUET/No9ZKiRUNm++T9fZcsJ5hP0YX45+mNCP+hZQFDNWA==;31:99OU9XtaAQfcEhdyumKlH3KmU6O85LH8nVmf3iCouGbbJz2yTNs/S8i8YlsO4xnf4GP75RgbO1pvr+1rHr+BzQxdT94wvdBdjx0KmjyHul0iGYSEmN6IoEfo3F8K4lndOyy3VlJEhe73/+0LsgfJxzB7kCieeShg+1KDI8vKiw15yqlrrcnwD7Lsz82j5jqNY+pGdtIje6NsDOJeKd7RZ6hfN20e0U7agGFMAipyhiU=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0170:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:VOBqhAb2u3b7p0pl/TL+03plKXJs9VLnjI9Pr8mEqLy1VqNitUbUf9V+EGkfb4otBJ7T5FCAaLocmBS35zhc88OsQmrwDoTlv63n4J5LxB/Oej9ME9ZpJGp/ROgVC9w8hqU0JlBujJXhGtUMuZVK73IGJ4lvcr78Iw86fy2742qpTl0BKpZlZvG38EVWJalim79L4zs+sF0bD6Altf9C2F+HDQhSl9j7x84MtcZ4i4Ibzd4sBf+jni2hTdFmBT5xqVnY7iLgKYZLuQnwr9FXjmxB9A+yjW8OK6ZhNdZuMBakhSInvDYdlD8dGx5BTn1rvQj+Mi/y7JIU4HRh8zivLS7nf2w7XYmXqii6yQ3EYY3u55U0qMFA+UfIufQPxMqCm9RcwaUY3biwOQkuy1+jz0yIBFw89Fyn+ciZjkMJKV2qk+MLNql0Qwq9lPkJZTj3zqvlj+7lE3eBACNEDaeyqUJ3n1c+JVUncmCpAXkc1tZtQWsLiCokgGN4jlb4rNJo;4:OeCwVobaEXcHzbG/JtX8sM3dyfqyTBeavS3IiIefoqC15CuskmO0sRvqC20sAmjuYDJKMSkc9V+VFR3ndbbO91qHYiiG58mfefl6uh0Id/rYVTTGsxf22ZU1+3ovvOOLjJ2dWiIStPGTJvnw0ocqBSt05w7JnyW+8laCtPRzvyvQ8fkHdjy23lgzBjz+kvdDOQSgnSGbokyTQjcyruxFR8iltyTpLyyAClKq/LZQQNEY8g7kPCvJzn0/qW6Qb7BUwWCEyxbvRBQSt4wbpASTXcQB3RmyJP2H/Jr4+J0YY1APp2TsZY42eRQdGUlaqfiPXtkM0WVMzVE49KX8CuJdf8COmgDsAvgfjzL9L6joO64=
X-Microsoft-Antispam-PRVS: <CY1PR15MB0170ABDB810DE816BE40FC00BE530@CY1PR15MB0170.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0170;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0170;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(346002)(136003)(366004)(376002)(39860400002)(396003)(199004)(189003)(8936002)(229853002)(25786009)(81156014)(8676002)(23726003)(55016002)(4326008)(476003)(1076002)(575784001)(478600001)(81166006)(9686003)(6116002)(97736004)(6916009)(6246003)(446003)(53936002)(11346002)(68736007)(305945005)(6666003)(486006)(16526019)(52396003)(33656002)(93886005)(86362001)(7696005)(2906002)(386003)(46003)(53546011)(6506007)(186003)(52116002)(76176011)(16586007)(5660300001)(105586002)(316002)(7736002)(50466002)(47776003)(14444005)(5024004)(106356001)(58126008)(18370500001)(41533002)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0170;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0170;23:/OF57zeQpZDdzgR64dmHtkKVPanl7OHQsOkxXnAoS?=
 =?us-ascii?Q?lzkJy151SjmKdwW3UBhDpMS4DuV/f5jwsxRmvwCgn7V7Vgz7es6TT3y+Kl6d?=
 =?us-ascii?Q?ehWAO1IjkM5/zOfkw70WePkC9gphuYNoYwigDdh68Li67x728QsxLd2YsKI+?=
 =?us-ascii?Q?XhWjEwn3FDjP0OUB0Je2FATuq2yLR/IoY9pCtyoH3CCqud8moA7aHpsHMtRr?=
 =?us-ascii?Q?hHz6u9ugKkSnEWdSrYtM3Hm9AShm3Yq6gcEHWH9X+9HP4EYPxVO4VlfNe46z?=
 =?us-ascii?Q?eVAxu4fSYkO8TvdYWAsZ2wcYCrn9nN3LHOwl2To9nI1GuAU4cBHsb8tcj4Fn?=
 =?us-ascii?Q?M1GJk6Ca/Hse0yxpEt2nVkJZ/HXcsVbb9pyRMEjZeYCRJb31asRIeoyvQSB6?=
 =?us-ascii?Q?vklnaw0VGPT8EafIScAs5Avm5u2Rr3GX/z6Earmqq6D9v68GN8d/eJw7fOF+?=
 =?us-ascii?Q?HaHDzIFD38N9yjQ9sjuEERzu6Yejh854PZ9AcixonKV6UNJ75VeIxZCRxfQK?=
 =?us-ascii?Q?llpS8Bzi9RrK/n21WDoN+HJQgGTiaehwqv7QveBUBURbKF1/kmEXyJDITans?=
 =?us-ascii?Q?jFqZjEIkha/fL6CDrcEucQflzHRR1A1JFCa7gppO625idpOg3XredYJz20IM?=
 =?us-ascii?Q?RYfs58uMM5bFlFGhzPHxoA36U18dZKAb4FwsTvdGLrmsWSX2AtU6HHze869z?=
 =?us-ascii?Q?Og+xXXtU6w7hRoeD69ql0K+AcKZMS+11o9nZjb4zu+Pe+UZezTOWt9HfqgY0?=
 =?us-ascii?Q?XCzf6D2Ywg8UJAFRYLVVPE6FtDqgEDKV9ApyT7GMIV/c83bme8+zO1KH4RbK?=
 =?us-ascii?Q?eTU8Q/R8zsBWZ2UaDLbNwnOIca4zdD95ny1F3EsJXGG07U689z/zJRHkkZ6R?=
 =?us-ascii?Q?G6qbSVxXFoD0jyBaZ8/MARP4b5Hbgs55iXtBG4ZVBeNHbevKYmq8Qwy5ZS/K?=
 =?us-ascii?Q?7IOpEJV6NSXXsxPGmBnDMWoDJEB+E2MLsFFGEeMgoo07H6/9aIHFEF35YOVK?=
 =?us-ascii?Q?oR74jt75Eyo6/X7g7Oo8K37YLVcyTUzNy+MqPyMm0aJzLRmlFxFNTB+ljsId?=
 =?us-ascii?Q?RZEUrZQIqhwWw1QyUFcHYevKiTZZvyISw7MY546MdWInFGhRVJRjyZ48AoUK?=
 =?us-ascii?Q?/j+kTAqVe6piH/D0ag4Yn84fP0R+L+HEkLkZwu+vg5K47fOKv4ClGo1fShAp?=
 =?us-ascii?Q?KsprWpOopq0/bYd6VX/QaJnu1+ErCDrkTwRMcwJeyvHe7BsICSWKhkRWfCPb?=
 =?us-ascii?Q?8HFS4hQZaC9O3rE4iP4Xk0HfMNz20iNeXcBM+sp+M5oMxGApAVp3QWDa1TES?=
 =?us-ascii?Q?RjmIQBKvbXBrurIBwbsFTA8ReVmA7d+6v3SMw/tavhF8xXAaN2AjeyPrfChr?=
 =?us-ascii?Q?XRXfqC4mjuo/hjdMCOU6oz7UkPcsah36K7QCBah55SM5gA+4NMg5bIicUW0m?=
 =?us-ascii?Q?NhJ2Nxva4MwAjQ3b+omL0ettrpsvBU=3D?=
X-Microsoft-Antispam-Message-Info: HrPKvD05Hi3BrfemaWaP3MkDIg5dyklRr6U3fxRGNX7zfc7VOWPs9ytcRkzW1FXmaM0+FI6X7ZTQ7LWrCpDfNbE0MFtEH3hY8bZvko8en53007vJYpF3cvPI1yeIKHywH+JRXZ+GE7BFBrz+XgA3hDUGiW5jqo0lz0AfVMPmu3scqCINwi+Dh8wIuDeu6NBB/+e3GNlN2PL8gwGXMULzSYP4bvJxhTtbZ7XbaiOWsfj62VDl0nIWfCUYOkduvF3s5/sDwUNilEe4BjNsOizWGQ5if2PQOPwana1XYEF/26VCsh1Dy2DIpqGMDIN2EurfYfbMgA2OfUxnhUhvpRtnTxNTXZJQcV1tmJZRs2QgH1U=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;6:ybBewO7SvrAgnXMbfrCe4PFZjFW+SIYJtwB5Aa5bN8Uxl64prvm3IENjHex1Fd35MdieNN721iU/Q3+rP1gUxyVhlABlwBMOSQgWpMkdbq7wwiYui9m9GCRHopjwlQB+Gfphfru4a/nPp/Mr/3A3aMWI/x9/pZNkdW0QuKqUc7KaTYBLZK5x42Zo/J6BpFa5L6UzqQEIeBItghGfTk7I4CoZwQShypv7nCJiE9t20eFJCv/+WCspVy/GReRoUadH9QrHYQgb078byHf5H8iHGoxBaPVi5Ou0zJO/3jg2mG6v9QqetPuqZFn6VaUdRh2HZL/468Un9L2nQeEixjyLQzGzbpKp4cyiW9tpqSDlR4Pck/X+FDAJPhkFBvfZacTii5vSQSBujamOuzRGLRWTV/7SJSFVDJYsJgg6a/z76zi05uFJuJj/1bu+hekbZpODqlNj9A+zusm326VrBHLdNw==;5:jBI2vZcEh9f2D2D8Mk2Op3nVCrCr5PgzK7hyv13IMLJmw/kVyWcPeMwfinP8N3b1BBz8CfjKCqE+DClEPjhwM0VQ2WmwnXoJQ0bmPaBfp8SonQrMSsXnsCnzqQbddH4ckGStSPkRSSOcu81ENpza+1+51RD4E0SPLQ6vc/0b8RI=;24:S2ElCAsNDxnO/Cam54NRKb3AtvneqX1+fJ52hxA8tlT3pUnjksaFb3BAE5bbVURxiM8qWh7JpeI8K+1pKp5KhRp4jm4g7jiD+zC5P0/n2bA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;7:dUjwFr8E4QVUf91JL1hjiT0ALHKGy98A16V9wWzifXgY6AByIKg4fv8wtRRpU9u/tY4jIO9206CGk5e6UFBkBgQV7XI/th2ffqza7wTulenSLijAN+RJEl+hIPMgkuiwaCEE+TWpFOWwPBA2vOM4EnJgMZCcXdziXg8V6Iot4NArnn6ZYOZ6QVN2SC2qVSr+g6tbPBI6ZagFmu0nJHJwkPGeEmmHb/pEcGA638ScoVvQr8eS4qJy4BUyMfIctvsO;20:/42MwOMpK2ZwnSHMCZvidNy7DL4bnGNUOk1rUcQhv+exsKrzhY7tX9HpbBlE50jAFipVbchzUIYYGw/9VoThn62daFeb/TCaNFMoIhYpclSPKkGwTh1UfUkWxtUq+UOV6+vAaKgRlmSrHWnBe7BTTBWflds1BC15ENYc5g68n5Y=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 16:01:37.5871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8702130-f196-4aa6-15c1-08d5ecc7be77
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0170
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 03:07:48PM +0200, Daniel Borkmann wrote:
> On 07/18/2018 12:55 AM, Roman Gushchin wrote:
> > On Wed, Jul 18, 2018 at 12:38:50AM +0200, Daniel Borkmann wrote:
> >> On 07/17/2018 12:57 AM, Roman Gushchin wrote:
> >>> On Tue, Jul 17, 2018 at 12:30:18AM +0200, Daniel Borkmann wrote:
> >>>> On 07/13/2018 09:41 PM, Roman Gushchin wrote:
> >>>>> bpf_prog_array_free() should take a generic non-rcu pointer
> >>>>> as an argument, as freeing the objects assumes that we're
> >>>>> holding an exclusive rights on it.
> >>>>>
> >>>>> rcu_access_pointer() can be used to convert a __rcu pointer to
> >>>>> a generic pointer before passing it to bpf_prog_array_free(),
> >>>>> if necessary.
> >>>>>
> >>>>> This patch eliminates the following sparse warning:
> >>>>> kernel/bpf/core.c:1556:9: warning: incorrect type in argument 1 (different address spaces)
> >>>>> kernel/bpf/core.c:1556:9:    expected struct callback_head *head
> >>>>> kernel/bpf/core.c:1556:9:    got struct callback_head [noderef] <asn:4>*<noident>
> >>>>>
> >>>>> Fixes: 324bda9e6c5a ("bpf: multi program support for cgroup+bpf")
> >>>>> Signed-off-by: Roman Gushchin <guro@fb.com>
> >>>>> Cc: Alexei Starovoitov <ast@kernel.org>
> >>>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
> >>>>> ---
> >>>>>  drivers/media/rc/bpf-lirc.c |  6 +++---
> >>>>>  include/linux/bpf.h         |  2 +-
> >>>>>  kernel/bpf/cgroup.c         | 11 ++++++-----
> >>>>>  kernel/bpf/core.c           |  5 ++---
> >>>>>  kernel/trace/bpf_trace.c    |  8 ++++----
> >>>>>  5 files changed, 16 insertions(+), 16 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
> >>>>> index fcfab6635f9c..509b262aa0dc 100644
> >>>>> --- a/drivers/media/rc/bpf-lirc.c
> >>>>> +++ b/drivers/media/rc/bpf-lirc.c
> >>>>> @@ -135,7 +135,7 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
> >>>>>  		goto unlock;
> >>>>>  
> >>>>>  	rcu_assign_pointer(raw->progs, new_array);
> >>>>> -	bpf_prog_array_free(old_array);
> >>>>> +	bpf_prog_array_free(rcu_access_pointer(old_array));
> >>>>
> >>>> Taking this one as an example, why can't we already do the rcu_dereference() on the
> >>>> 'old_array = raw->progs' where we fetch the old_array initially? Then we also wouldn't
> >>>> need the rcu_access_pointer() on bpf_prog_array_free() and yet another rcu_dereference()
> >>>> inside the bpf_prog_array_copy() from your later patch?
> >>>
> >>> We can, but then we have to change bpf_prog_array_copy() args annotation,
> >>> and also all places, where it's called.
> >>> IMO, basically all local variables and function args marked as __rcu
> >>> should be not marked as RCU, but fixing them all is beyond this patchset.
> >>
> >> Right, agree, the __rcu markings seem somewhat arbitrary. :-( I think we need to
> >> investigate this a bit deeper and do a proper audit on the whole bpf prog array's
> >> RCU handling (probably won't get to it in next two weeks but put onto backlog just
> >> in case it's still unresolved till then). That said, given this has been there for
> >> quite a while and it's rc5 now, I think we could start out on bpf-next with the
> >> obvious candidates which should be okay even if it ends up bigger.
> > 
> > Totally agree.
> > 
> >> First two from this series we could already take in if you prefer.
> > 
> > That would be nice!
> 
> Ok, done, applied 1+2 to bpf-next, thanks Roman!

Thanks, Daniel!
