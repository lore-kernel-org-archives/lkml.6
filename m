Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965508AbeEXIrJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:47:09 -0400
Received: from mail-ve1eur01on0139.outbound.protection.outlook.com ([104.47.1.139]:43760
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965114AbeEXIrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:47:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-i2c@vger.kernel.org,
        Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        John Sperbeck <jsperbeck@google.com>
Subject: [PATCH v2 0/2] Re: Problem: lockdep warning with nested instances of i2c-mux
Date: Thu, 24 May 2018 10:46:44 +0200
Message-Id: <20180524084646.31697-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
References: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0402CA0019.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::29) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:2tb6JDGvWPbnQVy9ac+tVQn8/XFps27ycIwonWxBWA5XN3NVyP6CRkeI5bWiZEMiF+CtkYwyA1AH6A1DkjLWuAftfuXVf36Vm5tR63PdOjSMkmWYvTsvxlAkvPdAfHlGTBYb5s0ZQad+ZUBigg3lNNpzQNDiGlXvtJe2ddOIRQ7jOUruqmF3kJGjTslDfLgN/X7diWu8RMjruhzHRH5KMUjjEiXm/OX8+avKOiLHwxQgfRe9SFp0290nRULSgZ8E;25:QHhFw8MZ3r9n/HyilEaZoqQvhBc7m0ql+qzT92dhUhAsaO/mZVKaqiUbdjvyMPX/i0BT+EuoYy69Yi7JvIEg9P+teg6ye3eyecIdFwNPKutqQPj8u9KyBxKa0E5UqTer1is9ie8iL/Yw342OtETtt3E8gk4WtvwgHxnzw9xfxbLDX39EHda5SBmmgtJXsgVWuRXsqUSaUwYuPzr+nypHbbgl488H/8tvPbcYzccmJ2tOBo28iHOFl3+UUkfosY5DJpeoggMptnDEmfZLfl5jUsA0sPKVimpYBvIDxhYjGbIQDIlS1MPMAUPAbp9DqOwupkrkTbQQT5pv1zsGID9IyQ==;31:+ZB2q2b9JTx/kNaTNJZehfaZHhVdOpV8vT1CAstyIOPIfXYZX7vP4B9drHJUHp8ZCEy1LwvpmxRn4kYumoEVIuTIPfZ10SC3PbvXINccxDmcSDoIZOLtjhb/qZzslmh0vHu63RIWYZvUHRsxvjL5qWZcQHgyunGbICWn/SMpXg3QR8n0BfLR6zI8SfD2/f01GU9QDIc+E13cJgVCdR1OTAggZW9t3ftMIz5mI6Sjpv0=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779A28425C7EECDEB6D5374BC6A0@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:E+iqngscNlz7xhTACF4p04hMvAAjEwI7ndm+ak2Y9yey6ONYtbowRPDSyFJsZDn5XgWxD5zZFTXR3SGkTJdpqzsYg9s/GNuN/pQHOGyHqytc8mwO7Jvmd6zyBmPLyIHMbH9v7PPLJk2kYhG6NChmu5vAeX/DXYCgCLcW4pK1SDCkAZ+Mn8WFYAhuF1t19F7dCu0BvdQZH/stKi46xoUPkkxTmuJruaXwGckSoBGjJdzINSw5MmX9D6+JbYKsD0uU8sDidyJbZQiptrg9GYqx+Q==
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39830400003)(376002)(346002)(51914003)(189003)(199004)(74482002)(52116002)(25786009)(6916009)(50226002)(8936002)(6506007)(386003)(478600001)(51416003)(2351001)(2361001)(7736002)(5660300001)(476003)(6486002)(97736004)(6512007)(305945005)(76176011)(6666003)(53936002)(86362001)(54906003)(486006)(59450400001)(316002)(2616005)(81156014)(81166006)(11346002)(4326008)(956004)(8676002)(3846002)(48376002)(66066001)(68736007)(7416002)(50466002)(36756003)(16586007)(6116002)(106356001)(16526019)(105586002)(1076002)(186003)(26005)(446003)(2906002)(47776003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:PA4dVJKNlL83dxWFQnJ/dF14vuCqFhzairozktI?=
 =?us-ascii?Q?qFhpRNmDdrwedE29cYjb7oyJ7H+Zyw9CWSaRdiiAiBzuxrE5fBap6+XC/hs+?=
 =?us-ascii?Q?wkqihnmNgiGQPsfYe4FgCFcx2sh99rbb9879Hrds0MI8ddRuLjapAH4I1m4e?=
 =?us-ascii?Q?yLGoITMr1nIlacwU2QrBDQ6RfnVbQoed/zAS94fRa4eElXKL4hqyHrBOw1Rx?=
 =?us-ascii?Q?otw2zhmoKn+Z0y24vcdc3i9jJh+cLR4GQMy0E7HfttAqRANZq/Vm8vrply1x?=
 =?us-ascii?Q?LB6HrHqkM3oKkKdIlW3q5TuN2hBljat7utHe8NpnqNDB2GPjmCj0UsHURBy5?=
 =?us-ascii?Q?vNJkt2s/7ux0bXLfYZv2w2nqy01UIWiYcj+9WsE6z6avB8Kh0E7GS7Miumgm?=
 =?us-ascii?Q?iVeH9ovR1mlmlJzqDY/6dtsOnJZytq0bJhJv17NluviOXLH9RmYa+6U/foTM?=
 =?us-ascii?Q?+WsELPGhzqU9ZcL4dkyaunOH8TO+r4HAv+evwBcz9qpU4hQCqQ6foF7Bb/WP?=
 =?us-ascii?Q?MYvrqQckdhMg+TA8N/AF6/PD7whceVpiDqX7/tkXwiAtCl6SORZxlH2jj9hQ?=
 =?us-ascii?Q?arZPPVLyRDRHGjht9xtXeFRK1qcmpij2+rbiHMW29gm7fKHCMeYDYvIF3DBw?=
 =?us-ascii?Q?NDAB/WjsYudmyE+vYUgG4+yycCYXpC/6DCClGDXthqRkpPneQiXIIaKLGWlb?=
 =?us-ascii?Q?iTLUZXi8UcEoy0c0b1RVjJFOLSz++DS43LYNhaz60zZ71acPdtceXQv2Lr1Y?=
 =?us-ascii?Q?4LS/D3JItXMwpX5pntzpQEmgdbiNDqBnS0WlE7qo3Rs6xjo8zhSZEP1rlG9M?=
 =?us-ascii?Q?hlKgTfI9pQ1l4zyn+cDa5yAuywtIQbpyJpskrfr8SPEyDpISKmGJMcpNHWUQ?=
 =?us-ascii?Q?51FdWHdENi7pLfnv5cE5Oi34hVH0p45rR1RyACx7L5Q8J0hPbJVTkSba0npP?=
 =?us-ascii?Q?W1GkUIh7yB90GH4gfHCa31duLaBSV6B8oc4g7Tx6vQCh8zWraJq8BgeLMe2z?=
 =?us-ascii?Q?G/W+kEPYSvSakThxnDWSASGOL7L/vKm7Cb+GBXfICn3Id3uj2vDvJ86vZJW3?=
 =?us-ascii?Q?UTwBATH7uw/lIA6gueq5pINbPElgrbCzKF2cNtFFzkkk3eIDBw5g66G8Jv7j?=
 =?us-ascii?Q?C8qh5Ly9gTOY6xZ8p+sn0ReJF4j1pfn6Uf61qIpTcjz5Sm6kPcfjWaxvZ3Z6?=
 =?us-ascii?Q?TG/e9zKkjbNHegjB2XTFSqtsWCBuLFClKrmkDhTbd2TFxQALkoHEo7JQEv4W?=
 =?us-ascii?Q?YpfpES3hS9getcxGy7Crk6gHKEebat+ha8ndA9QiIsBj1W9r+6soiJ4CMxTF?=
 =?us-ascii?Q?T1a9Ky6YU5f0gPdlnw0w1YJr9qfedAiXnonLcwG0XT4GyVzQ3P4pHYdza9IH?=
 =?us-ascii?Q?MqEa8bA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 8lztHzffGJM89TBh1Btqm7b9JpRgy7YFtS2n/HS2qct1LKBjD7P3bdmAszkrn5lsjKcnVCN309p6MckB7nBhvUHQflIyiQhY6VRJJTg+pWtZ7L5saVKRuA51M6J9HuPut4pZtszAnZyASXkvw7Qjrx+5gIVp9zXEyJr2HYGfHBegv87uEk4ytekB3HlwN3G7
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:rA14n2lw6EARhG7eeiHLukGT2EsSGPRVsSXNsdQI2GG7xF1mODR8eI+vrK2b7iVA4AhtKN6XdEbpXRvHx3QwOp64czRmn7UW/IfTHMvfv6czUGS6RV4mxDCF8uFK2hvzoWEOS3h4yCFkCDalMCh14idELbYg3P3N2kBesnTXe6E3TmULMTWVlHgUaQRtvZ7bya85U6E846ez4l7UpNe2Q6uhsiqt7z1Yf9AFsULcy6hTgDHuNUn0zO1N3A+1LLy9Tdn6lrwXaIJ8Lvo0yxsGPitgzv2vQbgyPQyeyHGGo3RlAvP69JvCZgNBz49cB5xhQUlniQ6RQ6ZhxfXxTQXm3SSJLT/1GcCdrLuEEBM0iMILBDn7dKvU6euUOB63gLj0yVw4NltUL4Ajumo1FHilViI+N7DOTkwBMwD/8aha/WVHpQwNxOSzzBBdrzae83RaKSU7uObIqkPvpc5/mDDtKA==;5:2IDIiZlhFsDxo03ov9brndrhQkftuIr1jD31qOOiolTFYSbQu+yFkvV3wpUfCX35q4wY2uScBJncFSlWoSRgf+udhqabWtqH2mkHQAdtjgnla9fSb0lKFjAL6d0R11Qtg+Mpz4MAqzmZGbDs7O6JcUWEbkMaI4bryWSIwC5vIsg=;24:8UCwcxSJTplza08AJB8jX8D4Bmu5Bo4fMsNxCK1k+dVBqQaeSpn/NsxD/QzorkIVY+nW6SxrZqc1PciHKBSDTbS24JqlJ4aGHtuvwgq9FrQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:nRg1NICuiqe4rs3iu/1L2LFkPmQgQts0Gm1mEoY6lbhTF5D6YjQXIAB5euith13/sAqkHfICeUFMBxgB5afMQaX5F3p2xFs30Da2GxsxxWtQKiWPxxUfCsw3rqgQ5nUKT6Xh4/UXQx30+k+uF9Fe4snDtTdsNpTrhfGt2k8hM5gzxKqMk+kj+OGY77Ufm4JguKNNkxwQl7oWgZLBv2Q8Jwe+F8QU1aHg0RVE5Ra95vEPXDhncvhIKZN3S/+UwJNb
X-MS-Office365-Filtering-Correlation-Id: 6bb20486-0737-48b3-2180-08d5c152eada
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 08:47:01.0998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb20486-0737-48b3-2180-08d5c152eada
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
- Further compile tests indicated a missing #define for rt_mutex_lock
  with lockdep enabled, so that one is added.
- I have verified that I don't get any lockdep splat for a local i2c-mux
  setup with these patches applied, and that I do without them.

Again, thanks for the report!

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
