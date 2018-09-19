Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12381C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99ECB214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CvuxWrnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99ECB214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732740AbeISXrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:47:25 -0400
Received: from mail-sn1nam01on0078.outbound.protection.outlook.com ([104.47.32.78]:51488
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbeISXrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoGHJ15gjZrElqfEEF5NDNPQAnEBkgN/QqXOuiCVbp8=;
 b=CvuxWrnOga3SaxkxBD3avgPjyA7SsG92+Uj8ctxCLvNYbmwnX4Jq50em9qApBC/0pT0wAyNILD9k7EVRWGhCS+ld0fGwvzkNEo6T9ycVoXn5FvIOENp4CiLicK25C2zGU7D+xiT5yRdTNv4k8qy6y/cRtcd+uFvkZS7IQecVL3Q=
Received: from BL0PR02CA0047.namprd02.prod.outlook.com (2603:10b6:207:3d::24)
 by BYAPR02MB4758.namprd02.prod.outlook.com (2603:10b6:a03:4e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.14; Wed, 19 Sep
 2018 18:08:18 +0000
Received: from CY1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BL0PR02CA0047.outlook.office365.com
 (2603:10b6:207:3d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.17 via Frontend
 Transport; Wed, 19 Sep 2018 18:08:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT029.mail.protection.outlook.com (10.152.75.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Wed, 19 Sep 2018 18:08:17 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <edgar.iglesias@xilinx.com>)
        id 1g2gtc-0003ZU-Oy; Wed, 19 Sep 2018 11:08:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <edgar.iglesias@xilinx.com>)
        id 1g2gtX-0001uh-LJ; Wed, 19 Sep 2018 11:08:11 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8JI871q020652;
        Wed, 19 Sep 2018 11:08:07 -0700
Received: from [10.23.119.44] (helo=xsjedgari31.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <edgar.iglesias@xilinx.com>)
        id 1g2gtS-0001u9-WB; Wed, 19 Sep 2018 11:08:07 -0700
Date:   Wed, 19 Sep 2018 20:08:06 +0200
From:   "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To:     Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        "Edgar E. Iglesias" <edgari@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <u-boot@lists.denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] net: macb: Clean 64b dma addresses if they are not
 detected
Message-ID: <20180919180806.3tps6yukhm3ry43i@toto>
References: <0997a0e77b5e5c04c9a4d277d702d93a1a8a7448.1537373294.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0997a0e77b5e5c04c9a4d277d702d93a1a8a7448.1537373294.git.michal.simek@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(136003)(376002)(39860400002)(346002)(396003)(2980300002)(438002)(199004)(189003)(97756001)(63266004)(26005)(9786002)(186003)(46406003)(106002)(33716001)(426003)(336012)(486006)(446003)(476003)(23726003)(11346002)(478600001)(126002)(77096007)(1076002)(356003)(106466001)(9686003)(305945005)(58126008)(81166006)(47776003)(6862004)(316002)(50466002)(5660300001)(8936002)(2906002)(16586007)(36386004)(76176011)(4326008)(8676002)(6246003)(54906003)(229853002)(6636002)(81156014)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4758;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT029;1:Y85dMTzS1/xVPYnB5oGzsfCEXiXeujbR78B5BD5n3PKE2EHEgnu9Ho9j0P58CQ4slgnjo9wSTFOXtCWqRe+8BiZKDjlcSu1QoXv4iv4F8tJ1Gor0oCAB1qFheiVkaznk
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a167bb6e-47ad-4ba5-0cbc-08d61e5ae041
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4758;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4758;3:zdaMVSLV2wpXt2qw95S3h7IXkQ/FAzeTm5EHaP9Mo3a0iR3chaXAIOB7ypyK/GXQcdLWWPgPDo6YMPcSjprAd33Afo4odD0nN2WpnsZ5unupNI0bSCh4iAbU/bkc80/qBEUaydFisWka6T+4ZWZ+qpPTFjZ7DBNDL8oINaKcDNdpS/ecq3RKbphfAO47K6lcLYOZKWC6Mx8RSs3JQ3xeuWRC2upXv63/kc5YqtIPsDNVP2qEnYjsTNzVE9N4+fPJqMDEEivQLV9Cmqlred1RmdpYLdyeeUX8rhtOYCbbUv2KXTcrc+xRetOckazGwDGvuXxjwy3DGs20LQ+IHMnefm3otosoBwaOYlkZc3FBxOw=;25:QCzzEiwa9j2+cw87fqBNaeahAT0/gZIXx5edJXK+4g0HDgm0dY12atESwwB/8uwaT5G8WQY/zs//ZWwXmhqOhRl65NztjsFFsqCTmtJt25e+nmgsXoMxWi4VooA+8lrqJZiKgzfteji4kMy7AJlxpcAqwDcgrpmuKzh79Yasolh3U181Ys96+WIgSxSi9LakX3egCj6dTR2GibfrB1wqZGKPPtA7mII0Act3Lq41yDSkwo7r/uA2tnG+0moQKGcj28DvnHZaWV+VrI/KXJqnDc1P3j+jYwJQiG1Ag6jjAiKtLRTtPgIxKIJ7RrFIAUL8FxnJeMei3OOrfT4FDgOOdw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4758:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4758;31:PQcS1hh+j9cE+pd9H6v7K1rzepvTcQ01bCjV4psGSeBIU8XbGbZYUQ2K7QCHHRCTWRGaIqnWzlThyw/hQQ3EJ7uKvEWIjmAHisoUXDjPAUFgGkR1hP3yxZBR0vAxXy3epBZIxmXVTF8RUxOO4sjt3LH8c3GH67YtHoI8agdNbK2U31eDiJd0pcFevIw9cB+AWAc91Ae7bgq6zInykmux88tlGB3wPgO432o9VoMAMW0=;20:aQ3BZI/Sbyzk2f8yBs6z0rXUXUixTAie6mamBKjejd+QTalB8fF82lKnazjw5Xx+rIz7hUIqN0AsWqrlBFLoUTZdlP78III3/kOn8BAJhqsIsi1rkFAy1egVOPAxf8QcJ8ppdEqiBXeK5zfpaMuNUs7DIVtyDSuUTFV86J0khoX+kNIQM34FdK+5I5zltaAJpsIGSTcbVaf6/g7b367/r5qOJF5LLNQoAydPDj0NZ/gLcCASkN1H6M+4sahPXvMtmnTIp//vxw6ODv/g2iHMvF4KuwKLjXhCoT7Wtw/eYpWEGw2bRtEkxa0jHv/9ZjOVW0vUrOS0BKHkSJrJK0E7+VD3K1IOe36GYz9X8VHBvCxiNN4euP5VlM0GxuvYsq7kDlO4RUXbqFMM9/cxkLIr7G71DzwS98Mgz8grgw76WzNpqTISr+14tMJRH+KRd330aHIu4d/fkSPdgJAYmerb3QjmfsJuQjWcy2BIXvbzDFnXQKUSgXyXB+374WDjfoh4
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4758732DE2651FB5A1566D76AB1C0@BYAPR02MB4758.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699050);SRVR:BYAPR02MB4758;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4758;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4758;4:0sYFD0Yu8TdFEJIMZVofgNbHYDU+D6GRJ9jBPkV2aZJfkT//WdnaUYzdPzY1alXy0WQEM/i+znhteqX0+zUj4jJL5VJwlLY03KI2pzJCd5dHNrPwgweBwyXQsumj2GG/DUo/IEqXEtTvNyagnDGhD5MUTlCIy+aNwW6pOB1olfSb28JKvelNRcTr4mMttEpBNmNGa5XcIoYoZZ6qxjpqW0ehgwugFZohMtn+g4gwKLsaSm4oxwpEerRcqY4HXrYR+iKguKwEBaPMPROQgE2w/VeWdBNNBTfPnWP9dgT5JhKBld838hJpQnqlS7SPQ0BW
X-Forefront-PRVS: 0800C0C167
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4758;23:Xy49cp0X6jkd04ntGguvsVqbsyzrJmrTjtV/XD+9G?=
 =?us-ascii?Q?gMo7Jrwz1SrWKgFklqOfTXqCIoVJE7rNU0ZqAWDCcU+ugjWkHDNNRFLRPL4G?=
 =?us-ascii?Q?tNG06+n5gCnVZoondY082LCEU2nyQtg9z1wruQyh9WTWyuYGKG9wgR5RbRql?=
 =?us-ascii?Q?vwAp9+5VN446QpmRGQa4BqMb+v6wcNtioTQn8IeItZcHMf2knEYbGhk/ifzk?=
 =?us-ascii?Q?v+P68rvlSne+QERSCvTl/1PPEHPU/2CGsQGeHJGFNKzckwOdi6SeIBChlAwQ?=
 =?us-ascii?Q?HjtgG55dnHP5Tz16l5UR2Y0gGC3Jbqa+S/M/Sy2SLYvZY25AoRTuKxT0PU6Q?=
 =?us-ascii?Q?SJKvQiuzUjzEmGXki/MAaqMIkYy2hhwd+BBa/rbYGMr9MvCB+J9Glh1gfTsk?=
 =?us-ascii?Q?w3PdxxszuGH0ODnUmhwEPm6oSwhLKjRocDT7bKbbhgUeeyL8usBCJ21Nw+ZL?=
 =?us-ascii?Q?IW+ZcgqO4fs/GXmpgiYm9ApiRu3gzlrypD9wYqTIEy6q3neVJB3GcRZ8/ioa?=
 =?us-ascii?Q?4qMRIAxyFd1/H4NE8R8P6a2P8qF0mm/8EEr29zMA/4mCYEIyIvvE5TAroGxP?=
 =?us-ascii?Q?ejf9dHBGwWwX2PcKe7cwEr+Rtx/bBl/VKWWosx36Ix5PEZJJbldt0L746g7V?=
 =?us-ascii?Q?2XT2xY1rKqOvx+J0R7VguzjWq5xQWhtSRgoA3DRQeIcSPjykSKfK6qjX5YTG?=
 =?us-ascii?Q?ebcb+FUlGT5IN6DtB+1GntiMSrU/rAOVmSgm6iONwsla15bbGBDOZBtMnTHA?=
 =?us-ascii?Q?LDhLbQTRZJ4eTChDer/W8e8313mYKJzw0885g8lrp3P/zR7CULVyWzC0EsDQ?=
 =?us-ascii?Q?PruWlNlXUrUeo5mYQhb6MJJMHmE295uRLYp8LRes/P17QC7r+FLHkCTjqn3I?=
 =?us-ascii?Q?9hJscHClT2wN5A+YXmVPMTXHUmZ9zOPtLpA8sA9XiloQLHQBesOZmuw8ZW0O?=
 =?us-ascii?Q?xiDtauPsYYKKsXXWqzKOxX8K3GLyYXo3HQ8ktVlHLpSTqhujNQkBI8iy1Cis?=
 =?us-ascii?Q?OCiFnix3F3MqS9qoWch8V7Mn4RIO3ghjxOrCsh4rRpNJF7KNyc3NqcTbupBK?=
 =?us-ascii?Q?qowxBQB45L5tBIrk8DaHtW1TPEApDLWY1WiItMk7+iLHigeq/V0f8JecGTAF?=
 =?us-ascii?Q?YbngDy1rtf+iwIsNhGwFaGKe1FguU9mCrSqQQdcb+M4suzqJdbxrg=3D=3D?=
X-Microsoft-Antispam-Message-Info: xaMhKbAhx28C7QLtT0jilEXwZjLw9iBc7PhgYlOcx6B6NkdvAs1ZHYZlt5spd1Kveq7xGZYRGmyN4201GlATp31vyRZhTnilWtA0BA3utdgXSPEXKYugjjYjVu8wuszpWVDpYJ04QlEBGe5SNcC5ceeknxycaso8OTmWMaJe6V8t4EFb+TritTttHKMPWtN7m3DAPOCT5dTYzuqfauHaTyu06BcakMoq6+seVqka4g+TDjNsiM66pttpWtO4pA1eGZnsHzD75IkE2Jp6b5Xe9weLiAIvtadC77hB47KZFGRSrZhtr2wqtkHk0o+mv+5dnS/hBEK1m6uCxHVQulz1HnbfnpakRlVzSDRvZ1pV0xQ=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4758;6:Q3fLLie4NSbIwtlOOAjCWtItYRvf1ayBAgGh1zsHtikEYTn/+a7N6Z/AGNdN+rF5YPFR6GK/Nj9oSdDUz/7NajVGhy71D+lfN2o1tHPhrJevtzw3Ob4L+/DipzEgX9mJtKWMmjkxM4ag6MNFJkYTNJLV+xWLS+8UL0Smnepb7kj3QH049PBBh+Vf7U8SJnZoHwQdNJYYiJu4aeyD0z5JiXR3FwwnFTV+xs5iAK4OkIvzBsnLbinu4v7CC89SbI2NjdQKAMqoDomEHfFNcWiCVPwnqPpcWOkkvLwvPQ4PZyiVaBFMXe2e1TnUi+nIqk2kGPxJfHxJ78xZtPLDUcxJDx8cyhiJUakSPBcpudffg5YisfxAP0Sjy7S5tuKut+eVxshG7GPnLI83/zcRy8HCJGg8sRAHPqpZlOsHby+ilg3TCy9Iiybc5ls7SeCD/LiQl8zoflSd3b4aGUax0Iu2Fw==;5:ygtAfEoTQCZNohheXWlc3dOgiAtFC/r4VUG6H6j31SKBGXc+R3Fz71ii1U6O1zwt/LFU/HBD3NBKtX1L/sQHBhQAiI3W5bKGHvXV3RyCTsdSpyUJpR6YPYPS/C1aQKwkQb1jT2ki+hYbLy2QUc8CCvnITeKUnVnNdv1GbQ+cOA4=;7:p3yh3hePZ9N7Nb/j+P4T08mcSyPXWbEhIGu6ZxAsv0oWkVTt8em4zfEqHO3JA7uORD1EGbNn1F3CJF0WeFPYKh4v/pgrmU2BT4Vpz2mUFX/lFwODL6vGO+Ov96Wnp+ZPs6AA94j7FoVgC1AzBppgKgkrISBGA/hL354mzvvv9tSgV6krXvJKgicBAmhUcsfjYwmwxA6RUg4oYirjk3T7RBD5m71PyrSd//J2LIWq3XGt7Wb7XOqHQ9SfmveK1rNK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 18:08:17.2441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a167bb6e-47ad-4ba5-0cbc-08d61e5ae041
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4758
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 06:08:18PM +0200, Michal Simek wrote:
> Clear ADDR64 dma bit in DMACFG register in case that HW_DMA_CAP_64B
> is not detected on 64bit system.
> The issue was observed when bootloader(u-boot) does not check macb
> feature at DCFG6 register (DAW64_OFFSET) and enabling 64bit dma support
> by default. Then macb driver is reading DMACFG register back and only
> adding 64bit dma configuration but not cleaning it out.
> 
> This is also align with other features which are also cleared if they are not
> present.

Hi Michal,

> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/net/ethernet/cadence/macb_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 16e4ef7d7185..79707dff3f13 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2163,6 +2163,8 @@ static void macb_configure_dma(struct macb *bp)
>  #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>  		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>  			dmacfg |= GEM_BIT(ADDR64);
> +		else
> +			dmacfg &= ~GEM_BIT(ADDR64);
>  #endif

I think you might want to do this clearing outside of the #ifdef.
If CONFIG_ARCH_DMA_ADDR_T_64BIT is not defined, we'd want to make
sure the ADDR64 is cleared. E.g something like:

             dmacfg &= ~GEM_BIT(ADDR64);
#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
             if (bp->hw_dma_cap & HW_DMA_CAP_64B)
                     dmacfg |= GEM_BIT(ADDR64);
#endif


Same thing for the USE_HWSTAMP/PTP flags below.

Best regards,
Edgar


>  #ifdef CONFIG_MACB_USE_HWSTAMP
>  		if (bp->hw_dma_cap & HW_DMA_CAP_PTP)
> -- 
> 1.9.1
> 
