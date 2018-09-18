Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F8DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9A82086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h/LJ3fy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9A82086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbeIRSg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:36:28 -0400
Received: from mail-eopbgr20093.outbound.protection.outlook.com ([40.107.2.93]:10848
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbeIRSg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVukn6ydEHhRELfxuBYjfdOu5VHNQoIVQiX9YJEWZDo=;
 b=h/LJ3fy7c7FadE0qH716LelRurWexuJKT4YOMNeg3XOnQFp9Xq/UniCKOt8hFNjqfQiHQI30Erq31u/7DK9SJAWoqW6BR0nLsghTbITAMezSnkaFsjfZvMlCvwddY7GElogIRgVq5huQ1whDwuRdm8P029p5mxtTf+2em6bkzYI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jan.dakinevich@virtuozzo.com; 
Received: from work.sw.ru (185.231.240.5) by
 VI1PR08MB2782.eurprd08.prod.outlook.com (2603:10a6:802:19::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 18 Sep 2018 13:03:50 +0000
From:   Jan Dakinevich <jan.dakinevich@virtuozzo.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Kamal Heib <kamalheib1@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Subject: [PATCH 1/4] IB/core: introduce ->release() callback
Date:   Tue, 18 Sep 2018 16:03:43 +0300
Message-Id: <1537275826-27247-2-git-send-email-jan.dakinevich@virtuozzo.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1537275826-27247-1-git-send-email-jan.dakinevich@virtuozzo.com>
References: <1537275826-27247-1-git-send-email-jan.dakinevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P18901CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::15) To VI1PR08MB2782.eurprd08.prod.outlook.com
 (2603:10a6:802:19::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71591a45-c4cb-4286-7c76-08d61d672e57
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;3:m9w6ofpH7AphkaB7kWfEZCfEaOQaDsOOu7RDmciUgafZhEaafOD9O0/vClwQKiutGoP6Yw6JNNQQY7hCniiuBlvU/w64Co13gslGKNTO9Wkd1FfNcjbfOmR9MU5n8+DZC4DgHs1PzxuDhyx+3+EqsFanL/Yt+P6gjGmyHjkgaHuwWl7wJhUwJukUgXNtIgAhjSFpAjMeSWn0EBa/kGQQZ1RpcO/JxiXOD0bLHGqDf0Ztf5kZ/GAfA5/kzwOp/CL4;25:+yV4KegWrPKlH6I1z5T4nMcMLY887TFsx8t531ePBy1X56wjQ9le6pamCfLiZW1wSAenBnmHB8YEVEOUhGU5362Qj8bKYyInwlZuWGEFhj8y2xDgH0KTspMJd32JGM1ogDArOuKp2eVzBZU99yM41uuO6aQVoLI+zF2QUYpn399HjZu6Id6hG/upzUW1vDAFROwmsKID+sXtmVpE/8NblfFuUTcIvSu/oKb8u+ZKNJDK+nyiuoM5cVW9giE4eykAqjEvOYJy9uRnk3b9kLfY9NNWl8YRG3SYhGBeq4yEFXBnIr8gwVUwuaRBq95FsdS43XcAKFUSz+JYMdT57e56qQ==;31:+DNHFBXhR/JQXN5qORgRLDK3yTP19CsbLyf+DTLTC6CEBX4LEemXg8rvrUwD37zxUsU4+dxjOTZrgwk3ecb/n6l7UHmeA+g6xc1UiAMKgFeOyPS3aE8GBPTSVYyE7OtCtSy4ifdDnAUqtqrUlSpQfyy2gpLagWU4G8TdkzmTGijHjzWlD/MH79NaTboW5qrxOjNrDTpcJAvumXN3ehP64zUQHHDHFY8cn41VvNnWgpA=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2782:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;20:wO3/+RYy5bSxWy9AgJWcYo4GS3qN0pWIEKJiD/bw/YOO3S7uMEIZeLHmNkYF0iy2J+ZhG/kUhk9tqmfAKyYjFlhmIf9YY+r3bvPtnVk6rP1x6HC0A493U0pAwRYxjnlSR/ovRMLqzzj1gqtaOF+nUpuerHde89nV6lYq7wq5xVgd+IU6JABy/tx8cmDsEy661W1xzysXayWkAh+rcfxQCacf1qZsxCgwCz1AcZM6lwFuIh0i3Trfa9YqkUiWgwOOEzwhzHgntms2bD+zpwL2xqi9jb41M8OHHrsz6r8xhz1NzuOJVsS45Uq9fPCQSonF0FajM7zdmx+36yl1PjUZQmG9VLqhUdHQYNvDpA6eM0GH1ptKPsMDkywLDM9TUaxOpjCRuEZ0KvOp0ujOR2eNeE2sFhDAmCIKLSMcRUEhV6ieLyDT3r1/sBraC4tJ+azaoUjk4NXEZZhjD3PsNMi2Gm2RqC9l8v3TX07AUCPDvmgtVOkaMcetp6eDRAhS0ZSz;4:qwIBCN86mw7hXkxlUqW8dRJUuOePYtlrUqwNQqLR1KuPk8aWTPeGza9Rg0gBtvuuLxJ8vwdnKDluHSFZSbZJSf1Bcf0QZcCH84T2ADhHVOwa2gyh3+XUjw8TxM54nJVugT2oPc4r/uemO7IDhfpfSPB4GEGePtsRhDOdXIs7q5SdNyuVvNVXoiYVPJtu0BUcxX3L09YW/IOFdSVs3eLy6rh83MApwfD6/jOust26455nIDnlLwbG7iGRZ1qVoc5zNQ/junv8JeOsMaLSP/cR1Q==
X-Microsoft-Antispam-PRVS: <VI1PR08MB27828B1F9D329847481AEB5C8A1D0@VI1PR08MB2782.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:VI1PR08MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2782;
X-Forefront-PRVS: 0799B1B2D7
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(39850400004)(376002)(189003)(199004)(3846002)(486006)(16526019)(44832011)(7736002)(26005)(68736007)(39060400002)(6116002)(54906003)(186003)(53416004)(81166006)(305945005)(16586007)(7416002)(107886003)(66066001)(2616005)(106356001)(956004)(8676002)(50466002)(8936002)(478600001)(446003)(105586002)(11346002)(476003)(110136005)(81156014)(5660300001)(6486002)(6512007)(14444005)(69596002)(97736004)(4326008)(76176011)(25786009)(47776003)(52116002)(316002)(2906002)(50226002)(386003)(6506007)(48376002)(575784001)(36756003)(6666003)(86362001)(51416003)(53936002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2782;H:work.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB2782;23:hlCm3y2Dw8U9VTI4XTulQ7+kNeMrRVm+XsokvIMOR?=
 =?us-ascii?Q?UEOWa4HfZZeIndqGvlqjXXg6ruvBa161mvS/4NWpOgkTxTzT3P+IhaozWLqI?=
 =?us-ascii?Q?n/TWL3cgPFK2z2/pLL+MYjBvZMRgoEOfGx4EcgW6p0VpZwxXAoUVROLCuFtl?=
 =?us-ascii?Q?9iV8BUKr0hQHkrDyHWydaPrDw1DqakKwgSoJ/dDqbWPsNsrPMssdglDbt/FD?=
 =?us-ascii?Q?9e+MsR7LBuOW05ShCn7JtIX1b8ItetsfR8WrkCaWsrdh53pffPgvnZTta6DW?=
 =?us-ascii?Q?2HoRLYltGiidlJl/0PFDZwHDRVTljgT8IPbwvLM5fFmIqi/a6EEFZMHURUmN?=
 =?us-ascii?Q?Y1tpLWQEGVrdyPCCeoRA7Rg6Eu7LTKsI/qjX/QXMpvFGm+lRDyZ+5fwP4P/X?=
 =?us-ascii?Q?z9wjqkmwzwrVPh21Ffn7mS+acktW1fu5+SYDay0VFpwmPXGSfacHpvXKC6hv?=
 =?us-ascii?Q?FsIGF0yZ8bGy/mQGFDIHaU3XeafdbAFzLpOQiZjmClivLoeWchArmKvO6S6N?=
 =?us-ascii?Q?x3keCpIy5RFzyhtu20Ik7AaIkEHUgs/nOidHdDh3j+VAWYGiivA+cB1Mk2jw?=
 =?us-ascii?Q?c8yhR9h57ySIuR9lHxQQl5JJKVSYSBEDWn+ampHU3W+Jj5uuMcW16oTkMXtA?=
 =?us-ascii?Q?SNeHbCX/DVbVz+6Ks7BxT7of2RavDKEDRHUg8HqdasYy+NVr2QX32l2phzlj?=
 =?us-ascii?Q?AW6WdZUmw3sV//zn0SKAm8Oal1Pudsaig2eVhm9m9Izalg9VJxhViDF7b1Cz?=
 =?us-ascii?Q?qsAWnRMc3hpCvuNqEz36b2K3VVwTZJ/M2wfM+IkG9/BHcaKcyIJ2EpNW399I?=
 =?us-ascii?Q?V5U6KIPMQomQMTwlYCBEvlliAZGcBYUEiKDmBi9mdiSvi7rcsmxWg7jFGqLH?=
 =?us-ascii?Q?sNEzXhVVgPGX4pcSB6N/WyQ6E/H4qQ+TPGMBi9tTGVk6kWo+3dDnX0/ok2dR?=
 =?us-ascii?Q?PHmvHpq6+1lMVggqP6IQkVuzU82qI0aN4Z/ORdAvBbtaf0YQOKMHlGB+bnmp?=
 =?us-ascii?Q?QJJvTtKMb4RkXy10mrXVG8pX9QG3mTMUNoj+3XpOvR86FWohTKrQpiOQe8G5?=
 =?us-ascii?Q?KE+xC+7ZcT7fVO3nJFhu//31bHxXHkwALcGQnPFtUUw/qkpEL69wxnFjVjCn?=
 =?us-ascii?Q?96DwZJpcgPY93rKMmM/JmDrW68thV7AAXokUKQR0Ob1D7QlYDyM4p16O7Y03?=
 =?us-ascii?Q?AIOcf1b9yoQ3RUByoE4KVIVCowR37x5W0FL4PUUI9eD1mEsfLfIBbuZBi2Cp?=
 =?us-ascii?Q?aTlCUqUg6oyVsWkMCpabpIadNIt9J7XzucQt2MbfqI4X7TgXBT/7zTsMMUTv?=
 =?us-ascii?Q?BrM9PPkGk0g2gTCcmScI37mVvoqPqdqcM4b5M2sDzK9O6AnW/9gfl0bkBflN?=
 =?us-ascii?Q?Jad5gTZ+lrP6jImrh9KDC867NYH1ZkI/HfxygQsVYsDCB9w?=
X-Microsoft-Antispam-Message-Info: rxYHxopqFxEGnhPQoNxw/j99CGi2QUt84J+kKI76nBkc4S5Ye9qLxzb7e8iZ/BHGLJq2WlT3LN41UKo/kkEvf4fYmhFxig6nNGQ7XiaUtQtIMRR3l12dun10l76z0z8XCbgHtKg+ZTy9vAUvQyCBBBe3o797EBgq8jQKHN/HQ7BnbWYqZaFVyx8LrK/A5J4sJSkQRmbSsxGt3K/CNSEml5/suuOQpkfMfnZPBTQiJlJnohMNreLz9l5cqOYvHl1SiRl+uiwaA86Y0U4nu3U4PKlFWfk6C4F3BSJal+fN04TgOH6dPItx7VC/QyLcgyiOSVsUdqU2CZ63cFmqLeyaIWpxbCeMI485qqx1ZxWsld4=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;6:Z1dskc0o/irxpNuTx2mJbL6WHlDHN7SviwUu10meodyIfnRlWrc3CTt5nMvESKZ6ZugbGbB+Sdpu9t/2gorUDkpf6PmpYhRK3be+fu0/5iQlyvRqRKFZDmj8A5ZOydGA0Xdx4cV2McP30rdblM3ra26174YtvPFqZpYYGcVRVl5vXgXJ1Kqd1Mv43Gil9ML2rzPpwLQzqUes6LI146qukut1OFeyoCx97gUE/tC/519ZjxulJo55ZwTCgwkAPx/PSOoRzyAHSeUdIWqMX3FMDOFsfXK7m6lcbATPC7wNHYOY5IK5EBY3i4nomPkrD5RC1GfwcB8Xy6MT0QLRPM4wlseDwwhVrJ8tHObG92vNIz63IkTdNDrf5Vql0fFDODNJYI9xthl73GA0BEI/lJS1bXIr68Evq+/0d0gP3VAIRiw348j3GWnntG2SvjPblMLR93uD8tAah4KwQx04ThoYtQ==;5:WrXItRxPSmAniE4nb9M6FVuQdzDlugRHVUw9e/YGVXlBOpgQ0RxvI+xOiq1FeA2lx8gq3+yI9Lmm1AXz/zTbiJFmRJ6jII/Fesuwdz1OTIm74UDfajTjXPHE8ex7xmbwKMnxQ5t1UmUN720OPcNUxuRVLCpvQX9elcxlRBXca2Y=;7:3Ugf4CAyesu3FlGBS2VzsxMZEYv1UJ1l7uy8fu7tlqqkX1w7OPySNcPcoEh3IcMU29C4I97F4yEVxrZ0AhMzP2ES/0Nw3epKsZznKFsYxR6+TGy9TJPM+tuX8Vkvfxg20uIPlLlWfV61fu/roGmHBfUN8xyDX7Z4D/Kei8YCtX6h9MhR5XSv3rWal/nQWFYnNtrtxj5pOckw2jX4ekP5WTKi8jHxD9Utndd31+L1xofIMiG0ESpSuhdJGajIf/TN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;20:pTwURjOc5GGPgYGXP0MmG5J4RRry76gIMBWMzrWMf7B9vc6oR66djM2VFwjlKzT2U0xc3FBXc6wIFSZ406ajEcLjyQirKPHf80134RIhkiCrrkf7rN0t3KPhqm1trvHJv/tbkxjGFDdx+LEPklfqmP/kKgBM4WoOwPtJ0ROSA1I=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 13:03:50.5826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71591a45-c4cb-4286-7c76-08d61d672e57
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2782
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IB infrastructure shares common device instance constructor with
reference counting, and it uses kzalloc() to allocate memory
for device specific instance with incapsulated ib_device field as one
contigous memory block.

The issue is that the device specific instances tend to be too large
and require high page order memory allocation. Unfortunately, kzalloc()
in ib_alloc_device() can not be replaced with kvzalloc() since it would
require a lot of review in all IB driver to prove correctness of the
replacement.

The driver can allocate some heavy partes of their instance for itself
and keep pointers for them in own instance. For this it is important
that the alocated parts have the same life time as ib_device, thus
their deallocation should be based on the same reference counting.

Let suppose:

struct foo_ib_device {
	struct ib_device device;

	void *part;

	...
};

To properly free memory from .foo_ib_part the driver should provide
function for ->release() callback:

void foo_ib_release(struct ib_device *device)
{
	struct foo_ib_device *foo = container_of(device,  struct foo_ib_device,
						 device);

	kvfree(foo->part);
}

...and initialiaze this callback immediately after foo_ib_device
instance allocation.

	struct foo_ib_device *foo;

	foo = ib_alloc_device(sizeof(struct foo_ib_device));

	foo->device.release = foo_ib_release;

	/* allocate parts */
	foo->part = kvmalloc(65536, GFP_KERNEL);

Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 drivers/infiniband/core/device.c | 2 ++
 include/rdma/ib_verbs.h          | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index db3b627..a8c8b0d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -215,6 +215,8 @@ static void ib_device_release(struct device *device)
 		ib_cache_release_one(dev);
 		kfree(dev->port_immutable);
 	}
+	if (dev->release)
+		dev->release(dev);
 	kfree(dev);
 }
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index e950c2a..fb582bb 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2271,6 +2271,8 @@ struct ib_device {
 
 	struct iw_cm_verbs	     *iwcm;
 
+	void			   (*release)(struct ib_device *device);
+
 	/**
 	 * alloc_hw_stats - Allocate a struct rdma_hw_stats and fill in the
 	 *   driver initialized data.  The struct is kfree()'ed by the sysfs
-- 
2.1.4

