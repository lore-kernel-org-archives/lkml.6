Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD516C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF0C2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="zFAFFxOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF0C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeJDWaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:30:11 -0400
Received: from mail-bl2nam02on0057.outbound.protection.outlook.com ([104.47.38.57]:21279
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727866AbeJDWaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIt0qXOzGyOVVNwOcKFgS1oy2fmuA/hEdBN8+15A41s=;
 b=zFAFFxOWZ7EH+ElzBxYuyqOZUImjvAGY7N9mmDDyZdB0MELvhacP5fuj5NWPERh8AphManIkmpn99QfOeWPxLvwrsiyjbcxPIjTwonaW3ZHlwM1EIpezEnhNUfXINedCKIc/eIbeVecvaZHgLhr+rNPnQlB4961T90/osr88qCk=
Received: from BL0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:207:3c::28)
 by BYAPR02MB5109.namprd02.prod.outlook.com (2603:10b6:a03:70::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.20; Thu, 4 Oct
 2018 15:36:13 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BL0PR02CA0015.outlook.office365.com
 (2603:10b6:207:3c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.15 via Frontend
 Transport; Thu, 4 Oct 2018 15:36:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Thu, 4 Oct 2018 15:36:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85ff-0001Oa-8g; Thu, 04 Oct 2018 08:36:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fa-0000EC-3k; Thu, 04 Oct 2018 08:36:06 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94FZwnb023816;
        Thu, 4 Oct 2018 08:35:58 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g85fR-00005X-Px; Thu, 04 Oct 2018 08:35:58 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 02D8B121465; Thu,  4 Oct 2018 21:05:57 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v8 05/10] edac: synps: Add platform specific structures for ddrc controller
Date:   Thu, 4 Oct 2018 21:05:23 +0530
Message-ID: <1538667328-9465-6-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(305945005)(356003)(36386004)(26005)(36756003)(6666003)(478600001)(63266004)(186003)(106466001)(5660300001)(76176011)(72206003)(2906002)(8936002)(50226002)(486006)(7416002)(110136005)(126002)(2201001)(336012)(106002)(103686004)(51416003)(90966002)(446003)(16586007)(6266002)(54906003)(50466002)(4326008)(81166006)(81156014)(476003)(426003)(11346002)(8676002)(42186006)(48376002)(2616005)(316002)(14444005)(47776003)(575784001)(44832011)(52956003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5109;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT057;1:gBwIvTLGillcsCZaO1B7JLEIw0XKm1NwxP9+rX7kCc8DiXZetLkilefZgCkhFnZsLkmVK7sYB9HPhEa739UwaYVySdSXwAtHl5RTnDcF1wZ4iODFsWTyUBBt7Bwb0LxR
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f501627-6c78-43dc-46de-08d62a0f1d2c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB5109;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;3:Ww5Ig3sMCSW8tQYWueF/GAuBXaPBM8ldlrD8uFMw3xjA359OZhq3Y5V5YpaStDq2ZSLz02nxV0+kx5CYuL1dtjSfSgORgoVhtkCbYdzSDyp8un6S/QUcbASxZ8II014zERiT/mFx+PmHdAY818jBkalQ8GINYtL9S7Opkb7o6Bk3tb5XW5+9nKVhSqhMVqwiJGKHesc1/4wgW0DZySGndiIvsde8DaLYE3hHpCfUOMXOiXMZ2DmbwGQo8nfKA/365dAtUdTnJ70CGGzr+c1gKBwQtcx0JlFXa4CtA13iS8cxsLzww6IpLG69UCXz17H/auWvY3h31ma9bacOLzD/pMEI0mtbhnlg7F8M7tgrBqM=;25:0hlHf+H0lEFaE/bSzG0vAOwrE+oukqMlDxqYRdnguVCmca2B6ljVbqIu0mseaRhWvOrqnwgef9NIl9z1vk2zYXRpvsjyZ5aiBOL2qjx3Av1zq8W0byxkCOUpsIuS4REON7z/SOp1ssGN/DKlSsCujjxddCQPSPnVbBu6nlt/qVBamVx7FqeVvxHhc0Pwc3djwAs/ouidysReVUyimlqz1Dr9uvbvca2EKFxc46pgAExwO9yi6JGg4PsVtyXLYnrc9AD/1WKjikjCgQvJzdSiZ2nfgEv9ZjSbLnxnxKNu+vQlwUcXgLM4SsgF0N7P1Ke20NiGUxzXxA/ur6K4whldyQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5109:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;31:pPf69Hd+IutJWw1HmS8rCxA2ebtziFn0vqkZsw/rGytmcmXyBQF2DOecRr/NTZXmocvHfOJMijA9KUglqhcPU8IkIVVSJf3u1fLZwA3HROaF6NbiSkAJ+2Ozm/jG/IcwGhqOlIYXP2bLTwljsPxzlVgOFlq1g8spL2MoiKo0Bx/Ht56KVU+WmwHqVpnGoQToL3cGWIWQQhZJ5rikIH/hs09LtdsPDoe1RXmV11JfyLY=;20:RXl4QGL7/0AOpITyo+kn0WWAg226SifzBDF2UHFmC7qRZqAqhgjKtYJqwMXVhEsZIr2J7KWwxkPMG7TR9jDyQErhmKKDfON9Svewivym3ujm0pKL/CsVVh9DRGBj0iueHLsW6+o3qWlZMNjT2mtD0gbO0FY/l1EGRvg2twjqgF7cl6seSIPKtBihIlBBpp7vwvc18G2X/ibHgi66OnXJVb7iYYI9xZWiFxuUAgLAdBRNdvli0WdBvYomKOlZANEigQHJIdaqf3pXMfTfj/Mz+sIDxVILLe+qfV+k1YjF5mobUTG1EJonfE4l2JRB17ecpbHG885LbMd4Whppg+hYQkIUWoVIJy+QjpHsRxg1Z4rSCaN8VdxQdyn11C4HWmkY43jNGbZ1dqhJ5A18Zxy9QnHdxluZOMG1pA1XE+5kVT9zPvKqSl4Dfr8DzdYjptdse3MTJmQ4MhFnhm/xyuMKdSu2p+cgmdlao01rnSjAvn1+fg2qly3ECDuzg9VWb4bV
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB5109FFE8E7F8BA0A2F7592E1C1EA0@BYAPR02MB5109.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BYAPR02MB5109;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5109;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;4:mt57AoxiWGyk4YrynKwL//jbtwSjb9B8f06yZF+9RAIqmcuharIJ5ZWoNHi58w+T2S7c0AQKT6t+o9MS91Q+ztbhsB7siOBe92FQ7KgBYdJ+QatO6Rk9KBhiP0/EbgrO3zAgQnmeu7YOgb3pmKi7Qk1aRNmTEpZjusjBYn8eGuX7x2QsQVuKLlXABeLMixhVnHDMVSfUoiegPyskqM8eZMpVITdoAthFS3WgM5ugHUSNe3MlMGSdI+PxiuS1jwWwtFCUfBXfla0WIhDwxipUhEoCTq9QkAWRBQLEMdDagolCQN1V/UseNM7VwhXzmBUsv5UcfiIBbRMogXoWff75r2OsQQxoAPRd3HaIX5mnYyQ=
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5109;23:T5870WdPL26ULFzs5H2AYY3xKysOnB6PrB8OktGgC?=
 =?us-ascii?Q?zlKHn/xitvxTIellduwCs7FKiePkUWtnxFRyMPNlmw49jUasf4IFlZJRBPTY?=
 =?us-ascii?Q?wTvIzCIgxhL3PzC2yOws5a91zhx2hmavxpr3rfTcGfue/YFVQ1hfMhuaBjHU?=
 =?us-ascii?Q?bepIUeW6UeosNoaQnQLKsK5+ESn+r2nd9wdl+4V2+rk3bLXaMINipuhiPS/p?=
 =?us-ascii?Q?fnM077GoVQ3XwLsPrrzafKyxWqMJ0Vm/hU0huKNMit/nzbSAZWhaQWRW4nEp?=
 =?us-ascii?Q?RFhedi6wjCyK7MqOs5TTAPiA+wROPJNK2MuJaPm1ye9DEQbiB5cbivW3x1Ll?=
 =?us-ascii?Q?odXEwVvllvlDfVJ3NYH0WqjfnNROpqjhI+//EiOVSHAz9Q6v0cSoeci/Yph1?=
 =?us-ascii?Q?+9rDiGhkqo2orkmPO4GbG64k/J3lhCOdtKikRT98SimdvBzNygMjudNTzNGO?=
 =?us-ascii?Q?vlASOeB7ijAY0v4O7rTBHbZhj4rxykrKKY66wruDu4rsM/en1HitHaABtzNN?=
 =?us-ascii?Q?50447AlkIsEDi5m45qZ1grE7Km7sKEzrOuY/Iy4dFpOmobTILf8epCaLVN7P?=
 =?us-ascii?Q?/eT4AgCJMZ30HH9zf++Lemi6AvQSg2noNkzetyiYg0LQoEW15NrlIMHD3Z2R?=
 =?us-ascii?Q?Z0HBiVeXoCyZcgS3Vok9kfygMHujLWfKpBHYpFJMn0pJamLj7RYV12ldNit9?=
 =?us-ascii?Q?ZxJG2135B9dn/ZlejmLbdoOGcFVfYveH6j113hsJ9jlDdu30wSmz+oajJYIz?=
 =?us-ascii?Q?+6jivMqzp9q9/LtiYcdJ28hs1KybB4KcbLkFQXBy1h+5K4iT19vg4JI8hP7x?=
 =?us-ascii?Q?sA1c1MK3cdHXfD/MgO18comfm3QnCSCUHNqw4gMoAnh8jcreGuKvhyAsLmgM?=
 =?us-ascii?Q?51RkbvN79F114RaTG+HslVN6QATc4Xkb0hewaMSSEyEKhNKqAfIIUH1BhOTG?=
 =?us-ascii?Q?sxNWLol9G9tjN2Vcn510qmaIG6hnVkJ0tWrM4hZIQcz8VoU9ro4DFvCcedsG?=
 =?us-ascii?Q?0GOaZ0khn3eIqncfLntOGChAOXnp4KlxdYZzyGM0vcqueMegH5o98/j2M41g?=
 =?us-ascii?Q?+j7+sPpEpXQ4Dsqyr8KEH8uFyB2Dy+1XmTg+WQfFgeAXk5gGHhYs7LDxdknv?=
 =?us-ascii?Q?YDayiA+1aJ+qW8L8GsC3OistloRpuCloFGDjMseV0sg4dWbKwbNCfSUJI2di?=
 =?us-ascii?Q?8rfSyfnRc/ouJCY66oalwJj7cYPAm95BmXPbp6iEqqU8NWbf7iyyVLsQ6dfc?=
 =?us-ascii?Q?bJ+W8jeY20iPkyvvRnOAScq0NCWxufgGn1zniff?=
X-Microsoft-Antispam-Message-Info: LLwOo19sXqR7lTVCBVtmMArALQ7KWInwRbBYiU42oUTCG+v4ttWjPWZ4Dnx1XPjPEDGS3x7bPpap9be936qWjyj27GkPoVyxypC1eas1tbvCc7SoAsx3LL7EYd2itxTb2uViA3vjzCgcH2Xw+oaTlcdbB/UyOCc6IutTSIbyhiYLB9AXwfVLGQuubTAWvl1Qj8Q5vtjffI5jB6KgWsuSiccpCZnOqPAqJ03MkRlA74u+dWwpvpK83cbCAeOChv1CrBAYHoVJOVWz/BKEhhdj1Y5pngHsyl4okvWiHXFT5aHr248N0RnFBWgjfxZcvQi+l3f+ftN9DsBCrdqUDA0YXEC4j2HCyp14iGO8/5qmdNU=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;6:Ji7ApyiazRcZ13GJMTua/P82RjpVr3ahFDdI23s7SnljBFol6t4aVJ31KAaj1cPuxSm6fT4eNlIrWTTNKQqx09JK71EskJYcbPQ90xWRUsB7Bpb565/P71i58Zn3zMKYV2SvxSThz77js02hgypC6BJwyBOdFojkudjarXsoDpyz9687U8auhy1NMwLs2Z/wTlhFJB1XHUGL4Cxw5cDcH6rK4IHzyHAc7Ocg3/pYpeMK7kUC0j/Ai9i1qvuhuwvZk8n6FLmlRrQVssghwNm/4i41Vg2H3C1Vuz4csnjmJD7HJ/vAnT8ULNCd/v0xZNrfq3fzy79SvIP/k2M451JWxawuZzehPm7JPubpXvtkYYNvrmsEh2PdxS89zDqjw0EKc8cUyuorpt/M3XTqu8wWqEzbM0Y8t5NOiYTXIdZ/2hq6eZXzrP66ybqjR7GAZbjPUsXdj9RXpZkCGxalsOY4fQ==;5:zkCEp0k4G+ny6/dwxkPK9uoVdYSX5BUq8q47OHj6aky2rtSC5YhJlFOloYgdYfIcJYZ884qOF3PlpQ/xpk9V00lriMbgzTL7WMI0STeEWObZK/h647wxDy/g5cz8msSQporuzSnRCjRSAi5bfHrbt4ELN7Qp27XAqQUVncbY4E4=;7:r2uD30ERv9lCtR6Mv/KkGofzjJSYH9RrGgfFBQhnKoA+2elQAK70vYE7GgMSIC4Nw1bMiNQYvzg/IE46IylGUMiDB1CYq3c/2KAHi8V42BLrR9vOnlNGqiN1mTbsKD68RNhvfCfTuYqJYZNmWGPw5Az3p669xyI0bngp6wsiQbXZdoGT4DAIPZsAPkZvr58BawCMTgyxfmlnJqOd08q/GW/6A2FKZPMleOynj2zbWc4sC44OCQ/UuCajNocbLyt/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 15:36:11.6664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f501627-6c78-43dc-46de-08d62a0f1d2c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add platform specific structures, so that we can add different IP
support later using quirks.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 91 +++++++++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 675155f..f0f4704 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,8 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include "edac_module.h"
 
@@ -130,6 +132,7 @@ struct synps_ecc_status {
  * @baseaddr:	Base address of the DDR controller.
  * @message:	Buffer for framing the event specific info.
  * @stat:	ECC status information.
+ * @p_data:	Platform data.
  * @ce_cnt:	Correctable Error count.
  * @ue_cnt:	Uncorrectable Error count.
  */
@@ -137,21 +140,41 @@ struct synps_edac_priv {
 	void __iomem *baseaddr;
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
+	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
 };
 
 /**
- * edac_geterror_info - Get the current ECC error info.
- * @base:	Base address of the DDR memory controller.
- * @p:		Synopsys ECC status structure.
+ * struct synps_platform_data -  synps platform data structure.
+ * @geterror_info:	EDAC error info.
+ * @get_mtype:		Get mtype.
+ * @get_dtype:		Get dtype.
+ * @get_eccstate:	Get ECC state.
+ * @quirks:		To differentiate IPs.
+ */
+struct synps_platform_data {
+	int (*geterror_info)(struct synps_edac_priv *priv);
+	enum mem_type (*get_mtype)(const void __iomem *base);
+	enum dev_type (*get_dtype)(const void __iomem *base);
+	bool (*get_eccstate)(void __iomem *base);
+	int quirks;
+};
+
+/**
+ * zynq_geterror_info - Get the current ECC error info.
+ * @priv:	DDR memory controller private instance data.
  *
  * Return: one if there is no error otherwise returns zero.
  */
-static int edac_geterror_info(void __iomem *base,
-				    struct synps_ecc_status *p)
+static int zynq_geterror_info(struct synps_edac_priv *priv)
 {
+	struct synps_ecc_status *p;
 	u32 regval, clearval = 0;
+	void __iomem *base;
+
+	base = priv->baseaddr;
+	p = &priv->stat;
 
 	regval = readl(base + STAT_OFST);
 	if (!regval)
@@ -230,17 +253,18 @@ static void edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
- * edac_check - Check controller for ECC errors.
+ * edac_error_check - Check controller for ECC errors.
  * @mci:	EDAC memory controller instance.
  *
  * Used to check and post ECC errors. Called by the polling thread.
  */
-static void edac_check(struct mem_ctl_info *mci)
+static void edac_error_check(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
+	const struct synps_platform_data *p_data = priv->p_data;
 	int status;
 
-	status = edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = p_data->geterror_info(priv);
 	if (status)
 		return;
 
@@ -253,7 +277,7 @@ static void edac_check(struct mem_ctl_info *mci)
 }
 
 /**
- * edac_get_dtype - Return the controller memory width.
+ * zynq_get_dtype - Return the controller memory width.
  * @base:	DDR memory controller base address.
  *
  * Get the EDAC device type width appropriate for the current controller
@@ -261,7 +285,7 @@ static void edac_check(struct mem_ctl_info *mci)
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type edac_get_dtype(const void __iomem *base)
+static enum dev_type zynq_get_dtype(const void __iomem *base)
 {
 	enum dev_type dt;
 	u32 width;
@@ -284,20 +308,20 @@ static enum dev_type edac_get_dtype(const void __iomem *base)
 }
 
 /**
- * edac_get_eccstate - Return the controller ECC enable/disable status.
+ * zynq_get_eccstate - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
  *
  * Get the ECC enable/disable status for the controller.
  *
  * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
-static bool edac_get_eccstate(void __iomem *base)
+static bool zynq_get_eccstate(void __iomem *base)
 {
 	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
 
-	dt = edac_get_dtype(base);
+	dt = zynq_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
 		return state;
 
@@ -323,7 +347,7 @@ static u32 edac_get_memsize(void)
 }
 
 /**
- * edac_get_mtype - Returns controller memory type.
+ * zynq_get_mtype - Returns controller memory type.
  * @base:	Synopsys ECC status structure.
  *
  * Get the EDAC memory type appropriate for the current controller
@@ -331,7 +355,7 @@ static u32 edac_get_memsize(void)
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type edac_get_mtype(const void __iomem *base)
+static enum mem_type zynq_get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -356,11 +380,14 @@ static enum mem_type edac_get_mtype(const void __iomem *base)
 static void edac_init_csrows(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
+	const struct synps_platform_data *p_data;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
 	u32 size, row;
 	int j;
 
+	p_data = priv->p_data;
+
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
 		size = edac_get_memsize();
@@ -368,10 +395,10 @@ static void edac_init_csrows(struct mem_ctl_info *mci)
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_FLAG_SECDED;
-			dimm->mtype	= edac_get_mtype(priv->baseaddr);
+			dimm->mtype	= p_data->get_mtype(priv->baseaddr);
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype	= edac_get_dtype(priv->baseaddr);
+			dimm->dtype	= p_data->get_dtype(priv->baseaddr);
 		}
 	}
 }
@@ -406,12 +433,27 @@ static void edac_mc_init(struct mem_ctl_info *mci,
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
 	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = edac_check;
+	mci->edac_check = edac_error_check;
 	mci->ctl_page_to_phys = NULL;
 
 	edac_init_csrows(mci);
 }
 
+static const struct synps_platform_data zynq_edac_def = {
+	.geterror_info	= zynq_geterror_info,
+	.get_mtype	= zynq_get_mtype,
+	.get_dtype	= zynq_get_dtype,
+	.get_eccstate	= zynq_get_eccstate,
+	.quirks		= 0,
+};
+
+static const struct of_device_id synps_edac_match[] = {
+	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
+	{ /* end of table */ }
+};
+
+MODULE_DEVICE_TABLE(of, synps_edac_match);
+
 /**
  * synps_edac_mc_probe - Check controller and bind driver.
  * @pdev:	platform_device struct.
@@ -423,6 +465,7 @@ static void edac_mc_init(struct mem_ctl_info *mci,
  */
 static int synps_edac_mc_probe(struct platform_device *pdev)
 {
+	const struct synps_platform_data *p_data;
 	struct edac_mc_layer layers[2];
 	struct synps_edac_priv *priv;
 	struct mem_ctl_info *mci;
@@ -435,7 +478,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!edac_get_eccstate(baseaddr)) {
+	p_data = of_device_get_match_data(&pdev->dev);
+	if (!p_data->get_eccstate(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -457,6 +501,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
+	priv->p_data = p_data;
+
 	edac_mc_init(mci, pdev);
 
 	rc = edac_mc_add_mc(mci);
@@ -495,13 +541,6 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id synps_edac_match[] = {
-	{ .compatible = "xlnx,zynq-ddrc-a05", },
-	{ /* end of table */ }
-};
-
-MODULE_DEVICE_TABLE(of, synps_edac_match);
-
 static struct platform_driver synps_edac_mc_driver = {
 	.driver = {
 		   .name = "synopsys-edac",
-- 
2.1.1

