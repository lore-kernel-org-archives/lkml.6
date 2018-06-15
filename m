Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 91A76C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D086208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="AFWLs2pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D086208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756091AbeFOMJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:09:12 -0400
Received: from mail-by2nam03on0061.outbound.protection.outlook.com ([104.47.42.61]:2752
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755816AbeFOMJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy6boBGdwuS5FZrb4JniTgAnOCVhYoeT0dVE2Jq2C9Y=;
 b=AFWLs2pv4AtPwX6J5/A/arSDHUJIr6AS7qLkNskdeapPoORffQaoDb2yMIhtH3FvgikDQFAXJ5m7dRa3z2f7wpQI6yxyfN/9y7rs9OF7WvP56AqfHLnJC8MzgdmjU9ngcmk+TCvg4idBBfQFYmmgbpkqxY3Ee+hQOFjcDoWU95Q=
Received: from localhost.localdomain (155.4.205.56) by
 BYAPR05MB4583.namprd05.prod.outlook.com (2603:10b6:a02:f2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Fri, 15 Jun 2018 12:09:02 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Cc:     Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
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
Subject: [PATCH 1/2] locking: WW mutex cleanup
Date:   Fri, 15 Jun 2018 14:08:26 +0200
Message-Id: <20180615120827.3989-1-thellstrom@vmware.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:7:67::34) To BYAPR05MB4583.namprd05.prod.outlook.com
 (2603:10b6:a02:f2::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3b1dc82-7bd5-455c-a4d9-08d5d2b8cb4d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4583;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4583;3:GrVPUxHWFg0EAr5jWhqDE22aSpQsFScwMq807XOa+gnXwx8Z0bX1sVxHgG9hsmgV3d3LNRv2T1H1df76BjqecmCQjtUlF/aFSLsSwgerPLcpMmESusI7nlJA5TU9yWZJqqNrdnDgw7CxyhrVPLxx8OlsxG2qo7VroR7r2MrK647hcuVK9WNS9O0DpkfkXRZ5ePJbP6grZvagtCbbIwmZBPjOjjEKLe6RL/j+y/spiu1BoUqSKzKJ9qSM8sv95dtZ;25:X1/VygwZNom/7fYF9/8ryNpWqe3KwVKQ4naN6nOMEopfUj90+BwiqxSrw5Lyxnk13gdk/pIeSq+Crt/FX6aTdldr7spB9D+sJtGbSxwzo6PiW1Pap0TI06XJrMKmIwxkuJ5HFCwnvqKfIbODevvONlgKkdTN8cuuBPmqIIh0HaGcyncGqbngcKTKMH+AqEs3THwVp+L8eoq44Nu7QkqQBd+ugU6badVvbhMaEnxt4KeVurg2ehbyoPo6fvDYgzodjG8Sf5EowRXwVRNU3lumPymeoNzXKL41hJj2MqIPZK16M5UrgOw627c04c/qfhb8VxaRuxzsUHCtA1R7mGdGRQ==;31:BnANQG76atpToufY3FJw0CdF/EdPZtvYR7kOC94pTewEdu2FHQHK4F+9LNDSd6EB2ae/8xxMtFzfHKE+9r1a2z7XaRu0ZOstTenh80CAxfkCfjjYBwN+keMZbNnRQFGSrUx2u7uKk6d4v+cWG6pY/Yt255hoMzY6pk7sy6Ae1OcBLPzck5C2v/prkq9flEd1QcDIGcaiXfxB56PPu7d9ytyejVguvMOiRzY6iI3RRgI=
X-MS-TrafficTypeDiagnostic: BYAPR05MB4583:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4583;20:tK6VmPnzuyn0GpDsizU7xjPaX7IyxBm8olgit0PSWlotbp+c+Jse+kBt2OFlncLvGC9u76jg4Z/y+I/1Bx8zWwjeOXob8LIk55/Qdt6utP+CUTNkZhfJTRY522dlX5sObGl3UwT8TzyGMp/ARuuO5qvLIvaI5131Z6AQBQY0euQvM3naUAvoPOYTORagJ8aEjJ89yDzfIq2kr1BZ6XvdggMpuC3gLhrLslfpZ+cQ6ixcTjv94Rc8VZUoHLLdht95Ryrc5ABocknoJ3rwJqSeHD/djl8M60y2vueIkqMJ/cdBKnU/NnBvlxzfz8TVLVM9u03x3eAN8pxTEHdrrRfkJFU33WJiLQ8it4dYLNYPwfNkdutxXWBjwZlEyA647lNWsho2E8h9+BpPNYM/x40oHDpv82b02Oy5LK9/bopEpqE9n9pCCXstJ8JCz0hNbyahW/FbLbNbWJ6Lao5Q8S9pRxcXjpyGP1iGuQIPtpx0SOi6EfP3jCykNj5ty4OFrgAA
X-Microsoft-Antispam-PRVS: <BYAPR05MB4583CD9017DE138C965A290BA17C0@BYAPR05MB4583.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(9452136761055)(1553240931313)(104084551191319)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4583;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4583;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4583;4:yiGRvXdJd189crQSmDb1HbJtoD3j3RVj160xS4VG3amR2y7HVtrMqZFfhq+aSB1t4a1mnpj1+g+UHkbygIu133b95Aw/FLhQ6lIrlAQaLVp8hagxScuwuZsSNUuqCxAFC5U7FkksqmmffB3vFF9JmuhoSYzXJXMVQHLUAJMKsuyJVObeFQiFaI57LK1xyW/tWMwc+7Su3+RqoVZqXspWwoK+WA1/Fv4Gnh8leGqOXe4BCLIc55vxMnN7dR+tUiwRzvtiMv4Z0F3f4QVCZkz6YLZYfi4etDDj2FbmCXi8K0exee4sZTwYWyblhfYyiwIe2OQX7iMbfnjg+3IENwpK5nsBIAgGGhFO8SYhw4b+aTl5IjZ03VnO2rYHLKsrSlq5WZ9xqIYChYUAtulohGOX78jg3Tgz+BOQ5N5S9E7SokqAigIJMMKlOs96yZUHhFDw
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(39380400002)(366004)(346002)(39860400002)(376002)(189003)(199004)(5660300001)(8936002)(68736007)(305945005)(6486002)(551934003)(36756003)(7736002)(1076002)(6666003)(2906002)(105586002)(106356001)(3846002)(478600001)(6116002)(50226002)(97736004)(81166006)(81156014)(54906003)(16586007)(47776003)(186003)(25786009)(386003)(16526019)(2616005)(26005)(476003)(316002)(956004)(66066001)(52116002)(6512007)(486006)(51416003)(59450400001)(50466002)(86362001)(48376002)(7416002)(107886003)(6506007)(4326008)(53936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4583;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR05MB4583;23:rfWP2l+6M+LAnGwVXdbU2HBKzB1UIkHv99mOcY9T9?=
 =?us-ascii?Q?fxdn/RT6uoUlNhGsxTtICrYjxHrYx4TySNxPypraoxKQaeZ7pFZTFQ8if5lI?=
 =?us-ascii?Q?XDtbwC0TyJ593VBKhOaqbigEGv02knRnNfZVrcFdZoRLvvbJ7EkNQ0cU75c6?=
 =?us-ascii?Q?RSEahmNf79wrHe9Ogtex8vYOF8HdrTCYMOTS1iEaG/6VyOwggWGFnM4aKJ5h?=
 =?us-ascii?Q?uPgBvsZNn8vyK4WIzE50mllgsPkoEWc1kwUsLscYfbJgEmecSqVdkouzK1z4?=
 =?us-ascii?Q?EtPhWHV3rblv0/xGBa5pjhvQapE8Cd8eo6kxazTiqNaTVbdhm4E9II/fBnte?=
 =?us-ascii?Q?dJFIksP3BPgyWECDIvGNZVSRfwMOgSWzGhToO3kulXwK5lg+60Ha7IPg7HC/?=
 =?us-ascii?Q?LXCAeNwW+aYIb9XjfJMQnKQQEklVxDeaWOi5eACT/a41BEN9mUgBjBj5uQAZ?=
 =?us-ascii?Q?ynm9vzt3juWrxteUi4/WxQou5NBtopYHwRHu3La8agiF2M3yZ4A8BqPiMbvk?=
 =?us-ascii?Q?6kz2rjd0oDJzQz0GqDNQ5WYJttX8JcblaRlfj/V304yl2xz7+CT8ZoF659iv?=
 =?us-ascii?Q?07i+8AS9B+Xm5WoK29m0W2D2xP7GP41YP20p5pSuhNNyjTlFx/7IYPU/nCKa?=
 =?us-ascii?Q?2Vz3lD6u2puLyto9Q6rJ4ZDPcnv1Moz56V7Wsdq1QF39MoDTO7WDoc7Hw/Ks?=
 =?us-ascii?Q?CM67nerQkudP11Ns9AnIwxxubrtYIOZ8u/WLS4g3ktnEfc7B7gJRCpAYVbNe?=
 =?us-ascii?Q?4phgaw1p76gWUgOIiI90e2+DPfHzQIsmtAC5m1UUaGj0y+1zI7TVR+ZqAJb5?=
 =?us-ascii?Q?IM9i8spPQuEZUH5mmb/5Q72A0DYuXh6Jflir6BB4U7RbAgeB4Kv2/ffTjSh2?=
 =?us-ascii?Q?YwwixS8Xbag0cH1njIdPZqnkFu95ib+nyXchutvrZBRRMpDojHOOnA2cgzHb?=
 =?us-ascii?Q?TL6Kiymt0UYNOb4FNN/9GZoyvBrirKvvbS5VyPLvgpgeigbmvzvcEoka3Jce?=
 =?us-ascii?Q?uh1UJRUVUXg1vLTYHyIkDLmHGK8Z9+eMjD56Jp8Gs6CvD8WJpvIB9FOtJnUQ?=
 =?us-ascii?Q?DkaTnphpU8gPlY/3+AQ1ZHiGSgTCTPxgTzf1QMq9FN3lBbNgMg4QgHoh+IAc?=
 =?us-ascii?Q?O57k8X1VL01hnghP6GudDgT2l58x9PRS7GuosFDJ8LTpnTq9g2XvHYOmlgHX?=
 =?us-ascii?Q?Q2pCvqQ6IsvcybVAHk+ui9HiEVYB5/vPfwMQXhhhDAxuaoibFNgcOHGaFPdr?=
 =?us-ascii?Q?6rMXsIeCADhSeYX2rQ=3D?=
X-Microsoft-Antispam-Message-Info: GoDSz3NLKOkNPi0YKJD2Gz1qonNct+kToRrdXGqOmpsUAViKqh4JJNXW/XQ4f+FSuYYeuGBMH2s0X2s1K5SCFKzgFZUsBbI7HBaLT2+o4n8cELj9y7Yf2o/AMPhRnuzT4l3EcMSgBk0HyGS2KZNFB0tyJymL8e0cdYIlRCv0RyT/guRkVORG3e7QFnFeQ2jl
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4583;6:REqIfb7huJQ6l4NBrbcMS4dc68KLf0Hwx3UaAXCdCe7eeiUOQGNlmUaFUcYLF8DcNbQAsoQnzV1BGRkBlXBFKZmxMUTiJc7JhagBqd9X5MBz8ENqfLZriqQOLJEIuILsKBlJIDNjkTM4U8XugMUZ//S1WmVIuuzvl54Zoa7804O0S3wyx21wDS3AcF97S18jPbggRhHxW2oUbZhtXjps6YHsIyf4MQOzXv7fe4n0Bt2j71Z711Cx2p0ZbATGDhwW7PgrJRjyukRgQk20mI5F9OukJjWCGyRGnrOxu+tSG73xDJ+OuaG5Fx1o+sQ5LIqTEC895FEREOwzHt6x2kzKVJso90Leu4WPBtmlIcDbXZ6YlbGIrn/anicsfhkmX+1RJRzQ2u8U+KqMlqBoxJvw4L6z0zEkWmwR033nP4Hw+fOtAKl1RFPyCK57PDRGMIe+fJgsxT86rAwI696mpohlCw==;5:tDVJyRnkYEDAXNkwwdu3MtSA62iyQ3rjKY1NhBtcfCsJ4PPdowEnmaLFySKfU+KmKk3DTsbHbQHLb7//2POzcin8C3Kie2grcmC4n1yG1QnVXcU3GISzqYVoupi6G3o1ypq+sIhvnZIbfC/2J+IFVIqB/TdNQukzB1YaodlXZlI=;24:Qp//RrmshK5JtKjD2zKuggwALTTW5qOQzsucPTT65DGV92y0+2MbAxHC+HGMA9qSaUi3Il1uws1i8H7ZnhgrVlXs2whHCvcf1xQ9sNtGYhc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4583;7:JKmNHmLPMlkQA8vgKdeXwoTATCmclPWMCierfBLx9330M9zJDvOVWAM4ORI2DAA5VDHrzEmS/YmoTG7zek0QLNefEj2jMLKF/Fty3qJeqPeqv/7IAEjVH3evgVUEmrVfXee2ge5Q8l0Rb/5IroF0JbFcuiYRAWhtXoFJ5pLkFRD+bIDQmtPFB/pJc8vHZ0APoIxPZguCVB+NIRQS2LnIMBaF1R8kuMPKaFq23ve9gyTkkaLhLpRmq2dIZy/d9W7G;20:10IhI4u8IrNrGZbAFG0sW/WBMi8COjskv7Mt3GvfYVU/G6GfsJzd1oLgY1nnxj7LdHqTZAYzw8jH9hyEw5pQAgtCrX9rJJzbmP7Qj4Hsxd3Ngu0f9uPxuZvyyabXYyZAp43TWopiaqxc5MkEZkIPvSpAPtwjHJpaSbJHZuVZiw4=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 12:09:02.4309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b1dc82-7bd5-455c-a4d9-08d5d2b8cb4d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4583
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

