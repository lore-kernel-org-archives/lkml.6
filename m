Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76925C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FAD20870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="PuUeoSxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfAUQmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:42:10 -0500
Received: from mail-eopbgr130055.outbound.protection.outlook.com ([40.107.13.55]:20608
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729075AbfAUQmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8zUWP11okN8Bu0QBfuGf74LiUIIfzFAx139RdKcFUU=;
 b=PuUeoSxzzwGrkXvhHR4+vaI8lDm4z90fZdHPu5cSSpHSQiKH7fbPeQvIaKKUWEjlaxabWpOYNk0K/yjTjDTjGy82p4lSdFWcqBV9IqRSOCncgSbYbR1hSELqQIg3ruzRn5od23zseJ0EZMx0pB6oGkuJiVw/NNBAASwchBcF4YM=
Received: from VI1PR0602CA0013.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::23) by HE1PR06MB4009.eurprd06.prod.outlook.com
 (2603:10a6:7:9c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.30; Mon, 21 Jan
 2019 16:42:02 +0000
Received: from VE1EUR02FT038.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::202) by VI1PR0602CA0013.outlook.office365.com
 (2603:10a6:800:bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.26 via Frontend
 Transport; Mon, 21 Jan 2019 16:42:02 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 VE1EUR02FT038.mail.protection.outlook.com (10.152.13.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1558.11 via Frontend Transport; Mon, 21 Jan 2019 16:42:02 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 21 Jan
 2019 17:42:01 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Mon, 21 Jan 2019 17:41:58 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Vinod Koul <vkoul@kernel.org>, <linux-kernel@vger.kernel.org>
Reply-To: <federico.vaga@cern.ch>
CC:     <dmaengine@vger.kernel.org>
Subject: dmaengine: usage of dmaengine_get() and dma_find_channel()
Date:   Mon, 21 Jan 2019 17:41:58 +0100
Message-ID: <23108003.0nNWatJzJB@pcbe13614>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(189003)(199004)(74482002)(426003)(106466001)(44832011)(336012)(47776003)(9576002)(246002)(486006)(8936002)(126002)(476003)(356004)(478600001)(8676002)(46406003)(50466002)(9686003)(110136005)(33716001)(3450700001)(16526019)(186003)(786003)(26005)(7636002)(106002)(97756001)(7736002)(43066004)(6116002)(230700001)(14444005)(4326008)(2906002)(86362001)(23726003)(33896004)(316002)(305945005)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR06MB4009;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0895405f-6990-4a31-9f65-08d67fbf5ed4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR06MB4009;
X-MS-TrafficTypeDiagnostic: HE1PR06MB4009:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR06MB4009;20:U9qFsMhXmvRydPuHG8+tAxSDJ37wzboNJWMfkUU++/kNDUSiPfDIIyIBAzCy3fGEOLGtg72GnWhpBsqMaKZ3RSa9YdV4rdeya2AcA0si9Q6vc45RLx6AP5Dokmb5SP6jHUi6+SzipqIaT3ueX/4WCHIY/OJJ8jQzFoJSLw5ai+z0s++sb3aVnOtgWPy3D0IfHburXPOFk6Qb3i8xGepGh2krKS/E9gnHW3TlqbLKA7d2/Yx5IXYRsvolG7RLD6zQD6e2d3TQR6LN9D2mC+i3LnXfm1rRK0+H4saqrLDx+R1dhuI1QdDGS3LTAwTRIVMr3bitIIG3K35zIgjI3/VpKxnfGz6VQy34O2HZ/JE/dIE+WcLogwLC1b1zRnGMsdBi6MdQgU7UFb0NjpvTV7evL34t55fqCcpM/pvgKg9jHUXvicevlMhm2er0brMCGQchADKXwoxuwHoA64UrdMJTpblBUt+2eyhcGXzz19dw2LrAwm3E1Z9e4beVfq/UdxxG;4:VvBBkEyJT7EJttkG3Z8gkZ7dcHLUg95iuEKycjlQDCtzaRafnei8EDuhWO43H6HjKTuYIKPwxaZ4uMdb48NceBbiVPZrbIhoyLjNxrLYX3cuoM2Qi6OaCHTr6LcrB+dhWKM2M+ozIYjcWVR1dwT1qU8ep/S13tTw+KONFRy/ua+aeABGT5osLgM8hznwrJtSTVFl48se8ZTtiUYfq9qg7NngkValq1WAF3P1Nnh6sRptfTt/8Dsr5FyFoscjSzNnASOZ/pIdFKSEF7Ank4ZMuOJnDaS8sbIe2f3hHMEu7yf4Oeh0v/EJeto+tbdarF0J
X-Microsoft-Antispam-PRVS: <HE1PR06MB4009D4BBB92E6820B94F194FEF9F0@HE1PR06MB4009.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0924C6A0D5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR06MB4009;23:Jrq6L3PuTVtObET/Iau1PHwkr9ZzVuNc/jlk5KOJr?=
 =?us-ascii?Q?hpelRBdXvgNEG5Hjkj8Gdws2X5S1N47flf0ncaiTGBonLA9t2EygFl0xd6XJ?=
 =?us-ascii?Q?Ihmc9wikVdvehfxYoqZur8tUDdkpXmPdRdFu0Qiyak8hFV9dQzNPZrabFyJf?=
 =?us-ascii?Q?xQWCnxcLm3yYZ5I5uRyvp3Thgm1+p9WRdIhXXjX+v2k8X4CjBFvVslBF+j2i?=
 =?us-ascii?Q?RuxmDLIkG9P4gtY+tq5MsvXqgxPCEzPjp5oK+uj2TST6mg+5YWbOhpcT6eTx?=
 =?us-ascii?Q?xt4cXT0Dh0TXC/hValt2TnC3OjYaXKxR/tveTVA9v7tD7dkjctiYrLZW9reZ?=
 =?us-ascii?Q?mJnZh6pOv9dBkzOr8Y7sg2wv39aerrhrljUB/gmuYfzwjSVPcYi2nf0A39LF?=
 =?us-ascii?Q?FluqHK/ADEKYhV6PO8SO6UUItJbqQfW3pagx9H+Q5cIBWhvhmaoNdgObG5es?=
 =?us-ascii?Q?P8lCMRPxQsNW+0WOvsA9SWWnKr+CmnkQMyJjLzl/ZXW8humvHjmb5oTNiZ2o?=
 =?us-ascii?Q?HvvOxW+626AbKahA9TCjEkZf0ruSf381m2uZCArLBpnCg6NltSXYc19frBB0?=
 =?us-ascii?Q?fG7tTS0Nmg8IodpOPOcCz/7ILqYLf4uZyhmhwul3fk9v4FJ+hWrJISMJzR5h?=
 =?us-ascii?Q?zTeh+7PP5uf5rPrRsBjQrTE2v+hSsWJ/+z603aczIuu13bAgyU9OedWQAjnx?=
 =?us-ascii?Q?WnDRBOI39fJDUc2x/BnAIa2LyGi6URAUhRZhQ8UQOnEKy/gQVezVo88H6tEt?=
 =?us-ascii?Q?wkQ+9kimzZ9eRP+IkziUUBY95X7p2+3kDyhD2W4/kxbb3G/HCcegPs+/hknL?=
 =?us-ascii?Q?lx5hxIBd5Ir+zdxpEHWomsBuyD7fOWCFybwdNAddSuhm0Z+A7XAXNWTztepK?=
 =?us-ascii?Q?BjzbSmEq1576z0+7XnlBL+eEQwVdQSFnaS9EXMhYMBdWCq9oXaUqyeecSGay?=
 =?us-ascii?Q?uVmBAarxVZxsU1VP+aFhl87eIzl8LmovrgT8yLDS4xlx530pkw8cPlAOSi0c?=
 =?us-ascii?Q?I7cua86Vd388lNlV4PdCOLfo5n1wy1QQJa2pCAqoTcuSZPX4j1Oopzzw70SS?=
 =?us-ascii?Q?p+YxzRrol/3OxM4xc4TZyR9MJ/B?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: hie7tlSARTQCnElqEwwY7nHpS9o8OshO7MjoFZakX57gpgCxUxgKhWsDfpNZD6RdQHCA/VfwwEkI+TBDLba9KcoIUHCkEqklf6UTptenr+Xt/PQX9qtR8EPur11BNJr2jLlgB/H3CZLKYPKTBKWsEFr82s+ENRr86o0GgJHwsXDt0TMmhWJy+TAofiU8qJuerWwqjDEpibokNtXUQOnETY+IJhaYWn3VipjIzvx4nzuyztAXBD9Mbf22Z9nGqo6/TnKqfZy++N/5q8AeGMrq24um9QgzYsdi69t35wJOZdoEIvd6aoiYCSoOqD8qeCmRFVng+M2AFmdyWMNuHtNGXZNy47k4AZqdjzBlljYst9/dKaTf4PbavkqKFDT54brD6mj0j2kU6rrtWojZ4VjlVyaV24iYxUYBvU/gKwrxbOg=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR06MB4009;6:bjOjoTG2M6EyqOedHlJgioH/p4rR7tokylWjE/uLvnTe3XcUD7FirZ1zJJStX0X5XpAZs8O0hW+S/AzXHSUHIgAYXBKghL+Emqqse8KgU2S+uqsrfDwctj0drq2gumJYiGWa+USbF5/AjRzM2SFTd4rCwwMScgM2Nxmm8iJx87DxC2IYn1Wv9mLaiy3cLvzsXKc2dxGRSwNEXqtBQ93XUV1bQR014MCOvTa4S+QK9ZQ98MbHoyqdC9wY6Y/LQsQApISfaezHzW6O7PumaVHppGiP3z6k/8RZa+tfLRNNKeCN+d0cBlGiQ1c8xcptBlhQ6iUQFC/+nkUpm6YdStGwubXtCnaBzh3XkSUZzdoYlPlzpvY+zPHek4UvOfp6F8r6If8xVldWglY+5Z9SqTu/C8oLFq+DvjnSb1ET/uJLZijrx+Zx3d8Y6XW9kok+Waxumq5ytLpPUjbNMB/rObrxkg==;5:m6hQbTH+rRB+YfOQKlJTZa7prZAecrCuwrkewrXgoSgdnnCyogdiP8X/eF3JjnRa2Cvns/a6L0wG/93w8VV0WcW+PmqvCPGrJaXBZjl40ohYcJJsPhS/Eb2L5mURg5WcJPQ0HZ3HR8Ecs5zjlbXcINjYcPVxl9XTI+qn4B9E7N6hziwX+qyrK+HqX+2CbaJth0chftyrdwoo58JzZPuCXw==;7:CK9VZr41OvTXQuDDeHGzn7fB+rjwuRSCFp4HotY21VHU9G/RCuQLyOeX6ypESJ2lRFfuDPX/k2GMaNPD2d9pl5vkRpBzsb9hZAavGfKoo5iMk0e0kezJ8nuGdR/UybkEYpDtJGutxCKuIYYyWZ4Raw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2019 16:42:02.3321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0895405f-6990-4a31-9f65-08d67fbf5ed4
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB4009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am a bit puzzle about the proper usage these two functions:

void dmaengine_get(void)
struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type)

Looking into the kernel sources dma_find_channel is not used, despite the fact 
that it looks as one of the suggested mechanism to access a DMA engine. So, I 
cannot find a valid example of its usage.

The same for dmaengine_get(). On the other hand, at least this function is 
used in: drivers/video/fbdev/mx3fb.c. But I believe that its usage is wrong 
because it uses: dmaengine_get() + dma_request_channel(), instead of 
dmaengine_get() + dma_find_channel().

Reading the code my understanding is that dmaengine_get() + dma_find_channel() 
should be used for "public" (not private) DMA engine channels.

It's here where things are getting obscure to me. My understanding is that DMA 
channels which are not private can be used by several drivers at the same 
time. In principle they submit all their transfers and the DMA engine will 
process them and then the DMA engine will notify the drivers about their 
completion.

My understanding is also that the dmaengine subsystem assumes that "public" 
channels of the same type are interchangeable.

In my use case I wrote a DMA engine which is specific for a subset of driver, 
and it cannot be used by others (so is sharable among a group of drivers). All 
these drivers, potentially, they can submit their transfers to the DMA engine 
in parallel; but I cannot do it because I'm forced to use 
dma_request_channel() in order to be able to filter the DMA channels, and this 
will make automatically the channel PRIVATE which prevents other drivers to 
use the same channel.

With the current API I do not see alternative for me. I have to use 
dma_request_channel() in order to filter DMA channels. But I am wondering if 
it make sense for you, and if it does, is there a solution today? Or, is it 
possibile to design one?

Thanks (I do not know if this message is clear enough)


