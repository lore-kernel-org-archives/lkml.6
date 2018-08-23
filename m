Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18DDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B2A208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FfMANIPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B2A208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeHWT06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:26:58 -0400
Received: from mail-db3eur04hn0204.outbound.protection.outlook.com ([104.47.12.204]:40929
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726274AbeHWT06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKTqs69dt0E9QIklBL2JSJKblOgamxvYDWtPwc02P+Q=;
 b=FfMANIPqyKTMT2has8j7x0t30n2nbbaYUdpgyDfbkFUCN9Nzh29Ben0Bg371Ke2JKvyLTXp5BBUBIoT3V2TK7+u3cS0PH/Gl9IWzl6LfXkKuZRin0ZvNJqWSJbg9dUIwSLqiLZCZIO4YNKfIPwjCUCGF0F1hjv2RLp33/817hy8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 AM0PR08MB3588.eurprd08.prod.outlook.com (2603:10a6:208:e1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.22; Thu, 23 Aug 2018 15:56:27 +0000
Date:   Thu, 23 Aug 2018 18:56:23 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 RESEND 5/5] KVM: x86: hyperv: implement PV IPI send
 hypercalls
Message-ID: <20180823155623.GA5065@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, linux-kernel@vger.kernel.org
References: <20180822101832.31763-1-vkuznets@redhat.com>
 <20180822101832.31763-6-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822101832.31763-6-vkuznets@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: LO2P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::20) To AM0PR08MB3588.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbf3b12b-6eef-4b2e-52d9-08d60910fced
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3588;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3588;3:kuDmAbahAPIwMhLk7ilX0WYLPF4ZFrVyHAUI2OOkO+0bPv3ZWmfdEAd6liNBtI3XTCr/lCCLhIwc0c9V+z5CE2UwTN6k+wqAxXR65TvHQjBTGqzASJa0NpSWfObS0fq6x7Rg0PIjmWtRmq0RzTaJ8UNrBc9djuiopwGdmfnnlLSfIUghKPzTYXaMGzAyMalDeP/ESSMiWqAOFHEgP1FsqUl1xvM7hQg4iqybxviat0YVDF9GDmJ577LdD6K2pLgL;25:3bDrtp6qUlfNiuaPB1zOtDbeHidD/TS6obOaupEjhcd/GmkekJw9u7cRau1Mw0mR9mVvmCbbUNW3Dl5A2T35RXg90jS6McE/69gfQN8M9iy6BfkvxgWNneOxlv2esP0b4YrMfQwSSr+LqdWvmDlKf6edBwfY5V/t+08FhWYOvhjdueOhSA5Y/Vd89RHjFHMUj3kG1+C/igiCWrf9/1D0T3eKeuNhPPpN+mE0cWsibnQRpnPhIiEyDGyHwpdXuAnJcm5opTIlPZf418u+6IEqdb8TVS52E4l6VvAkDjYX6G9Qj//nvsRkKfzu4qJWk1EFlZY6XomYk4+OBrXLPoymQw==;31:FHTSKiBCqTWmuAUS9avWNE76PSZLItHbsS+V/k78yfc0FzMABKE8u9z5eHkhfRB9EQTEBX1sBg6egGUXK83qodmpF6PDQiibosmqrnsfsKXyU704/c0oycr16NKM2bGMtHrEUaIc3RpQZbuOK4lHXnt8mQceyCnivo9AG9XDHb5I2a+OKBHqmuvjX1Lh7s2ZiLUDBzUAhQA2UVawvj82656is88wL/1shaNG5c/lmt8=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3588:|AM0PR08MB3588:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3588;20:2e9OYNz7mqvRn1LlzMbJhOniz0zyjzSHqxWdlSktY2pOKkub2aazheQGdeEV6nQ0jpU1X+ePOMKmF7F43M87XtI8Hbi/p9dpD/3esTODHegjDKWPxSADPcM8p/x7gZ7cV7QtszTRmz+9Xga5lygU0ZyEt8ooAv7ne3EgC31pyZrmzmruQODssBj9isyP2Z6o7Nrlv/FP61mTQMQxZWK6hVt+WGflRetj1jE1pj5HXNP6wcJQ5K4akh5aMcyKAohpIiTreDl/RhHIcH1+LI2Icro3tLYUYP85uPA0t2A0xO9FFzcUS5/yWWIuCYXZ2m/Vo6YsygX6hjXGB3/4ujZ1Kqovxl9yHa3luHfo/z00STPUmwrG0mVUibliCa3/Qx4MZnQOZ0Y5vzWLlU0KOTsUctUgVm3XcYNtg/4hxJIeSUdCfKu/NF77xYc/Pc0r1G4p3WBc8nwRd8BwDFjYEbd7mlGskwbPODzGHVEzueej/43nTcyIULvPohQiqkNF/3GE;4:T/zQP1g/afkyu7sBR2E/rTLepdy1jHRZEa3JCMXrBiUHf38m3uUcp110ZLUuhPp3btYOZodblp06zeOvleEyy9UqG5qvq+T6FmSqGmNBqMRW693YaLUmU+UmWgMHHXII2v/jHk6jO4uRbGRQU/MxqEe9UFH47nWUbtO+W5OHOvAEcwoxjNxsYx+VAX2MxbRxJpOeDrmegBcek7ufEFMoXjJBMfN72HiIYiMibAtQZRPWJA4XKu/4h6IbkSMCnzt1HJ4Q7f+x9YFg8kiUk9HXYNsd2hyD+dd5VT5OEAFi4V/jx6ydNJ/R+TlV6gaUGB+G
X-Microsoft-Antispam-PRVS: <AM0PR08MB3588C57EC3E9730ABB2A0C79C9370@AM0PR08MB3588.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM0PR08MB3588;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3588;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(136003)(39850400004)(346002)(376002)(396003)(366004)(189003)(199004)(55016002)(6246003)(81156014)(6116002)(8676002)(23726003)(53936002)(39060400002)(36756003)(33656002)(50466002)(81166006)(3846002)(305945005)(4326008)(9686003)(6916009)(53416004)(5660300001)(7416002)(7736002)(6666003)(52116002)(956004)(6506007)(105586002)(25786009)(97736004)(229853002)(486006)(26005)(478600001)(446003)(7696005)(68736007)(2906002)(66066001)(476003)(386003)(316002)(11346002)(76176011)(8936002)(186003)(16526019)(14444005)(1076002)(106356001)(16586007)(58126008)(47776003)(54906003)(69596002)(86362001)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:AM0PR08MB3588;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB3588;23:E04P6yHRP6IJTFkq94/VORVad6V4BZxYwT8ZrRoZe?=
 =?us-ascii?Q?occyCUBea05nEWvpC3LjVAvCQdwbfJ8zOOoU52uac1u8e9tYL6z6XQYvtVBt?=
 =?us-ascii?Q?hcXiPO0C9FiM7JkyaV79MIZqurj/o+8X49HS53e4gM+0qFD7gV6q46SDQpq1?=
 =?us-ascii?Q?DiH73WT7/z8G0ypXvUIJ+YF7HhWRb3TVShpNpkW+uhEQs21I/+dbtkMVIg26?=
 =?us-ascii?Q?qlIRDtz28v6c655m9ywmI5hd3tjvEBP6RFwGQpioWyZEmSVb1iN0JDI85YV8?=
 =?us-ascii?Q?iT9zsAX/EtLYEXmo1NyYh5zuXSyxSHxiJ2Y1IJpZ48rNSzf98KCjG8NucdIy?=
 =?us-ascii?Q?6wP2r8oyw1rXu42gcpWUzIlfjeIAgG5pkgTtBhSEIcSQq6VZgYAVcu/BOwrC?=
 =?us-ascii?Q?ZXLsYpEfh81lq7X1wTu/A/KcDV7sQcwuFCok/TYPjZZorC66L9ZPsMd3yWrY?=
 =?us-ascii?Q?nxiSf29JsZ5k25cYkRt5VX0+je8zsiM1r1i70mZawoVavjosOrVsAorPENNZ?=
 =?us-ascii?Q?4yHOiuHauBRgjOOTBrY35GC58kQhERGT4eSXznfA387aH+6gJASBe4MUO80U?=
 =?us-ascii?Q?EgCaVXvC1xEw1a6j6mu0oatn7eXtEX5YfKJHk0htihbPWZFJdWROBDQWVg/c?=
 =?us-ascii?Q?Dyy+FOGdTUg82EkguY91tCTAtAhhgMDItakgdmG7eUdvXUau8JWzK0LSqhAM?=
 =?us-ascii?Q?y7WQDkLdN/Q/99fJ7p0t9bYiCHkAv/h2JqaVfuBjaLn3bHYjEtL4soi4uQ4f?=
 =?us-ascii?Q?Cmte+j+c0X42KlmYJfd+JUsHS0TsX+rFcuwbUTTjM5zwBICG/f4Po+PAoEWe?=
 =?us-ascii?Q?TclVPGwLMpbBmPsQ6eRBgH9R+YoLream33x5SVud3fgdTR4myBMEr78nm3f3?=
 =?us-ascii?Q?IcoVstsyBRjb7m9uwdXDJ0eSbGIPqfzReYIB2OW3Id1UlWFtdpZUXwH7Y0Wb?=
 =?us-ascii?Q?TugbPIme407ZZKcCP6HllQL0pY96tAriktVV445j6h05RkQVqH1W56frIqKW?=
 =?us-ascii?Q?oa/OuLm6xQ4IBD/WefnQ3jLyfLtsX8e2OJi1RwHLcLQ4MN0/C5L2wI7I8dSP?=
 =?us-ascii?Q?CpyZm6bokmilEUdKxxujggO8tIHF8C89FsCBEKafNpROHZ9AyeZi/pF3zQ47?=
 =?us-ascii?Q?2Ed5sShOHBMCLUd5WSLD1aX0ddEjD7BUNUgNCvA4AeXEGDWdzjkbrfiksJoB?=
 =?us-ascii?Q?5ZR2H9+9uHtuJJ8JzT8Xi9HEKcLqDiijYVQDDE9b0rRo9VET0EPBHzVleSBW?=
 =?us-ascii?Q?1iqA21PRFi5Ws7wEIaz7RLszpgqVtsEP61VL3XraiPce7xN+mOdeUouvdB1Z?=
 =?us-ascii?Q?l+1Ccw+FPi9IDT7pHxaAhB8wO7mqL5bltxNwy7XDcbmT8uyofrG05aZo+eDn?=
 =?us-ascii?Q?iLR/l3rOIkp887aPeo9zRLG2PKQ9Rqk+eOAULBDgO3I3M3iCTYQ8r0mNznnv?=
 =?us-ascii?Q?+LhVPLXpA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3588;23:BEw6mExcoD96jDd1qvxOiU9Re6ZS9eGnVfHxmJczsHhiYU8VrGbWv70EW2NmFPGM0FMB/ytWT52jF/0qiYuptTvevtg9IwkUday0GnMIuHxo5310vPdxuLizC6PgCPQy2VL5GgRrbd/oeHLa79GSZw==;6:Uz89f3VwYsQrz9pw9VIJKJgD63wWlM9eJzUHERzbTNIVhuWq7Hb5OzlQeoZjeWdblpYbYBA6N95yGDigks3LkgWm6YpsrfPpv4tTJR5BysiXqfOG/mvciSyM33EhxF+ae2rToPiDVD1ETjnqQZFCFAToN8WDvjbYdNCiQYC4kiKb/SfCtCUmDBptFgt4RU0NZTKNW9SVsFVUiRgcNWkazEid/zwzmYpK6ZEw4nsy5sfFdcvfdYJbaNg8ELN4QHx+2/yEzqVand6OULGfua9q/nY4FxqGoMrt0G1n/nNuzrUN7elU+WwpdOP59Dbi1n4wYWW4lbMgS48uKhczLD1R2hBfWArIDZs08h/wE5snpVP/qFxVU6U7tjtl4eT3kU0StFgp6ogMO4vTxFpmx1LZ4ijmV5Z+McXrvvHHh706muK4cI0C2/MoDwXIHsooXzopSCgLtIXSj/p3s0SlfTWEJA==;5:SlJDebSqpqNq29TylvlC7C0taCh8ocMd72qP3ToNAm022oFI+VjeTXsfNsj3ICbBcV1YMN/b5cf9y2NU4EBRXNkVp+syzN5WQASA1wYtXqOnNajn/Rq55SSz6RNTNNZvIiUiZi7uTlbkeZa4ni8FShy6aeoschMXZWEI2w3iFAs=
