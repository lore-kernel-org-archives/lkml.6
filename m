Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA277C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C437208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="A4MBxRvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C437208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbeGIGGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:06:44 -0400
Received: from mail-eopbgr680059.outbound.protection.outlook.com ([40.107.68.59]:43232
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752914AbeGIGGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MJ47rqjj4P//Z2RBz0CQWPAk+aVwBOZFz8mR+78VMk=;
 b=A4MBxRvv9KGkJtQshH5/qCtPU7yAt7PelGGKQN2oIvYDlhtghV3wMxB6A/W0Vt70JnnaaBbE1FLbq27mjNUn12IIi2r3BID396d3x6Su1XHRtY86El1zmE7bWT5cv5j5HGiqiF8a+poI0EMM9LycO5qxB/PLBsbWqK5PYe9q6GA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY4PR03MB2631.namprd03.prod.outlook.com (2603:10b6:903:75::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Mon, 9 Jul 2018 06:06:34 +0000
Date:   Mon, 9 Jul 2018 14:04:35 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] serial: 8250_dw: add fractional divisor support
Message-ID: <20180709140435.3996588b@xhacker.debian>
In-Reply-To: <66eff871bc97f24e7fbcc2494df1bb6fdd98d8da.camel@linux.intel.com>
References: <20180704165908.4bb8b090@xhacker.debian>
        <20180704170310.56772d77@xhacker.debian>
        <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
        <20180705143921.6a8aeb50@xhacker.debian>
        <66eff871bc97f24e7fbcc2494df1bb6fdd98d8da.camel@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:404:42::19) To CY4PR03MB2631.namprd03.prod.outlook.com
 (2603:10b6:903:75::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29d3c495-9fba-43fc-93b1-08d5e56220fd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2631;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;3:PlEFDKknSTbuKq6+8U9tCEz4TQ7iWNCkFOcfco+VZ5nT6fSKe3b47N0h6L1DbkZq4FRTJsVEkStI0ORH0C0YFm6ssPryXrq1ILhNHOMInRKp7oXqt9jlv9n6D/ZVU4vIWCAPTiv00gJ2EmBQO2lIzWI0oX1f5QeTs76DlQZ4WqdFwe+5bct6jc3AGdzwFYRS5ZTOIhKt2yWcpZinckJQshH5M7E1AeBs7VU74OY9xuNInK4zaSxIZaqcMc5uw3/E;25:kwQ1ODIb+JH9XsCXKU4wbwe47S2/La9aCmEvpADqErO7WqmUO+blloHWhgx9SIfkZWbxPI5PNUUF/rCVBGyWhKTrIcDK0PW8Vp57Eo4C7x/sxGSkNuTad+Od6aerkL9WxqjwSE9zSgh1DG/abDlCY9Rqm5T0E2TFgYxBKvNrwjySbA961gPnmEYVBwEKDfOYg1Ym9znj0ZUKamLoaFqzzFfybztfSxSR4G4WPaKO26xaycLYsqIsbvRV754BhWiAErS0smBlFyIeLgOzjS2nKFRxWgsc/zRgUr/qRGPt/hlOfHx/vbMhuXpQ6invicNXTTT5h/CczXUuFqBTVLPCCg==;31:l/5KkP/ucSK094t2PI37ZxPS1rGe2z/8/+S0l1ZNQTkSp+28hfbz0XGirmA1kbTgd9mn0mcrhTkJVFBFfuEG26E4FrnCd3DvTBctRDil4lp5tOhJtIPAOLwKneBM8xULr32ewCCZzC7CpFyt+AghreuX5WT5Znq9X+sEbioWi9C7NALAHYUZYQN07UKifUpUXcv1MaDdGRLvFzKxxIhCyDJ3pqaqYaJYoDh3tqzJ9vs=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2631:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;20:+iXoccvRqkao/MiAyLztUpE+NatY0sI6Eh73xZoMQDAOxBqIqtTCGtX3wcILZItTWipVM0gOwBwidHQO1ag5epgn1vAwsaXPeYYCwKJVp15SsqZiDxl+QRNtY4Vur+Ck9+MViPA2DFGG8q44CqbIvb2xwqnUYiwh5mnpl/cOf4yp0ZI51G87zrrAuO/2qThopPrLfLZbRdijTWwP+fLxAZ93EPBfnGKknE83md2ioz1k5zdn3Ak4i9VI4+S9msRmzPyWTt8dYSjys64PUHvNod47ITeVIoSFukU0yfgQfuGAYx98u1IFzGZxgvB11IkBmP/CuRwRJPSjO8OtgyY5IOhKCzhT4SZ+iPLbDs2dTZhdBK2ergKfr9VOruN0wHEjEligU65V/zg7sXkSdJSt99sBtqRqbeF8w+G2RXr3dktlNGm27DVuiR5rXtp1H1TduHWMHn6V4CPfAYhpC9dS3sHJ5kcyWomVx570WJU/+CDSaqJ+G1A6D4g2o1PtDZ2K;4:SXYpCJ+kx9mrtkUuLwurMaNGdy91nIqzEtKmQ5crSvfq7Kolj7vE+Wn5mj37bd3/aE/RTudSjryDel+/k7vo8XA9zTjEmCdfKeEF2ximnXsH+aUgUIj3AJ0ZMYj6SySYmZNprbCnBCJQRky2JL5lPU5xonVAv8ArK5w0TVWt2O+z70EImJmjyKzBt3Dum/bUHUqux1hXI1Rg2o11X8UR/VSGX2KLpCSSph7ERjeuRp2MZX7VcOzCJIMGfYdatmrG54jUJvL9cGLdUYF2fRrWzw==
X-Microsoft-Antispam-PRVS: <CY4PR03MB2631B73E959E9D159B62218CED440@CY4PR03MB2631.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB2631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2631;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39850400004)(199004)(189003)(106356001)(2906002)(8676002)(81166006)(81156014)(8936002)(230700001)(72206003)(478600001)(93886005)(1076002)(6116002)(3846002)(23726003)(54906003)(50466002)(6916009)(105586002)(97736004)(68736007)(5660300001)(229853002)(50226002)(316002)(47776003)(66066001)(11346002)(33896004)(76176011)(7696005)(52116002)(386003)(6506007)(186003)(26005)(4326008)(55016002)(9686003)(16526019)(6246003)(86362001)(25786009)(53936002)(7736002)(446003)(956004)(305945005)(476003)(486006)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2631;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2631;23:h+LDZb4N+LTA8FK8EZ7angK7JRqeTblHo8lUqFZgL?=
 =?us-ascii?Q?BLYQY2x8Vhpm0iAO+GbQUzxQbLuEc5B6sxJS/9MOiju2RtrE/r1zX8o+lMJ5?=
 =?us-ascii?Q?ahTh7tDSaJRH+hSQ0jwwjdzbVXyrXWkO3R1tlyOw+ZJuZTdkzmxrAMq8molV?=
 =?us-ascii?Q?+4oUpLT2vD3XdP8isKnY5hx5DLWRWIMqwCx5yzpPH6FJNHmHA2IvzLPT9JED?=
 =?us-ascii?Q?V9AyyybmjB5fvjgkPH+lFHEFp1sGLOKddl9QVrxviA6B4XjEkai7jT/NF26v?=
 =?us-ascii?Q?KRXSrVUjeSxtxpimnieplbwlOQVjPFbf7REuELWI8R60Y9qIVDcZBCDkEBL2?=
 =?us-ascii?Q?gvOkOg6NvPlTOdOAm70oVqr/w7hiNxK/hM7KmfhvlVSwzP8eX/yC0JE0FtNf?=
 =?us-ascii?Q?TniKSnN+rUN2P6/qhtVANV2QIzULFcNA1r4AUPpiG9LTuIReFVZq8zqaDH9D?=
 =?us-ascii?Q?k4VsSyylf4O91Qm/UsZyBJd//IyW7b1MWgy/961AgNX5Gxzxxufkc87HOF4+?=
 =?us-ascii?Q?5MrB/egVK+i2PDW6PquEb6r57ei0h2I8hCe6jvTcEV6hXOieMestnCxieJaL?=
 =?us-ascii?Q?nJjZzIa8okKVquRgLgy0Wk5hvPxLORtgo8l87wGfavBTEZuxvtYnCdJIk9Hd?=
 =?us-ascii?Q?SI3BRGuBjeBJL6gj5ZmuSk8W3qD+YrY3YfHX4NWcJhMBAb/Vm9elZOoHJZsG?=
 =?us-ascii?Q?wqoKIWCOXxtyhJOpZCRkqKVscNcHDV7h0fDUo5UpJIbINkcuBRNLuzyhcxHB?=
 =?us-ascii?Q?rVuNN83LSbOdwsunjUt+znl77MHrJTaXkub+ixcPENfQgJ6tQl7iwBiGHLxF?=
 =?us-ascii?Q?FXAfjQwFq4y72xDEibCrpkZkVLemdWJMr60fYsixfcEMzmLDEkP5jWryO+xM?=
 =?us-ascii?Q?u2QjHE7goitQryxJAuVHG1vkXuhY9P0lmTERCF9OClkqKRsxP8b6WPene5oI?=
 =?us-ascii?Q?/nZJir9yKxjp18+OlCmbcSJCeAtk/jUY+T/vLocDyuRM0e/Fyrq5jR+UQMya?=
 =?us-ascii?Q?zhWMURLG1xwwEnNGhLY5jQVsFgQ2tWdRAIIhV3ek7M/LnN/Kf7Ws38uK65xP?=
 =?us-ascii?Q?zjksef3PDRQ6tIdC8N3eS+Bh09axLGevCyIFQ0e2CgOXo0Z2E/BzmRYtCvDg?=
 =?us-ascii?Q?+1IH/F5CYU2nYloMPMQIgaKVY5y8BzMBzbc1evBkTGWl0PmvcW8n96fc4u1L?=
 =?us-ascii?Q?aXrJdDAYZSN6VszCmRyZN45SDrZeZggqGlGXzwAF5QJB1gH/qdV6lzvoFMZ3?=
 =?us-ascii?Q?uqeuvn88YOeeSPksQu+04Pu0Whft97sCbJBxZTnmd3Ema/LdYc4yGEzVehiO?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: 6GW0ONssDr2aZ7THe7cMQjhPOqesevC6pAWAMEWR8oJsu0NTIjC/83FJx4/WnbnhV4J6GMRxLpPuRewn4X+l50X21D9Ucr4QjFEfHJozdm8pla2Bf6IUchY8zTeCDHir1S/NBlnSoWCaKLyRj3jzciiAkJAzbgl8NMYYF7hkFTjGEJyf5TCcRbK5/05ledg0xtA97xhQhPF/O0eWFqXZLi1UPa2u4W066syIx52bwf6C5873Mx95i7EBtVHwGbNv5sp1gf57C7NkFtEeuPas3aYSrEZVtIpf3N0pzplEdT07BHkq1IYAQl4f+/xndFqDUl9FQvOL7NEkC31iHBBmqatDQhgeVVMUvEN4RMh/4Nw=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;6:OV6dRUrnA7Akx4LrbkfN8cRa8sc/VW/IQlqZiB37FD2KCefZnn1S2D2/2TJSOow+tA1KMYYwNX/wQX7zLZpYumYHUqT7dKpqOegUjBSf141nQ3B1wPUelx/R1b6gBKZ94a14ZrAFFwx242hbXjWmglpH0JUMm5ys16TaS+MQ/Tfd0NmzFWRscEl4r+DHZFUitmLu/pcIRfH5lIO0u+M23pie42d717OTG6uQSCEXJOfXAh5uteoFdxfVpRwGVUViFVsMhrONANebIzMIk78WzVfSjMeB/wlR7q1QcUq2xo2Yx3O6EC2Y/QSCwwU5RQIy7PAJCd0YYuj+DSV8PCbzDttZGQKf9LWJ79d2QPXZglvf/6cR5CWDb255gAt1L+ZeWklxr+DwDaWmOOF+ZfAX5rDOacfltq617m0CDEjefGD/xBSk0ONycD4SmsT090/MhAbeRMUlRsXI0Xb/9yXaoA==;5:uqAs534x8/sgW2/wErIaqrH8VGx3Vulw8qr1Fm5o0MU17+auGrW1FiBMkNF1Y7n+tSGnhmQrul6kZwk8gj+MPnfcTzo4yA8TDnM28idHoptZOWaOKXAohMuU9Sc8vz1qoHkwcpDlVlBIm4GN4ta9ts/6WoGRPKZUC6EzLushzyU=;24:8UtWxhHDgAm16UQ6M4Q48yBQQ1IRZBO7ZFkgyjmgVaw1749ilPWLqMQY27ZjuSvJQHQCeBxkrsIbrwJAfUZmNLJyBNZKtPqx/YsY1+06dos=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;7:EPZ2Z6YkegAkVn/x6L0yLOASRkSsCOjnI2jOfXrcHzGVht1ZtFRRipym/7T0uUk+02lSHjBCsCwee/jDx8qpnX4y3h8tRM9LKImqNifLoRoQpZUwdoL5lv6zqZXrdFuzu8o+2LP6FKrlXXWX+KvPP1xevLhm8aSeeMq2jVP5jd9jBMb20U5SNjWp5FPx33sMt36W/TIJdVTUXr83T3iDXyqjipDhTWrXteRMAqepDBXT5hc4wgkXrbQ0dwjpWzoP
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 06:06:34.9364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d3c495-9fba-43fc-93b1-08d5e56220fd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 20:37:09 +0300 Andy Shevchenko wrote:

