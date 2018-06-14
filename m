Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D1F86C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C86208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="SRnZg3jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C86208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754720AbeFNHaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:30:08 -0400
Received: from mail-eopbgr700043.outbound.protection.outlook.com ([40.107.70.43]:27136
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752892AbeFNHaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn/zj2m/rel16GfpE0tpVUmnvWNF1PaTkbzsvMoNPuo=;
 b=SRnZg3jDTtKOq8e0WRXasKVBpI0EVRGiy3qm4KRXSrk7cIoMvqdW+uoX3yp6C2LXmFyljIUBqsIu0JbJgxRSA0Rd+/3t3JU5rWv21h9H98++HcrxBvr08ASPiRKTlN5urCWMe3CY5jmEjZ1+qqajB+7msURkTPTCxmV9dBCA0GU=
Received: from localhost.localdomain (155.4.205.56) by
 BN7PR05MB4580.namprd05.prod.outlook.com (2603:10b6:406:f2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.13; Thu, 14 Jun 2018 07:29:57 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v2 0/2] locking,drm: Fix ww mutex naming / algorithm inconsistency
Date:   Thu, 14 Jun 2018 09:29:20 +0200
Message-Id: <20180614072922.8114-1-thellstrom@vmware.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0701CA0081.eurprd07.prod.outlook.com
 (2603:10a6:3:64::25) To BN7PR05MB4580.namprd05.prod.outlook.com
 (2603:10b6:406:f2::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a577eb8c-c0c8-410a-bb9b-08d5d1c8a377
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR05MB4580;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;3:iflV1Naav0MIxQhNcvknVELucpBzyBDoLACW2HGZOLyWAq9x7+mjhIR9vAKf3gB+pd+VVf6OgLMB10jdKrAagqhOUx0M2gJLkZfyXnkJqaatA8nhmFpg37oKngsmD2ZoAJJEBjGcEqkscdSSeeBFL7JoNhxfR7OyKXGpoE0kszIynLJWTblljy31fuVj4IqYExi/6LTgVaiuj4GNCR0bm0d0Wvitrzit2GRFo88yAVnyXapJva+qvqcrcIzF0Ubb;25:CPWuAWsAzzM1xOmwD72UAbbNFDK+Q4EGA67pP/WGUZKVPWZP65MGyoiH+M7p+Pg8+It+ZoxIq6tEwR+LLbQDDfeYAdJfKfotN+rJVcLWqSOzJ94b/XYDyF4nt5GxfGqINQ5fZYwster9IEH+ZPKs1uWukcUFmSr2fPzYg1jszmwdZ1DiX5wvPTPDh13sgvxsp+lmc3EBG55u+fcg/J2BE/Qt8xETkCfSCU3Ty3WDdsRQkIw7F3UYh3ZPH/juXir3iDBXNYdonOwcM+RWKcyzwGxodaGze5VFA2b9VgIyOd7lWuvnYnfpPRVQPW/nOIagzpqy9/5rWtdl2YXBzIHwbQ==;31:nQEB9KITEkYYs1y41jf9P5V+8GN4F4DKpDVctFa1oOPP1HJPjzb1WZpsIfC0SiyVnDmE5jOuOCwUJVifC7WGnq8pi3kpLtGrwC/Ya4iXypiLpF6md0wGn3C7aza6WtO/KdqJr7BVHOumhQz9l4sYkQNE11DxVeK03WIrY++nnYnO2xsceBg1jjJ8zhIx+2nQvEFFMm19GkukJoVokGldQZpWPktlQ83F56xPIBoPmAo=
X-MS-TrafficTypeDiagnostic: BN7PR05MB4580:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;20:Ndo1Rz/8juiiIPPuGaKmcgOzGQXdUix8o3L3zIMtcnHewb3c7kTtpJjRZ/xUQlx+Zv0tUGM0ir1qwZ8ZYVgl1l/CdzQzv6v/+unbZy4dJ6Whyb8r/yctG9chH+rnZ7W3g/DyK9H0EISu79PBNF5Fm3Grnba6kJVZISrjUcyQTfoIWDC4hTx63BqC0t3UFcA/dCRlD2iYGXypsUBB9tHpO80K+wRgYIS40s2az+CGzC+bKnWhfjf3YTiWEnhQyNbkHRNDY94xF3+XIdY7S85xQok/AcrOCjiTfi+VqBZ9aoQqxirhkxLXKHG9OSkJRavY07mY3Dr3jnD6AUo50FXEc6RpyfRIp9OnK8bVgnnuL65ZpaLixZd+stHW1KzOiuVpGxoRDdmCcmT5zLoyI2YAcYDjcVImk8q5bKDkIc9jTCBAl4eNt5CEX4wToK+iCWJ0+Cus0zLgKZMvzOAF8z+3NKBWuT5J+seNl5pXX0gd3oXKnALSKVPeQ6gKLK6u2Q4J
X-Microsoft-Antispam-PRVS: <BN7PR05MB4580A0868BB7744C8B48CFC1A17D0@BN7PR05MB4580.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(166309043207732)(1553240931313)(104084551191319)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR05MB4580;BCL:0;PCL:0;RULEID:;SRVR:BN7PR05MB4580;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;4:YZNPNKQAxx0FT0KPY5vYKL+qsA4zPvfIuACJtiokaCIEfOuUDQvjyryn3SHsBW6jvWo7lHnpnQ1zbPWOOSN1/x7dqVcnC7wUVl5wCiVwdwwi4fMxJtLiByGgIH8/akA1+wQoMiajpwug2me/EnxcMqZgC6rDzSWmQLmcJj6ohjFjMqGd/2s+w4OnKmWshxv5LUObH75huDjJT44WRMxFKoAOKf3aLHCSFrDnJhI5mtI52hLAI4bMrVp1FLEBGMYJEqU2G06/lt+2mdDlING3AkDMucFD5hgUK+kdbdogzQ24ipJuU9byJeW9JteN46UMNTbBc2al4WdAlwzEWwhvf+Rz/lCGHPMvcVXy8+KC4AhtkwzVt142IcbppHO1HDVGzHxamxr4TNpTa33driZb0Udc4uAcSw1mOwIobsDzD6gssP8W/lZ/JfNv9Uf1zUB0
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(199004)(189003)(6506007)(50226002)(966005)(2616005)(476003)(551934003)(48376002)(6306002)(26005)(305945005)(105586002)(106356001)(54906003)(478600001)(51416003)(316002)(52116002)(16586007)(86362001)(486006)(6512007)(47776003)(8936002)(956004)(97736004)(59450400001)(50466002)(16526019)(7736002)(25786009)(186003)(386003)(5660300001)(53936002)(68736007)(6486002)(8676002)(2906002)(81156014)(81166006)(7416002)(3846002)(36756003)(6116002)(66066001)(6666003)(4326008)(1076002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR05MB4580;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR05MB4580;23:UtEQGyl4gSkQS6edfaYqNZpyFSqs+toUeLNiaSAFI?=
 =?us-ascii?Q?BMmQ+4ZfgyXbb/oEKAqa4JGTnWC5UaHgI3VwmJQirmA2U2En1k85SDMfjFrD?=
 =?us-ascii?Q?G0k78Df7lZQeebWaUBMRZsYtrX1ihJOhz+S0k7oD1lHsMIFGyqQy9E1Ak9W+?=
 =?us-ascii?Q?vjDj8o+8lpYucaBjwj45ICWlXQssIjYzMInXDXQaXYvKwtgiZYEBmVQ0M29F?=
 =?us-ascii?Q?VY5cTeXuwwoqPB/U/7ZFxepmc+cktIr1nnvFzXU1VEpOCSLCdh/aQ55+ny3S?=
 =?us-ascii?Q?bdI6jaZtbMwA9JRhZWjW5dnxrzc67q12aZnYq32N3F0FgeQUQJ9ooRhJh1wt?=
 =?us-ascii?Q?V3cA24tBbTuhe5uEOWbDv0++h3e08nkoDG7+LBs8UoTKU3Z5dy/CAfEWtgDF?=
 =?us-ascii?Q?3WJlVAF4BUkshj580mCcWSNRycU4h2K2iWWBz7GykIIcxuJN8/dlONf2H5/+?=
 =?us-ascii?Q?Qfx0S4QC4EfNhfkKSMPXbwYEdKIaz42pe5tiuW23VLGd98enLPaEn2zW1Q1t?=
 =?us-ascii?Q?4gOIUySmjOA0RfQ8+poO0BMPv7YOgVzVsTJWvrlsIALIo05I4NFClC3Nc+Xj?=
 =?us-ascii?Q?9lj3yVTPC86ekYFw9w2YuOAThheNt2MZeGYTzSJFnCX0w3taleWMpblhWqb5?=
 =?us-ascii?Q?N+2Y9ptZYYQMW6bp33dllKxV/OkymZ7SdPq9g8TnqFj0WOAsymgkbG70Uvn9?=
 =?us-ascii?Q?CNKoqXnNF7iyodWjdJR518hSErEZ22OT/sYWG/DxJA2rCIJHB8OtuczETgZi?=
 =?us-ascii?Q?kW4QStrO24PyG1nsh09UZvA9iHZKI3M7xUDMsHAyyyvAEl4vMXsVy6t32kZS?=
 =?us-ascii?Q?dcGzplTF87WHv26Sk5mdNM6saITDaOAf88yAdMvj3BMYibh4Y41mtJTYZ7io?=
 =?us-ascii?Q?3+BBCyZM8f7kl/GsV4EPs0fOVwgsKCPkvXWiANAlp1tCbW1vL66ANJ4KjfrZ?=
 =?us-ascii?Q?+QPWNPrI421hQOYu+EhMlnEYzvPLvRpMvdnQWPcdKN6kjQ3JTUVsEqaoElYd?=
 =?us-ascii?Q?Z0KOmhwnrO6O/qPU607MwyXJJ1R5yQAKuR2pG4F7A5ZjylKcyVEwPsUUPZBt?=
 =?us-ascii?Q?PnLawSr1Q6AridIYgwA31Cey+QSOzECsmMSl6WskZshzfOqn3BXDV5wWNzcs?=
 =?us-ascii?Q?DMw6w/2OkUeQHLda93qkRLSTIwWN/CVGwCLk2XfdYKM2NC0MiNUxYAZ7ByCp?=
 =?us-ascii?Q?Svofgq8IfrauNcd2R65khL07MOQWHjB44S3adVBuRqZ9671ZFu84hSGcCXhP?=
 =?us-ascii?Q?yLWSHlwB5FXOMSPqWQmJAr51jFLzfxSEzd6oiY0CFo1cbAtxSGq47CRiG2NK?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: DFKxB7VoEj7WNCl1F9kVM+Z6QxL7+4QJw6spspENkkMl8KHO8Z+dcpWPyoTy33tVdE/CwMXx7Ch3r6lkwhy37WQzOerhoUsB7Pw8pESsZy7r6txedCFDlExq2V/fBDaVjjrXiykHZuEW1iux9YrPpRBvGNQsgWyYpzTwQ6jqjDPpCwYwA+bE0AFxoCwRz3yX
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;6:Z+/owSJAeQMEDu0PAEWC37lWNUPIyUsqFflhtvCOSicpOyib+n1Ex+Ma+5jx4oQdX72I7yaw/JlB/5cKi6CAX/rDF8hrUVMzvgXTqgEfZRtoZo9l6/BePlxLqiJjlogkxReFwL8PtWtpOiIbAFKnpt+m5erqloILOL5wI5NdWAOF2Sc5DaK9t72aU20a40JZ1rsZXS2HQIiV65GbapZOS+ztsp5oPfWiNw2SdRvih6WWK52IwZBxYdOJxtnpUDa6IvUHD8d5s0FUcC4kAaE/8TBA9EkJrEGQK3NEQ9597dMHh9w/6epMPdjL/Y3aEP5DGIvYm5ytwn/mgPyqM/4LtHluUFgtjCrLRuqgXnhuuaoK5bXc2XgPIiqlTh7xY6dPqfRbr2QwtIsI1FIqEDmopRyutTej1eiFk2RVr8AnM37kHDzW5RDW9JEBVNvlzqfZV5qBDnNkz/Hfj4yf3+zsSQ==;5:1FX5TkPuFTYU0+lfEG+ISq1nbs53nVy5MAP3kJfJzfCbPXb9TrQXszKU/FxEv0JTEmKJge2mUS69+KmD5R9YF28h+T3mYeSYWZDY3FaIPIub7L+VTc3DhiRHrli4ifVhlFRzk/R/vmUYYY9KKtJdxNR6Xe5ROT1KZ/4bEidCaQs=;24:jYJgun1K9lYQTJ3Wh6SRwsOITLyDXCASsDm7CEehltjUU4GIRSUEgZ3w8ftN0VJCrILlkPaKjpQJFfZPHqG97KjwXeRR9c+zD60Vm7PbnTk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;7:u3/v+qU+RPrFFqjCEvGNuFzlpzYh5MyOkWQCXTh2kZ5kumeLe7rBTHYPmJ2f8VtdKfgzVtFuawwE+NMxome3L33DMotMVRZjVDuWUOrK0vv3hWRzxEKIBYdDcF/dZXaeiYu37opyzPyXflvr/NF93jtFtoGickkJcul5Me1Eych+/I3Ln+s9NCLCUri2JmVIRL+0+Y3QEqk/5xWs+Ml0DS/pP9zRgq7F0LFqkF1GNEqDx2EeE5n9seVMI5GI7VPx;20:dlm9XvfUUSikGblrATzjeoD/1nzJRBjgEyENg3rPl+QCsaXXGWNqcPjZ8nF/O8ZvC8TnRUIRHx0kfAzN36JIvp/tQJOIPVn2j4UGUX9r/hpmvoc0T/akA1jjwO4KdyHO+pbA4wDtRfzdR0nawQSSRx1gzD3oLnJEysHR5nxK5fw=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 07:29:57.9710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a577eb8c-c0c8-410a-bb9b-08d5d1c8a377
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4580
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

v2:
  Updated DEFINE_WW_CLASS() API, minor code- and comment fixes as
  detailed in each patch.
