Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AEEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DA2208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PndEGBK9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Pvzz8nfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DA2208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403969AbeHASYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:24:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57988 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403773AbeHASYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:24:16 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71GY3VD023556;
        Wed, 1 Aug 2018 09:37:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=0e6MzhHWH4G4SkUvZnVg7QTO8pf3lQ0eNxE6L3Mf5AE=;
 b=PndEGBK9xxtJoDpfKHkTqQZqpbMTs5p0cvw9aHHy9X80E+yeWK9wGMHfj2ETKoFIaO4b
 94aVZaaGqTHNwdxeO0p5CDW+lfAhTB98VhFP8AgrVIRKQyalPfR+N+rznmGLM0hHeX1E
 29YV/8nyrwCJlczl3FmgQT+a8ppugpUaNBk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkedrghdr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 09:37:34 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.34) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 12:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e6MzhHWH4G4SkUvZnVg7QTO8pf3lQ0eNxE6L3Mf5AE=;
 b=Pvzz8nfCXScf7Yzm0gIgoqgi/nsrm3ioJHJqsreN2FpfYYVatXdzWpe9F/z2JcxrsEhJZuBedyQnBUVVAwn4geyfnuujAbux26WwZFO2lrj8a/w3HwI+EtfLmMBHYkeak47Dw6LGcKuD9i5gy33qmE7qDaxmxxfUkjFonYnFgtg=
Received: from castle (2620:10d:c090:200::7:8561) by
 CY1PR15MB0170.namprd15.prod.outlook.com (2a01:111:e400:58bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Wed, 1 Aug
 2018 16:37:28 +0000
Date:   Wed, 1 Aug 2018 09:37:23 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@vger.kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v13 0/7] cgroup-aware OOM killer
Message-ID: <20180801163718.GA23539@castle>
References: <0d018c7e-a3de-a23a-3996-bed8b28b1e4a@i-love.sakura.ne.jp>
 <20180716220918.GA3898@castle.DHCP.thefacebook.com>
 <201807170055.w6H0tHn5075670@www262.sakura.ne.jp>
 <ede70c6a-620b-f835-d66c-b4608fe0ef54@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ede70c6a-620b-f835-d66c-b4608fe0ef54@i-love.sakura.ne.jp>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::7:8561]
