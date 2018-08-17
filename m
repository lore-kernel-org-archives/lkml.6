Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5745FC04ABB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032E22146E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RtnMdrOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032E22146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeHQP2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:28:25 -0400
Received: from mail-by2nam01on0045.outbound.protection.outlook.com ([104.47.34.45]:58000
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbeHQP2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alzi/6RqxMXV4t1Cn6T7Irm1qFDo6iMcjEDH8ueVO/M=;
 b=RtnMdrOjpGuvtyqsZDVebKGmSs2SlYzkOwdGPu1TWFGCCTSISfib0khle+e9NlrKwzkgMsLCehTyeZGkc2Ey+0F/vGmMtEhx/l4EUzq+zXQ5OcplX/wfa9RDFY9TYwEHXOaT3/0PP3DwGFZIGE4bFKEj3sK8w94KlRw3knvKqqg=
Received: from MWHPR0201CA0079.namprd02.prod.outlook.com
 (2603:10b6:301:75::20) by CY4PR0201MB3506.namprd02.prod.outlook.com
 (2603:10b6:910:95::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.22; Fri, 17 Aug
 2018 12:25:06 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by MWHPR0201CA0079.outlook.office365.com
 (2603:10b6:301:75::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.19 via Frontend
 Transport; Fri, 17 Aug 2018 12:25:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Fri, 17 Aug 2018 12:25:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoP-000311-JK; Fri, 17 Aug 2018 05:25:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoK-0000U3-Ik; Fri, 17 Aug 2018 05:25:00 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7HCOwFQ019101;
        Fri, 17 Aug 2018 05:24:58 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fqdoI-0000Tf-FP; Fri, 17 Aug 2018 05:24:58 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 802B96050E; Fri, 17 Aug 2018 17:54:57 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2 7/8] usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl fields
Date:   Fri, 17 Aug 2018 17:54:54 +0530
Message-ID: <1534508695-12642-8-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(376002)(396003)(2980300002)(438002)(189003)(199004)(8676002)(47776003)(90966002)(81166006)(81156014)(6666003)(5660300001)(478600001)(52956003)(2906002)(336012)(486006)(446003)(316002)(26005)(42186006)(11346002)(16586007)(106002)(36386004)(63266004)(8936002)(48376002)(76176011)(426003)(36756003)(51416003)(103686004)(356003)(186003)(4326008)(107886003)(6266002)(39060400002)(2616005)(110136005)(54906003)(106466001)(305945005)(126002)(50226002)(14444005)(50466002)(476003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3506;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT038;1:4apezvDJHQiE2pEDBkYCjVEGYZaniO9vIXS3YSQ6C15NaBI+hq66K5mhpu9gvYNMm4vTz3bLHVTau/xate3BiJRs8ptxdlBvNYLm1X8Yo7iiQWhbpJDECUGyuDKbEVlC
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24830aaa-8f5a-4967-9e7d-08d6043c771b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY4PR0201MB3506;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;3:YKiC6Gnxz3LWXJ5lj3FG/1mdEA6boDgXxicaxwqjrS559vnczGuMwj6f13VFKpu6aMKP/zsXIrHZ+SFyT8T9h6bl632YwA3KlpvK/AxYOcQbh3bPTdhsPiXJzOupqbgenMGNSXQV2Wth6pKYiLmOPsK7sewUL95vWS60Ck3qNO+nW/9JmLmmjKh28YJNKuJD8mhWdVOhut8u7TSCLUIN8r76+ZymlNHmP9ebku4tt8Ym5vteNX/KpJbWduWOo8ngId/kpEFjG0FhoGvTMo0uxUlyU0lZDShan7YYL2e10/TPXKuQnlT3ndeC95D93jBPCKW7jgJxSSsQivyT9qdMquv2fQXxYQ21Y3KSfrTZnWE=;25:rqNhlcT7EUjzzeUHYM1rsWh8KdJ78b/kG7l61vyUt+kA7qJ0+NDajf7PN95sDnkmFhRVxjjK/Ifwamo0ooZM5mdl0RFMYQFflrxJJHUI/4ezNhGxeNgbanCfxdBnJGbnAl1nnUlWi/IJLroWyD69gDqz3hOvUWs7ZKOnG+8pQkyOxo2dTLhKdPQK6uwSySuo0Nq12sEGudTZ1c0cget5qZYDEOT5PVuIZkjJm2JX/enLohg8Eaq1Hjmml4qrSRb3AQ86EMoVHOe4ReaMMVnX5rry3w1tAz38fgWArv19QfPlB3mBHux9Qq3Th7YKeObGaGjd4EhdWgJ0bjRcGLK4Xw==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3506:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;31:hXat68axDN+ZSmHipHL2mSOgXvf7a8RIGQJE9F7ynEyBcmEs/D2OiAq5/LcoT0t68tz6hst44sHIkKKVCcowTV9PUHqD4QLW0U5W0LaCe2Ibw7xNiycwvs/ppaHdydbvv9vvIAlkVLh52q1CD59OKIdBbmtQMOk7lmr2YqiQ1WYmwdrGK0Js0iNPgLA9VD0fqkccb/s9KmHg8LzHuMfBAEAZVtSkOVyYkq/TQg2Yzcw=;20:rBWc2UgKa4GSEhvRtf78ZQKxaQv40UPzoAXZApc0/xEGz+vP3odeSYE2ecU487suWbh/ydsldiKWGopKG8xS9lgfoKQk78NdZkMdyMneV4LiWR1yVF2H+odFZ8pqCZk+UMDdVtnyiDL8k87nFZJPtNOuAmdo1DELLuwc0yVpxdD93I7+xnkGxxvUdWd/lWx1Ua7vrmVyyqbTVrRcssCa13pOcPCn0Jsxvj9SekGYkrWc9ACsykvXMNSYwhOT9vE5tewhgKRkgd+0+vUymhvuGh2gu+vRXgBMgbannnj45mNgqL2T34zA0KSGHHGzcbsCMrbyMaie8rpj20VSNxs2NxBk+tlcDvzAquoJs6EfN5cDuuCXqj2ZngjY9VXHM8H0cafiFn0jXDjFqCOyVzvbonCmSmoYU8p7g8tYFnpRhHbsLMQtYC3oMLwOUG9bprjZfbbp1VZdKI1eY0GJhTVp66u9XGZiWx171718y7hNSQlq253ezQfqtXvxade69eZy
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB350633F60B4D5EF3B1E8BBCFA73D0@CY4PR0201MB3506.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:CY4PR0201MB3506;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3506;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;4:cJs+Ed/+lzkXm4bi1+Xce5d5kYXJ6X+BNafmv9VoArj7cYj9YUPwG4P4DYaT2jWDbhuGT4R9MicifcpeHjgySX7AL+GeUXXCsgppAualOPRe6up1SK3u1KjXROwxK0W+XEBo4SCJCbxr0n+ui+l5reAbKLWDyuyFuy8nfVvKjv7bdmH3RYoZfxpmqm5rY7TGYSZK229tIOYBrWQefZquYtdqmyAValN/c586tabL+qhl5YvMaJW6T1vKqyV8JlcLUtwz7cwwIOapdvjcs0an0q8vqmKdGpu7SffSKkvKOmmR0v5PnMHr/BfSlf2u/0cr
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR0201MB3506;23:oKSWlHnMQKggHEwpmbmcDFGbpx4i9giCMDB517D?=
 =?us-ascii?Q?GEekJGJ6VIw6EgdkE6BAtGc2RFVTxK4lLH6EGLfMe0uFCR2hEDPrTCpI4eNs?=
 =?us-ascii?Q?Fy8tLnPUAJC4pRE9ICs35qGyyPuTeoLcjxmUTYbX0H4iRBZ6Mb9Zo37fX+zw?=
 =?us-ascii?Q?mZw5ALiMNQrPh8uzXPieedED7l5TmUUVIiH0Kg2VDn8A/jtmeW8W8toF0ElZ?=
 =?us-ascii?Q?fepxMzxwO0wmSzPDdAvAOEwOmq4PVZk+i5y0bns9O90FFOs8PuA1TXHJIU60?=
 =?us-ascii?Q?dZNIOlxUuqJItgVRcfVsChZmUTUOy9ePmxfaYCbGnJaU4qC9E7jbXiBYoAsW?=
 =?us-ascii?Q?ShYQUTlSAqbhbE80iqtvmqREvMOprzqw/FdXZJoww5EmbDbCtGYS1VaTuHeX?=
 =?us-ascii?Q?2xlTEQmkp9fF1RUlyko/xlJvya/H6l0CDwLX7Tti1GmLrfULKanb+ID2WhC+?=
 =?us-ascii?Q?9xVdzCAt9zCc7g8fAdPnoXFSrbM5ppNVc0UNo0Op9cMSsKLvv2CZL+L1at4l?=
 =?us-ascii?Q?sPlX/QUslKi6IpXcjZQPAFBAe2aiNZG+U5uCLVKmkjB1sil92wLnSKexhg3H?=
 =?us-ascii?Q?wuOSu+WrgzBGa3Ho3mmJKkOWoB/1VENOlINnWCSrK30N7HC6oCPGSxjnxDjL?=
 =?us-ascii?Q?XCyIZvBq7fZqSDP4T/4nN4Yt1phrlsF4+2oqqqrHUyMRx0F4I36b2z+IACCm?=
 =?us-ascii?Q?SxkmlLpGQ9//Nlgpe23SC5lQxI//vmPj5Lo/TA2Y7F9BOOkQrTy6ld6e2+ov?=
 =?us-ascii?Q?F860YgJoCL4yLKhrteKEZH/06QDULQvJuW3acGp/LPkrOUnjkPftuMaNRS71?=
 =?us-ascii?Q?jtJlneBqXOjQqwAWTQtMNNdsusZHatv65HZ64PiykbnZm/2cRo2i072g2/z7?=
 =?us-ascii?Q?jmyIAh5vTeliq7cYn43cWXvbWX+vx+V6a5PHYpW7fJiRAz090WG0lzOrqGAm?=
 =?us-ascii?Q?EWTv6fO/30KWP3WM/R9WMUv1ih02hJgE+qRfbHwx10vWTx6ZR1IvSQSfvycA?=
 =?us-ascii?Q?2zq7TTsgz+tgirNMbC/Ms9R7WlFJGIvba0taRIPnUby6A3sRscZvDWi0YZVE?=
 =?us-ascii?Q?FX/Xdukw1m/UZLfnnADUCw1LuG0BOIszpNniv6t+/cqJ0yaUMiBeGRP7mTQS?=
 =?us-ascii?Q?15BNg7XnU+jVmEm/O+JOPPQNFtxx1G9tNLfYPY7QXwzhRx5897hww5Sv9W4V?=
 =?us-ascii?Q?E+dJqiFzB3VpD4bbdy7f4y4oz8IiYf6/s2z2Z?=
X-Microsoft-Antispam-Message-Info: 9ZcccvJ0TBIPtOt0Md7jzMucdyWb9xE3OOnyXsS88E11TCy0rCB9jTrQk/D37xIYCK4Sh7TNfONC65KQrGT5c/n249SjNEQjaPndrMycXuNbtc5Jx56qp/rn8uivtAczTB1GaQnr9td/sjXfNQwYHWKoiXupsEcFHW05G8UPpdDU0qafYmsaIeFqBlaQrWB71R5Bag5Z1A0k1F3yuVekIz34ciwrS4XXiE7k0F0PEtqPTblP8mh7YE/XU73l+qmHMDh/GOIUgMNnS0QvSbCJV5JBfMhWKZsB8dwcHU2ZJAOCwRlqmmleEYpqTcWzb4EIxJfXvUcwyK4oJZAR0zW1lgRieFrVvfZD8gaK77i2HFQ=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;6:vzx2JDEqny1hTv7Uf07t+o2hyBeyHRmhauLWhiAoeoLZqbriHvMSZlz8rcBtZcpud5m6ISMR4hGHZ2k3XrLw6LrWwg8dsyOH8lzCN5ehKTS6EGaOF+/wc2Gqm+WicJ2NaLc4TAuXtZMVFL6PhizIxG1nCPL/yc7Gh23U9W4x/ZKGm5SaVOXd//1xFKrqcY5r1NcNU/TByDQIQTl8bi5vGR4671TbrFCQXaPUfQGX0qtNqYgWZeZu0K3JoY7ZS4/iPvRT4ZtLvaTP6U+FW8R4Z/zbV6cqm0/Fep8mFZvod/jGJljK0hVbm6vbn6aRMX4efXql3xwGyPOu4XXqHwxUiOoULOmhIgLQNOO33fh/bwu/W1kQoeQp3YwxmmgdXtznBfvaSlpJ6baALUzRKGq9k43oyZeZOiIWYDBMRcN7Sgu+NsoDxurnw0ioVrSQ/muBwj3IdCP8uX7WOXrGkukkkA==;5:48UqUTEL2yn+B/j3XvqoXrIKo05yXjeJ5rOKWWvQjhfi4jQoK/FyJm3Vrj7xIUWuqqN1HR5ULWUGtTMSsJ7v9LUfb6AIsHhQFjtUCsd3PAIhdWArP93fG75YWeeiVS9yYyUCYaa3XmAkAbIhtlx8DNA73O4y8t9hnG7O7gYYubA=;7:YkOOimwUgkeBooFNs8wW0stoG8WHHBwqJyTASyln12ZoyKDoLMcKqtdUIFGkFnhEdMqAhJu85goXXQfjckzUdnbIkR0aBcSf02AIoluls8zIia662ucf8oFCLzHDPPbLmwa7X6MlK/SAeLkcQ8+/vxMGYw1qmo6HeL9POA8zgZAcGQeEB7zs5v88RT34THaWjoa7sm9gctDK2poooCnKIB5QSdfkcC317/jkL8jakXa/1pAmup2a61l6zkzvGXn5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 12:25:05.9851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24830aaa-8f5a-4967-9e7d-08d6043c771b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The present code in dwc3_gadget_ep_reclaim_completed_trb() will check
for IOC/LST bit in the event->status and returns if IOC/LST bit is
set. This logic doesn't work if multiple TRBs are queued per
request and the IOC/LST bit is set on the last TRB of that request.
Consider an example where a queued request has multiple queued TRBs
and IOC/LST bit is set only for the last TRB. In this case, the Core
generates XferComplete/XferInProgress events only for the last TRB
(since IOC/LST are set only for the last TRB). As per the logic in
dwc3_gadget_ep_reclaim_completed_trb() event->status is checked for
IOC/LST bit and returns on the first TRB. This makes the remaining
TRBs left unhandled.
To aviod this, changed the code to check for IOC/LST bits in both
event->status & TRB->ctrl. This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3af55f8..1b1bc14 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2290,7 +2290,12 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
+	if ((event->status & DEPEVT_STATUS_IOC) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_IOC))
+		return 1;
+
+	if ((event->status & DEPEVT_STATUS_LST) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_LST))
 		return 1;
 
 	return 0;
-- 
2.1.1

