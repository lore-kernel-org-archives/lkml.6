Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CBEB8C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64239208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="o+NmrneE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64239208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754733AbeFNHam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:30:42 -0400
Received: from mail-eopbgr700051.outbound.protection.outlook.com ([40.107.70.51]:50400
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752759AbeFNHaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6bxfBsPCa9aIWfCn/yrTH5XNVL5HhxGurc+b3mllOY=;
 b=o+NmrneEXqyjE5Ral2DOMTmXunlQJPOYxIcIjKBjM/EUNg4tsafB7XNM6/eIMJmBlkSewGHFxBkKX1ePB5tnbpa1VswgjqGcgiIRM9S03CwARAFaYXeX0Qrik2FD5brodzCsQu08EqkIp8Qug7DWJh6s4qw1h8ItUiYmpt6FHJg=
Received: from localhost.localdomain (155.4.205.56) by
 BN7PR05MB4580.namprd05.prod.outlook.com (2603:10b6:406:f2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.13; Thu, 14 Jun 2018 07:30:31 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v2 1/2] locking: Implement an algorithm choice for Wound-Wait mutexes
Date:   Thu, 14 Jun 2018 09:29:21 +0200
Message-Id: <20180614072922.8114-2-thellstrom@vmware.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180614072922.8114-1-thellstrom@vmware.com>
References: <20180614072922.8114-1-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0701CA0081.eurprd07.prod.outlook.com
 (2603:10a6:3:64::25) To BN7PR05MB4580.namprd05.prod.outlook.com
 (2603:10b6:406:f2::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b19eb2c-473e-4244-9aa3-08d5d1c8b7b1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR05MB4580;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;3:9w3qZDzMbMYNiiRDNfBGPF2COl184jz2EljVWF0dRDSol5NfaRkItP89ik/eSfw41vbHvwYpu4BLlx69s0HQxIEpJFuPkEYEL4hp1dIXm8fRblIi6UmQWgy00B9M5MYSbHLLacwph3vuk4Vkjl8HxyAC/QcN0RyIr+vkUts3zdNScwkrL5ivXryFU0t8LzhYZBN8BEUPFZOrl61rgJIobySR0rgp4kzX4EbZm/R3Al+9FgQhdraNqa4PSFGlJKXi;25:8X436WOon4LinlMsqJqwPjXqAv0YJWUqKrZuPaifnKJkH/E0CPpf2+KHuyZQeWYTDhdHcEdh/tvNa9sS9U+ZqUl3y0ZeenyxO+09H6Tf59C+wIxpsyNlF2XcPj8hdBp+XzrfM8AKNQa5fj6UxWKFsIKAx2jHtujph6+tvwFZnsfpArz/6akM2w+2yTL0GWDlq8yMV4MfX9WUyMxzAcgcVylsR2n6RQX9jrzrnELs7WJHf9bpMRhZCd/CE98GbMT5xdC/NI26mLpReZp56R/Z2WNYFMm/p/RhadhGq4s6Byy2yeTDPp6G9iHrYMEMYJHFYebDCfmFMrzmAZH7e4wKeA==;31:iPos5SToGh2bqxfe39xvURgkYA5Is9AcNq1LxNKoyFgBfmmNBx+qcZ8QH3cgwyiDGpoRQMg3WDHRqbCDe1rcKQSLW0PQjpjBQ2bq1HS848ZZbHA1NqIIKBPYDC7flzMJFwLV8qwkHQouyjBRyevz23s8YGCzp1V0/WcZrkte7vRicAFMYV98MfBQdIRo/KHWujxv9QTqOM8wzbqHhU0B3ePn9VtADKMuG2eSkRjzIqA=
X-MS-TrafficTypeDiagnostic: BN7PR05MB4580:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;20:tGiA2x7kLhVYfdLx6LhPMV5ufuiR9n42Ko4aV3N6LaE2hr8qPRLu15gGMYEtConY7MGUqBmH0Dk0thKc0Ej5plPG4tciOzdKC+AT3oLYgr4IBNbZYFFYo22cgDzhASSiDkRF+ODAeN7+4Kv6SfadFzgESNsFvBB9H6ruK8EOeqAPwSaOLY+3Y6/PZlsF11HlkPJPc3uJW/622vlL6IYyUt+BvtepMsoDMWnw5tVfXQo/znZE+KX3aKzciI+Y3WVrEQt4I/i8qqcEsnDMppxV1m5aEo7stmYG7GtFEe6Grynoyz3ZdMdC81d+4oWy4CJAeoD3hCSFPoVF9jkghQUqK5y2vNYlY8TUod4HPCh3Gr4opC377sZQR4ttgChskG+LQ9SGLTR6L1bsA9qDigi/T4veS24uWjSPc2eBnVTCUuj6xju2MZOT/26g1/XS9O/YsZ1vO3cZ3WHP6zK/cu/CUMXdvC85jmBxinzKxBp1H9EzmTidYk8yXA0SXvvUL3Cg
X-Microsoft-Antispam-PRVS: <BN7PR05MB4580136885452EAB84F3753CA17D0@BN7PR05MB4580.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(9452136761055)(1553240931313)(104084551191319)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR05MB4580;BCL:0;PCL:0;RULEID:;SRVR:BN7PR05MB4580;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;4:X9R6FZS948BwFtb4PRdeu4lVD4DMcK9y+Q5+M3+kOHI2E48EU+23mcnwBdGZpomJ+Ul/KhyoADGk+yfbNFDSVHGPRDtV4JN7p4VG95QjsKiVEUXKwCowPE3QZXrxjA6KAOEhs2e3SwADwZNPprdLVlWzoKW5AKdSLbQY3muDqwvOdKaBv8UmP8BlpQ+yNJKKM0G+aFAAIhzIi9ieWjayGCnrk1EjIFG7lvz+zYgnij0GqS4rqWoXppNZYx00jmhubtyW5yHKpgemU3cZlD/L3E9OgGctXvGIw6rSc5c3qoJXORvT/y9Tis2dKlcyZEQHKjPU75JnxV07jowas0od+StgLd1g2Sj3W23w597Kr/C3xLe5Hm8kVsIO71V1TtuYFJkHqwIcdASpTSkZLT/CBzGE/NK8fHp6h+w4UnlT5RAQS/EXnCvoQyJZ7BzImjwy
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(199004)(189003)(6506007)(50226002)(2616005)(476003)(575784001)(551934003)(48376002)(11346002)(26005)(305945005)(105586002)(106356001)(54906003)(478600001)(51416003)(316002)(52116002)(16586007)(86362001)(486006)(6512007)(47776003)(8936002)(956004)(97736004)(59450400001)(50466002)(16526019)(7736002)(25786009)(186003)(386003)(446003)(5660300001)(53936002)(68736007)(6486002)(8676002)(2906002)(81156014)(81166006)(7416002)(3846002)(36756003)(6116002)(66066001)(6666003)(4326008)(1076002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR05MB4580;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR05MB4580;23:eyPZCmrKa22i43/sAOZLExEchXrJpJE31bBiOotOL?=
 =?us-ascii?Q?4e0I6ryYK+JUM/fMDLAwzEQhv1//Kpk8BqOpJV+cck6CA74rnQU3ZVoE5q10?=
 =?us-ascii?Q?LFpCIqVEEaqhss//lC9KoT1rkzbqmfJnihulmv9UYVZjI019RKrUCuZoECBS?=
 =?us-ascii?Q?90hlCYaYinJUhn/m1ApyufTfdTRg0qC5PumLcpEOIBadmf1XT/6eSAT+a65r?=
 =?us-ascii?Q?T/Kn6CeWBVNDH8aKBpsWi3PGedgY/Lwi6eHchgQdHILXH7gMVVgkmJQVtHhd?=
 =?us-ascii?Q?WtoVC/HOayHZfURO+2N57vetr3TAXg+ycCK40VB2fsTPwvMJ5RsRieMHKVbC?=
 =?us-ascii?Q?lJasFTgslAeJkYnnld4uSDCCiEV3cJBvTJNXFxB90jDOlzhyKozgh7i24kIP?=
 =?us-ascii?Q?yhva40k8Vs2sm7aWYKG3LzIqjAhxl3Jpm3LnBn1WiztAFtKSAyAdetLVgWwb?=
 =?us-ascii?Q?Zn4hUA+RuPqIQGqoLBGlA8tBGqt+ebHOmMiS3qctQgLnSS4hEmu2NgXDvI4N?=
 =?us-ascii?Q?Y+V1NRq3RUlRPA2snX0Gs6q/Qb0teL6WIlJ0B5PvLkZ6s3TCrHA/3+eZyvYK?=
 =?us-ascii?Q?9M5WjSSZg3h+tIXvC0wWy1gsDCqygWWKCyPlN/m0snMMsrJ/NPL0F2sTR0MW?=
 =?us-ascii?Q?e6icrjk3tJkJJ/noZ8yjhtSFb5AdAln+zvVGvwfr9jFnFG8qZ0wnNaUrz71o?=
 =?us-ascii?Q?kx/jxLYlgm6PZGxCIP/2aVUriFeHKbPkNBQBcDyTCDkDF6ErjoWvp+/f4Vlt?=
 =?us-ascii?Q?30HDT5eTPAEzbZFX4glqnEg4OZYSsyeJ1U32MmUwz4YOcgOzKWTg5rSHkUjV?=
 =?us-ascii?Q?vxeMuYF7OxzRIX44OIegjli/Y6W6rEyBsD+eVSeZdLB10laWOY1AUzi+SDL0?=
 =?us-ascii?Q?UQO1UC6hdX8rnVrSdHC9Pk9m3tYKNZSh3w7GnTVX7TMOkiviaIm8ti8xEuN9?=
 =?us-ascii?Q?KF9QZl4dUZKREbpdr1qO/PWM25q9obGyRkv3etcrrhB2gwgfNhxAYl2WbUD3?=
 =?us-ascii?Q?SiKSc9owZyYDO2O4k6TJUEnATqxTPGW01Q7XIwWbuE6S5co/Zdj6N+9jlpWF?=
 =?us-ascii?Q?fACgd0QtVMcyTzyh1fm/giVQo2nIPKPsgfCe/qgIq6iFg96+r7UV/V5ES9d6?=
 =?us-ascii?Q?3fH4uEQJwmmDb/bwoUhsVEDa89mroUUu52urygtg/3RK8zxDYo58KBI1B2xo?=
 =?us-ascii?Q?bGGt6K0njeGQbvcI28CYRFMuAIsStqf/xHJrrwjGX2W2erlxuNh4G8Tc85ic?=
 =?us-ascii?Q?QkaHmjmKsWInxIuGffc3eV3cbTrtcCMLi4TR0H7N7CUCxP+gmn5ymWLESmXr?=
 =?us-ascii?Q?09r1F++gMl5yf1Sq73/HwE=3D?=
X-Microsoft-Antispam-Message-Info: i35YNLKtC2X6BjllGCXV410D9xIrpkUpwEniZAMIjt6guF/toZS42NJzkWH8gY96VFU6LFhLuSORIsJYlArskhdI/T2BK9fpNMgirKWs4irw9O19Jv73qwyWuRdkXYwpKXovCKkDspbVKsqJKvP7ip0ImM9cq7BxpMPIzRMcOS/zlvBaPN6PHI5wSGbLNYiP
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;6:TmBR5OnvDOSNn0q8rPVlJaDAWu1D+mg5M8jrG9eE5KNq19dqvPnrby10DjVyvloY1J+pvbcucroMHNSfXLXhx6h8agaTb5zdAcG9kAVHGZSLs8fK+5+JZKzxNomt1FpCVH3F2vaOeEasN2wpaB3S2pdtaBouEMUNfcge6qYv004v4Y4hIbmrlkuuwIptBsOjw1k0btKlAj8ZMiLkgxwKLODtC8alxKUkQoyLsa8hWwi6Bmg7fz3jntW9J09XFtiIfXdzSvnXaYB7MFeaEmkJYfcg7+u5Va0aou6l4VnNEfFZbfXvBYhfMgZLryGXDeLq+yUnB3Sm4p/x6271h+tYmand5wXnZEXkbFaT6Y5zPxudo7uzIDfouvGArforbMls+iL24azoJXDDfNf8kWTj7RxNsMblYowEauLcaqvB29k+UHctj8XPzOfzbQ59ekew7z3wo8rMmyca9jBDsaT8kQ==;5:4zTx2IDx1RgbSpAdRqkeA91+KxfmuWw3mYeARllUuxNhNaZhYdci2F58gMDKcYxMf2nIhxxh6MHg6XYNDq61bWcMqmX09Lsaz7zeTAI3Dl6aPWpG3Jj4HtWZnHQE+qvqkUBs/CMPOCZGo3Uf6PuGWJ7TKpBfFE9D5jixs7yGNt4=;24:6kRokPgCTaHgtvj3+I1JRdAuIRKcoQzwoH7M+nN4FCwwYg9UYSgcNghXvZ0mdk43lKazvoQj58QDWsoqVu0Xw1xQDppjtGReXlaUtFXV7jo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;7:YVQuNhL16worukhYB3u8hV66M7/wyI1TifAmAMFVI47QdLHOXk3WL3IHwiAPwfTbMySROgu3KFwx0GwCnnKMs7AU7DQrXsYHWzUxcpcaccHGwUi0ttfBQ+btApbRB1nPjHDvNErcIeISuUO92wGCa0jJKu54mcGqRZsyARyMqMwm6C7HAXAL0KzPBfHAywpYq+QDF8Kt/pyQCfrnwkXdBkykIuDvIRbQC+am+xGZzLwHoImrxGW/fVQlI6dPYH9P;20:mjwcyP4sxuh1igNjez5tcupebOdjvU2uPiruizUa7ZzcuzfLHAZJqIg/6Rli8vaWGKLxDu+JYSeHNNLnfjnJU1nV6bHPoGThUcoRWlTWh254C4FjZzWzusMszI8woTlb24w9hH7byLkOF9/lC+pq7jk198XfIC/pKhHAcAGRal4=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 07:30:31.7636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b19eb2c-473e-4244-9aa3-08d5d1c8b7b1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4580
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
tag patch-18-06-14

Each thread runs 100000 batches of lock / unlock 800 ww mutexes randomly
chosen out of 100000. Four core Intel x86_64:

Algorithm    #threads       Rollbacks  time
Wound-Wait   4              ~100       ~17s.
Wait-Die     4              ~150000    ~19s.
Wound-Wait   16             ~360000    ~109s.
Wait-Die     16             ~450000    ~82s.

Cc: Peter Zijlstra <peterz@infradead.org>
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
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>

---
v2:
* Update API according to review comment by Greg Kroah-Hartman.
* Address review comments by Peter Zijlstra:
  - Avoid _Bool in composites
  - Fix typo
  - Use __mutex_owner() where applicable
  - Rely on built-in barriers for the main loop exit condition,
    struct ww_acquire_ctx::wounded. Update code comments.
  - Explain unlocked use of list_empty().
---
 Documentation/locking/ww-mutex-design.txt |  54 ++++++++++++----
 drivers/dma-buf/reservation.c             |   2 +-
 drivers/gpu/drm/drm_modeset_lock.c        |   2 +-
 include/linux/ww_mutex.h                  |  19 ++++--
 kernel/locking/locktorture.c              |   2 +-
 kernel/locking/mutex.c                    | 103 +++++++++++++++++++++++++++---
 kernel/locking/test-ww_mutex.c            |   2 +-
 lib/locking-selftest.c                    |   2 +-
 8 files changed, 156 insertions(+), 30 deletions(-)

diff --git a/Documentation/locking/ww-mutex-design.txt b/Documentation/locking/ww-mutex-design.txt
index 34c3a1b50b9a..b9597def9581 100644
--- a/Documentation/locking/ww-mutex-design.txt
+++ b/Documentation/locking/ww-mutex-design.txt
@@ -1,4 +1,4 @@
-Wait/Wound Deadlock-Proof Mutex Design
+Wound/Wait Deadlock-Proof Mutex Design
 ======================================
 
 Please read mutex-design.txt first, as it applies to wait/wound mutexes too.
@@ -32,10 +32,23 @@ the oldest task) wins, and the one with the higher reservation id (i.e. the
 younger task) unlocks all of the buffers that it has already locked, and then
 tries again.
 
-In the RDBMS literature this deadlock handling approach is called wait/wound:
-The older tasks waits until it can acquire the contended lock. The younger tasks
-needs to back off and drop all the locks it is currently holding, i.e. the
-younger task is wounded.
+In the RDBMS literature, a reservation ticket is associated with a transaction.
+and the deadlock handling approach is called Wait-Die. The name is based on
+the actions of a locking thread when it encounters an already locked mutex.
+If the transaction holding the lock is younger, the locking transaction waits.
+If the transaction holding the lock is older, the locking transaction backs off
+and dies. Hence Wait-Die.
+There is also another algorithm called Wound-Wait:
+If the transaction holding the lock is younger, the locking transaction
+preempts the transaction holding the lock, requiring it to back off. It
+Wounds the other transaction.
+If the transaction holding the lock is older, it waits for the other
+transaction. Hence Wound-Wait.
+The two algorithms are both fair in that a transaction will eventually succeed.
+However, the Wound-Wait algorithm is typically stated to generate fewer backoffs
+compared to Wait-Die, but is, on the other hand, associated with more work than
+Wait-Die when recovering from a backoff. Wound-Wait is also a preemptive
+algorithm which requires a reliable way to preempt another transaction.
 
 Concepts
 --------
@@ -47,10 +60,12 @@ Acquire context: To ensure eventual forward progress it is important the a task
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
 
@@ -90,6 +105,12 @@ provided.
 Usage
 -----
 
+The algorithm (Wait-Die vs Wound-Wait) is chosen by using either
+DEFINE_WW_CLASS_WDIE() for Wait-Die or DEFINE_WW_CLASS() for Wound-Wait.
+As a rough rule of thumb, use Wound-Wait iff you typically expect the number
+of simultaneous competing transactions to be small, and the rollback cost can
+be substantial.
+
 Three different ways to acquire locks within the same w/w class. Common
 definitions for methods #1 and #2:
 
@@ -312,12 +333,23 @@ Design:
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
index 314eb1071cce..b94a4bab2ecd 100644
--- a/drivers/dma-buf/reservation.c
+++ b/drivers/dma-buf/reservation.c
@@ -46,7 +46,7 @@
  * write-side updates.
  */
 
-DEFINE_WW_CLASS(reservation_ww_class);
+DEFINE_WW_CLASS_WDIE(reservation_ww_class);
 EXPORT_SYMBOL(reservation_ww_class);
 
 struct lock_class_key reservation_seqcount_class;
diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index 8a5100685875..ff00a814f617 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -70,7 +70,7 @@
  * lists and lookup data structures.
  */
 
-static DEFINE_WW_CLASS(crtc_ww_class);
+static DEFINE_WW_CLASS_WDIE(crtc_ww_class);
 
 /**
  * drm_modeset_lock_all - take all modeset locks
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 39fda195bf78..3880813b7db5 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -8,6 +8,8 @@
  *
  * Wound/wait implementation:
  *  Copyright (C) 2013 Canonical Ltd.
+ * Choice of algorithm:
+ *  Copyright (C) 2018 WMWare Inc.
  *
  * This file contains the main data structure and API definitions.
  */
@@ -23,15 +25,17 @@ struct ww_class {
 	struct lock_class_key mutex_key;
 	const char *acquire_name;
 	const char *mutex_name;
+	unsigned int is_wait_die;
 };
 
 struct ww_acquire_ctx {
 	struct task_struct *task;
 	unsigned long stamp;
 	unsigned acquired;
+	unsigned int wounded;
+	struct ww_class *ww_class;
 #ifdef CONFIG_DEBUG_MUTEXES
 	unsigned done_acquire;
-	struct ww_class *ww_class;
 	struct ww_mutex *contending_lock;
 #endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -58,17 +62,21 @@ struct ww_mutex {
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
 
 #define DEFINE_WW_CLASS(classname) \
-	struct ww_class classname = __WW_CLASS_INITIALIZER(classname)
+	struct ww_class classname = __WW_CLASS_INITIALIZER(classname, 0)
+
+#define DEFINE_WW_CLASS_WDIE(classname)	\
+	struct ww_class classname = __WW_CLASS_INITIALIZER(classname, 1)
 
 #define DEFINE_WW_MUTEX(mutexname, ww_class) \
 	struct ww_mutex mutexname = __WW_MUTEX_INITIALIZER(mutexname, ww_class)
@@ -123,8 +131,9 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
 	ctx->task = current;
 	ctx->stamp = atomic_long_inc_return_relaxed(&ww_class->stamp);
 	ctx->acquired = 0;
-#ifdef CONFIG_DEBUG_MUTEXES
 	ctx->ww_class = ww_class;
+	ctx->wounded = false;
+#ifdef CONFIG_DEBUG_MUTEXES
 	ctx->done_acquire = 0;
 	ctx->contending_lock = NULL;
 #endif
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 6850ffd69125..e861c1bf0e1e 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -365,7 +365,7 @@ static struct lock_torture_ops mutex_lock_ops = {
 };
 
 #include <linux/ww_mutex.h>
-static DEFINE_WW_CLASS(torture_ww_class);
+static DEFINE_WW_CLASS_WDIE(torture_ww_class);
 static DEFINE_WW_MUTEX(torture_ww_mutex_0, &torture_ww_class);
 static DEFINE_WW_MUTEX(torture_ww_mutex_1, &torture_ww_class);
 static DEFINE_WW_MUTEX(torture_ww_mutex_2, &torture_ww_class);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2048359f33d2..ffa00b5aaf03 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -290,12 +290,49 @@ __ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
 	       (a->stamp != b->stamp || a > b);
 }
 
+/*
+ * Wound the lock holder transaction if it's younger than the contending
+ * transaction, and there is a possibility of a deadlock.
+ * Also if the lock holder transaction isn't the current transaction,
+ * make sure it's woken up in case it's sleeping on another ww mutex.
+ */
+static bool __ww_mutex_wound(struct mutex *lock,
+			     struct ww_acquire_ctx *ww_ctx,
+			     struct ww_acquire_ctx *hold_ctx)
+{
+	struct task_struct *owner = __mutex_owner(lock);
+
+	lockdep_assert_held(&lock->wait_lock);
+
+	if (owner && hold_ctx && __ww_ctx_stamp_after(hold_ctx, ww_ctx) &&
+	    ww_ctx->acquired > 0) {
+		hold_ctx->wounded = 1;
+
+		/*
+		 * wake_up_process() paired with set_current_state() inserts
+		 * sufficient barriers to make sure @owner either sees it's
+		 * wounded or has a wakeup pending to re-read the wounded
+		 * state.
+		 *
+		 * The value of hold_ctx->wounded in
+		 * __ww_mutex_lock_check_stamp();
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
  * Wake up any waiters that may have to back off when the lock is held by the
  * given context.
  *
  * Due to the invariants on the wait list, this can only affect the first
- * waiter with a context.
+ * waiter with a context, unless the Wound-Wait algorithm is used where
+ * also subsequent waiters with a context main wound the lock holder.
  *
  * The current task must not be on the wait list.
  */
@@ -303,6 +340,7 @@ static void __sched
 __ww_mutex_wakeup_for_backoff(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
 {
 	struct mutex_waiter *cur;
+	unsigned int is_wait_die = ww_ctx->ww_class->is_wait_die;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -310,13 +348,14 @@ __ww_mutex_wakeup_for_backoff(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
 		if (!cur->ww_ctx)
 			continue;
 
-		if (cur->ww_ctx->acquired > 0 &&
+		if (is_wait_die && cur->ww_ctx->acquired > 0 &&
 		    __ww_ctx_stamp_after(cur->ww_ctx, ww_ctx)) {
 			debug_mutex_wake_waiter(lock, cur);
 			wake_up_process(cur->task);
 		}
 
-		break;
+		if (is_wait_die || __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
+			break;
 	}
 }
 
@@ -338,12 +377,18 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * and keep spinning, or it will acquire wait_lock, add itself
 	 * to waiter list and sleep.
 	 */
-	smp_mb(); /* ^^^ */
+	smp_mb(); /* See comments above and below. */
 
 	/*
-	 * Check if lock is contended, if not there is nobody to wake up
+	 * Check if lock is contended, if not there is nobody to wake up.
+	 * We can use list_empty() unlocked here since it only compares a
+	 * list_head field pointer to the address of the list head
+	 * itself, similarly to how list_empty() can be considered RCU-safe.
+	 * The memory barrier above pairs with the memory barrier in
+	 * __ww_mutex_add_waiter and makes sure lock->ctx is visible before
+	 * we check for waiters.
 	 */
-	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
+	if (likely(list_empty(&lock->base.wait_list)))
 		return;
 
 	/*
@@ -653,6 +698,13 @@ __ww_mutex_lock_check_stamp(struct mutex *lock, struct mutex_waiter *waiter,
 	struct ww_acquire_ctx *hold_ctx = READ_ONCE(ww->ctx);
 	struct mutex_waiter *cur;
 
+	if (!ctx->ww_class->is_wait_die) {
+		if (ctx->wounded)
+			goto deadlock;
+		else
+			return 0;
+	}
+
 	if (hold_ctx && __ww_ctx_stamp_after(ctx, hold_ctx))
 		goto deadlock;
 
@@ -683,16 +735,21 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 {
 	struct mutex_waiter *cur;
 	struct list_head *pos;
+	unsigned int is_wait_die;
 
 	if (!ww_ctx) {
 		list_add_tail(&waiter->list, &lock->wait_list);
 		return 0;
 	}
 
+	is_wait_die = ww_ctx->ww_class->is_wait_die;
+
 	/*
 	 * Add the waiter before the first waiter with a higher stamp.
 	 * Waiters without a context are skipped to avoid starving
-	 * them.
+	 * them. Wait-Die waiters may back off here. Wound-Wait waiters
+	 * never back off here, but they are sorted in stamp order and
+	 * may wound the lock holder.
 	 */
 	pos = &lock->wait_list;
 	list_for_each_entry_reverse(cur, &lock->wait_list, list) {
@@ -701,7 +758,7 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 
 		if (__ww_ctx_stamp_after(ww_ctx, cur->ww_ctx)) {
 			/* Back off immediately if necessary. */
-			if (ww_ctx->acquired > 0) {
+			if (is_wait_die && ww_ctx->acquired > 0) {
 #ifdef CONFIG_DEBUG_MUTEXES
 				struct ww_mutex *ww;
 
@@ -721,13 +778,28 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 		 * Wake up the waiter so that it gets a chance to back
 		 * off.
 		 */
-		if (cur->ww_ctx->acquired > 0) {
+		if (is_wait_die && cur->ww_ctx->acquired > 0) {
 			debug_mutex_wake_waiter(lock, cur);
 			wake_up_process(cur->task);
 		}
 	}
 
 	list_add_tail(&waiter->list, pos);
+	if (!is_wait_die) {
+		struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
+
+		/*
+		 * Make sure a racing lock taker sees a non-empty waiting list
+		 * before we read ww->ctx, so that if we miss ww->ctx, the
+		 * racing lock taker will see a non-empty list and call
+		 * __ww_mutex_wake_up_for_backoff() and wound itself. The
+		 * memory barrier pairs with the one in
+		 * ww_mutex_set_context_fastpath().
+		 */
+		smp_mb();
+		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
+	}
+
 	return 0;
 }
 
@@ -750,6 +822,14 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	if (use_ww_ctx && ww_ctx) {
 		if (unlikely(ww_ctx == READ_ONCE(ww->ctx)))
 			return -EALREADY;
+
+		/*
+		 * Reset the wounded flag after a backoff.
+		 * No other process can race and wound us here since they
+		 * can't have a valid owner pointer at this time
+		 */
+		if (ww_ctx->acquired == 0)
+			ww_ctx->wounded = 0;
 	}
 
 	preempt_disable();
@@ -858,6 +938,11 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 acquired:
 	__set_current_state(TASK_RUNNING);
 
+	/* We stole the lock. Need to check wounded status. */
+	if (use_ww_ctx && ww_ctx && !ww_ctx->ww_class->is_wait_die &&
+	    !__mutex_waiter_is_first(lock, &waiter))
+		__ww_mutex_wakeup_for_backoff(lock, ww_ctx);
+
 	mutex_remove_waiter(lock, &waiter, current);
 	if (likely(list_empty(&lock->wait_list)))
 		__mutex_clear_flag(lock, MUTEX_FLAGS);
diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 0e4cd64ad2c0..3413430611d8 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -26,7 +26,7 @@
 #include <linux/slab.h>
 #include <linux/ww_mutex.h>
 
-static DEFINE_WW_CLASS(ww_class);
+static DEFINE_WW_CLASS_WDIE(ww_class);
 struct workqueue_struct *wq;
 
 struct test_mutex {
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index b5c1293ce147..d0abf65ba9ad 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -29,7 +29,7 @@
  */
 static unsigned int debug_locks_verbose;
 
-static DEFINE_WW_CLASS(ww_lockdep);
+static DEFINE_WW_CLASS_WDIE(ww_lockdep);
 
 static int __init setup_debug_locks_verbose(char *str)
 {
-- 
2.14.3

