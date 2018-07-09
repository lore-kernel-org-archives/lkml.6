Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C20C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6576220882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Af3/C+JF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6576220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754496AbeGIIXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:23:40 -0400
Received: from mail-dm3nam03on0062.outbound.protection.outlook.com ([104.47.41.62]:24544
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751321AbeGIIXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+95Y1lLhZ6qJPcQGkBq3dcYguacv2UBAEL3/m5zUGr8=;
 b=Af3/C+JFgrvFbKgsqmclxdGUr2FPntFsmIxTXADaoW7Ykvf4zMlu8ibmuMLHIlz5QEjTOmlW3FlTUCNQUGn3QKivivZ+Zxg+q+yGdKGj9QJdZSKqn5iZSGtlBoWNom3PBd6c+Yz3A1maCK134WO2x2nKEgNo7Cmu4M4hQyR5nUU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY4PR03MB2632.namprd03.prod.outlook.com (2603:10b6:903:75::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Mon, 9 Jul 2018 08:23:32 +0000
Date:   Mon, 9 Jul 2018 16:21:38 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: serial: 8250: introduce get_divisor() and set_divisor() hook
Message-ID: <20180709162138.005c54ec@xhacker.debian>
In-Reply-To: <20180709161922.3c43f599@xhacker.debian>
References: <20180709160942.11a74f7a@xhacker.debian>
        <20180709161922.3c43f599@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0172.jpnprd01.prod.outlook.com (2603:1096:402::24)
 To CY4PR03MB2632.namprd03.prod.outlook.com (2603:10b6:903:75::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5c12a50-a169-4167-bac0-08d5e5754348
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2632;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;3:GjFh35qhtEm4FS4zGfQQbfgiU19IY+S1LokihGcybN9952JB01ort5TdsAdhptLqBbQmvwBX82ontfDt2rdTSmGd/0bhffHNx4pxQk/A3EY//gnHVqNE/d/AD61Y+91M1dAFjT5Xtc93uq/1QLfqF7bHY0zAj/oIeyiutqEDlDtVGH5hbgRVnMPYf7GX14jqN5sos8OFyvlMfxqMaxDqC5htMAY+6YTuauEr06/lyKbBZ6aGiXID/VLRlLrM894e;25:tgyANK04hKAelW92E+vHD1Lk2vohkXmoO/BGkPz5ESXsHoU6JpBoYRptIKP7yhPpWwSGMxyUTSAryG33YdZW7pMrRua0RRiDoBSMdb7c2tAMmqx7nYw6hehv9I0iDrnk1y3XwXam1vcUXQXnRgTcJ+8vZ6zl7DnqUPbbFddLAc0oJ5OKtcIEp3dw36TG7kxUpfEItqAAoZiKkTzFeE9EoQiY8L/fsuE8C4+eALrTHY5HWkegxQBi8iaugFqFoamXE9COfEU7TbNWgZRZ09+n2J2xKP8szJv1Ki/7cQZDdXXO+AVUC6UTIY6zXxd2v6nNgvLgz1mSFUdMVCFgA4urlw==;31:2xbb0KBnM/+9/6w9wjYxGPnDCRm78CgHuw9NjfT12hufqeNLeccbQrANpmyIK38GHAWuN7x5esfVpTWMjknQlBHX0o9qBA/9RhPRKu2xOzaZA9VLCykDJ13cXIje3xThaneNrHJdIOc4CjZjlO5X4cpsbJpkBCVd8pTa/914Q2scl0erIZ7eByFbnlayvO1ySusrazkBi8uKAva0Cku7+tmxeLxPCb8L0op9grG70Sg=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2632:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;20:QtkJpWoSmybtALRsWeSAlfMyAUqeWjDNG74m8+velOgw2tXsMP072DeJQznHUIC9xw03GYatmwkdrnXrPHyDk0zElymkir4xuR3SArl0kU3rfRqYNcYQoapsXenqGwABY9VCoLoImLPBALrGCsJtmwZb9By3cjfxqhBQyGYXPyjXxXeNsJWraGgUu81N3F4wQU5fRaqgCiM9ezqJ/lMeW5qK4Wv1rWLFWd6aEmMH/XKg3/D33jLCwbzjNd1cwnhRZ+p6WAtjpghEKynWrqoyoG2f7T2v/oFlc/jwU3tni4DqcouDy82qZGAnwd0uYsh1dtz4LeN2yfNhADifGPUViESpw4bSaqN4JUK87cwYTR14nDIhPxNdQ5ZKYVq24rFl0fmkMRtXUhSjk12JDgsR7rAY83R8+lTAxUkRRrCbbuGb8kNgjfO6HPcZUwl8mnktR6RzwTO6c6jqY3nlJ9u0hQVpQ4JnReEBag7c9hn+a7rtRaHRAqVeiVHDGmtnZwSQ;4:FQOMPQIXAOmE/D404c3gT1tEPRmoZ6Ro5qgLBZzFyihSKNSGT+DGGS9Hnj5y7j+VqWX2lAuBwE4bHI3C3AdCCADcfuN8EdmeagrxphxHZU4Qbq6fmo1uo0MeWMvCLwpxzLJy9bYkhGrNcu10e2xdVtrMKrMT62HV1vSZXVF1ER5V0bq1/oKcQP/aLOol4ULDXNC1t3sphd3S1cQHxLdrQK/mrdTBaLVTMNOe6+3AYu9QE0nwrpHg+IsqjVe63eDkqZ0OUvuB8BAU88+YUMh4KvEWLY5w2kWMRke/d9wwItKSwcfChaG3Iu6rdJM+nELr
X-Microsoft-Antispam-PRVS: <CY4PR03MB26327BDAF8977C6DF178F9FCED440@CY4PR03MB2632.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB2632;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2632;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(486006)(11346002)(55016002)(446003)(956004)(476003)(25786009)(2906002)(9686003)(66066001)(7736002)(305945005)(47776003)(8676002)(81156014)(50226002)(5660300001)(575784001)(72206003)(478600001)(86362001)(68736007)(8936002)(106356001)(105586002)(4326008)(81166006)(76176011)(53936002)(316002)(33896004)(7696005)(52116002)(1076002)(6246003)(97736004)(6506007)(386003)(229853002)(54906003)(110136005)(23726003)(230700001)(186003)(26005)(16526019)(3846002)(6116002)(50466002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2632;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2632;23:SZppgbpeQ5C6FxHW9QtguoG3QBuunfeZM5ZavLMga?=
 =?us-ascii?Q?rwXvqGVPJywr617FegbDkpUlzC99JGbK9owU6j+0Sd30QlSoVG78xH6tc1aC?=
 =?us-ascii?Q?uFXIHtNj0Tz+/BVEtNZ0w/pUIF+JG/e6yd4wmu7iLb7mD7XpryPRl0TYwuNE?=
 =?us-ascii?Q?Y+Yr85om1zIoJqtmBj1YJ77nb3LJponJcYSBMnEsa6+neOaQi8UJ1bTlDWHL?=
 =?us-ascii?Q?IoL+p5UsgNZP6njI8jkc0G6BjZ6GhZXSP/pNWgHuJzjto30WqsBc+DHWwDer?=
 =?us-ascii?Q?vs8O9LIQCr8Jzkb/3skJ+1WqzWJBRCWDJsEqa0IFxc/NrKXF6wieyvETnb0h?=
 =?us-ascii?Q?NESmdTcZbOcVWh0kgH8xK0Fm6MQA4ZAGhS4tuCSY4No2SHDLax5uGN+uSvFP?=
 =?us-ascii?Q?LlwD3Yz+k5T22f3lLvOQqRCCAqdda8NZt5Qdh+UboejOLR2EsmgwaTmAnRzV?=
 =?us-ascii?Q?y61kZ3X5/lwXphyKyGmoYFtB92Yv6GJ04UG6Q0FjNvz9kI/mUGW5gWa9hrQJ?=
 =?us-ascii?Q?6/oBGP0gxlX6N0N+Qv+1UEgJoayRTQcxD8PCPQZBGeo8FKxpX/s9mnYssts4?=
 =?us-ascii?Q?1smZ70tDGgK7200QPPla0rRu6iR3LskJfNiz39VEs9N76Trdi/J0ORCkd51c?=
 =?us-ascii?Q?K20tKsu/JrINGu96xI5SEqJu5kpqjYHS3Lieukr0OLqEn19Vk1ZVH338qS+t?=
 =?us-ascii?Q?Yr/0avjZGY6zG1mbM3teHERinYOmeHKDwnVzRNSEteErN4L/A0UStTgqXd0G?=
 =?us-ascii?Q?58VuGdGISIrReHShqkI0X5G+xDRtGKh8gEuU4yy9lryvkC+W1YxrAeYgNu3g?=
 =?us-ascii?Q?QG3OwsPk1QO251i1qH228Zjg9rRzxsIJU/zHrUwhDq+CsgIU1AhxC0dtIqNk?=
 =?us-ascii?Q?gg2WfPZCc14mCrU6th+plyJqBf6Ia4sSz3DRirZl4eBiAJqkVeNv16CF1Gz3?=
 =?us-ascii?Q?FX//rtIDI1IlnLrUsZWEtwhryoy2WXW4iw/LR6RzZtMbqARLuEpzn8PMEY+6?=
 =?us-ascii?Q?ANxQpjYQ/kslS5i1Orb+8FZRDc7vY6+FNTJsi+dEpFGBLB8WBSSoYgnOHjjk?=
 =?us-ascii?Q?x63dIpfMHcyW6WwiAwqibJqkJMtTs+EEjpI4NgBv02xLP7opjC6fo+GBoB8W?=
 =?us-ascii?Q?V7iSF9t730p4T7BGkARpDT0gjQCYpnMi11CndepWIWRcsNIXy7R1YedePWvq?=
 =?us-ascii?Q?EOAHVgmSNK4PgT/5mwtI9myXYKGANZoJNLgpfz1jRLSkHxNnagDVzptjDzXV?=
 =?us-ascii?Q?x0RExbKeGDYnYnaMwQ+DPGNxigfoCJOdLn06RquiSvb6ksWHlztBZBC+fnK3?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: b/8v7o9lyBPYYP1WyIC8xb0Wm5wtWh3STykGav43BGINJgRkQl20XIKjKVdXZ5lCcl0P4rJrst8FfxwuRPR/R+Z9JN3hqaD4jmiP7FevccmsDqLz1+BErDbUdCY07euuaZwKJ7w65yT0tpD7Gi9kdQ3eKmoQKRBavBVPjH/y5492npbAXF2KaFLx+r04IhpeWmKBpK/JEsS+gjis9uNO3nQKWSKNCqDqwq+h1Bh4cJ6S4qwhQAxRLkZEbdhs30tpoLiXqSIp+8Bm8qMnStIXzrvOaM7hJBK0jrAP71bbpCL6SLeogmKDKw01vjAWbNts6WXoLuu3nNR4peLBeYkAA0AmEA2AX1I8eBrLvJDn7Eg=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;6:cwUC4jxTPnd76Qx8kWy0EIFjJlpU6CyLjJHq9LhJhTsyHbk3gD0mV7YQj5JHF97DU78j1sWW2z14v2okoBwd9MZbHjn0QvnodJm/tgZzJ5LssM30XgbtoydbzWKBJWYVdSH2jYrxAQUgepoRRzgGbcIrUFUOOIclV32YHAnBFO/GE8KElimXnlHRtgy4UAO+BlSXoNNVPFxlwjx7liwKM+yPLm+oRGmtAbY02ruHgyb/nuz4+S3orVLFT9vqJ+wHkmn5Af2i97sjPwHB7L0h/PN8XOkOstGf6aKgNOd4wQ5taxIB1T/CVBqrqb2EUlJaSl3G3sIx638CrTFedsXC6mPgreQuIv/PuUHh0MKH9ssSfDJOoLs6atwu00ePCqLJpLev5q4ahr4t+7HSwl5aITUtyOlK2M1GMdJLt/M/JEpU97pNNxql8apC7rni9tYXqo7MZtbSozlgjb2z8km+Kg==;5:ZTKZ+rP3o3y66gvziOFxpZmtd3zuaFLL9sTni8XEE29EW31FpOHoPOEfaxx+CiK5KoXvJPxoYfKLJ6rjlyNi+Fil7B/aYji/WzK+t3R5XRPV+I5WcwDAzSAfxHWYGbkFioXd3RDPSaR0dgVRSN5yD+euqQ4jNLqHnOBp6V6lh5Y=;24:bEVEMr23j8qsv968rJJiihX1QIlvI3x/5eF6e1XRpACZbgd18x0gLNkNUVVhe2oXkH3YilFWTKSJc5qYPc2OWFjCmHHXbVJeVtQ5SqdgxMs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;7:sFIi0a9QbtFd9cbr9nh1whPgXnBD38CkbGSW4LcD2PpCptyLVg/2b32/II644ZAqnFGPxheGoaAM/NW3743gzUzKvdqjCkc7++yiSTJ1ocuth4UwZYYuMNzkz03DY57+eetN8FT+PlZPSx1TOGAQv7yijxRbsUKukoM0/N/W7tcXiw8g8o/bTo2BJMUm0aP6bdZoDdFR6DZGEkK/14ZiY+dQF3MMMYmy3ggFxZCIEsGGYyhNbj4Ul2EQ/CJORlL/
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:23:32.9243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c12a50-a169-4167-bac0-08d5e5754348
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oops, sorry, please ignore this patch.

On Mon, 9 Jul 2018 16:19:22 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> Add these two hooks so that they can be overridden with driver specific
> implementations.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_core.c |  4 ++++
>  drivers/tty/serial/8250/8250_port.c | 27 +++++++++++++++++++++++----
>  include/linux/serial_core.h         |  7 +++++++
>  3 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 9342fc2ee7df..a0bb77290747 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1023,6 +1023,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>  			uart->port.get_mctrl = up->port.get_mctrl;
>  		if (up->port.set_mctrl)
>  			uart->port.set_mctrl = up->port.set_mctrl;
> +		if (up->port.get_divisor)
> +			uart->port.get_divisor = up->port.get_divisor;
> +		if (up->port.set_divisor)
> +			uart->port.set_divisor = up->port.set_divisor;
>  		if (up->port.startup)
>  			uart->port.startup = up->port.startup;
>  		if (up->port.shutdown)
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 709fe6b4265c..ce0dc17f18ee 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2498,9 +2498,9 @@ static unsigned int npcm_get_divisor(struct uart_8250_port *up,
>  	return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
>  }
>  
> -static unsigned int serial8250_get_divisor(struct uart_port *port,
> -					   unsigned int baud,
> -					   unsigned int *frac)
> +static unsigned int serial8250_do_get_divisor(struct uart_port *port,
> +					      unsigned int baud,
> +					      unsigned int *frac)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  	unsigned int quot;
> @@ -2532,6 +2532,16 @@ static unsigned int serial8250_get_divisor(struct uart_port *port,
>  	return quot;
>  }
>  
> +static unsigned int serial8250_get_divisor(struct uart_port *port,
> +					   unsigned int baud,
> +					   unsigned int *frac)
> +{
> +	if (port->get_divisor)
> +		return port->get_divisor(port, baud, frac);
> +
> +	return serial8250_do_get_divisor(port, baud, frac);
> +}
> +
>  static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
>  					    tcflag_t c_cflag)
>  {
> @@ -2570,7 +2580,7 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
>  	return cval;
>  }
>  
> -static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
> +static void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
>  			    unsigned int quot, unsigned int quot_frac)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
> @@ -2603,6 +2613,15 @@ static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
>  	}
>  }
>  
> +static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
> +				   unsigned int quot, unsigned int quot_frac)
> +{
> +	if (port->set_divisor)
> +		port->set_divisor(port, baud, quot, quot_frac);
> +	else
> +		serial8250_do_set_divisor(port, baud, quot, quot_frac);
> +}
> +
>  static unsigned int serial8250_get_baud_rate(struct uart_port *port,
>  					     struct ktermios *termios,
>  					     struct ktermios *old)
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 06ea4eeb09ab..406edae44ca3 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -127,6 +127,13 @@ struct uart_port {
>  					     struct ktermios *);
>  	unsigned int		(*get_mctrl)(struct uart_port *);
>  	void			(*set_mctrl)(struct uart_port *, unsigned int);
> +	unsigned int		(*get_divisor)(struct uart_port *,
> +					       unsigned int baud,
> +					       unsigned int *frac);
> +	void			(*set_divisor)(struct uart_port *,
> +					       unsigned int baud,
> +					       unsigned int quot,
> +					       unsigned int quot_frac);
>  	int			(*startup)(struct uart_port *port);
>  	void			(*shutdown)(struct uart_port *port);
>  	void			(*throttle)(struct uart_port *port);