> On Thu, 2018-07-05 at 14:39 +0800, Jisheng Zhang wrote:
> > > On Wed, 2018-07-04 at 17:03 +0800, Jisheng Zhang wrote:  
> 
> My comments below.
> 
> > > > For Synopsys DesignWare 8250 uart which version >= 4.00a, there's
> > > > a
> > > > valid divisor latch fraction register. The fractional divisor
> > > > width is
> > > > 4bits ~ 6bits.    
> > > 
> > > I have read 4.00a spec a bit and didn't find this limitation.
> > > The fractional divider can fit up to 32 bits.  
> > 
> > the limitation isn't put in the register description, but in the
> > description
> > about fractional divisor width configure parameters. Searching
> > DLF_SIZE will
> > find it.  
> 
> Found, thanks.
> 
> > From another side, 32bits fractional div is a waste, for example,
> > let's
> > assume the fract divisor = 0.9, 
> > if fractional width is 4 bits, DLF reg will be set to UP(0.9*2^4) =
> > 15, the
> > real frac divisor =  15/2^4 = 0.93;
> > if fractional width is 32 bits, DLF reg will be set to UP(0.9*2^32) =
> > 3865470567
> > the real frac divisor = 3865470567/2^32 = 0.90;  
> 
> So, your example shows that 32-bit gives better value. Where is
> contradiction?

