Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F43C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555B324B2A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="BUq7N2fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555B324B2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753657AbeF1Huj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:50:39 -0400
Received: from mail-he1eur01on0071.outbound.protection.outlook.com ([104.47.0.71]:42112
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752057AbeF1Huh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvJ1KigriCYmy1BLRFTdkRhhyBSdJg4zIAEGHqA1HMM=;
 b=BUq7N2fqZvCgsNSlKpEl0WY+3ikKevoBO45oIMOqieVRbpJtLZgYaqmQ55neQH80stY9IZ4eLrlAKOFpByb3sdLvaqtCsMdwXr8JABwchWcn3+y//bvOJkMoMkCOsfqlAUFR2jIt2bHCBd22RHALJMDZIIXnknbTcZlx0uI3VT0=
Received: from DB6PR06CA0034.eurprd06.prod.outlook.com (2603:10a6:6:1::47) by
 DB5PR06MB1143.eurprd06.prod.outlook.com (2a01:111:e400:51cf::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.23; Thu, 28 Jun
 2018 07:50:34 +0000
Received: from VE1EUR02FT050.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::207) by DB6PR06CA0034.outlook.office365.com
 (2603:10a6:6:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.23 via Frontend
 Transport; Thu, 28 Jun 2018 07:50:34 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 VE1EUR02FT050.mail.protection.outlook.com (10.152.13.198) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.20.906.15 via Frontend Transport; Thu, 28 Jun 2018 07:50:32 +0000
Received: from cernfe05.cern.ch (188.184.36.45) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 28 Jun
 2018 09:50:13 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.399.0;
 Thu, 28 Jun 2018 09:50:13 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Alan Tull <atull@kernel.org>
Reply-To: <federico.vaga@cern.ch>
CC:     Moritz Fischer <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: fpga: fpga_mgr_get() buggy ?
Date:   Thu, 28 Jun 2018 09:50:12 +0200
Message-ID: <2419388.jt6midSiEu@pcbe13614>
In-Reply-To: <CANk1AXSmDWb=up_xDwvSg1SLS0iv6spcpcv42fSpM7+=Cy06wQ@mail.gmail.com>
References: <4617134.5euanDEBgJ@pcbe13614> <1569671.PEFH9RgftX@pcbe13614> <CANk1AXSmDWb=up_xDwvSg1SLS0iv6spcpcv42fSpM7+=Cy06wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(438002)(51444003)(199004)(189003)(486006)(446003)(106002)(6246003)(230700001)(476003)(126002)(76176011)(8936002)(50466002)(74482002)(229853002)(54906003)(33896004)(11346002)(53546011)(478600001)(8676002)(9576002)(6116002)(23726003)(43066004)(561944003)(16526019)(316002)(186003)(786003)(426003)(5660300001)(106466001)(9686003)(246002)(26005)(4326008)(46406003)(3450700001)(44832011)(305945005)(356003)(2906002)(33716001)(86362001)(336012)(14444005)(7736002)(47776003)(7636002)(97756001)(6916009)(39026011)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR06MB1143;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe52186b-19f5-4f15-06de-08d5dccbd427
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:DB5PR06MB1143;
X-MS-TrafficTypeDiagnostic: DB5PR06MB1143:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR06MB1143;20:xVnQGPMiAo0IZqSe+pZ3haci3cunKf6Zww/UvHmALvlqBpweS/C7PoRPC/uh2J6tGFYAHUdKfKs+j+pQ/OkQOAaWxBtmzjXf3XcywLcBFM9YCTTUfCnC2vsWhUVME9UBO4PF93pOX+WV/x+YL10/DJL+lna7xXV6D23GRZMZh6TPEt34HAQnEBtlkvj9d4vaffNnYhivXy6hOFrPpXgGJcycKEXQFh2HxO8P1/UeS5x8ou+xmxPh/5F/jlnvOlF5flffFFou8Y2eVg3+ozZ/XFJ3ckcKVwT/WLgiAyJQKQeadq/4FLsNPBea/VFbEknY3Mu7QHSdc6Pvs0Wt7kt8kRPtCNbM23aUAobVijcLCC6TF+jnsY95r7lhRJiGnyIHOYCIDmiopt7jqenwLQLSI3GRCpfbSfp+XJpDmKNQaFMRwUNLlMat+XWSYdXT9Kra11eTnnYHNS8dVdxHL8jQWNDP0L86Av8LI669elKl3P/24eTWn5EUHopOyQHrqtYJ;4:Z3gRncOsBCNu2cVKEXwRpz0XW8SU6C41TEgF/1c6sRDVKKOO3NcdmZ+NzdqokBxg6qSi4gWrlR2BeYTosrFqp2C1fHofXap4ZvHMH4vZyj3oMWoXDDIt8ZFVurpX1Lw+w6BvfzzQBGqN+zEcpelsvQU8YBayYFMbo+21MqSJyJ15fWDSKmYBcH7kZbEdz/or3CsGalmHhD0B+lIfjzHDbE9GtAwJY1s1KMbGr4NgOp/kKma03hbfD1bCV4ulAkiJndetYEsQO/9m+tqJ/679wfeHKsCm62juzBpbScjLj11aWA/eQUmTkLBW3sVBh0sd
X-Microsoft-Antispam-PRVS: <DB5PR06MB1143B110D31FC5BC74AC08E5EF4F0@DB5PR06MB1143.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB5PR06MB1143;BCL:0;PCL:0;RULEID:;SRVR:DB5PR06MB1143;
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR06MB1143;23:ostWQ4t8o7N6eHkpsQFkCq4viYsT4SB/RCHux151D?=
 =?us-ascii?Q?AU7zYrYz8d5rev0kxq6gPSru18qiAtDmXJcd5xfLmM25R0UmLPRLXyFnEs2X?=
 =?us-ascii?Q?k5eHfdkXhE8xMiSmXZzApoDA2/RZZAVuu+NJ7ffW2QqJaIqJoAYBjIVhygDk?=
 =?us-ascii?Q?XLFvcNJQ5YCWAH/0B+NIqu9gnCWZiU2srmdDvfItba6CX1Us8PPjmzn+nPQa?=
 =?us-ascii?Q?H27IuS7e6WLv/mZIH30wU8ZdfhUu951pNdXjM9N5E294Npxp7r3H4mGqFNrX?=
 =?us-ascii?Q?mnzz4+diRspOl69/9k906rZCZDGDABx5sS/c7o+rImf/avBiS6Jq7zbV73LT?=
 =?us-ascii?Q?AnTn1ZTqjvNhBKxQ+jSbxV3cz2I/cfIZDOelN7b0ZaZC+K85gGBho3c15UiU?=
 =?us-ascii?Q?CliwOPZgnBftmrTWqDkjSQ88UeRhsm0dR96duqIqVfITeiLtPcvS8sCdHhux?=
 =?us-ascii?Q?PqcNXF5mlpdSMYXcp8c1mrOd1KnHX3ulqbmiYhQzPu7naECtwcqDR+UU4OFk?=
 =?us-ascii?Q?cyIkeFLWdDHf+wuWDqO4/cYhuRoSPhfcDqFUVxtUi5dW9aNg15kUKJNiSjdc?=
 =?us-ascii?Q?Dxb5AnidO2naDuoITJjxjuiSBzKmcVKKuzrtrcCjWM8uBX/dHZ6wDciyAeWm?=
 =?us-ascii?Q?GJ43QcVJcaloXl/94dOn2cuNFgLscKwMAkkkWK4rnroFfVYp7wKnL1NRKrBa?=
 =?us-ascii?Q?Z+Do+XXBL3+g4NL7UatWPUQ2JgMxcNupdvJjZJIZYk1wKz9Pe1eP08toc2iv?=
 =?us-ascii?Q?iYV9DZ0Xb09dMZCKrcljppTJk1PFFEH+SFdAsYadaX5fC+ue7bM2nAyDw/lH?=
 =?us-ascii?Q?RqJi54uuLx2oJaPOfujwMaRmeFRXEuraW1E44AGk9k5bVIsMEtftX7hGDcbC?=
 =?us-ascii?Q?VynG5yKIRPg4y46AcbS4WaOx8PaBBiyPAVma/8+L9gPZUwfWz3p9Avrsvx3J?=
 =?us-ascii?Q?Hp2uLMVKyngmRdb/07XCqv+D0MHJgRbWUA79JiCcZS0h6dTIrTRtuZjGSEbn?=
 =?us-ascii?Q?Okf6A+oBb3W4u3ac+C4tp8/Ze4HcA7eUvxQcyd9fOn0k1UmHKNEEI7MjLWUy?=
 =?us-ascii?Q?2KyzY5q2HrjsWswrrJPmF/t5QkCTBM3C72VbLvbQFTpyX9zDYYh/mDpRpySC?=
 =?us-ascii?Q?KBTpAggd09ntOma3/Cl1e/vTEG6GQZUqRTlTFfinE1Uqlg7v1eBT+A4WTD93?=
 =?us-ascii?Q?B+T00135N3ce3SL363+AalCvZcU2OuD9mCDblIGRYwCFuCmAXr9KOUmo+Qxg?=
 =?us-ascii?Q?6bf8UzWbLsh4hSjgbfVJZ16kICUxS6ixq5owsslCZWzvMtTH6kndbr5PGQVX?=
 =?us-ascii?Q?dfMFoMwZQxNT+5gTwoP45fae8rWDCw9gWTZFGTZnGKt?=
X-Microsoft-Antispam-Message-Info: xMWw9Stdzobo9LxfpU6GwbEm+pRZkT+OccKvlOj/t+s42z1COB4PZnJySluLoTbKRJihrL3FM46Sx3zwrgi0CBUxfAYitZC4SzWoWrrNw+wPinD+K0TEfK2B37N5qLe1hAHYV8oTzr9th1sFb4egZLVPGGZPTYOx04JaljGp6gahTi1poaLArrqPcbvFHjtGA+r5MnrG2yrZRUGBKgGs7/CnHYzFk9SzWwJWtSZeyKBa2aFzsGjXOznW2exP5r3fw0LUzAD5xBafzNPiPJ/o5c3mc+rBiU6Xo8d9FWKCjFpoWoNo3eLc/MigNi2Y9UGzFkwUzeR0CX/dyzVfBlVjNzSKJxI0LUXHuqMtJYKdcBg=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR06MB1143;6:b2wynFXwpyPAF/ZRYQjkpWYV6y5ITCPc1E0BRlYuQ/sgVmQPA1a25Gy498sZocHrOXu7XDzSxUampJM7tcvmHITwvGMGr4HmBUe8l2yljpbicWZfY64jL1ncimBwe1iIEuGvpFJVDCzQznxJLYxSjihy3ucDVFjEHMHhI/Sbi1WRkeHvLgEPnQL1E1nwre14KAFxfaPIyEeSh+Q02SnQDc6UId2rWlSgcg0dN/tyRYsdywFMMzDW8gsIOVQMcW2zClL4/05v0h7ht6BUfo6cz2ZLKweWDPNYo0ij9k5hDohNXtPEVUiRZdLNwptqHCpoZv4+QOrsiHh4/u43v9bzL9HNekhDXZEPZOUyFk3jFlVXE4z4O3RXCn+Cb8S0+Pi3EF7xwC3An/yXgjcCkany843OAtVnWFDWp30jC9Z2UnUcmoF843uTr4H3wVKyVQfTBJenL3MV4rCscerqSuyL2Q==;5:KiLapCBguLAxw0/7EBjTyA5JwbzzHJCjKNW+H0US4yYU9bzDgUx9mM6tawY+G7eUSNV1daVvKkUGvKv3QML1S9h1l/LboxkLAeLdjZFBLaL7F+WxpssN/c0n96q7VSsJaS4/16rG8BJ9AHXX07J/o34dHI9fuNEZ3MtQ3Ni8BkI=;24:B6v2wzu4hHHeJHL1PW6GhbgfrhABAs4liGgAxv7a8+BtjLj5XbXPB8eH04dx4F9lQxjMReavBZgCB/NXEIHVohQkzK3hDjfhuJLYrbK4gO8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR06MB1143;7:iUftMh83GkGn+Mp0ObdJ1XDnhLn7Q1ttsuFOKUXYUjnHYtuRiG8zu96TDMuQ3oLTaLZRimxkRfOVKW2xzdv4o9TZIZrcxfipfHEd1MMHF1sbx6tXvG4Wnv4c+7yFdHz3Og2REDUw92qyuFolfc17KODyg8U4m/9ROuspDHJIm+oH7bD/QzuFmF1EQLFN6zIljBc5pxD+mr6120foubD46+sJI9rwUJY/0YAJe/U1qsTnnYArCS26xI2K2dUi6T5Q
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 07:50:32.3879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe52186b-19f5-4f15-06de-08d5dccbd427
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR06MB1143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 27 June 2018 23:23:07 CEST Alan Tull wrote:
> On Wed, Jun 27, 2018 at 4:25 AM, Federico Vaga 
<federico.vaga@cern.ch> wrote:
> > Hi Alan,
> > 
> > On Tuesday, 26 June 2018 23:00:46 CEST Alan Tull wrote:
> >> On Fri, Jun 22, 2018 at 2:53 AM, Federico Vaga
> >> <federico.vaga@cern.ch> wrote:
> >> 
> >> Hi Federico,
> >> 
> >> >> > What is buggy is the function fpga_mgr_get().
> >> >> > That patch has been done to allow multiple FPGA manager
> >> >> > instances
> >> >> > to be linked to the same device (PCI it says). But function
> >> >> > fpga_mgr_get() will return only the first found: what about
> >> >> > the
> >> >> > others?
> >> 
> >> I've had more time with this, I agree with you.  I didn't intend
> >> to
> >> limit us to one manager per parent device.
> >> 
> >> >> > Then, all load kernel-doc comments says:
> >> >> > 
> >> >> > "This code assumes the caller got the mgr pointer from
> >> >> > of_fpga_mgr_get() or fpga_mgr_get()"
> >> >> > 
> >> >> > but that function does not allow me to get, for instance,
> >> >> > the
> >> >> > second FPGA manager on my card.
> >> >> > 
> >> >> > Since, thanks to this patch I'm actually the creator of the
> >> >> > fpga_manager structure,  I do not need to use fpga_mgr_get()
> >> >> > to
> >> >> > retrieve that data structure.
> >> >> > Despite this, I believe we still need to increment the
> >> >> > module
> >> >> > reference counter (which is done by fpga_mgr_get()).
> >> >> > 
> >> >> > We can fix this function by just replacing the argument from
> >> >> > 'device' to 'fpga_manager' (the one returned by create() ).
> >> >> 
> >> >> At first thought, that's what I'd want.
> >> >> 
> >> >> > Alternatively, we
> >> >> > can add an 'owner' field in "struct fpga_manager_ops" and
> >> >> > 'get'
> >> >> > it
> >> >> > when we use it. Or again, just an 'owner' argument in the
> >> >> > create()
> >> >> > function.
> >> >> 
> >> >> It seems like we shouldn't have to do that.
> >> > 
> >> > Why?
> >> 
> >> OK yes, I agree; the kernel has a lot of examples of doing this.
> >> 
> >> I'll have to play with it, I'll probably add the owner arg to the
> >> create function, add owner to struct fpga_manager, and save.
> > 
> > I have two though about this.
> > 
> > 1. file_operation like approach. The onwer is associated to the
> > FPGA manager operation. Whenever the FPGA manager wants to use an
> > operation it get/put the module owner of these operations
> > (because this is what we need to protect). With this the user is
> > not directly involved, read it as less code, less things to care
> > about. And probably there is no need for fpga_manager_get().
> 
> How does try_module_get fit into this scheme?  I think this proposal
> #1 is missing the point of what the reference count increment is
> meant to do.  Or am I misunderstanding?  How does that keep the
> module from being unloaded 1/3 way through programming a FPGA? 
> IIUC you are saying that the reference count would be incremented
> before doing the manager ops .write_init, then decremented again
> afterwards, incremented before each call to .write, decremented
> afterwards, then the same for .write_complete.

I'm not saying to do module_get/put just around the mops->XXX(): it's 
too much. Just where you have this comment:

"This code assumes the caller got the mgr pointer from 
of_fpga_mgr_get() or fpga_mgr_get()"

Because, currently, it's here where we do module_get()

Most mops are invoked within a set of static functions which are 
called only by few exported functions. I'm suggesting to do 
module_get/put in those exported function at the beginning (get) and 
and the end (put) because we know that within these functions, here 
and there, we will use mops which are owned by a different module.
We do not want the module owner of the mops to disappear while someone 
is doing fpga_mgr_load(). For example, inside fpga_mgr_load() we use 
most of the mops, so we 'get' the module at the beginning and 'put' it 
at the end. The same for fpga_region_program_fpga().
Like this we do not have to ask users to do fpga_mgr_get()/put().

<Parenthesis>
fpga_region_program_fpga() does not do (today) fpga_mgr_get() because 
it assumes, but it is not enforced, that both fpga_region and fpga_mgr 
are child of the same device. Probably this is true 99.99% of the 
time.
Let me open in parallel another point: why fpga_region is not a child 
of fpga_manager? (and then fpga_region_create can have one argument 
less and close any other weird possibility)
</Parenthesis>

I'm thinking about fpga_mgr_load() because, in principle, this can be 
used by other modules to program the FPGA with what they want.
While functions like fpga_mgr_unregister() are most likely called by 
the module that owns the ops; here we can safely assumes that its the 
same module to call this function and not a third one (if this is the 
case, then it is a bug) and we can forget about module_get()/put() 
(and indeed you do not suggest to call fpga_mgr_get()).

I did my best to make it clear but I understand that it is not always 
easy to read someone else mind and I'm not a best-seller writer :D
 
> > 2. fpga_manager onwer, we can still play the game above but
> > conceptually, from the user point of view, I see it like the
> > driver
> > that creates the fpga_manager instance becomes the owner of it.
> 
> I think that's what's happening.  And can continue to happen, adding
> the owner parameter to fpga_mgr_create.
> 
> > I
> > think that this is not true,
> 
> How do you figure that?  fpga_mgr_create() is called with pdev->dev
> from each of the FPGA manager's probe functions.  It stores dev as
> the parent: mgr->dev.parent = dev;

Let me say that I'm not advocating for this or that, I'm expressing my 
point of view (taste if you want). I do not see a true technical 
difference because mops are in a 1:1 relation with the fpga_manager 
structure. So, whatever is easier to implement is good :)

Just to try to clarify my way of seeing things ----------------------
In the reletionship between the driver and the FPGA manager, if we say 
that the driver owns the fpga_manager instance, then we do not need to 
do any module_get/put, because it is the driver that does everything 
with its own instance. If the driver does something wrong with the 
FPGA manager, it's its fault.
 
If we allow a third module to use fpga_mgr_load() (which I think is 
the case) then I think it's different. The fpga_manager is an instance 
owned by the FPGA manager module; fpga_manager is a token to access 
some services (like a middleware), when you use these services we need 
support (mops) from another module that actually does the loading and 
owns the operations.
And I stop here with this argument ----------------------------------

> > the fpga_manager structure is completely
> > used by the FPGA manager module and the driver use it as a token
> > to
> > access the FPGA manager API. I hope my point is clear :)
> > 
> > I'm more for the solution 1.
> > 
> >> >> > I'm proposing these alternatives because I'm not sure that
> >> >> > 
> >> >> > this is correct:
> >> >> >         if (!try_module_get(dev->parent->driver->owner))
> >> >> > 
> >> >> > What if the device does not have a driver? Do we consider
> >> >> > the
> >> >> > following a valid use case?
> >> >> > 
> >> >> > 
> >> >> > probe(struct device *dev) {
> >> >> > 
> >> >> >   struct device *mydev;
> >> >> >   
> >> >> >   mydev->parent = dev;
> >> >> >   device_register(mydev);
> >> >> >   fpga_mrg_create(mydev, ....);
> >> >> > 
> >> >> > }
> >> 
> >> Sure
> >> 
> >> >> When would you want to do that?
> >> > 
> >> > Not sure when, I'm in the middle of some other development and
> >> > I
> >> > stumbled into this issue. But of course I can do it ... at some
> >> > point>
> >> > 
> >> > :)
> >> 
> >> I was meaning to ask something else.
> > 
> > I see, you meant the example about the "virtual device" without
> > driver. I do not have a true example, but this is a possible case
> > I
> > think we should support it or not (check this on register())
> 
> I think we should support this use, yes.
> 
> Alan
> 
> >> I don't mind writing this and would be interested in your review/
> >> feedback.  Thanks again for seeing this and for the thoughtful
> >> analysis.
> > 
> > I'm here for any feedback/review :)