X-Microsoft-Antispam-Message-Info: JJEzyyj8EDFGHCxbI3ZrfjYI36iUV3aGzAz2CoNUjCol0vXY7wZs3T1L3Z9RxxBnPZxIDbbNeGJctaHmXV5FQN3FMU/PCdGzE+5cylFahEqaolbR+C33MiIFag6CFmJaarImSpN+QFXjp89P7Ei7dRjeLzRGqo8LXYF1jqEMGmMM0FAgvxkeZNulXwDOrFjZln/4CYNAV8JUzRT1Fkku+v3gAI7flr8LD9iqmhLqrJ+XD5NDP5NjCpploStNqBtV9XAUVv+UMXubDT8XFxazNDDnwKKPz57218htcVUHCsndVvkfjE9UM2fVHz5pluLwq0Q862wm+x9uo3PofcfrmN8EpD2s0glrPcxWfjmUNh8/84SUI/K7FXRO3L/FK3kFPywzZYm6O5Zuc54C2OeO3UsN+vcZxvIcbJGQQVm7PVpbfANF3dQ/JQYib/jY510pJwTJgWcPq2aRBfiQKh3I+9cNzMHBjel3X1CL0Fkpp42sq4IaAFFDVxfDZq19M1vXvoRLVrfQLuUPToasI7wg+0MU1qw0Rwq3Ywful2dANRM1kmV22mNYJnsrC/eMTaooiebAydFZyLDQ18ODx9SeWA==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3588;7:OPT7YsZHs/Ecu4Wg0UzmJYBEcya979v70ZO/4lJnKVB4tXcIORVjyutioS129hhOKOZ6+0iv+Fz6sgoG9ifxRpLdg4lXoYnLpXBjyQEmqOQkxmYIcS6Oe+vbpjQ2AbNLs0kk9LnsS27wUQlvZzRmS5a9frETr5u4C1Xuqz6w25XDiLNgVtyMJ1n/ij6DDqztutD/o7bhgIiPizY8zTwZUTWqF/rMscEg/D2sP4+05T5+BeDRSQuytiWY3NlGuBwF;20:qKWLRMDpJwdXoqWcYcABJgHm7t/NmyymbP9qCAF+/19dl2hhSKQpBYVNJwYLnMfMSPSJSXLy3/4ZKuzvf4poA4y9xavPSBRTxNzBFELdUDLyI6/jATdXUcUGwo/i6+WBc6FmyDgjVCmxX6M+bkKd1Qs+3xBNYzTjUOONPxX7jhQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 15:56:27.7045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf3b12b-6eef-4b2e-52d9-08d60910fced
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3588
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 12:18:32PM +0200, Vitaly Kuznetsov wrote:
> Using hypercall for sending IPIs is faster because this allows to specify
> any number of vCPUs (even > 64 with sparse CPU set), the whole procedure
> will take only one VMEXIT.
> 
> Current Hyper-V TLFS (v5.0b) claims that HvCallSendSyntheticClusterIpi
> hypercall can't be 'fast' (passing parameters through registers) but
> apparently this is not true, Windows always uses it as 'fast' so we need
> to support that.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  Documentation/virtual/kvm/api.txt |   8 +++
>  arch/x86/kvm/hyperv.c             | 109 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/trace.h              |  42 +++++++++++++++
>  arch/x86/kvm/x86.c                |   1 +
>  include/uapi/linux/kvm.h          |   1 +
>  5 files changed, 161 insertions(+)

