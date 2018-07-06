Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDE5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95CC22449
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Pr27+LDS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="MpoefdUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95CC22449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934434AbeGFSbC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:31:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53758 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934298AbeGFSa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:30:58 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w66ITCqh018568;
        Fri, 6 Jul 2018 11:30:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=vcNVh7vClOknJEGBSPYAjavAen0HXo/WJ1qrZTNsg1M=;
 b=Pr27+LDSSUb9FTsM16j2MuH9e8GtdTCq7ZHmOSZ0q/YZruKbugdRn9U3xXDIfvRAqfYU
 rm5P3jRqcRQn/QmHsM/33Yq0Xu1Gk++6m5ahfxYvckCsm8ShfTaMg4VSQIf7sAYv4Lmr
 qbxJT7sJvY+ifIlgWDllTqsxcoKlCL6elb4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2k2bq4gemq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 06 Jul 2018 11:30:35 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 6 Jul 2018 11:30:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcNVh7vClOknJEGBSPYAjavAen0HXo/WJ1qrZTNsg1M=;
 b=MpoefdUHPKOW6SRrJIO80oJ1Hc/VWjaCbJ2PtOIcVYG2SRwsmBpCrwkw0rkS76o1gVPle+6hxnR6KAj0mxtkZyMeTB3dF2ByxjfA7kA/rwTeqMVyMVHwn5xGDRb3IW0mZaLSa6nOXORP/5MmTmoCFd1DqSfROL2dY1L4EGs3AZ8=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:17d7) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Fri, 6 Jul
 2018 18:30:28 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Roman Gushchin <guro@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 bpf-next 1/3] bpftool: introduce cgroup tree command
