Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E306FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEE42086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="nvvPGg/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEE42086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeH2Muc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:50:32 -0400
Received: from mail-eopbgr700062.outbound.protection.outlook.com ([40.107.70.62]:25824
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeH2Muc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9ZpEl/lJ9Hr5+fWuiuYgBFBjl8lxrM3L/oK3YtFF98=;
 b=nvvPGg/URmgs/02Nde1GaMHz7UQ9Yxgz0gqdK0tez9ImVT/ax630qguQIm8bJ/0Yxwfh4TUjGuHswqhPuQoxqu0SNtNQzsaFVEc187VNNMUIgxRC4BUdH8JstxgB6KIUNNmpRRBMaY5JuL9tA60AvyfVKGHfUuNTWSaWWC8+bzE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1577.namprd03.prod.outlook.com (2a01:111:e400:529c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Wed, 29 Aug
 2018 08:54:33 +0000
Date:   Wed, 29 Aug 2018 16:51:31 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Yelena Krivosheev <yelena@marvell.com>
Subject: Re: [PATCH 0/5] net: mvneta: some bug fix and trivial improvement
Message-ID: <20180829165131.52798cd6@xhacker.debian>
In-Reply-To: <20180829164024.41e8439d@xhacker.debian>
References: <20180829162456.2bd69796@xhacker.debian>
        <20180829164024.41e8439d@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OS2PR01CA0135.jpnprd01.prod.outlook.com (2603:1096:602::29)
 To CY1PR0301MB1577.namprd03.prod.outlook.com (2a01:111:e400:529c::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25f06e09-d543-48cf-5024-08d60d8d0bd0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1577;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1577;3:yA2gbSeo/SPDV5vD3PFC2uvzI4UGrR4GX+pFuoFoMfpHIPgsh/StLd0DDqKptOBXN77l0DnIFnSYBQobdIXkKbtGBR9U8WQeMjx04faQ+lEDImb2f3x5nWZhVZNNtwatwvzD8o4lZE44r9EYjrqTw1bN4889kEb3P5NrPM7568rRiKdt7XszFsA2rs3fwZvkSu7TkEC4M5XeybUQTDAiMa1qvvsEfMK890TrQ079462OcmPwFn+BSFrQY5DUaxfQ;25:8QzQpfW/zafeurzCISBFgs6EoZQZoCsPUzdwxsuhkz+dPOToHsc4ZtTG03WtTViqLdta57YhsULEFQeISzMP4Z6n3/FPU/LST3O0ffGaP+PRBN3Lff2ESzzI+bI7W2oV4NxWpnjrwNAz8zFSyt+J6/Nns+fMyjkm7jYXZaCSy5O8fyy1Jukj4B583dcJvL+zHIp/aGBP17FelN12Vff82z0i/1DmxwgM0/w0X5/hW01AsGFWkgW5yD7WtbKM/RO98fQARvMoJfvXObhzii7okCpYb5Yn00pDvDX0A49GciJQ5wb5BlKdSMACw/o+TfkG8VYrn23hzUWvrwaBexMGFQ==;31:q+q63Q/W6QvCbjXVumQZNkRDg8JlmRuzZMWVQFZQU4L724Kwsclng6h+ui+l6QVX34jOgxkOybEtzImTz4cjyE/CnghPpNF3zFcTk4+d8l572tr17bTtCa20N2/oInJ60b+H2fF+jwS5+oJVxEoWyNp76G74/nh2E4xOAE+Zjf1qwDl5lH8FJicnJG+5KCkJ32bSYAqTbB+NOw9rDsgM1Dwf3Gd2aCkj7nxs9tnpklA=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1577:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1577;20:MnxXvrOfZ3VemNzAEQ1iTUItN9utBmINfgMuCOGUTJ9t/41aH8+MgataVE90qXl+itPKe0v6L62VyVF4Br/UqyRpFyqd4S9Dhbb0dDEThHUDsz/CsHxfKZqM2K0gzs4yBg65w/p6Ja15a+/AOqB6nInmaONH34xIj6idk/CzE/Hg5IJzEBYMFoUQPR+gEfMX4LPaFwEx8dgov1o1HUfnefQVae77O2i/24obm71zNbyLNrZzw+fzQNDUnD0499VvdEo+1dHvuXY7nTIo+pNjCtDfmQQkzOXBkFE4ZqFtUT0+/5W1dwzqFinERVWQlpL8NX7xkG9Ll1uM7muc2yqZAoxGh6/sV+AveGmPJJy2tUXddYGGt0zu/2CqmsM/mufFORNpRRhV7heGZyjNWNFTXDP0Z/skkoJFxk1vw2XlFM7j9I0B6dCNQdLyb5uj6OzRGJXWUGT/ll6eddktpge811wx0/C4TP8rTsxMb4YPPtVOXfdfdfxhELylwVWBexsL;4:z3KwbDEhynL+vdbqfspKsOjp9alHkVfH/MIdRNU6irlfXV1kTEs0XDZOwXi7p/9fCq8W8MbZ7dJUsctUm5hVbx7z1ZSpn7zm7vBD/DZoi6rFFAdBjaCUoZv4h1rR1p+brCkfFWMZFhZYRU8sxEWIWzYN5INK+CCwnPvbpsk69itkBvF3Y9LzroSPvYsferbPMuBLU86GIGo/enSyv3Z+Zzo7tGd2ghWsFhq9iWI+xd2eRL5sFHQuREpjXzTHn99AN4+v7wRYmTACwLc+n52M6A==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB15776CB2E64EF02AA701CE2FED090@CY1PR0301MB1577.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY1PR0301MB1577;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1577;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(366004)(39860400002)(376002)(136003)(346002)(396003)(52314003)(199004)(189003)(3846002)(8936002)(33896004)(76176011)(110136005)(6506007)(97736004)(7736002)(7696005)(52116002)(72206003)(53936002)(23726003)(6116002)(2906002)(1076002)(446003)(386003)(47776003)(55016002)(68736007)(478600001)(9686003)(66066001)(81166006)(11346002)(50226002)(50466002)(486006)(230700001)(305945005)(86362001)(476003)(8676002)(81156014)(16526019)(316002)(106356001)(4326008)(105586002)(6246003)(956004)(5660300001)(26005)(25786009)(54906003)(229853002)(186003)(39210200001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1577;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1577;23:sTPKCE3XpJEkskoT89ozOo5WwkKHV7xGZgTaboP?=
 =?us-ascii?Q?Xue6Ql/Bn8qRA8o0L//HOFUEqntd6zWRxld0zq/fn/zLgVGv4T3MVKZNME83?=
 =?us-ascii?Q?kDojAgJ1GZGIpDeWSAlQFr9DajnG8u2ZoBuc6t8FnuKN7M/+gR1kBqhcSUCu?=
 =?us-ascii?Q?mm8lQhMPLdsG8KGlDSXceMl/RFEJS79S9pOL17aHnVMnQ+nEtDVXdNlGIiGB?=
 =?us-ascii?Q?1Cs0qrrBpOH1X0o0mBCGSEwJrEwGnnILkTm9R4kdpb+eoi3E4HXuHppN1wKU?=
 =?us-ascii?Q?29Tjq3wAXdEZntQ6pa+y28bc4Oasr2XZoiCGwgn6LI1rOvy95GeTQhb3I+Dy?=
 =?us-ascii?Q?/BJ0Gk9n/DOdpFLiPmPm1gbXYKOYE3xdxzEMHbko/7lqezHwmxFl6q1CMffU?=
 =?us-ascii?Q?wqRkVQwLIBELM2yJSIzKdnxu+0djoLfTFGrSFieFYigdaTSd7a+T8USicgDJ?=
 =?us-ascii?Q?dg1wkcaRuMp9Id0/KvsbOnHQ7JvsaAnUEkHWLKrt3+3sTAzbG5PuTFcvBGGq?=
 =?us-ascii?Q?Rz6A0NWX7phY9wcJkxEmHtLvbCUlP4zbLhRliuEpvVl3zJQmnfLaihDHvjew?=
 =?us-ascii?Q?jKH4yjCA5sn9yDadzcq/0yeNudLzTiOnnfv9T5MkJTfYTNgy13Nx8nEqktLS?=
 =?us-ascii?Q?vpP8cG1pMdVy0ULB19LYFzsLRch/e3pxoP4oc01ngN9oc22HS1FK4w7NxpJ0?=
 =?us-ascii?Q?UCW55al+TmmlkSGB0QhzuEW24x60WHTYIcb9SNKiMvqfvmR4+ZjTNDwpMKQ+?=
 =?us-ascii?Q?H1ih5/vnw5/AJ/E/NvY2PrRwOkuDl1GHQFS5vFRqej17TGKYCIr+O5c9lyFP?=
 =?us-ascii?Q?/z3n6efPPQrw/W/66Dot6JkosQAZFv0C586WI8T6wRRKGd8fCx7TM6skp6MY?=
 =?us-ascii?Q?5a4xZF5Lvv8HXi3lfK/AhFo8vX1P66Au6FF90II+Q6ZN0aqNX0tpRieFh/1w?=
 =?us-ascii?Q?nOMMqiNYIJInQoppPI8pqNYZOUExOe6d7sgAqPP1GEbSmY+uB26aGUN6ONuc?=
 =?us-ascii?Q?h3qc15VSlWLxcUpPCGkZii1F+BozKSRIDbJqgcrnPTalG12otpulKwluc/it?=
 =?us-ascii?Q?Gz/X+Ia9L42G9BJMOjcs+K6KrD6ulGjOxCd5lWuEPBfEd/qJSJZkvB2yxJYC?=
 =?us-ascii?Q?lQGou/1kBNMzJf9YEqBETtX3ui/PWx4ISgMGH6gGIHIJnfyhvlEhJtxk4tvF?=
 =?us-ascii?Q?p8GIHL8waeW/lWdJ+nIalI5ZGb7LcGh91NjTe3em/OviVu9kMDjylzyUSjcu?=
 =?us-ascii?Q?+d5klEYBHQ3VNHGf6xEVMLu2sPHnazPDl3Wu3CQVbQvB2/9AROmbFp2hfnjh?=
 =?us-ascii?Q?c4WQ+9YLPLnX1yEX6CHFrQKSvzHZJrA4BGXOZ/ibTAPvSuZFOPKgVBy8WsW2?=
 =?us-ascii?Q?XwH3ZxL+fRxXvcgIwwBg4cmyEaRc=3D?=
X-Microsoft-Antispam-Message-Info: y1SqTTM/EZNAo/Zrc/KGgTOyNEndpzQ+COzn62mJfwJOHTPo+x8/BaWFPDIAt/z7B6ZxwFemT2jvTDFFAunSXSCSw70veLB0EWuXfcgqD2SxZZVFyO5/2L/gfxG3Ab11Ocqb0oyyRJKrcDJ0kAy5P5rexDhYYH0ai5gzwH3HMQtwfMWyKUzw0C8p5ev0O68ldFoestbKUjQiga46fUx91DjKSMUBhJ2u4TW3/lvxMukv+3GLqQ2RuJqDMtwAOEhL3F7Y7WaPwObKXRl1dA36MU5wR4aZxKrG6Yc9K28s9kIdlTDVES76i2D4KgdU4SVTlNTlEYkx7lmFKYcp1aCyKxUn/SXQwMzRQut1k+Nwq/8=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1577;6:ksOEdkMdWGDTpxoksJkCYzfoLFWj0WHBYtZu9yMundYRLZ2+yzsyD2keHKrYo5rq2QUMZJTg20Q08YOPRWs8x6fQW8ZBtpLeF0n3Np6ZVbAMS+l4p97u6V7uO48y48/LV8HGH2nuR50wIgGCakf+CpGa+Pfy36chbfdHLF6pko2+AhXetKqKDdPLXw6mG8F8FFQui9ITIXIqk/fanQh2Bl/2kzOaCJqF7xRjnCGXO8UlgZlhQvHy8hosiSApFjjb3RJyqXDS1XJMLI06yhyzG3ajp/CCEt2AlgYiblgP8qCJHygjg6HO2uSFkfhT68iyPMCUPgGS8nWk8gIut5lsB3gIbbenj6rKX+bQV7Lq6D0OOj++qYrILTedyS6S9AFTDBuNJ1/7YRJ8Sdd8U0vEHIb9MVRZIgh9MzNWSTUb4fzuqIhGrPvPPHQ84a2TYNYAaqUm5OvLVj2Qlw1b8X0EaQ==;5:QuX1NtNoq/2u+mWn9hVhVBeLrih1kTtOqvknCMAXeJqhCwamAJruc9UQB4KeuLieakQ7zs8cQYRD/F/5jew+Mq1YlKfRC0aSyiSL7pziWG+XhBqgPgOAmzq6t1NbCyGSwv8EyXMJIUJcOtTry8v8EVfC+i7iOw+7RjB/kqC8CZQ=;7:zT4zcXqoANkjp53E+DjN36MfLniUrRrUBpwDI9QQ80Bqv7QAEHLNqeaHoUKW6QOT3apNHTkWlvlbDtKzdBhbK0sK61jn0GZ3fWerD2vCvjgA7hlFVTkSUxd3MrT3F6kTNYAeobj4gbXaVgbW4URGLPnDD4ZarRFXDfPzRppyhGcXM/ejazwqFHWHz5W83uxSQ1xS0PieGy96boGpMMLWA5BHnslZtGDc0AkRSlP/al+f5kCwPlouQh3ImbeJE/Nd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 08:54:33.7397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f06e09-d543-48cf-5024-08d60d8d0bd0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 16:40:24 +0800 Jisheng Zhang wrote:

> On Wed, 29 Aug 2018 16:25:57 +0800
> Jisheng Zhang wrote:
> 
> > patch1 fixes rx_offset_correction set and usage. Because the
> > rx_offset_correction is RX packet offset correction for platforms,
> > it's not related with SW BM, instead, it's only related with the
> > platform's NET_SKB_PAD.
> > 
> > patch2 fixes the wrong function to unmap rx buf  
> 
> I have question about the following two commits:
> 
> 7e47fd84b56b ("net: mvneta: Allocate page for the descriptor"), it cause
> a waste, for normal 1500 MTU, before this patch we allocate 1920Bytes for rx
> after this patch, we always allocate PAGE_SIZE bytes, if PAGE_SIZE=4096, we
> waste 53% memory for each rx buf. I'm not sure whether the performance
> improvement deserve the pay.
> 
> 562e2f467e71 ("net: mvneta: Improve the buffer allocation method for SWBM")
> mentions that "With system having a small memory (around 256MB), the state
> "cannot allocate memory to refill with new buffer" is reach pretty quickly"
> is it due to the memory waste as said above? Anyway, by this commit, we
> want to improve the situation on a small memory system, so should we firstly
> revert commit 7e47fd84b56b ("net: mvneta: Allocate page for the descriptor")?
> 

If maintainers decide to revert the two commits: 7e47fd84b56b and 562e2f467e71
then, patch1,2,3 are useless, we can drop them. Only patch4 and patch5 are
still useful.

Thanks

> Any comments are welcome!
> 
> Thanks
> 
> 
> > 
> > patch3 removes the NETIF_F_GRO check ourself, because the net subsystem
> > will handle it for us.
> > 
> > patch4 enables NETIF_F_RXCSUM by default, since the driver and HW
> > supports the feature.
> > 
> > patch5 is a trivial optimization, to reduce smp_processor_id() calling
> > in mvneta_tx_done_gbe.
> > 
> > Jisheng Zhang (5):
> >   net: mvneta: fix rx_offset_correction set and usage
> >   net: mvneta: fix the wrong function to unmap rx buf
> >   net: mvneta: Don't check NETIF_F_GRO ourself
> >   net: mvneta: enable NETIF_F_RXCSUM by default
> >   net: mvneta: reduce smp_processor_id() calling in mvneta_tx_done_gbe
> > 
> >  drivers/net/ethernet/marvell/mvneta.c | 49 ++++++++++++---------------
> >  1 file changed, 22 insertions(+), 27 deletions(-)
> >   
> 