The gain -- 0.03 is small, the pay is expensive ;)

> 
> > > I would test this a bit later.  
> 
> It reads back 0 on our hardware with 3.xx version of IP.

Thanks. So the ver check could be removed.

>   
> > > > +	unsigned int		dlf_size:3;    
> > > 
> > > These bit fields (besides the fact you need 5) more or less for
> > > software
> > > quirk flags. In your case I would rather keep a u32 value of DFL
> > > mask as
> > > done for msr slightly above in this structure.  
> > 
> > OK. When setting the frac div, we use DLF size rather than mask, so
> > could
> > I only calculate the DLF size once then use an u8 value to hold the
> > calculated DLF size rather than calculating every time?  
> 
> Let's see below.
> 
> > > > +	quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4),
> > > > baud);    
> > > 
> > > If we have clock rate like 100MHz and 10 bits of fractional divider
> > > it
> > > would give an integer overflow.  
> > 
> > This depends on the fraction divider width. If it's only 4~6 bits,
> > then we are fine.  
> 
> True.
> 
> > > 
> > > 4 here is a magic. Needs to be commented / described better.  
> > 
> > Yes. divisor = clk/(16*baud) = BRD(I) + BRD(F)
> > "I" means integer, "F" means fractional
> > 
> > 2^dlf_size*clk/(16*baud) = 2^dlf_size*(BRD(I) + BRD(F))
> > 
> > clk*2^(dlf_size - 4)/baud = 2^dlf_size*((BRD(I) + BRD(F))
> > 
> > the left part is "DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4),
> > baud)",
> > let's assume it equals quot.
> > 
> > then, BRD(I) = quot / 2^dlf_size = quot >> dlf_size, this is where
> > "quot >> d->dlf_size" below from.
> > 
> > BRD(F) = quot & dlf_mask = quot & (~0U >> (32 - dlf_size))  
> 
> Yes, I understand from where it comes. It's a hard coded value of PS all
> over the serial code.
> 
> And better use the same idiom as in other code, i.e. * 16 or / 16
> depends on context.
> 
> > > > +	*frac = quot & (~0U >> (32 - d->dlf_size));
> > > > +    
> > > 
> > > Operating on dfl_mask is simple as
> > > 
> > > u64 quot = p->uartclk * (p->dfl_mask + 1);  
> > 
> > Since the dlf_mask is always 2^n - 1, 
> > clk * (p->dlf_mask + 1) = clk << p->dlf_size, but the later
> > is simpler
> >   
> > > 
> > > *frac = div64_u64(quot, baud * 16 * (p->dfl_mask + 1);
> > > return quot;  
> > 
> > quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud)
> > *frac = quot & (~0U >> (32 - d->dlf_size))
> > return quot >> d->dlf_size;
> > 
> > vs.
> > 
> > quot = p->uartclk * (p->dfl_mask + 1);
> > *frac = div64_u64(quot, baud * 16 * (p->dfl_mask + 1);
> > return quot;
> > 
> > shift vs mul.
> > 
> > If the dlf width is only 4~6 bits, the first calculation can avoid
> > 64bit div. I prefer the first calculation.  
> 
> OK, taking that into consideration and looking at the code snippets
> again I would to
>  - keep two values
> 
> // mask we get for free because it's needed in intermediate calculus
> //
> and it doesn't overflow u8 (4-6 bits by spec)
> u8 dlf_mask;
> u8 dlf_size;
> 
>  - implement function like below
> 
> unsigned int quot;
> 
> /* Consider maximum possible DLF_SIZE, i.e. 6 bits */
> quot = DIV_ROUND_CLOSEST(p->uartclk * 4, baud);
> 
> *frac = (quot >> (6 - dlf_size)) & dlf_mask;
> return quot >> dlf_size;
> 
> Would you agree it looks slightly less complicated?

Nice. I will follow this solution.

> 
> > > > +	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> > > > +	serial_dl_write(up, quot);    
> 
> (1)
> 
> > > 
> > > At some point it would be a helper, I think. We can call
> > > serial8250_do_set_divisor() here. So, perhaps we might export it.  
> > 
> > serial8250_do_set_divisor will drop the frac, that's not we want ;)  
> 
> Can you check again? What I see is that for DW 8250 the
> _do_set_divisor() would be an equivalent to the two lines, i.e. (1).

My bad, I mixed it with get_divisor.

> 
> And basically at the end it should become just those two lines when the
> rest will implement their custom set_divisor().

yes, makes sense. Will send a new version soon.
