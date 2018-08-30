Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC011C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF5220666
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="mB+vGZYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF5220666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeH3HqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:46:09 -0400
Received: from mail-bl2nam02on0077.outbound.protection.outlook.com ([104.47.38.77]:53888
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727438AbeH3HqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IytP99lifDv2P7s6J8wQWrTPsDsqLlRRnozsn6nitpk=;
 b=mB+vGZYezjok/Tu3EwZ+7LKQIwR+okI2HsbZ6AYN1PDnvhQ3xd/0lZC0+WWfjK2YGeJawCs7Rqhw8Ng1vBKC4yugfydO+N4IATuKmvNI4+tRqo2j2NyeAoXe4fLvHXgjGqIZGMaPxFrZvCGhb3SCwNZD39+ADTGKYr3wl/N0tgA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1577.namprd03.prod.outlook.com (2a01:111:e400:529c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Thu, 30 Aug
 2018 03:45:54 +0000
Date:   Thu, 30 Aug 2018 11:42:46 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     thomas.petazzoni@bootlin.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] net: mvneta: some bug fix and trivial improvement
Message-ID: <20180830114246.044ffaba@xhacker.debian>
In-Reply-To: <20180829131232.GE1955@lunn.ch>
References: <20180829162456.2bd69796@xhacker.debian>
        <20180829131232.GE1955@lunn.ch>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0160.jpnprd01.prod.outlook.com (2603:1096:402::12)
 To CY1PR0301MB1577.namprd03.prod.outlook.com (2a01:111:e400:529c::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1b8ae1c-e8b1-4571-763c-08d60e2b180a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1577;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1577;3:2JyRImIII0PvKfie6J1H7ncuyr9hXRGIvSrxKp8hP3eOPd8rs3+mCE2crT3rOPcsmQNTb2UYhcpJ3dzlOfdH+HJBT79CBQotMmGHlRaoi7wDEAl/IhjnqrjvY9wDuSlTm65PNTPmvRtxTC3KdLxpxibJ0rEYuWRczfkkHr6c5SdQC4qYKBDkcHlXrQMI8jIOr980gBTF4CLusO0ZcOvCVEs2Mq7+NxpABkqSFUcky8fS/wafyhw2R76inBl5dWAO;25:lq3i2Qwt/q6Ua1fP1H9iGULuTSmyRkiAp6/H5/Tbqzwp56EkXdo4yYe64nC4gM7VVRqf+UtFDhkeQdyts9lEYdSc+v7NN3qTO071sCOBTrptLv5EhflMjXhLgvS/xVD33+VTQL1xkS5ppvx0Q0ODLoQqe/o0oZT8tjfUWydHwLzoYTw1VNtE6zfx2TYvZJjCKvAx0rGvSI/aQU9vtnN2kmkRyQpo4sWyHHl+ZMalKaL91acemLH2cnGuisKq2QJB5F58JRPUnxzxFNMN3i8PuxQUdyctsart5P8YAHjGPu013PTcs1fnbYqpY+84S0kJBrr4EKuW3lkoqa9Dk05SLw==;31:n3WqKVtHhYpOr+e1pDfO2zoYAo4ieemyD0rJuo54z0pgp3jo7w+ccHl5B+fwe4D4rejYtfpq0RDC3Gp3cu/BG4xWRwqgzoKIHOZMh/b3dN3F2dJ3OanNaBteD77RVGuxGQ/hiEpyweO6mAHMABX4TpC1mcWptT9zGTb1uX010haYvXDcDhVGzmrjfKSNIcWxQiGn52dQSJB3cHY3a3SYuonHPf5YFl3ro44w1mcIjus=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1577:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1577;20:mRPgWsGlUOQ0b3P7OdSoeWJz+x/S1YPIOfHiSuHfJI6fW79lW+pMi6DCVc8EuWCLVL/GqcKOsVIpGUPpOdy32OeZk7A33FyE+HHT+YiiAafuO3rFKUo0akzMkxVt9yYE+JPQq1PbGWGD8ISuQzSkU+q1Xv6Szyq4XRSTUf4fJ8WOWwUCb+AydgDvM6cLEInQgbuPT2RwEQE0hKSv3BLR42TIL2XuAVSpa4m6QeKC+OqJChF3MrbobPJ/I41kas9D4Jh8eJ19UvibRjASMwsVYaCo4bPUtdZVhwKsdCMO8fIUrP33vZJw1EAujoNin+9eL9INlrS+r1gukulyscFMbSIsHd5zHne22DuV32+Txf+aJ19iv80Hm7BusXOaasmtWlGptwS55TvTRT49FGxpKYc454ll5Zzm7uJY153pyVTheL7KS1UzbHVE0ip9zpAKn3OQvjcaoG2l9GBvSFtBwntbvTjxxL3BICdMmUy6zGpkhN90RrDprS/VHG5FeK3e;4:LO/lOwNTnf+TF1nf6oAysn/UTsF9V9jqGYbXnemVqdSeY8t+5INa/CFxp81AREsVsE6R+0c7bV8sm36hk2eId3K63G+w5z3YmRaXQhyptOSXuh/eJJMWXhfrYOZuxgn2IJtJONtrVgmYQryCTtmhnFQybSpnCudSv5pBQEA/8Y4TteXCEnAaG14reSYSO7dRDyGmf2QLySvaNwMmVZ4YnHKOLsgp72nEQjVSYVTSiCr2ha8oxNgW0SiRDcAt2Vn1feKV3eiBOcE6KqB6JlRQPQ==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB15775F755E7EDDC0C58215E5ED080@CY1PR0301MB1577.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:CY1PR0301MB1577;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1577;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(6116002)(6666003)(97736004)(68736007)(26005)(5660300001)(47776003)(3846002)(55016002)(9686003)(53936002)(7696005)(33896004)(52116002)(66066001)(23726003)(1076002)(76176011)(86362001)(186003)(16526019)(11346002)(956004)(476003)(486006)(2906002)(25786009)(105586002)(81156014)(72206003)(4326008)(8676002)(230700001)(8936002)(106356001)(50226002)(81166006)(446003)(7736002)(6246003)(50466002)(6506007)(386003)(6916009)(54906003)(316002)(229853002)(478600001)(305945005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1577;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1577;23:gGU+UT55dsIIb/31wQRDwcKWWM4Iux+vFHI6efB?=
 =?us-ascii?Q?KngB+tozPolKVfVp6lL2278UIbxEic81JpZBZ8Dk+T/UFsVlt7CFDzCtIeTe?=
 =?us-ascii?Q?2kb0o0oLteM4O6tr19/TaR2fhnjd5LaJ75Dr5yg7YntRXMCIPTd+E1mlIgHb?=
 =?us-ascii?Q?w8WIl3ekYUEjDrjGznqiVIOEf0ZDydNGw+IgzYfQrMA7sb7alUexIuL4K/zF?=
 =?us-ascii?Q?6nazq+QsWe+7JnEf10ovxBj57BahTUmtyZHz4CBsw+kfvIfyoMaoXd+XFZte?=
 =?us-ascii?Q?+7jF0q6tPok7N5cCKYynXCr1VIchHyolcT2d6emOKmhy0AyuF1vp/qnSkdXq?=
 =?us-ascii?Q?AfnnAKSoNGJVm2fnygMyNJMv5EP/4wxz0OXCYZaLVEn7rGLbdIdkUqbXwDKE?=
 =?us-ascii?Q?GhYw632oe/kx2vfBBO6zDU6NP4DlTeFIirD7Ib4IFQribFfao/jinWViLDuA?=
 =?us-ascii?Q?bojk2ref68iFsFjDlFS7vPyzeflmrspEnl8/V6SU0c5HksFRjLTrHN+eXLE6?=
 =?us-ascii?Q?W9pbri81nl5cdFqPvBg307MQpG3EI9PSd8H+rmtTnkiR05FNucAlQzW3XHDa?=
 =?us-ascii?Q?t1cxiP02wDEEu1KwOrRJSAfiP9HUBvTWSBnoBvtXVNk0pX7/bDT5zNXR5WLC?=
 =?us-ascii?Q?Vfdg7s8YePouO8iCSro+jMx84jmEJOLJAmu+Gcoc52uC/9YRMGJHujz1bFkV?=
 =?us-ascii?Q?p1J3ca91r9V/8XQszoTfRfAZ2kkmvvhN7u89xEi9ONPzDj5dAGLs/OcJuNN/?=
 =?us-ascii?Q?/wwp3NMUMDQVu+uM7FKQFtVIDbgh4GeW8cRc/j/vUZShlHlOGWY8O51uMnv9?=
 =?us-ascii?Q?1r+SBCm5YkI+/lxtM64y5rHNFCH9dDifnHvGZ+NWZl4sTgTqEQpaVItbQHQx?=
 =?us-ascii?Q?j1WZUuBeR9ncqGcwOtm3duTxh9RZJw2I0+SSB0eJguYxVuJTlI+ke5Xckklc?=
 =?us-ascii?Q?1gVAcRBMhvDLnGPsdaWAlTppJuYLkM+x3JP71Y4HDcRn9LvrVMjqY9caEZlZ?=
 =?us-ascii?Q?l1F/17Vi6inFy8+9PywQ/8bwTrkNNpXOp7HAdpBUa0HMqvqc8C1BXVvWcLRM?=
 =?us-ascii?Q?sVsajzH7V9fnqL0Yb8WpJss2j0iypmFdmyiurdzhrJJAHPtwJCmOdTonZEqq?=
 =?us-ascii?Q?iQX5mIJgSl2ML2DSGcU9qdTz1HvRVOdRdqVmM8BWt/fuaa0gr5aPmQz+glxJ?=
 =?us-ascii?Q?oCXCmPupYhGjkv++QbU64FpeP12dnd5KUzttT1M3pIv6TKPzl3U02azl8l1w?=
 =?us-ascii?Q?mpq3kv8xKiOWQWU/syDY4ENARYXGRjqy4g5sRHsmc?=
X-Microsoft-Antispam-Message-Info: /Dl/ae+fngYSyI0cZujsl3RqOALFyQIF30hyHGzytcUPOfD4ECU4LMXwN8IBt02RbKDeqd0g8sUyNk6rB91EoNsN+maY/5iCskfKjJB5sEtxBJqPv5JL/vxsQhaW+lEA5qHbZVep3kmkbTutNSuuRhss69tqC9q8H2hEfM/xoKnuZm5sAUvPsbju+AwzO7HMsynRZbg9jkvAmqpSns5+oXIUriUgWkma2A5nMNEnrBm+YQAaZgZkSf4MEiOI+WcRNE0tvgtu2w1nVOpUcsw/dyEiDnWbwvixgzhrXkiAyl4xcC/dLURmY55RlKIWXAgWJRLqEZi4aOVjmjDo6tjsad39qiHkvQ/JLmYMd8hhH1w=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1577;6:lrI0JXJslbPBCj/2hVDdBcyXXVBnHw/GmJ4sTJm+IKRRcFN7TV3tjJK1UqbAcd3nb7+hJAGdVObnawpynZEc36I1TeiC39iV1Wd0ribSgwNA8wFz0UHcd+qh8GktPkqSdLwfd4/PLUq5ZSrQOmnQSIybcdrd2gfyQrxxmz0viHFk8dxjKa56dml+VQVCzIih1UBolKhaI040dzQL+rWppnp2Y1PacCA/S5Z/6/qBilVBUqCWIOvcW5b0MTYerNQPVoQr/TNt/6C9f3n8ExLMVJAJ0TMMg5kO0cSvGD6dxliumTHzpq4sWkpXRGTgINsZZONOSlTOO3ep/+1tEsZNSN9Hxi2f+OPjwzRS6pEDv3xKgWVmvPRFBlMTv8HWQ1thDT5UD/nqj80OPs7eg/2QGH9iDANJew2btS62m36ON6mLYMhsLVsoIIJBsWoiaAb+/zsaqqzL5D1R700g7x+xDw==;5:mQAGe33N8pClur5nbYIaa3XHTKt3jshggOieMlPxtE39fWRa5bYPQR/32Mcg1F6828ucOeApnAipwDD4G1Ng6VLf3iqr/7KMaJEaKSfA2uzwBciLjdWyT0MjsQMHHnyJk2z/7hKt0c10TdB30/a955um+myVbm+LX/XNr1Qk/R0=;7:gei4CVOmQA674i0qByBi7tZtBxjLFLI+0ET6hXUZfWsHYe/xMOvaEJhsTIKOsyYLVPOseM1/lzV8DWidHnYTOYOFO/7dQIwpEGkon6Ebs2Xz3EclxCm1ONsEASWqepfm8QZxXckeb8VN78bL6VCUHXYKRDs5RA4wJWfYVEXuzJqGFdW6lR4LAHYyXCC42uZ54vUMgJgNAqBoHNX8/Zv7Y8uOTEH2Zp2vJL5Wrj7IlffBOOaulO4Sm32HndM7yf2A
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 03:45:54.7837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b8ae1c-e8b1-4571-763c-08d60e2b180a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 15:12:32 +0200 Andrew Lunn wrote:

> Hi Jisheng
> 
> Please separate fixes from new features.
> 
> Fixes should be based on DaveM net branch, and use the subject line
> [PATCH net]...
> 
> New features should be based on DaveM net-next branch, and use the
> subject line [PATCH net-next]...

Got it. Thanks for information.
