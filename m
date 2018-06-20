Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66140C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFD020836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JvrR9aLF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Bty73p1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFD020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754311AbeFTRcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:32:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52888 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754088AbeFTRcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:32:17 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KHS7lv004872;
        Wed, 20 Jun 2018 10:32:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=utKCbDUWXXA2OIdWuw8bnVfyzs2wsaWfwCNt/Y5re+4=;
 b=JvrR9aLFi5OxuCMUXuFy7zGQtOs0wmGGTYSa2cYMRV5LzcAr9FvXjA+Sxb3cjl4xzuw7
 2AK1ipwQ8YhHZ4F9qRH/k/MYZeB8dRoKVTWJ8VSbGKimYGebVRais0IDTj4Hd3a7HYOI
 bvib1uqTN0Ji1BVZ0VzADLExRYrJUj27I/U= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jqsq2gbsu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 20 Jun 2018 10:32:08 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.14) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 20 Jun 2018 10:32:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utKCbDUWXXA2OIdWuw8bnVfyzs2wsaWfwCNt/Y5re+4=;
 b=Bty73p1BJp67Y1j8wZ2AkVuMRgJ6hh9LMtuncwQ1mhLvY+vsbVOr9oSyZcxbr6ZhjsiMIhd8zBciGATJ7AH8OJz+aGfTxyL6orTkLpDEWbigmkyqZ9CoD6473FKXuAhTvFLMIeJUT9OW3L35rHwDXw0QOF63x0IgFX0NRFyKCIs=
Received: from localhost (2620:10d:c090:180::1:f057) by
 MWHPR15MB1136.namprd15.prod.outlook.com (2603:10b6:320:22::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Wed, 20 Jun 2018 17:32:03 +0000
Date:   Wed, 20 Jun 2018 10:32:10 -0700
From:   Dave Watson <davejwatson@fb.com>
To:     Vakul Garg <vakul.garg@nxp.com>
CC:     <davem@davemloft.net>, <doronrk@fb.com>, <tom@quantonium.net>,
        <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
        <ebiggers@google.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net][RESEND] strparser: Don't schedule in workqueue in
 paused state
