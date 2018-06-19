Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749F8C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037162083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="YkeYLbVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037162083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756644AbeFSIZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:25:58 -0400
Received: from mail-eopbgr730082.outbound.protection.outlook.com ([40.107.73.82]:26019
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756600AbeFSIZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqljLsEJKty1XFE5o6z9kVLrGlFx3jhWS0hTQ0drhtk=;
 b=YkeYLbVf95HaqTq5jbNiBpR0XOaGZzg/wldKqqBDSVs4XMLTh5gOYstmmu2QXIYzXdjsT01OWjsZ231K1FZvgYmPVySUTMJVr39q1uAENBqes3JKkY40AjRiV9+Bs1iwachyRWgWoyR8KPpr6SfiyqJb1vZ2yZMjOLszH3hAAyk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.vmware.com (155.4.205.56) by
 DM6PR05MB4585.namprd05.prod.outlook.com (2603:10b6:5:9f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.16; Tue, 19 Jun 2018 08:25:42 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Cc:     linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
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
Subject: [PATCH v4 0/4] locking,drm: Fix ww mutex naming / algorithm inconsistency
Date:   Tue, 19 Jun 2018 10:24:42 +0200
Message-Id: <20180619082445.11062-1-thellstrom@vmware.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: CO2PR04CA0136.namprd04.prod.outlook.com (2603:10b6:104::14)
 To DM6PR05MB4585.namprd05.prod.outlook.com (2603:10b6:5:9f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b65e6270-8b58-4550-c205-08d5d5be41fd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR05MB4585;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4585;3:+3pR1v2VqviQi7vpxS7sV90iRVrDtaPZJmBqmZ+6KzCBCy5eb8d2X+5tu9Gk7acS6s2qGekV7e1T/Q2DjYDeiKNyrOoio4KkUnuyCZ6/WB1Sp9gwSRgIf1DhwFyoWaBJsWIePOuvFKPACSyXmXUQmmrm7gjPy6tZPEGyTRKOtXF5XmmB14dSxhOtBB0eO/xpfj76BE5dTjvO5E+SEQYDNaUl4NXuWX4ioHR1MB4kc0rWC5xGr5RNSZcDoGvpNBD5;25:pX3bhgziOukFyrJBmkg7GjilC2LqCQHQ68ysGIDShH9FPu9y0b9DmN3O7ctqUN55l6EMtN7pXljJzwqfUIQjf2lp51sg2YlVWv5dZTI3hlXjpgyCCZAWdKXHmMCL6vX4CdKvDKyqIMyRMG1+uVk46eMtsmDQkT5dA5ydpmhNwd82sSBO5rdrpJRHZYWIBlHN7xOVdEJItWToiEko9RtLa95D9uFtWNWLNQhd3CgjL/NBoWbPy//oNeVfJewbnTg5PtBH+F1GS64z8I53ETRN+J6pUscVt8TiTg+elf82fFsVEmj7B4VGAj3FrM0MHSV/+pnFw7wtewGV1VdKXEsjcA==;31:sWy3laa4D0U24h0ysrYmlkJTCZ53kesPLJe4ViSs3VvBBeLH2qM2yQYCYLhR1tRJJwJ8vKRsLX4z/CvD1DhBhmxDsqjUi++aZyci64otOIif3gK47+nyH5SPl0lMotKQKNSYTvmJpye3/ZTeYxduXUAMs94HkNMswLDtL07V/qWHRn7hrRw7yjrIWn1UBzWD6y3yunBuN0qulDheY9LOdYZEkypQwh+sbGlQMlEXdTA=
X-MS-TrafficTypeDiagnostic: DM6PR05MB4585:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4585;20:K/9Muupvshm23+0DfYa8WL0QMYGeje8I7DxH5QE+8sjlDR/BUamyYTgIw/UYV8UQLkaz8Sek9xNIY5igATQrMPdCebp2L+gI99S6JALS4qbO6j2zpDz20zPfB/Gd/A7if3iSslGAIkbIqw51fB2wntTOEKXvGPUcl0kbekXA6/xRfVLciu1htSl7ynINJr0M90ayrDIjngD1YhrADiUf/n8xouey+LWLYH2QxvcB3ApgG4F0SFl1d2UEPHwHQt4HGBidKgexjZ7G0j8GVyZvyj87OOYMcm0b5TGWQVF1/f9N3dR0i+U4vGefdDRIhA0ZoJtRiD/RpSrKq0kyR5PGmWyc7TtR5CMCtqY5y9BN+8LouMOeSatWWNdTcNw21QuQpuAqmF6XYBKS4UGND87vuVbnrR2zkHYbuvw4/sRyJR+eoawonAgneqPh1jrGFuTjarYTydpj4ycwhKhjdwP4AakK60rWoxJqvnEZwtPhnAVxSY4cyYyc2VTnK25UAfaC
X-Microsoft-Antispam-PRVS: <DM6PR05MB4585FE5C43A574F1B32E4B95A1700@DM6PR05MB4585.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(166309043207732)(1553240931313)(104084551191319)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR05MB4585;BCL:0;PCL:0;RULEID:;SRVR:DM6PR05MB4585;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4585;4:EZV6SmPXXnpnrQ+z0GmrFzMVa8afp6hEEl8RRZX/DAzwL0IxbARJYA97VCjOkMlT3MhK9xcxml1OyLFMzeln0nVNZgJHfjvTeJebqP4F5AVaSBG4BUBgaSocU9sq5pvrO5B12htXiCYyWe7UDThv+npw7de0gdOgiaeQvTNi//t9sS5a982nlzyFJoXHVqxO4W0z3BO0M20y6zN49XLJkLxRffSNILpkktEa2iUzjKaL126x2Zg/r4kuS8eCdP8275JOm0QGq+7QFIN7ZOi44ysid76wwMTjF8riDa2+kTIBILBC23gipwDsCt7RJRjEZrMPe3IH6iFC4ILrddh7jEm8jkc8N7dOsqG1Ek8S1OFKtKDXJmS3qP5Syw91d/dG6PdzHYdHEOtxtDDg4JzFjDlIAYkmRvEPGUGlRvxO6Wqnbl1QW/qzGJmTaeaI4dVF
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(106356001)(6306002)(68736007)(76506005)(53416004)(956004)(105586002)(7736002)(305945005)(6116002)(53936002)(316002)(54906003)(3846002)(69596002)(478600001)(486006)(50226002)(66066001)(2906002)(186003)(16526019)(48376002)(47776003)(5660300001)(26005)(97736004)(6486002)(8676002)(7696005)(52116002)(86362001)(51416003)(8936002)(476003)(2616005)(16586007)(25786009)(1076002)(59450400001)(4326008)(81156014)(81166006)(966005)(7416002)(551934003)(36756003)(50466002)(386003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4585;H:localhost.vmware.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR05MB4585;23:Do7U9yV1mZaHFAbZZgJoY7zaQnUlyG9ipNdjlo/1T?=
 =?us-ascii?Q?RhErkfuFTn0j8zM1MRWGa8ETzjDHZB1/X4JnjId0M1rDBPl7CYB+/zy1IzBO?=
 =?us-ascii?Q?FKgMef3ong6xOXbCxuqWEf53RW0lzcm2S5ihJmqPsZmvtCEZWFktjCVrlhuH?=
 =?us-ascii?Q?CavLNxCDBUXGaGSaPuvDbE8AwA1ArJcP1LbvBGuJKwfiQ+a4AQuwYcmZtfzR?=
 =?us-ascii?Q?swiSq59oX5i2gORlaMarlNNWH4lcZYdw/+i/uT5d6GQrVrEsNPn0alrr6Rbs?=
 =?us-ascii?Q?AjR1zf6gdnS60rSmue4+hCFIBbcPJ2iLyvph5903Hp2zrTewC97OFM8igJFJ?=
 =?us-ascii?Q?FqgfyzomKB/kpDEi+fCYbFzMIw6Ze8W2bvxvSUK71pVQw9Eh2i2DoHppSUX2?=
 =?us-ascii?Q?NUcjY9QUf3W0d3PWE6kF28mJX9q18c/mTKuLwzCkMwUts2oT0xJcwrJKg+fP?=
 =?us-ascii?Q?i2xSyHjGhBLrSnMLejO01ENnK8cZxxk+SaZerMPW5cxoZz3vgL+6aYHKrR9C?=
 =?us-ascii?Q?iuwq05Xy+nsOoHOv8sZDAdHyLk4t5Qy4EaQIljQQbNurXrLPjyXEdasF3uuB?=
 =?us-ascii?Q?fAW9BMbdgNTl1vr3yfCZ3ejXlJgnWCHc7xopG4TB8LuO4gnoayKs3S6qu+ZJ?=
 =?us-ascii?Q?3PKiu1yV36C4lBZdBFfg0FtaV8v6pKDj3iaW8w9dZq8qVWr9osVt1So07Adw?=
 =?us-ascii?Q?t16PMIxd7+tmR6uUBv08rZegjk7jUUJXzIvnfjXghWBnLI2vi9y3BD92wyA4?=
 =?us-ascii?Q?7/2huv3LF6VOHTmtMztbKenLAwF6TuJdJTf/9Ts/fN4Zycb4yj6Xl46PXT1U?=
 =?us-ascii?Q?FSxMGAQ9PzY0m4ehHWDZARqCf0dxIdqzF+GDdBYsVbT48YupvqNOU/QF6go9?=
 =?us-ascii?Q?gzdQP46YPO2nqCaAQVchz9A5jOv3k+5hZcg7lBF2eCYB7xVLIR1GyfKLvTWv?=
 =?us-ascii?Q?mj8MF3pbmMeK5ooYaDWmjWsBMPIwQS+vq2P7uYE6ytKO9K25Y3fa4zhZBvPx?=
 =?us-ascii?Q?JHMUHeMgR6W5yP0q0YvCktfyokLk6U/pzePgv3AXA+PLg8FFM26EjwJS0hSt?=
 =?us-ascii?Q?ziRVdMpAE/eSDqwjF3d/mk7APvVDfHA+/p24VgXAtBz8zWKxuLIbqfLfXSV8?=
 =?us-ascii?Q?RU1dXRnmuQJxhcWdFdi31qrcJxAyPmW4KID2wRNGx/pZcCyeo+1yWlrZLW05?=
 =?us-ascii?Q?m4B+OHNXCP1PfWx6jhweZdw37WKAI4YyQTPv4cgWtRYJksXLqVmBFu82zOLE?=
 =?us-ascii?Q?Ve9xbKU7odxYVcRy3NlbH4E2IxQLJGCO8B6IcbeArgjfU23a9zp6TbjEh5a/?=
 =?us-ascii?Q?SGyu7NSxPafOgvh5yyDyAc=3D?=
X-Microsoft-Antispam-Message-Info: vOi39Ye2ByI0RAhkg7duPpScLuAlVMjFAttBnwBqEW+67cEXCQCCndQYx7Dvd7wgFiwTbETsDhQvSjUCYelF97oDl3EkV9BPEqpz1fdTvrHrtLmv6pPQajwy3WJE1hz/u3SSW2hQ4Kg/X19ul/MmGzzGgYs/T4eqopmUujuugrc7d+OwiT4HWoXjGy82CtBeDKpFL0dD1V/X6jfmNY6Kbouio3LD5ix5Dz7uvxu/xXmvONgtbtqS77H4HgZOfLhKqbtXyQ6h+rn8n0u5Vk9mIPz3OecDBd19eEC1owhj10TVynn6z3QdpQxwNe3tK7ivOWAACBcytR9nyMM8/8ojig==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4585;6:FF/06C2KlsM6YqrWtbojpkaZxM+guHgBSjUowe9npD7P42TOz0VM1iOe1aBaBihFjRtOmHfVMUSru2hAfVnSYUy74QKgrfrtiC5RBgAjdsj/WExhK2GmYqlgvB5tWupksbSix4etWKxu2WujXgG16ggU3vouESJ2wmVJSqQ7dyWTXQPF6NB60+46mX1En5ZaGlWfJG/LazboH4jJ5vsuOxeOnaGDbmBIGVng7L4iK+hh3zRzVfD+y7a7h68uvWpkIbxJjPe0Vir3qbXog8MFEM/EQDET77u8Enlvhugo/EcsnWIg4h0z7zK8A4fktV+/XNVqlpRHMhvIUPIlLHpPTlCxk4lmIBKvP20203pTQm7foQASUBCfE6YaDrqqu9cgtQypjMVd6UsIpo8qjmOlztBk5rte8cgSx/AMf4Sr6o+9klzSubJt+VOgOtHjrUwvlWN1AE9UQpt9eABgnGvBQg==;5:uAwS+XFg7o5zndoXRox1yDFzC6ob6Gf9XTbcZ9hoY+ZbODK0sr3dWsP+GZWMSD228ls3/r8WOKvVY50vjxo2NDVD0lIqY6B5oJLms07lP6HEta1UO7i4+gbJmQ0QMArQo43XONJ2a7KHvjtrgovbWSdEZPabkM+9To3E+4wh/Vw=;24:AX+LzdPiXlAmQ4/eHsbkkkA8EsmUefnxO+jm7E4PJw3M3VHtMRft+4XqaCQGfOq3jOg4blUW/MWzFHoqSbCi1G1BI8PB1SYkt14eu0X8hrs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4585;7:U0KA2u7hYDB9Z5/EirP2609eQb7vH40k+dlb9WTczLVvoupkrDQW2qPKQksOwXKUmHzV715yD8zP50cBeyQbNzkEZlehzeXRxEbAFpxr7UQe+MOhdwijbo87I/93Y8bo/gPSnCN+FKe29rpI5/a4Bv6a4SaISUAkumU3z7gn1RKG/2WPTtE0arPAJF8dy74RfjdU4r7HWRTJCH/T1v56cGzCPTn9L8BlAtROLRRnO4a1KzHiew8zu5KiByKEU253;20:0ga4EVl6PYQFNmLhl9uNXU+PBGrGcKPzm0QQkGFaP0469JieAMkfHkemtSZxk2/2UDgsfHvCM3B31clULm1TDWlHVgmuH7URPbMowCMo8dCEDMahhI2W9zSMGhlV8fcDN94ebPsP6B/xHTPl8PtsI4jghVGz+3MoAPbLufrUkgA=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 08:25:42.1820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b65e6270-8b58-4550-c205-08d5d5be41fd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4585
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small fallout from a work to allow batching WW mutex locks and
unlocks.

Our Wound-Wait mutexes actually don't use the Wound-Wait algorithm but
the Wait-Die algorithm. One could perhaps rename those mutexes tree-wide to
"Wait-Die mutexes" or "Deadlock Avoidance mutexes". Another approach suggested
here is to implement also the "Wound-Wait" algorithm as a per-WW-class
choice, as it has advantages in some cases. See for example

http://www.mathcs.emory.edu/~cheung/Courses/554/Syllabus/8-recv+serial/deadlock-compare.html

Now Wound-Wait is a preemptive algorithm, and the preemption is implemented
using a lazy scheme: If a wounded transaction is about to go to sleep on
a contended WW mutex, we return -EDEADLK. That is sufficient for deadlock
prevention. Since with WW mutexes we also require the aborted transaction to
sleep waiting to lock the WW mutex it was aborted on, this choice also provides
a suitable WW mutex to sleep on. If we were to return -EDEADLK on the first
WW mutex lock after the transaction was wounded whether the WW mutex was
contended or not, the transaction might frequently be restarted without a wait,
which is far from optimal. Note also that with the lazy preemption scheme,
contrary to Wait-Die there will be no rollbacks on lock contention of locks
held by a transaction that has completed its locking sequence.

The modeset locks are then changed from Wait-Die to Wound-Wait since the
typical locking pattern of those locks very well matches the criterion for
a substantial reduction in the number of rollbacks. For reservation objects,
the benefit is more unclear at this point and they remain using Wait-Die.

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

v2:
  Updated DEFINE_WW_CLASS() API, minor code- and comment fixes as
  detailed in each patch.
v3:
  Included cleanup patch from Peter Zijlstra. Documentation fixes and
  a small correctness fix.
v4:
  Reworked the correctness fix.
