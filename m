Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbeBBMyh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:54:37 -0500
Received: from mail-edgeka24.fraunhofer.de ([153.96.1.24]:43233 "EHLO
        mail-edgeKA24.fraunhofer.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751848AbeBBMya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:54:30 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GiAAAuXnRa/xoBYJldGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYNRZnAyg1uKJHSNOoICl0iCGAojhRgCGoIeVBgBAQEBAQEBAQI?=
 =?us-ascii?q?DaCiCa3gBAQEBAQEBAQFMAg1eAQUjEUUQAgEIGAICJgICAjAVEAIEAQ2KOQEQr?=
 =?us-ascii?q?zCCJ4QWAQGEXYF9AQEBAQEBAQEBAQEBAQEBAQEBAQEBGAWBD4NagQ6BB4FYhRW?=
 =?us-ascii?q?FOYMAgmUFil+JW49kBgKBHYZ6jVeCHoYlg2yIBY1qigeBPB86gVBxgxiDCYEyA?=
 =?us-ascii?q?TqMDoEXAQEB?=
X-IPAS-Result: =?us-ascii?q?A2GiAAAuXnRa/xoBYJldGQEBAQEBAQEBAQEBAQcBAQEBAYN?=
 =?us-ascii?q?RZnAyg1uKJHSNOoICl0iCGAojhRgCGoIeVBgBAQEBAQEBAQIDaCiCa3gBAQEBA?=
 =?us-ascii?q?QEBAQFMAg1eAQUjEUUQAgEIGAICJgICAjAVEAIEAQ2KOQEQrzCCJ4QWAQGEXYF?=
 =?us-ascii?q?9AQEBAQEBAQEBAQEBAQEBAQEBAQEBGAWBD4NagQ6BB4FYhRWFOYMAgmUFil+JW?=
 =?us-ascii?q?49kBgKBHYZ6jVeCHoYlg2yIBY1qigeBPB86gVBxgxiDCYEyATqMDoEXAQEB?=
X-IronPort-AV: E=Sophos;i="5.46,448,1511823600";
   d="scan'208";a="4684562"
X-IronPort-AV: E=Sophos;i="5.46,448,1511823600";
   d="scan'208";a="8930245"
From: "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aymen.sghaier@nxp.com" <aymen.sghaier@nxp.com>,
        "horia.geanta@nxp.com" <horia.geanta@nxp.com>,
        "pure.logic@nexus-software.ie" <pure.logic@nexus-software.ie>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ryan.harkin@linaro.org" <ryan.harkin@linaro.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "rui.silva@linaro.org" <rui.silva@linaro.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v3 2/5] crypto: caam: Fix endless loop when RNG is
 already initialized
Thread-Topic: [PATCH v3 2/5] crypto: caam: Fix endless loop when RNG is
 already initialized
Thread-Index: AQHTmjdPDFt5DoJeZkev9KNOEKfDKqOQ6pcAgAAaHIA=
Date: Fri, 2 Feb 2018 12:54:24 +0000
Message-ID: <1517576063.2002.19.camel@aisec.fraunhofer.de>
References: <1517364040-27607-1-git-send-email-pure.logic@nexus-software.ie>
         <1517364040-27607-3-git-send-email-pure.logic@nexus-software.ie>
         <VI1PR0402MB334297558BB1984131546B1D98FA0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
         <78ad6a62-190c-e4fe-dd23-e1d058f9bbb2@nexus-software.ie>
In-Reply-To: <78ad6a62-190c-e4fe-dd23-e1d058f9bbb2@nexus-software.ie>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.80.233.51]
x-tm-as-product-ver: SMEX-11.0.0.4179-8.200.1013-23636.006
x-tm-as-result: No--13.628400-8.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="utf-8"
Content-ID: <319A159D028DB7489AE7EEE5F58C047B@xch.fraunhofer.de>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w12Cse54020591

On Fri, 2018-02-02 at 11:20 +0000, Bryan O'Donoghue wrote:
> On 01/02/18 12:16, Horia Geantă wrote:
> > If the loop cannot exit based on value of "ret" != -EAGAIN, then it
> > means
> > caam_probe() will eventually fail due to ret == -EAGAIN:
> > 	if (ret) {
> > 		dev_err(dev, "failed to instantiate RNG");
> > 		goto caam_remove;
> > 	}
> 
> For me it's an endless loop applying the first two
> 
> https://patchwork.ozlabs.org/patch/866460/
> https://patchwork.ozlabs.org/patch/866462/
> 
> but not this one
> 
> https://patchwork.ozlabs.org/patch/865890/
> 
> > Please provide more details, so that the root cause is found and
> > fixed.
> 
> np
> 
> ---
> bod

I think the problem lies in the instantiate_rng() function. If the
driver is unable to acquire DEC0 it'll return -ENODEV. This should
terminate the while loop in the probe function. However, the return
value is never checked and is instead overwritten with -EAGAIN, causing
the endless loop.

This problem only occurs if u-boot instantiates only one of the state
handles (ent_delay doesn't get incremented) and the kernel runs in non-
secure mode (DEC0 can't get acquired). Instantiating all state handles
in u-boot therefore fixes this problem. In addition, the return value
in instantiate_rng() should be handled correctly by including

if (ret)
	break;

right after "ret = run_descriptor_deco0(ctrldev, desc, &status);".

Thanks,
Lukas
