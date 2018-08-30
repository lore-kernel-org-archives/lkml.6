Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7660C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C0220644
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="s0JtiXk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C0220644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeH3Hol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:44:41 -0400
Received: from mail-eopbgr700070.outbound.protection.outlook.com ([40.107.70.70]:61045
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727438AbeH3Hol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qANl44dIwOGItXXdu8VZ2xZEm+9N94M5zVsAnHnxYA=;
 b=s0JtiXk1Vh4T7EGISye1gk2BKFXmfLcqygVmS9AyndNHbwxFqqrniN8gdf5MJgPLVWp0QsFE17kQgc2jnqJkN3qVbFSvTdQb9uX68ZWyVL2owym3Y6heF0Gghkwa0pX9oexA0A2UeBF5QjG22K4zBRbK5AAArvpTZpicvi47ZY4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1571.namprd03.prod.outlook.com (2a01:111:e400:52a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14; Thu, 30 Aug
 2018 03:44:29 +0000
Date:   Thu, 30 Aug 2018 11:40:42 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/5] net: mvneta: fix the wrong function to unmap rx buf
Message-ID: <20180830114042.1f9900d6@xhacker.debian>
In-Reply-To: <87a7p5jzp3.fsf@bootlin.com>
References: <20180829162456.2bd69796@xhacker.debian>
        <20180829162751.018acbb6@xhacker.debian>
        <87a7p5jzp3.fsf@bootlin.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0178.jpnprd01.prod.outlook.com (2603:1096:402::30)
 To BLUPR0301MB1571.namprd03.prod.outlook.com (2a01:111:e400:52a9::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e9e4317-4dce-4348-c1bf-08d60e2ae575
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1571;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;3:n34QFxVs9NMH7jNmssJ8YA9N+Om4HQ+Z1k3ldCHa6pADKRKv+nk8upVdqKX0wTzgjdfP90xmq1xTMEwG7cAF7zCPpw5X4mQDUZq9pSpdR7biblj2EiebLfDnJih04Dy9QUCk4BZbp2RJDdYrxy7kk2f8kp6lv4I7uwNY6ZIjDg7jg88unv3VHdF3CBH8cWGyyJqt8cOzHKlaqRlU+Y/ikBDihpbCkt2b557JsFjKFCVekr3OHPJuBWGBd76YXhco;25:QmEb16XAle2hoEjuUUUk8ErySLqWQL8Q7/MGJF99d3OGozvyfvDadNYkzB3EgjxPdkgaKNXTz94vRDetVgEGidAus+I0UOlV2BsYfzi9AhCZ1m9RQuASJCO/8wZAPyCQVs4h7HAvrc5C10nJcfbw1X14GTh5VmHBgmfrqwU+Nscw9RTIY7Ix2zNN0GiHFCvqamxTRGEJ0sihEvjOEwAM7FPJigmWFpGcGtmRAGFwAVEAEuLllL+RL/mNTQE2jhwjJUSjVemhytK0DzKpo70vaPKulHni68OVvrrK0CtgUg+3/DOUtBmn0euUjJlCtawHps5rPkoUoObPZDjC8/EoHw==;31:OEHG3VHY8fEioWqCrAkybAAVirCSrMgMXZJ6U57OVGxj+58Aag7oK6XeiLScaBS+ESzrqtONnc/WCf8uM56vdzi30L4oVpxRG3AnVQw45klEkDx1mJuQqj6w7BIuPKgkSxDMdnM6gOYwhDooMq7rDmrEEHod+b9+uiWRfwXvUIoHkDgHMvhDR2915ZkJqyqVyju9Em2KJE700dveMwrir7NrZWF/IWrsji2ExdUskL4=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1571:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;20:+tPu5OhZ0F7/Ldi7xKDXCxvMAIk+AGGug3owVD8cbcymcrj1yTQXByChhFKR/djYXeGUq3Djsk4POvF076UIo6zlwQ/JGVsRaZOadm68LgRGE19qOHeqBNAbT1pOhn0iB7ULx6H6755aG1LV9H8NRoM9mUmGwrd1Y5gcGQp9uwh+fFT2+DGzTYUkQao7f8F88hicps9hjI8wTweJQKb9YEZ5a/LOGylx8mXCzrIbPjKx3ki4XT7Id+Czv+A4BhWt2DLWfu8YMR5f4WmdOR7aVr94PKpQL7iqoVA1YafhHNX88NnkWM6E/uoiyXCQ9CKAj8mUgu9nAAcddpPL2q7HzVfQAXSEpBwJUafQgwj7ckO6P/8gRitXsXq1AeGucu873/DicznVQ9Efm2GCqFDYPsIYGrqqWVNk21N6xkNfr7wqVORxvmAV8KASUfApIDAPVZZrPBIuNyvoDbKJG86lQSycbqIgU8iB4m7AIUb6z1KRm2qjfoZ3mI8/iCeaztBF;4:HkyT3RU5qo2//Y1lV5DKfzwSEF21LyqGLtOb46CLUS7IDirNMiTa/eiYk28samP0uxJ7Ili9ZVOJi0WH0h9G4gVHXVstp8gE/gZ9dzKpbo28c0qg5ds3JXkRhxPMIHc2vuJ5JnJR5dkCcccLDd+ZIZf/kz2fl693UvAGAfufR15AupmTd5WjIJuUem4+JvkSrovcCx6I8sV3obKJ5EA0W9uW2efC+EwWydF1O/11+EJSuexjpaXax6tWA4+fWbfz/Jhp1tMKoAHNcKFAY4KxiqTCVSiULD07vno3dnrfrW/0kVfSdXmkSWAUiyOpOc86
X-Microsoft-Antispam-PRVS: <BLUPR0301MB15710E32CA3E781AC7C1C909ED080@BLUPR0301MB1571.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(258649278758335);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:BLUPR0301MB1571;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1571;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(366004)(189003)(199004)(51914003)(486006)(105586002)(966005)(106356001)(1076002)(54906003)(3846002)(72206003)(50466002)(11346002)(8746002)(6116002)(956004)(8936002)(6246003)(50226002)(446003)(81156014)(476003)(316002)(2906002)(7736002)(1720100001)(6666003)(305945005)(186003)(6916009)(478600001)(16526019)(81166006)(86362001)(97736004)(5660300001)(47776003)(9686003)(33896004)(7696005)(52116002)(386003)(76176011)(4326008)(53936002)(6506007)(8676002)(23676004)(25786009)(66066001)(26005)(68736007)(55016002)(6306002)(229853002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1571;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjAzMDFNQjE1NzE7MjM6RlRIL3Jya082TjZrd1BZWElJeUxmQ2Vv?=
 =?utf-8?B?UTFzWU56TERJWWFXN1BpRlAzaVNLUW9QZGtpd1l3QXVpZFR3Z2tRaEJiaTNr?=
 =?utf-8?B?V1ExazdqOS95TWF6OUdSTVJxeC9lYWt2clR4RFcrUXMvNFQ4QXNXa3cyZWlF?=
 =?utf-8?B?RG5melhsOHorUTNnb012TVhhZWNNYjdJbVEzNzJIK3RNNzlaQ0RpMDNKbVA5?=
 =?utf-8?B?akJXVHFWdk5HTVJic2lFVE9JNThjdjBmQU9wcHEyZitSRDBCbmdkR0NQVmln?=
 =?utf-8?B?eXVnaFU2ZDliNFBmMnJiQStFK2ZDdlNOSTIyMGxLTDI1OXpRalZYb1BiOVJP?=
 =?utf-8?B?RjJ5dmNlUzY5N1ZpYm9Tb1E0ZHQ1MDdQdlMzcnJnZzYvZzVIRy9DaGJ2Kytl?=
 =?utf-8?B?RERPTUR1MHY5YUh6VWpPcDdCdUV0MzY5QWJZSFVMNjEzY2NraS9VS2tUSExU?=
 =?utf-8?B?L3VRcEZ3Zks3YUNQSnNqallnNzhENk54cWI2RmU3Y0pna0pIY210QjFrelNL?=
 =?utf-8?B?QTJCVnVPai9RN0dmUC9pZEdHOW1XZHdkMW9pcEk4ZVNSTENMeFZNWEdENDhW?=
 =?utf-8?B?M2F2OVZGcDRRT2I4UER0NHV5T2VZL3Fka01uVWwxZ3YybXJIRC92UTh5VXFN?=
 =?utf-8?B?WGNUcW5VRUQ5VkJiVUMwN0I1eVFxVlh6VE5pTVlQUmJGNDRnL3JjMmt1UjJt?=
 =?utf-8?B?em9rNmNFQlFNNStmL25vQ3EvWGxET1VHRXFqQzRHOXVGNkw4RDVLU0ttQnJa?=
 =?utf-8?B?M2xENytSak5CeEx2eVE5MUF6RHB5dWt4dkFoWTI5WFZuTzRYanBVMmloUFcx?=
 =?utf-8?B?QitETTZSRWxsNG1ldDU4Y01WVUs1b2tZQVBaVmdldmxPNmM4TGN4RmRDZTlZ?=
 =?utf-8?B?VXRZY3NvVlFTR1pxZmp0QmM2SUJsNXVDb2J2Y3FDSy9aWGMwSFRGQmp0cmVm?=
 =?utf-8?B?cTJyNGJZb2dNZUtNVU95WDE4L0lCR1BiOERJRTkyOEJHMzRPbUtwSDU1M3hj?=
 =?utf-8?B?elFiM1pUa0o5VE1IcHEyR29seStHRzd4eUVaaVNGaEY4bnRjZWlXQTVKQzE4?=
 =?utf-8?B?SGdHYi9YMFVYZytxOVZxRFhocHRSSzhRajhpSzNmME9iMUk4KzRnNUV3UmtN?=
 =?utf-8?B?QXRxTTcxdDJiOU9NUnh5VnpJdWd3TDdLQ0hQejhtbjdXUHFNY1Y0YUM1TGw4?=
 =?utf-8?B?cklYbzNkdlBEbkd0Y1V4R3JlY21hZXZVK3BQcW5NSUROSzk4RVRtaGFJTGRM?=
 =?utf-8?B?OStGUys5RGFaOVI5YjhyaGFzaWpuQjk0UnRWdm5MNHNlM0pEalNCaWlOcWc5?=
 =?utf-8?B?RFowK3padjBuLzJJMkU4MzFiR0tEbG03aTAxcEJXc2pkUGg2TTVpSmI3UEw3?=
 =?utf-8?B?b1ozeTV5ZHBWR2lYM01GcVBOSXBmYXNYZ2hXZ0tPT0xLaVdHdCs4aktTNzVx?=
 =?utf-8?B?S2RpVHF3R1pPTzdvb0VnbVpVeDFiMFVkMEgrcGUyMU1lSEQ2dGhsYTlkNTJt?=
 =?utf-8?B?WDl4L1l6cEVjcUUxZ3Q5Z0xrRHBtVmNTZ1JCOGIyc3hNNUNVTWVlWEQ2SjJW?=
 =?utf-8?B?MWNrZC9Kc0h6Z3U5enlOQ1ErM0VjdWx5SkRZdktaTTNPOXIzeWMvV0JFOUtn?=
 =?utf-8?B?SjI3alNxaFl5OU44NSt2elJGdkFFbFA5L3FHY3o4OTRieEswY0tJaXpmZmtQ?=
 =?utf-8?B?NmNuaUpsWkM1NXVvV1NyeUZieWpWZi9UZTZUOGpsWHdNeGRNTXZKTVNxOHhy?=
 =?utf-8?B?eDAwckpJRnBHMXNOTzNuNlRFVXBDU3lVNmJUZTVrcExFMUNDZVdtV1ZUbkRw?=
 =?utf-8?B?SXRDOVFvdllPWVF5c2hKb0wxaldkWHBXaWQ2Y3M3WkRud0FXQT09?=
X-Microsoft-Antispam-Message-Info: fAxI5eWmsdhHf+D1VC2k6doWCyvyuig/igzXm/0AQ0yoq+C/5gexWdnRrd3aVCB7OkrgH3U1eEPIn3J/Dzr/xGRTkzM/MpRQFppsZDpdWzH1yCYW1JbyQXFY4FHGzg4JRRJe6bpCyzYIzVfSsG3OBVM3OzIszB7oGBH/NFDB8xeRoTbnOzw34rZFVNxi5NaTZfZYCH1EpakDcp8SphbVLGeuTExZs5eT8OVL9V7X0ujn9lemFmVntgCTf+UqXnV6RGSign1ccf0trWgdi4VxR7kwB/BdqFXLBRYa/+tX+24lBAaYcG0U6M0JO1VlVA000QKc6nmWyAbx127y6WCYbKLeC/1+O6vs8dPPtMAXPcs=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;6:sLelYCdEVvWuH76TjSJNaOyDB2b5ntFj72ayQGLpVdA91MspAtTWqlQjb+3TChtQySGzZSG1VKENkccJJtyvBi6SsijoZP/VIzRJ22fSC/93d+0OSZ4pVvZ0kZq1gmcf3nofCKxEBBI9c22V+mvLXkpFW3xQBKmOc2tNa7TGr1xYTsU5VdZJ9Lvr1VoG5JaWJnVZ638Lk2X+GwwYk/+2vMMnLIcchxprSHJMes6iqYavhziB4gNf5MPEb/8xHn0zTEm0Rok1v7cjvrK9/OPUXBuegqZNoWfrQcWjmu7hZF34WuKUPzGor26QZrEvXU7bzaQEeSP10PLDH4eKGPD8bMKFMEGG5elsGRvjVRhE3KyxEwGvZnCLl4gT1k2Xhovvm3Co+lAvYcr0CKxiCocd3MnO0sTfwMKzNdjNMQzBrIRBGI110CN0QgdV3/JtePkV076Vf5KOQ/R72K9JToj27Q==;5:mwj66oEfQmnM7ojey+tz1cSg39DxBEzeQZSJR0BHHrbdpnT8q2F3M5Nphy5u5ap6krNHjQnzrTf6HQ2mgKRR7FOTOdLkPMUSGMTIc9svv23P5tpbVED9GHH4zYB/O4NjK5vy02zMg6pk68SpBoPKB48MqiHihsD1uwaYjMsjXeE=;7:Avq0/WbzVMmTFnOt7I8pAzZpXXbE13n6UMMqv36/QAWixq/qeAXDd7udqlRAYSCE2zHNUNxUyUzW10z8HFIHeivP+tFmBEpzQA87l5Qrb4uxEvcc+ltgIzp08tXShl8mXsOL6dL/gaq2isKPDWacoQ0Nj8fCtOmravftBwv4SsYiumHlZ769ToOMht+cNqRrPqhQAdJjxUG0ezbrHErC/IQ27K7CHFPhinCD8OE/adO1anWTDwhw0QDAC7hipxH0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 03:44:29.0304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9e4317-4dce-4348-c1bf-08d60e2ae575
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1571
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 11:21:12 +0200 Gregory CLEMENT  wrote:

> Hi Jisheng,
> =20
>  On mer., ao=C3=BBt 29 2018, Jisheng Zhang <Jisheng.Zhang@synaptics.com> =
wrote:
>=20
> > Commit 7e47fd84b56b ("net: mvneta: Allocate page for the descriptor")
> > always allocate one page for each rx descriptor, so the rx is mapped
> > with dmap_map_page() now, but the unmap routine isn't updated at the
> > same time.
> >
> > Fix this by using dma_unmap_page() in corresponding places.
> >
> > Fixes: 7e47fd84b56b ("net: mvneta: Allocate page for the descriptor")
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/net/ethernet/marvell/mvneta.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethern=
et/marvell/mvneta.c
> > index 0ce94f6587a5..d9206094fce3 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -1890,8 +1890,9 @@ static void mvneta_rxq_drop_pkts(struct mvneta_po=
rt *pp,
> >  		if (!data || !(rx_desc->buf_phys_addr))
> >  			continue;
> > =20
> > -		dma_unmap_single(pp->dev->dev.parent, rx_desc->buf_phys_addr,
> > -				 MVNETA_RX_BUF_SIZE(pp->pkt_size), DMA_FROM_DEVICE);
> > +		dma_unmap_page(pp->dev->dev.parent, rx_desc->buf_phys_addr,
> > +			       MVNETA_RX_BUF_SIZE(pp->pkt_size),
> > +			       DMA_FROM_DEVICE);
> >  		__free_page(data);
> >  	}
> >  } =20
> This one can be called when the allocation is done in with HWBM in this
> case which use a dma_map_single.

oops, thanks for the catch. will fix it in v2

>=20
> Gregory
>=20
>=20
>=20
> > @@ -2008,8 +2009,8 @@ static int mvneta_rx_swbm(struct napi_struct *nap=
i,
> >  				skb_add_rx_frag(rxq->skb, frag_num, page,
> >  						frag_offset, frag_size,
> >  						PAGE_SIZE);
> > -				dma_unmap_single(dev->dev.parent, phys_addr,
> > -						 PAGE_SIZE, DMA_FROM_DEVICE);
> > +				dma_unmap_page(dev->dev.parent, phys_addr,
> > +					       PAGE_SIZE, DMA_FROM_DEVICE);
> >  				rxq->left_size -=3D frag_size;
> >  			}
> >  		} else {
> > @@ -2039,9 +2040,8 @@ static int mvneta_rx_swbm(struct napi_struct *nap=
i,
> >  						frag_offset, frag_size,
> >  						PAGE_SIZE);
> > =20
> > -				dma_unmap_single(dev->dev.parent, phys_addr,
> > -						 PAGE_SIZE,
> > -						 DMA_FROM_DEVICE);
> > +				dma_unmap_page(dev->dev.parent, phys_addr,
> > +					       PAGE_SIZE, DMA_FROM_DEVICE);
> > =20
> >  				rxq->left_size -=3D frag_size;
> >  			}
> > --=20
> > 2.18.0
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel =20
>=20