Message-ID: <20180620173210.GA6064@davejwatson-mba.local>
References: <20180620215949.32334-1-vakul.garg@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180620215949.32334-1-vakul.garg@nxp.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::1:f057]
X-ClientProxiedBy: MWHPR12CA0067.namprd12.prod.outlook.com
 (2603:10b6:300:103::29) To MWHPR15MB1136.namprd15.prod.outlook.com
 (2603:10b6:320:22::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15f066a9-f753-49dc-d437-08d5d6d3bcca
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1136;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1136;3:9HH9UHG1vRXIzHRAeelfaGfAodJ/bACjnNAYIc+WBJvPjw4mgXiXD6sQvAModlAbeSHPCOZ3p2enKr9+NhMc80dJyLsWnPLMbpNGCFj0rpK3BmoubdtEWvQkHJT82YwK3PyrMWmdUJ5BROcURROSBe5omL66fTIMEwlBgHnN4NzRVCQeF82O63CU2L54ajMXN3xlBjjpbOAcEQD+SUpOz/OqG3hXOsNvycKHsoCw7YTUqlIY9gAk4eI5ABRuNwLo;25:OSyMQ8CWf3nXsI9ATdEpwlum9kSCt31Z2cQcVGoZkdRHUZOSYXHWdXk64Jtin7Dwwg3VJUMsoXlfGUj6j4+73PumMiIpZIEponqd5efFv8U+akKy1S3DVtcFihG5iP1nP/WMHBfha9djd1c37rSgIZ/cjSzbRjDZ5yoHmTscIJIQCEtz11Y/1bb53MWwmsmSbQOC3akRZaQt8DdoLaoYQCqfiwF8/tc/TOcdeTH2m3+N2nbs0ZYyIM2IfBMzVLIkhbkZnucqp/nD+Tm9s894XKsTW5z4gfPMDVW3ocv9+U246tMpPz98Kr2x2mmtWnqN9pIgLC5YMR1uOQU/Z/b6zA==;31:UZHHH+ASL/E6OO1mqz4w6Rq0S8mf83Fk2W6+4Q1MdRT2DFpcEE+c2zLKsgZbU2c0kOBIUw4us9hOb62WD1hp/RWgIiCogE85UZ5Ge87JbJKCDot61uL1NuoDHEPuNnzbzCVGSMmJ4Z4a+bHDR4XCFg11RZW8H+lkpQ8j4ZY9JKr4aNVHAgJHoMyiXId/X3fgsFb7fQywVKB4QoFjW6drruQYWPby+qrmVOU3b3AhbB0=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1136:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1136;20:q7SkJk3b9MTmpMP9QtXrKlmQJhoyTASuZMAQXCookVEwAnuuQRAQyFD8XaEZle6IIXyMzqK3Wa8LU/qXb1H2zSfSeF16PEV56dyxsE6f/MFZhxKJH1my1SXY2G4YqKEAWbFVdPFRdkeliWw2+zo8pqAanhchxhQV5fiQTvO1WJgeHRlo6YRfFVxwL6pdNhrLn5RAyW9Er/HrS6eAXsXsDLJHe6RD3EXXiQXdCGAEMAI7aDas30nnbzA+K9AXEAAiZu8BcU4Ws2pkhyL28C40C0x4wsuXKwY1ceTHSNkoO9hJ0nPSaC2g2goHvuAo1KQE/DVU6IBxZ9Fm8KafHZ/K+ZEP1/ugp5AYk7fpgkBYneiS1pxcvtQ8Yu852D4xyhGGGRkcTkQ1FQ2Y6s8rpdVESrLWolf28i10UhpPkv3Lodq4eCNIM5N58dAvWYItIo+qcGrmQBiOWAPCfrnUsP///1widJqBICjUuFhojDPCUPJLu0XZTm35CCFBRH91wWQk;4:hTryRpUyMZiwDk0ue1mWn5JKufoEQsdrUWMbfKMLvpGnK+IabJfY95ld4bdH1XT2x3/4WbRRwYxHWd38TSH9w3uQ2XyL10fxCj13Zvi4OEruhES6D6IxKv/gBLflrMZEeMCQ49CwViXO1+kQ4BcDY3Tjb3Gd2atM/7VTAVB/1m0pDfw2GiWSjtLSMFWMS5T9ly8B1mZrbFYy7XOLQW7Jo0Ek+0NNwO7U2x0L+w6uQci3Wa98OFFSivfwF2nhLhu/84HTbz7pNbyrjmOeAP9Yid/uCgAR8Q8NOQuky4rSwG8CAcrJdda0rHv+x77o2bARxwCv9mIyqe48NqQgMHsUe8v8DCJy62W2MLJfO12acK4=
X-Microsoft-Antispam-PRVS: <MWHPR15MB1136164CAE456007EA2069D2DD770@MWHPR15MB1136.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1136;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1136;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(366004)(396003)(376002)(39860400002)(346002)(189003)(199004)(97736004)(4326008)(486006)(478600001)(6246003)(2906002)(50466002)(8656006)(47776003)(25786009)(7736002)(58126008)(68736007)(16586007)(229853002)(76506005)(305945005)(86362001)(53936002)(6486002)(39060400002)(386003)(53546011)(6496006)(52396003)(5660300001)(6666003)(8936002)(76176011)(33896004)(46003)(11346002)(52116002)(446003)(8676002)(316002)(81156014)(106356001)(81166006)(105586002)(98436002)(6916009)(16526019)(6116002)(33656002)(476003)(9686003)(1076002)(186003)(23726003)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1136;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1136;23:Zoy3Fi/owb8LGihHAhLk7+KvLqCJDLaFlCHA11TAL?=
 =?us-ascii?Q?YgadxL4WqUxsbZSbu9k4Ovm6Majyos0rqIAY+R97c6t0rQGvJb+oVbQBgD6r?=
 =?us-ascii?Q?rfqIFYkU/qjP1T3hFykXEKp2EX7B5MBxFsjieVgPKSd2KSCzjQWYGJFAKy7Y?=
 =?us-ascii?Q?Sqo1Saz0g2bKxSM+NkoEY4ZN9LwrlXUp0sbOMJ4TmHzao8NTWKxo0VLn/2QN?=
 =?us-ascii?Q?vXeE3yG55sVIkYL2/lfx1hSPuUvD4leAGF/jIIdAEt8m0nzeYS6TWt/WD3gH?=
 =?us-ascii?Q?vfXGe/xv7ppOq8vTSDn1ih+k1dKyvV1R7m8tQCV1uS7oLy5mZ6ImQINbufSX?=
 =?us-ascii?Q?EGoVLTNCYrcejAuYdQZTKw3xGbuAZOBCiUO1wwOVNsEpm45ZkLIWMDahBXrO?=
 =?us-ascii?Q?xqFGGICib+8yUhPBhXU2N5QpGP9M/7kO0fUlu5ijMlnWMPq7R+yNT63YGUmH?=
 =?us-ascii?Q?Zp/jiZ2DO7vWoFU9XgIIJfZUDjSJ9UodaB+BHcFHtYbepz+uYoQ46dAWERsF?=
 =?us-ascii?Q?oheBIYK52NFe5ukuhxtYtxFISLyDfhzvkprMk7mJAiSs+qDMTzGxL86aTzh9?=
 =?us-ascii?Q?ScgM4GOqoxHSI+koakUhJ8cYTIqBcobic16f1Ermsy7+TJdA7AuLYj/T+ueu?=
 =?us-ascii?Q?Uvyywc/FuoWigsJW29ijHikB4CxVtL8FvTVpSyiW1FSB2BkbgAbMk9OhwCvb?=
 =?us-ascii?Q?nHtLzAnwt6Aa5xMy1QLJH1wTMt7A1tEOmaYjFz7aizaoSMcueDI6fjt9S5/T?=
 =?us-ascii?Q?7F8ZHy5Q2t9VR2jwEXWZN2x0IiGPxJCn39OdnI8fkdgEfsneNsFa3byGmPCI?=
 =?us-ascii?Q?ROVIcE2YQAR5+Tqm/S6CKuAphDABTdmTJAHM2pFtUsCVNk802baSMvZmolg9?=
 =?us-ascii?Q?ppvzgvXPtsVK4Q7u+RveI1DxQKWnCnw9M60seJfNa6IptTOnaO5J1+H42j79?=
 =?us-ascii?Q?z0YKxUKBFf9E1VUL0nnVyRY1Qgj6Uz63TjtzWWUcwdue2hdqwFlrSeTeTnrp?=
 =?us-ascii?Q?5fZoeVmAkmNDeRV5mNCL5Gg3m7pmM/1QVMgwxjLmOxU1TLX6ACol5fXYQw0G?=
 =?us-ascii?Q?VyTQ2aa8oLdUZPvCXcj7XD8uSMFhWEGcYU/cApDb2xVLVuv4QIhl96LA4Beq?=
 =?us-ascii?Q?c769gUJFL9iw3IBmDbYv9+yS111tGp92y2K/p52wJP2bbnZPs5rVC8cqlS6r?=
 =?us-ascii?Q?wHvSEb/UtW+lSMui9qVHLFZf9CsvOnKBhsi29qKGi4AKRe7bJJt2rpBqGhSi?=
 =?us-ascii?Q?qG5nKB1zzioTHWGjenPuDeHVDFPbfwYpSuYOzQHWWK2T/OLAKeONlz9K9gqh?=
 =?us-ascii?Q?k4lVRjH4qzVam3E0Oom0DxsKDGOfuCBs+w4wkxw2vIN?=
X-Microsoft-Antispam-Message-Info: Tk3NOXHj6r1k863nJBfXV+25lfEXt2bOchPcn5ym7z2OuAf2s/k6ItKs+5UuF2Aj/qSldKTmvn5/ADXG75ipyrFHPwEjNcNJZXpihysnfVRE95FhdtEVhexyoWFDON1mqgsAbXRsZ1gZFC97KMWYCZIT+bhmZFyflCDEjTHzPJYgA2iMHrYOZKvPnC17QYVC83J/+a4TPL/vTElHXG9p5M9EmIgFBuR2ESmPxpTkgbvRfmA8mu5hpxWCtH49A2Avnuhz+Ef9KZV6MzUQVJOvs1wEYVl0HaooCJtiaOA3tMxsoOI2s6T9DLS3Ga23cnnWK6ZyG2QkNx4LzsDz7xyqHA==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1136;6:qusIMy1Uv/lvsuk/zX3yJbKn6jbdGlr1VJiCgk2LPS7WxNtGgNL8Aqf/7qRZEvoSTaToDuqI6Dhk3tPejBehKzxFCQwIYy2dvzbXSTjI089naATo5Ssg7CBBZ5bsZd4/GhiFjYhr1is91czWaQwwZcr6HH0VkzoKM449ShVJivJKD0aAfXCqbTaSyWbm0r/SxC5XhQrtrOgMqODbZF8wBV0+zoBZVdUE0PSApT9j232M5IEXcmNbmZ/hwtOdD8C9nLTE7S4mhwhZ/tVf37DhwJLoeMIQcP4UtpynlJFvmZs7e5E/PnYQeh0IlSpaUc3V6rG9r2we0S0k5rQio0UY+Vu+23pukn7ixDuiL47DFYadENpWadWgziskne00Owi0kdSZ5UHXY0VpApdjrmjYJ/f4+sRUt0EwbFRyK6qvpsEAFsssOJFc2utuv2wuz+Ug9oP2dPjXAhGvBz7SbNASvA==;5:26D0hWbN5niv/xo2CnzDImcHa3g6bi01jQHpVXHrO/4exE4+Zfoau3aYg9EkR9bQ5MQm5GIMTFMdxS/PA8z2hnTnCkPxHiIR+2jirBjyknGOdvJl5MDwCApud5QlejVIQVLcNXpWxQkpGAu07Bl3aFb8bAmil843YQIZnJlltIA=;24:AvVcACLI+sym+qSeYe+KPzGOGS9ExbhnM+IZqeNJJmFe8BAa7Buu/7pfr8Z8xhcJsJHvOuGvoXfKJWvoR892Ejsh7syIwkROZXW0RBc7J3U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1136;7:hiogOIWQEj+zmigGv8L588mIekQXAeujAkI6Gsv8CzQ10jP3ZporEgjcNM7wkeTxiMWqWdScsru7UN7vPIsayhBWhMzkT6BNLQn3XDzuoI/+oxhxrucaRzZ6fsSH1pT0wpd1orsTuYOqM9KhRDJKb9PPbyYib2mt2yOM703a+1gbpy0NHrloFexvZeop3Ymxk9VKKL701pQ935JxQJlRexH/iUruDHmyHZ4Qf0J/Wjrj9i6IaBqD/22oQGTr9CqU;20:CaDAmK2S6/F1yvEOm9L+XkPLafsTSVgbukK60iUBZG27PALP1ecdmxx9eaUNgGCapGU7MOsbxY8NuPFCILbO50f4qCP0lKUYTkimKEy7BPk/Ole33cQfCrdxRmn39oeRtZNOkMIBfSUDb+wdA8gNySreZ4/fLPc+yunkWIObzGQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 17:32:03.4884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f066a9-f753-49dc-d437-08d5d6d3bcca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1136
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/18 03:29 AM, Vakul Garg wrote:
> In function strp_data_ready(), it is useless to call queue_work if
> the state of strparser is already paused. The state checking should
> be done before calling queue_work. The change reduces the context
> switches and improves the ktls-rx throughput by approx 20% (measured
> on cortex-a53 based platform).

Nice find, works for me. Although current code isn't broken, just
slower, net-next would be fine.

Acked-by: Dave Watson <davejwatson@fb.com>
