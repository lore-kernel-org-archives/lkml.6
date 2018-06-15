Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67865C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F020F208DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="mZAT1Rew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F020F208DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756613AbeFOVms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:42:48 -0400
Received: from mail-cys01nam02on0077.outbound.protection.outlook.com ([104.47.37.77]:5233
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753487AbeFOVmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEJoMUwN6+g/2tJV3r6fGLJRIlKX1io1o0NQejjMct0=;
 b=mZAT1RewtLUrnPgsD0rtpenq3t5kvW7RGRF7bkj91PSooMjk47fKYvdaOS9umc5XI6bZl/aG+rr9WMitg66y/ttmPbUMIXoQRW3v05VAw44PRrmjeWCsm6gH7uNugt0UPEbrRaqNYa6ol5+JX8v9+/CjBKOLQzTxes6jQX25TbQ=
Received: from localhost (88.247.2.85) by
 DM6PR07MB4380.namprd07.prod.outlook.com (2603:10b6:5:bf::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 21:42:41 +0000
Date:   Sat, 16 Jun 2018 00:42:31 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2 5/5] Input: evdev - Switch to bitmap_zalloc()
Message-ID: <20180615214231.GA371@yury-thinkpad>
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
 <20180615132017.23889-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615132017.23889-6-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [88.247.2.85]
X-ClientProxiedBy: AM0PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::16) To DM6PR07MB4380.namprd07.prod.outlook.com
 (2603:10b6:5:bf::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33b264af-344f-46c7-e69b-08d5d308ec6d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4380;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4380;3:MmGkNlkdcFxlaog5wd6BClT5exJYUtNmRcQViyVL3qVb2S7Zzsh8GlJi9U8TAYgslQy8thBsdvKzG8WXXecXMVh0ApJfLTkrW+8PEPLxfyf3UKvnM1Hi+SUOnQuLwPLxEYjIdagbJ7WDB9yA84ywPBHKFQNNkbil8j7fBRPjA4pAb0h8CJct0jidAYIKLqW2EffIumVKk3OL6GRVYREl1wQiCJRl/W7MrcgLtmWU2VpyK27uPZtXcEUphBjOeDfD;25:KXyVNhk+duF+OK3+SDcvTIahGKsAoZ6Xks7qmxjGtXEMcV8PDUQlH8V3X0SiDvaPGNaplPfAIGcj6yLzanDEffsxfqP9AHJ+gg3WxFjgG2Jl7UXS4x4kmSOyC5V4JexFMezH7XR2spiTPWKwv/vk0WEXEwMqbK46wpdTHspjkcThwzLR+a3MyIl+0Tr3Hp47KUuRWzi4Ap0X6xPqIhqeZKjZfb9yI9PEOFeC8tMGrrLR27T+6z1cLORlEI9IzjczMZt/v3rdALIgal2ePzZ7Q8IfBnwcig1BuztZJPvVkwN1g3+525ycYTshv9dnadPtfzeiA4HXPqzkRR1sqta/OQ==;31:zi0PCIifieaXp1EMkyakSfrn3yI3AFSVLCU99YJ0F/9rTnpT2wmOCVGerZm2uDa+QJHpW+83vnoNrYjkWUKw4IOeDxXd0+izmg/nK/04K/Qv6g04RyfjXg+8Ww+8xwSVCWE1VM3Z/SAwee24Q3sXSyq1BuQqWImupPtMx0OhMtEpBuevvhDr6pEWtCYb4S8aIPuOQHxlakpKTuwiRFLgU3zkENgwcWreHEI5IxBz1EM=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4380:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4380;20:GxzwoBg3+bwy23IaFw95rn9lA3Lz52hlU07WdeBZqcrXp8/7VMd4zqwCgZFZ4mIYLo1GllKBOBS3RFI7G1Z7k5+OjUTP6uyZss5hlmq6mq+Kz89UlujTnC5283cVIf0VUEq6SQuJBzg86Pr7TAwM8TCrezkvKWzsaVPyxegOyMfFPue699xWr94aE0uwFtdnNV3j83JXGpXhyFmUQ01Q3wRaEGqdT7EIORAiqJ0SungvZIEG8WaESIBgd8EFpqp/wc9oYeRfBfR4YKfBuHYlkYt/r7nfjlPUoKCIHBpiLOZMzvefTf2CDtk81GCthCagTFW/1PScMSZ1UU4lZiiYotUsZkSU2UjraDD4cA0YxprdSSWbVTMoVA3LxJu7efolpD0r5BYpDLWlTWFYVM1TYVgjg6xt51ALw4JHwF2/g69xdd5ZDsBt+v4rG5QuJ1IwD8v+SvCqylX28QlXvvdi8pzVaKslqr7/L7A2cbeA8Cuml7/2UTW6SPtBDCpWVVwVYgD1MwGQ1kGiAWpD0PwFUL1akxANFIUHqmy25qD+Jgf7xGuz7Yw9XrZgj0FDT3xfN3PGDKLcNOi1qJw/t6MVOjgSw1FeMPq+NbCvA8OKxWg=
X-Microsoft-Antispam-PRVS: <DM6PR07MB43804A5BC35206531E2FFA24E37C0@DM6PR07MB4380.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4380;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4380;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4380;4:kEAYxoa+DkL4QN73o/ygB1subJRmMwu+nFFwqhbCR1nwR6ul78tflYmW9zFagGXLzDrA80YQN/FqHL/l+OXGFfUCfZEG4RYHDsN6vV3y9u3OrUSTgvf1OTx0hd9VjU44s/Og1IWed6aqIxhsZX8vG4MPSXNc8F2Eq15pOSSvuOPYogR6q2Y0E7BJz6bdPsKZ0MdH8J5hOwZKxs5FFNNr/JTa9+mddxh/qd22bkaUMWwWOMsGzvcK+u6CXLmFx/pdKTqNfTk6InFYMyBbFTeDU6073uVcRg1FvORtDcLouNfJgdhARhZySR3wAl8aBlcL3mghzseNgHedyS7Kwxc87Hfrz79UKo91HlpGqOZT0vU=
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6069001)(7916004)(366004)(346002)(39380400002)(396003)(39850400004)(376002)(189003)(199004)(76176011)(54906003)(66066001)(16586007)(33656002)(55236004)(33716001)(58126008)(6246003)(53936002)(6666003)(186003)(2906002)(16526019)(68736007)(50466002)(9686003)(229853002)(26005)(6486002)(76506005)(1076002)(6116002)(25786009)(33896004)(23726003)(3846002)(4326008)(39060400002)(386003)(47776003)(106356001)(6496006)(316002)(105586002)(5660300001)(6916009)(7736002)(72206003)(52116002)(97736004)(8676002)(81156014)(81166006)(486006)(8936002)(305945005)(446003)(478600001)(476003)(11346002)(956004)(42882007)(7416002)(59450400001)(18370500001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4380;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4380;23:WLezg+k1PE4Sws5vJyTWlXYv5SeGjV62eX/VSvfS8?=
 =?us-ascii?Q?o/7ztWuEJFvAn0h6cm13gVRGVUGAE56R0Egj+KrUUPv/IG67z8ehFW7ZF4SA?=
 =?us-ascii?Q?PECJ03EFg0ObyskzC5unjCnlBKn+HqkjdwxIAbTxIlIMWdCiIRSurc2rhv6h?=
 =?us-ascii?Q?4cQxzXwnrQtYDmcQEDFtJmdg6vT4wUVfkxSIMRxz5ew6YAX+NTa7Rwe9dQBo?=
 =?us-ascii?Q?DUKpMGrOhf4qpZJJ7iHMu4wd8PF4A8FhTI+leLFki9FnahtqjMYxdhzNiYzo?=
 =?us-ascii?Q?baSc5Nfcw6OY2ES5fOA+ttZCXgYTFdiA+oOaOE9YhmzGM0hGH6nXnat/nWDr?=
 =?us-ascii?Q?h+m4fAxZiYzR1v1L+rdSy+Uyf+BJwV/XjBM29pUCrvwbz3kDqsr4peOUZhWs?=
 =?us-ascii?Q?a/F4zrBdcookB6IYy/T7XK/XhHkUHAzttqV/3kvQHDdpxg+cJtI5ZYwh7Rqj?=
 =?us-ascii?Q?pwZcdroEONLeB0YGxE2JnG+OoFIs/yn7p5cxpmCMhS9nDpDTxrqumCcxlgyn?=
 =?us-ascii?Q?gZB9CKS5XMUjFwtvt0OSwCLZJHLmrzppEl1l8j6Dc1RvC/kMPGghRXdvLfoQ?=
 =?us-ascii?Q?4RssBEXe5UbCMfogIqlg1CuZ/Zwavcee9WhAjuDs3/Xj/7IpVY7Ee7QxBAb1?=
 =?us-ascii?Q?A7Z8bsnQVstdKIiUYWGvxH+Xc810ddn9BAlp5aI2NEMnq3wRZiwt9a3XQBBX?=
 =?us-ascii?Q?dirklNwqN7bmPB1xbTEceuwhO+CRoCzfEzIFlTUUZ4TRLakWxmlRBaYZ4Z+l?=
 =?us-ascii?Q?rNg2Q+SORPUdQoauCei7AHNsAVycvoao4VAsFdpJzXK7BZznIKO/MkUWTawQ?=
 =?us-ascii?Q?QCP614YEO2dJO+1glxpYP071nE5Tql3GYNAifqNGumtAwqqIIJce1czqJQwe?=
 =?us-ascii?Q?7XuEsSOmOuzwUqox75OLq0d+r6aWYWPisEzPER63kFjTaM5CjaV1+5SO/OiR?=
 =?us-ascii?Q?gY30e9TXu7ZEuJRYwMZf58t1y3zq+Xta7fTJacW8GMBiR+5Aiy/lI/e1Nabj?=
 =?us-ascii?Q?KjR/X776GamAOCJTCzvzNOHwp3FgDQNmDsM7mx9cMBBvxBsfnN/9j9ya6BI/?=
 =?us-ascii?Q?gr1776rD0pSTLG3diXTiWW1SsVO3yjbujeBtIUCNPsI481Imi11vujmruR8Y?=
 =?us-ascii?Q?IpytJecFq+OJQ0eIyWG3hk+z+ynO9kQDHfTTXPL8x6Y5Zn5FgU7B5XZfoPiQ?=
 =?us-ascii?Q?hJ60iDj9FzzXv3Aw/eOobUZP19cVs1Om+thoWj4x7q5aqygK997w7NqwzWxc?=
 =?us-ascii?Q?ufqG9hLVNv6i+eYwnl2YrGy5I1Bq+OPaqhffTTSE0TNagCBEzDMlYOX0/FOO?=
 =?us-ascii?Q?dU+RGzKhVo8Y99IckRYKemQTJU/Dn2Ze37l0xZKiT4ofRmBZBtrisCb90/Gd?=
 =?us-ascii?Q?kwngNnyBd3yL+XrqEvC1/x++8H4ksEgsQD97GbVH6hFAFSFhzGaHCsQ8ZKUU?=
 =?us-ascii?Q?I1Xp9HDjz4kCg7wmtn7mwZ+Q63O0id+iC8sSC+umIvTRFyktor/+8WukQNJk?=
 =?us-ascii?Q?vbDnwreLOQ4OsurRpzUK2AhFBWlPL0S3XY2ydzlUP5esip0uYatadDFdH6Az?=
 =?us-ascii?Q?IQuSiW0pNZYicwPvQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: ZC68UXaNTvX7e5bzAQxW3p6fri86XkVyqTQoX8pinPnR7x7Wy/ErXCU4qxGz7Lo/jvBJ/1nw9cEZxh10bCHvz/Ap3GSfMKeguliSJyoRL5XnXiLzl4Lvdsf/sS+9Ey5WdmrhUQyj7jwW/ZFKyLF44VYH3AHOpH+OrCz3Ii0PJtOm/eyR98e3zGsbeuceGHEr
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4380;6:h7phhsPmus2BBWbyi1HSMaORfGlWHr0h6sX9H1f6+vfX3IM/y5Ukw/Lyo/nr35oHWDhmqJAiXZQ41Jld1B43SoRpQtyQD2MUCfzgvMtrxzmkHNslOha4A6rhzGSNIYxr+vLpFy8wNj1HXPgbE1KLQckN/I1LTO9kNE48Aka1zMhYbCSx2+B58+ZUqM0MhxqucldANHBDZQRU1q3pAYeMVb1zGJ5X4O1GQumEGAImxrr21UvGeJH5pLM/1VUjrICbJzxf8DDSj5vGmpJ4ZXNBIFAgpz/OjznBsBzaEibjx/n+OFRL68C8ld8bm4YH0CKbaSXIb1EBYSsdjdUJuGP2c69RkKBEDJA9E+IzJWD173g6r14vpdU/Shr5uOiXg6PrK6O3wQXs26cNKnrcv476uMzk2lfcthu/7A81GUozGVKppzFANq4fK2SGUdHCWXn3gGtDYFWgHsUqUxjK0PxQyg==;5:vRvQDjKvKmOW6tMj17DHi4skDHb3k15GxuehHC0LiK03BY1Jpkc51DtxGOdqA4dKhn+ASD+MHB/+vkUv7cYlSayGVEELNgThpMwXe/SDiawUqn35hPWA3Z9Bo/laRekkOMBOcf7UdPVMKZ4RkciX4CJ//l5yUmhesTFVqfdHRus=;24:4AVEXTThpXnUiT1zut1sAFaG55Xwjo09suG3nuLbssfgkpHzSu0Qdnh3ukJPFdQu2fXOG86dDM795Bkuckir7z3JYeT3M0P0G/CxVUb0Ftc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4380;7:IHglCa21GOwy6Zyafc01UFLesDEI4ZE0ajtflzv0hD2DGx47ObZbvsGwKSqtvBOIhe1FS1aPUDIat0bp/GIJHZJCKBhnrAj/6GwFzCBn3jyO3Ln5Vj8V+FNQGpoAVJHIqSjgpDKe4xUGpY4Kiu0bT9L5S/O9c2KIB20SmXgzcMP2Nyh6IuinsNQsKG7FVSuylTnfiHXOUTylPHLhURuGrQZRDqB3/giuemVqIIGvGTeQA/sNff1gYqoMGqBwRy0A
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 21:42:41.8064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b264af-344f-46c7-e69b-08d5d308ec6d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4380
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Jun 15, 2018 at 04:20:17PM +0300, Andy Shevchenko wrote:
> Switch to bitmap_zalloc() to show clearly what we are allocating.
> Besides that it returns pointer of bitmap type instead of opaque void *.
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/input/evdev.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index c81c79d01d93..370206f987f9 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -481,7 +481,7 @@ static int evdev_release(struct inode *inode, struct file *file)
>         evdev_detach_client(evdev, client);
> 
>         for (i = 0; i < EV_CNT; ++i)
> -               kfree(client->evmasks[i]);
> +               bitmap_free(client->evmasks[i]);
> 
>         kvfree(client);
> 
> @@ -925,17 +925,15 @@ static int evdev_handle_get_val(struct evdev_client *client,
>  {
>         int ret;
>         unsigned long *mem;
> -       size_t len;
> 
> -       len = BITS_TO_LONGS(maxbit) * sizeof(unsigned long);
> -       mem = kmalloc(len, GFP_KERNEL);
> +       mem = bitmap_alloc(maxbit, GFP_KERNEL);
>         if (!mem)
>                 return -ENOMEM;

But in commit message you say you switch to bitmap_zalloc(). IIUC
bitmap_alloc() is OK here. But could you please update comment to
avoid confusing.

> 
>         spin_lock_irq(&dev->event_lock);
>         spin_lock(&client->buffer_lock);
> 
> -       memcpy(mem, bits, len);
> +       bitmap_copy(mem, bits, maxbit);
> 
>         spin_unlock(&dev->event_lock);
> 
> @@ -947,7 +945,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
>         if (ret < 0)
>                 evdev_queue_syn_dropped(client);
> 
> -       kfree(mem);
> +       bitmap_free(mem);
> 
>         return ret;
>  }
> @@ -1003,13 +1001,13 @@ static int evdev_set_mask(struct evdev_client *client,
>         if (!cnt)
>                 return 0;
> 
> -       mask = kcalloc(sizeof(unsigned long), BITS_TO_LONGS(cnt), GFP_KERNEL);
> +       mask = bitmap_zalloc(cnt, GFP_KERNEL);
>         if (!mask)
>                 return -ENOMEM;
> 
>         error = bits_from_user(mask, cnt - 1, codes_size, codes, compat);

If my understanding of bits_from_user() correct, here you can also use
bitmap_alloc(), true?

>         if (error < 0) {
> -               kfree(mask);
> +               bitmap_free(mask);
>                 return error;
>         }
> 
> @@ -1018,7 +1016,7 @@ static int evdev_set_mask(struct evdev_client *client,
>         client->evmasks[type] = mask;
>         spin_unlock_irqrestore(&client->buffer_lock, flags);
> 
> -       kfree(oldmask);
> +       bitmap_free(oldmask);
> 
>         return 0;
>  }
> --
> 2.17.1
