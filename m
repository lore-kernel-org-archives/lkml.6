Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968A4C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3869E21761
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="gRYsuSWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3869E21761
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbeHMQgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:36:15 -0400
Received: from mail-eopbgr690050.outbound.protection.outlook.com ([40.107.69.50]:60480
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728778AbeHMQgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4/YPSLoXWjXVhIGwVbO4DSzIAL5G26L1wbrq1zrjKk=;
 b=gRYsuSWo004Hqlhf92fkh+8L3hdUMLntcdsMK0omT/Stv306O89BiOpatp09fZu2lficTHaab75KNhpV+PC6EyTs1SgyamePPlf/T1ZavMK2vm+drhmh8+YgUjfUNVusOXGjXLnUMxpFcDbCfXBM/2sT8rvMPJUHpwq+FOkXcX8=
Received: from DM5PR03CA0046.namprd03.prod.outlook.com (2603:10b6:4:3b::35) by
 BN3PR0301MB1217.namprd03.prod.outlook.com (2a01:111:e400:403d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.19; Mon, 13 Aug
 2018 13:53:48 +0000
Received: from BN1BFFO11FD011.protection.gbl (2a01:111:f400:7c10::1:153) by
 DM5PR03CA0046.outlook.office365.com (2603:10b6:4:3b::35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1038.19 via Frontend Transport; Mon, 13 Aug 2018 13:53:47 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD011.mail.protection.outlook.com (10.58.144.74) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Mon, 13 Aug 2018 13:53:47 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w7DDrke8003590
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Mon, 13 Aug 2018 06:53:46 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS8.ad.analog.com
 (10.64.69.108) with Microsoft SMTP Server id 14.3.301.0; Mon, 13 Aug 2018
 09:53:46 -0400
Received: from localhost.localdomain ([10.44.3.40])     by zeus.spd.analog.com
 (8.15.1/8.15.1) with ESMTP id w7DDriwf000703;  Mon, 13 Aug 2018 09:53:45 -0400
From:   <michael.hennerich@analog.com>
To:     <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <baijiaju1990@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] drivers: gpio: gpio-adp5588: Fix sleep-in-atomic-context bug
Date:   Mon, 13 Aug 2018 15:57:44 +0200
Message-ID: <1534168664-13034-1-git-send-email-michael.hennerich@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(438002)(199004)(189003)(26005)(77096007)(51416003)(106466001)(186003)(486006)(72206003)(2876002)(36756003)(4326008)(49486002)(246002)(16586007)(8936002)(50226002)(316002)(8676002)(478600001)(14444005)(336012)(5660300001)(476003)(126002)(2616005)(107886003)(86152003)(1857600001)(426003)(86362001)(39060400002)(6916009)(47776003)(356003)(7636002)(106002)(305945005)(50466002)(2351001)(48376002)(2906002)(54906003)(31853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0301MB1217;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD011;1:YIr8AdNZtMFLKywka4ZdOAlXM7/kHAJ5RBMoH516aLKaG+1G+N1KydiU6V70UTmgatBUPPbWFS8XTwdVSZedlY3tJkiPn6hQQuhHBM9PQBIsaf9an36egBoF6kRPhEGf
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c5e8d31-563d-4455-8cee-08d601243106
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN3PR0301MB1217;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1217;3:yEX4nCAd4QnXA7giO8+X7QXCv36cqoBzI+g1EYIKMY5JR+8/dCbmCSc7O6vL3a9tdZSOYSLDxXKk6VYlghPuLQHnEtWWTjr7U/Cc8TKsZqaaJ0d6pKx4PSn66qOlt0RDYZlxDlR+hxO4JOvGOVyHyJ9TfazrsGJsgV/ZJLaiZIMgrGa0AMdFLufL30lr6KW3x7/N4hl/8flMAWNJqGvXoBp7KxCeGJSnT15uRgZcApkIgfyByJsvLM9rQxDA/Bm891OtFbK8Ocs1Tp3mB3SzbxF/b6eqEVHvJQQEnjbEq571Nb/QYqQ7zDoHHt0PxFXiB4UBG24w8IaOCN8BQU+IFxufQdlsucCC9G8MqWlHJ5k=;25:YrhpBTxpvtZ2a+QgzTB/VzJko6Gm59MedB3UN+haAn9CuqniPQRwbhaFYJjErUDWNnlNwYoFOHdOJ5L0tU/I/lkOHJ++xPpqrV2iUI9c6tG+9G41I/4XonH5IheXq+crw4FWVYPK6RxPBaTcQuAQIN+K1mox1//QQ8NjgrjPW2lO4Vy1CLpw0J8w00ssQOmHACpbMRIQLFtCs0RV8HQZWqvPx3H4Es0skEXLEWzBv6zrlUT6XAqwoRxX1sqqE1Y+/jxNWOTpOEKtU24+Ca6mw+GKnVsbE7Xk4bcJFdiIvaJoTRTSEdFBghIDZuVvl5j5qNxdkU7qhJU0q7fRdBMrfw==
X-MS-TrafficTypeDiagnostic: BN3PR0301MB1217:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1217;31:dncTdWBGfxPh5PgKO5ZCZteIhCv9MEG/mF4pA8uVVTUt1BzJ/VCph9UtyVtYfJ8uPOS3gAMN7+fTk30NcpM1YBlgE92scKZ1JxZIoULAi9/YTKzh4vlJ5KtTFfCQjllJndzHm5DNECHqQss2qo50dFVFLKi/WOWHjmeetmo5/7ROlOfKlGQKQ5zr/i0MlycaZrTB8j08s5gye12X/kttJVW5UaDQa3qhcdbLDqSmCPs=;20:0FOh11ePXd7eIXYXkDwC59w9dfhwpEojwSYesZs0HX5Lg7VE4kF84/SK0IRiVmiDmnGDTM6rbT2C4qm6s4jgaqzisiK0G20IxIeNng0ebrQQwhRJh9/P8Bc/gTfgClv4T5KkOU2THv//g5NhUY1INFY4PKj79BWQpT/QUGjjF7MMmkmMKUUQ61r/kB3V/IgohwXhX20vH7wNgTwYk3NxWE3Iw4Xei88PcREBneW/2WrmifdLnwutQr4/7LovOOiD1LqkT9Ado+oETxkJi8MT9RqO0ez08XHYps1y9fleDhPb2GvmDNT2C5iSw/ovWN9Os1qXei8lQO7j8tITW69+w1aZ/nwCyNUm9rDdwiiEBdWrKAS0UIY9qmqV54YKuBsmFuH31bQl1/Wa179NfT3ItO4to9igCDoQPAZGjsPgLcOtz+Of/bwJfj82Lk06hRWviSPI/6Refl8uqoicYpYK//zC8FlZUFBxr4+zvpIZCMoqbykZmNe5be13jEciy3RN
X-Microsoft-Antispam-PRVS: <BN3PR0301MB121787DA6BAD2C7108165FD48E390@BN3PR0301MB1217.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(85827821059158)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN3PR0301MB1217;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0301MB1217;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1217;4:8sPppGWwCuPO9eaq4fFRWc6tDh8/cUterII3V9bdWUHZeZtpsHHfnLEq0kImHulJk7JJUUKWtadzGQmK4jNYzj6JmHJ8z0PpZQop16S+2hmMTK+wsRWXRiowtNqkNfhlCrvwXWiiv+G6MuQo0oU9ERvpHcBiB0H2ubSrc/VllFFHpsgjJRcXSad/8smjeE50kwfn2PQboOVpd3BXF0HKEkm3cwhXK+PLd/VpHgThjoo/KohQxViNjuoYaBArVQ7B6t653j6X5cBIWygsYw9tX9NBtEGjER3281IsqxCpeyF/0rKEgITLQhU5G44RoO/b3vtDFQ6PKrAxu4lAgmdOWEg9QHVOarD6JKzCX4LZNzqe/Mw6vT1etD3i9V9AYLD8
X-Forefront-PRVS: 07630F72AD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0301MB1217;23:/DV8QL/2cMiZXBZASN6JnYKwW/zXuv7mueZgfFO?=
 =?us-ascii?Q?R5oOspOb8HMT2zkt5LLQQFYVWHSGvbt00t7RWsg0AXWVUYfnc2Z6r9S1cqio?=
 =?us-ascii?Q?mjGRzJWjeFPHUru4m3FLmhpuKfq51eYVz9LEuTMnxQ1IaMZTq9nVvsplgmaM?=
 =?us-ascii?Q?hA+pnVlOLYQXj7XOG1r8ukW3X3BG/sUf5KFomXo2EyPVwwmyH7F8u2blCxEM?=
 =?us-ascii?Q?iZJV3KyTX8dGaKoNdSvf55tBjbJh4aZxA1dcflsPdzUPK95ARem/a7/O89q/?=
 =?us-ascii?Q?Es+g52V/gEEhus+AdBxQTGcq/ehdemXY1IwH0S68bgvXxKeCf7DaMxZwyk/Y?=
 =?us-ascii?Q?yHe82SidDlSkJ/hFCM2SHxpEBwU7R2x/TvBylwdKf4VY8TxrBfBDZkzr0nMn?=
 =?us-ascii?Q?wnSppg1L4s6EHfp3Ox9BNG3S5eDhFhCoGR4t8L6JkoIkAjkgTO6S2zdEoVZQ?=
 =?us-ascii?Q?V+3j2n81b6xRFyDxUpw863T5HeNT066IurTNqbkXpW/slYEDqNSF4kRsN3Bv?=
 =?us-ascii?Q?u3JV+abb7PKZ+xaEJwIuyfCCVi0PjTwgnitOmqn3vQxQstwahctUL0tu/yxR?=
 =?us-ascii?Q?fuTDNgkdd5j/mtHTk3UVeyiWqtRQm/XTBBL1+X093Pdg7BU/EJF2zSHLTlzf?=
 =?us-ascii?Q?M51AVzGzfzRBOWxW2wiiGa+VX4In+OEC6u5ebdki4cAR2jD7PQvaqL/4ziuQ?=
 =?us-ascii?Q?IN2U01FnDDky27pXzKCJAbbWkpMJY35rpRxxzSlTYm4KtQgMxwG6EtJvdc7c?=
 =?us-ascii?Q?DyY6No1KjdCpYRdlE82TPbSCPcXZMyNF0gCvU+Tq5ZW/oNwyFdVzJpL6mxMS?=
 =?us-ascii?Q?lpE9og/MuNEnxsBrbp4FAAAKIudhxMfEefpfiHVeXYq0vPkOhBov7FpW5XB7?=
 =?us-ascii?Q?wKHeTztCre4jZe7fcQ9HKV1xxRyQ7Hn1aat/TfHMJJ2bGh9oBkS5JpNBAR6r?=
 =?us-ascii?Q?koNJFxccQOImx+biT1rAlON7QO1k2CoOFvFsn+5+6JF/dX2MqvU2hjgTo3yE?=
 =?us-ascii?Q?qIZSytpZP7oo2YqA6v8O1jAU1MTPtOhEroPDs0NUJYxKuyveWEaWlgNc5oGd?=
 =?us-ascii?Q?IwgjArkYP9FFKuaYJy7a8R12cDWYmpt2H+1Y8cjF1YWgSLJerdVZIS+Rn96E?=
 =?us-ascii?Q?4Duf5RNKeB1Ykpk48x25rybiljGR3uxBz?=
X-Microsoft-Antispam-Message-Info: E1kudFw80ZopQ7XQT2sy9I88KzTlE+KTG5mt4EVqdTHw7qXiDRb3IlD0UNZ8drNd04vG3VqEIGqgi/OK4KXbFNY4As6lmQB/4wE3exiOUnJFB7vPHjGyjJMbFRfPMbqfhuDQxx1JdKO0e06ezV01V28kWSujwK0B/ZMsPgH78Xs3qxNBcIRsklNNmvhiQzqu7KeKvcdPptERmQrmlazZ1B4iZzWii/MoD6ZMkcJ4gLa+9sH/DdZZtbWxZXWhsCmr3fqNsK6pa0wKvzuSh5ydJo+6qtIa8IkUoyJdm8vG9CM4k4LZF/VLEh7m4jSTsdViH+kJya2fUu6fTzrYhUoR/f2Dsdn9WbGKjfYcG44Nu4c=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1217;6:oGGd0RdPTDZqQ70yt2dtDKpUQ8LZrAYYKoxDSL3EhHt2dv7DCm4ciB/GZX/fYydcBNR2rr0ImRhvBiSOyMT1JJ36ZPLI5/gxusfskG4XsOz74Vitcdkjy+StEKb3oxFmn3nEYvRcpjre22XOIHyfeQluUwQjT7My9RcqrJoM/Ds6cCpzgSK6VDhXJ5ChB2LFVInwguajGVoLxJFr7Gs2qTSVhgVcO8eeYNGpJJVDu2vcjvFuXWvCZKNBo1TgfNhnRTkP2ajZBQA4vTdq0xaK5+cSHgx92NQkdixwM9fsORSNPMyEnRpgvthFB+KLAZ3KQCHfRIcHZk4Oq+HTGvVcb7AkzP3Tnm2vT5Wo0HBt91QXMUCV3ZJfkLF0PZaiM+sFS/ywHb5yoLmUODvSbSgtjteue6/WR1khTuLz/93oQCIFpbHfPvb8ZVlhO7c0ynkKOyUsmhJKIUIAsfFKjOhBYg==;5:10ieDkghKiUavkBynX0sTPg2KYV+okWGMoQqycipRs/I0s/WcwbduwrOO2avn/Udv3VT9nPT+bm00/miTqdjxv8iEaS/EtR9ol3rVOWbie9YrY6ajwfIzE8lC0mt96BmDjRHWnC/WKiYGUcH72pVCthhRyHcgHVLR3Uh5jgcqEY=;7:6pbY8vGCy8tEzLFJKxoJ1TmU4xYVi8UiaxRULzj/D8+GORC3VbdMcnXSWaPo5LQPJqMlzROvaQytaoQp5F+YU906GitduVnm8xrIfyvz//l3hwgnfzldl9+uG1D4K4YeMo8ryrAM+eq/zn5gDE0Prppv31hFQyCMcpT/E/mHn/ZswJesU2/rCCDMRJB2m1FhVJs4/XLrXsF33TEu/FOdr7hD8oxBy04wO4+UJ3JVNGFs4L2drinR0SR8B0s38VUe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2018 13:53:47.1216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5e8d31-563d-4455-8cee-08d601243106
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0301MB1217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

This fixes:
[BUG] gpio: gpio-adp5588: A possible sleep-in-atomic-context bug
                          in adp5588_gpio_write()
[BUG] gpio: gpio-adp5588: A possible sleep-in-atomic-context bug
                          in adp5588_gpio_direction_input()

Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/gpio/gpio-adp5588.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
index e717f8d..202d367 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -41,6 +41,8 @@ struct adp5588_gpio {
 	uint8_t int_en[3];
 	uint8_t irq_mask[3];
 	uint8_t irq_stat[3];
+	uint8_t int_input_en[3];
+	uint8_t int_lvl_cached[3];
 };
 
 static int adp5588_gpio_read(struct i2c_client *client, u8 reg)
@@ -173,12 +175,28 @@ static void adp5588_irq_bus_sync_unlock(struct irq_data *d)
 	struct adp5588_gpio *dev = irq_data_get_irq_chip_data(d);
 	int i;
 
-	for (i = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++)
+	for (i = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++) {
+		if (dev->int_input_en[i]) {
+			mutex_lock(&dev->lock);
+			dev->dir[i] &= ~dev->int_input_en[i];
+			dev->int_input_en[i] = 0;
+			adp5588_gpio_write(dev->client, GPIO_DIR1 + i,
+					   dev->dir[i]);
+			mutex_unlock(&dev->lock);
+		}
+
+		if (dev->int_lvl_cached[i] != dev->int_lvl[i]) {
+			dev->int_lvl_cached[i] = dev->int_lvl[i];
+			adp5588_gpio_write(dev->client, GPIO_INT_LVL1 + i,
+					   dev->int_lvl[i]);
+		}
+
 		if (dev->int_en[i] ^ dev->irq_mask[i]) {
 			dev->int_en[i] = dev->irq_mask[i];
 			adp5588_gpio_write(dev->client, GPIO_INT_EN1 + i,
 					   dev->int_en[i]);
 		}
+	}
 
 	mutex_unlock(&dev->irq_lock);
 }
@@ -221,9 +239,7 @@ static int adp5588_irq_set_type(struct irq_data *d, unsigned int type)
 	else
 		return -EINVAL;
 
-	adp5588_gpio_direction_input(&dev->gpio_chip, gpio);
-	adp5588_gpio_write(dev->client, GPIO_INT_LVL1 + bank,
-			   dev->int_lvl[bank]);
+	dev->int_input_en[bank] |= bit;
 
 	return 0;
 }
-- 
2.7.4

