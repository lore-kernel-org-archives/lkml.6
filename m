Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9599EC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434C220657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="MTzhTkOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434C220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeJ2XQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:16:52 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:6667
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbeJ2XQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=om22OWHljtCipSrTK6imvEYZlkjWqbA+NvRH/il5wnE=;
 b=MTzhTkOcKkOg38yRtrL17gffs+IfVQrwzGFAqcAGdMPSDljs7/+EKT78K/Se93qU081H/MUf4WjA+i6kcefoBuZGWPhBnfP8aTY6RVCv1hFm/ilFbycSB2wVLwFErvIrqaoM3bpTVHotLe01RGFsGv5AtFfroaKxRkB3SnaOGyk=
Received: from VI1PR0601CA0025.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::35) by AMSPR06MB519.eurprd06.prod.outlook.com
 (2a01:111:e400:8033::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.22; Mon, 29 Oct
 2018 14:27:55 +0000
Received: from AM5EUR02FT050.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::205) by VI1PR0601CA0025.outlook.office365.com
 (2603:10a6:800:1e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.18 via Frontend
 Transport; Mon, 29 Oct 2018 14:27:54 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; the-dreams.de; dkim=none (message not signed)
 header.d=none;the-dreams.de; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 AM5EUR02FT050.mail.protection.outlook.com (10.152.9.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.14 via Frontend Transport; Mon, 29 Oct 2018 14:27:54 +0000
Received: from cernfe04.cern.ch (188.184.36.41) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 29 Oct
 2018 15:27:44 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Mon, 29 Oct 2018 15:27:43 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Wolfram Sang <wsa@the-dreams.de>
Reply-To: <federico.vaga@cern.ch>
CC:     Peter Korsgaard <jacmet@sunsite.dk>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] i2c:ocores: do not handle IRQ if IF is not set
Date:   Mon, 29 Oct 2018 15:27:43 +0100
Message-ID: <1607303.K3FPNFt9tg@pcbe13614>
In-Reply-To: <20181029085259.GA4101@kunai>
References: <20180625161303.7991-1-federico.vaga@cern.ch> <CACXmViZZ3SBPbV4AXK6EsJPfD5TJqEU_-Q36+vz5LxTk_pzq4A@mail.gmail.com> <20181029085259.GA4101@kunai>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:AMSPR06MB519;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d96f4f16-e5c4-4ee5-8a32-08d63daab74d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(5565046)(2017052603328)(7153060)(7193020);SRVR:AMSPR06MB519;
X-MS-TrafficTypeDiagnostic: AMSPR06MB519:
X-Microsoft-Exchange-Diagnostics: 1;AMSPR06MB519;20:4cXiRlIPENanEoge7GZoFBcVO02JXA9C+GyT4Acfzbc4S6NhtEyEf+qgb9yLI7IU57p+IR98PQouk/Bg3thmFcW/Mb55tA9EhWWpO/R8bJF03KA0wV7JbEXu/nI8M4zXRjo1MRJJS4vlJzF9cMI5PO+0iBYz1bvUvAyAzVeg4dQ86Gp/i3DO7Lh8saAXqOI9WadF96zZB/qXebvobP3u7CyOCVyGUbJ6y6kxQv3IL84EMYnIRERdJYsN78lX2IJEvbW7c3wEldwjbicQXc0zwd/6Et2yCcYpThhOKxvz+XJISKtnYkGkQhblJlznHF0YmsmqlJ8Knl+GCAebsG8anfEUSY/nIl3nD/KfBqfPoBZnD4UW71gtiIL1Uaoaze2PGT1xhF7E+arjDeRAVuYTnMCGnwbj9NficQ1dRKnezH1G424nI8DVzOwFgiuYqCt5B1XAX8CxIz02ThUSHJqvNEMvhcRxr3RRV61kdFHBKu3eV9QVh34Zo3dyvhsL3bLt;4:Wa2oMfAghdhJlG+y5MOA8L1nlI69hX2XeHeblHEjwqGDkM1mV7NgGjb2hQ24YWSIxkDHqGZZ3FrxaOXLpZM8U7eDeCq6RaptPTLXwXn+E/Kh3Da4/g7YscvKhIb4u8nhaONJ+H7BhIp3QVEt4QpM3nKWycLoFKVsMU13o4myo93ZG8RNmE/D8M4FkJclrh2y0wNfCUnfcD2cg9UxkEAKJWhgo6tgZzqlJ2aAnvKFf1OAWb/5A+kWAsOjarx6QdHBDLzMYJR6H8mpzCoImVVc7w==
X-Microsoft-Antispam-PRVS: <AMSPR06MB51906933193148882F17FF6EFF30@AMSPR06MB519.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(7700054)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095)(7701012);SRVR:AMSPR06MB519;BCL:0;PCL:0;RULEID:;SRVR:AMSPR06MB519;
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: 1;AMSPR06MB519;23:b6VcrXCjIeNFARtIKugwSLAfVCxV1JdmM00dIIQHnpjEq+ktNcOJcNjALpnwCupd5WRREtATEyJdN1PjB2XlQwdOp1khm06/E3E3DGUK+vV9QcOR6ltfaPqsUNGyYL2uXESK9XP5fbA2/ngJPtMdYnyjrLnXwNx7ZGj47QtFBd7vDcqukxzVWgJbamPD+KM6;6:PEH+oifbBpc/hFWWaaG+IpljTxtjjg+1txzn3zDrbzf5R5qjmNFUeypZ1ps0yRW+T/mMZL24rBVHBQAXJN1AzZG0ThuTgyaau97AiT2T1KJNq3Lcqsx3HjWey/VAnjEsiSiwRnd87MX74TGI+IRAbYAVDKR846J1vZp8D3sHG9XzTw7B004XoEz58+lGLGh9Jo1WWHpN73e2FshCA3a7icRPxgmaplD86FWCKFsL76slQUOdw41dnZRW6ZFHFcE5VlZ+X1j9Vd9TciLAyLYicnVojVwPE25jz7Omag3nCblMgCd0NyAXzji5VC6mxWgq6K54z5ZSHDwVBz+unGoWqI9YwEgan9cQAwQRgG2MaNRmahjwFDl++Ma2FfcAs0+pc8zkOloyQ8+rGBfNoCjymD8hzQiYN2xRaXrJHh4Hvr8zRdCvrYM+NBwLzIT8EJWzLshF0VtdvzdSzvKlToMflikQ5ZGzL7PKk8TCkyOEihXrqezkLSPa+zfjOYX7MOce;5:WPlIhl5ofa7OaGbRwQMP/ijXIHHHAmnPNwlsuqcb6EYxsPbrbRaoXVGC39PiVmx+0Mc0MxHhoOWHQTDsgFKTrOW7iSOliytcFOEqVqCK6xK4L9DejqxIVdBOwM8VXUpCJJNQuyTy9wt7vNpNZVQ36Hi87hbXcfLWiWDeYvzyTb4=
X-Microsoft-Antispam-Message-Info: D3H0uVyFPI4u3aZvdf8T44ZBXlZeVnf16o6vbljm9NdJ/mqY0r2KNmld6NFVdsN8M9uBp5ZrIY25ianIFyO5uIObm1x2KhUm96zdNReyRX+NzqsrepSmwotgT8gXyhCqoLYqZPHpeZjCyUi1PatIv7yh0YPP7fSK6t353aidZerAwiWHhSFH7BrV5pXd84CWLZH9ZHR/gvNZLjs7r4gg+C9Xj0f0bm+qlKyYWiyQzE6JzH1U3Wm6dlRlLjJAGtQxnxZkGE/DAIbepD4ojpgzGEJUDU7m13U2LmNQPU/pPZcyyZQOSh971M04GMs7lPg/e9n5CHFYiBpXJCjRYwjo9DVUOFMO5KdQGhvV2HUQmYBHgupRGXCZRNa1zWMR3rT4yDAihLdQUU9071nQfTcgFWYHIJoLYlF5/au55Hy8lZp4fIoushG+fj0b0V8mUqVeeFv6mOvH6Ge2qbg1v7gUy/i4dLj0dZqZ7U/NqcWFIRk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AMSPR06MB519;7:Kf2C/m52NUBRUrxuV0mrCY25SOnvjU1ixG90+hornjT3CAh6nnZ5qiztvtQKN3SvJ+6mIBORUKEcF3cyqpy4yDORo1spyVV8B6zp1a3XVa6ruCXrPvLK4+lSMStOYlL30V5fkXMzywYw3/7J2okS7Q==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 14:27:54.6050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96f4f16-e5c4-4ee5-8a32-08d63daab74d
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMSPR06MB519
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 29, 2018 9:53:01 AM CET Wolfram Sang wrote:
> On Sun, Oct 21, 2018 at 04:12:10PM +0200, Peter Korsgaard wrote:
> > On Mon, Jun 25, 2018 at 6:14 PM Federico Vaga <federico.vaga@cern.ch> 
wrote:
> > > If the Interrupt Flag (IF) is not set, we should not handle the IRQ:
> > > - the line can be shared with other devices
> > > - it can be a spurious interrupt
> > > 
> > > To avoid reading twice the status register, the ocores_process()
> > > function
> > > expects it to be read by the caller.
> > > 
> > > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> > 
> > Looks good.
> > 
> > Acked-by: Peter Korsgaard <peter@korsgaard.com>
> 
> I assume this patch will be resent when the other patches get updated?
> Or shall I pick this one independently of the others?

Since Peter did not answer yet, I would say to wait because I'm going to re-
send the full patch-set soon.