Looks like I forgot to respond to this one, sorry.

> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 7b83b176c662..832ea72d43c1 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4690,3 +4690,11 @@ This capability indicates that KVM supports paravirtualized Hyper-V TLB Flush
>  hypercalls:
>  HvFlushVirtualAddressSpace, HvFlushVirtualAddressSpaceEx,
>  HvFlushVirtualAddressList, HvFlushVirtualAddressListEx.
> +
> +8.19 KVM_CAP_HYPERV_SEND_IPI
> +
> +Architectures: x86
> +
> +This capability indicates that KVM supports paravirtualized Hyper-V IPI send
> +hypercalls:
> +HvCallSendSyntheticClusterIpi, HvCallSendSyntheticClusterIpiEx.
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index d1a911132b59..3183cf9bcb63 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1360,6 +1360,101 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
>  		((u64)rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
>  }
>  
> +static u64 kvm_hv_send_ipi(struct kvm_vcpu *current_vcpu, u64 ingpa, u64 outgpa,
> +			   bool ex, bool fast)
> +{
> +	struct kvm *kvm = current_vcpu->kvm;
> +	struct hv_send_ipi_ex send_ipi_ex;
> +	struct hv_send_ipi send_ipi;
> +	struct kvm_vcpu *vcpu;
> +	unsigned long valid_bank_mask;
> +	u64 sparse_banks[64];
> +	int sparse_banks_len, bank, i;
> +	struct kvm_lapic_irq irq = {.delivery_mode = APIC_DM_FIXED};
> +	bool all_cpus;
> +
> +	if (!ex) {
> +		if (!fast) {
> +			if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi,
> +						    sizeof(send_ipi))))
> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +			sparse_banks[0] = send_ipi.cpu_mask;
> +			irq.vector = send_ipi.vector;
> +		} else {
> +			/* 'reserved' part of hv_send_ipi should be 0 */
> +			if (unlikely(ingpa >> 32 != 0))
> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +			sparse_banks[0] = outgpa;
> +			irq.vector = (u32)ingpa;
> +		}
> +		all_cpus = false;
> +		valid_bank_mask = BIT_ULL(0);
> +
> +		trace_kvm_hv_send_ipi(irq.vector, sparse_banks[0]);
> +	} else {
> +		if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi_ex,
> +					    sizeof(send_ipi_ex))))
> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +		trace_kvm_hv_send_ipi_ex(send_ipi_ex.vector,
> +					 send_ipi_ex.vp_set.format,
> +					 send_ipi_ex.vp_set.valid_bank_mask);
> +
> +		irq.vector = send_ipi_ex.vector;
> +		valid_bank_mask = send_ipi_ex.vp_set.valid_bank_mask;
> +		sparse_banks_len = bitmap_weight(&valid_bank_mask, 64) *
> +			sizeof(sparse_banks[0]);
> +
> +		all_cpus = send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL;
> +
> +		if (!sparse_banks_len)
> +			goto ret_success;
> +
> +		if (!all_cpus &&
> +		    kvm_read_guest(kvm,
> +				   ingpa + offsetof(struct hv_send_ipi_ex,
> +						    vp_set.bank_contents),
> +				   sparse_banks,
> +				   sparse_banks_len))
> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +	}
> +
> +	if ((irq.vector < HV_IPI_LOW_VECTOR) ||
> +	    (irq.vector > HV_IPI_HIGH_VECTOR))
> +		return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +	if (all_cpus) {
> +		kvm_for_each_vcpu(i, vcpu, kvm) {
> +			/* We fail only when APIC is disabled */
> +			if (!kvm_apic_set_irq(vcpu, &irq, NULL))
> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +		}
> +		goto ret_success;
> +	}
> +
> +	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask,
> +			 BITS_PER_LONG) {

I think you need exactly 64 rather than BITS_PER_LONG

> +
> +		for_each_set_bit(i, (unsigned long *)&sparse_banks[bank],
> +				 BITS_PER_LONG) {

ditto

> +			u32 vp_index = bank * 64 + i;
> +			struct kvm_vcpu *vcpu =
> +				get_vcpu_by_vpidx(kvm, vp_index);
> +
> +			/* Unknown vCPU specified */
> +			if (!vcpu)
> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;

You may have already fired some IPIs, so returning error here without
attempting the remaining vcpus in the request looks inconsistent to me.

I don't see a specified way to report partial success from this
hypercall.

I'd rather continue here.

> +
> +			/* We fail only when APIC is disabled */
> +			if (!kvm_apic_set_irq(vcpu, &irq, NULL))
> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;

Same here.

> +		}
> +	}
> +
> +ret_success:
> +	return HV_STATUS_SUCCESS;
> +}

To my personal taste, this would have been easier to read if the -ex and
non-ex versions were separate functions preparing the arguments (vector
and mask) and calling into a common helper function to send the ipis.

Roman.
