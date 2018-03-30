Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbeC3JEe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:04:34 -0400
Received: from mail-sn1nam01on0053.outbound.protection.outlook.com ([104.47.32.53]:51529
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750764AbeC3JEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:04:31 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Fri, 30 Mar 2018 17:04:13 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] net: mvneta: split rxq/txq init into SW and HW
 parts
Message-ID: <20180330170413.73320f7f@xhacker.debian>
In-Reply-To: <20180329134259.3fe6165b@windsurf>
References: <20180329181220.61d63c92@xhacker.debian>
        <20180329181356.6489ee2e@xhacker.debian>
        <20180329134259.3fe6165b@windsurf>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYXPR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:403:a::30) To MWHPR03MB2640.namprd03.prod.outlook.com
 (2603:10b6:300:46::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7876f1c4-b3b3-41c3-1c09-08d5961d3e0b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2640;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;3:IAMLnmq6V/FwqQKl5z2XOHLUGuA2pohq6ZM2oJaCVjbKPB0XNr9Ylhsd04qW+VZYFTno84f796rl907KdlYw3dcGflbjsVBUpL+ZhHYd9F7mQS/qnitm5H1kC9Cq0KwRz/Wj37b7dYGaMpxykBSHwF712xX1AE0kv5RT5F70gkq6gHss3N1b0+y3bkYRc/HujYsxH+h5f+JqmTNF6WrjK1Oc7mu4/8+WZEpv7drE52o7aGhS25KpNV41wZnNrMY1;25:tGMXf7LTwfhva0ViWaIpJ2kb3sQ+XEE5Fastzg+SafpnWXH5E2UvuXqvl+nSszN6U8X5/TMFWs+pbf+r0W3RDG8N3WRPXN05Wp6DLVCtqFaNQRkBzZXFryuivEtdR60t2AMieodz+ZZlCe8NLH43hdTPy06jjDRVtw22Kb2zRk44uXD3jSI5pfBP9fWrtsqapLQk3HO6m4twhigXDdBZ0BOGKaLHA+Vn9mro7WRknSSJdWcAfcxwPv/Od5FFs9jKYILXwxssFpbMduSvEAc1ULNbbWEKAb6E9QgGF7GVE4sQO6woumr4OlWa04Yelddz+eJTuLLxUIaF0opntuTF9A==;31:FFJneznd5i3ant/BNBIdQO1wEchQXWJl9agE/hAIMQ41BY0KsdhEQQ7kJ3IFbdHHVFIgyr0edDeo6ry1turRSyFQTTbA8SEusuwDWTQ0lPuMgCoanx+jZAMcAuW5qxmZZWSYMI2MA4KYr6Cxr5ZMlwu2rYhjjlfhwQguJvA6ZrVWNp/z/+rDAa0ZTXifUq1ENxqIOZZXA+OglnUeWu/IzWle3SOW6ZZsDqhjsDY2pRM=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2640:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;20:3wsXQ2rJ4D7864jvolYxTytEQVZtd6q/9O/9zqesUtIHce3MUZ123iNSGuLVF1+fon6kogqiqgYsS3cWsD3pRPmrthSjPsrRJbOhspUJBWergJtjryq4TWCOUGZVMwtd0rS9Sl79281DobU4LSqtrmTAl7g6uCP17RYpIGx48xccoo97J+ulqQphcS04Libizy85R3Yu2uHGW4kwXCnedlYAMOhHflEB0J/OCA+eYKtztq9iGxtBO3DQm1NzVkVWutNd5bXY6gMYWkMkuGIAXoGx4k1Wb2i+G2P1lNbyR1aJPj6rSu6RbcduBhtEtkZJQlqgshdoblCFvj1smeIupOtr7MWnJiSIFVNH+KqeiQBKik56e4+OofUZtVjyJOKCDpNm+tYxugbIJAwkW+P2KF6z7Petd3+GDD+hhB8+ko5IavzZnpZCMNlSzSw5el0WlrS1wwHF6J1c5dZk+CHDb29pcmHM4yTNVU9ZoP5pn026NnColx3n79VUeoE0RbgL;4:3hnCmhd+nOcqJuQPEStwlb2Rnup54X8KKFqcPmSJxLkELgsrHjVHDvC6/SWmMinsq4Ak7R210GXy87lE3EEeeJRDmOAcYPlMxGPjEGvNHDkIEBP5lGuzXU3xKzpVOsoi6izRqCTbWecGGyhhbV2aEbTX6mSqscGCKbQXeH0S9v6Ji/pO24rmIQj0E8oiyDDN/lRy7FkRg+MgnFw6G0sElBSBFhApM9dkMdfaQ0r1kbhuq3ScYlPIgQ4pfIUrq0UCNAmg2Jzv6F8uEBt0FNAREg==
X-Microsoft-Antispam-PRVS: <MWHPR03MB264074131696753660F749F8EDA10@MWHPR03MB2640.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR03MB2640;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2640;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(39380400002)(376002)(366004)(199004)(189003)(230700001)(86362001)(54906003)(55016002)(9686003)(72206003)(6246003)(6916009)(106356001)(8936002)(478600001)(105586002)(53936002)(97736004)(50226002)(59450400001)(4326008)(33896004)(229853002)(76176011)(5660300001)(316002)(476003)(2906002)(486005)(305945005)(486005)(47776003)(66066001)(956004)(81156014)(7736002)(11346002)(25786009)(446003)(50466002)(8676002)(81166006)(68736007)(6116002)(3846002)(23726003)(52116002)(186003)(26005)(16526019)(6506007)(386003)(7696005)(6666003)(1076002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2640;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2640;23:QDNcXTPnb75pOI8xDFPlWJ0wmvgRBq9nM1AkeG43l?=
 =?us-ascii?Q?BaimfDfKhalRGfCcGfU+IH8Bg6yj74CpyAjLpLdoTHy4HE8Bme/IEebw8+6l?=
 =?us-ascii?Q?hPrlSOaWQKs7PsEcqyvkTc5qcElMNbGUtsCEjtImmP8sQlFduNF34V4UXhzF?=
 =?us-ascii?Q?iN7LbUEDvPrp0JaMQXF/T8xmRLkIyqLPe98aX0oBqoKb6en+T/FlBWgqJUa4?=
 =?us-ascii?Q?72ly4mTXlJexg9PYvrn+PlNtqVro4O0IiRqytkXFW6zFOqUT43h7LgS93+Sp?=
 =?us-ascii?Q?NhsZ6V6VyowWaAmDcV2PguPFdJWawrrkvw0uJAEku9ZRf7HcQACLAnDkAS8m?=
 =?us-ascii?Q?84sEy3QJ47DnMO6qWNAj7XNXCuE1tQ585utxvSEUKspOK/s7yLXTM/XqfZeS?=
 =?us-ascii?Q?L22yWZVXt1mRtz68jj7Aw+meKqxrEQQUykMz27IARgu4V2E2BM23tN2Oh9DK?=
 =?us-ascii?Q?SoBph4c1ArhDTEsklSdn44dU45kzYyPlU1MftXQFpntk0AgYagYKZ4zi2bVD?=
 =?us-ascii?Q?M2mAnxyNetCAOLchoXQE4o9eZmU1o/+AqGNyrKTKGXxrtVuH9Hxj1jHi8eGa?=
 =?us-ascii?Q?g015Q99a7UI9lHAFElBf7thGillOH+O7xA/yi/Wk7iIPBODZz76TgVZkRhry?=
 =?us-ascii?Q?+5IXYPG5FjyLiAk8GaikP6IfIP7cJQWbSnNIbOmXL+odSnoPQxzFyDJeT6GH?=
 =?us-ascii?Q?bzmhgncu7LmbmlZEvFaCq/YQZZEl1pbg4tNCLm8/NytsBddEC350iIHPSy5b?=
 =?us-ascii?Q?RLqEz8LpMnwF7fdtXQiC94zdkb01szqJc5izhiYCbK8R0NITkcOvbA4gGTTL?=
 =?us-ascii?Q?O1vcStgx+CMUlNlrq+OoRPELeWw/gFQSBu8ZbYwTqRcKPPW4yLBPAi/IdDbm?=
 =?us-ascii?Q?Ou8RCoVYYQZF3T59pthnnmCwXlCCZlgUclHG22bGeC3oxlXIwzEqRF7KBJWU?=
 =?us-ascii?Q?vdYKWHokwUsxxEjUIVCjalFb2bjbLFD6/ep0Fd9Kfvj45ok/1UmBxRlTA21C?=
 =?us-ascii?Q?TVU3D9BKhxsluAbKeBeUHdgDrJdLJF8bUZMCFwItzkxs+Hg/vVxuvZ5WLYmx?=
 =?us-ascii?Q?8NRFMQIAevrGlA9u3kBeirDSZ4Tao+8MNqirZjyORjfr5M6u8fCejuKY7C0F?=
 =?us-ascii?Q?aL5FUaxG8EmBeTnMXQYYxMsVg/DOvhWSPL3AH2ugHkWakOyDmOD+WuJ73a/2?=
 =?us-ascii?Q?nO6LpJOYQNMQO3XkoqKLQtGD2shjrB+CaVemb2/0ysOz6eM5KSl3nkHuTHSe?=
 =?us-ascii?Q?FxKNUntZrEg2Mj/RzIH+ZryN8GiTV54wsQgPyADgRci9gFMgUVoFAexxh22f?=
 =?us-ascii?Q?5yX3qvISYoye3eAB7uIBm0eKHqkdBg/BJXR8LKxSGGl?=
X-Microsoft-Antispam-Message-Info: GHpUxnEuwUlVG3HTjGh0rS40kU3hDwXAjEDu7wJmLb6awIGJlHE8lH3Cl55SM1cNrHMX1J8maCcWzbWXEMF8a1tNdmmONFK/RMB5cuv4V1ViAxx8RV6lvSRno1HvVeJW5YOeoWbXXmmxWZmvLvQzhvT9AE2lurdCGdg0UDRB+0qwSlnNbMACuIuzs1Rp9r8m
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;6:hZ+/9wKTdzZfHCdTjwjkMwh/qdDEOtFREqvuMEU8ciVYC6QNe16P5tOX8nOFDHAt4WwlVxNvu0fRGA91MuG/VyQsRIYDZjP8FdXxRzg9YlCXwY+bRK25Ov+N5fInS/xi5LJQ3T2/Ic+lNpncgofrNxLwu/ol65uB1LNbgDygHZHE8O+jwDnl2m6qtyT6y1zwdQt64+4ZcCVrWjsacEAFgXoKeOLAGm86MbyuN247cOuX8uRIaIscVBcfIzHgB4EbKaHSektXVX1tRNZfKFE3A7M0T9w+3o28qcJxA7VepcgjHbbbc86sCmaxeUa/8nktRrLzxB9pNTLLQzI505lUciY41/ABcHold3mT48ZNanRdRQIchA+ulXUHPi1RpD+TjFysa2VHbtnxURCu7yvR+GF+JSdP4jWOfl5M0gvLqDu49cQZJmiIPgIKG1aIMMnsnJ1jybBRsTEm4V7xuvpOxA==;5:MrgMNq141JelsUV2ZgEbjYANEKjn33f63b+6pnGJ1y1M8KlVkPxsHeG4p5uCcYAqxEaSN8gJHPjINMbBh0wTx6ZtkKnVWOakIBjKGlRhfVAWXTHRc77GUtPuLE77wK7DmUX5mn7yGN4hvu0JpZtTIQnqT4o83izUSXAnRR01O8c=;24:iDLyQ+BMb23XPmebEfuNS/3dUAIdnL+0mUEuTg6RZP0VP6g40apoL0nH4eA7zG43LfNU9oJmn7FBE9edI1VlsHfcHVyfUxUMA8qqpz0JEyk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;7:O47oFk23ktK67IMNb/9QX13+zylhWUqbFjXEjn1GLNthwB1/NfQPeMSOobn5z4EorJhqV9Ngvq+zrpK82jdQRvdFgPyLSlJTs/UHuYAZEv7/gScw/w8MEDqOMMudd/WJWpG+6YOqFNqF5ubnHw9fKO+zq6Sgp9x1LHYFBoe/qgc1pzTvbY3TGDQ3e7pVV+LxOCMQJ0DchzD/gk4LCmajBgiSL+n/EnnVoAlmV8LzgCcXYcMdVdVnxqDJ4uI7l6ql
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 09:04:26.8801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7876f1c4-b3b3-41c3-1c09-08d5961d3e0b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2640
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 29 Mar 2018 13:42:59 +0200 Thomas Petazzoni wrote:

> Hello,
> 
> On Thu, 29 Mar 2018 18:13:56 +0800, Jisheng Zhang wrote:
> > This is to prepare the suspend/resume improvement in next patch. The
> > SW parts can be optimized out during resume.
> > 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>  
> 
> Thanks, I have two very minor nits below, but otherwise:
> 
> Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks for reviewing.

> 
> > +/* Create a specified RX queue */
> > +static int mvneta_rxq_init(struct mvneta_port *pp,
> > +			   struct mvneta_rx_queue *rxq)
> > +
> > +{
> > +	int ret;
> > +
> > +	ret = mvneta_rxq_sw_init(pp, rxq);
> > +	if (ret)  
> 
> Here you're testing if (ret), while in mvneta_txq_init(), in the same
> situation, you're doing if (ret < 0). I don't have a preference for one
> or the other, but having them consistent between the two lpaces would
> be nice.

updated in v2.

> 
> > -/* Create and initialize a tx queue */
> > -static int mvneta_txq_init(struct mvneta_port *pp,
> > -			   struct mvneta_tx_queue *txq)
> > +static int mvneta_txq_sw_init(struct mvneta_port *pp,
> > +			      struct mvneta_tx_queue *txq)
> >  {
> >  	int cpu;
> >  
> > @@ -2872,7 +2889,6 @@ static int mvneta_txq_init(struct mvneta_port *pp,
> >  	txq->tx_stop_threshold = txq->size - MVNETA_MAX_SKB_DESCS;
> >  	txq->tx_wake_threshold = txq->tx_stop_threshold / 2;
> >  
> > -  
> 
> Spurious change.

There's an extra blank line here, so I removed it ;)

Thanks
