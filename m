Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DA6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C89205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="JhqAO23h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C89205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeH3HbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:31:13 -0400
Received: from mail-bn3nam01on0040.outbound.protection.outlook.com ([104.47.33.40]:59392
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727195AbeH3HbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtBKTYYzkp6PCGMat9RX0bNPWGqoz6nB4wYNHKzX3ws=;
 b=JhqAO23hi0wmG4wBaYHg5No2ejKa/pepOPlAhj1g/bNBGTj7cyM0hXV35LvtGQx0FVhfwIjx1MgcQqP7WjZ2XLGm9kJ92ByuqK7GnQXOOpon4mvPVhSWyI1BYoIKAY2KSJfoM5DynGJ6Kz0nfyIRF9EIDhUD5vqPCay4cbIQHaM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1575.namprd03.prod.outlook.com (2a01:111:e400:526e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Thu, 30 Aug
 2018 03:31:04 +0000
Date:   Thu, 30 Aug 2018 11:27:58 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] net: mvneta: enable NETIF_F_RXCSUM by default
Message-ID: <20180830112745.61502abf@xhacker.debian>
In-Reply-To: <20180829130836.GD1955@lunn.ch>
References: <20180829162456.2bd69796@xhacker.debian>
        <20180829162932.6015e89d@xhacker.debian>
        <20180829130836.GD1955@lunn.ch>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0086.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::26) To BY2PR0301MB1575.namprd03.prod.outlook.com
 (2a01:111:e400:526e::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01dd6ef8-2a88-4e68-e13b-08d60e2904f0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1575;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1575;3:SRjp5CSZrtQs72hS3ovaC9vlY/Frd7BfNbuCo6Kqou2C+mBA//AByV8GBlsnfiBYvwnas7Wz7nzLaMXe3StfmBslDovDWTStUZzBDIK7EAQDr6sW2w2FMT9fZRNOsK0sy0XXi0i8JSJQ1sy/wiTs/KYaTjq58yPXYn3/xhK0/+ZmBRzuQW8We8Vxf3TLB/4Q39mHBglxNhzvyteeNe/EeXmbVNJbSlSdfL35uFEPFp6bxcKHggXxMf/n0RngzEax;25:MFeIUskXW7+m/Mrd0YiETKYr0J22AnOnBsKOgZWasAaOrS5xjkdB1yYJ5q6cdaNTma244wz37yq7eo1NuLlpN8+Vsl5E6VfbqKhXwpjQFrcDo9iWu2u7Dh84Bhskg3iQ+IA7kSMpAYBjkhAJKy+Uzx5FzA2GfLjOp56fcOPfW1TORozEaSnfpf402ibxh132UVXBWbHB1KP6alCyJPdv9Qb77+CyIndPrhamjp6ir3POPMvXaGSzhmb/58FFkxZ2Y20V4aPR68PuQtNgblKiV6xCumvk3MqTPeo17zKd2Yin4HlbOQF4WUOviXgbouc+BmgC6/+g1L42RiTcSpB0AA==;31:yeWeS/+bE2Fk2dGxTdMSGMrE20XbP/J/3SvMzCyENKQ0r62sglKQmON9FBpJkwdyLQPbjmeN7b01glJZ2nfQoQ8/RTBDTG8GmS5VC1MU4tLOsTlmwx+SlLLvMFRNaOtJQE8LHmYXPNrYZB1LmZKjTZ2aIMlr0SiKMoorX0Y0wJF4W8emSt2yHpXKhIbX9F8tn1RzyJtSgOq6mD/WZxqpW9qodpaKrApSTqhPALn7cDA=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1575:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1575;20:i54l1F3HdrIBdsMCwGbHsma/cI6p0zKsGPgqtoX9ZHaxnZNeA09Md+ALlrOu50N+kArPjtaFKj/bjJYW9YkxFhSF6nm2Aclj4pR6QToylFEjBlgLUtfPeUJqUSJZ1QHaqWlZ0cGkL9shjNjbFQFc1OhejsJp6LFTbrh1/GDwZ4Tf9Fi5xRpj7H4mN3rDFcVqPwba++Dw4LWBbijdO6UKaVeSLljEAXAK9+g3pyUymqeD99eZXy1Je0R4gmzmxuPsQu9z9DncXxdgauLrKD5RY0GbsKI+7c8sb19UPtPLs7iDoR3LWCACMImcsu2phtoCo4FMlPtanAT9Awu2GvUAqIql3m54dKkJlhdKei+gez5LwojETq99vf3/9xSrOrMMTnAUwVSXB9/N4CzSpPtPYZLqcasoiTIZ1Q3cMK+j2r4nIyJz1Tnkfk8M0nDDhJrwezXKYP5hRBXNvDj51IjPv8DU4x9IBEnTDnNpFO/YageOj0zK5h07XjPQmn2Afaui;4:kBWJyIAkIlYEPk20sdVsw1YuOiyq0SrZk4v4ZAPFs1INE8cgD7CqAIIl4236i/6IOsiqkqG1faQcaNwUm5jckSdICg7XpXVe+DCaw04MpSeOR3jFqz8cQuaopHKM8022M/+vGH5y4GQUgfZxC7+vBWOtONPSBTtHdDUrbJ1uaW8JZMs3sKJcVRDlIlGun/hnjlRPizlrS/EU/5QgklTM9a7TFfoyaLZXt6qvDOm/cxaFk/SLe+N5PSBVAYFqlh1TG7bB4SWRYqSC+79MMopcBghTGhT7NFsJF4EonZZV0GhfSrikG+ltx3ymcjACfO0J
X-Microsoft-Antispam-PRVS: <BY2PR0301MB1575E4FEC0596A92770B75BDED080@BY2PR0301MB1575.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(258649278758335);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:BY2PR0301MB1575;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1575;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(50466002)(47776003)(25786009)(3846002)(6116002)(11346002)(476003)(229853002)(1076002)(23726003)(66066001)(33896004)(76176011)(52116002)(7696005)(446003)(316002)(956004)(8936002)(81156014)(6666003)(81166006)(230700001)(1720100001)(50226002)(386003)(6916009)(16526019)(186003)(8676002)(26005)(68736007)(97736004)(6306002)(6506007)(55016002)(2906002)(106356001)(105586002)(9686003)(72206003)(478600001)(53936002)(5660300001)(86362001)(4326008)(6246003)(54906003)(486006)(7736002)(305945005)(966005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1575;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1575;23:lQL1uyefCTM0CveBGgcVhcnHmgd5XFkJhgeWpaB?=
 =?us-ascii?Q?s1lTzF2C00CECmXUigcnIeei9JJcOuJcwtx1hyF0+UvT0BL3kFb3+sd/TVmX?=
 =?us-ascii?Q?/siCHATz/DarGrix3z7AADb/r4ndz+kUyYtvDAAxBhBFJ/ZpNxCRU3agyvFP?=
 =?us-ascii?Q?TDNCNWXiGWUwBIqCMc6jBWBGwbogoaj2hOM7P1WQ3kAsz8iHOFOpR4//n/i6?=
 =?us-ascii?Q?Wnfo9ynKIJ8xiEWvG0n2xuZLETQJRgQVu8B5TW1D0WQAeP/EglppwS9SHR/H?=
 =?us-ascii?Q?W47WWEB+8PuMX/aGMTjCaD1BEpLAkil6NMFkgMmC7ocKI2zpseImX5LUiTTN?=
 =?us-ascii?Q?dQT9teUc5wMeAokq1I2AkjmCd5tCl8gBsI+roGur0vgoxeLY+vR5K4pqR4So?=
 =?us-ascii?Q?1wNMvalhu9yw8UydmQPdyOL/twEl57Xeplo03Rxft9Kq99kO/hPZFHWwzJ7b?=
 =?us-ascii?Q?Gr1VcJVvv6OzK3X4kS64rMIm96iUIhV+9M5reEh3bQ4Eum6m4l2UHN1HS6oE?=
 =?us-ascii?Q?i2zF8kEjorNslATRmrwqXhQ2TKXnADMGbFWvyufNMiy0BVp4hLrRkljYr0DG?=
 =?us-ascii?Q?dlkAfwQFiJiVsYKzvy6kzL2PdLc4d5IezqR5yDYseEg8C6T7CMTnvMLBZihM?=
 =?us-ascii?Q?At7cDCp+Hr/7nnv8gfwgX8jWrJ+IKy6qBqMdGUutPB7GhIxYVAW81SDbmJ2R?=
 =?us-ascii?Q?V7CtteOj8GkhqxE3pKW5weHgFtVOzWPcw2PQQlUum+R76lFFcisMj1s2TXWR?=
 =?us-ascii?Q?EPXHxhSBlfmr8iKkO3ppsUXyraURZEPHS71118w54BAWKZTAMCpd7iMx7i9e?=
 =?us-ascii?Q?Ei+EpDfE5HMmcpR5tEUlqsaepjTthLbUUOWwHeBQnhUOWcpAhOsup+Bqv9yd?=
 =?us-ascii?Q?hOxsZ0ZRBqFsyovLfBndvq+OQ1PfKHI52pn6zP/8a0xfjFiTT2bFEuKzUboM?=
 =?us-ascii?Q?HPmta7HQzXwvNH2hVaKUdgFKllrFxpdYA7enTi7GFlK9E0Y5092nvhlbLnP2?=
 =?us-ascii?Q?psGcKvv2/R6OQiFg5xmuZDnaQJhudFxF8KIXyRLsVBhsoegZwnkfKGYHzsfZ?=
 =?us-ascii?Q?+XR2G6kfozVwLjh77jEDHmvoHAG/vb1qsAxrL9maLMrjLj9RyEeuDy08bIlv?=
 =?us-ascii?Q?KhXC2Po7E4eaiqC/5T53G5DsrC7JBULPxSECXlkF+EFyild6QWa4XAJ4drgA?=
 =?us-ascii?Q?hmGXTUVEPgxRuiDptu1VkqqhVSUhbM/Ba5qw931zR/qML7BCBgP+dVaFrkje?=
 =?us-ascii?Q?8mKGHDA40RsHqI//80Yn/g3lbmdkKvQdTbS7XEvwc/ZYdMFTm6Ray9ePOZZo?=
 =?us-ascii?Q?V7D01eLYn3vxPMPGrofNlh+k9fUuDpXFRAYnDelZXCdyd?=
X-Microsoft-Antispam-Message-Info: XARgRi8PgFdDW/y0IB/C22knobaLDkLLUKA/Sp+8+iCoyXIvGUV2zpBeKJNXIxR9PO55ingVDee3cOdl1KZHy+0+LWZJV6UiXtYhYwHLMmRr9nUqm3WFPPef+NCNbclmRh3Ezih/TndNtWH87uFm94dse2l5L5BUPgY9HGgMztkiIZl7TLRFx+GCsVOStUeC9ALp1O2ERfR8n4sJv7k2qq3GDZvCs3ogi6nKMxTrahjenV/egZCqwX63iCvL3ZAjKaIRJ9RRKYM2/BBx1FWQgK5qJ4KTAW8YKkrijuoG9zcY6kD902JK/lrzEC0ey9zSM4xK/BzwOej7fcsoSTTFCUem717YN7xd5prPd596rJw=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1575;6:JR6KW5W9LIEVhhPmEXiYTq+MCRe1wnZHSsNEuIN0kdlAw8wYePZAL7HMgSIZ1salt/f1S77pjxlOPK5+nLQOZM+SnULkmPU73pEE6hhyPMU6hCKFwplgJ/3C6xaPNAt9rEo5z5I+UpEv2se5M0IDTY8tqwaAjFrun1A1cOoOu1bnMi73kehenjdIx1et4U13ZCLEXnXNcZ9InIDCKnpi0lO6bRU3OBwFaLzSktcF4Jag3ksfWAM8q/KvmsHj7wxiycidDnM/GYTDfpzHnF+Xl31g28xJPi5qxzJzNsvz/yZPwQNosY76F2c5FvKYmZxhGx/0xN9Y3WPKDQQ36K3+hc0Zbvp38zdN3CGBtMm1n1zYSEK/CAtGzb8OVCli7q41LI79Kf5YK3q6lPrSpdvQwLcd99tTITctM5VsGSel8xn1BRjQF5jf5jSp592QZ7m5bE7b6j6txj8r+/wMUhCpTg==;5:m3Wja1iP/mVnAM/ppzSf9ALLkYlRrJbUAWB/I2q1Fbck1LUw5gt1INzOVST8lFWi318gDP46DLkCBb/cHQFaRiZ9SDPD/P3drZC+9h/b7VG2b8LWNKsIXMzqa3M+esBaUVrV9dhotmuUcLeSKKKgFGNoU/RE4gAZZUhEnqE9a8Y=;7:0Mf2Rlnnh92AlDKV/0VbjSMvYjYOSyThXorOKkbMC5bbOonTx3lpwTynwIceH/+0h3TrIK0uMPHDyAbZoLxN7sm6n6qiTeZNyazunmaGrLxvWkMSx8ETXqm+W0gFUvmqKOaQLjUMHwE+OeFAkrM4V+gHT0aVqGlPhhUZyspNPpP3TmjcvtQqJn9c7JHeUtToUW+6m0c7eD/UyCLjLCBbo25NClKDb2RaOcIO1ZG0hpclToIDf5CEASbR9hglPWEo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 03:31:04.1573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01dd6ef8-2a88-4e68-e13b-08d60e2904f0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, 29 Aug 2018 15:08:36 +0200 Andrew Lunn wrote:

> On Wed, Aug 29, 2018 at 04:29:32PM +0800, Jisheng Zhang wrote:
> > The code and HW supports NETIF_F_RXCSUM, so let's enable it by default.  
> 
> Hi Jisheng
> 
> I've never studied what all these different flags mean. Does
> NETIF_F_RXCSUM mean Ethernet FCS? Or does it also include IPv4, IPv6,
> UDP, TCP... checksums?

Per my understanding, it means RX checksumming. And it only supports IPv4
RX checksum, the code will

> 
> I've seen network interfaces get checksum'ing wrong when used with an
> Ethernet switch with DSA. The extra header DSA uses means the hardware
> cannot parse the packet correctly, and so cannot find these headers.

The network interface is mvneta? Do you mean after this patch, we would
see errors as the following?

"bad rx status 0xabcdefgh (crc error)"

So for DSA, we should disable RXCSUM? I'm not sure how to handle this case.
I believe other drivers(with RXCSUM enabled by deafult) also have this problem
with DSA.

Thanks

> 
> If this is just for FCS, then it is not a problem.
> 
>    Thanks
> 	Andrew
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

