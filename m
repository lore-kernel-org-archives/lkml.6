Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E7CC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC6424116
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="XLHU3NN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC6424116
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753404AbeGEG4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:56:55 -0400
Received: from mail-cys01nam02on0076.outbound.protection.outlook.com ([104.47.37.76]:50525
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752773AbeGEG4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZlL859NBJnJx/QN7LCCaDmWtXHbc8VoU/rlOjO2oIQ=;
 b=XLHU3NN07X9dxqiFpow8bKnM8UJjiwcn0AgrxkrSNg/EGfFPXqyG5VJb7iBjuqEjDDBGQVFBicyJzvZSbxgHke8biJH+kjFBIQwBmY67G6zjiOcevsGY0Nk7COI2/KvrQXf1+jVygjBUT+/Ba+vsuafFrKaFTiyX5vIfxEBwfSY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BN6PR03MB2626.namprd03.prod.outlook.com (2603:10b6:404:59::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Thu, 5 Jul 2018 06:56:48 +0000
Date:   Thu, 5 Jul 2018 14:54:58 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 3/3] serial: 8250_dw: add fractional divisor support
Message-ID: <20180705145458.7e7d9b9f@xhacker.debian>
In-Reply-To: <20180705143921.6a8aeb50@xhacker.debian>
References: <20180704165908.4bb8b090@xhacker.debian>
        <20180704170310.56772d77@xhacker.debian>
        <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
        <20180705143921.6a8aeb50@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:404:56::31) To BN6PR03MB2626.namprd03.prod.outlook.com
 (2603:10b6:404:59::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5697dae6-d96b-401b-cfa1-08d5e2447b6c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2626;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;3:DwYnknhyMfBHSaznz1HRzqFXihMHqEwLikQKOTkg5KzxjztkMlfrKsh3LqLsPzqOBqC2ky5F0jqLiDvxIhuHW37vZLBPqqbsihmKSnUAie3uybGUzA6IW/ITJ8Y0XmPBISXJJ79ao5WB01IBWO/j2YJBuOHA657irQUZZVAfVQPGsYj508vmrGpiY3h19OVRybpkJ5ihs8OJLVryNsq3Sf0U44Q5/r5q+xLnoIgmpn/zZPdv7CXfRNMORbz3VJZK;25:RYM3f+oGKTFkaG+8pAEI2ZM4MtYtY0m8t2u3kXuHDKgZEGg20xLWL5KTNode3uNq+ZXYqqsNPqMH8J9+zszaGdZPERs8VGkIcikLPMCCsfH/RZRt9weBtKfMgWnw6qDqPpuHXoofL841guF2r+CP/3YitQMOAVTLVCVlKF6jSOhIDJ7GunWxluh6JIYZFoZ4B4klpEzir+ltuNBsoD7rf0X+FaVY7LtHqsW6mLHduEMQ3hz2bBBQLgTicl8byqwKWkjtL0ulTtrDU9lvOGJTFSPEzJ2M3Mipkz8/AznJx1kdt7z4lbPDFNxbMjqzPfcwLgy2Jzj1E0MHmcUWD8QODw==;31:jvG6WMHGGBAzPG7Gd4ALvlSHd35hauRLE8sOL/ZhaKS+SWQvRtcWL1d6FDhZZjKaMTR5OtMH7MhZJguakyqRpYYFrT6TuGsORQjE3OUKQJl5+q14EilxGAIlR+yHv/dDcErvDcqDN6gEc8ufDvmBciJv3gUFvMom3wsmrEiVtjwx8HDYrvVWyXpuhtvT6u/pcDs1uzSy86WTdcxwRerjuqVeXImLCfwV9ZYFutumZmE=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2626:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;20:kDLJmNp0L56nNuC0z2WJ8qNXLo1D/DQZ0NckLrtOn/ZvQz7wnr9ixNbqXtsgutzs5tynN/eahLT/0hKeSjeD03Ss9i898HuUVSixPtluA4gQXqaHJ/5jehcuO+D7GkwCccT6CWkeAX137fqdwCWuNnVil4dJdoC4t7aoo+Onq+zuZkeWtzmQTdcJ2iSmcXPshuX25OkIjNUkK77RIky0oLvyZoYwnJzeFr0hH+TGoxJETq3a3840qnUxlzHEaCTOpo4k7CtYGfYwoSnlccGZBp3QWYEcu5Red+AuSh7juFdLTM2/6TvbnJzGwLETXXmug79xJ4MfPKELNQrm7/HMwNeKH7PD9uqsUB1mYb8aacaqrlEK680pK2tgPmYdQ/X5JRA4rcVLEovjzQLBlV3D8HAMl8P0KiMJqoOJO0fCPyNmWMZp4FNvfBN0A/KrDcNjefJVcNyTc8WaVFpLCugmlYtyZ9gUY3f+r1q/HcPGadOwZbB8djvJuNdDWiDW5/PO;4:Jd4GRAsyua89e3SO1q/GyTwShPFZ3oh3f+3ZOwe2jwCMAUXtFTr3ZwHmVIxKGRDvlWzFQinR3b7TBRgo+gC2DLqrsq5VSk2XZHTAADGMS7pkNlvIAEbnulImnfz7tHf5A0vPuwvKpm7bA0mgyBqQhMNQ9flFCJoleKvsWb4Ff86fw2I7yStikz1G3nICAG2PKD7NaxaMUi8R0DuJLBJdiQ/h4vc7SQ8rsVqJep9B4asJnp5I7IstFQOBTFYcvr6B9yhLoYJBg3GqYglyi5pF3g==
X-Microsoft-Antispam-PRVS: <BN6PR03MB26262D1D5D06E5CB064235F4ED400@BN6PR03MB2626.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB2626;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2626;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(186003)(8936002)(446003)(106356001)(26005)(486006)(2906002)(33896004)(47776003)(476003)(97736004)(305945005)(105586002)(478600001)(52116002)(25786009)(76176011)(86362001)(50466002)(386003)(6506007)(50226002)(956004)(66066001)(7736002)(4326008)(11346002)(16526019)(81156014)(6666003)(1076002)(81166006)(230700001)(6116002)(316002)(7696005)(23726003)(72206003)(5660300001)(55016002)(54906003)(9686003)(53936002)(6916009)(93886005)(68736007)(8676002)(6246003)(229853002)(3846002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2626;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2626;23:PMqNR6qyXSgnemDlFjMoNY63gLsQL1q++DK/DALm9?=
 =?us-ascii?Q?xv6Pkx00RL2vQjpANs06ZbQfGRdpJ3/WI8D8QcKlGj/Xy4+1+9QJO9JC568i?=
 =?us-ascii?Q?6lDk1hXvBG9i3cB0a709/GXuOwt1UxE76WPV0SrOToVUNm8kxK72PCreRSDO?=
 =?us-ascii?Q?r2obta8e/T8fWL3QaeiHg8ffivgktLwwwsgVpdTPhzvKhFM9tMsHW9ECHXaN?=
 =?us-ascii?Q?MHqDkDJaAg/BrBHtxvM5ok93jGQRyegeedZsNgwfB9ZaqmMV3ByL7WnJhx2Z?=
 =?us-ascii?Q?1EKO6GW/7FNECbBOd5uAtMDP7sQsBNmseqAUMq6jssznm5G8PyF9D2negNfw?=
 =?us-ascii?Q?W4ldh77t6EtOcrgHWfalQNwSsqBNFWL89rlvBFmq20ZnZ0dPbH/DZWIJWW4I?=
 =?us-ascii?Q?CVEZnXYivQ7SOEjNWUxtoFFobp+V7RxiTNlcSyxZNFKu3Qd2RcyvGyQmERj/?=
 =?us-ascii?Q?WPO/ozfK3cUU/GqWWfgzm6rEWLh5KccKl8D0Sg2/8PCUHtkAu0jXTezsk1fy?=
 =?us-ascii?Q?td4AiahCLolcTKpm3om5MskUExDHUD5PbS6mxCr5WNj9Z+NZCNIRV0BODXg1?=
 =?us-ascii?Q?iGhetDcY0MyyXsoUKlrFhkfWxdw+k8/lx9tCYr4tkRMSdjSOMA3BnDIag9L+?=
 =?us-ascii?Q?gVtqgTCtv2wiTCzt3kEKc/umUNKcBakL8ySY8iTyNs4GRERcujxfjCPrb4kn?=
 =?us-ascii?Q?gi1Xv//GQ1l6LeTf93B1uQSM+aEpxOAUGAeWzuQlmi7tBq4EAg8vGz1ELJ+I?=
 =?us-ascii?Q?SrZX0C7QrVzFDr30hhCnIHJlCFXnPtB5eze54sNRwnqxPWE8TIKCtevIQivn?=
 =?us-ascii?Q?CAAacgznYp6kqMiBPfOF2MGsIF+yL/xA/eLG8380jN3cbGWBVMghjZ3J4S7r?=
 =?us-ascii?Q?xv/23lkKpUshosVM2qhVYUxvykGt0p4GAyZKgDeTBQJe6kG3qpacBxNX54/6?=
 =?us-ascii?Q?xtOyD3G9CuC3v+KbGyCASUf+a1i1LAKKR/tW6BTo8K0Qx1+/IYomWP90DTbP?=
 =?us-ascii?Q?MrI2fj8e6kZq62NAGhUI5+c803WKxutXQb62uxMIkBdaRdaAG1Z8bIxLndcW?=
 =?us-ascii?Q?RgBTuipPKKo1e0oGBZua8YurwnTg1kTvcgX2XDQ7nelxyHLQdNDAtsB4B0ys?=
 =?us-ascii?Q?kHBcQ1VwTc4Nk30/WqokDINIWfFn/empFIz65Lw6PZs7mys4rbOE29GFYu7K?=
 =?us-ascii?Q?hWq9Totsv7EhT9qcbz5uIsC1L6jWzt9n4T84w46iwWbv10REhyIAdMXxlTzM?=
 =?us-ascii?Q?W4IERWl0dAZz6OWbOQYy2bDsctTHMxtTZPFEKoTTInYJMotw6Tl5uUmSrXgM?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: 0VnieKBMpBLuhCvRcupn5vGO7f8Z9WutwIjS1utODPxTIOLwRIspwm+X8txCBw6H7hKNqVh2pk7Xd+0Y2OFSaqxaC+BRndyF73HJjA/89SRMHLw4ulGYMWg/PtcpEsB7UdEy/VTU90E2fYX6Ad3DF5nBX0LspkgKaP0v4c6ZYPUXu7w3DFNVIJKKTNoCr0e7Xlva8M0/J7tuHqesgzFQaB7oyp7ntn1Oe78M58AjCj5NBL2voCaxZs1hvts+YvAAQeXcQu7Ofm/S11uhbynKH901Rj6IV5iWCyJaCnR5ADgXNR7JeJumstq2uMYqrNmlrCh5MjdyAAIjundbx5EvokRfdj+xyByk5DMe4dV0RWU=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;6:UXnWdaoPhO5d9lDrPkfD1Gk6WlwKGQ96HDVH2tAZM2diHas5IHX/iTiHeIPQZgHjyTAruc6Rn0AVSX0zTDVzRBz4vCk18/6JX7SgDzmz2zHaBvw9SDmLxMISB+sttjfcWAAhgpXobwOWoPzqSkRu9k/aCp326prSc3TvTFKZKYJT1CAExcHAV9EeErwfjl21gRoatE382SUUS0Gukg1NKXU+iE5mXK/eM2TZqICfvetaSB305kRkmW6hpN25qMgNBxme6i0kjiGAzaEahurO5XB/MusmEu9Le4AXJJ5jUPo6t3A184Q95POgtKAnE34Cn2dRpF5181TOdKn5uYEaB6PqSuvmJ//68w1iex+onepz8ZdDtJQ1RTCVTyEqdSnNmxV6i9xKITaJMPXdx3kbb7bL/bUlvE+kth4Ftv75PX2ZL3MQYQ7YVKXOvBB2fLZJSLRslH6yk5vFeV+Yml5Inw==;5:SvrvLVpe3g23Pc/Z+X4/JPmV7xZNQbzbUqTynmisNz0rJQgRNt545D5CDyPZoRCultwzwUETsE4s3d+jM87WA/ncQXwgDO+rG2DOWPw6m3VLF34eHNIDSy2iJ6V2VxZWHnUm/wLbodGnxDQ+2JezYKnFpmykhhfTqflmIkxi+bI=;24:lgpga4cerWeuqYJ/G3eBnhChC5fUzeb6EfOrwPVIsOkM34CUWwPfdO0zScO+gwUJ1RX+AjLVkLdHHoevL0yt5ojOa31XwF4XwBplYjr6rwk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;7:7DL5PM7uEUcQMLD37xS7uSkpYHPxMaEWscoRhMB8iBuVtcSrKlgCDefGrfYDwjhpqHw1eCxuG0Q2tiT4Gqr534HRjvO74Dyhn35HCy6EebjmbOUiUgWOS4Jy/SaaZGI+dMATlEU4VEGj28bDxjDQhtS7q9ybMoMxveC18NG/fh9dJ7m8W4nK/1yDt94qQ98EdKUZof8Nxa911QUk92jGHKowWC3zRK8O8vawrsUYFpjgxRQkJ4lEJmwMoLhrSr+C
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 06:56:48.0730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5697dae6-d96b-401b-cfa1-08d5e2447b6c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2626
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2018 14:39:21 +0800 Jisheng Zhang wrote:

<snip>

> >   
> > > +	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> > > +	serial_dl_write(up, quot);    
> > 
> > At some point it would be a helper, I think. We can call
> > serial8250_do_set_divisor() here. So, perhaps we might export it.  
> 
> serial8250_do_set_divisor will drop the frac, that's not we want ;)
> 

And most importantly, serial8250_do_set_divisor() will set a wrong BRD(I)
for fractional capable DW uarts. For example, clk = 25MHZ, baud = 115200.

In fractional capable DW uarts, we should set BRD(I) as
25000000/(16*115200) = 13

but serial8250_do_set_divisor() will set BRD(I) as
DIV_ROUND_CLOSEST(25*1000000, 16*115200)) = 14

Thanks
