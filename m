Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7CFEKjexGVuOWQAAmS7hNA
	; Thu, 07 Jun 2018 22:27:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8EED4606FA; Thu,  7 Jun 2018 22:27:03 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="PzzJOP1Q"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D38F8602FC;
	Thu,  7 Jun 2018 22:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D38F8602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeFGW1A (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 18:27:00 -0400
Received: from mail-he1eur01on0081.outbound.protection.outlook.com ([104.47.0.81]:5207
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752315AbeFGW06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 18:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y2d/JF4VqQn5Ea3rpgQ/gaR2drj08LV7m0M4cVA3oQ=;
 b=PzzJOP1Q/MW8SowRL0zK3mDnj4xboA01lWKYnnBRT5BNwaeKYOvm8ssP0rtgYz3p7+LoOZvZ9HbQ6/h391mrzabIWmYyfiEaRFOlQV37DuijWmfSESNewcSzOWQT5iIxwNcj4Fedz+bOW8I1sqBOfHxwi4beA9tCJWnRoPDYpyI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM6PR05MB4454.eurprd05.prod.outlook.com (2603:10a6:209:43::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Thu, 7 Jun 2018 22:26:53 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fR3Mk-0004z8-4n; Thu, 07 Jun 2018 16:26:46 -0600
Date: Thu, 7 Jun 2018 16:26:46 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] IB/mad: Use IDR instead of per-port list
Message-ID: <20180607222646.GX14597@mellanox.com>
References: <20180607190832.GA24370@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607190832.GA24370@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: CWLP265CA0191.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4d::35) To AM6PR05MB4454.eurprd05.prod.outlook.com
 (2603:10a6:209:43::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4454;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;3:+A/NkcO7eBJvqqJ2g+W0wIZ02IpAFcPOMXvZMcXTtVnbB+v92YvBICYQ+zVz1+d/hOVeX+W7CteJn5OO47i8NIyUcUsoUTJQ/jL3fENh4liHbWcegi/uC7uHQjwf8T48gGs1o/4HRZmX/mMl1p9vBCxJGMNHJmc/khjbWQhvKk0IyMXs/WYG/mo07vBq5yev7FqBMqW9P6cTjmBenle2V0xiMak7JhVmfBbwm3dMmaPRupwBlDHUBAhymo2MYVJQ;25:sG/Bcs9intRShyu6zharU8s8sjbr9HbmIfri17GxwY+bwCFi3KbM3cUpZ5UBsY4Uf9Jqp9XuzCBOUcbU1DKpo/6qTy4K7TAZ6OgocjNaBjSUUWbQCSScCLSE3gL+evxS3pipNHTxrTgxnjff9Ds39M0030L8LUKJKkJ5PHiEsQ6JTw5SYdHwL01rLL90ZMrc5JVwXucFCaJqZfnQhcSjlkEgeUkUr1nicV4mfN6rqkNxSI7GYoHgk7wYAHtUEjiOu9YUcqLVuB3dpx2WSfbeZ9bUQ285FnHmbe+8gGF3Yk8LRvXGggvGzEQEsyJ30Mc1AFgr80/fc/2xckK/5+cS8w==;31:Qj5XUlWQkWRfjgujMwVApqXg4jvK4As0WgRJZpgN86OsrHnGokaKJEgCcVr1P5ixy+5b37uK/+aSIKctjVqJ2iJoVLcyNvyESScQ12nAGeo5YAH4R0gx1tW1idhr9OFodNeQdjEMxzCxEtFXvIDcXu4qjZe7IDR83kemue2mz0G7FBq3mkiqWzOoOMYizeKEs9yfx2WlF8RXXclW7cgY9n75rKU2TBVZb6/2CSyvlbs=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4454:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;20:o4tz00F+oeErPUKIR2KildwCkrSkL/EhTtMtjWHrcNmILKbKnM2AStEQ8ilHhbKLcY8WUuleqPwckjVKt7Hz/ck2hDmn2o3VRk56JHovoTxQRwLy2HV6jvjHAnQknpnTGaJExI8aovjxfDux4iHDY0INk4Rlx9VGdNZF93Uvkn2+r86NWHPW+J0p4UmGpg9b3FTR5RSNi1+5Qs+xNgEjeaKVpoVqUv/6XPGExtT5ReLB69ZwPlWsAPbSkbVzhHArOlwbNnobE79raWOv6fSXerMoX7qjSCqvZN1yNvrVV0PHX47yk5ULDzxX9FzdJSsxbwijsunEsydIt8hawK+j26ZD53xNd6IBHi6c1ldfzQZcpZk1eDPDICAWGp+1pFo/QrDAcNA5szj/lB9V5saAtTIrwKLKqjqmgPzAl8Vop8cLuVVzcslBm/1YYdEnFgQp3KYkTz/4Irz8+3P/kgffejN+/Sm3RjEeFcODkrmdZ4znB7qjDzXp6Vd0Hbpbjbwk;4:96MGKBMkQBWzWuHVOEYT8g2inaVyA6niuC+/t+YJOUdBANuXsRScrQXhqJ9xg6isqS3X43yjdFP4ow0EhU4sj75UOFzVRHSTGcFcKzPaCiLWYAh7XBSjwPmXbWCSv1+tVu58QhGEdk2zqeIzW53JkTn8d4PeufPVETpdlzVJewfNVdMYBSqIHiNTDG3BP2TOU0YYwTsdRxSYspaAjhxifj/etVdDzJJ0AeafzlaPseDn8hdJDDWM5VMr5X1oF3pO61V7/40cYjiEoMMZxopNtfdyIWwTn8CC+JoDnJvbpi9cY6Ap5h4LpZBp+gA1ffdZ
X-Microsoft-Antispam-PRVS: <AM6PR05MB445496D68B6E3288FBF81FDECF640@AM6PR05MB4454.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM6PR05MB4454;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4454;
X-Forefront-PRVS: 06968FD8C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(396003)(346002)(39380400002)(199004)(189003)(97736004)(6246003)(39060400002)(3846002)(6116002)(1076002)(50466002)(23726003)(186003)(47776003)(46656002)(66066001)(2906002)(26005)(229853002)(53936002)(486006)(11346002)(105586002)(2616005)(476003)(446003)(106356001)(54906003)(36756003)(86362001)(4326008)(386003)(81166006)(81156014)(59450400001)(69596002)(7736002)(305945005)(57986006)(83796002)(52116002)(76176011)(16586007)(58126008)(8676002)(8936002)(122856001)(33656002)(478600001)(6916009)(9786002)(9746002)(5660300001)(316002)(68736007)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4454;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4454;23:4q9BdbOSvGJsYylJknKo/N4MAy5VS3LDjyjCLI1Tj?=
 =?us-ascii?Q?L0RGHke+cHJwNzNCXiranPjrVPMXbk4SIKq4EcFhXM4mko7ofzaMvtWHaLCX?=
 =?us-ascii?Q?00IYi3kFCpbgxjs3u98bPIfI3mc/7D/vIhrlFj0BFN3V1bdHDgj/9o0bTqH3?=
 =?us-ascii?Q?yRO1avCLGBKgKBoUXBh2DSb0uZeKPB/zK682OzIvBxrexXxalCIufWG6Z/+X?=
 =?us-ascii?Q?Sf03W46aDKkkp61tNfV0hp+kRh4y6GdGKQ5uwsxzLlPEL3RAFX5mS4QF4On4?=
 =?us-ascii?Q?DSNFr3qhzC87jHtbG/w4coX6mtCKBa95E99LLXaE79nQbgbh9L+Q0XsqpdMy?=
 =?us-ascii?Q?DsV6siyYKunhti35RsoLL7eSFC1w/mKg7DEm82JAvMTx5uSNOO/60WmI5TqX?=
 =?us-ascii?Q?9Toi/svfXaVzlg2D7XCLXA8WpqtmrAPDRagM+MZushFNuPWzC/4QoCI7jO/H?=
 =?us-ascii?Q?Dwiw55AO4xIoQRSXDI0ntHJuAfTu/BDXyixJsu8bGL58PMrRSA+8JVCEUjDJ?=
 =?us-ascii?Q?HayeoC2V0E4ZCvDoCVq0omZbDPN5+JHpN1NmEats4EOOD2gvF7HQYNpG9CTF?=
 =?us-ascii?Q?TVLwoCBF+rX+tnjqx1LSFduXXP4aYzEAVkdcrNjkCVLr1e/Rk1qqHCHCQF/n?=
 =?us-ascii?Q?k0VE9x+ig3NyXp2nkbCbd6SgOvwxXrMECLXVl46RO1oZi/361MGounHNHF++?=
 =?us-ascii?Q?H0RMHyRvsc34JD95Yz6wx31wBvFlP0ijf+5FJY1dxjkI7Onqzu1ZyrGvvQuN?=
 =?us-ascii?Q?NfyU1Trm0hHPLHCdgTIk6q/Fqexn9z5WxT4dmE7b2CxWjRN9j7jVU6sogqxg?=
 =?us-ascii?Q?rqkH5BVpQNw5CI0CmSRi4WYbqw8bX0ifiD3dUXuReWm4z7Id8xXupuVxR8Df?=
 =?us-ascii?Q?UJLz2se3qHsKSqYn9VefKMZWXRxQpQYK7XvDGT/3XrDJ6OtkgSN/TKnJ2vTp?=
 =?us-ascii?Q?OpXe6jMTq/boEDDobzfuoXpqNX9C+XcZ5MKPCi2bKKMYi68J93ObB4Zs3Fjs?=
 =?us-ascii?Q?P0iL+KxTSgjm23uk/FtcsR3ZH/xDUx6takJm2tOLb+jeYFgtpBpbEliLEXIK?=
 =?us-ascii?Q?7zlqVR77z5AeglJWecTY9mkw36xT2Z4PrEiEAUlJTHgpWkr3iygyGgFT6hEj?=
 =?us-ascii?Q?CP2P7jVcYPkpjA88LXFZ3jKz1sD+VGvgMWhnvNGzhp0LXfTwR4L13TmWCaZx?=
 =?us-ascii?Q?ccpDGOULyOM1pebn4yZxRSGxGcf0jo6bpLJG3ZliWxVk51MRG/ews0wqyOnU?=
 =?us-ascii?Q?T5S6kJALMFhc0RSDOA5DQbL/p9nxM6QX5felXpTRz51nbdAdJo9gfWJTGiyK?=
 =?us-ascii?Q?Klqgyeok5Y7imoeIu2GSw2bmx0krOygsIXI7Y5GWZWaeFq5PiCWazxtK7/yC?=
 =?us-ascii?Q?I+GAWgLbLOcpN/Zl4ZVoFjWU4htPQ0R/QunkNWR215q6P+V?=
X-Microsoft-Antispam-Message-Info: oc9vlj6NjMD4yHo8+iTqqE6atnpHwDZiyZIYIayl4oCdvEoDYIctGlcvDMGi4iKnTyCVXFSobj4EcVocjyjbWKbUbrn8CSNRdLAy26rdFsqCdL19/kZ/7wcHg1xEnJz78Uch8fde0p2mhX2O384MqYmNMQY/ZzDkbY1v9zI0hktWyWZWV5zw7cMgtacA60js
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;6:gpEltabTzrr4qEulDbTtCMr0yOd5lKGI9Bx+FDaLBf2LmCxhh8QVcg8nzI/ndVEi/BZeEm24LIUrN4bV+N5G2C9vxM77zyK8EDdF3Knglz/Kxvg1OEHohxYnHB+7KN6EwGCI4V8AbKt+42orDOu+c5JktHcswB3EfTc1Ozfr7iT2axVhe5TK26cA0hKrXfJwlwLhFY0jCtGC/p1AtAd8vd2JWHWICI4lm9OnOJAO/xVJ1I0zh+khNiEPkWXmdowkahimsQUEk07Qv6Ma1biJt7y0OSbYF1hiJqMU/JFSET9gBAI4flCCZS8UST/8kEnYMgbM2LYjIl2If4Bw7YQtiuY5S65dxs3qfXvRICKM1cs29buIMYPbw0puOLck9JE/bSISsv8jKUXLlAFIRiWyd38ZjkNn0tr8xDJCvP5nJSgvYpCRFGbeFrBVLdpSeuU6BMX/48wtPRUAKUWWC0A5+A==;5:5EwgrwAE3UAV4h0Q3pn1FuVXH+8t/WVRLSfeYicIKK9CNjaLC+a9CaTMwmJZynxLkpU6k3bHtPglJB4fHv0b06lQPe1wuUDDKDfeYhQKECOJ89DaCF2XWrWnVjywU4BjcPmYwkVM6pq0JgZagFk6YFNrRE+DJARipPrAEUd+Knw=;24:r2fPa8sVRjVJJ8TpqVtlVc+GqllMzw6OMsI2PXv69lIN0F2UsviWtxLMmD/aVLgQ3O7q99VSiXGWj0gKs3KUrQw0yneZF2CFJaUk+hgsODs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;7:AHiUUjBqK1Bo0Y59XGjyXudYDs/N/+WA5pyxuN/73rapgW4dAhdIHvRG40y/VXTVStUGkPkOHyHGLJlFYYCE6BpYEbcft1GYVkdTPMLnK96M3ZI9XCrorobXSsTafT1+FpyK/n4rlzLMox6wF5bJ+bRzu2ltqVXF5lmXo7pn3I26Yo+F0BRgIWUMjz/sta5kyaqhRy/7NOOHSDjTtN/c/CJcyquljVXjI+81I/0mPpkLZjA4BupOG/cpVDj/etPv
X-MS-Office365-Filtering-Correlation-Id: 5d9d9f48-bc2b-401c-c8c8-08d5ccc5c562
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 22:26:53.3311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9d9f48-bc2b-401c-c8c8-08d5ccc5c562
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 12:08:32PM -0700, Matthew Wilcox wrote:
> 
> Hans reports a bug where the mlx4 driver uses the MSB of the agent number
> to store slave number, meaning we can only use agent numbers up to 2^24.
> Fix this by using an IDR to assign the agent numbers and also look up the
> agent when a MSD packet is received.
> 
> I've changed the locking substantially, so this may well have a
> performance issue.  There are a few different possibilities for fixing
> that, including moving to an RCU-based lookup.

I do like this better than the last series..

This are is somewhat performance sensitive and it would be nice to
avoid this global lock.

What about using a read/write spinlock instead of the IDR internal
lock? Then all the per-port reading threads calling find_mad_agent can
run concurrently..

Thanks,
Jason
