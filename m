Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1983C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B510222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="h4qOSIzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfBKNsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:48:07 -0500
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:6272
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727223AbfBKNsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBjC8rkjWTBH/UQvY4t/FG2ykzOKkflnI1WmfhEBrqE=;
 b=h4qOSIzZhTVdFQEqkqxnygO1w/C0u2Hx5P8xYtGUMuitmm34MXNv99ib4h/ez1iIY/LM/1y3JCtOm4MCErH/sASCkRi6ySMJQmO2uOWLffHrb4PcwO0Et+0zV7TYvC7Fj2xULW1Be5n/TaQN4c/DSnyeijU11h0ggq2LwTZtJ80=
Received: from AM5PR0602CA0007.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::17) by HE1PR0601MB2153.eurprd06.prod.outlook.com
 (2603:10a6:3:29::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Mon, 11 Feb
 2019 13:48:02 +0000
Received: from HE1EUR02FT060.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::207) by AM5PR0602CA0007.outlook.office365.com
 (2603:10a6:203:a3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Mon, 11 Feb 2019 13:48:02 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; the-dreams.de; dkim=none (message not signed)
 header.d=none;the-dreams.de; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 HE1EUR02FT060.mail.protection.outlook.com (10.152.11.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 13:48:02 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 14:47:47 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Mon, 11 Feb 2019 14:47:46 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Wolfram Sang <wsa@the-dreams.de>
Reply-To: <federico.vaga@cern.ch>
CC:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] i2c:ocores: add polling interface
Date:   Mon, 11 Feb 2019 14:47:47 +0100
Message-ID: <2252068.1XvXk90vR3@pcbe13614>
In-Reply-To: <20190211102526.3y46r43usznu4jgp@ninjato>
References: <20190211083122.32485-1-federico.vaga@cern.ch> <20190211083122.32485-4-federico.vaga@cern.ch> <20190211102526.3y46r43usznu4jgp@ninjato>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39860400002)(346002)(2980300002)(199004)(189003)(8676002)(9576002)(7636002)(33716001)(33896004)(8936002)(47776003)(305945005)(46406003)(246002)(230700001)(76176011)(6916009)(7736002)(74482002)(316002)(106002)(786003)(106466001)(54906003)(2906002)(4326008)(9686003)(186003)(43066004)(3450700001)(446003)(50466002)(97756001)(11346002)(426003)(44832011)(478600001)(86362001)(126002)(476003)(16526019)(23726003)(6246003)(336012)(6116002)(26005)(229853002)(14444005)(53546011)(356004)(486006)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0601MB2153;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b9ce413-ffe8-499d-2814-08d690278aa4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0601MB2153;
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2153:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0601MB2153;20:jUilYrxWuAug/2S2W+cwZwa5VQPFveDtC6YD1aMkS266HRsEljb7VGyHBYeF8aobmPjrIzXzPrW/uLLbIV7P/vIt+6CAg9jNrWKxXibEBVk0lXOFG0mznR8IsFxKFaifctPAeLIvbx629md56FVPuYkVNaku3z5UpgDh8tD6R2DUiE4nP3B0AU5JSxBDh7OmW1GhZ2hNoySjprrs3YWF2W4FCHgBAqyxa/OOWgkaE9H/jZ+3WAHAKhJqPT1rWHvJFf+C3aYgPld8tALEmnZ3d3L44hZOb5dJxQbsLtqDHC0PUEEKszjtFTZpR5TK2upAOLlK3DIy8tFcktEJnRgg1pytuzAFSad0dyeksqYN5zwzL0d6ALS52sy5/VOu42V7+/bMKCA7ugl+drZjYxleP7wzRw1gM+yPkwx/BGOjnME2wrUJXlUfk2jiCb4aAX/I5wXsyE2c1Nlamb5WKlycMdXeD6AXjlULYRbmA4Rv+uRPdVZ+JvUEwes/OlISS9Wv;4:FZcERuG2EmbO8fI5XXLcj/2jwsgc8XIcs9L527XaSRzY2KpHH0NbQ0aZ9JlIGpvJSDyN1Au1ssDmni9m91DJuHN9svzFWRQwaa7GP1LsV9+esuDw399df7haUGGUNeQRnTszG5yv1KXhqE5mFA5DOQN+bufjInd0OqSBNyzxeVLhjCxN7kwxSg0He1FUrbMQgFwTAJFduC5nmlujjxqUWELRu9jBUwq+2wAL7cRBiWVGCBvsPvKo7dP5Z8xvNiSDpC7CPx+uE2pQCbhRn++O6N9Cie2JgdoZu0fNmQ5Lsi/QSKyq+rLjThk2myXv4WR2
X-Microsoft-Antispam-PRVS: <HE1PR0601MB2153B8AF16772BC1B7896495EF640@HE1PR0601MB2153.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0601MB2153;23:JRca4a9mCiDCL0RgE/JxZ8etr7phO2hovKPVxrT?=
 =?us-ascii?Q?Od0X/VN74+T0gAhVKGa4P09zTmb4rTgIIgo0PApQxqS8aOTVbC8QcYPJ7OKH?=
 =?us-ascii?Q?VNSVR9HnSonW4fw5FRgmhT7gMGJcxNOyl63Ll6vyhWbzhoS4qR93TD9I0que?=
 =?us-ascii?Q?WRd0Ah6LPwrjjVYvK5cB3yLvsuJswdEqiBuWF/r+L2tIUkOgwQbG1IgbYHmf?=
 =?us-ascii?Q?eks1F1t2McVK1zSud+BEEpTxxEyH22N5S1yhX6t48uQCkFuae6vjbWQxBUUz?=
 =?us-ascii?Q?iClhJBEnJvgdmZemnEfpwdbvhEsY4ziINST2zSuVTYfP6+IY2oS9rI9nlwuR?=
 =?us-ascii?Q?ic1YRDgNrSAcnQstA4foquVrV0Zq6DHADt2D8676J9TafHhLg8nPktvJEtId?=
 =?us-ascii?Q?ggnmD3FHGkELKsXgTYDgo9bld655S9ljd62CrUUmrDyd59ogiRCjTb5wZm+/?=
 =?us-ascii?Q?aOAQSCkHMF7JG1ZyhInn8KpfHJO8uvMs/HJwfV2zfLqzLmJWCGQvm2HXCmfn?=
 =?us-ascii?Q?H6RtnjsT8eYsMNaGwa6oxE/h5dNmCVuzO2t7K4+Eep1n852IRziLH8IJSCCN?=
 =?us-ascii?Q?MZ8nMFcqIWZevXMSuVBk2cSVpKHz279q+gF46VR4wAhF5mzoq5iss/gE/+VW?=
 =?us-ascii?Q?WUkN0PNNt2fdIvR75eNzlnyC40MH9aOATG7KvMnYNw86Cgh3wTM9l7j4GjEy?=
 =?us-ascii?Q?/6VFLFf6ZwnOiDKkY6cpl+GkYHYv5Yc2ftEXFUt8ncUzwkkiZyizkmMaT45w?=
 =?us-ascii?Q?+k7UPx7ByKaQk74fZnGvHZDIzeehLf59tiJxkDE/dQ++9MMEauxLhE2U68ID?=
 =?us-ascii?Q?CQke573m1zOsn1AAMNR0bevq2rsIp8tYdZz6I9wksu2Zd+b3ODPiugpM/U8U?=
 =?us-ascii?Q?Z85ABDY/eHRQWTKWapnqBV5SnX6WI1qQ1yrHMTLNWcfKhj0zAg7aAVn6j/1F?=
 =?us-ascii?Q?hX+eSaXUQI2f2E5Nimd0YLgpv5xPuqTGvPjNkJ+d0Y7YyGgsQG4hSEYJLz4B?=
 =?us-ascii?Q?FAjhXlKnpPMv2nRNuc8V1Vil0m2NI9Nbz1ajHGxPRtb1FyfdxH8dwdmyeDgW?=
 =?us-ascii?Q?zpXKjEsTfhbkCWWcGn+GYoVyfRLfg1mIVEwnf5aD9MF06QN9bvlhQohL7wLq?=
 =?us-ascii?Q?wTQpNx3zLBc6Zb1yUWm7A3Ybd3VhnksDoxPsyLwWXwmgQFJRfsPI+27+eBVx?=
 =?us-ascii?Q?OmW1kc00Qm1lreEMNijr7A5GE5OLOY3NllGc7DbHhPfGOZ8ZWODSHaNkTYQ?=
 =?us-ascii?Q?=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: fTPlX1j1VAASLpSCGzHdc/BWNrLjWFz3wMhhrAcEcCHssCF3uooTxpZNAEz0jfkYuZNBiA98UFYcph1K4zfLwnnedXOH+CwPEiOqXh2yyVwRPskLgrjt5AKByfClUg/nOCqIjYkaCUQ10EqhL5+EhB7UCa6EUGfQTKIK6tSSnN9vtR+DccGuCE+ieP5FQ/uHGs7gB4HV0u+lfgwYso+u5QV9e4H+7NDZWkbPuY0DQp/S0QX0tdgZQcfgBN+zVBM68F6Alk7ppg9JytVyTIH107LN1KwZ9acWLo1g6YzmPb4543Mkytb6Uykoop1Fc9fo9tNYjdRh6Y843y3rwmaztTRjxLw7cfM4vslX9wqK1nwlQnHVX0UwRg/dlPmvD35+iqySPFK8AofoO0IXGweuGR7xxfZFsyvOH8GMF/eg0F0=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0601MB2153;6:ODxnuOSnCqn8zBuTbgsagdYw/pHkluBKOZ4BbMi3dE2B84blj1NERzyCTL/Aui16M5gjZ5wNalUYH9B/SdKGdlFPEi3ZlGR7XHgU+9YDj5UA8jbNSNj+icWA0Wg0KRLFXUq4AqGkXSbMjCEm66+84/WJLTrzLfzxzGrN4wgIAAql0ayrGao9vRLirGoyVFgSg6tBfNCs8YBHP5iEUiSTKctyaSCQpOA+EG/+Z11eWYEWgRPAe/rpQ7oD9bPPQ1RgRC4a+4jJsS4ffCBRwd2PRQCBTlxx/MzuvWALiAQE04Z6hnvHCJDGLIfTVlKhDbN3Ef1xBD5VHiaNblwzOowmV/H2HzrruUPqinpxiwSWvk5MEp4uz/b2BBrRgEdVbNlw103cYuI2fTT1SlG8vXb3lpiKWaCr2M9+v1KeP8rgdvVTbfPVYOUwPkHfxptPZemrm708RjNjnYgdeVejvqtUmQ==;5:DtjKyH+YGVvZPvKaeVKtGh62AdqjWTrruowE5fCX81fHPOvZ1IukmpLeY7zYVkXmcbaMUKjeZeN7IAusC614rq650XTnPbWnUaZz8lJLsvjnYONmtsVVJlnIxNmBzlI518zu/wxTzDjbQc6512PTMpG7pZUVHhv4Ns1aH6QjZv2eT5+yHBEd/PnKmZt5UINh2XcdHimbTCkSOzU+awfdvA==;7:v5mItvXCPNEQaKPHgTCg34UUhN8SPC3dl4qbslIab4SEKsP2R/R83k1mdzJxPXzkNnms+2iNyczaD+ffVdqyCzwU6GYwsfl855p6HbS+fXh23Hg1NmvUQQv6Jr5j5hyWL0x5EGyPa1k0Io277ZyLWw==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 13:48:02.0539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9ce413-ffe8-499d-2814-08d690278aa4
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 11, 2019 11:25:26 AM CET Wolfram Sang wrote:
> On Mon, Feb 11, 2019 at 09:31:20AM +0100, Federico Vaga wrote:
> > This driver assumes that an interrupt line is always available for
> > the I2C master. This is not always the case and this patch adds support
> > for a polling version.
> > 
> > Report from Andrew Lunn:
> >   I did some timing tests for this. On my box, we request a udelay of
> >   80uS. The kernel actually delays for about 79uS. We then spin in
> >   ocores_wait() for an additional 10-11uS, which is 3 to 4 iterations.
> >   
> >   There are actually 9 bits on the wire, not 8, since there is an
> >   ACK/NACK bit after the actual data transfer. So i changed the delay to
> >   (9 * 1000) / i2c->bus_clock_khz. That resulted in ocores_wait() mostly
> >   not looping at all. But for reading an 4K AT24 EEPROM, it increased
> >   the read time by 10ms, from 424ms to 434ms. So we should probably keep
> >   with 8.
> > 
> > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> > Tested-by: Andrew Lunn <andrew@lunn.ch>
> 
> Fixed these checkpatch warnings:
> 
> WARNING: 'transfered' may be misspelled - perhaps 'transferred'?
> #111: FILE: drivers/i2c/busses/i2c-ocores.c:306:
> +		 * We wait for the data to be transfered (8bit),
> 
> CHECK: Please don't use multiple blank lines
> #129: FILE: drivers/i2c/busses/i2c-ocores.c:324:
> +
> +
> 
> WARNING: 'transfered' may be misspelled - perhaps 'transferred'?
> #154: FILE: drivers/i2c/busses/i2c-ocores.c:349:
> +			break; /* all messages have been transfered */
> 
> and applied to for-next, thanks!

I will resend this patch as v5 to add the fix suggested by Peter Rosin



