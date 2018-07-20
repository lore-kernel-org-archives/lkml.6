Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7F9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24925206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="aAyMI2Xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24925206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeGTJ0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:26:45 -0400
Received: from mail-eopbgr30122.outbound.protection.outlook.com ([40.107.3.122]:1245
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727331AbeGTJ0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U58SokJTD3JR9OW+PgQgtnPZvNZmHcpmE/pRzpDrBUo=;
 b=aAyMI2XvTE2p0M/vwl+78KryEvHS1P5YwofkPsLisUdxOPRYMpBvDD8AUD5hf4f4UWiAtZfXwJ8zjUndWm/0K9LNWvx8CEcWuhf/J+0WQ+ncgTbECNR+wcRFD2mEQbTgxLpD1p2aXy1zxhVoyB8GSb4akCMDcWT3jS7q0zt7cEE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2459.eurprd02.prod.outlook.com (2603:10a6:3:82::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Fri, 20 Jul 2018 08:39:26 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        John Sperbeck <jsperbeck@google.com>
Subject: [PATCH v4 0/2] Fix lockdep warning with nested instances of i2c-mux
Date:   Fri, 20 Jul 2018 10:39:12 +0200
Message-Id: <20180720083914.1950-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0402CA0010.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::20) To HE1PR0201MB2459.eurprd02.prod.outlook.com
 (2603:10a6:3:82::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 754345e5-76b8-451f-4090-08d5ee1c4d92
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;3:pomueAztHK6wXhG6QYsseNvWdW8+f897A5/k9KBvH4drLC1n4jxIqUkae+hxIFheI4G/qRZLXI3ECqfrxLOG0sBqdY1sEmY39IXG4fpA/HmefUDnk4BHGUF0cZbWu1j1PbqMwissv9d7+upF7X/HE62jynFMD3USpUbJR/LeXUTX7reqfP60E+wpuF9Yl0MTC8ibzIUxW8yoYeRTMkeQ6Zc5LO9Ps6JWeI/R0z7bsRZMSE3SYMLgB+VJN24RP3XN;25:9cMqmUZecxIkugcsf54hxhI6e+cRGnyCKrFVtNjmzNs5RyFUH6P25oMLkzg/DOE9NBJWd3yZbI5HxywHEWOoZ4RR2p3n6XhHDxgQpIhUtar3o9doCJ/3R3BkChDzITl/5RAdR4p7zjdNJF8WfcdZJH1DE5WPWVF4zqhngEyjyFjx/s4GRa5k3OgD9o+bI1L7PxxEcBiJnSZ2ch809GQPMhPk620WNv8zNY2LV+ASxvjd949avApRinR9HzxBCPSThHmO1wg+73WPxkDTQWI2lt7ZiqloQcxWXJk+09uDXmAFW5uwkBgkoPmjM2/jHeLUT74Fhm+jN8u76mHJA9NeTQ==;31:Qo0CJuhrCGKxAeWJvja9k1pMjlxcNf5cm3vwKmKFOTNwAiWttolcOs5Ig+Qlt/eZsqQmbfYi7uqlWBixxmTbJvXeMUeLHd3ZxGhUK2sVA2uqzXte9mI9YER50ZvEQdRHf9HyNS1l1cJz/EiYyGVknup+THYgvNEFyHo9x/yC2eTSVZQGQ6WFtIoBSfnwMan0XpKubp6YpHHf4GFyCNKvQFK54UNTc8eK6DFIvZk8g8Y=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2459:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2459B54C6C1AD81639738F4FBC510@HE1PR0201MB2459.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0201MB2459;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;4:+z1F2GabHeLPg1jlDYQ8ahS3ngqB2pRmo/bpbnGZSIkBtiaNz8eAw7hwWI/bQYoVCgYl1mXG1fpGjdOL5UUvFaRfniMcGCmjNAFC6jHQ2F3MEzWflK9JEg5ZG/oBa8VY0EsaQzIuQ0Q8gwslczSEFTw6mQbBEC7Ay9+mVHC09v/nFuXZl3ylBtrukSUSV7VmRl69D9N/0mdpO9SILZy/cjSK1Lixj3ZKy9gGCWWVoTqzAy/FMZfolABnErb5Gd/Wq1rGs3jUx6Pt7UDZfoWylA==
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39830400003)(346002)(366004)(376002)(199004)(189003)(36756003)(6486002)(47776003)(6512007)(6306002)(478600001)(66066001)(4326008)(7736002)(14444005)(26005)(305945005)(486006)(476003)(25786009)(956004)(2616005)(50226002)(316002)(74482002)(52116002)(51416003)(86362001)(54906003)(16586007)(2351001)(106356001)(6916009)(6666003)(105586002)(97736004)(6506007)(966005)(386003)(68736007)(7416002)(5660300001)(16526019)(81166006)(8936002)(81156014)(186003)(53936002)(2906002)(48376002)(3846002)(50466002)(1076002)(2361001)(6116002)(8676002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2459;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2459;23:he2T9BzMQtvvSerMhdp//MWSLW5ruAPiNKJIurt?=
 =?us-ascii?Q?g+o1PBLR1JYlniaasX/MLnZBdY3XfZ29hQcOj/owQfWu3HREmGIm9NOmQqOr?=
 =?us-ascii?Q?/TtBBWUkhQsjh+gwpqKvjBtbXe5G+ZqrcIdfM63nGz+HCPDasciF7TGlcbIU?=
 =?us-ascii?Q?OsCfTUIH735O4pXAm/472gf4mRVoEFaEMZA1SKZfqmpDAq7w0P7Ikp4R5uFT?=
 =?us-ascii?Q?t5QRzlTrPUdXsbdBDYuC+ARcxL7/A9w/HpczLB6lt8vSx0chSUS0RX1yTdR2?=
 =?us-ascii?Q?VGsI4qyRayVR6o0fhkzW4RMr9pm9tNAKaIvw0GcZ66yJDJAcXuVfdgM5lUem?=
 =?us-ascii?Q?aAenXscKidOOGzJCzbT1m1bElRWfl8ROWZL1bxYD0ztqcJuF2OiHz1HpVLUd?=
 =?us-ascii?Q?bfhPXb+eXWF6sLoizmd5HFXtMOqvYuRKGJLn5iV9VsrNQCpCQm7sCDx/DY69?=
 =?us-ascii?Q?e8fkPWeMKjyHaBBwFOLnXjMubd7ApruJWl1MYxJLWWYHnsLYKwZGDoUeTpzh?=
 =?us-ascii?Q?j21dpjxjIgv3u31a1k5p+bBwq5QCKTnmE4h0nV53uX2CpoaWRKr13HdULG6N?=
 =?us-ascii?Q?w5u0/OjJIZ2PkPN0L0pA9W8CWC+u8TcVuK8PsiN/+hCdCEF9LnDbxEhwJ158?=
 =?us-ascii?Q?Q8tjHGZdYumVydqadgX/ljeuJu6WGWkM1YVQfbrGtjdKRrhxn74cddXyg7ty?=
 =?us-ascii?Q?sx8bPNpYanoksCoFXBZoUT77/bvE3aO0YmIjN8m+nKnnamW2WjpNOmR8v3WR?=
 =?us-ascii?Q?RuZGH+KxyBoLKsTTjDiJIPdOeWUoL5RDiOGFrYeubKFis3IZ11TXtboUMg4C?=
 =?us-ascii?Q?c3i0yog00Tpeo38wQIT9Gx1Zzdb1gmR962nNNxZs5EpHiR0B740DQA+NrwLv?=
 =?us-ascii?Q?rG8jN0G+csNpoKlCxwLcVZZOSuxo0nXA1KPNXdzUVtfdIV7UUSHVAaO/XNaC?=
 =?us-ascii?Q?VcXRCiDhXvPmenErPQx5pCpR3PGpqfHuWqC+xbj3joisZNbwxoYJnbGqVCah?=
 =?us-ascii?Q?2Bl8Cs+rrqKNaqhYJy76K+Igg13N6mKEYBXnuk+EepUGVqzGqZFfzHUfOhlK?=
 =?us-ascii?Q?zUCU6hXZndIOiIGTfWb6KG4HETzVdTkVMg2kB+lkQkro0S9Z+bLilk12l4BM?=
 =?us-ascii?Q?xYzdDGAGYk7Hy55ne3I9YDc/xXUbgBEJuy0agwbWmy5DaFSqibddXuKHP3qx?=
 =?us-ascii?Q?O8zMq10hTf5i2yRLfuMy/1phdPcO35YpLcQfclJyL9BixotawY8uKXGVRusN?=
 =?us-ascii?Q?1MYkSaqMH9hacs+18mTd0RrxFOuweDLslqdyNDuXgsGbNPG5CTIi721u+nlN?=
 =?us-ascii?Q?DG/B0k56A532Q0GtQjvqzCH0=3D?=
X-Microsoft-Antispam-Message-Info: ParenIl4KimngzxWHdRvyiW8fb22HvVfKPM8k9E8DhcKnSFDN6t0RMIY6xRweXNhF66x4Xf2DRru3AtQb6ugvpLWp1vTwlql3xn54QGlwIQiaSEpaPBK851KDaOHq3YUjYH1vA05fdF7ize5wz1Zk9O/TtCfwnywowF58XZzxv8ZSj5/9xWFWLdXlVUKQAayeCinIHoBnPcWYPzl4WoMf+De2U4J6N39+eAticPOkpaSoVAQflUb96rM6C2t+DP2JB5rkbK1HpfbS5dgd6+xnSIJy0idkTA6p8Xpcu7IVs9/7mo3FIshnH+374Pvh+9Gr84n8mrczqht8mYExgmSYXQer6vnXmijv7ED7blyy9Q=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;6:K6iyqAOJS5v4VQ2xxN/lBHXvkkuaChevyRBu8COvsgGdgNCnDhigSnYRCPNC0mDNFqVpQ4m9mkWY/OsClmVoiUCH4U0A4bE57WpYARLAjlFK57B48FxT1/XjW1pBAE4JTL2t9pq7H8V6D7FnGg4L1esJaPSTNfZiezKYNZ1zcvvVlMrJ8d3BaYaPnbj6c0ypJtqLhchjajEUiyCaW7AoC2LcW5VQPlrm/mhEX84y7HIATDpCBGGJzjrkXsKW8o/hIgzKyPpLhgqlDq/pghhl58ko9uJydFRXqDq7k+pwjUJNAMxFA6ayCz8tO30YbZtsiFcendM53AI9kdbuw2EXTALApDaDO/2ok0uHxlyoCEA49uFULELuoSQIWcim+Ma6T2DswqfEBK5KwkxLtwyTYInje8P34SuQcLaMEU6QLs2KR2oe+EYHgQjwXaNzCe3SyAg8tVCelnXFoEtGglo0Ug==;5:nUUuwTv/9lHACzj6FSkBoWrWQ5aG6NC6YxRQBd7WITTV+cZZaFtdVdgMHAnKsn758RZInURMptwEH4tZUPHQfRYqzMc0AGr0U98bxl+vlvry/yDQeV+gYGQLDuTEjK/UVMk/9Yk0QBcbLHTzkk9MMvuNXNPZfqjdEj3bI4sDaF4=;7:3Y9ftf+E8W6971b4oqUB8y5dcEKpVj64e4xnfmIBdPh9MvGA4nB5MeCdRfgnjCnv4Gys04wKwsPUzQf7W+ZWDqdWXDD0cpZ5sZAnHy9FuiiU8Zy788W4OhGRnHeS2pnV9R/M7r3f90r4AGFbsO4EO02lxoYoq7Bf/8v7jCgWl/vsqyP+seyZ5wnRU9xtZk4ccAzvegpl6yy7sY5nxh0EGQmQltUZqJf4TikjEKvhXojGqktMIZizTHj5bFq3+65o
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 08:39:26.7265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 754345e5-76b8-451f-4090-08d5ee1c4d92
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Ping. This is almost a resend of v3, but I added tested-by tags from
John and unwrapped a line in the commit message, so it's a v4.

How is this going to find its way to Linus? I can move this through
the i2c-mux tree, but I obviously need a tag for patch 1/2 for that...

Cheers,
Peter

Changes since v3    https://lkml.org/lkml/2018/5/24/994
- Added Tested-by tags from John.
- Unwrapped commit message for patch 2/2.

Changes since v2    https://lkml.org/lkml/2018/5/24/176
- EXPORT_SYMBOL_GPL(rt_mutex_lock_nested) is more appropriate (the
  rt_ prefix was missing).

Changes since v1    https://lkml.org/lkml/2018/5/24/93
- Further compile tests indicated a missing #define for rt_mutex_lock
  with lockdep enabled, so that one is added.
- I have verified that I don't get any lockdep splat for a local i2c-mux
  setup with these patches applied, and that I do without them.

Cheers,
Peter

Peter Rosin (2):
  rtmutex: allow specifying a subclass for nested locking
  i2c: mux: annotate the nested rt_mutex usage

 drivers/i2c/i2c-core-base.c |  2 +-
 drivers/i2c/i2c-mux.c       |  4 ++--
 include/linux/rtmutex.h     |  7 +++++++
 kernel/locking/rtmutex.c    | 29 +++++++++++++++++++++++++----
 4 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.11.0

