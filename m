Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DA8C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154FD20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="KO5lBehl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154FD20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391190AbeGLCJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:09:55 -0400
Received: from mail-by2nam01on0067.outbound.protection.outlook.com ([104.47.34.67]:49680
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733093AbeGLCJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiOu0SCaW9HESN/R1hnBRIuid6gEG54pFY/xEFxb3VE=;
 b=KO5lBehl9sfVMR0O2xFlXIKcvwY1T1jxkwBnM0oR0iZH1xHH6nV2uhXhHc7RALN33yI6Vm9phXoHUq8McGGwRg0ZeQM1vK1nFqLO7tLzeek0KKNWVUwPNaWoXSJWoUVUWS7yP3wddOvk28gaHIiZ01UF7YaE00RbHrnIMqheuwc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2635.namprd03.prod.outlook.com (2603:10b6:3:43::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.22; Thu, 12 Jul 2018 02:00:49 +0000
Date:   Thu, 12 Jul 2018 09:58:14 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] serial: 8250: export serial8250_do_set_divisor()
Message-ID: <20180712095814.76b0f159@xhacker.debian>
In-Reply-To: <20180712095504.4d9583ce@xhacker.debian>
References: <20180712095504.4d9583ce@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: PR0P264CA0029.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::17) To DM5PR03MB2635.namprd03.prod.outlook.com
 (2603:10b6:3:43::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70cd8035-9366-436f-734e-08d5e79b4bfa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2635;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;3:9YkbC/UFSI+MADoKM6HdOOOfLMLCg6L7XAlNCG0Xp986aLSZ5ZXvzUjPIqIKPHnfoxvyDSsT3n03IbAmcdB9P+hAU+Yri5Xs4AONzL8je+PC3G9cNw053TTFH8K2kcXjSQBtSxOipVma8Q2mYf2oEQVgnp9pN1534nLnn2uel1SZg6F/aq3iK6MMWfZOI9OzMfv112Dz0QH1arLiGioTAX8muSYiZ9VUeoU938PeKvmJl35GA1Is8j6HZDnVwHDi;25:r8t4Uuv6BfqLhQGL3d5Npl0/1eKsb/Zpo0DHE8OHmmcvQPQv1zmviZTNsZRG82uRZpWoEy8S5Y9i3LG334fWNuZxZZckfm1jWrxJBYoidcB/UwSYP7LTn9FXKBHUmV7glTB3HyK2RDCJGj5NfOkZft21F+mS4DL4iVawNRuXfhqaNBJbx29RPOIFvz8dL0QqdmVrcT88nG5R0GS0gpkTIyf6Cc3BJeAon9LZtNvljyrUwOXeIuHKFUjDYbkn2Ys75+k7vMmxrx9av4oxFl1ak8t2WHYHli7/XgrcrXnIwvIDWm6V7t46+HpCqv4l2Wh12pVcAuzqBZbQVBODSYBe1w==;31:3ch2NHa0AFXwqgcKywvZDXqIaT6qfm1hST1HIVL795MN/Q/0kkX5s022bJqd0TuBH5fK0MMW2NNYiwkgVVGc+iw6zqHQ3WItpDUrIRUhZx9vYpFRP5G5Ok2tvf9DsR6cww3sfP4EwiCtvNRzsJDYTsFGeR53erHcb40zCvniu3pWA1N8s4lQDN4HZwXOyBLgSCKdFsJt1WMs+5cL/yXTsnAk23akFiatOP8qyzjpt/I=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2635:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;20:YDtXolG81A6DE2Sz2Pu7A+cNo+7xlQxzRoC64QBRP3J5GCDq6p93XEgTB/vp0ZB7OMnixJoJo3YDnS252MRA7h9y5ejAUSLT+srnder7Wt1ovSLwtcHk0XrZehVkpnkCyIPNzV3Y3y3DmZoNtv1Jw1HRTCkM9WSOQ0acYM6Oz76UtEGaZe1Jwef4at+7WHFKg0DvMz3y2CS3vHO0Ca/GYxxXUl3Rnpt5ziqqbjfza9XXaUS+oefJkNjODzFV77wMBNsav2Ij4RHqtLxT24auGEyoJwpBHzPKilMzgGmY4gGU3r6Otzty0hbZZUV8L3bfqMKYucrFqnghV+HTn/5HzFIZOrefaykxSaVslm8Rkm/LkUOO/hCgiwILKbNWE/Hg/uQL1oI0aULUeyDC2gDTOWw4LbnK9Ou8J2UDpHTy55blsCO/hdpPteuIpPPBJOWjPdtrPzPBZwKvzKrcaGo/s2q2trAbayXeEXije+JpWWpYFqPJiQiWJlXgzBhvqM/r;4:BNyn7colwrHtC+o6agd5Rb0qZWXSVNXz5gwcJGnLrWKe7FnDKPbQH6g7Vj329XLv1+oQxpYYVsMxz8HNqaluT26upMeyZVz17zSvLCHv2HhLDD1jXau96yNCBcIC96UvuUZasUvIXxC8y5vKUMV0enum8JDxa+kmGBPnfLpaoc1XVQ+yQfS0cHxvTl2Sqof2OCVyB19oilfwGP7duwtVR41l0tO1imQVgsKqgIuJL2bW/zVW66tt48T3S1vG0xAmy4uP1SNCWIRNQvM/vXH+w/6FFEWc0CeFEooXp5YmR/qfYG27L41oB3OvkQTZxy31
X-Microsoft-Antispam-PRVS: <DM5PR03MB2635C96E02E0B2146FB9A927ED590@DM5PR03MB2635.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2635;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2635;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(26005)(8676002)(6116002)(50466002)(8936002)(9686003)(7736002)(5660300001)(55016002)(305945005)(53936002)(66066001)(50226002)(2906002)(97736004)(81156014)(4326008)(47776003)(81166006)(23726003)(230700001)(72206003)(1076002)(11346002)(478600001)(105586002)(316002)(106356001)(3846002)(25786009)(7696005)(386003)(110136005)(6506007)(476003)(15760500003)(33896004)(186003)(16526019)(956004)(76176011)(486006)(6666003)(68736007)(86362001)(575784001)(446003)(52116002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2635;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2635;23:JdYDqbR4dT56Y9n8eKIKZJR1hoeuaVhgFIXv/PYaW?=
 =?us-ascii?Q?h5lVz8deEE+A6LX4msu5TehOwMG54Waw7mC6NfG7EClFyMQMZk7glNn0o1xL?=
 =?us-ascii?Q?RwFGQntqdVc/AJYM6g3EQ3VmAv+z/WKZAgIrHmBPzuJwVNk6iCOMAwtcjmuM?=
 =?us-ascii?Q?t9iYs8tbIpMu3RUdmDcZMaaSi+Hk3+9sCoCDY/2T2IVvZzjVdQxCzqRGd817?=
 =?us-ascii?Q?LXcK35+J8mmkQ3EALhGzjqrBjkaTpfnPWwYjAr8zzm87F4u/0IMm8rRR5NZF?=
 =?us-ascii?Q?fUDv4t/Y5tj8jXz1prkE+YiJRY2KOaSsXKQfC4NalmDZBy7cXTpKRgGyI8xL?=
 =?us-ascii?Q?4v4XilIm3tDUIZTD7aoBNlADmL1hotUVkkQA1NkdcQEYTmJhW5+Rp2VyqnJV?=
 =?us-ascii?Q?iGlBR6eBnp6dzEUGNo9RWfodHH+tmU5BrkQqGO8vqCgTASGmeiCD46PFxn5I?=
 =?us-ascii?Q?EFNKDa4DC2CHOiAwIQBBabqbNO7+wfbrHhGKmlRjHPLZrlQdocyLJilaU7jb?=
 =?us-ascii?Q?uVffCH33QnaDJY+bmBsADoGm4kUSt/FEDlCNjhcVS/0lAUdpsm7gCCSNQIqk?=
 =?us-ascii?Q?ysn7csfb5WAn0p/MoX+nLARUuTTBeQojcpkpRRNucr1dj0YbwPVDXzsdMcX0?=
 =?us-ascii?Q?XmfSBq++6kjwjw2LPto7LNMvp86bvaXALG8bopoPxYoR+P0zHIHJIYFtIHmk?=
 =?us-ascii?Q?c7L15TFlTy9cj6ZLxq2mhK2xJhUYrXNxE2RfrDmHGdmbCgF2DQw2sHxHtaJj?=
 =?us-ascii?Q?4uv3oMiW7rGzWJvp0SVN8eRAjc2gMbJE1jgAvnMzfCFcAAIgqR3z9vTND5Sb?=
 =?us-ascii?Q?/QbQ4Nf+uHuZYiz6XfcxfnZ8dHkdSk8KNxnL03PE5zeRzZPSa58MMb/BASGB?=
 =?us-ascii?Q?ULyt/aDOSoxMEoPBB5O2NTOnNRGYm5mFLwxeDJZ/ebjj5fXfIsJloq9TPx/b?=
 =?us-ascii?Q?EjtkKfD7NmrsH4eq8R9wcXdfyJuXEjIPYuYtdpZSyB2Lgp+KetewDyu6u2/w?=
 =?us-ascii?Q?Yb7sv6bIp8mWTfOakSBKjOrGvQNQR/LB5F71WE78VGoxaJpzCaTuxTdT/HoP?=
 =?us-ascii?Q?X5/YieGxvoBTHpXA4E9swLn2TxShvQf+66mQvcJzOJBcdMXtoTr2Pe9XEPeH?=
 =?us-ascii?Q?RdM03agTv+AU2+rm5d1/FBQ8As7AgSnFn7REbIzIdyv5pg48FX5bz5SsyUDT?=
 =?us-ascii?Q?P5rmhiogVN5x5tkAp8jmjYutOhhnXedMMG01xCt6D8ahTQaEP3gYRjrhJhw6?=
 =?us-ascii?Q?HdYTwBRHjtHGpKgipQieUNjHHROgvSkmMoiLoOt?=
X-Microsoft-Antispam-Message-Info: JTxrcEb4gcTnn3ia7zzV7gzD/DmDQSnjgP5by3DhHDt8AdUZTcWWMkKhZdezQCOvFmbCoAZiYMLT5Axcv4n6FnErF1vvOd2pn32U2ZkypOEvs+zZBAHo1PfPqNXRYPYHamUMH2hA5GfjYJdkRLUe5IaeQpuATOquNONYdBYXcYD38rIbfUYdamMvZqjfW7FdvXEJzXR2/7tK/FX+TCIFsIv/QStEvcHKdiR7k4+Xn1DNp2AJ02bzp6J0gTnSr2fINDDLn/TWe0ARk5agCohlEMujDeRjIJ+GhqDPsJCH3gGb7fDo4dpVwhpnaMBL4jI0N6PBEjP4z57OzLey1aKOboRP1yYJafWF/SOHgUv8iWE=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;6:13RGEj6Sb5rSuvAKNCKEfwbxs8Zs5Enn1rstyhUmo9SU1LsO5EOTNg/DFpaufv9XritEdEMU7OiVCuA56Czr/pPtfPWjNCeZ3JgSR6G/L+37bl+0z+E1rF0CBHjq99Vbwqe5Mv4SPi3Y94SMcweL1vIW42/pSvItaY0ZjB1mw2xQ7iAopDXSNnkW0QsliJEj+MP78fJAAu6//JuykktFCrji2CyX1laPoD2Egdvfw+OEcm1rRFu8Wh3ZXZuSWsQXkTLaBEq7rXoSFNeoTBe0jB21eHnQM+hc4R1AMIgO7qr305zZvQJ1JwlKXsC93XywumBKGjKo4eQu+EzidT773UeEZzCphYDmafZF5nsDG+TseJXQwi7/W1U1zux5R9m1e2qxWqT4uCTuEcaheeesG5XdyjuXoSFREBs/D7sTiyarTdqWFgkKo/I6j+vr1WO5QS1EN1wjtgQe+nnnompO9A==;5:jFCoYACaibwKTl12oeZNTtajexgMr+w1xrW7UcDxbMfAZnJ891PGwd6Ljixel0KxAivGEgDOSy5MjR7moOBEogXe1aJx5D81SdwVP08/wI6E+VCblPPA6q6SzC+l3ArO4bu+ggUhvwanfIFl9b3GL/PghsYCKHokxTll0ivQH/w=;24:xlMuv5nng+ZK+RLgIiVfVGItlCxEaBx1FmupEK81Q3Ly/JaBJhiBPuGxmOXtV/HepooW5cvgSiF35VcP/ApYNMRxcfSa54KFNcKXuKxvdD0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;7:Ocx3I2Q911JhCDxiHUrDZnny1xJ4ZPmws+PyD0GdB946jDuRoeEsbZIjlm1S0IGjCZjf0mOLpls9Y9WtA0hED8vZjz+Jr7chtxXJa9DsR01zrrwJ1GsQ+xm3Mb9TPEtpG7fHdBdavtGEVH6fZJRZ10RR+iJkXF+menYG4i0ZMaIgunsyCXsnilLzGQv5hifMEQpsnOIwekobCBdOqUshQpW7JD7XRoW0XEblGx7fL7zDyUaT8pzJQnOJcY4AGRiJ
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 02:00:49.7493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cd8035-9366-436f-734e-08d5e79b4bfa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2635
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers could call serial8250_do_set_divisor() to complete its
own set_divisor routine. Export this symbol for code reusing.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 5 +++--
 include/linux/serial_8250.h         | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ce0dc17f18ee..945f8dc2d50f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2580,8 +2580,8 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 	return cval;
 }
 
-static void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
-			    unsigned int quot, unsigned int quot_frac)
+void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
@@ -2612,6 +2612,7 @@ static void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 		serial_port_out(port, 0x2, quot_frac);
 	}
 }
+EXPORT_SYMBOL_GPL(serial8250_do_set_divisor);
 
 static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
 				   unsigned int quot, unsigned int quot_frac)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 76b9db71e489..18e21427bce4 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -160,6 +160,9 @@ extern void serial8250_do_shutdown(struct uart_port *port);
 extern void serial8250_do_pm(struct uart_port *port, unsigned int state,
 			     unsigned int oldstate);
 extern void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
+extern void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
+				      unsigned int quot,
+				      unsigned int quot_frac);
 extern int fsl8250_handle_irq(struct uart_port *port);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr);
-- 
2.18.0

