Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963D1C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E02420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hdG4S7P9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E02420846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932874AbeFTRmd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:42:33 -0400
Received: from mail-eopbgr710089.outbound.protection.outlook.com ([40.107.71.89]:50614
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754723AbeFTRlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzXjjxb+XxO3qo0I5igjwilZ3KxLCYpht6qunDjCKVs=;
 b=hdG4S7P9dfayValrs2RAwq/VYRE5q0zfj8KAAt4HHNGXc2KaDbkRMHCqSg0ju54J2TnwpuwpSQoCNoTIuiVlaWSOB9e43rpDGFewD7IBSE6fNa0VHK3hh3Nfgl8VyuvEz8Kc8nT1uf4pM42sELkozNGVyfbpGLjzznPrnz+XYW0=
Received: from BY2PR02CA0118.namprd02.prod.outlook.com
 (2a01:111:e400:5261::44) by DM5PR02MB2649.namprd02.prod.outlook.com
 (2603:10b6:3:41::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Wed, 20 Jun
 2018 17:40:59 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BY2PR02CA0118.outlook.office365.com
 (2a01:111:e400:5261::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Wed, 20 Jun 2018 17:40:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Wed, 20 Jun 2018 17:40:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53006 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6G-0006og-Ox; Wed, 20 Jun 2018 10:40:56 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6B-0004lu-LP; Wed, 20 Jun 2018 10:40:51 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5KHegOk002476;
        Wed, 20 Jun 2018 10:40:42 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fVh62-0004hY-3e; Wed, 20 Jun 2018 10:40:42 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v9 07/10] firmware: xilinx: Add debugfs for IOCTL API
Date:   Wed, 20 Jun 2018 10:40:32 -0700
Message-ID: <1529516435-7315-8-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(39380400002)(2980300002)(438002)(189003)(199004)(106466001)(16586007)(110136005)(478600001)(54906003)(2906002)(106002)(50466002)(48376002)(36386004)(9786002)(63266004)(336012)(316002)(47776003)(356003)(39060400002)(126002)(26005)(50226002)(77096007)(11346002)(476003)(2616005)(305945005)(6666003)(446003)(7416002)(486006)(2201001)(72206003)(7696005)(4326008)(5660300001)(8936002)(8676002)(36756003)(107886003)(81156014)(81166006)(44832011)(51416003)(76176011)(186003)(59450400001)(426003)(921003)(107986001)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2649;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT060;1:CJQnOi7Yskrq7jJkcpcMoNgtZreQXHqznyoXW5UOp1WA8FxeSKjBOir60TpqRCp4iaZeWX4nIUrITQhqm4IVqYZoUdMVSyj3WLpvfV/os0TUecGLF9IjkElIDNtjKKjB
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bffffbef-1a6a-4ac6-6f75-08d5d6d4fb94
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR02MB2649;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2649;3:CrkSDeIeM6ZBb7WYE+QPeU1Zu1ssvCMUT1JloIGZejZENiy6/KQ0tLMn0D4Vk8iDE9YRPRXPuK9rgoiwO+O5vIiwcC1KoNlG/RDp6xhgC8c8id71gsDZo+uZp8nEEC9rUK0dQQlAyLo7l+0iHJiGqTxP+xyi2+CgJLYrhad6yWPvjbyfF0JktikX3elw7nSfaGmHOYWX5wU1SbkzIZbscQYcDi10LVxA7uh+bVLkqx6eMkpIM4SY/A8MBsgyprZvtQQndpD0o3+yu7wp7jCzPFbb6E8faZ80aYKIhfG5Hy2Hygq9IYMdONYIHG2ovmMgkczYV+FJp+AX5cs0Evwnj7y3t0uHqTNLS2oLPOBaSFM=;25:Y4hbfTk9lhEcXQVYDBTZvW8+hTgfdLmN80Bc3kT21Mqm5zi8KEo23kdZiIvqKH6WURwsR3/UYwq5QetaJruIJTJRXPE0/s5vrMEr+8iqc+Bbpv24gAl2VMOlR4vQ9bZRARRr4xG0vHEwpfWY5tmcyThqdrRTyLSmKdFgoi37cB75HU8huAR05fd9/yhHEq9vgMfM7nxa2ljhP69/Q/BJeiYUPsX83UFVYfsi869vOAIG7uHAU9GFNxdcxRLze0P1EQjJe7YGLIU7a0wWP1hMWIhIce+GRLs063cx/lHAe8QozKjePL3Mw6WxbyrGK3dD+TEGQuVYH3z9s20fB3RUZA==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2649:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2649;31:fGAyN/gxbdz8ETbGeRy+X99NZl86AOL3Yyx2E8MAq9905xga6+9rQofZyFgefohIkc12FvVwyuZuBITafRippgKmHK6qa9DvszNzhVmuYq8cFRt82GAcL5SYiBjZnPkV2/Q6xyy8RIyE/L8KoB6WoBDnpRfXOoZnB2EQsRC0bld0oiHIPvJorxOywQ8Q3qRFuL4ZpcYCExGN+r5aI76/Q7jUUcBPAiYc5Rvn1IgZsO0=;20:r8BSgsG2pckj0xNpj8NIH0JxH1yMEc5Eoy1JNFYhAIRW7Ci0sRI1K01/Rg+Xd53UfUTtrCjXEVh2kNwyY0uQTNLqRXpbHnh/2deSm6wW2cbcwS/SyTDziQyQei+M/ZDtK80jlwTDXL/7KFzuS/wOSaiabr1fBQ4WCU6w2kxeFBAFfzCRl4/eMHne33Fe6H1gdeMlqzzY6i9N0oGrDXVLrYFNasLcLijyZ0HjMErCsH+HeYQFpWxceJXEbP6z1IeILqUfuHQGJca/jWIgS0r2v7/0kFI7YNoQYvio96A9qiVCn9hrQJZhqKJljUBH2pZi+6PRFxwidHHmiE9Zi5WnR2vk1nYuEKkAqDJ6DlSUMKDdc7PB/6/E3wOEpcqDR7zS+YQVgBoRFsZkJHJuQDCXC192E8QhGFp8KBDGl7TpdTotLwY81Yfhp1PryNOvrHmqr3Wsx/UbTrT6Po9aqLrrhbhY/giSSBDAI0OXsRv4Kvum33gafCI7aekfIqPWwURL
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB26493DF5DF9AD4B926BAD8ACB8770@DM5PR02MB2649.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR02MB2649;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2649;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2649;4:8QjJ8EPL955h5AT60uiti+BLfOj2LF0aOMYYTcya1oQx151bpSazWnEQLaPvDiA4VJfsRu0jP/hlIChz7uT2I1CC03FdMPCiZKSuDfcnGpJbj9bf6JR2QpaXlMsmDKwnB+KM0G4gNTBikFe0FzlH6tO6Piy17pTPEBL2HTs7LAdJGFJT1WuH+lBq6rKJ1VGY7GQxE2M7h4EMv/H3pO/dDi1nTX67WiOQL+4RkQIlA5+4zQ9ii6IiXM63t//WVwRc0i7YTnCjcVlr0Lod02eEaI0c7Aoxmxo2lxp2qkJ/4ABQ7phnOsrp4oeAxZ7jhXhx
X-Forefront-PRVS: 070912876F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB2649;23:Ksm/LzUTO4qT7bUcApho4iaQ06dzkIyECAq20GKXn?=
 =?us-ascii?Q?4LMDoZ8vz8BZ1Gmm7/8QcRPrL/C+RODpxIowRitGcl39xyGjujcdzJ+78vjp?=
 =?us-ascii?Q?+XNhCRt0Io7e9jR688hB8KDiPrFROz+6MZVZw5rfkV5H9wCRcmxDkmCKawHD?=
 =?us-ascii?Q?JthHGUuhxVsZjSjRkCb6aWJaS4XijJMz2zJ99omojB9ugYo4kyWSUbWwjJCr?=
 =?us-ascii?Q?O8KR7RFgczUs9vGyzFhC74p/+Gso2llKc36WdcN4YG+8DlbatSSVUGxvoXjd?=
 =?us-ascii?Q?j7cEQvNT7WAx8ck090ZRWzr9tRLBTeInu4Kl1ZH2TOizsb2n1AgMTPWtVOYE?=
 =?us-ascii?Q?aR15dR6PZzMxjvsALYKqU5lbvjQnUk1FO1OO2O2SINtKKOrCDZz1gDMmFpR8?=
 =?us-ascii?Q?x3qkZ4V23PMPiSgMp5j4Eg89uBH2633k8unUlmxtdfmCzX8N577maY1RDT2q?=
 =?us-ascii?Q?3+M1SBjiRyt2MGlDTH8rr54yMdh3Dzvv3xykL6Ovg0w14VR9W1149IDpQTYg?=
 =?us-ascii?Q?dOnsm+X1Q8x/0T4jrE3YxYBdA8ofa3O5elqHYOzLpd44bARcWmfV9idL1Nug?=
 =?us-ascii?Q?9hVh/tNsUZJIAujjs7RFboWjhZS3dOkvvQmyqjXrtB4QghXXKJaOrOltJT1o?=
 =?us-ascii?Q?e6nJ6ZK+Vv2YtlNi4CdqekE/TbMi8wH2+4OniQ9/F1gi8etn/8dLPg+JaaZb?=
 =?us-ascii?Q?LaVbvX/mIvLxpwgiwQJZI/nqSv6MRUjmpCKx3JhwezMEZi5OsVMLrz7LKws9?=
 =?us-ascii?Q?T2Jj+MasmgGOS9NdRyBsouaJNQkg0CC4qta5D7HEBH5PTnUU28geH/3B9mRN?=
 =?us-ascii?Q?qPOY9aFv8kNBG2lBBKUmRbrLHEcbzqmhl8w7oWHe8m9GgB5WIIVL8l7/jotZ?=
 =?us-ascii?Q?WMbZo8t1mZpOTYWIuzSQaBn1aKItn/QdpYVPQfotjlmeYd4Gj+VuzfHsIDnv?=
 =?us-ascii?Q?uU96gxXNqzkU1WCK0q5lGHWOu2YSl/gj9kqTrD0u/BWF71t7/vwXSVIxdDu9?=
 =?us-ascii?Q?ZbfvJ633ZFNK3Ffn2xfFeTieuJBKLMPH2nnJvQs9h7jbkRT2gpR8ktGPv+C5?=
 =?us-ascii?Q?S8/zfxl1A01fFNUg2SE0AEJh7BHrScd4ySQiKynuYJa2M3PFhmsPmk+4WHDx?=
 =?us-ascii?Q?5nPLY6b80hLy829TPRrtthWBY2Wk/4HXQC5cNgD49kkO2zwZ89zw/vgQMXP6?=
 =?us-ascii?Q?D8LOtqb8SUwITsYZM5Fa3BThAdonKh38QZgMREjrZj35i0xqwWF+FYHKKqqt?=
 =?us-ascii?Q?r2zPkmAEyh8h94SNnlzk0NXO48XgE1RtukX6u+D+Hv0IgVkxiG0eY56tmdVl?=
 =?us-ascii?Q?yDmEIC79chnWYFPL2gY4EM=3D?=
X-Microsoft-Antispam-Message-Info: +CWMF1/mZfAM02XyAhXQzefhJiC2BqT2km7mDB7XKa617iImSaj9ZfUOvwDJVS21qv2x4/4E1ZpOje/zMwnCPczn1nGjsoBxb6o6Y0uHBYwIS9pRzrdLw7E6aqyoPW/So5z5vsJ2BZkcn1i/G6P/SqyxZu+yltecS59F5Peh54jZZZ6+e4eMX/eelRJZu5gaK/ip8wNVnsQ038/QqK7LFENGAAgBs5eR7IEVJagWxYmFnfomktp6qDSx7xW9YF5wncp0tvdg8SG3la88nMXDgLD/5Tix524IAcb3utp/175FtxRIBcTH++ofnbxLz6YWkS8PPFKfkskIjI2I777Wnw==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2649;6:fNi7VfFhRfLIVC6uID+gYg6LyiZKikROmRoRHvkAL2bDHtkzKuTesTiYEykjBNS1754TzhHkZ+qm56NqjSCs9Efg5GcFN0tER1VrHAEF9wiiS6OMWPpHVfFbqwpV01GBf8iXXYrHXkwtctyiY3bZG7CuhsAKcqnvcgYD5n6WcwcVkZSE9hg0kHg5lg1X9ZB6RvaMEzS+XDHYATfLOl6jbnSiWHL3pS4tamj+jD9zRJAyw1a9y3H81qBKjMWPaLzcS9vzJb0DqGPqb8Qr+ll0IFJ1+emSerVq79TJg13XZXmpuHoISupTAM8MxHfvfeQqbDXIlcVQYKDN0AK+FmXriszXx/ms8YbdgZA2O+mqk9Xtu/f8vbt9zcN1aeVmHM1RRjYPHh4tJs24o0PoddJ/t75iUwUA/1x1vXpN8D4sZQ+z9EL0lGUScsxCVPbnYCuEmLIoR5muYo1uwdF6s9h0oA==;5:eZIUkGtKZxHxmCKszpfHYqX1rVvkSFd7iBQv+PDwf5dax9bvKWAK7OdrjvNCEjB4pKSG0xUb4meeEpCo8EdzGn1llWwvdCCv2O/9aBQvq/7O3/FenGmdQbHQJoEAx1kFRWrER0wib3dYf0gQXgA7Soh9MzOVtwhTFULRP4bTH/o=;24:udDAV4+wDlk0MGiDyYAfM3Q8eX8GVV00kZGoEXS7NCvQwrb4rHKVVMN6ja2RkPbE1Jt5ng7wM9kVOlsXVCI9By6TvycSnLoE+5pc82jcJ08=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2649;7:IzUgsHym45ObBUJDhkx74bJGyZAOl31z9dF1Uw0LoZ6koihM3thwhaT/NjdxU551gWw9HqvglphKytj/9peTFMaUfS3ZJ8OOdtN2MXD2qEW5ZUTQgwvxpE9dr/zhxGqKG0hCQk5oG6C0Ch3Gvoo/Wus8pzJa4tqcPQ+ZCDn2kxkePbT3A1gbmqbMKqwQ2R8B7ZVlRI2mrIWLH86hgh4DDHhpT0TciMGiFly0v0BK1SFY2YNckKoqjWo0XqoJprgf
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 17:40:57.5794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bffffbef-1a6a-4ac6-6f75-08d5d6d4fb94
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2649
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add debugfs file to set/get IOCTL using debugfs interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 4800366..148dbff 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -32,6 +32,7 @@ static char debugfs_buf[PAGE_SIZE];
 #define PM_API(id)		 {id, #id, strlen(#id)}
 static struct pm_api_info pm_api_list[] = {
 	PM_API(PM_GET_API_VERSION),
+	PM_API(PM_IOCTL),
 };
 
 /**
@@ -95,6 +96,15 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
 			pm_api_version >> 16, pm_api_version & 0xffff);
 		break;
+	case PM_IOCTL:
+		ret = eemi_ops->ioctl(pm_api_arg[0], pm_api_arg[1],
+				      pm_api_arg[2], pm_api_arg[3],
+				      &pm_api_ret[0]);
+		if (!ret && (pm_api_arg[1] == IOCTL_GET_PLL_FRAC_MODE ||
+			     pm_api_arg[1] == IOCTL_GET_PLL_FRAC_DATA))
+			sprintf(debugfs_buf, "IOCTL return value: %u\n",
+				pm_api_ret[1]);
+		break;
 	default:
 		sprintf(debugfs_buf, "Unsupported PM-API request\n");
 		ret = -EINVAL;
-- 
2.7.4