X-ClientProxiedBy: MWHPR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:300:d4::11) To CY1PR15MB0170.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59141ca1-e7b1-468e-0d8b-08d5f7cd129d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0170;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;3:v7T5t0Myevo/pD4SWgBw78USw2AXigl2AkzMrC0ItypykAxjk3HbkpgabnTQfmFARouRQ4EjPWcaTCeuLAZwGQyQsJBbnH4sM8Yc9fxaNDGGpycfY65ZAAtRCoOlcWM0YaVftjZGx4zaz4fJnbX1F5roenW6VXjC4CiKG3PlGBYULIPAs2KpC5sqWCBISJJVI/Il74gni7wIj3POIi3PpdahCBENGGvt6WfNxj5IM5eCBru9ivUdBz6BGp5OuEhi;25:IdJogB/Jew6K6AnJw/ne0dnunqPFZL82AD/ov34bOGh6RSDjkG4f1/uLAydP36tDNRITYCPIN49M1mdEYm+ZEVs98DcOY2goFyuhzNom8yMAxjIpxrJaTWM6r3DWN6HQ/VWNovF7M7e94O+diJcDCoieVI4VX9aKWmU4pJtYogCwyqT+oa6mBlga839jRTwQdmmWcA/qfoOuXHg64tG2nfuQFGdQNtlr24EtVgHPErst6M2ENAZ+PD/5TShhsi2GTZ3/mEI/+2GXwmNpKgX5kWHomxSm+YnmQH9yIRCRY2apczLb4pNzYEjN4r02yY9xEkA+/aFqSdrJzpSRFLBn0g==;31:44P3Exv49MLxbGDeuzA1PTCNl0OqVKzngCpPeHxpb05quoRoRy2vnk2mq4rHrZC3idcxWcInE0wh64KbsWwUjcM34Qs8BUmyrdT1ZEn7x2W6IKlCk1g1bbmf/vOvIcdL5bd/LdvQkWR47KFeNofQzT2bHqpf6k4VnSqjF+OHvaBl3Y+xZJZv3VhTqCy6TaiHofEzCjUVK+dSYNWLufdqq2bVRFE/bOpyYUKgBPyUCpM=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0170:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:jYeGjpruhAO2Z0wsgg3nPAE0VXOBT6emBKZDoeDxUR9KMQk9g4RfQXF+3dYqoL9Sgl+2H7z7CEi1byiLKBk0iNcbkK58hM/eCItTbQjGk601zhlQl6Kqopwnnt9VKR7C1T3ZtmrtV1a1adBcYQxK+Dseoq+xxSzSRmgkQJ5P+D9H/wn2T8oCLFCccxyeltGSq5RdzYtzERYTUf8AHvFXsjnHanjwoLNBJbPZlW5G7CPQUFZz6zVZtbs/Jdm4MK9gViFmE3fSJW46ahj/BpGb1BgNUYlAsUV52N04IGa6zz58ne4StJQoHYepKFsU6PpgdOXWQEWLsqJccvN5VXROjA/Nr9ZIUgJwx+sQbOTCUXcS0N+CdwJfnsYwvXjnXJju5JOJhslTVFyTm8n5yap9go8uBuQ/RRQviDUQuCS+VKZKR/VlcgbcjedgHdGVa+mPcIqy9RIxAYRjgr1Tkg2IIsB4cfiImKOT3BCVwiO9MeCNZ+wn96gUlR611lpeK5Mu;4:9/xasYhcTSeur2zG58dns0Lweg51InFgSjHfQqgu8qRx/3HYAOMZZw2g11SyvqwJ9al+HC8RkY4Fx8DTT1M5zFOk6nGr6zPZN+zvC1q9aQag8dvyTWTKNjLQH591yWTwLspsiy9v5299MTYsGs82cNOlidTYl29Ux/HPPzV+h7g3POmHjRt/Oo4lLlo3E7tHLTZzR0IpZIytH5Xppc+521LfJiBL0I7gqPH2sTwWFQxRRDTkSuC6zwsWzswTdXMw8WCQB8WzOxVuowdTCoTdeYV882D/6ETkl4h7Xhyb2A7Tp31dULZKTXVXJrcU2x7s
X-Microsoft-Antispam-PRVS: <CY1PR15MB0170A455DAA12EAE2257491EBE2D0@CY1PR15MB0170.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(10436049006162);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0170;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0170;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(52314003)(189003)(105586002)(93886005)(4326008)(25786009)(39060400002)(229853002)(106356001)(46003)(53936002)(33656002)(6246003)(186003)(16526019)(386003)(8936002)(446003)(11346002)(53546011)(50466002)(81166006)(81156014)(8676002)(476003)(305945005)(478600001)(68736007)(52116002)(58126008)(76176011)(486006)(55016002)(1076002)(23726003)(54906003)(7416002)(6306002)(9686003)(14444005)(2906002)(966005)(316002)(6116002)(6496006)(575784001)(16586007)(47776003)(6666003)(6916009)(33896004)(97736004)(5660300001)(52396003)(86362001)(7736002)(33716001)(18370500001)(99710200001)(42262002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0170;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0170;23:+9GvuFBXBeFHTmiQM/y8QVwRXn7uyT4ByZhkFJfLw?=
 =?us-ascii?Q?BOjf0IKEL9YpQ2mSIZ5sD128hGbZvUbAomankrpO/HgFSNsoN76w0pwJW8pL?=
 =?us-ascii?Q?4EnRjF83obNfFpkmWfw3ikfhPBaIpzW2Mvjgd190GoQf0lgPrTtsL99RSaNd?=
 =?us-ascii?Q?Rb5zmC9OS3n1++BYgoXVgF7MywJXMM0CPDEktT6yo6LUhR+vjuFsB0+PTN+f?=
 =?us-ascii?Q?h97zH0s1zgulxfFatBe0BwJv96bDl6bP4nF0x6Tyo0qkM5u6JK4xFbWz6bNj?=
 =?us-ascii?Q?k56q684/FGwFHDn52wcEHgJ88/rpCpsmZgjmbeX/lUP6KKlOB3ogJ9nCb9IR?=
 =?us-ascii?Q?DESjIxjI22K96jwAcsvmuX1geqFwdnYWY7ebfC7yHfZ0xYn1mwzVrK0CjkNJ?=
 =?us-ascii?Q?PuS4Mo+1zapZkSoT2mOcAJZmbUmDARFVwKQuB/iP5y//MHgxXatYXHcJSiD3?=
 =?us-ascii?Q?/5nC0HsglFgIFP+cyQawPayedf3Ntt6wtGG3FI/C6TqbHKGXnRxIRS6VbHdd?=
 =?us-ascii?Q?44TToZ2yn8UQHK/gDhUdYhII9NVHvWwvTfrTxB7ST0xAqK/NehFmu9dYnj2Y?=
 =?us-ascii?Q?yaYkY34rRj4thH0WplTASnjK2zWygGL5UwjIq7fGs/RK1g4CNB0PT+y7bwqc?=
 =?us-ascii?Q?Gy/nQgu4wfRbxhUehY+hBm0QfCkN8thMk/jd7X5SHrkbfmVDNwBwTO7Ej9t8?=
 =?us-ascii?Q?amHE8aei+7PtTrTVzuqolPY8APmzNJN83D9by4JbNYDEINjuHJv6i3ImV2dw?=
 =?us-ascii?Q?7TyAoxMYU7risUEysFQg3RNsvQ0ZaxMxJtKVr50SrCmhi24uTJLFR+OykfpH?=
 =?us-ascii?Q?lpE8IeGoAvlM4ehab1RqhJW+1qIkBnEPIMD2lEwH/G7yPr9ZZDnYPZRiV5dO?=
 =?us-ascii?Q?7XDyOMrOJ7uem7g5PDNHow2kOBo1kMnIoPZYnUIB4e7mXswCkBkcCsgF5iQi?=
 =?us-ascii?Q?8dvJoPlnsG8BWah754vxr4oe5pxEqRHEkPIyFRJReA1I8nraGdCcoLTjtNZW?=
 =?us-ascii?Q?PAhCv3vNZPBQs0o0wUG2kcdDjrdG+O8HyTQNMub+FPqiPgH0e2U8Si7u6S6b?=
 =?us-ascii?Q?ieKrKqPPXtoANk03sHT09yIcMMFn9kIwH6MYHcGv0A+xUGmd05hvhS+kHy7e?=
 =?us-ascii?Q?ScX0OfG0NTDhXD4TkwCGJHKtTDsAnlZjpjpAb+q3iuYJ+Am3ygduwE/FPV3s?=
 =?us-ascii?Q?3/GYf6mgeoOIvbChbnHfFfTSEjpCIKbUjfMFLcKbxzZC/QM2h0u4fyBnFH8G?=
 =?us-ascii?Q?jCQy4zQ54sjEI2+a44ybqmax7vz4byYRrkQIqOKnY6qfxNM9jSbU/IykrqJL?=
 =?us-ascii?Q?Q4hqQAtYMg+iwV1HfXIxI0jwZ4RTyJdIRjvMh80AIZQ5iiHsoav5FyT52Y/0?=
 =?us-ascii?Q?uFWbDSsIc/xJUwY1xKT59dN3apKMcfamdg9Q31gO5vaowwj5P6pP4EGrvDe2?=
 =?us-ascii?Q?eRUMgLqUaYvahgws6WKUDC517cP0Wu9DHLAX/+jvv/TyFS495owQaLsYp+52?=
 =?us-ascii?Q?hqY6ux8lng6/xIupxvXpLPB5RrrFbFjJFs=3D?=
X-Microsoft-Antispam-Message-Info: dYRutNyOhOmNWjEde4Lxkatsk3/cGpvhCNc/cjQkrsiYMZiqF4lBGVpm3ZdpSfRwn4y6qZ1TWrdEmddQyXh1VOb2/5p6KmZTQYqtDihcLj9b8RfKA5iiboFjiShNCYso3PZPgYvD0x3b17XuZM+IxQWI1KpfwthufFb2HAPnnHq85/VkxK4d5V+rxX1nWEMi/RMHlClrukYclEr+tJqHmQkCQRij7TjxO/veiPjRZDA9DXc/9lDXQdIWA0WNVkoi3uTW5b3UVXUCnzuxx7eNpj0XrOmm6gkqLdZvPQT/+P5oPWvUTX87S3bEXiSELlzUuvZFTPmVqorqfGMdHB9FuiDLls+J4jomDccLO/W8JJM=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;6:0PZRRjzr5i2GNOVM49OylRWXu20XfjAFxSeesovG9kx2y9/vay2boqDT8/fk9RhnfaqQ6OodLXmKkgxPtLGJkj3AllKzCUSDV0PPU5trcffo46Z0+YhYAlyn9RBDJLUcmZZ93W+vCH20f1dwMhHtLxj+2O3z1QaEZRDQJDn+tRNBO/udLfFogWc52ll/mZtOU54oFKim4qQr4O/thgmtT8JZzUd9s85K5Y2laW7XJnKFXGuu8cLQ7JLM4KsUs9qqQ4g6RjaAAOfS6J1JC5kxtcmGUeJzfUDbgNgdrazSpb7JcjrAr11BTxh5hHjkoN2S1PPtmnIK/EV0oGTLdh+q67OxV7RWTfbHhPP3Mh/X2SqCLAvyzhCqpJ8m4nsBR1vrBkP/xqCzy/lplW12zqAtfY5ABC9WXoPF/jZygWvpSA1Eo9TY48uw3v09ILRxzFb2AlYlJ4sClOmH1jUgsRezuQ==;5:A8i7h/xRe1JKRIKY9IbPNzsK88izwlxs2+d4UAYQlvhnhv8XxB8VbCBTShG0pG+zqXWl86OvxjNR3jikHIvp2PBDpg0NsnHQ7xiXXEXJosKwQ0xPlPaYCKE/rbcg7Zl+xW7ESx+HbZOrydV3fu1JBpoi+zmTenGSRYv0BTpJloU=;7:2AuULjlQuqkqRH+eMLgVMt4lsXOluHk6GfPQk/ozD+LhnjznnuRBbz6bj6DAQ2NAbvU4QBvnB01DEnyKdRGYIuoFz0vVzluhjPIPDurb/dXsuwIeEehh9S7h+m1rC1H3LuYqH7kmfO6GrqV+nP4DUXYp9jcifG6QTsV3FQfiA3SAsQlSu18HUgTgwgdc6HyEYLmac9EqivBQWWgMzLRdBxtquqTkjGLuPPi4TVOsHF6EfW85A2Fq4wHRxE76FZVQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:DzF+UhQ9nA16MI9PVtoA3zaH982BT5uloN9w0FTkfQJ7v8jZ8Gcc54HR811GsP348y0o02AtNM1IR3iGGr3DeJJs/VyhLrTW8uSGhXwK02DpDmRSmacE1ainfaPUGuoDZG67sv4ex2eDuA5D2pd4Zb/rL4zuleKKI/7Ue0JbLaA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 16:37:28.7045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59141ca1-e7b1-468e-0d8b-08d5f7cd129d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0170
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 11:14:01PM +0900, Tetsuo Handa wrote:
> On 2018/07/17 9:55, Tetsuo Handa wrote:
> >> I don't get, why it's necessary to drop the cgroup oom killer to merge your fix?
> >> I'm happy to help with rebasing and everything else.
> > 
> > Yes, I wish you rebase your series on top of OOM lockup (CVE-2016-10723) mitigation
> > patch ( https://marc.info/?l=linux-mm&m=153112243424285&w=4 ). It is a trivial change
> > and easy to cleanly backport (if applied before your series).
> > 
> > Also, I expect you to check whether my cleanup patch which removes "abort" path
> > ( [PATCH 1/2] at https://marc.info/?l=linux-mm&m=153119509215026&w=4 ) helps
> > simplifying your series. I don't know detailed behavior of your series, but I
> > assume that your series do not kill threads which current thread should not wait
> > for MMF_OOM_SKIP.
> 
> syzbot is hitting WARN(1) due to mem_cgroup_out_of_memory() == false.
> https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_bug-3Fid-3Dea8c7912757d253537375e981b61749b2da69258&d=DwICJg&c=5VD0RTtNlTh3ycd41b3MUw&r=i6WobKxbeG3slzHSIOxTVtYIJw7qjCE6S0spDTKL-J4&m=h9FJRAWtCmDLT-cVwvXKCYIUVRSrD--0XFJE-OnNY64&s=If6eFu6MlYjnfLXeg5_S-3tuhCZhSMv8_qfSrMfwOQ0&e=
> 
> I can't tell what change is triggering this race. Maybe removal of oom_lock from
> the oom reaper made more likely to hit. But anyway I suspect that
> 
> static bool oom_kill_memcg_victim(struct oom_control *oc)
> {
>         if (oc->chosen_memcg == NULL || oc->chosen_memcg == INFLIGHT_VICTIM)
>                 return oc->chosen_memcg; // <= This line is still broken
> 
> because
> 
>                 /* We have one or more terminating processes at this point. */
>                 oc->chosen_task = INFLIGHT_VICTIM;
> 
> is not called.
> 
> Also, that patch is causing confusion by reviving schedule_timeout_killable(1)
> with oom_lock held.
> 
> Can we temporarily drop cgroup-aware OOM killer from linux-next.git and
> apply my cleanup patch? Since the merge window is approaching, I really want to
> see how next -rc1 would look like...

Hi Tetsuo!

Has this cleanup patch been acked by somebody?
Which problem does it solve?
Dropping patches for making a cleanup (if it's a cleanup) sounds a bit strange.

Anyway, there is a good chance that current cgroup-aware OOM killer
implementation will be replaced by a lightweight version (memory.oom.group).
Please, take a look at it, probably your cleanup will not conflict with it
at all.

Thanks!
