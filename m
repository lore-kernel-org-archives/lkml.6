Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 50D01C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FAE208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="edCYLgfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FAE208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756150AbeFOMJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:09:26 -0400
Received: from mail-by2nam01on0044.outbound.protection.outlook.com ([104.47.34.44]:40992
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756109AbeFOMJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJo7IbwvpycvU38D3NfHh7iW4hkfqBUQ04Wd6Sl/up8=;
 b=edCYLgfeVIc4+T0DssI3e8MkoxD+0+rUeUVbIT2IC/mKrrsPzybVnxEuQ+XY1bJYFWSMlj5FLb/fae36HIS150qGsigbQizHzhxoFBiLIc/AHLw11BounQEXQl92C6Qk1SVI9V/ukHs0cUx0Q81eBFVETrUPgcy3zsyeR/J1Vo0=
Received: from localhost.localdomain (155.4.205.56) by
 BYAPR05MB4583.namprd05.prod.outlook.com (2603:10b6:a02:f2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Fri, 15 Jun 2018 12:09:14 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH v3 2/2] locking: Implement an algorithm choice for Wound-Wait mutexes
Date:   Fri, 15 Jun 2018 14:08:27 +0200
Message-Id: <20180615120827.3989-2-thellstrom@vmware.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180615120827.3989-1-thellstrom@vmware.com>
References: <20180615120827.3989-1-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:7:67::34) To BYAPR05MB4583.namprd05.prod.outlook.com
 (2603:10b6:a02:f2::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c6aa314-bc57-48ce-ef19-08d5d2b8d2c6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4583;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4583;3:XJsyU/PUrUTsWXxhykzJH3I8yVVn2yJLWHvGmFdYGDvL1fVWDY1NDQWstTEdCT0EdiGzypvwH+MkPQGAOWvL9Qnblq5ndHvuanT0VXOd0CnczAznu9dfZXQr+jV1DhUntcwCZqsd3HGlJ0Aeiwngq5W6F0m08D2RNxUliIA1ZVMQrLgLkq7QEhwCSenSrsJoX46td22ps2LhELLeSHUitBvmVuIcWbW9gg7zwUYPYmdI2wXlkVt5dvqNnkJ5GmnU;25:VhgUy4dFzXpnlW6juxZS/2K4QLBPj2tWMymjR6II6WKC0USYv+I98HkPmW58PBC/iAjANK7tiCO5gUY0PMSxk8wQvL1VcDd+LFCY9GeXDEyx02GTZpLZN2eeMEJFrck6Lp67gwYhsoztJOZE1hqqfz9SMjk6k7aDOglMXKyGtH0dQv7mvBnvGljZlFoVBpthMLU9TJk3X/5wZou0JbpmbdYUTXQVll6RfSNvRbdwY8XOYYxBM7Kbo7d3HURQKEVzAtoQTad3AK1LFVRCMUxgsi4AldGQY2scNTt2L8c7u65G9wVOMQLuFrMP925o6K9wKvaOfcNRohwH8Emdud+h/w==;31:LLvZH3tJ7AVekjhtGUBJ6tsdVi4ncY5ANldwceyNB56xGF6udTkyCn6X7pDo2JymAuDxyrUVeZrQA78XI679z2JlC1q4vXNKU4rOmTziUzonWgu9yGIK2KzZzEDI/DICB/emNCLO2wT+NOx6wn80M7bvbA/o8OCVDChP6XmOL+TpB1rcnDnl+Oo0TSkxGZ4wkdCqOl3p8mB/tVTizOneKPHz4phf2OI1S1EOBQiwcTk=
X-MS-TrafficTypeDiagnostic: BYAPR05MB4583:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4583;20:sj4Gt81PxzwebTZY5VZ2hjnXxdoowvbpCPY3nkiLxPd60K2tNLw1vAFiXdPaTLQgx5OrL7Q7xZ3hQud7Q4kweRuwBvOAiFD+VG6nMRqYnxyCpeQPK0aitQNt/pSogEyPF0Xl7rI9OVuuHil924g+Ppwhg9W4EJZCgobNH8Fqm2gG7Y9CjUYpgMAk2aQ//tFlcQqPj1P8yhYAqTXeWAe3VAZii2ilkYgoWKQbqeeVIWHck2ZQPyiOLqNi1I9L7UwFhxUIpiget5tQhDkiKId2/am/M/gxbeKRksLSuRVKA00qBmq7SEtBUzHwjzCQx3e7Oh54sXr6OmDv2XVLLzHyeCayRsIjoNqdKmO/oP9Ua2xy1CvOajdyQ4eX1Nx++EorT/Q+LeUw/NUhz7q6AoPosPgk27991/jatMMI69RXuvgMz7cOyGM5WdNXQPOEC781ViM1WQ5klgHhM2w4CzxpqTyJTOxV2TXfeCllKRg0SphqSctzwrSlpcYHmgDnayf2
X-Microsoft-Antispam-PRVS: <BYAPR05MB4583F364D98BD6BF0A361CD1A17C0@BYAPR05MB4583.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(190756311086443)(9452136761055)(1553240931313)(104084551191319)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4583;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4583;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4583;4:LR7unGnyaL3acb4DrDInM7kpIrd4S2Xf3rtaXQOdX4GbUNkV1qHzOcarc12EfJnZ6UI9xIbyr5/o0DDH7/r2ojZERzjQ7sBd/jVO94HAAtwZ8HDhbqpIXv802+FOvmUt3zVZ7VC/TkERYb9LfVyQj5pL40G2Ch5kHXYasxge/lPq2fX6c1z+E9kiP8iu0Cm6O1y0VSy7hdb41D9NTPN5vRQmjSwSxgXy+ywz88qqF1QDuFGUnjZ2AM2unuVtr2VQrV8I/BPo0sS1X79ux0X5AXVHbMV4WfcA75Vle2Ez+GzCQ6H/o3sckcIsEe5yoJPEVOKawOR5VLr+rYWdDZubDBJwOKp7aNKZDs7utnDITSg9PC3LZc032G03z1er6ue10/ms/ZJBwi9Rfdzw91oUJlzACV7GzMPCzcxlCYfkd0ZJhQVsDsRJvm8sexNiBrbRsI036E0/3HStmBQs9H1ZutL2RgIcmESYNrW4q5tV7k8=
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(39380400002)(366004)(346002)(39860400002)(376002)(189003)(199004)(5660300001)(8936002)(68736007)(305945005)(6486002)(551934003)(36756003)(7736002)(1076002)(6666003)(2906002)(105586002)(106356001)(3846002)(478600001)(6116002)(50226002)(97736004)(81166006)(81156014)(54906003)(16586007)(446003)(47776003)(186003)(25786009)(386003)(16526019)(2616005)(26005)(476003)(316002)(956004)(66066001)(52116002)(11346002)(6512007)(486006)(76176011)(51416003)(59450400001)(50466002)(86362001)(48376002)(7416002)(575784001)(6506007)(4326008)(53936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4583;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR05MB4583;23:CJhZp3KQQH5jrNHQtFBKvKy5T/yxfBqciLs+BQq22?=
 =?us-ascii?Q?BvTXmuLWOZiN8fp7p7cj5nlJhvPh4HUs+v+gGS5voB+VIVSe+M9yMpTtvBJ/?=
 =?us-ascii?Q?7kk1fYd71r1Vip4LbEUStyvquZi4/27r6rFpGrl2roNksSD4t782jEyh3eTZ?=
 =?us-ascii?Q?m1/q0jU6b8ZKTonqG9QGYVe8PznRTCWoDcf6JL8PdaMC82oRSrDvPvN2L470?=
 =?us-ascii?Q?7PWnrzRz93mLqm04b8eBNp+Aj15b/5Nn6+gNRccPGd17MO5s9G/0BDzpcxnv?=
 =?us-ascii?Q?YT9+Z+MKBszGbK+EjeFxtfXEzZ9JzND0byLleXe2Ran5RK8l6hJFwwHHtXGB?=
 =?us-ascii?Q?tgZ6hhtgub4RoxLXDXbkAjn19jMtExjWOQJxQnIwQqtyjlCP62oHULVHbyoz?=
 =?us-ascii?Q?N90pdJI7owJjK0hxxve3YhLSKAJwwsBLxA9KnZIT2sq48IofpnFdrY1BDQ8f?=
 =?us-ascii?Q?nQ6pcpW1CglzyO7QpoQycbU05jgL6OuolaciarHwMZZ9fmxZ80W0lSbtcaMP?=
 =?us-ascii?Q?brqqflJP0WXYT5BrBN6KSZXh7v5wCA9T5qGZxBa3+fQdisPOwGHNvqZQRFMc?=
 =?us-ascii?Q?ZtULeGyA1lWq6LINgrf3dGGiH+dHJVXuTDE92y2We4yq4FRGvlSfYm4dnYF7?=
 =?us-ascii?Q?DNblfhye4sRQvbWNOKm7Iv9u8ACJagFGynUfKZJ7pbU165eBOL6k6AU0iqte?=
 =?us-ascii?Q?gGKt0QgyNBDLq+4bC0bES0cYWwXloSIwwi/r/Tik8KauGQMHKz/FXHGWmdIT?=
 =?us-ascii?Q?MM0HsbeGdaHnD9JfT53y14PEMs65QrSD5Q6yzYdzGs7kcTXZU5P9a6Eo6zd3?=
 =?us-ascii?Q?XBGw7i1q3NdMsr6wrnlpm3W7XaARgbBW14dt6omWKOroj+p7ofLAFMFlgHYk?=
 =?us-ascii?Q?QT4bzyE3UguGSb1TWlqZF1qSEK8+I8tPwjU4/84lmmWFvwAswE9n6ZikoVUk?=
 =?us-ascii?Q?pWYJGlEAzMhUgOfZeDdfSSwdPzAFpKYfPZFYz2f3QLboK0OgpmiDLq6K6UDV?=
 =?us-ascii?Q?n2pVoTfSWLEzrz3woXjYB6VpV0NBFVrrtZk7bS/mBTZBjAkTv6eS/KdrmLpe?=
 =?us-ascii?Q?ceEBDek2IbsDu/RzK0w526zgb7YoUl63Cv/ogi584Czs8UKv1pNftX1Jfw6L?=
 =?us-ascii?Q?RRnLj1L9B8YrtHqAvlIFjzosgQWDthUcGYwlxFSKYr9vjXfn9QIr8fDWtVu9?=
 =?us-ascii?Q?388I6RxPU9/bAZ8yWc3YovQBIMnr4PxsGTb5pWktNovIqQfyoHyV5XY+TMnv?=
 =?us-ascii?Q?AKo+EKgTIXN7XIO0SwEqghzERy3VoqSdi/yw5cOpAsEsBgf2iHcsfefYIeo+?=
 =?us-ascii?Q?+369tM0nsiijvGnbgyg47I=3D?=
X-Microsoft-Antispam-Message-Info: dUcQQjS61AzuimAEUEeWoZrH8sHMCJKzDzvT9L7H8DXVMg2v4puY6gbMsr5UEUJZkieIx+AKL2XeYXbGvoCGwAhRuCv6dGyk84J/qEktQckO4VH1kODhJYIkho2ptqq115+dBeTtdC675PhXK10VBnSI9GzSJ5IKzJ1H7HiyJ2NEmFn+ciKpUDTyGcabnmWZ
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4583;6:Uyf5MIOvHRrFc+3NIUR+NF8+HHIvKVgCt3Z82o8f49ejY4Ke/JLdjv/da2Eqik2XRvc51gTRSUtpt+V0MMvqYfeYOg84e6sG3bA2pG77Ep9YR59yFj8KNlxoVHh5U/bTUoWKq3/3z1Kt+XuZToItOvo9mlYuT+cAdiMXbTJvTPk80ByETcZMfbOmZld8UwqdUt12PiWh8TydMMv9sA7EGbtTfdhc4/dmdASABjdshhzP5xbdZfXF66bGJEukZezOV63owVHuv8kGGg90oY/CEygqS0uH8tFCyhDzPdEWMWB2cX5YuNVRPztXPY9M6gXXWYbKFFBet3hHM92cg/cOA30KCqCyCoVkB0J5fe1MBHb/PYZtKtXRtddwJaTOOdFv/f8mJot0LbSHGzg0vjmn7CWQ3cBlCteqlLfHlkNhNrifKc3vqb6GyEiBN6UPbLbxBo5ekm0msVj2FzyJUMfqcQ==;5:qJQdgRKPdd/a0f8GFMyS0pOd8QEdMJ5+AH+Vo8INzNcMFbzHGpz7/936DKoL8PSKGsAmwAAmaZ5W39212+fq4hO41AgS3fFlmWh64v2GxSLpy7ThjDryld1yavDUtX9C6WAHbX9uIrLmY2hyzl7kSW5BkUzASYFmRY0mTMk8pi8=;24:IBEKpJPnwtabhr8XwDR4Bc5fZoxmftDrUhuZkE6kH48klXMsVaCInnmErItCIx01SzOhwylXnpYvQnJLYD2x+yOBYclNuSqBABpsUlZHw/o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4583;7:SLnNAvWMpmtGR5zWWRzJWK+K/m0AFfimZZZ3tLxiYylGrAcE3FZqNti//9UpgA6A3/UEnuPue6S3tMvfp1X16HGG9v9cv7Hjn8Hnrl2roXQF/Wlpsg7VVI561+16QVec6Hz8iKWE0nyQr/9pu3pIefONBrSH0+sVr6d2is35SVopWDFcjwaPnIA8FdQR5dDY6J+1W2ydxMqHxhJOQ6NbW2j6Te+QU/L99SOJ6E3NxFelbPZ1pibIoN0ebYMEBsee;20:n/CFiLxyWaptu5hCgrOlwhLPfqa00rON9kluZIddBUhRd7aYYk1v7tmnLbI5U6DBiUMS16HnCo2WT5vKtPmv90H98vTTwaiP2X56L7HC8womEb9XzZ/T7cIN3Zd1ANicPkUWXSB6lt/uZVbZXEkRiYH4f8X7JAgZwoWidW4nrFg=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 12:09:14.9659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6aa314-bc57-48ce-ef19-08d5d2b8d2c6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current Wound-Wait mutex algorithm is actually not Wound-Wait but
Wait-Die. Implement also Wound-Wait as a per-ww-class choice. Wound-Wait
is, contrary to Wait-Die a preemptive algorithm and is known to generate
fewer backoffs. Testing reveals that this is true if the
number of simultaneous contending transactions is small.
As the number of simultaneous contending threads increases, Wait-Wound
becomes inferior to Wait-Die in terms of elapsed time.
Possibly due to the larger number of held locks of sleeping transactions.

Update documentation and callers.

Timings using git://people.freedesktop.org/~thomash/ww_mutex_test
tag patch-18-06-15

Each thread runs 100000 batches of lock / unlock 800 ww mutexes randomly
chosen out of 100000. Four core Intel x86_64:

Algorithm    #threads       Rollbacks  time
Wound-Wait   4              ~100       ~17s.
Wait-Die     4              ~150000    ~19s.
Wound-Wait   16             ~360000    ~109s.
Wait-Die     16             ~450000    ~82s.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Co-authored-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 Documentation/locking/ww-mutex-design.txt |  57 +++++++++---
 drivers/dma-buf/reservation.c             |   2 +-
 drivers/gpu/drm/drm_modeset_lock.c        |   2 +-
 include/linux/ww_mutex.h                  |  17 +++-
 kernel/locking/locktorture.c              |   2 +-
 kernel/locking/mutex.c                    | 148 +++++++++++++++++++++++++++---
 kernel/locking/test-ww_mutex.c            |   2 +-
 lib/locking-selftest.c                    |   2 +-
 8 files changed, 199 insertions(+), 33 deletions(-)

diff --git a/Documentation/locking/ww-mutex-design.txt b/Documentation/locking/ww-mutex-design.txt
index 2fd7f2a2af21..f0ed7c30e695 100644
--- a/Documentation/locking/ww-mutex-design.txt
+++ b/Documentation/locking/ww-mutex-design.txt
@@ -1,4 +1,4 @@
-Wait/Wound Deadlock-Proof Mutex Design
+Wound/Wait Deadlock-Proof Mutex Design
 ======================================
 
 Please read mutex-design.txt first, as it applies to wait/wound mutexes too.
@@ -32,10 +32,26 @@ the oldest task) wins, and the one with the higher reservation id (i.e. the
 younger task) unlocks all of the buffers that it has already locked, and then
 tries again.
 
-In the RDBMS literature this deadlock handling approach is called wait/die:
-The older tasks waits until it can acquire the contended lock. The younger tasks
-needs to back off and drop all the locks it is currently holding, i.e. the
-younger task dies.
+In the RDBMS literature, a reservation ticket is associated with a transaction.
+and the deadlock handling approach is called Wait-Die. The name is based on
+the actions of a locking thread when it encounters an already locked mutex.
+If the transaction holding the lock is younger, the locking transaction waits.
+If the transaction holding the lock is older, the locking transaction backs off
+and dies. Hence Wait-Die.
+There is also another algorithm called Wound-Wait:
+If the transaction holding the lock is younger, the locking transaction
+wounds the transaction holding the lock, requesting it to die.
+If the transaction holding the lock is older, it waits for the other
+transaction. Hence Wound-Wait.
+The two algorithms are both fair in that a transaction will eventually succeed.
+However, the Wound-Wait algorithm is typically stated to generate fewer backoffs
+compared to Wait-Die, but is, on the other hand, associated with more work than
+Wait-Die when recovering from a backoff. Wound-Wait is also a preemptive
+algorithm in that transactions are wounded by other transactions, and that
+requires a reliable way to pick up up the wounded condition and preempt the
+running transaction. Note that this is not the same as process preemption. A
+Wound-Wait transaction is considered preempted when it dies (returning
+-EDEADLK) following a wound.
 
 Concepts
 --------
@@ -47,10 +63,12 @@ Acquire context: To ensure eventual forward progress it is important the a task
 trying to acquire locks doesn't grab a new reservation id, but keeps the one it
 acquired when starting the lock acquisition. This ticket is stored in the
 acquire context. Furthermore the acquire context keeps track of debugging state
-to catch w/w mutex interface abuse.
+to catch w/w mutex interface abuse. An acquire context is representing a
+transaction.
 
 W/w class: In contrast to normal mutexes the lock class needs to be explicit for
-w/w mutexes, since it is required to initialize the acquire context.
+w/w mutexes, since it is required to initialize the acquire context. The lock
+class also specifies what algorithm to use, Wound-Wait or Wait-Die.
 
 Furthermore there are three different class of w/w lock acquire functions:
 
@@ -90,6 +108,12 @@ provided.
 Usage
 -----
 
+The algorithm (Wait-Die vs Wound-Wait) is chosen by using either
+DEFINE_WW_CLASS() (Wound-Wait) or DEFINE_WD_CLASS() (Wait-Die)
+As a rough rule of thumb, use Wound-Wait iff you
+expect the number of simultaneous competing transactions to be typically small,
+and you want to reduce the number of rollbacks.
+
 Three different ways to acquire locks within the same w/w class. Common
 definitions for methods #1 and #2:
 
@@ -312,12 +336,23 @@ Design:
   We maintain the following invariants for the wait list:
   (1) Waiters with an acquire context are sorted by stamp order; waiters
       without an acquire context are interspersed in FIFO order.
-  (2) Among waiters with contexts, only the first one can have other locks
-      acquired already (ctx->acquired > 0). Note that this waiter may come
-      after other waiters without contexts in the list.
+  (2) For Wait-Die, among waiters with contexts, only the first one can have
+      other locks acquired already (ctx->acquired > 0). Note that this waiter
+      may come after other waiters without contexts in the list.
+
+  The Wound-Wait preemption is implemented with a lazy-preemption scheme:
+  The wounded status of the transaction is checked only when there is
+  contention for a new lock and hence a true chance of deadlock. In that
+  situation, if the transaction is wounded, it backs off, clears the
+  wounded status and retries. A great benefit of implementing preemption in
+  this way is that the wounded transaction can identify a contending lock to
+  wait for before restarting the transaction. Just blindly restarting the
+  transaction would likely make the transaction end up in a situation where
+  it would have to back off again.
 
   In general, not much contention is expected. The locks are typically used to
-  serialize access to resources for devices.
+  serialize access to resources for devices, and optimization focus should
+  therefore be directed towards the uncontended cases.
 
 Lockdep:
   Special care has been taken to warn for as many cases of api abuse
diff --git a/drivers/dma-buf/reservation.c b/drivers/dma-buf/reservation.c
index 314eb1071cce..20bf90f4ee63 100644
--- a/drivers/dma-buf/reservation.c
+++ b/drivers/dma-buf/reservation.c
@@ -46,7 +46,7 @@
  * write-side updates.
  */
 
-DEFINE_WW_CLASS(reservation_ww_class);
+DEFINE_WD_CLASS(reservation_ww_class);
 EXPORT_SYMBOL(reservation_ww_class);
 
 struct lock_class_key reservation_seqcount_class;
diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index 8a5100685875..638be2eb67b4 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -70,7 +70,7 @@
  * lists and lookup data structures.
  */
 
-static DEFINE_WW_CLASS(crtc_ww_class);
+static DEFINE_WD_CLASS(crtc_ww_class);
 
 /**
  * drm_modeset_lock_all - take all modeset locks
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index f82fce2229c8..3af7c0e03be5 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -8,6 +8,8 @@
  *
  * Wait/Die implementation:
  *  Copyright (C) 2013 Canonical Ltd.
+ * Choice of algorithm:
+ *  Copyright (C) 2018 WMWare Inc.
  *
  * This file contains the main data structure and API definitions.
  */
@@ -23,12 +25,15 @@ struct ww_class {
 	struct lock_class_key mutex_key;
 	const char *acquire_name;
 	const char *mutex_name;
+	unsigned int is_wait_die;
 };
 
 struct ww_acquire_ctx {
 	struct task_struct *task;
 	unsigned long stamp;
 	unsigned int acquired;
+	unsigned short wounded;
+	unsigned short is_wait_die;
 #ifdef CONFIG_DEBUG_MUTEXES
 	unsigned int done_acquire;
 	struct ww_class *ww_class;
@@ -58,17 +63,21 @@ struct ww_mutex {
 # define __WW_CLASS_MUTEX_INITIALIZER(lockname, class)
 #endif
 
-#define __WW_CLASS_INITIALIZER(ww_class) \
+#define __WW_CLASS_INITIALIZER(ww_class, _is_wait_die)	    \
 		{ .stamp = ATOMIC_LONG_INIT(0) \
 		, .acquire_name = #ww_class "_acquire" \
-		, .mutex_name = #ww_class "_mutex" }
+		, .mutex_name = #ww_class "_mutex" \
+		, .is_wait_die = _is_wait_die }
 
 #define __WW_MUTEX_INITIALIZER(lockname, class) \
 		{ .base =  __MUTEX_INITIALIZER(lockname.base) \
 		__WW_CLASS_MUTEX_INITIALIZER(lockname, class) }
 
+#define DEFINE_WD_CLASS(classname) \
+	struct ww_class classname = __WW_CLASS_INITIALIZER(classname, 1)
+
 #define DEFINE_WW_CLASS(classname) \
-	struct ww_class classname = __WW_CLASS_INITIALIZER(classname)
+	struct ww_class classname = __WW_CLASS_INITIALIZER(classname, 0)
 
 #define DEFINE_WW_MUTEX(mutexname, ww_class) \
 	struct ww_mutex mutexname = __WW_MUTEX_INITIALIZER(mutexname, ww_class)
@@ -123,6 +132,8 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
 	ctx->task = current;
 	ctx->stamp = atomic_long_inc_return_relaxed(&ww_class->stamp);
 	ctx->acquired = 0;
+	ctx->wounded = false;
+	ctx->is_wait_die = ww_class->is_wait_die;
 #ifdef CONFIG_DEBUG_MUTEXES
 	ctx->ww_class = ww_class;
 	ctx->done_acquire = 0;
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 6850ffd69125..907e0325892c 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -365,7 +365,7 @@ static struct lock_torture_ops mutex_lock_ops = {
 };
 
 #include <linux/ww_mutex.h>
-static DEFINE_WW_CLASS(torture_ww_class);
+static DEFINE_WD_CLASS(torture_ww_class);
 static DEFINE_WW_MUTEX(torture_ww_mutex_0, &torture_ww_class);
 static DEFINE_WW_MUTEX(torture_ww_mutex_1, &torture_ww_class);
 static DEFINE_WW_MUTEX(torture_ww_mutex_2, &torture_ww_class);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 412b4fc08235..55b5ac9bce16 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -248,6 +248,11 @@ EXPORT_SYMBOL(mutex_lock);
  *   The newer transactions are killed when:
  *     It (the new transaction) makes a request for a lock being held
  *     by an older transaction.
+ *
+ * Wound-Wait:
+ *   The newer transactions are wounded when:
+ *     An older transaction makes a request for a lock being held by
+ *     the newer transaction.
  */
 
 /*
@@ -319,6 +324,9 @@ static bool __sched
 __ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
 	       struct ww_acquire_ctx *ww_ctx)
 {
+	if (!ww_ctx->is_wait_die)
+		return false;
+
 	if (waiter->ww_ctx->acquired > 0 &&
 			__ww_ctx_stamp_after(waiter->ww_ctx, ww_ctx)) {
 		debug_mutex_wake_waiter(lock, waiter);
@@ -328,13 +336,65 @@ __ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
 	return true;
 }
 
+/*
+ * Wound-Wait; wound a younger @hold_ctx if it holds the lock.
+ *
+ * Wound the lock holder if there are waiters with older transactions than
+ * the lock holders. Even if multiple waiters may wound the lock holder,
+ * it's sufficient that only one does.
+ */
+static bool __ww_mutex_wound(struct mutex *lock,
+			     struct ww_acquire_ctx *ww_ctx,
+			     struct ww_acquire_ctx *hold_ctx)
+{
+	struct task_struct *owner = __mutex_owner(lock);
+
+	lockdep_assert_held(&lock->wait_lock);
+
+	/*
+	 * Possible through __ww_mutex_add_waiter() when we race with
+	 * ww_mutex_set_context_fastpath(). In that case we'll get here again
+	 * through __ww_mutex_check_waiters().
+	 */
+	if (!hold_ctx)
+		return false;
+
+	/*
+	 * Can have !owner because of __mutex_unlock_slowpath(), but if owner,
+	 * it cannot go away because we'll have FLAG_WAITERS set and hold
+	 * wait_lock.
+	 */
+	if (!owner)
+		return false;
+
+	if (ww_ctx->acquired > 0 && __ww_ctx_stamp_after(hold_ctx, ww_ctx)) {
+		hold_ctx->wounded = 1;
+
+		/*
+		 * wake_up_process() paired with set_current_state()
+		 * inserts sufficient barriers to make sure @owner either sees
+		 * it's wounded in __ww_mutex_lock_check_stamp() or has a
+		 * wakeup pending to re-read the wounded state.
+		 */
+		if (owner != current)
+			wake_up_process(owner);
+
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * We just acquired @lock under @ww_ctx, if there are later contexts waiting
- * behind us on the wait-list, check if they need to die.
+ * behind us on the wait-list, check if they need to die, or wound us.
  *
  * See __ww_mutex_add_waiter() for the list-order construction; basically the
  * list is ordered by stamp, smallest (oldest) first.
  *
+ * This relies on never mixing wait-die/wound-wait on the same wait-list;
+ * which is currently ensured by that being a ww_class property.
+ *
  * The current task must not be on the wait list.
  */
 static void __sched
@@ -348,7 +408,8 @@ __ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
 		if (!cur->ww_ctx)
 			continue;
 
-		if (__ww_mutex_die(lock, cur, ww_ctx))
+		if (__ww_mutex_die(lock, cur, ww_ctx) ||
+		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
 			break;
 	}
 }
@@ -369,17 +430,23 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * and keep spinning, or it will acquire wait_lock, add itself
 	 * to waiter list and sleep.
 	 */
-	smp_mb(); /* ^^^ */
+	smp_mb(); /* See comments above and below. */
 
 	/*
-	 * Check if lock is contended, if not there is nobody to wake up
+	 * [W] ww->ctx = ctx	    [W] MUTEX_FLAG_WAITERS
+	 *     MB		        MB
+	 * [R] MUTEX_FLAG_WAITERS   [R] ww->ctx
+	 *
+	 * The memory barrier above pairs with the memory barrier in
+	 * __ww_mutex_add_waiter() and makes sure we either observe ww->ctx
+	 * and/or !empty list.
 	 */
 	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
 		return;
 
 	/*
 	 * Uh oh, we raced in fastpath, check if any of the waiters need to
-	 * die.
+	 * die or wound us.
 	 */
 	spin_lock(&lock->base.wait_lock);
 	__ww_mutex_check_waiters(&lock->base, ctx);
@@ -681,7 +748,9 @@ __ww_mutex_kill(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
 
 
 /*
- * Check whether we need to kill the transaction for the current lock acquire.
+ * Check the wound condition for the current lock acquire.
+ *
+ * Wound-Wait: If we're wounded, kill ourself.
  *
  * Wait-Die: If we're trying to acquire a lock already held by an older
  *           context, kill ourselves.
@@ -700,6 +769,13 @@ __ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
 	if (ctx->acquired == 0)
 		return 0;
 
+	if (!ctx->is_wait_die) {
+		if (ctx->wounded)
+			return __ww_mutex_kill(lock, ctx);
+
+		return 0;
+	}
+
 	if (hold_ctx && __ww_ctx_stamp_after(ctx, hold_ctx))
 		return __ww_mutex_kill(lock, ctx);
 
@@ -726,7 +802,8 @@ __ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
  * Waiters without context are interspersed in FIFO order.
  *
  * Furthermore, for Wait-Die kill ourself immediately when possible (there are
- * older contexts already waiting) to avoid unnecessary waiting.
+ * older contexts already waiting) to avoid unnecessary waiting and for
+ * Wound-Wait ensure we wound the owning context when it is younger.
  */
 static inline int __sched
 __ww_mutex_add_waiter(struct mutex_waiter *waiter,
@@ -735,16 +812,21 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 {
 	struct mutex_waiter *cur;
 	struct list_head *pos;
+	bool is_wait_die;
 
 	if (!ww_ctx) {
 		list_add_tail(&waiter->list, &lock->wait_list);
 		return 0;
 	}
 
+	is_wait_die = ww_ctx->is_wait_die;
+
 	/*
 	 * Add the waiter before the first waiter with a higher stamp.
 	 * Waiters without a context are skipped to avoid starving
-	 * them. Wait-Die waiters may die here.
+	 * them. Wait-Die waiters may die here. Wound-Wait waiters
+	 * never die here, but they are sorted in stamp order and
+	 * may wound the lock holder.
 	 */
 	pos = &lock->wait_list;
 	list_for_each_entry_reverse(cur, &lock->wait_list, list) {
@@ -757,10 +839,12 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 			 * is no point in queueing behind it, as we'd have to
 			 * die the moment it would acquire the lock.
 			 */
-			int ret = __ww_mutex_kill(lock, ww_ctx);
+			if (is_wait_die) {
+				int ret = __ww_mutex_kill(lock, ww_ctx);
 
-			if (ret)
-				return ret;
+				if (ret)
+					return ret;
+			}
 
 			break;
 		}
@@ -772,6 +856,25 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 	}
 
 	list_add_tail(&waiter->list, pos);
+	if (__mutex_waiter_is_first(lock, waiter))
+		__mutex_set_flag(lock, MUTEX_FLAG_WAITERS);
+
+	/*
+	 * Wound-Wait: if we're blocking on a mutex owned by a younger context,
+	 * wound that such that we might proceed.
+	 */
+	if (!is_wait_die) {
+		struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
+
+		/*
+		 * See ww_mutex_set_context_fastpath(). Orders setting
+		 * MUTEX_FLAG_WAITERS (atomic operation) vs the ww->ctx load,
+		 * such that either we or the fastpath will wound @ww->ctx.
+		 */
+		smp_mb__after_atomic();
+
+		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
+	}
 
 	return 0;
 }
@@ -795,6 +898,14 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	if (use_ww_ctx && ww_ctx) {
 		if (unlikely(ww_ctx == READ_ONCE(ww->ctx)))
 			return -EALREADY;
+
+		/*
+		 * Reset the wounded flag after a kill. No other process can
+		 * race and wound us here since they can't have a valid owner
+		 * pointer if we don't have any locks held.
+		 */
+		if (ww_ctx->acquired == 0)
+			ww_ctx->wounded = 0;
 	}
 
 	preempt_disable();
@@ -829,6 +940,9 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	if (!use_ww_ctx) {
 		/* add waiting tasks to the end of the waitqueue (FIFO): */
 		list_add_tail(&waiter.list, &lock->wait_list);
+		if (__mutex_waiter_is_first(lock, &waiter))
+			__mutex_set_flag(lock, MUTEX_FLAG_WAITERS);
+
 
 #ifdef CONFIG_DEBUG_MUTEXES
 		waiter.ww_ctx = MUTEX_POISON_WW_CTX;
@@ -847,9 +961,6 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 
 	waiter.task = current;
 
-	if (__mutex_waiter_is_first(lock, &waiter))
-		__mutex_set_flag(lock, MUTEX_FLAG_WAITERS);
-
 	set_current_state(state);
 	for (;;) {
 		/*
@@ -906,6 +1017,15 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 acquired:
 	__set_current_state(TASK_RUNNING);
 
+	if (use_ww_ctx && ww_ctx) {
+		/*
+		 * Wound-Wait; we stole the lock (!first_waiter), check the
+		 * waiters as anyone might want to wound us.
+		 */
+		if (!ww_ctx->is_wait_die && !__mutex_waiter_is_first(lock, &waiter))
+			__ww_mutex_check_waiters(lock, ww_ctx);
+	}
+
 	mutex_remove_waiter(lock, &waiter, current);
 	if (likely(list_empty(&lock->wait_list)))
 		__mutex_clear_flag(lock, MUTEX_FLAGS);
diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 0e4cd64ad2c0..5b915b370d5a 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -26,7 +26,7 @@
 #include <linux/slab.h>
 #include <linux/ww_mutex.h>
 
-static DEFINE_WW_CLASS(ww_class);
+static DEFINE_WD_CLASS(ww_class);
 struct workqueue_struct *wq;
 
 struct test_mutex {
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index b5c1293ce147..1e1bbf171eca 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -29,7 +29,7 @@
  */
 static unsigned int debug_locks_verbose;
 
-static DEFINE_WW_CLASS(ww_lockdep);
+static DEFINE_WD_CLASS(ww_lockdep);
 
 static int __init setup_debug_locks_verbose(char *str)
 {
-- 
2.14.3

