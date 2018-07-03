Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E062C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6BC23DA8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="v+Lu6DKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6BC23DA8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbeGCCZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:25:22 -0400
Received: from mail-dm3nam03on0069.outbound.protection.outlook.com ([104.47.41.69]:5310
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753835AbeGCCZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+1ZQEgibWUz+h9zxGjJ+Q9BQb2HVzZ0dVeTgdhnzPU=;
 b=v+Lu6DKlQUcj441usm3NyUuo3T53Gu0TZ3e+Z5w4jgs752RbEdQrgcHXeRAmy480WE+KwANg3aZDARjhzp1XhyEBBmthbxpVvuL4sFOO9m0OWfzHqJ5xvw+lF4pe1w2RskZ1x5a3HxKWgju6m0I9PkEV4rSafZPMo72K1VoLyKk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 MWHPR03MB2640.namprd03.prod.outlook.com (2603:10b6:300:46::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Tue, 3 Jul 2018 02:25:12 +0000
Date:   Tue, 3 Jul 2018 10:22:57 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/2] serial: 8250_dw: add fractional divisor support
Message-ID: <20180703102257.678db6a8@xhacker.debian>
In-Reply-To: <59b14f97234271a7d859fa07f27bd66ec252ccc9.camel@linux.intel.com>
References: <20180702180428.331b36c5@xhacker.debian>
        <fef0bf484ead5e0998666168ced86438bf935ce5.camel@linux.intel.com>
        <59b14f97234271a7d859fa07f27bd66ec252ccc9.camel@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR01CA0001.jpnprd01.prod.outlook.com
 (2603:1096:404:a::13) To MWHPR03MB2640.namprd03.prod.outlook.com
 (2603:10b6:300:46::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ba2a934-37ba-47a0-6a49-08d5e08c35e3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2640;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;3:oOw0DTexi+ixbBq5HtfpemNEiCWgcU48f/g9Cy08akcjVHh/4ION2buxqK44zmkif9O9lBVIUUwc+SoLbbobq+xXo1MYuwtV1g9qm/IJMqUiImm9hZTqEKSlehnLNtvy62dbi7MYUXCZtJstRG+JRhOr+r3X6TiYOSxD/+GmU2TSU5nKyKraSDY3MeijGGLX0NrAutbY5qaTSpYARFfXWBdXxnr2cHCuj3Ryf4CXbnf4q6iLsMKkgdk9MBOc50Ac;25:1GBLOd+rdxBtkPrSadVo2tZF6x88hpwsw7U6yk4uYsXLEokixBMVt6OM61zt53HXP5Z5adcKo7Et7rhQtsdp6ZF6STzzIbHnS3HdYm2gb59NZafXHLk8N1KkIYjiqj2U5R4spBcACgsJcim6z/V7Kash/flfl8HOeWqmXCBsl4rS3hl+6RCV9nJxa+nNDoNR1XYY6vxRhuwmB9gBeO7+SIhZRggnVXJ7m6VvPhLi8xVy1KOZSP5GZ01llvfJUW3czO//qeq00/EMPTuevhGGSXmVBaFnrmy/YDIfpXwwSh/lrfcpOQjzTZWTUosphGc2gNarsbgR4xeVMI5VdRRupw==;31:pt8In0Xz+erq6HqQa++vkDoBQluGV7GJSrgiGyaK3ev1EmUtWHJOHZF1IbePYrv+xim1+HnPgpq9O/fWULgRwUqDeekE3WUk2rNtou9n1Jz9Rrb4B3ilYyXFnlNigyWUQG+bR1Uh2CXy9k4WWIyxdMSDSIa+HqJxr9oe96UOBm3dXsm4d4x17/W5kulIhJwN1detn9jek9/usoa2xNzWoG3Elq5rzZaoKPd0wL0SK5w=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2640:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;20:RsOog8PmDolRyDYcZ99j0ftqje64GTveoE8Veew5AsWVmG7rRCyys1Yu92Zbet6AwU++S9HC6pa6MyK/jVppt2g/S5P2MqTB3moXh5eEUqnlHNRgVm8BFeUfzAe4+LJeF+5qxUFHOVLiHpwsDgOMTp30WW0TwwrI+xbEzY+8qee2CgddFD8gWe2gO5nd3MexPrngiq0pCsrT3msnEIhq2QatMeEulfUT6KZyn9KzdJ7FWKZQ70po4JbXIwEVZAYR2wHYln9Y259W0S9YDZyd0232kcIhepisZxeV+D8B1UY+AbPBeaFLztG0nC8xSjiwFkEEoqx9E8+IFw8+0IUhuGUj2jW/3mu4FlqVE1fW9K33KxxcgvQO07Oi5aeNWV68cQ52Y0xXV7UnGlb42G3RtPCemFKCHpfbN8Td6LOZWd4bvzfTAaZARPssqb4VyrTI43aA/r9a9LqB+5y4IIX2KVvcFCxvnubvnobH7yTQ+/B4+r+bC4v+NbzRMrXIx7zo;4:PH6ck1mca/WkypnByyZxu58JqXfklthmjt8xW4E5SQUX6tKbpnewmwxCGVozhHyc8j3BuJep+f8g38mfC+KaQMnh7gGfdq7YWAdrY0mK26sLqgY9NzZ/TQCjgmZ6T3ZuHGhvoQtoU9db0+yvpIBMcJRK39wcSPUiv7M7SrmLPYUYZBc0lW82yLtv9WolefxmcQW+o4JA9xWQgrVS/accdD7gJwv5tub9WDOw9m66Fqb2u5yBesxw2RKBorm63LjUTL41SOSCdBXINCd5fU242g==
X-Microsoft-Antispam-PRVS: <MWHPR03MB26401DCA4C49AE3E9D51F56CED420@MWHPR03MB2640.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR03MB2640;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2640;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(6246003)(25786009)(486006)(105586002)(4326008)(956004)(53936002)(446003)(1076002)(305945005)(47776003)(7736002)(66066001)(8936002)(97736004)(3846002)(23726003)(6116002)(230700001)(81156014)(8676002)(81166006)(476003)(11346002)(478600001)(9686003)(72206003)(5660300001)(386003)(33896004)(54906003)(6506007)(76176011)(316002)(86362001)(52116002)(7696005)(229853002)(68736007)(50466002)(16526019)(106356001)(50226002)(55016002)(14444005)(186003)(6666003)(6916009)(2906002)(26005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2640;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2640;23:ugfl934r3Lwwk6LAL9tCH20KwuCGTL/cTS4vH/moZ?=
 =?us-ascii?Q?1cTPbQV5SQKCA/7nSg1mPcWuwFLFdB5R2PvFxtm6H2eNztCoC45VNbOO4TeZ?=
 =?us-ascii?Q?D67GF6pKOGZVJHMHxfv/XP351pbiBmG0Pij6ul2YQ6AKkKcXMSA8mHjX/ozB?=
 =?us-ascii?Q?br5BkIIq9mYSBY8QJYte39sZv5tNs/NbI7n4Jxq4pPVjEyfjhbWRiLtqllxi?=
 =?us-ascii?Q?oqiiFqCJuw5dbXwZnRHLhiE+EpYsFCXX1XOGna5jx1B3bK+TrZzrFt9FKy5/?=
 =?us-ascii?Q?fzyYtA2Gw0qy30CDrEeaqlqdrKVcab4IAVdj0Jmt4Vuce/8rU/43o3NWNW94?=
 =?us-ascii?Q?96MhDov3RpGE41yk1R97WMMSrGf/rrOn24bbJRMiOLPCDCP4dsaSpr4pgoIn?=
 =?us-ascii?Q?ofmihlPQkVvbgLF6pwQlVWm5XlBpbt7MLumZSxuIj1HBQzLOvZHl2EJsHrjI?=
 =?us-ascii?Q?BnViEvv2dRoXFxP8jY9T6XRPiglrf6WGvWC/E0FEwLgbSYD1dM+leCMqTA7h?=
 =?us-ascii?Q?DUCl/FXBLngFKreYxcn3XRGJZd7oPTptcugdwCkE2GriGlV8eyv3m+v8oSc3?=
 =?us-ascii?Q?OLQggRY99f9OSWJe/7UA9LNFGtt0P+V9/+K0CasrDHaIja32UouVtS81Xhil?=
 =?us-ascii?Q?Yqm2kimIeA6pETJu76ei3RlU/VahwTwACwROobgsU4gacg3Sa9TdeyqTXhHK?=
 =?us-ascii?Q?5qmAIgebj+lp/NQLiBWsfV4m6FbR2csK2bqQkYdI80Aag2bVIuW3VuYb07CN?=
 =?us-ascii?Q?bQeTafVQxpY63JCstp8HFOAoWRP251i2iNVNI85EWwuj5/rqBewX5CQ3PtyR?=
 =?us-ascii?Q?ZtvK51tFfQBHPH2v7NhXeolLh7F45w7HC3mS7SqhzgRDsbnEgG35NxMequpI?=
 =?us-ascii?Q?mgFb1ayjhcRL5DrTTWUMS/F+7Ue7F1h3Xt3bnQcMbCZHwoB/HC9kjvuBeeiz?=
 =?us-ascii?Q?FkXw+yag86VndCHhe1ZhijELhPfhzvBFsI9fu3N5aaQLBX1C9mrHTdeE46+C?=
 =?us-ascii?Q?CnDZKB1L6NWwt9NhCYqMgkqb3ADxI4MWdNVEF5GkEBZOTt5Vw26SlwxYPqey?=
 =?us-ascii?Q?QC6J8TlheRKE7u5rU4DdsWRRQSYz0pPEhdDk7HSMD4t79CZX7JgqocIWaHwU?=
 =?us-ascii?Q?sXiwVWl2rSed2W4Vh+P+JTLX5xR/t6Ez8DBZP/PLuBF/w2w2ciJ0eWCPSiAA?=
 =?us-ascii?Q?bUcpmqa2qevVhkgi/mXmXoJWPRfDgmefDy3m7ALazc1G5Etqcro8Rkh69dDE?=
 =?us-ascii?Q?G6XQJUcI47TK6KONZzPcV7iMhjPp+x+xZ3tPVUHTd5iOPZ2eEGx2jYHKRQMD?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: g2sCckrvICvBOAdM2LeDVB4hsMAEa+y5+WwjuEvGwrh0J/AuDJyfrt5w5SkuSzC4EZquNOGT3owLNE4+CkZ2V46teSxlUuRTWeKuWJCzb2vic/pdWRa0rCQpnFLMsP/JmgqUYWvvAcxZXpCAsAoSQWcgfWBqMfWZGkM/Mr80OnKGFvRgFUoHDhZBl8m6NwiR7wYoLrss6QU4uGdS20GDpRtsAddstCEINKMnXLH/zuLlpv7zcXg79tarbHGHsDtPECQz01bCWJE/h148axgE7iWMcEK/4drlftykNZOCu8Rw2jbIeTYA6un59EIcUx8/L416eJ5T0+jZSnk+oifeT8BpyB6z9WKBal7Q24YvbUw=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;6:xdlKMPB4kKJKUnTy6HXCOE/F9gPZ+WlwEs1/ZSV1LZ68dtXJ06YoUp+4M4z+2XVtAL1IV5TwyWb//b/yDb8h6PG5+p2VZYrBCchN5Ngkouq1asuCq9z5MTFctWv+t+oa616XDUY/aBBd/ox61Txm1UtrbKc5SyT6fVKFqfSQ6my3aoJRrTUvG6EkrRYQKQN0cpuuSaKLiHN7xrii6sL51DALakZz8v9zAtqf+EtJpa73QGfJo7Rplr5v4J3wn0a8wOvzs/clrC/AGkR8SCfCveoNFAfYYOgR6DVJPPaaHtgVlEWO8gyN5loncmQyBv8ICvWfa/OXpakHF4mouOsPzEYo+/qrC+CTPHXzDHBSPPdbW2UcNx+oxnxat0lpBStq9j8PMl33CZtdEZLWVtsu94AaTsb/a63livhXcbumUFxWd8zHJKcDZeWEfBQX9fOT62SP3gMTxPD9R97GjD2tlg==;5:xq0uk+A0/M2oaWxdMQzXwmR5lv5984V8A9LKgm0JGh7Zj0tFgjSWeqvzLd1vowA+otMviRsuLuVebOxZHdzcXKtffcAOPjJtjHMcmc4vfG0jLxbMntl4Ueo8farV00aH3ZbUY+cUhbIgkc7stpakepeNfZqSRfnjGgP3rotY9Og=;24:FEKKRb2y0jihMg9zr7PVsLpb6e/Wm7wLCOuCAIpHCkl96oYidP2BuuYy6OvuyC+VuQp1HUkAswnM+DDBzvUXJdph/2JYBYWW/n1rg0s6nVE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;7:TbgJZwXWsjRKQ/4emLsixVmdbJQR/MRukQ6m2taTmL3bp4lFYOlUTBTdOXW4riFbb4l8sqZz0hiOefRPS/IuXTYYXXp1p29YzWMAXajIC6aeGqq0L1pl7M5DhkOe8XA2843L0iFrjtlcwmkihyXRNLQC1tWv1uWcXoSwaQerip4mkpJa31dE2jM4Tgo2tuaZj7b7ZJ7LhPzEmiIUoY4bXd8kgM0Y2rSGZJfOzjDyHKvXhRZFcXfoK+fp/TIJu/bc
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 02:25:12.8867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba2a934-37ba-47a0-6a49-08d5e08c35e3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2 Jul 2018 14:51:03 +0300 Andy Shevchenko wrote:

> On Mon, 2018-07-02 at 13:18 +0300, Andy Shevchenko wrote:
> > On Mon, 2018-07-02 at 18:04 +0800, Jisheng Zhang wrote:  
> > > For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> > > valid divisor latch fraction register. The fractional divisor width
> > > is
> > > 4bits ~ 6bits.
> > >   
> > 
> > There are several serial IPs that have fractional divider built-in.
> > None
> > is using any specific hooks. Why do you need in your case, esp. taking
> > into consideration that we have a custom ->set_termios() callback?  
> 
> Okay, I see that in 8250 we have hooks embedded into 8250_port.c which
> is not the best solution.
> 
> For example it prevents better splitting Exar code.
> So, we would need these hooks, but better to integrate them in the same
> way like it's done for the rest of 8250 ones, i.e.
> - rename existing to have a "do" word
> - create new functions which would be a replacement that choose between
> "do" variant and custom one
> - not sure if we need to export "do" variants (at least for now)

So you mean add the support as following:

1.rename current serial8250_set_divisor as serial8250_do_set_divisor

2.add a new serial8250_set_divisor which will be as simple as

static void serial8250_set_divisor(struct uart_port *port, ...)
{
	struct uart_8250_port *up = up_to_u8250p(port);

	if (up->set_divisor)
		up->set_divisor(...);
	else
		serial8250_do_set_divisor(...);
}

could you please confirm?

Another issue is I'm not sure which struct to add the hook,
struct uart_port or struct uart_8250_port? Currently, it seems that only
uart_8250_port needs this hook, sure, adding the hook to struct uart_port
is fine either. Could you please kindly give some suggestions?

Thanks,
Jisheng
