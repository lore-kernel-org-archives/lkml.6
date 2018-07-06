Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B08C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7B923FCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="aumoGiDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7B923FCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933479AbeGFNQn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:16:43 -0400
Received: from mail-eopbgr10043.outbound.protection.outlook.com ([40.107.1.43]:43840
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932995AbeGFNQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT2P/DOoukuJjWfcUoYqyQ18QexVzg0M6a/NXLqEETQ=;
 b=aumoGiDfE2W/TR0jeqK+nfaPDgYNRyKplMJUjouAKQgSrht1IsxJ76T7d8hba85/77JIrCrkd6uNSM1e0xXXNGEpepo7BONKOzO3dbz8Z5mmfPQJaqF42bIob8U3IQhZbyrdOWtOa5z1y9qoE5WMAK3Z6iuwoHjBwlxg3aO1wnk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
Received: from localhost (79.177.120.149) by
 AM4PR0501MB2324.eurprd05.prod.outlook.com (2603:10a6:200:53::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Fri, 6 Jul
 2018 13:16:37 +0000
Date:   Fri, 6 Jul 2018 16:16:32 +0300
From:   Ido Schimmel <idosch@mellanox.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Petr Machata <petrm@mellanox.com>,
        Arkadi Sharshevsky <arkadis@mellanox.com>,
        David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] mlxsw: spectrum_router: avoid uninitialized
 variable access
Message-ID: <20180706131632.GA3760@splinter.mtl.com>
References: <20180706124455.3151925-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706124455.3151925-1-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [79.177.120.149]
X-ClientProxiedBy: AM4PR07CA0019.eurprd07.prod.outlook.com
 (2603:10a6:205:1::32) To AM4PR0501MB2324.eurprd05.prod.outlook.com
 (2603:10a6:200:53::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03f47298-8c48-45d7-aaa6-08d5e342b465
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:AM4PR0501MB2324;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2324;3:VM61xOCTyveJbdHbNPjgAXvNlwCCbKv7D1TILrS52T2BFTQB9X7ExoMYOkSoc0whqALeUFN3qwYg9L8Qt4HG7jcNtrv/S3FSZeUUk/wnV1jImlcR7oKIGQv89wL7B+O+CENbAVcv/GK6jBv35HVpcotr5xHSvdcHJ2gVTNPKda+CGFLOF3TkjvK++3Uw9DulQ/KHtVpETmS7G2JlSMXdFIMcp6nYCtDG5jPqbVN6TB+trDzY/siDvCULNnusiuUr;25:jZDEJ9iUYBeRfJ///1eGOvt0Goy6sCZ1GNj0o3j95TKQdoIpUgdSIWdg4jUnZW+hVsY/15Kw5UAcCFdqM9WdBIT/9WkpHRzFw3qXJOU7Z6Qc9S+g2AWAusZsk6Kq7htyDr1tIeSQqp7+555YGjzanpBUO2fGFFShrBiqzUitp4xCIO1BgwGShWfZPxF0/YkbeVdCKPUyH0dmWWbSAEnGQOzBHayJIcehfqGxdu6sEtCe12qqkMHc6r25t6EArnMRW7ECbt/1PExIk2tH0qpOB08OHbzS+JbmDY2zcPfcQrwLFkJ6LTI8FFN4U44eqdL1OObCeVvaI3z/oj6jNatJ+g==;31:fQRwDa1bX9Le7M51IodN/ZrXXb14n3YFzLNkHwZUJKNXNkmD9bf8dSpP5Mg3no++EOO6UUmC0W99ggdm/nvthDqgOxTlYQR9myj3YhHmWq1RBZf+boOognNCb0Uz3YoSwknQFTRbHcRNPj7P0M4WyvpcNi/+nBtCpxMIZbshXpP3K/EhWzXouxCohZVszA8EhH3J6Sr3Ow+2v9P54SxnO0SksTAYhaaY0CIYSJV523g=
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2324:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2324;20:ohtJN0Ncpvpz2kU9FUw+vqoJoVkwgUa/zUC9nggMTWVJEMw18Y8MkidofFcSYUzisQFEr4ZRqCMDGpUEbuEFqnaUZGIgiIz484eZzuUpewuWDA0zVH7NgiqDTqNzeWbmwjzl4fh7MeQ2ofIbisahQnbDQ/w/k3gNvbbLU5jx+Sp45ZdYr6QPudGG9/rjoJclV3Num0oQphdQNR5qAmAF2v0zY1coXTxvrJTKiEKnwV0DVPWFB2EJPuZsFY671/i79YCGYdFYH4A8sNwBNv3sL6W4LWAdpfZbQlzVTettlw+4FVQXNI/AEW0oXEpuOOMwvpd3oi9QzsZ7AjGUpp4WuRSSU8hFfa9SM2KD5/PXm0fO0H8zTBBGKKF0q31K5ZHRO6gedQbzW/slW8s4utR6mxFBfvRPRHvuC8rQ979GXnhEQmvxxhoGL1bV3HcqIKgJaQgLVgY1zdcZkZotQlJb1dNVOTjQsp3JV+ykXhSHWiMEx0FbWYwkNj5FDxpvZSsP;4:HMeYwz3WFrftsixgb9jfIdOg7XHKPupfo+rXE3V3RnE1/6kFhOayJEBaiiDnDNM7D3n8IAChNOZj9FlVgi+J0uvKa7tkWy9HppCQmDJmr3KlFktO2ZK2Xk7VDbKhNlnlq2kAfHjWv/p3REhKEytqhFOz5Kn8rLLRTM3ck33JiMi3EETBiugcwJx40C5ZXtChC8l1GkrezhsNaUyRHJrFmYPe6kI/qehgqyHc3xpOSaW3kyVP/2iZSzcZZiFyGeWwrCBzrWibtj65P/UDpay7WA==
X-Microsoft-Antispam-PRVS: <AM4PR0501MB2324FA24FC5F6A87F24646DFBF470@AM4PR0501MB2324.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM4PR0501MB2324;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0501MB2324;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(81156014)(6666003)(9686003)(6486002)(106356001)(97736004)(5660300001)(68736007)(76506005)(229853002)(53936002)(33656002)(4326008)(47776003)(478600001)(25786009)(6246003)(39060400002)(105586002)(54906003)(6496006)(86362001)(6916009)(305945005)(23726003)(16526019)(2906002)(14444005)(66066001)(186003)(6116002)(50466002)(81166006)(7736002)(446003)(11346002)(26005)(76176011)(486006)(8676002)(386003)(316002)(52116002)(476003)(956004)(8936002)(58126008)(3846002)(1076002)(16586007)(33896004)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2324;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0501MB2324;23:vzSeNjYMrtraTaLe2zw/hULXfOFFzNVryv/KcHP?=
 =?us-ascii?Q?LqB9dE2wRgJcdNULSP+85Tz4+0t8LfEMENm/bGIJbbV3xgk3HWusFZOG9gGK?=
 =?us-ascii?Q?WEIYGe5f6HT2Q0cSWMmEFxoEZ+1irmng2MujWNvzOHSarY0pZTfJY74rCbi3?=
 =?us-ascii?Q?vN5SG/iL2PckT+5Dr3VgD1qQOAUhtAB/bazqp9rD1GN9olYf34PoBAnrH1hN?=
 =?us-ascii?Q?fplpZ3gtUiwx3ShPS7kGhRnuEzvx9Ng+7qivu0hff7+W7j+aMpQiQo37boW7?=
 =?us-ascii?Q?cq3DRdpdvVAkjtPURdc+R1AcPkfm5Ao1Y+iAIQ9b21tPFE7rQD5gVzuroZH+?=
 =?us-ascii?Q?CsXbPavm227WnidNXrBgL39gbPLzAIjdhUhlBNGRWAD+/KskUUud4nJRFk5Q?=
 =?us-ascii?Q?ogt1/cxvINgeH6sEWyg4plDv3TcymxaDlLxyCpGZKG3uc5TynENfarL3vQSH?=
 =?us-ascii?Q?xAwn1cqdqo1kQw+bHtgQUvffCmsty5THKXj5c08s/niFdCYlYY+y1oVG+/ad?=
 =?us-ascii?Q?Q46SbQWy9L18P+meCoio/EGU0lrD1eYmZ4WhtB+RFLF/IsKiCfaCQwnEbkuk?=
 =?us-ascii?Q?kaW69+tvi+Qxhn7yUfOA0ZSevYhNJCYViAexGGovgb4rJFQ1FBrmLKG82Lf1?=
 =?us-ascii?Q?GOIuWNLVumG5DKaSyLzODwUYnAiCgFZV3R6WnGcHotOB1lmYuyFacJPHGp60?=
 =?us-ascii?Q?iUEPLS3Nrlp6HjbRHJrPgkzrJu3B4aSar8zMI3Ig6ygMJdwXnfFi7m4BNtJc?=
 =?us-ascii?Q?HVMIVv9njyUr72nelGRtcmn+S9qTxG9O/HLavr3vzVsgfY8vRx+zEmBHK2w1?=
 =?us-ascii?Q?8QGOmYFVsuWRB9fdrm6iJboIEKQbYOwjmL5JP9CY82lUXngVYv2J7XMG9KUz?=
 =?us-ascii?Q?DDnPjrjIDUi/AlaSH5Z7tF/a/mV5N3xri614FCQ2Upmq6ovDNua7v8E0+Kke?=
 =?us-ascii?Q?hzyzcCSOS4TBs96UeshwSEKH5fEoTUy2KSHYU1g6bR2XF9ibIPxzSfESHPCb?=
 =?us-ascii?Q?rUQNGCIdz7foTKsvbytq2Z4MyjjJ22L+jehrC2O4JnFQfb94gDju/kS464la?=
 =?us-ascii?Q?XwnlVjmJyiaJKsRQdKojK7GfAravAGaFMYLpRG5ai26j6U8myL7G1KnJFIT1?=
 =?us-ascii?Q?nA/NdUJhWcLl/TacniyPBQ8nssqRRpJLgS5AJHW+hTcOC1TMdDz5/3ShXq8d?=
 =?us-ascii?Q?QLBySk2qLhuhvM0npS+6VTgjaRDo/6gNHnJ33QF0F/sysU1sft2+VIC1zZbm?=
 =?us-ascii?Q?CGukWvTJzcMcXF8x4bUkgpSFEl/M1fUHa2XaAnZ8GGWdm9NglWaQFhby8cQ8?=
 =?us-ascii?Q?3VArA+CoTsQtt/6J8ywkclVKrZY5SyaUaXaKt5PO1blYL?=
X-Microsoft-Antispam-Message-Info: v64W91a7/rHD+rQcfLR9xW1rJLQeff3gx+SA2x8roAZG24N5eqjz3uMlo/YVZA/GEslwxru/8ciw93S1LtC9RVKazCfjOWsjSPjH3EMcjrrcs4Z3WcIRzyzrQSbPdAzP9V1HvtCZGbWZIjg5qwp+CxSITw+XoqAdUHgkpUAUAE63wRwPJjY2sz54qva51VDsp/d56QcYuDUfAX2fmPX6QkFaQj1a9+r5tvbcfrXPsV2yqKsmPWT1L0SHi8SqI0t6m1ht12dds+XTk9QineQvDqDRZ/KiH2cJUjrYF5ObcGCulvkZPAp10ry6fEItzaViz2p3MaRO/3fg5or5R05bRXhruSuH5ULoUcK2rA4H6qI=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2324;6:rxxtXbt+3inu2AvEYh6m6UwTYie//xoaaYEI68DYffCs2oKbLcEFaimCpUhYEQtr9yfS9MDqEM8VlrLpJoT7HCYlxnQqI/vJ5/BBVKfAN3k2t2AACanFHMsKIHKB0BnIcNk+k1+8aqROiB7iReEyjUZavPyMgsuYJgh69dwWfLkOEfYF/bSfk1eRo566jmXzjxY2wDzNbnpsYukQA0jsvIFB+ZCEaSWUutCiKh4Arvjj2m+WUFm8pJeCSfrNpOl+/q4VGb2R66hRuDfu1ETddYa6iNdTUaaEUKs/QCMS1+JwAO/aOX3wFXVl78wNcApGDgISwXTLnI92OWS5P4o2wlrJQt6d8EAYgBpcOxRuc4KyfMfG4wqE27I3YqmIavzfhKlYw2cNYq6gDJX/X6MpbBrQgmbQeglaaBodcfp4YZqci+C8rRRTiKtu2EiU5rPGuzjT++qcXqEOSuN5BTo3lA==;5:Mx6XlMkWyAvm9KCs/YwWSwpjXBSv6i3FJ4JKknOuYL/APDb+yue+Aq6blAdedF88k5Y4qU6GvGonxBT/EMQBQWbPknaMBntKlWKW7+0zjHwp8MVn8zZ3e9TgRjhw1LENjMHFXguSZ8ZT4TroPiKqIz7Mk4OBqa6KVIBV5skWTM8=;24:3C8XWCpZhazgbXnKtOCY2DViWCpvTEaU//lDv9C3n3dWcMlYd86N2PbHkTb10eQfSQBAeaRGifFMcgJO6SMJwfBV7tS8YHrkBtPFWNnW0s8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2324;7:yj4hVMU4DY2Ptu2ppCcv/VAr6H0w67pXU/nyMxmVO6VjANlJb5r7Qs70DhLRSEqy4BhcqMtAvsOzVh2tcMstw2ayE+cMcJvWJxkN6kooFGMsXL1kCyRIe0QsOSD6DbvgdHoL6vu+9Y06mOArsUjo68SVHEnTKy6a3T7QIR83gqLLLNYJ9ENl80uln/O9+xx5inWp2VsRq5CCqmQJYPtM6yxVfIN3btfD4ohSJp9LfbHCxsOIzEpxAPa0N/GjNeE9
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 13:16:37.3869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f47298-8c48-45d7-aaa6-08d5e342b465
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:44:45PM +0200, Arnd Bergmann wrote:
> When CONFIG_BRIDGE_VLAN_FILTERING is disabled, gcc correctly points out
> that the 'vid' variable is uninitialized whenever br_vlan_get_pvid
> returns an error:
> 
> drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c: In function 'mlxsw_sp_rif_vlan_fid_get':
> drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:6881:6: error: 'vid' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This changes the condition check to always return -EINVAL here,
> which I guess is what the author intended here.
> 
> Fixes: e6f1960ae6c7 ("mlxsw: spectrum_router: Allocate FID according to PVID")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>

Thanks!