Date:   Fri, 6 Jul 2018 11:30:10 -0700
Message-ID: <20180706183012.6475-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:17d7]
X-ClientProxiedBy: MWHPR21CA0067.namprd21.prod.outlook.com
 (2603:10b6:300:db::29) To SN1PR15MB0176.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e13dd7a2-f844-45e3-e497-08d5e36e8d77
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:K1CgVAffB8442dRfGeW8UQxzRROxwT1LGmH2Jzdwpk+lAgwo0JAGrE/lhk+smHu9Xcd//jnuVXBTjS1rAVjVbfAUrmcbQ8ULUMUegX4Z4igxakmg0BiZPZVpg0Vjz6zGWnFiBrsepi0QUX0BAbrm3XD6dp1PqryKw6uaajWI9rUQBOcGGyGrP3cwAv1DMhuzYmQ6ki7s11ccpURXEbHKzg/z1ttBK+Sz5mK/+JI1wGYDlNVzXCFfj/orRaiyPGNl;25:gsMnH9oeB6ZFFOc6WbeQ4/Pl14kOkYatxUfBypu3cTcPBo8xwrGeKd1BNymkNXwaAnY4QH/grAQfHnqvllgSvAwAl3CF8UxAwPeeAxOrM0Aq2zzAt94k/BY7uooTvie4DukLRK6xivtGlrLrwlkPXl3ihXAOws3uvnNHM3+xrndXodiw9kwtBh9ytCiP5/cidfpPpsLDH1zUrBtpb6RTNWQAoW0ixlIIFvkSFzaUAN65QiId3rKFDBCAH/z1nU3euXt/sC023nf9WpTjIUD8nE2jX4G7qNSgIo/c8FrcvT7pUKZ1hF/uS2nNjua0WT43LGvOa/GvkQ6jC+HL/WbJZA==;31:i8zFCMw9FnZ4uMTNfreim27bcPq3n46x5SS1/O5xgcJrwCtrQYR5qJPARbJ4aD7dPKvpw1tA0w5pbXtegcTCfF8wvsEQ6dh/Ar01nuyiGDLv2z8rfxJ+Gn8Ut1H1+zeu3JsE0Qqn0QdVOWZQ1hCFMkmDI4CnwATogGgPilJmnyU2IfmwRupskR3IElQ85LTeLIQkUQntUO1dlpXgHCmdUzxeie6YQ4y0JdD1ivF1Pfk=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:W1JvK8r64VlXGWkFnfbIcN5t825QFXbBok2XpDu/OtGSEWxwn/uaXb1nPT1F5q16si0YcpXzTp9TFoHjmTc2ElPswFZrzNKVIGcPjFVdD1pdD47tzzH6UWzOfMegVmsCwtjwKZRvJ48VlFTAIgiAOr5UiGZMeda+3kIYUMk6aqphRtDHCUsKHYXnaHaWY/tBZmDJ0ab7np9YyrBk16VK+pot+Drnc1e0dyUPZ7SX2RRK1T9V2bVFMadkXGuy0ahpti0axItJ0Yad6uebiTRXdW1FuqPgX/WkyajZqYbawKHKEqlUMklreZjNv7jTmSfrlqZZLXMaCvWma4/iZuFu2DRq/pXWQ84tcjgXFgm1m2N46rkm1qAUN/Grp8/r8bWFajzxf4ZyW8912KdLbKpvBKj19MLRXz6gP7zexoVrGMkKg+jVebHzSiJ+qsV3XGub9dWHfLc7MlgZx9mrWu4HguV/kzN5IJpVLNoy3G2/p/lg7zixMME79wOvVnC3E3TW;4:Hr4ewAPQSEjDRvfOLh1PkiEojZFwB1rDx2jNJ5PVC2L/oxi9ZzOnV0W/gHr4zxwvoa6+tOf4+wW12E2R9giwIeIbGNke79rO4RNE1ZUg0XRwAV2uZFtIQYCjTO6Pq944Bv6ZdHnX4H7ktBFjRLwMUbN3Wk2i7SB7Xa/2aL028kJrIKm3Z7benDZZwkoQ2pspplKIL+3A+e0lsYb/3DZxg1HoxnO+edyPTHfgoB15Jl6kfPz7HHRD9aaAExkyaeYQOQjH/+nXcFciic/pa/Jm6cBhAceQKigDMYUqjHBwPIn9Dbf/dUwegYoO/Rv/7bRbLGGMC7CMq7dvJ7R9Vxpqr4j4ZJJEq2XyQhmzh1IZOWw=
X-Microsoft-Antispam-PRVS: <SN1PR15MB01762EA5FBA7C0A88CD55445BE470@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(81227570615382);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(476003)(53416004)(316002)(186003)(2361001)(2616005)(46003)(386003)(6506007)(8936002)(5660300001)(16526019)(68736007)(1076002)(7736002)(81156014)(48376002)(69596002)(97736004)(8676002)(478600001)(50466002)(51416003)(486006)(52396003)(52116002)(81166006)(6916009)(2906002)(6116002)(106356001)(105586002)(6486002)(50226002)(47776003)(86362001)(6666003)(2351001)(36756003)(54906003)(6512007)(16586007)(25786009)(4326008)(53936002)(5024004)(39060400002)(305945005)(14444005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:kQlUSm1EEIGxSlJahS6lnxHy3AN4TKu5uEjeqznw7?=
 =?us-ascii?Q?Bi09FVYJhJWA256r2tPxhf1c8oRedrw2WfyH9vF4anvI2U3nKuUYD3NUosD6?=
 =?us-ascii?Q?vISmBVqL9XxYPDZQColvvncWpCUlTzGGbrhi5MuQVZZzIF2Sh7jM87Q5Avb3?=
 =?us-ascii?Q?wgoiLWQcCHsrhwZ4L0LDm8Dr3YR4P6lDiS0yGG9/4E7vL2REXOnADJTyeFo4?=
 =?us-ascii?Q?KgrGYjD0pBtzxFCPsZZAUAvrb4Dw9qn+J09ke3l8nWmnx7iUtt2UquvOsMSX?=
 =?us-ascii?Q?FTPpAI5s3mkNjk0GBu3d4D5Z2682xTYNPzyzRIZbkQnobVpDrw8ljNJ+d9Np?=
 =?us-ascii?Q?hyRCOUhHLcbGfGVzhuDjlw1zzAhSRFctKHJ0ow0FsEgvSbKQbTAR4wdsh0am?=
 =?us-ascii?Q?xsFTUZzXOiVHI0hHC3TMRuG6Bp9m3a3ulzmP0yuUk35dz19RKqFjuhWiobal?=
 =?us-ascii?Q?L1mccwSCKc9yGFMcymh1yJ8KZ0KwdzMvtSBrWx58+6HYI78ADq9LhfayWhuN?=
 =?us-ascii?Q?fW4orfrC3iZI5iQIOMTn7f3h7Am30SyCo91ns4fPD/xzTndVwz5hl2KLtgme?=
 =?us-ascii?Q?ghho/Sbu37TtARWUkNYiNr+gJrVoNIWEcffdp8+Wr2wisSIvdKeq6LUi2/2x?=
 =?us-ascii?Q?A9yIqE+dd+vMVlvoyO9l2633Yhb32ZmfeGwXbvsQkPPIQH6nN5r9DT5mgyfZ?=
 =?us-ascii?Q?awIh8ou8a4sKGXZf1xZCe8kea16ey5bSqoafR490BJBqLXrt3K1z711M216N?=
 =?us-ascii?Q?G+vHyhGDF9Ye1tJlwJH+zZNLpAF0lyiR8RKMkDjWh/1rYsztMRiYBum8LeMc?=
 =?us-ascii?Q?uVb8alvcjkh5MDEiiVt4A3K9MUEOtcS09cEC1FN84CctPkRBJavu4vslL74/?=
 =?us-ascii?Q?3lBKKnOCY7mbXB1ZDOyQoFGyfA6LVrVv20LUdlqcwN4+miIpsHKuOqxEn0ZR?=
 =?us-ascii?Q?ViwcaHSMkU4Euqkcg/nyK+T1FRF0rE4Yle85Hyshv0n8f/xa1D3unTBKCdls?=
 =?us-ascii?Q?cH5X7NFRfUrDt4miXdIHMZ34pgCFYuWJUqaTe2mXTnnnRBqd2saf4eGLmNru?=
 =?us-ascii?Q?fa7KKSMu6noCCxFRZurZC4rdYj1ozh3ljSHvWZnNdA8yghC2LQc9aAzu5moc?=
 =?us-ascii?Q?mzDZFJdOxMiOMo4K95eXxKlnc7TsUXcr+Yj7GnMtvATV2gtor+/ekqCoZVrN?=
 =?us-ascii?Q?zmJoQCSp//JlvPu+m2Ok1Yon9CH90ZWyXVnJNJ/FnERmNXCp6R2gM29tMfM9?=
 =?us-ascii?Q?D//QCRRdVNnkW6H2V+vZXIjox85IvGxHmpFZVX6vKjvdvrTWL1rIIMkzKen9?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: pId3My1ouyd0dAATlKrsSy4w3gm8rCkB9ieXHjIp/MJ4hJWa5XTJBISr07THEt3L4NBG9IVR+DLz4JWOatNyElhOvkDeaOV9Dwp/gy84U2qljo9mbGoWEJB1RS0xFAaIt0uAeshw7mG9dKH5yfP+HE6t+9+xFUmXK1Bu7q/DTpSglpyfHu/uaCRKGXw7iPROnazdHPen25jFjDbr3mbriXN+Jg942/fYly6taaZUmTQSCyW2P91H4CH4XHxRI0xxJ4oXU+ziC1hsiBa95KohyedwBEn0pGnk0v2Av+I/1H/EXF8rLk79Zzb08nGXJTYC/a8IIlNsAMfDArPPrAih/KRoLUhS+yDsySpfKhdt+aI=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:60kej1KJ/nn/vtpTxhAnFPvee1YTDVDv7MgRyCvPTaBSvYKDSFh4WPPLPX/UM5PEkH6mc8R2dOllFYLpbYIkD+Qa5L8k9AfIIl94M8IQZOJJZJEaMtCU2rLoz5OE8G7clsfpGVgyw4uY5KKpuw32Pzcf7+/trn82w/scTwhll8RT1WXqM3h2CjecZs3qzZjoPafvrzXLArB0ezTYKuyDPLfbosIgCHm37SaJGSXmXUcC5jjinxoD/3prGdCuut6QknG7vIh6Rd1V/MyMUC+mwzYoUUDtQjrwbt7YIzNxR/atAPUDbBUvgI/rM81WsFHBiAziUxhm13oBvV6iIQthdQ0nFRjYMiS+ja1nfI71Wi25cPNfmvO+1EvL/ZqWjvCAQRq0vpfMyHBHG23hfsEJvD+RFe2drwKlnsbdTY0c97HPhMFlGKlFm4FNC8hVFKhwpRf2cqHJeoXMX8FU8TT6wA==;5:h1hwM2q/d8X1RoFKInq/mMkoQpXZ+qLHFgIUHGiECydnS2RhDiCfPZuCDGAa4IJa1PbVDgVi76LanAjW0HZGW+AyHW54i7mfPXpbwDijy5KE4oren1gbTrVY0EJFQ24WUCRg4Zd62csWrFDYPnFacXWV/Mzwn1roIW6yGsAiI6U=;24:hTg6QRmkCj4q11cPXjYKCD29ZhmXxTgrR7kcC8TLelrLnozdx3vdc42cm1JjrwaYMJ7NkXhr3nKvaZrpXGn8P1I7L/H8e1FNebc3rpkjzgA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;7:K0eYGHc3p7TjLJA11bbTk5ab0aCxXkaJDCO5iIs26dpFTatzzIWNwysiQqJ5+t8spI6pplFb7nD5HhYGDXd43Zm37fjE9IOZJUpTvh5bXt1/zUYd0KGwDnB/RlY1MI0k/DBqMZPtYbYIsLYSrTX9WQRwXLNz3cKS2IK+IFiptWtECLo8I636QckZzYUXe26V7BJ4cpQ11nBkf9PBsDKO+OMNMe/5RmYdzevwOQXuz5CVO3nIyIK6k/VO1aH8z9ua;20:5GhtpFkiRV6cf/i/0m6imWyBBbPvsoHMSpYreUl1FvKlUBbT34mtCPWCHKxkSTmrcBwjPqUk6/eu0ZZw9RXNG0vwSsp1HcP5Payaw2QYUTCcvqEEs2QhDSPfl7b5Zd3ETWDDNotuU470YMaR3M9uzFh/OQz0rmyP/kkYF6JhdRQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 18:30:28.7912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13dd7a2-f844-45e3-e497-08d5e36e8d77
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0176
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces a new bpftool command: cgroup tree.
The idea is to iterate over the whole cgroup tree and print
all attached programs.

I was debugging a bpf/systemd issue, and found, that there is
no simple way to listen all bpf programs attached to cgroups.
I did master something in bash, but after some time got tired of it,
and decided, that adding a dedicated bpftool command could be
a better idea.

So, here it is:
  $ sudo ./bpftool cgroup tree
  CgroupPath
  ID       AttachType      AttachFlags     Name
  /sys/fs/cgroup/system.slice/systemd-machined.service
      18       ingress
      17       egress
  /sys/fs/cgroup/system.slice/systemd-logind.service
      20       ingress
      19       egress
  /sys/fs/cgroup/system.slice/systemd-udevd.service
      16       ingress
      15       egress
  /sys/fs/cgroup/system.slice/systemd-journald.service
      14       ingress
      13       egress

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/cgroup.c | 170 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 165 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 16bee011e16c..ee7a9765c6b3 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -2,7 +2,12 @@
 // Copyright (C) 2017 Facebook
 // Author: Roman Gushchin <guro@fb.com>
 
+#define _XOPEN_SOURCE 500
+#include <errno.h>
 #include <fcntl.h>
+#include <ftw.h>
+#include <mntent.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/stat.h>
@@ -53,7 +58,8 @@ static enum bpf_attach_type parse_attach_type(const char *str)
 }
 
 static int show_bpf_prog(int id, const char *attach_type_str,
-			 const char *attach_flags_str)
+			 const char *attach_flags_str,
+			 int level)
 {
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
@@ -78,7 +84,8 @@ static int show_bpf_prog(int id, const char *attach_type_str,
 		jsonw_string_field(json_wtr, "name", info.name);
 		jsonw_end_object(json_wtr);
 	} else {
-		printf("%-8u %-15s %-15s %-15s\n", info.id,
+		printf("%s%-8u %-15s %-15s %-15s\n", level ? "    " : "",
+		       info.id,
 		       attach_type_str,
 		       attach_flags_str,
 		       info.name);
@@ -88,7 +95,20 @@ static int show_bpf_prog(int id, const char *attach_type_str,
 	return 0;
 }
 
-static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
+static int count_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
+{
+	__u32 prog_cnt = 0;
+	int ret;
+
+	ret = bpf_prog_query(cgroup_fd, type, 0, NULL, NULL, &prog_cnt);
+	if (ret)
+		return -1;
+
+	return prog_cnt;
+}
+
+static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
+				   int level)
 {
 	__u32 prog_ids[1024] = {0};
 	char *attach_flags_str;
@@ -123,7 +143,7 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
 
 	for (iter = 0; iter < prog_cnt; iter++)
 		show_bpf_prog(prog_ids[iter], attach_type_strings[type],
-			      attach_flags_str);
+			      attach_flags_str, level);
 
 	return 0;
 }
@@ -161,7 +181,7 @@ static int do_show(int argc, char **argv)
 		 * If we were able to get the show for at least one
 		 * attach type, let's return 0.
 		 */
-		if (show_attached_bpf_progs(cgroup_fd, type) == 0)
+		if (show_attached_bpf_progs(cgroup_fd, type, 0) == 0)
 			ret = 0;
 	}
 
