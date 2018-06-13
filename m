Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 86864C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1F1208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="jp4Z+ei2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1F1208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934804AbeFMHsr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:48:47 -0400
Received: from mail-eopbgr720071.outbound.protection.outlook.com ([40.107.72.71]:65056
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934508AbeFMHsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciWhR1bsE4PGajszOpEctfkJsKOSNlEIO9jnT3dqm3o=;
 b=jp4Z+ei2B1dH/QS/R/KUvIBP7dCHMf+NlsuI/HYbkIor140xHpdL/k+r7r8yPHo0HHfBpvw3yBwwcUISgn+q+Wxaj1nejNucX/Xf+T2L63ERMjdMAawkQPHRHCdIzZElSB8Kys0fjN7J863BHNxQoybQeblJuuNhYAevLzD6gz4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.localdomain (155.4.205.56) by
 SN6PR05MB4589.namprd05.prod.outlook.com (2603:10b6:805:38::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Wed, 13 Jun 2018 07:48:32 +0000
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
Subject: [PATCH 1/2] locking: Implement an algorithm choice for Wound-Wait mutexes
Date:   Wed, 13 Jun 2018 09:47:44 +0200
Message-Id: <20180613074745.14750-2-thellstrom@vmware.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180613074745.14750-1-thellstrom@vmware.com>
References: <20180613074745.14750-1-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0402CA0057.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::46) To SN6PR05MB4589.namprd05.prod.outlook.com
 (2603:10b6:805:38::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33643625-2d42-4ee6-b8b8-08d5d10211cb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB4589;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;3:E7RqlVl8HgTpGE9pRBsvkxkQx3k40HTXY+REMJHNYvLhQB82pcwDXyJRJxrrT6FsCmzZxDGMSqSb3MqrYVTXb1RwLto0Yi3GpJ41GZSW67ntN3XXUFLvHWc4cQUsiC5uYjXd+zboiBRvOBRnzjnSl9GyoSJPNc3vRZqWqaS7NPQ74/XaTlhQFsIX5PG+ABDb5g6wn5XKoslTq0fTCL71RnuJhFw8IMRD4/yPz2WajIoMlcHJSNpNCM61QQ7xsanH;25:eDtsOWvWgqndM84TMEr2WT/pLZmYXdDsh3Ae56PCwYPHLQrc7zpIVe6La0iPimeBmU7Jsp6lyLAoZVJ4XFUL+Ixwe/F5SVj9151HhuC/NBy/pYTY71bwNxEqo46qeoh9L6aZGTsUvKgP9xIQA2R1FxQ6g16zE5TvCE4ihuvo+7McdnuBYMUsG+Eiqz5SwkC3lX09gaW1WkYt03+qesrm6olHCYJTabLlMRRXhjjQBsPwZjkPCesEfuLnSSf/Zfh5v2qOcez5gYSDL89HdZCVBiRi/Kdt7gZjw9kKgRG/s41QjLjFJG05I6L82CwJ/dz0TfphCFLQ4yDjqWE8iyK9gg==;31:YZ2imemwOnRb3ENBsGeNUYgv3xjg2EgiQCpMB9gIZrJxD0QO6ty+ui/TxvNjofRwj2AZMdIQYmlztXHExMUCpxfxaSTrNTFsiALtkpXczxIwgSlIXxNiPmBStiEsKdOS2IeTBw934J6Lo7OI41e2J/q9OgcEosEcc2pJu3mN81zumAik8b2Z3LK1ju8F99LGeVlO5JmvfRKcy/cwvf8D8bmY3W82kURK9hPkT0jms6E=
X-MS-TrafficTypeDiagnostic: SN6PR05MB4589:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;20:fbK/x9VHpJd7aoXtyA00901oidesEZsnZB73Ognw+QmQmZsP/ieSrHFia4JXPPALP5+lLqRlIpt9b5rKmv2AJHpMUMC92DFRVfwuU3vTMhALnn/wwK138KZv3w1+Ib02fouE3rqnJKhzlfsC8QT1HS0/UybAF6wOq6cUMCRqbphND7N3fB0cYoOctfIo8jhEku8DlK9ogWHlqQ4iQxuQlcOZf/ZmHyw0ccOobXfdgb9oYfDeLXe/i6htkumS7hLHre8ZY/iUH863SYN0sGSBaWcuSQWGZRutzKgQS4JZFKPI791bqhWb/t9edD14kOGHUUQ2elhqnk0T5iWIgg/hq874Abw2ivb+Q2dRKYvN+chDvOeJH0ACux5S93p8rMJrEW07ARExaJ76Fk6iQyY+lon2DH34Y83kgVOBL4pctrM2hVqlddsYH9vS4Dfim5G3Hk1LERW9ARiBqkM0EjZB0lR0GWGriLSIbceIRcmA8bCWAPcUnI8l8ma+Ip9T0uy7
X-Microsoft-Antispam-PRVS: <SN6PR05MB45892AE8D5481D65C3FA70B8A17E0@SN6PR05MB4589.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(9452136761055)(1553240931313)(104084551191319)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR05MB4589;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB4589;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;4:I7+xOpDSvmf0aoBfhOtvqhir0CIwfsQ+8R8gGBsj0sTGMu83J4ANK+rBUJtn/4CJsFHbhF+Ii5Eva1H3r5CF+M+QJ2/JGRJWoX1kKqMWFAQqkpz7CEQ3H+xblJIXk/82eomJHcf6/287evxTc7tIPBYPeXExH0R/BnhDHQjzEaBgPlKd7tk4P8w7e6ogwE1jEKfgp5W+/bt76ajnb+cx+Edz/5BxeamEg0gSuzYEficevZEo69djl3DFOcWCpttftlLkbdqJQMvUv4G4h90gLRncdf1SfuBldA8PICKp6bj1Z/oazRSG8xW/gKqtQy3OYLYxS76k5DjsZLmGZpeLK6Mt/5gzqUGYwTscy6J8fJE8s16JRKcESnwf1Mn5osjrF2d2R8cPfvmhCDyLgeBeThMvQb776D6dq1pfDeY8SaR4Fm31DV6Z8Wh6uhJKFkdy
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(346002)(39380400002)(396003)(376002)(366004)(199004)(189003)(81156014)(25786009)(476003)(186003)(551934003)(16526019)(478600001)(486006)(6666003)(2906002)(106356001)(48376002)(50466002)(53936002)(8676002)(81166006)(8936002)(305945005)(6512007)(7736002)(26005)(956004)(2616005)(6486002)(5660300001)(59450400001)(316002)(6506007)(105586002)(386003)(4326008)(11346002)(446003)(51416003)(76176011)(7416002)(52116002)(16586007)(54906003)(36756003)(97736004)(47776003)(1076002)(3846002)(6116002)(50226002)(66066001)(68736007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4589;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR05MB4589;23:NHrnbrTc0pRQhE2iTDQHmdDcA10pB1KtFQeBiGbPL?=
 =?us-ascii?Q?LOkf7QO9hVbl7NjpaFWOhdoH66nz2EgSQTyYT3Ke04IB6wTPl51xZYNBXP2J?=
 =?us-ascii?Q?B4i/GPAPYmgIS1yMFNUM8C5lLp35TavETdhK5xyBonQO9aKNy6wBQYYcdGXm?=
 =?us-ascii?Q?tPsrq1rlWNjgwpjWGNyzmkY/F43abyIhp8zr1RGchYRIVQQgu0w/LHZthes3?=
 =?us-ascii?Q?yeIAC7P4kuoxpQ4h4Ujrp2uYMdJB5Km3R7ANSc08vHblKxIR6C/r8HqqQd91?=
 =?us-ascii?Q?qQ/wXb/oyAMXCNvKz7p6spd2YWWq7647bgzrFqWhwNvTidhCvg6dzAvQZolz?=
 =?us-ascii?Q?r/4ou1fSM59YlAmqGuG7o5RtlHcb0QOGGDrlz7nZ/O6T6lWGYsfiMwPejnQx?=
 =?us-ascii?Q?/WXq4BBtIC0Z9tJOQ02LEdai/No10LJRPfUIvcn9r/pedWyNNlcxMzqbNi71?=
 =?us-ascii?Q?+pFOo6nxpcn/jgsfFwmv6UPx2rc0TPHNFojiC6ISJSwoQoGyE/rtHUfwhpho?=
 =?us-ascii?Q?4F8lecT8e0zwjHOdrxXlKOj1dTJDr1OzSoJwpzvucEBiyUXn2hoKinIY6Sjh?=
 =?us-ascii?Q?4HJbneId+ddQjwqUpeGQlkDejUyeMeLTNk0NjfYT5aH7lWrf5C+k/G8ehPuh?=
 =?us-ascii?Q?t57xSHUfIsbqOnX7+FB+NkZGW5CKLJymfsg2wBb44idSytmP0VZCvCi/7eZN?=
 =?us-ascii?Q?/X4IlFiEvT5UH8U4ptiL6gUFphDv17v0/IQPvrBt7CAiFFC1HLBi3l6mBO2O?=
 =?us-ascii?Q?J5GOKMsvQr+o6eOohuB6njOfLMevUz2eQg+dgZbeEoy9XP6MZ4QEGVI23VQA?=
 =?us-ascii?Q?XbuQ4edhKTaof5bTn6DTXuKE2pWPiSZHsIGrrOp/kZ0Hyiue6LDgZ2sDTgL+?=
 =?us-ascii?Q?XfgbqAfoH+WxXPshBMim8NLsZSG+9GZRUjDP/00kF1/Ah0aSFqfufT/f9lXX?=
 =?us-ascii?Q?S3Vd03zD13Y71J6Uu5Wc9VPxN5j9enYQ/p8IBB8uef5/29k8mGAWv1YE/l1S?=
 =?us-ascii?Q?rrKg6QzBrCQM/ILwid5oSL+dd6+/XvAcEf/nSUCETcf0g7N0uz/86pBcjhx1?=
 =?us-ascii?Q?b0zSLNhQJBrzcZNqTK+C4TCCauSfxUc+dmVk0Bh6IWp8taI+YAXh4m+IAwQM?=
 =?us-ascii?Q?zT+hR50VhA+DkIr74yh0Is6Q+SxTPR+ZxIoWh/ofHdO7zRfEd78eA7L58grJ?=
 =?us-ascii?Q?14PTDa8Pub+2UC5WckS5CkGzKi32L1aEr5JNp1Ch2sZBlZA/YrGWmM5XfYaP?=
 =?us-ascii?Q?nUPOjDu8kjfRiWO/HgCS7TJt3Ir7RlLZr3jhN5Jrg0jewXh3YlVN7AGT96XS?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: zmEmolCAKRcZJKFnpcGsdVAA+5kTMVmuDxEq1Br3S9KTsArywl9lLz+xDOM5vwPG4f7moppxTxKa559KoPmpmFZv7M9J+PFeqU5GeRzbFIUYpEnRK53fT1BTz66cW4hKOhSI3zaeMoXch/U/UnlGIFBum26cy8YSIr6aciB1Ci7WtpEv9u1b/8xwYA7bnK2b
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;6:2dDyMfTL7cuo/Fb/UZ/86qxd611aAixVYDKJaJZ1lFx4SSB68onLNkyLWnr/lnP43IGZrfPOdwx1QVu1IE1tXjA/aATg5zhXoTIweQ4NriGRcxNOPl7Jumk30mi5UhSt4SH4C/XzVUfUcx1MxsxNZ03fDb+VHSWMeoUJoXVgbofFZjmDH7McMxaxAEy2MtfBcM/xUD8VdFdQwSf6TEsL77GDztK7FrJhc+rWTZ5xzIS7scKs7YuPuNxuPHLzAReB/cU2WIG1vNCsxXAJ32HFsWjmaroisnP7wp1PmC2dYxus99o164ZSpnP9ArPWlIhuXswADmlnYlmEBFw87me0IfT20bQZZjuYPCD0IyRvH5GROEp4Rvs4WcTAvglRDo/LcPD+nhCENazkWFrG1f+1UDe/QYd8tRn+feV0pdnHEptbo+ZXJW1qyVhLt2AeLwXsaplwFE5gd1LhpJVELoJE/g==;5:iRUcpqxSBnXzSybV7VsxknPBcgVc5dRhH08kG5f9vL3Q/kp1wJJhzJjEse7cN8Hlb6qkiudNdWU1pmr7IknJkFsB4rUmG5zFY03OIhybs8fd5VyoMyko5YlmIGFbqEzQ22oERUZl9kHpYtUzsSxLfvboUgrMWykA7V9xmQgiftE=;24:ov4lTwGdoADvEsEuFef/KzMdFI4MCGMZHbK9OY0oOGf3LYneIo3qr78Q8R87o9AoNTos0l9wGt86DXmBr9TToHybgMuI0s0a2KKhj//kLlY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;7:BMTi+xMq3pqeVSCy80dd3H4uXh4NVdnQjiL7E60zcK3hh8wg1XQG/A6MUyZ6RN9hlHAUmFFHIp1qZ9a8KSc05sqbhPTiMRxLRKGy3wmyicL6omUTOWkU11TXofe4pEi9bQiQ+Si93bqWjuEPdrX1k+mvDAvXRAr6nbDvpQdlzQezSbx/PvtyiLOsyV2kQIP0o1iIiaGePOQPDuDM0QIxwr9PKfGKgMDsekGHAKN4Agp06sodWP7Mafr0tj96n2VQ;20:IzPI1woiT2/SByMkSSVGBWtqkdpMdBB7AFUXigfyZJg87/GMmot8LGtSL2z+tYm3sVbr8iR+JzypDZ7XGiO4N3xSV72hP/ooBl+jb2921Drk8+PlR8afRumlKAzbLRJVnrbZcbT0yx5kf3iwBsUBP4xLGvrTDbYyM1ixykqv/WI=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 07:48:32.2589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33643625-2d42-4ee6-b8b8-08d5d10211cb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4589
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
tag patch-18-06-04

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
 Documentation/locking/ww-mutex-design.txt | 57 ++++++++++++++----
 drivers/dma-buf/reservation.c             |  2 +-
 drivers/gpu/drm/drm_modeset_lock.c        |  2 +-
 include/linux/ww_mutex.h                  | 19 ++++--
 kernel/locking/locktorture.c              |  2 +-
 kernel/locking/mutex.c                    | 98 ++++++++++++++++++++++++++++---
 kernel/locking/test-ww_mutex.c            |  2 +-
 lib/locking-selftest.c                    |  2 +-
 8 files changed, 152 insertions(+), 32 deletions(-)

diff --git a/Documentation/locking/ww-mutex-design.txt b/Documentation/locking/ww-mutex-design.txt
index 34c3a1b50b9a..29c85623b551 100644
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
 
@@ -90,10 +105,15 @@ provided.
 Usage
 -----
 
+The algorithm (Wait-Die vs Wound-Wait) is chosen using the _is_wait_die
+argument to DEFINE_WW_CLASS(). As a rough rule of thumb, use Wound-Wait iff you
+typically expect the number of simultaneous competing transactions to be small,
+and the rollback cost can be substantial.
+
 Three different ways to acquire locks within the same w/w class. Common
 definitions for methods #1 and #2:
 
-static DEFINE_WW_CLASS(ww_class);
+static DEFINE_WW_CLASS(ww_class, false);
 
 struct obj {
 	struct ww_mutex lock;
@@ -243,7 +263,7 @@ struct obj {
 	struct list_head locked_list;
 };
 
-static DEFINE_WW_CLASS(ww_class);
+static DEFINE_WW_CLASS(ww_class, false);
 
 void __unlock_objs(struct list_head *list)
 {
@@ -312,12 +332,23 @@ Design:
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
index 314eb1071cce..039571b9fea1 100644
--- a/drivers/dma-buf/reservation.c
+++ b/drivers/dma-buf/reservation.c
@@ -46,7 +46,7 @@
  * write-side updates.
  */
 
-DEFINE_WW_CLASS(reservation_ww_class);
+DEFINE_WW_CLASS(reservation_ww_class, true);
 EXPORT_SYMBOL(reservation_ww_class);
 
 struct lock_class_key reservation_seqcount_class;
diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index 8a5100685875..f22a7ef41de1 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -70,7 +70,7 @@
  * lists and lookup data structures.
  */
 
-static DEFINE_WW_CLASS(crtc_ww_class);
+static DEFINE_WW_CLASS(crtc_ww_class, true);
 
 /**
  * drm_modeset_lock_all - take all modeset locks
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 39fda195bf78..6278077f288b 100644
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
+	bool is_wait_die;
 };
 
 struct ww_acquire_ctx {
 	struct task_struct *task;
 	unsigned long stamp;
 	unsigned acquired;
+	bool wounded;
+	struct ww_class *ww_class;
 #ifdef CONFIG_DEBUG_MUTEXES
 	unsigned done_acquire;
-	struct ww_class *ww_class;
 	struct ww_mutex *contending_lock;
 #endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -58,17 +62,19 @@ struct ww_mutex {
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
 
-#define DEFINE_WW_CLASS(classname) \
-	struct ww_class classname = __WW_CLASS_INITIALIZER(classname)
+#define DEFINE_WW_CLASS(classname, _is_wait_die)			\
+	struct ww_class classname = __WW_CLASS_INITIALIZER(classname, \
+							   _is_wait_die)
 
 #define DEFINE_WW_MUTEX(mutexname, ww_class) \
 	struct ww_mutex mutexname = __WW_MUTEX_INITIALIZER(mutexname, ww_class)
@@ -123,8 +129,9 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
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
index 6850ffd69125..778ed026382f 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -365,7 +365,7 @@ static struct lock_torture_ops mutex_lock_ops = {
 };
 
 #include <linux/ww_mutex.h>
-static DEFINE_WW_CLASS(torture_ww_class);
+static DEFINE_WW_CLASS(torture_ww_class, true);
 static DEFINE_WW_MUTEX(torture_ww_mutex_0, &torture_ww_class);
 static DEFINE_WW_MUTEX(torture_ww_mutex_1, &torture_ww_class);
 static DEFINE_WW_MUTEX(torture_ww_mutex_2, &torture_ww_class);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2048359f33d2..b449a012c6f9 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -290,12 +290,47 @@ __ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
 	       (a->stamp != b->stamp || a > b);
 }
 
+/*
+ * Wound the lock holder transaction if it's younger than the contending
+ * transaction, and there is a possibility of a deadlock.
+ * Also if the lock holder transaction isn't the current transaction,
+ * Make sure it's woken up in case it's sleeping on another ww mutex.
+ */
+static bool __ww_mutex_wound(struct mutex *lock,
+			     struct ww_acquire_ctx *ww_ctx,
+			     struct ww_acquire_ctx *hold_ctx)
+{
+	struct task_struct *owner =
+		__owner_task(atomic_long_read(&lock->owner));
+
+	lockdep_assert_held(&lock->wait_lock);
+
+	if (owner && hold_ctx && __ww_ctx_stamp_after(hold_ctx, ww_ctx) &&
+	    ww_ctx->acquired > 0) {
+		WRITE_ONCE(hold_ctx->wounded, true);
+		if (owner != current) {
+			/*
+			 * wake_up_process() inserts a write memory barrier to
+			 * make sure owner sees it is wounded before
+			 * TASK_RUNNING in case it's sleeping on another
+			 * ww_mutex. Note that owner points to a valid
+			 * task_struct as long as we hold the wait_lock.
+			 */
+			wake_up_process(owner);
+		}
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
@@ -303,6 +338,7 @@ static void __sched
 __ww_mutex_wakeup_for_backoff(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
 {
 	struct mutex_waiter *cur;
+	bool is_wait_die = ww_ctx->ww_class->is_wait_die;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -310,13 +346,14 @@ __ww_mutex_wakeup_for_backoff(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
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
 
@@ -338,12 +375,17 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * and keep spinning, or it will acquire wait_lock, add itself
 	 * to waiter list and sleep.
 	 */
-	smp_mb(); /* ^^^ */
+	smp_mb(); /* See comments above and below. */
 
 	/*
-	 * Check if lock is contended, if not there is nobody to wake up
+	 * Check if lock is contended, if not there is nobody to wake up.
+	 * Checking MUTEX_FLAG_WAITERS is not enough here, since we need to
+	 * order against the lock->ctx check in __ww_mutex_wound called from
+	 * __ww_mutex_add_waiter. We can use list_empty without taking the
+	 * wait_lock, given the memory barrier above and the list_empty
+	 * documentation.
 	 */
-	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
+	if (likely(list_empty(&lock->base.wait_list)))
 		return;
 
 	/*
@@ -653,6 +695,17 @@ __ww_mutex_lock_check_stamp(struct mutex *lock, struct mutex_waiter *waiter,
 	struct ww_acquire_ctx *hold_ctx = READ_ONCE(ww->ctx);
 	struct mutex_waiter *cur;
 
+	/*
+	 * If we miss a wounded == true here, we will have a pending
+	 * TASK_RUNNING and pick it up on the next schedule fall-through.
+	 */
+	if (!ctx->ww_class->is_wait_die) {
+		if (READ_ONCE(ctx->wounded))
+			goto deadlock;
+		else
+			return 0;
+	}
+
 	if (hold_ctx && __ww_ctx_stamp_after(ctx, hold_ctx))
 		goto deadlock;
 
@@ -683,12 +736,15 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 {
 	struct mutex_waiter *cur;
 	struct list_head *pos;
+	bool is_wait_die;
 
 	if (!ww_ctx) {
 		list_add_tail(&waiter->list, &lock->wait_list);
 		return 0;
 	}
 
+	is_wait_die = ww_ctx->ww_class->is_wait_die;
+
 	/*
 	 * Add the waiter before the first waiter with a higher stamp.
 	 * Waiters without a context are skipped to avoid starving
@@ -701,7 +757,7 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 
 		if (__ww_ctx_stamp_after(ww_ctx, cur->ww_ctx)) {
 			/* Back off immediately if necessary. */
-			if (ww_ctx->acquired > 0) {
+			if (is_wait_die && ww_ctx->acquired > 0) {
 #ifdef CONFIG_DEBUG_MUTEXES
 				struct ww_mutex *ww;
 
@@ -721,13 +777,26 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
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
+		 * racing lock taker will call __ww_mutex_wake_up_for_backoff()
+		 * and wound itself.
+		 */
+		smp_mb();
+		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
+	}
+
 	return 0;
 }
 
@@ -750,6 +819,14 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
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
+			ww_ctx->wounded = false;
 	}
 
 	preempt_disable();
@@ -858,6 +935,11 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
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
index 0e4cd64ad2c0..c7fc112d691d 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -26,7 +26,7 @@
 #include <linux/slab.h>
 #include <linux/ww_mutex.h>
 
-static DEFINE_WW_CLASS(ww_class);
+static DEFINE_WW_CLASS(ww_class, true);
 struct workqueue_struct *wq;
 
 struct test_mutex {
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index b5c1293ce147..e52065f2acbf 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -29,7 +29,7 @@
  */
 static unsigned int debug_locks_verbose;
 
-static DEFINE_WW_CLASS(ww_lockdep);
+static DEFINE_WW_CLASS(ww_lockdep, true);
 
 static int __init setup_debug_locks_verbose(char *str)
 {
-- 
2.14.3

