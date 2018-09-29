Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C405C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55021206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="urpVln0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55021206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeI2Lv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 07:51:27 -0400
Received: from mail-bl2nam02on0056.outbound.protection.outlook.com ([104.47.38.56]:49280
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727483AbeI2Lv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 07:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI1Djg5JubFgmUsuqbUfvsYbfHojaDoAqm6coknn6Sg=;
 b=urpVln0NbAm9PDVrMVjbzE3XJU8Z1TQIus2HyRg23TyBu+ygE5qmMBs3vEfJt8HTvCy8vmGpkWu5tegwLNn4WJfZbAqGsMvRj5xO8O02L4lzhnXIbWCutkTZMYLxBySx+Mcs9n9IFGBC6SJ3odRKE5DfNbTyFsiCTtr/ztPHgRk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1576.namprd03.prod.outlook.com (2a01:111:e400:526e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Sat, 29 Sep
 2018 05:24:20 +0000
Date:   Sat, 29 Sep 2018 13:20:36 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [BUG] sleep in atomic in 8250 runtime PM code path
Message-ID: <20180929132036.0323e24b@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSAPR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:603:2a::33) To BY2PR0301MB1576.namprd03.prod.outlook.com
 (2a01:111:e400:526e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d79cdb6-666c-4c02-5006-08d625cbd02f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1576;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;3:ljtYDFW4UuUO455+Rdu+SoRPVYmNNFEbH741fz36tmn80cOWpbYTwU5aPWQkv1bv4glzsN5p86l96N9vENjppITXuBUZH5tSIjiArWT6a6CksmFK1bRrdAqJpgkB5SbnFU62GXeaG2gzIKwpRhNMD09RnsjmBH9uMvu+NfRkZ9/Y3orZ2C/ZEpuC+81BOnTM4P6ufz6qJEOg+zcuYBCOUwjMHteroqq04unUfip3QhZrjtnhNa94d7/1C7iDdB5w;25:Q9i0pcysdTbh+LQkGl8AquPv8Kzx0Ny/858Ae/O4a+DHh1NpuRgfk+C3yvjGQG6cucwN75iKPVj9O0IVndSqzlzbsU6ecWlsh2mDUEbYfG2+F20+6F5qNQu59Pu95cFnq9pIpoanG1eLMKmIyZdcSK+LNAHDU8J+HwU7wckiwkEn7xJ0HZQPFfwyjzH7rmhAAHn+uB5kq4Zjj3Jk7drrfnrqEcWXtOajZ9r9uERN/b38C+gocr7YnhDAHDH1wgubE6JXeNSL+LpXKOJ3PDhlo4IB1EUBuy61Nnb/XuHGmOk2jBZ1tcYYPk75Nth6kqDpSeoq+TOO86He9PoIhJVMhw==;31:l/bE7wfReNwMrBehm2aaFonmBccy5C5DPIL3hCxK5l/vy/szH1AT5NK7ENI7Bp5nlDKm7eOXJUAJWKNkrcCtYzsPBnOOEnn+xsJcqe9dAFaWypnw6YBRJzxXeWuVVjSVY3xtXm0cVGUVgZFYYTxXrL7znj5KfNy0c9b/elMeu2ljlurOXCHCuq6xX45wIt7Y7v00pI7ZyLYzMP086CwZfn36h2xux1rVFTe/MWN3KJI=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1576:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;20:nMuFxxZEotPSdXv9ND3LaGpxWhqxsE6+K1BIY60HIw8eaHtNUs6dUGbNQmjItM21Sq5hw782Tsi0DXlFoEdI3gRPNRwdnjFXifv18xqKW4d9OiyyVtiktHwua2Xi2PKnoczr6ym5MzXuEXoV2VKxlQ9X0GAh8avDFyIYiUHZY+FRDCSsBXNLKiBpK/hAOtI7mdSjCD7I4YnxfYkBABnISo+cjkQKg1k3ICxeS3R5maZlywzdTJZiQy6gm2mssSFQ8G8yxMQd45wpMgfxbVjLEr0GRn0D0gqCxWtlIdzOG7C83f1Wi+4Tx703D14ZkOhY6WzHUHKIxE8Y/4NiMDnSvPHovzW2l0o0rvHeuWRNjH7BRrfS9UYilCVfegrA9DKp8+0B42yK1FS1Kveg44ZjSC2pYrSI/89NlEj197IsQY62yNOLXooEaqv/0648W4+cZL5H3e0YTYBv89/fyzEcSINc7Jn0GW6eKv1MLosFOu9pV9nYPxXY75V0sAI579Mf;4:8pIyA+kX3uHIyQQjvDvNhFBr/my4mUCkG69hm4IQqLBdMdEv4bW+gSlDe94M7QUFRHGohMBL+T1ieKh5828rULE2gswpEfSJVLT6CEoOPTFcTlzEmZO0z8IM+8RvpWroeHsuzqi/661rZ4L6GHRb6TiiuaPup3vVejIabn6F7029qIpxzJz35oyADqLVzK9V8wguTu9LASkHlIjT/EvKv3i2YHXFiYY1CxVu4FsIrvdqr9PUOnSn8W7spDrrgnhMva7SVCyxQ4j1NI0FntLHnA==
X-Microsoft-Antispam-PRVS: <BY2PR0301MB1576BFFA56C9CAFCC8974C5AEDED0@BY2PR0301MB1576.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BY2PR0301MB1576;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1576;
X-Forefront-PRVS: 0810818DA0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39850400004)(199004)(189003)(3846002)(23726003)(47776003)(6116002)(8676002)(1076002)(305945005)(7736002)(66066001)(53936002)(7696005)(2906002)(52116002)(6666003)(68736007)(25786009)(9686003)(33896004)(55016002)(4326008)(8936002)(72206003)(81156014)(81166006)(478600001)(50226002)(5660300001)(316002)(110136005)(186003)(16526019)(26005)(86362001)(476003)(956004)(97736004)(14444005)(50466002)(6506007)(105586002)(230700001)(106356001)(386003)(34290500001)(486006)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1576;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1576;23:43mcdF1oP/tgLQ+y11JY4kKPgqVzTW5hgPoFPL/?=
 =?us-ascii?Q?Exwgt/0l9y5qqiqGgZBbTixaZtxkWq5UhxEUn8cLbfR7MAhOr8gywpUjOl1a?=
 =?us-ascii?Q?+6YNx/HTwykee9C2s2JrCaTfp3SxXlvl0SYEYYOdStE4wwoRGafiAaxsL7uL?=
 =?us-ascii?Q?/oV9B8i2YMcPmwBErT42P6wnFj+FZ8TQED1TxTaa1Ntz1HK1NYU45egFdwq5?=
 =?us-ascii?Q?NpXS1PJ0wNpTi4yIEOJqpxBYcBQzaakXj50W2v/9g3bRDrG9mHU7Wiq5GpJX?=
 =?us-ascii?Q?O8so1AlMEWwaNhwvyKgG/z0ILSEjUt4NymOz3No4y1nPD7Z5c/EA5XlmAduL?=
 =?us-ascii?Q?BcqDejqMpde+kJIaY4vsSyUvt8iB8KrLCRpY9bYFB2yjppzlYMTDwA52gH4a?=
 =?us-ascii?Q?/FO4n2/y6hk15B697FtzX4OXtGy6e6ds8x0SPwUb8LuT0CTlZViEFFUMUf5y?=
 =?us-ascii?Q?IpskqBMZla2BYNB1KZNza/qa4LhC0TgrkYVj28sSL3bmL1YwNN+uElRpAlc2?=
 =?us-ascii?Q?ePlekHQcPIdMqZSat4Q6fuVeHbxcy/+Cmykje1ju11w7LvhpW/UmjatF64dt?=
 =?us-ascii?Q?Iqt491oYufH3eKoxNHgnb6PDov5UsYHQq2opQO+csrh+6ZhWwSvh4GO3GON3?=
 =?us-ascii?Q?wXlxSkjN4LyluRK3cRKvHfPuj2rNV0xdOlg/abLu4xAoUyCBWML8azZZXncc?=
 =?us-ascii?Q?XWpvSthAIMHOXNOtQ3tL8Y2ebtpCDlYxVmH4UgWakTEZdrvg/Jfy5eBjHeVh?=
 =?us-ascii?Q?jQD/3RcaCED1dOxtQz+D2JY3q4EH5PQ6dfueN5+FJTpT4twGlBVSWKSr3+WJ?=
 =?us-ascii?Q?6CC//AhcGTh2Yyrtrf28u0kthRF62380lzuy4FyI0uHHzuNEXFZSls9Io28l?=
 =?us-ascii?Q?+kGIRJvddsKzqiSA/eC2e0hpWmGWESbt9BINLy/LpA36ifQOUtSjzsNbA+N/?=
 =?us-ascii?Q?4KBcV1Gj/Qv4PliE+GdpKVLyHL9eFeJEQSa5IvAXhldvdn/Pe8ZwO3h69EMT?=
 =?us-ascii?Q?TpcKaWXUaPeRIutz+kFm/dX21qZR3K3Nb92PrNQuUw5hsmzF2JNTwJGn6PUB?=
 =?us-ascii?Q?Pf1IeB72IvVIgyqfnavMnwY0MLLF+Pm1bDcfI6RSBozztk99yhwW1paWtTeF?=
 =?us-ascii?Q?CetYXSyjL0pWVGv6Slg7kdWw7dd51YlXrzuAvje7wbZiVd9P/KSGFrkwhEIk?=
 =?us-ascii?Q?fg92zLnqIrKVaE4+/8giN59e8n3yRbtAuKmg6?=
X-Microsoft-Antispam-Message-Info: LVpjLhqk6ySAytjeHqlAYF6S+H82iXhqxb/a9cOMltC7Hk69IrRMCNu3NEg84odXq0e8NNJF1BewsLncq1k+EZCgCUULvZ4/haYBngoMfOEjTT28XPAw6CPBeltvUo/tVxgXLeSQKnP8x57MEgxDBdLsH1dSWXJM+4jnSLIBoNO7KHN7sRDpOJyAFo00gocyq1ADM4Vo4wqOc+bP2fijuuzO48io8IzrOcYt87fW3lMvM1Be8B555CIZpgj+nKdbMG3XdTlc33IghH3FJjkfSKmD8gR8r/6yesAx7ML8KjDVqmJC1noAFuAkOFIFE0qvMETIVrP3+QUE9xvF+RJJ5bUdWhEU7DPsmr2llrhQXw4=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;6:ZXsk7at+tFocEs4svsjYMCXRJ8jtkxmdedhsexYPpZ474zmNcvQzLdKNYT8DJQVUMZwCFjzPqayE7B0/+nJk1MszILsaeRneCPVBtrZ/OTS4h6qhkIfjYYtruMUsOGL8LVrwrG1YmPnbn31+l2SepqYLlktGDjLIGB+hJc5YG7sd26Iu7F0/JAnlXeaTzfPIcfnsEZPfYxQOOZf39cEQs7LL7qYcmosnYIQjbO+uBFSFunpMdMN1ARDO4AYKrVGSKwLkTXThlpfJXYFMmZ8CQnyakoYYx3XzzXUXdr5mYivh1VQ41e3KSBLShYJgaqF/mMsjIjLxJxFqhwRHTV5dxO85BzAfbjgxjJrLTJLXG43HPSFVI+KK5o5Kdb1rkkRae7v7xNI24RhVEfFnSYTkuPRMEcwrZIjcTHsfEmBTvQtiWkfLfkOBsogXyXymeU+9AXYRF3g4dXNth4k5xPX1tA==;5:3GlvOI6+uqyXe1EH+7rwmRTf+fmnFVOAdyUhWffAIZVTvVNY1sE6xA2+PMdcSkwaWEMOKuchKZ15tmLVPM4XwdUvPiJs8lDdcuSLQQvTkw24IQzPKBLqE+aAU72t1SZKc4ODDKVPwVCLqVc16uw2JK7ClbxrCGKtJUA3Qg4cAkE=;7:wfvYBIN1oAU6d9DlLoky0a4XRI88RC7Cbays0yowtCPqFFpjV8K4OcK/O90PQuPVRlxHpdd4nwBZK8uiG6564x1sB1uBOJqQHPy2Divk5tqvd1j0CBosmpTjfj3cYNYNlmRlDtsOpyZ2uUq9zvgSttEH/Upe7Kcvk15cpQJG7k2IQF9fiUHtWTYJK7PMzHer2FdlouLr/Zshrz5ovNYdriKnSEwjGtdV2DEYFjM6I2infyxjITpdaIA+cqLm8m5e
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2018 05:24:20.5451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d79cdb6-666c-4c02-5006-08d625cbd02f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1576
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently I found I could trigger sleep in atomic bug on berlin after commit
d76c74387e1c ("serial: 8250_dw: Fix runtime PM handling"). The path looks like:

dw8250_probe => serial850_register_8250_port => uart_add_one_port=>
register_console => console_unlock => univ8250_console_write =>
serial8250_console_write => serial8250_rpm_get => pm_runtime_get_sync

The irq is disabled by printk_safe_enter_irqsave() in console_unlock, but
pm_runtime_get_sync can't be called in atomic context...

I guess the reason why we didn't notice it is due to the fact that
only OMAP and DW sets UART_CAP_RPM currently, and DW set the flag in
May 2018.

Per my understanding, the bug sits in the 8250 core driver rather than
8250_dw.c.

Thanks