@@ -173,6 +193,143 @@ static int do_show(int argc, char **argv)
 	return ret;
 }
 
+/*
+ * To distinguish nftw() errors and do_show_tree_fn() errors
+ * and avoid duplicating error messages, let's return -2
+ * from do_show_tree_fn() in case of error.
+ */
+#define NFTW_ERR		-1
+#define SHOW_TREE_FN_ERR	-2
+static int do_show_tree_fn(const char *fpath, const struct stat *sb,
+			   int typeflag, struct FTW *ftw)
+{
+	enum bpf_attach_type type;
+	bool skip = true;
+	int cgroup_fd;
+
+	if (typeflag != FTW_D)
+		return 0;
+
+	cgroup_fd = open(fpath, O_RDONLY);
+	if (cgroup_fd < 0) {
+		p_err("can't open cgroup %s: %s", fpath, strerror(errno));
+		return SHOW_TREE_FN_ERR;
+	}
+
+	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
+		int count = count_attached_bpf_progs(cgroup_fd, type);
+
+		if (count < 0 && errno != EINVAL) {
+			p_err("can't query bpf programs attached to %s: %s",
+			      fpath, strerror(errno));
+			close(cgroup_fd);
+			return SHOW_TREE_FN_ERR;
+		}
+		if (count > 0) {
+			skip = false;
+			break;
+		}
+	}
+
+	if (skip) {
+		close(cgroup_fd);
+		return 0;
+	}
+
+	if (json_output) {
+		jsonw_start_object(json_wtr);
+		jsonw_string_field(json_wtr, "cgroup", fpath);
+		jsonw_name(json_wtr, "programs");
+		jsonw_start_array(json_wtr);
+	} else {
+		printf("%s\n", fpath);
+	}
+
+	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++)
+		show_attached_bpf_progs(cgroup_fd, type, ftw->level);
+
+	if (json_output) {
+		jsonw_end_array(json_wtr);
+		jsonw_end_object(json_wtr);
+	}
+
+	close(cgroup_fd);
+
+	return 0;
+}
+
+static char *find_cgroup_root(void)
+{
+	struct mntent *mnt;
+	FILE *f;
+
+	f = fopen("/proc/mounts", "r");
+	if (f == NULL)
+		return NULL;
+
+	while ((mnt = getmntent(f))) {
+		if (strcmp(mnt->mnt_type, "cgroup2") == 0) {
+			fclose(f);
+			return strdup(mnt->mnt_dir);
+		}
+	}
+
+	fclose(f);
+	return NULL;
+}
+
+static int do_show_tree(int argc, char **argv)
+{
+	char *cgroup_root;
+	int ret;
+
+	switch (argc) {
+	case 0:
+		cgroup_root = find_cgroup_root();
+		if (!cgroup_root) {
+			p_err("cgroup v2 isn't mounted");
+			return -1;
+		}
+		break;
+	case 1:
+		cgroup_root = argv[0];
+		break;
+	default:
+		p_err("too many parameters for cgroup tree");
+		return -1;
+	}
+
+
+	if (json_output)
+		jsonw_start_array(json_wtr);
+	else
+		printf("%s\n"
+		       "%-8s %-15s %-15s %-15s\n",
+		       "CgroupPath",
+		       "ID", "AttachType", "AttachFlags", "Name");
+
+	switch (nftw(cgroup_root, do_show_tree_fn, 1024, FTW_MOUNT)) {
+	case NFTW_ERR:
+		p_err("can't iterate over %s: %s", cgroup_root,
+		      strerror(errno));
+		ret = -1;
+		break;
+	case SHOW_TREE_FN_ERR:
+		ret = -1;
+		break;
+	default:
+		ret = 0;
+	}
+
+	if (json_output)
+		jsonw_end_array(json_wtr);
+
+	if (argc == 0)
+		free(cgroup_root);
+
+	return ret;
+}
+
 static int do_attach(int argc, char **argv)
 {
 	enum bpf_attach_type attach_type;
@@ -289,6 +446,7 @@ static int do_help(int argc, char **argv)
 
 	fprintf(stderr,
 		"Usage: %s %s { show | list } CGROUP\n"
+		"       %s %s tree [CGROUP_ROOT]\n"
 		"       %s %s attach CGROUP ATTACH_TYPE PROG [ATTACH_FLAGS]\n"
 		"       %s %s detach CGROUP ATTACH_TYPE PROG\n"
 		"       %s %s help\n"
@@ -298,6 +456,7 @@ static int do_help(int argc, char **argv)
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
+		bin_name, argv[-2],
 		bin_name, argv[-2], bin_name, argv[-2],
 		bin_name, argv[-2], bin_name, argv[-2]);
 
@@ -307,6 +466,7 @@ static int do_help(int argc, char **argv)
 static const struct cmd cmds[] = {
 	{ "show",	do_show },
 	{ "list",	do_show },
+	{ "tree",       do_show_tree },
 	{ "attach",	do_attach },
 	{ "detach",	do_detach },
 	{ "help",	do_help },
-- 
2.14.4

