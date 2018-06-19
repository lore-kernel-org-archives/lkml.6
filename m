Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5F1C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A131A20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ZzGvh8ME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A131A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937314AbeFSI0N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:26:13 -0400
Received: from mail-co1nam03on0057.outbound.protection.outlook.com ([104.47.40.57]:50284
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756600AbeFSI0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy6boBGdwuS5FZrb4JniTgAnOCVhYoeT0dVE2Jq2C9Y=;
 b=ZzGvh8MExoV5lKJ/eiwuhGTuLNeczdOyqhjIsG3RiHIzlIKvJbwKcqrDeQ3yzsDKSL1CMecKyf5t6tBHaJoyeVkExjHennyB8uAZTwpPhZB65plHvMFFCMUJ6ZZFzgwGuMZ2Yqs3MCGYiBs4nTTeH4EC6wzgUshqmBdgNojKtBI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.vmware.com (155.4.205.56) by
 DM6PR05MB4585.namprd05.prod.outlook.com (2603:10b6:5:9f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.16; Tue, 19 Jun 2018 08:25:47 +0000
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
        linaro-mm-sig@lists.linaro.org,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 1/3] locking: WW mutex cleanup
Date:   Tue, 19 Jun 2018 10:24:43 +0200
Message-Id: <20180619082445.11062-2-thellstrom@vmware.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180619082445.11062-1-thellstrom@vmware.com>
References: <20180619082445.11062-1-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: CO2PR04CA0136.namprd04.prod.outlook.com (2603:10b6:104::14)
 To DM6PR05MB4585.namprd05.prod.outlook.com (2603:10b6:5:9f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3ece758-5c9c-4642-1d08-08d5d5be4571
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR05MB4585;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4585;3:0quWA1GtpvLZGuKMvJa0ByRQjRVT+3IG5+vWh0czM3kYXCSZvK4+oxd5mcr3jmq937xapOs3qU1QD0vrmw+JBFddrwOH9iwB6o7ml2tl8/IBjNU2qj9YNmgOk6BGdUfyd0lFPTUYnfGGsPyIsuZsf0Ora3dhTbNNFL1+4SO2XCRWHljmmTNqylVSxHaMVnv+mvvyRd6sw0E/Z8g3OBFuvdPA5gNGe0WS7pocttdbYKvjHdzYMqTC7vuh6mFpArsT;25:ZYn/QBbIvXQGqO22ylHhDW7ieswljsS9+VgFtyZXOCrTHXOzJs7Ihb+wwgrPhfT87VflbEikd9uT7xl/t5Zc4ce6oyDqPb7xs9Alza2HysqT82H7mCubvx+siF9P4gjZd+cLu8MnN3zlklFD9CpXWSyjgd9vevlV1QbNIUxH90lH8XWWr5TIsqQ3vc+DMtDLTbBuxe55gtTIGSTssPpMuETAnpkoeNm93kqvGjUP6js4xliigynF5JdSqOT7MzPQThEWtVhFgN2C6+C2reQv9OYqu8ttpiX1OqBIfBnCq3EcvgzpmQCoqAqjrDcrS/tz6vEIWqifvz8LdkjQTp7cSQ==;31:rR9m8JQXXcbnE+3+Ay8rhTLM30PgJY3tpBr37IBXyjswbG0osKmLucQmjbTnkKJ6/lr+BAPeg9H9rAjSN4+YnutC5vr76nQvNeo6rTaK+D0a0mvRsjlEjWv/o26IKkBNbHwpgiUrTrw6ei4EReZ6MSs8oZn+tGjQehb8NcnQPAequf/Gr3w0yWObv8o9L7ZW51lDMWKTfnbTGDQm2Mqz3I3jarZTmY8N3bcPy/J/xVY=
X-MS-TrafficTypeDiagnostic: DM6PR05MB4585:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4585;20:CcEXPbTcmlYDb6a50mjBtNbXpULGz+SUACZmuC1B3XzS9JP1TllW7Pa6OwlXskWRrcSxiyIWGVLtryEio2Tq4Xpz35sFr4q1ipWBSrJqicdqAVdn0DFb1atcVARswm0q/305jiNIt7az1q3VANYWuNtSfsih+J72uxE7x4jFil3xdWclKmxTHnCf8vyddOCyvrhwJbtByRiQ2XLniu+ZyV2l3VMN1BV/a/X1xZegus+ujxWnathPZTd/cSzu6hD1gMPIbl7bFuovswcIw77Y/Ap1/Zk4x/2mzYvhUs2Ax4ol9sq9Mtb+pf0Dhowk2lKzZdgd2ob6dmdQ8J9S7wivF65hoydyXSI61zqfoc2q4hhZwXhdlbjJ9EPJhcbudEgRnEt4s4/pWRsNvSF8NnBr0gOCMkl8NsGx5/aA9zgr85X1N57dMiOwXV5dbUt7qH+XjuWPPCe+DXgEWQAJjVypyMhhxFlUsKCGfgc0qOManr8+ibR5anR2r/yWPJxjKUjV
X-Microsoft-Antispam-PRVS: <DM6PR05MB458544A8856A901A2650D202A1700@DM6PR05MB4585.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(9452136761055)(1553240931313)(104084551191319)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR05MB4585;BCL:0;PCL:0;RULEID:;SRVR:DM6PR05MB4585;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4585;4:GNdkLAGLX6fv1xFgpNMW5gnvFQvnYles70lksDFjUReFixubt4XM1KJFUKiFpI9eqrccxbZ4fHign+MkWOAwuzJNzFee0Mi7vVV2QyrsaEXUE2Ec77pabMoOEaBjrxO8GW40NCU2/+1Kgx0bYBFyDFDETrh7vNFDOjFIhXxfQKqPNzjUHm2q+lADPi7yRfJaneRcds5FBmHUfdJEaS35ax49xnNIqfAhmH4dwGYxdV5rqbdg6J+iblwOJo2xa4Vea8ptLmxYu0eq44YuwlYlwiw6/t6zDGLtA6WRvKvMC4pwBl/I4p/GcKslo8Wlyv2CJEbLL+9qOaDVeu+/v5lvksW+JzV7qNISfAp9jc2WtxPHGQwz6GtbrVMwhzZeTa8lnMpFfz7EwX287hioj4vZYOVS0QSDzKaKCwtWiVD59BszRqGGCIuxYEvINPkJW4KP
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(106356001)(68736007)(76506005)(53416004)(956004)(105586002)(11346002)(7736002)(305945005)(107886003)(6116002)(53936002)(316002)(54906003)(3846002)(69596002)(478600001)(486006)(50226002)(66066001)(2906002)(186003)(16526019)(48376002)(47776003)(5660300001)(26005)(97736004)(6486002)(8676002)(7696005)(52116002)(86362001)(76176011)(51416003)(8936002)(476003)(2616005)(16586007)(25786009)(1076002)(59450400001)(446003)(4326008)(6666003)(81156014)(81166006)(7416002)(551934003)(36756003)(50466002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4585;H:localhost.vmware.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR05MB4585;23:ZN+jjEIFSBt9Vw/8isAj/B3RoMP2pwwikTcybeBEw?=
 =?us-ascii?Q?aoXsAu8teriYq7+bP3hqwUb16/6AWw5j+88vNcxgmvYQ0myhhS6Ex2Wx68uy?=
 =?us-ascii?Q?qw+/3jDbUOTnx5wLiscyutLNJEuEbMig9Ft+5kdCRM5WfLjJsauWV7ZIYUvW?=
 =?us-ascii?Q?sltKjVq8ty3yFLfWr2mhPYccGnh9tgUC7O/zG6uUo3+LRIrp/yWW9cBBu2J7?=
 =?us-ascii?Q?HmhCS0mxWKkfFeiqHksdiFXQ/M2j8zvp15NCRc8uPfEKtS4m3+qCPt4BIRDU?=
 =?us-ascii?Q?/u4hVJlNQNDpLkclreH2m3GP8A8VpreI+Hm09GkSaUG71iQEJsqN8BZyTzl9?=
 =?us-ascii?Q?Nl4BSn0lsV8lEDaMXRXkjYJywLSszls4DZvNIyOkEg5M2Bjxn8z6r38vM6DF?=
 =?us-ascii?Q?5BE22GO4IurtfVoGJ7OA6r1JrlzTYSVGKiuZxvhXrKAJLLuzsJLmI9PVUXzF?=
 =?us-ascii?Q?LZGSWnp0u3IXRAcgZG718IWu7FeiY49JvbC6pNCcBDmDIy5a/j6QgBrgr5Mq?=
 =?us-ascii?Q?cIExfyWxmeR75AmSFM26IqhSVdK4AifYndcFF5ZLWdda5GOjISNHlFVnfzkZ?=
 =?us-ascii?Q?/ePnO1H0Zs/1gJCxqjp0Nu2tzz7Pajq/uIEJv6aewe1m4cHd3huRZxAc9e1q?=
 =?us-ascii?Q?0MfYxNjLRklw/QKJXiGLa80oWiqKPS23f4Uv7G5RKrFvPd5/HecIbMTfM4vL?=
 =?us-ascii?Q?RE5THw4dV9YKyTXpjP5vd5x1st/Dyg/g4jcc4joPXGjhW6JlKUAKwvN9xYul?=
 =?us-ascii?Q?nIogBUIt63WMCChHS2GHXASMzB7J8E1MfhL4ObJD/0l0KjcJhSPZm7i9n/Uz?=
 =?us-ascii?Q?3ok45FF1R9TbPwTyQeVTRYN9CUMBCk8lldF4TJ4fKh+iRP0pU36Y7n4A6w1N?=
 =?us-ascii?Q?qYYidSfJV38Bbe2qCTtZz0k16wtWfAUejkHk9Eplwp9+2LmED5fCoJkB4Ahx?=
 =?us-ascii?Q?8p5N7r8CMIa35p39D0N7akbvrk8/ufiJWIWdw0p06kovYuZKGDjTiPL7qLDg?=
 =?us-ascii?Q?DOCCRpUitUrY0vilZAtaaPU24XVI615Zz6g7IMHt+bdAwA3yiHVdGMCWgWQe?=
 =?us-ascii?Q?KFhD0ImwckPdI7+wmLhgHT5xwz83tUKW1ehseuftoqAKrRPZea0JnEKueVJe?=
 =?us-ascii?Q?4qYGb1zczJ9vcyzyZTKVtZ8my4v04vVZLPscMByBsvvyabEBQcNeZTG3uIsy?=
 =?us-ascii?Q?Dibnjo4PKcJaD2G/GIP5g0W6Xs6qZxO0aNP8TMJOCQm6KzKvQ0Lh8zDhDNSe?=
 =?us-ascii?Q?jJWlELfk4wUGj1DFzbIFVd/nDwMj9CGg4Q5E0FXcBoYC0HRsp0FXM8B4rrqI?=
 =?us-ascii?Q?NNLYtLgvd05JWTY4l8ifXIyeVuRaFnxhU49bfcfJgW5KwyqtVTSZHcGfftF7?=
 =?us-ascii?Q?Q5QBA=3D=3D?=
X-Microsoft-Antispam-Message-Info: GNfSJONmuQMOiN7Aq1ECCNtXdbYYl94dze06GqrtTAyHt+hZh7UW/0/kGkj2ZF8D3bNBLfzBIUnrWBZDGTdxs68LmuOuONpKKuEQQZutPFF3Ily6bgeInT+tkXysLsquIZQ+t2oblpTfns7cqryCdQe+ZeVfIgL7ocIbk0Ytdwx3biqrqjH0O+RSgild6usKOx9ujfmTdi8fwDKZuePGuDibwX/FYDYN+s+T4m/SSb5xvCwAelhK0lvKcKR9N5xK9YPTW0U1SwShtB6ywrIOdEJHru0IWoymeiF2j5KHuBD+SK66bOrmPPHQz7ichHdRI5KL/0NYsgOEUukYeLPW4w==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4585;6:GPZnTKwd+PoF79oFPhwyV/dKtp8fS1cb0rY0+WS0mcGUbEiUtVlrsYG7SQYc0m3VnUqh5NG5hXJQRcUk0UxGG542KP+4mN1qxT8EhBmUdLWmkc1KUwRr+nINfnSRfeKlbyd8m8cTt09XSUIMbNRXJvZ0CAEebzu2YV2ebyV5rpBKd4uHfubW3MxMY9PvXUmMgknINzv8LT/z5ZAXCB0oxrPJFhvkocnwIBxo7SbgfCJ5Eh9ZoINKq0zyqCobaAxCvKTVBmAUItLfFrtakayBkctp6P/GAbaduBwFm8c9piXRUMYnTMPPuWbAJYSrIN7dvF72B/B2ygSs1HBkYnJw/+RqjY7xIn4Q97lJtFsU2tKi4Owu/aCDKqT9vVaT2a9ASNY460X6cEkOFJpn/wdo6ftcDBRN1w0dh1CuT3qzlgh7W9w5oPOKUp/eUKrv8jF6x1Ha5s3j47Q8kXsOIKqWKg==;5:3/+xpSKd5jjyqrphqEJeKVGZ7p8LKUghxnIgm/5uOg8TWrSfD/wUUaByfm6unQHDkVZm0ByIWgdw3SNrnaYXsffL00q1jbjVdDxAnTRDHIiiYWJJFMKskoKbj+cKzt9QVO/oTcImokMaW4jEvcQGMRQox58BIQ8k+WQPCiPRbPE=;24:vZ3Js5EOQPzpNOqui1s9udQdEwIIH6Lm01rZa24Slo/oi4zeHKFF84A92vtT6gqi8BjveRKoow5ubNhhMlWeIHTG9Ze1ymLpj7PDodLtEo4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4585;7:RuzJxbdTk1CYl5I30j+CYmhEozx2QkLL4AoL8IV159JZi0Nsbrh78RwnLgapOKrhNIRqBmgbPyfyMMflHTsKqwjTPbfitEPokFiJOSKKhdQTgOf0hsjS9sCSc01T3gAdA6kDze+fBs3bSogmtSAVTfs4ONmyVPTvYaxeNsbieOIOn3knaebdap2tUUOIGUf7MalCgizezolvfOmaCSLO6eaahYn1ix9KcoepVAXws327knRdpBnE+n9alhNBFC6D;20:6bFzxmO31jvABFTThQbuLr2JTNg7bnD8RaySQFU5o41e48S9V9kgB1041V/YxigJCIEtPISp3WSen04zOjft6rBhK9Lb/LInOKKn55+rxSjJHKxwO8GwVGAk5PgKirMiZODqP5cfeqGbH8EmIIq6uaJwFEsCLmMeYfpZB+wpRpo=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 08:25:47.7650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ece758-5c9c-4642-1d08-08d5d5be4571
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4585
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ziljstra <peterz@infradead.org>

Make the WW mutex code more readable by adding comments, splitting up
functions and pointing out that we're actually using the Wait-Die
algorithm.

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
Co-authored-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 Documentation/locking/ww-mutex-design.txt |  12 +-
 include/linux/ww_mutex.h                  |  28 ++---
 kernel/locking/mutex.c                    | 202 ++++++++++++++++++------------
 3 files changed, 145 insertions(+), 97 deletions(-)

diff --git a/Documentation/locking/ww-mutex-design.txt b/Documentation/locking/ww-mutex-design.txt
index 34c3a1b50b9a..2fd7f2a2af21 100644
--- a/Documentation/locking/ww-mutex-design.txt
+++ b/Documentation/locking/ww-mutex-design.txt
@@ -32,10 +32,10 @@ the oldest task) wins, and the one with the higher reservation id (i.e. the
 younger task) unlocks all of the buffers that it has already locked, and then
 tries again.
 
-In the RDBMS literature this deadlock handling approach is called wait/wound:
+In the RDBMS literature this deadlock handling approach is called wait/die:
 The older tasks waits until it can acquire the contended lock. The younger tasks
 needs to back off and drop all the locks it is currently holding, i.e. the
-younger task is wounded.
+younger task dies.
 
 Concepts
 --------
@@ -56,9 +56,9 @@ Furthermore there are three different class of w/w lock acquire functions:
 
 * Normal lock acquisition with a context, using ww_mutex_lock.
 
-* Slowpath lock acquisition on the contending lock, used by the wounded task
-  after having dropped all already acquired locks. These functions have the
-  _slow postfix.
+* Slowpath lock acquisition on the contending lock, used by the task that just
+  killed its transaction after having dropped all already acquired locks.
+  These functions have the _slow postfix.
 
   From a simple semantics point-of-view the _slow functions are not strictly
   required, since simply calling the normal ww_mutex_lock functions on the
@@ -220,7 +220,7 @@ mutexes are a natural fit for such a case for two reasons:
 
 Note that this approach differs in two important ways from the above methods:
 - Since the list of objects is dynamically constructed (and might very well be
-  different when retrying due to hitting the -EDEADLK wound condition) there's
+  different when retrying due to hitting the -EDEADLK die condition) there's
   no need to keep any object on a persistent list when it's not locked. We can
   therefore move the list_head into the object itself.
 - On the other hand the dynamic object list construction also means that the -EALREADY return
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 39fda195bf78..f82fce2229c8 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -6,7 +6,7 @@
  *
  *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
  *
- * Wound/wait implementation:
+ * Wait/Die implementation:
  *  Copyright (C) 2013 Canonical Ltd.
  *
  * This file contains the main data structure and API definitions.
@@ -28,9 +28,9 @@ struct ww_class {
 struct ww_acquire_ctx {
 	struct task_struct *task;
 	unsigned long stamp;
-	unsigned acquired;
+	unsigned int acquired;
 #ifdef CONFIG_DEBUG_MUTEXES
-	unsigned done_acquire;
+	unsigned int done_acquire;
 	struct ww_class *ww_class;
 	struct ww_mutex *contending_lock;
 #endif
@@ -38,8 +38,8 @@ struct ww_acquire_ctx {
 	struct lockdep_map dep_map;
 #endif
 #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
-	unsigned deadlock_inject_interval;
-	unsigned deadlock_inject_countdown;
+	unsigned int deadlock_inject_interval;
+	unsigned int deadlock_inject_countdown;
 #endif
 };
 
@@ -102,7 +102,7 @@ static inline void ww_mutex_init(struct ww_mutex *lock,
  *
  * Context-based w/w mutex acquiring can be done in any order whatsoever within
  * a given lock class. Deadlocks will be detected and handled with the
- * wait/wound logic.
+ * wait/die logic.
  *
  * Mixing of context-based w/w mutex acquiring and single w/w mutex locking can
  * result in undetected deadlocks and is so forbidden. Mixing different contexts
@@ -195,13 +195,13 @@ static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
  * Lock the w/w mutex exclusively for this task.
  *
  * Deadlocks within a given w/w class of locks are detected and handled with the
- * wait/wound algorithm. If the lock isn't immediately avaiable this function
+ * wait/die algorithm. If the lock isn't immediately available this function
  * will either sleep until it is (wait case). Or it selects the current context
- * for backing off by returning -EDEADLK (wound case). Trying to acquire the
+ * for backing off by returning -EDEADLK (die case). Trying to acquire the
  * same lock with the same context twice is also detected and signalled by
  * returning -EALREADY. Returns 0 if the mutex was successfully acquired.
  *
- * In the wound case the caller must release all currently held w/w mutexes for
+ * In the die case the caller must release all currently held w/w mutexes for
  * the given context and then wait for this contending lock to be available by
  * calling ww_mutex_lock_slow. Alternatively callers can opt to not acquire this
  * lock and proceed with trying to acquire further w/w mutexes (e.g. when
@@ -226,14 +226,14 @@ extern int /* __must_check */ ww_mutex_lock(struct ww_mutex *lock, struct ww_acq
  * Lock the w/w mutex exclusively for this task.
  *
  * Deadlocks within a given w/w class of locks are detected and handled with the
- * wait/wound algorithm. If the lock isn't immediately avaiable this function
+ * wait/die algorithm. If the lock isn't immediately available this function
  * will either sleep until it is (wait case). Or it selects the current context
- * for backing off by returning -EDEADLK (wound case). Trying to acquire the
+ * for backing off by returning -EDEADLK (die case). Trying to acquire the
  * same lock with the same context twice is also detected and signalled by
  * returning -EALREADY. Returns 0 if the mutex was successfully acquired. If a
  * signal arrives while waiting for the lock then this function returns -EINTR.
  *
- * In the wound case the caller must release all currently held w/w mutexes for
+ * In the die case the caller must release all currently held w/w mutexes for
  * the given context and then wait for this contending lock to be available by
  * calling ww_mutex_lock_slow_interruptible. Alternatively callers can opt to
  * not acquire this lock and proceed with trying to acquire further w/w mutexes
@@ -256,7 +256,7 @@ extern int __must_check ww_mutex_lock_interruptible(struct ww_mutex *lock,
  * @lock: the mutex to be acquired
  * @ctx: w/w acquire context
  *
- * Acquires a w/w mutex with the given context after a wound case. This function
+ * Acquires a w/w mutex with the given context after a die case. This function
  * will sleep until the lock becomes available.
  *
  * The caller must have released all w/w mutexes already acquired with the
@@ -290,7 +290,7 @@ ww_mutex_lock_slow(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
  * @lock: the mutex to be acquired
  * @ctx: w/w acquire context
  *
- * Acquires a w/w mutex with the given context after a wound case. This function
+ * Acquires a w/w mutex with the given context after a die case. This function
  * will sleep until the lock becomes available and returns 0 when the lock has
  * been acquired. If a signal arrives while waiting for the lock then this
  * function returns -EINTR.
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2048359f33d2..412b4fc08235 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -243,6 +243,17 @@ void __sched mutex_lock(struct mutex *lock)
 EXPORT_SYMBOL(mutex_lock);
 #endif
 
+/*
+ * Wait-Die:
+ *   The newer transactions are killed when:
+ *     It (the new transaction) makes a request for a lock being held
+ *     by an older transaction.
+ */
+
+/*
+ * Associate the ww_mutex @ww with the context @ww_ctx under which we acquired
+ * it.
+ */
 static __always_inline void
 ww_mutex_lock_acquired(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
 {
@@ -281,26 +292,53 @@ ww_mutex_lock_acquired(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
 	DEBUG_LOCKS_WARN_ON(ww_ctx->ww_class != ww->ww_class);
 #endif
 	ww_ctx->acquired++;
+	ww->ctx = ww_ctx;
 }
 
+/*
+ * Determine if context @a is 'after' context @b. IOW, @a is a younger
+ * transaction than @b and depending on algorithm either needs to wait for
+ * @b or die.
+ */
 static inline bool __sched
 __ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
 {
-	return a->stamp - b->stamp <= LONG_MAX &&
-	       (a->stamp != b->stamp || a > b);
+
+	return (signed long)(a->stamp - b->stamp) > 0;
+}
+
+/*
+ * Wait-Die; wake a younger waiter context (when locks held) such that it can
+ * die.
+ *
+ * Among waiters with context, only the first one can have other locks acquired
+ * already (ctx->acquired > 0), because __ww_mutex_add_waiter() and
+ * __ww_mutex_check_kill() wake any but the earliest context.
+ */
+static bool __sched
+__ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
+	       struct ww_acquire_ctx *ww_ctx)
+{
+	if (waiter->ww_ctx->acquired > 0 &&
+			__ww_ctx_stamp_after(waiter->ww_ctx, ww_ctx)) {
+		debug_mutex_wake_waiter(lock, waiter);
+		wake_up_process(waiter->task);
+	}
+
+	return true;
 }
 
 /*
- * Wake up any waiters that may have to back off when the lock is held by the
- * given context.
+ * We just acquired @lock under @ww_ctx, if there are later contexts waiting
+ * behind us on the wait-list, check if they need to die.
  *
- * Due to the invariants on the wait list, this can only affect the first
- * waiter with a context.
+ * See __ww_mutex_add_waiter() for the list-order construction; basically the
+ * list is ordered by stamp, smallest (oldest) first.
  *
  * The current task must not be on the wait list.
  */
 static void __sched
-__ww_mutex_wakeup_for_backoff(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
+__ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
 {
 	struct mutex_waiter *cur;
 
@@ -310,30 +348,23 @@ __ww_mutex_wakeup_for_backoff(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
 		if (!cur->ww_ctx)
 			continue;
 
-		if (cur->ww_ctx->acquired > 0 &&
-		    __ww_ctx_stamp_after(cur->ww_ctx, ww_ctx)) {
-			debug_mutex_wake_waiter(lock, cur);
-			wake_up_process(cur->task);
-		}
-
-		break;
+		if (__ww_mutex_die(lock, cur, ww_ctx))
+			break;
 	}
 }
 
 /*
- * After acquiring lock with fastpath or when we lost out in contested
- * slowpath, set ctx and wake up any waiters so they can recheck.
+ * After acquiring lock with fastpath, where we do not hold wait_lock, set ctx
+ * and wake up any waiters so they can recheck.
  */
 static __always_inline void
 ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
 	ww_mutex_lock_acquired(lock, ctx);
 
-	lock->ctx = ctx;
-
 	/*
 	 * The lock->ctx update should be visible on all cores before
-	 * the atomic read is done, otherwise contended waiters might be
+	 * the WAITERS check is done, otherwise contended waiters might be
 	 * missed. The contended waiters will either see ww_ctx == NULL
 	 * and keep spinning, or it will acquire wait_lock, add itself
 	 * to waiter list and sleep.
@@ -347,29 +378,14 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 		return;
 
 	/*
-	 * Uh oh, we raced in fastpath, wake up everyone in this case,
-	 * so they can see the new lock->ctx.
+	 * Uh oh, we raced in fastpath, check if any of the waiters need to
+	 * die.
 	 */
 	spin_lock(&lock->base.wait_lock);
-	__ww_mutex_wakeup_for_backoff(&lock->base, ctx);
+	__ww_mutex_check_waiters(&lock->base, ctx);
 	spin_unlock(&lock->base.wait_lock);
 }
 
-/*
- * After acquiring lock in the slowpath set ctx.
- *
- * Unlike for the fast path, the caller ensures that waiters are woken up where
- * necessary.
- *
- * Callers must hold the mutex wait_lock.
- */
-static __always_inline void
-ww_mutex_set_context_slowpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
-{
-	ww_mutex_lock_acquired(lock, ctx);
-	lock->ctx = ctx;
-}
-
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 
 static inline
@@ -645,37 +661,73 @@ void __sched ww_mutex_unlock(struct ww_mutex *lock)
 }
 EXPORT_SYMBOL(ww_mutex_unlock);
 
+
+static __always_inline int __sched
+__ww_mutex_kill(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
+{
+	if (ww_ctx->acquired > 0) {
+#ifdef CONFIG_DEBUG_MUTEXES
+		struct ww_mutex *ww;
+
+		ww = container_of(lock, struct ww_mutex, base);
+		DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock);
+		ww_ctx->contending_lock = ww;
+#endif
+		return -EDEADLK;
+	}
+
+	return 0;
+}
+
+
+/*
+ * Check whether we need to kill the transaction for the current lock acquire.
+ *
+ * Wait-Die: If we're trying to acquire a lock already held by an older
+ *           context, kill ourselves.
+ *
+ * Since __ww_mutex_add_waiter() orders the wait-list on stamp, we only have to
+ * look at waiters before us in the wait-list.
+ */
 static inline int __sched
-__ww_mutex_lock_check_stamp(struct mutex *lock, struct mutex_waiter *waiter,
-			    struct ww_acquire_ctx *ctx)
+__ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
+		      struct ww_acquire_ctx *ctx)
 {
 	struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
 	struct ww_acquire_ctx *hold_ctx = READ_ONCE(ww->ctx);
 	struct mutex_waiter *cur;
 
+	if (ctx->acquired == 0)
+		return 0;
+
 	if (hold_ctx && __ww_ctx_stamp_after(ctx, hold_ctx))
-		goto deadlock;
+		return __ww_mutex_kill(lock, ctx);
 
 	/*
 	 * If there is a waiter in front of us that has a context, then its
-	 * stamp is earlier than ours and we must back off.
+	 * stamp is earlier than ours and we must kill ourself.
 	 */
 	cur = waiter;
 	list_for_each_entry_continue_reverse(cur, &lock->wait_list, list) {
-		if (cur->ww_ctx)
-			goto deadlock;
+		if (!cur->ww_ctx)
+			continue;
+
+		return __ww_mutex_kill(lock, ctx);
 	}
 
 	return 0;
-
-deadlock:
-#ifdef CONFIG_DEBUG_MUTEXES
-	DEBUG_LOCKS_WARN_ON(ctx->contending_lock);
-	ctx->contending_lock = ww;
-#endif
-	return -EDEADLK;
 }
 
+/*
+ * Add @waiter to the wait-list, keep the wait-list ordered by stamp, smallest
+ * first. Such that older contexts are preferred to acquire the lock over
+ * younger contexts.
+ *
+ * Waiters without context are interspersed in FIFO order.
+ *
+ * Furthermore, for Wait-Die kill ourself immediately when possible (there are
+ * older contexts already waiting) to avoid unnecessary waiting.
+ */
 static inline int __sched
 __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 		      struct mutex *lock,
@@ -692,7 +744,7 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 	/*
 	 * Add the waiter before the first waiter with a higher stamp.
 	 * Waiters without a context are skipped to avoid starving
-	 * them.
+	 * them. Wait-Die waiters may die here.
 	 */
 	pos = &lock->wait_list;
 	list_for_each_entry_reverse(cur, &lock->wait_list, list) {
@@ -700,34 +752,27 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 			continue;
 
 		if (__ww_ctx_stamp_after(ww_ctx, cur->ww_ctx)) {
-			/* Back off immediately if necessary. */
-			if (ww_ctx->acquired > 0) {
-#ifdef CONFIG_DEBUG_MUTEXES
-				struct ww_mutex *ww;
+			/*
+			 * Wait-Die: if we find an older context waiting, there
+			 * is no point in queueing behind it, as we'd have to
+			 * die the moment it would acquire the lock.
+			 */
+			int ret = __ww_mutex_kill(lock, ww_ctx);
 
-				ww = container_of(lock, struct ww_mutex, base);
-				DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock);
-				ww_ctx->contending_lock = ww;
-#endif
-				return -EDEADLK;
-			}
+			if (ret)
+				return ret;
 
 			break;
 		}
 
 		pos = &cur->list;
 
-		/*
-		 * Wake up the waiter so that it gets a chance to back
-		 * off.
-		 */
-		if (cur->ww_ctx->acquired > 0) {
-			debug_mutex_wake_waiter(lock, cur);
-			wake_up_process(cur->task);
-		}
+		/* Wait-Die: ensure younger waiters die. */
+		__ww_mutex_die(lock, cur, ww_ctx);
 	}
 
 	list_add_tail(&waiter->list, pos);
+
 	return 0;
 }
 
@@ -771,7 +816,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	 */
 	if (__mutex_trylock(lock)) {
 		if (use_ww_ctx && ww_ctx)
-			__ww_mutex_wakeup_for_backoff(lock, ww_ctx);
+			__ww_mutex_check_waiters(lock, ww_ctx);
 
 		goto skip_wait;
 	}
@@ -789,10 +834,13 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		waiter.ww_ctx = MUTEX_POISON_WW_CTX;
 #endif
 	} else {
-		/* Add in stamp order, waking up waiters that must back off. */
+		/*
+		 * Add in stamp order, waking up waiters that must kill
+		 * themselves.
+		 */
 		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
 		if (ret)
-			goto err_early_backoff;
+			goto err_early_kill;
 
 		waiter.ww_ctx = ww_ctx;
 	}
@@ -814,7 +862,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 			goto acquired;
 
 		/*
-		 * Check for signals and wound conditions while holding
+		 * Check for signals and kill conditions while holding
 		 * wait_lock. This ensures the lock cancellation is ordered
 		 * against mutex_unlock() and wake-ups do not go missing.
 		 */
@@ -823,8 +871,8 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 			goto err;
 		}
 
-		if (use_ww_ctx && ww_ctx && ww_ctx->acquired > 0) {
-			ret = __ww_mutex_lock_check_stamp(lock, &waiter, ww_ctx);
+		if (use_ww_ctx && ww_ctx) {
+			ret = __ww_mutex_check_kill(lock, &waiter, ww_ctx);
 			if (ret)
 				goto err;
 		}
@@ -869,7 +917,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	lock_acquired(&lock->dep_map, ip);
 
 	if (use_ww_ctx && ww_ctx)
-		ww_mutex_set_context_slowpath(ww, ww_ctx);
+		ww_mutex_lock_acquired(ww, ww_ctx);
 
 	spin_unlock(&lock->wait_lock);
 	preempt_enable();
@@ -878,7 +926,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 err:
 	__set_current_state(TASK_RUNNING);
 	mutex_remove_waiter(lock, &waiter, current);
-err_early_backoff:
+err_early_kill:
 	spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, 1, ip);
-- 
2.14.3

