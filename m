Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970044AbeEXNw5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:52:57 -0400
Received: from mail-ve1eur01on0124.outbound.protection.outlook.com ([104.47.1.124]:65072
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966066AbeEXNww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:52:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        John Sperbeck <jsperbeck@google.com>
Subject: [PATCH v3 0/2] Re: Problem: lockdep warning with nested instances of i2c-mux
Date: Thu, 24 May 2018 15:52:38 +0200
Message-Id: <20180524135240.10881-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
References: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:7:66::22) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:cbQ7wQnSPv3AEvjhSl61PuDbcO9J47jtZT20VhE3s14ch4J5dvyD5mNKgBO5xUNsKMeM3jtso4DrJyBN6RfjLZ1DpAc392dtMDDx4UFfjR83nvz2yvBse58+tp28rzMK/aVliQTB2SnFO+C/wSQUluxHMFq3PCavh5ATjImuYiwwiUzJEXescvMqbVHILEozwYR8yAIxasGWnHhYtWUNrv/2KCUMjMJXon1WtgF8DP/xE5vL3jPuz+A++ISgJAd2;25:TzuCg9uJCtBZiqLoTY2D4u4fTzdDcoSrlRKaBYE/C8FzmjBRlbkTjboWGYDtY79PyWSGXzf/TmjSN3bO+uoggxoUyMlVQohAGMp6HMos4OAWMLO2QiC0RSiKAGorVsDkZ1mu2yTNmZ8BNdTOE8rBrML3MYYR65WpC3cuifR8gcqH8YH5ortHkwIwLZloaxbyv2mIIgjFIrJwdt2ffrER1CRqps3uWtnGn1kCgafjDnt4qY1bjNojTZAg1135T08kVhhQ/Wx4bt10EAyMapJRH1uRs8QQEqrGT3BM6mJpN0J0iRCDz0JYFkC5fE26+w0AJrzfwob1+cRr4aRRYLBSgw==;31:+saelU4QHGIj6u4ESBvjt6xDtzrQo25SiXyD8VoKEeMmGTMlojsTmbUfPHYRFo55389EL1weGVakzFOhPAHi1Y/oaJeoMEh689thr4ceA32t9dqIxomrzdJSPcWdxvczO4sZDS/r9IJiOU3APy3PkWB3IACZtauzKi9GDct60u+gZxCOTB8RYVCeRHp2Ftr7LFOeVLu0KaQIQKrZWRz8wOR7e0Mv/Hm1PwNgZ3posRw=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278206B23AEC5EF657B764B6BC6A0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:z/GZIO/6Ztgg4+yuZ8RPS0Im5GNICCwxlKbzRtTyiZBka8JK8ni7XBP6lliWau0xRPN9OTZhYY/AYSZLXACGFjgD3jpScEy8H4Hnv64X/8MUSJaVLGtVU9ieQxywX0RXllBy8GcF9IxD/0qpXTzt51PFu3YVHsXdkLStlQJ7L9mEFPHAO6sYGZRAjYyu9sQoc6QFkOYvADu/Hi8xSzNb/X2xOOzqZPer9IgCzhhfYPeSwvJFK6EMSXugXwiOvEcfV+GJPnaMBwgJqJuQtWvTyA==
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39830400003)(396003)(39380400002)(376002)(189003)(199004)(25786009)(8676002)(8936002)(305945005)(7416002)(86362001)(7736002)(16586007)(6486002)(76176011)(59450400001)(52116002)(51416003)(2361001)(26005)(81156014)(186003)(16526019)(105586002)(316002)(6506007)(386003)(81166006)(54906003)(106356001)(48376002)(50466002)(2351001)(47776003)(50226002)(66066001)(74482002)(966005)(6116002)(68736007)(478600001)(956004)(486006)(97736004)(476003)(3846002)(6512007)(446003)(11346002)(4326008)(1076002)(6306002)(2616005)(36756003)(6916009)(2906002)(53936002)(6666003)(5660300001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:HwFvFA/2U3qHTaA2shpGIryj5MFbaysDQFMxNBh?=
 =?us-ascii?Q?s9zDPz6vfV86r31ejtMFj8HCHhpMCtfqYQFEBvWKMnQOlWQ+wnIH+sjYOlm0?=
 =?us-ascii?Q?RGO/KdTeSjT3zoHd4J7QY2fs/TFGyaVPiYfzXNERnmiMVE5VD18VciOM5vwS?=
 =?us-ascii?Q?yZc7rmWjyYC9SSzCyw6ALfYDdnKgQmI5Fr0ZXhk+8FPKsHzMedtHqVksLoq8?=
 =?us-ascii?Q?n5ok8tkyj148e7Tao4chu1ffey1OC3X3HMdGcE4bEYLmtV9D7ay/R98djBZ7?=
 =?us-ascii?Q?tCGuA80MHhX2/n9d7GdecdCcMR/7dgPZpv5y/9PNpo6oLFqU/T+xRIClwe73?=
 =?us-ascii?Q?+Djh0eyZ6D53a6A0dmyULyrcsUwYF3JXoBubWRAh8ULKtS1ziMHC7kLv6qCq?=
 =?us-ascii?Q?RNeX48HcjefbSbrWHu9fgmHz4naHK1x3+xQFfM5zMUgKV501+KlxJomUT03r?=
 =?us-ascii?Q?/NGHO2dpl9vHbsPYeoAsIhgUx0Qa+b9l6nyb5VNJtquWLBT4nVG4YRobQg5b?=
 =?us-ascii?Q?rbmKGfeQuyF2Bht41LxU2ymlYL5OFZbOSFyqqWnzQy0vOKdxEGWLDdUUyYDq?=
 =?us-ascii?Q?g+FMi8+RE5AObXX8edLH1nN/WrpaXAniMXtJFRaNYeifLCB9wf0e66+BXy4G?=
 =?us-ascii?Q?7sGau+Od6RJgBf9PYHGqy1X3HqhF0vJHR2W527xdD+DXzc8WXiEHZfAQRYjr?=
 =?us-ascii?Q?ZrnjSmjtnV7qLD5g3WNARfomLNYB6vgJbFGFrKxiipo5hMQPvIWvgC2/bHKo?=
 =?us-ascii?Q?Jdoqx09iIu8R+n43ZAIclWeFAN4tX193kqdcoO1Jhkyk18mMxRTQAV8b9VBO?=
 =?us-ascii?Q?YroCXEOYWrwP5P1IH/I28t1r1vgu1tDeulsj9sTQ4wGSPHz3IrBO/bFieNkk?=
 =?us-ascii?Q?5Ht/oRHysGLKelGTNfopXEMTJh6TkkW8iUYCJBHW7y4fl8gHly8OHxkY7NBt?=
 =?us-ascii?Q?kEBfPS0ZFc+pm2s+qh7OHuGf1Wq7TkeCZj8dMjyFNTFRBM/fSoYDl6egAwsJ?=
 =?us-ascii?Q?skvtpv90ZqYqh/FFAub4D81Witu1HKfAU0MrbUv7ChtF132riQkbV09yftSM?=
 =?us-ascii?Q?bkRhul9U13VdUSQ2Ag+C8QgJU2ZWugf3F8ljQ6+nMiE9gSNWm/PVUGpgaoYr?=
 =?us-ascii?Q?ANfZ+M7rPDh85Efz0nSd1CbTlqR7QYhfJ25IYR33PdWWrppnIbZaVt43U03H?=
 =?us-ascii?Q?1XY3nb83W2jgMxWl0LYZOL89vLCSrA+ZoTGtCaHfmo2/WPf2VHBfSCvX43qa?=
 =?us-ascii?Q?7Fu+boUz19f91wvEnFlUHU3DR8vQz9+OPIChGUHC600D0ytqHQCRoO8BWfjf?=
 =?us-ascii?Q?3Cx2Krvmw07DhnGBnQqeHZRe+xYD/Vx8lclvamGj+pVcA5Kg86O+0zIQLnx2?=
 =?us-ascii?Q?QsOOTsHWlLW0fXF8Mygo3bY0QfZ0=3D?=
X-Microsoft-Antispam-Message-Info: DISFPAzfJ2Tn5o1VDE2F+VTlfbiREfeSYciaa+7b0D2QvhU7xDUqyiVixLc6SwWw0rdhbN6h0tznqVI32TsPpFfaKA3Ud9PzC8TW76CZrI4UDYF/pIuteeQSwu1SQg6pXtozm2BV49Bmit877I1vfWAmxR6QRrRLWHWWl8r7BzuJ+3Nm9A1TQLpx22/ctjKq
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:i9tzjlKsWKZrqu302+SJhC+Pdw2R9wwmRATawLcNdErKjmjVovdYAtTH7hxNFgWHnDBCbAHaYo60YZdZqIfJjezw9UjdSSUeWrWOHqncp2YBxu5RSt+D0sakB4dClVW7L3eH7QkRIcv8y+jDJtaQnbR0WsFj1IY8GbfLt3OWeRXPNu/cRtboVzsBFLKjOmRD1cmaFJrtGzHtjogO/ahDM1SWe0pImxheIC3qsywSd8YyxzZS0ZCiuqJdiifO2z36EvP0HNEECVs7qzWxoWv4UUZhxMojact1YNCBwIlHMY6wYZgArUi2e935YR/6FHiDGHc0ZYRT+kkM9LoBZp5i1iL3LKa33tSOEoHhQSAJRYmaDvh6fwAgZvqvqMcUaiq2bFk7sS0IY28EWmH2nRVJjGZq+7l7UAIKn/h5D8KRJNwUEJji+cIHaxURcdp7EYGkWIsZvQX82Ow8BPtWQhFSeA==;5:1hAzfyLWbDIiWp15vTK8t7u4COp3hJD7/Mq0Y1gRALw+UyvPm2CUMCnLTiD9nvnUgVARlpdd4ycfn5P3oES9dQRP1NNtkIwLxLPwEzZbSJ3I3dFAaNpUXHmRSb/KaR44wfU11sLURB1Q4PX9Ju8qwF82Qs1ZuirKpeRA85cKDoU=;24:jG7ihEWG2Mp/2HTBy8Ti8AuB3ksLV5Sm6X6VvU6JqmyVhqFNYRv/1j/pc5qZWQaB1WDHb8BP5dc79ilpPznO82bcf7p+zAz/tLeVc8+941U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:xzT/wTjIo5WhY9BCASpKSePRDRVGcLfyySV5epn3asZdtdymiLYTYbMof1wL3zJ/XoeJ8zwp0VNdl0uzV7kH/LjkU4c4m0MTxBN3w16sO+D8qMM5tCsw34VXlSXkP5BnPCho51/cM8TAdgtomYe5h/WfEZBAiEX2JHWosKoC/2fMU6dzdZ8OH2MM6kP/+gu2s1cCNmDQjHBc8zqyxVw0Ep8tQO8w5nYPoGQR6N18JJN7IxvcjZmVrSX2rTsbrB5Y
X-MS-Office365-Filtering-Correlation-Id: 11e85cca-3939-4a0a-ff20-08d5c17da382
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 13:52:49.1293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e85cca-3939-4a0a-ff20-08d5c17da382
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sorry for spamming. At least I'm finding these embarrassing f$&%ups
myself, not that it helps all that much, but...

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
