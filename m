Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BBCECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566252147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="C3oGwdL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566252147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbeGLVOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:14:30 -0400
Received: from mail-co1nam03on0083.outbound.protection.outlook.com ([104.47.40.83]:50917
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732787AbeGLVOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twI/YOUA0F0e/DTL1DxotsXBmr+PwtoTFHlUNt1ubeM=;
 b=C3oGwdL5wijff2sFZKAHo8mbV9uqcWK72GDrCu8v0+wcPZr24JEqzTZXL7rPhgakerq2KLq98WDfRUJ1k6S5OIUCGUPskaiSS8B+T6kElxs699yr2P/XU61ZCXgbkbze8XSro0+hYeRyFHihetlL2Rl5hq6vy2+af1oNy+v2iuQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Manlunas@cavium.com; 
Received: from localhost (50.233.148.155) by
 BN6PR07MB2817.namprd07.prod.outlook.com (2603:10b6:404:40::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Thu, 12 Jul 2018 21:03:07 +0000
Date:   Thu, 12 Jul 2018 14:03:04 -0700
From:   Felix Manlunas <felix.manlunas@cavium.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Intiyaz Basha <intiyaz.basha@cavium.com>,
        Rick Farrington <ricardo.farrington@cavium.com>,
        Veerasenareddy Burru <veerasenareddy.burru@cavium.com>,
        Vijaya Mohan Guvva <vijaya.guvva@cavium.com>,
        Weilin Chang <weilin.chang@cavium.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [RESEND] liquidio: use ktime_get_real_ts64() instead
 of getnstimeofday64()
Message-ID: <20180712210304.GA2585@felix-thinkpad.cavium.com>
References: <20180711123003.453442-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711123003.453442-1-arnd@arndb.de>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-Originating-IP: [50.233.148.155]
X-ClientProxiedBy: BN6PR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:405:2::25) To BN6PR07MB2817.namprd07.prod.outlook.com
 (2603:10b6:404:40::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9030665e-9c39-4d35-daa9-08d5e83ade47
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB2817;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2817;3:7OyGfYhiw8DICtZK7PuBtyc1O/Iqk6GPI6Dzv0PBPQQdvBqLbrk/Mb26fV5KAJJaFB9PwtPxE5NQAUmtMO8AziFw8m1reLXmdpE6QMC2/s1Otj30W7wbhlXuuMgZelGWMuROoGbA+ztLjmBg5UFR37hlKcjnqYwj/HHzTyWtDxTiztex/hOalRvKbxgHInmlxZlHp8PhV+p0C00cwShwZDPlXcanHRjyWmPpSmAhv+cN/Xmcl8cLmHiE5Tu1UrCH;25:YU5EvarlOIsTIaN1KXavnTbIFtP5un7jCcQql5fCQy8mzBd4dJ9T5cg6qKtcfShE5Fr3g6O354vUMQm2ddMJxgDhQoCG/x2ZLCquouZDobvkv2Thrj/sWpPlNjshgqgjBUKeuHMhzLZKzXIfGbg7OwvOOhHFZOMlG72VpwS5zgajIhrzDRR3yfhdasHHnjRn7ySV7NhBdIiFod0XZXU5X2rhr4ovY9TRZY2Sdayh9NNEdx1UdHE3dDL2x6QTaOaDSvIHtPf84uQeiWOFH9pgkADTnkwJfk5Lxr43OhSmWEnnCLT5ZZ1HTwhXAuTwU3cDrLX5nFB/dLaQXJIFeGGRJg==;31:6h0wMeClZAEXTYhE+hVY06z4+fc0rTMWY79deOz6Dcr8t1L+GIOQqLWaD67BLJFxFqo2MpNY5NNoa770hkAsdKCRKxu8YKw8ZPBSABr08dE4jd3N1A4lILf+cnM0PgyIepIP8KNtLLO/62fkv/bogwDCQH8QoiYUdjwLWo4G5/8XnndzPzx6DCvBEFCd6JItDkEDffsE3G6HEdb/SM5RzrI+4b2oWGMFypiwl8mA1U0=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2817:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2817;20:4OC2UIX84VGolGKqsOBqfC0jW3Oy26VcpZiyZGW7luFo4BcL0p2ZVkKHTvbp8zHRw6w1Q8u+In8YhtsCinPQEIV4QsH5Qd5FWFDF+TavJmW2uo8tsezodt854sXta42VhxDKlLX8TclBp8kcT+WUjJ+03JzNyXX7m1RbWSz85/gnCily30RRMIUi3lrL0USoWbNunwaMGeiWzm7Ab+YPchMRGsYGmpDPD+5GX3+AlIv6QltkgM7BMF2OV85zTALtzrV4gcg8M2BqfF25FWB8X6NUZuoYUcooRm7RynXDlils4NtH31qh4VOKFQ3IxGZJGccoNurYtkvvfyunpaI+8u6tRRcueddLg5qa1m0lJn7Myjxlmrz9yyixI9Va4HjAMd4mDLFY6Mw3WJIkY4qHBA0/EJNXv7zfbVqNltHtMF6Rp4yvBRnWzAGfQVisCVJmz1aqnCpJOLQhDC+N+jkaTNc/XIHkkScIbXJOOH6tY5gD5aaMgw6RcuXy7DfV40zV;4:i5Ob6Xh2cjRTUje4aCMx5EJZQsHtTFvoZyB2DhpU9lHvMms/GFF4WDS2d89XaFJzZRAjH9lbIpbmEK5T64eQtND2cqqSbnRjwKhbUouGuWpNNtqeBFMZY7AP/2Og+NYsn3l+1lj+8h54euMm3d7PB0w12/QQAJEz5rLpY2pEvbo6g/QN1B3nnu6BI8aoCJyXNUPFvbuB7+4zx1RRa4HQDzsPIRzyF9EdbEL3B/E4oqoKa+cvpzIBQ6mUia4xof21Och1QWsgKsUmJOhCW9j7DQ==
X-Microsoft-Antispam-PRVS: <BN6PR07MB2817D1E10086674F8142688AE7590@BN6PR07MB2817.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN6PR07MB2817;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2817;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(52116002)(68736007)(386003)(16586007)(478600001)(54906003)(446003)(76506005)(47776003)(486006)(7736002)(50466002)(8676002)(5660300001)(44832011)(956004)(66066001)(81156014)(6486002)(6916009)(476003)(11346002)(58126008)(305945005)(97736004)(316002)(575784001)(86362001)(6666003)(6116002)(3846002)(25786009)(72206003)(16526019)(186003)(8936002)(229853002)(33656002)(6246003)(81166006)(53936002)(15760500003)(106356001)(76176011)(4326008)(23726003)(105586002)(6496006)(2906002)(26005)(1076002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2817;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2817;23:dfHb20zerNmhKFSc2d1KgPs5wo2OlMsPHOsxDdUmG?=
 =?us-ascii?Q?TlaeCjdVQxCpvTknbeB8aok96N8BxkO0EvuEEG1dF96/lFpWvYlwTPeVOkku?=
 =?us-ascii?Q?q5PG40+CZS4ZuiejxDLcdIGHwZNS84+ryvsXpXddFhLKIwxZe96/2/E8vQPc?=
 =?us-ascii?Q?IRoi35EME3GKlliz+5CBWIc7VVmTlBnuwUjyeGnp627LTb8dDSLnbh4ItG+i?=
 =?us-ascii?Q?ZllLbsDcfRsydrqnnD+Hpun3C+WXshJ2oDO5cpswCaTJ1pGTav6UIOZgOirk?=
 =?us-ascii?Q?WZ3vy71qGLbKyROcvDErCFM64Z6cbX0NJwttPqecFxNumblFplRntdoIwF+D?=
 =?us-ascii?Q?io44T8Gtlm1Fd7r72N/GAiyTJgxNK881c8B0hyIvQnmIFeF4s+LGtSbaEAem?=
 =?us-ascii?Q?j/HKHpo283BvkK7g3nAV+2ewr0+sDQFVjip3/AJgvEMR4ubOIZerb62kEBoo?=
 =?us-ascii?Q?bUy3DyuWI6iDKht1vtctTRpb/XbzW1M97ja2wByCDVVt2rmK3urfLIrc6Ub3?=
 =?us-ascii?Q?SpTiSFcXV1y3YIpUquILIGm8XhFqwFpoRmi37akxEEQKJZU5kuwTeIXQj2gs?=
 =?us-ascii?Q?F/KW8QL5KCFrMg4oTfCO8Ef7v7Z/JtHTrkFcuNXEDg8Gx5zdV6p1qfF0w/8p?=
 =?us-ascii?Q?VsgSOKrhjIZFl3gRYvXuIaJhUuxYzDYW8eJO5TZwbRg4p0/3568op6grqKnm?=
 =?us-ascii?Q?4+zAd/krqORdW7IO2iWJK7Bi3PhVBSkCcsRO6Go9DPPTGn147llXruBIwOtA?=
 =?us-ascii?Q?rbHdz3usXIqvZzoQL2XyNjVw7fgwk4Hhm+hKqyLv+F2J3NgRBPygF1l3oP94?=
 =?us-ascii?Q?dqiAZo3YJLce+wR8oK95LMPY5T+mQDyrQR6uSWemiwKWKqmvzwfXUJG7fla4?=
 =?us-ascii?Q?B7qrgkscoZD8/uCwFIEGocvzxG6abhAeMEauHjhLmG05wkbw0mD9S45fAjS9?=
 =?us-ascii?Q?XxNUPGWQo/r1v8rb+ebZem1IbQVPFRzpzS4QAHOeAPUwC6+G5ADCXt7W1Qbe?=
 =?us-ascii?Q?Khog6GcejcdHN12Wnhh7rxp0rhzh6w1mXYI3I/q1QL2FipZKmNEL2X9Fcx/8?=
 =?us-ascii?Q?T8OloeETy3UrsUr1FV+79Jysmm3I0jF8z7QhfCpMvjl56BAEqEj4YZ8celpF?=
 =?us-ascii?Q?D5HgKnlpUQfR2luLwZHrAGIktMo6aGPNLtB9aHFUv2pkNx9wCWc+E9GhscZf?=
 =?us-ascii?Q?e/nlGw4CnX0J0IlYnfeUJeRenZ/Rls+3a0HkgRjVLhkGAPKncxCO3dnwNfzM?=
 =?us-ascii?Q?wiAXwMjMO23HJL73B+7wSV2gfILwn3WEkcKihqDsQBnpgoRw5BE9hmhfarKr?=
 =?us-ascii?Q?/aWMvlsbkc10e+SbGpxfc4mtmsle5jiOEqDgsBeXBKFVKgb6gdPOQCsFHzqu?=
 =?us-ascii?Q?STFlw=3D=3D?=
X-Microsoft-Antispam-Message-Info: HBdzoi60AtcVTe5f8aH+ZlJK1SCc9bO7DRSBioTVb4vWobo45qWxkI7Pq7OUcBFrFb5/c4JanCCqkaiARwfAvnxKTwAr/TwyeH93vYPjqdPiW3WqW1TjOf/s7r3c2O4R32MQv5HfLU5fUrRmDWj+BHl5HejAGnyz5Y/QYH9PaEA7A9l1JoebX8nCJfO3t+sqixtJzSncbQKWGNN4+AD7aY20cUb2GX2iYzTTAjq+m98K93EvednEcO/sWEo2FTWrEqcQiTfTpTU1rP4XYikM07taqv0wLTniv+8P8GhUO8sOjwwRbRVMzriYq/RmlHmuc1opjrHmhf/eUjZRufRpBxaR9p3OHh1pC3l6AaHw+is=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2817;6:14x03zJ6dL6ku4PfDmy0iqFjqaFSGexH1TMUCBdTJ5AXfoA+nCfUI1m2o6QInFrndj3wXTE4PtF/kHkt3HWHrEFMaCM2co8g36RLnvpo7nCSdhnoIMSa+U8fisFmfieldfIM21YezoaMfwuWyBIggbykXV8e8nwVP38KF+VQj9BFZP20lXCU2h8YQOehkJN1N0JKbWL2ccLQ55ehATUg7Kzj4NOyAYpM0U73ymcTcsFF2FX5mzMp2vcK3j5qMAQJAr4WvWhtvusBZxP5S630JJqDdN9Ms30Blp+tFpITHU3xIqI07XfNgfgE4Xul9qQPjQiwBc8BOS5LPmMHGtqaj2B1EtfoHJ76A9dHJoPPqrI1UJuQU6+tn9S9O1SZ3/X+jpzEBia742hlUeD26BYXpGddEuP7cPBbgbqZZhfEl5n6IWBlnhogZoHq7psgAxfIZ5TIZ/Rm+ZoPYOcJeN2KKw==;5:Hn12Y3vyRBBpaMLCOZUKP8zMd+r+GXUBOsLI4XmFvHoVTASOCHCoNlu/io+qmPyq13A8qsx2mK++GWE6geFAoTyeYZ6L8to8zPvaFtxhKBhlVrqa4Slg2MhIcNSW1ygJev2q6QWmwzRoDkLHh7FN9ZUS9raSjj0p6z1mTY42zBM=;24:b9VenKxvwEmROvyZ85ba/bxMk3vH1U/8oOWZLKnEtLqZrWYjWipLyEXGaMOuTx4Wh2757kMSLhASSsd07Mi25vKSRLmYW0l207jNyUr0VK4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2817;7:Yg3xW9cplUP9WO6yMIdzOIVJJELxI3hrH8ZC03Fnfs1RxLt8HCSGpwTIH96wA3Z7fdgHoFKx9sfynFKgBdJwHiU29WGRxTRwxlgmbDIYzNSX/28Qp0ss03E7fN/ncuh9iU2Dt/aIR+r2NMnjrrgabNLQcgnLU0jhn6XvFfJvXHVzzDO3YpZ60zsURth9Vfq6K0UgoB09wWpsK1CL5fe9NGNENmo3Wb1sOm5sSsapz5c/qXz0gKiL1eWhNjSwJSzU
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 21:03:07.5979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9030665e-9c39-4d35-daa9-08d5e83ade47
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2817
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 02:29:52PM +0200, Arnd Bergmann wrote:
> The two do the same thing, but we want to have a consistent
> naming in the kernel.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/cavium/liquidio/lio_main.c       | 2 +-
>  drivers/net/ethernet/cavium/liquidio/octeon_console.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> index 19d03fc24305..30884ad0a509 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> @@ -687,7 +687,7 @@ static void lio_sync_octeon_time(struct work_struct *work)
>         lt = (struct lio_time *)sc->virtdptr;
> 
>         /* Get time of the day */
> -       getnstimeofday64(&ts);
> +       ktime_get_real_ts64(&ts);
>         lt->sec = ts.tv_sec;
>         lt->nsec = ts.tv_nsec;
>         octeon_swap_8B_data((u64 *)lt, (sizeof(struct lio_time)) / 8);
> diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_console.c b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
> index 7f97ae48efed..0cc2338d8d2a 100644
> --- a/drivers/net/ethernet/cavium/liquidio/octeon_console.c
> +++ b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
> @@ -902,7 +902,7 @@ int octeon_download_firmware(struct octeon_device *oct, const u8 *data,
>          *
>          * Octeon always uses UTC time. so timezone information is not sent.
>          */
> -       getnstimeofday64(&ts);
> +       ktime_get_real_ts64(&ts);
>         ret = snprintf(boottime, MAX_BOOTTIME_SIZE,
>                        " time_sec=%lld time_nsec=%ld",
>                        (s64)ts.tv_sec, ts.tv_nsec);
> --
> 2.9.0
> 

Acked-by: Felix Manlunas <felix.manlunas@cavium.com>
