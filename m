Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5979C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE4F20875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="cv5UuCSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE4F20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbeGLF4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:56:08 -0400
Received: from mail-by2nam01on0075.outbound.protection.outlook.com ([104.47.34.75]:24333
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbeGLF4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJ5bXyYpT15GYA9bzxh89gOtDvNX66+ZwF+65GsIo20=;
 b=cv5UuCSNASqIc9htotn0uzgsVxUbL9nsBW+1HggZKEsGYemOmHw1dBErVt7qsCuB9oQ3SPvPQOwbj6LkWlEyoapJYrKbCGlH9BjdbDLyEoA7DjEez8LdYVsZjqBqTGZjv+N00jix0SEqaVVuo0Qx2UjSCyNlbFZJ5DLK1JL6JhY=
Received: from BYAPR07CA0054.namprd07.prod.outlook.com (2603:10b6:a03:60::31)
 by BN3PR0701MB1332.namprd07.prod.outlook.com (2a01:111:e400:4018::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 05:48:03 +0000
Received: from CO1NAM05FT047.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::206) by BYAPR07CA0054.outlook.office365.com
 (2603:10b6:a03:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:02 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT047.mail.protection.outlook.com (10.152.96.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:48:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkwD032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:48:01 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:08 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:08 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lqgp029851;
        Thu, 12 Jul 2018 06:47:52 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lqpk029849;
        Thu, 12 Jul 2018 06:47:52 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 24/31] usb: usbssp: added detecting command timeout.
Date:   Thu, 12 Jul 2018 06:47:21 +0100
Message-ID: <1531374448-26532-25-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(2980300002)(199004)(189003)(36092001)(446003)(476003)(2616005)(76176011)(105596002)(426003)(106466001)(47776003)(2906002)(14444005)(26005)(36756003)(336012)(186003)(8676002)(11346002)(51416003)(8936002)(126002)(1671002)(48376002)(50466002)(16586007)(356003)(4720700003)(7636002)(305945005)(246002)(54906003)(42186006)(86362001)(50226002)(5660300001)(6666003)(478600001)(87636003)(26826003)(4326008)(109986005)(107886003)(486006)(316002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1332;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT047;1:MW9VbSAkfLZV6HnZKqNmZHfAhm22DWAXyJT4Umbsh8DoIHWv/STPM0NLyNN637QQrsov8H1UlFs3ngRKweyOPQN/5usfToWNW+SaOw1/x6BGazw4GgQj8ROUwit/XolC
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ab3af62-c8ce-4cd2-599f-08d5e7bb0802
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060);SRVR:BN3PR0701MB1332;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;3:LiRwczjhRFrw3gVV7rDV+/bvkWwvyGjEwLjs3SINztutacBGAyyxxSuiQQ+qY6XHCO6VpiAQObEuLNgv7btwjEjh45EAH+Cnu+HLRm5WtgjNn4l7U+xFcsE9nzajShCxP5oxFg0GDSj33AhI2l2XRVep3rMmWEZgR1am4oMdUftqRpovkOm9eo7Eht9Isyq0tWmHOZCVeV6kJOsjqyRNc+Fdn7c5DL3K3l+z+9akAO2cwKVHesRTQLgbqRWvFidW/hEKZb5+wbrSgw0yRVefsJfvtghko/PjTvGHn6FRbxJ6rPZb2KY21WqQqYcqqUKeaHGqZiEhKSiyYoL9KAYBg6QwLe3W/nH3dhN1KBTJO94=;25:p5dRKnUyYexvHAhTY3V/ZlumAvZJSWvzHE7Vu8wJSk7Jeim2jIp7dm2zWsRj4JNhszfjPizaMXeMkDZIxPpWBs73t+3i8QR823zvs3s9H3rgZea7WnXisn3wy0PEVUGsIXn4Zyn2A3+lkP3ZAN1gdplJ7jX/PpfwCWBth0+y9S8bCKzR6/4e7h2A+HVOXk+xD1hXeMY2Bnxtuq1TlkfGs09GNCtdfOz75RTKCEX0wZpmCbhHOqSYyn7cH7UBpgIOuJAkdOUdLhMNuK2/PpXWouJJS6pIg4aHJ9S9wisudupd0aWyrHgrZIYnQY6FOteU654ZEXlZ4Fep+Dj9D84ncg==
X-MS-TrafficTypeDiagnostic: BN3PR0701MB1332:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;31:6nHID1zM8uvA/TonWvTwwv7mbtuOeRnu3bnxFVC39yjDNadoutAk++v64a1iy83CoTfhVbdZ4rw0jP3iMNOH3CJ+CRPfgHv1qmLKkkp52TVcGn9dxtFWZQ+LUCPkiW3BzRt2Io7NAA2WuYjfVpg4XLDGu1JTEO1pgmAJ6dDPgrfT+NvasFUCi/4TXXfkQ1xThOiGKFKMGg6c9BoXYlpR8CGqpJSsn47a2WPGHWgBYkU=;20:9k3e0EA0sSnnkQ4CiS7Eq3WlRZLgkU0Gpa6b/bPtHwuw3mygsPX2fHEhF64UYEPOHnOHXPVC6/guJHTnUIIKjItbKw98F8ZezFHM/WWc29JOegTOG4V3GAVh7IpQeeSMD3/sfl9GvO0qJslxBimQ3LZUVosDHbgwCjcJIpAHCWKDy10NM8kGlUfvWkiLeLB7DdrAJtV50lHDIwFGPHj4GDtEZgExYytHVmuX6evLs+ffxJXpq1/tdp8AIEQNowCeJAQEviKd+uawkI5C4Kk1UMDSSiOga21VTb6F+vB2w6wOF45JQlBRaEOEELbloKwYTKLl1ujAGdqiiacQRnN2bEeUXChAbEFzdGC4kt1NW3GmN55xzdZ9IsRR6m1AOdz0cKNch1Bf/4nJVFxvRwXAjZm0TCSrz2X574H97iCgHhR2qnRRQCUlqzqbmlRbVsBc3xnfhIRx3J+t+aF5uKn2nPXASY51U0LUXD6f4HZr7O0GlsdEDyRnpqYUQzLkoMxd
X-Microsoft-Antispam-PRVS: <BN3PR0701MB133299A22841750E8901F430DD590@BN3PR0701MB1332.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN3PR0701MB1332;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1332;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;4:pBF5GHYab394NTPvuMaz9Vai95bWN7S48I2o2JtpxuEctXD8HHgX+Xg8RYryP8JchnqsGZObykm78dP/qEyS1LSt3alBapIek+eHwNx9CzTCshFDxgKsFXQVrvpU5WSKkMdaff8+7vbUefQKWM2nuXj6sQhcTeQbSBZfzmCApmw8ZoBkY1VbrtKbPi2Vm6Sl3A9YIIxnZXho7KH92Rd9a+Zn5XUx7HjfAR3FrAfKamFgDI0cmlV4NZ9uMjQyQET0ABH43mRCIwnkdzugzLWEFk4hTg/6b+Iym9JPj0uY17MYk2co8AjYp+WyaSk14tPC
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0701MB1332;23:JpbriH5dizT/9+jjIeawJ4nZlpJY8v/JOzLA3pu?=
 =?us-ascii?Q?GL77WqBR6HTtyISPOk2sfwPUx80+wCiUr2Zlnamsz7zIuU86GLPZcZg4aTTE?=
 =?us-ascii?Q?RDxQ26IkSS3hxRv56N+1fsB0dcd5QlR/zaHZByb5ARmkGUvB8IO8MaLE5CMh?=
 =?us-ascii?Q?axjnfMcXkI2oDRVOib0HPd3CgRcu/u0uW4f3Pq8p2ulBPq/Zb9xzEbSrHHiC?=
 =?us-ascii?Q?iuTfuw9KH9PrYQhE/h9LtEFZa7tmF5cylRBiKKw0KmfTneza2bqajXXDa7Vb?=
 =?us-ascii?Q?VMbW6/Z9yEUP1MBeLFot1yKD6pOtnK5rdGTfFa2kLyg88U5mCYJ+E5JmyQ+c?=
 =?us-ascii?Q?0yfwE+UXrgABvxW+dwjLGtazOxj1N+K6DswwvJoXHDjIcijeB7aI1SG7efL/?=
 =?us-ascii?Q?r7Vhzz9uUMF7DKRvIjefiGfqQAsm6HalG1pb4E/dxOyz1LMGtg/BbHWD1ogc?=
 =?us-ascii?Q?+2L0z/SvIuBQKjw6MhBX+8EZ6R511UGTvnwE6/CnrAVpWpcMRB0dGrfLQCXD?=
 =?us-ascii?Q?IWvuZtfpbyzmotNocs1AkleOezBXhrYo93MnZ1/rvOSaB9OrTFXf4eoSnV6u?=
 =?us-ascii?Q?sKmTu7tjhHjP4jdTif431EIaktME66OiJYvYD6wOjwJIEntN8nEUxABssV2j?=
 =?us-ascii?Q?6mOB80fnF+krQDWLhxwmFAdmv+q+fsBUmQSfnL0PfA/pPC61FQ3i1317BFt6?=
 =?us-ascii?Q?Snm1G9pUamQFbPW3MW0KH4SoG59viLzPhTCYFd+EzW89e9NxOVYf79K3EEYk?=
 =?us-ascii?Q?xUWxDNmGSWMXeULruA5Azfs1mOn4wb3RqOFE0HoFr3zWat5wuQqNHMsFyEY2?=
 =?us-ascii?Q?Ps782eqDnAJ8xNnp8jnASzvWQ15PJgaC58t6Jn2ZkECd5uxFdopOh9SmMFEA?=
 =?us-ascii?Q?jKZNqtGBEoc1oCrvlvCTpHeRnxb0+e+Q9BFmAWVydjSRfZtqjWOpfaMzrBYe?=
 =?us-ascii?Q?ESGbdJbMdDdQNYew5mCXcFeyuf0q4SALRFkyFyFtgLV32f4MPrRg44ETSdxH?=
 =?us-ascii?Q?TQrM06Pwc0VX4eX6rFWt0EP3JtAnmwrYlW9rKvj7qdT6+lXnHgbQruI9vJnP?=
 =?us-ascii?Q?YNzd3jAvMivynRAz3vFuSb7kOdE6Mljzr+mp4kLNfQ7zuFUjKoYalxJUAsuT?=
 =?us-ascii?Q?Y/b3tqEIrDkvCce40ndRc8AalOYAAaroQEGu1iqkTDiJQdtqV3N8FAA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: Ry7jmlo+ZJHUf3vrJJ+yJXgUoNd6GhalyBhElTEf8rR1kTMrfW2LZbgq5rYVg/z3mwPdIhwYXKFr8inS3EMX/70eYSE5ALVqB78xlhlIw4C59nnI8X2u/jdJjiJjEV0uHiaTIlf9FlzrHeLpXqTiA39SxtgXecN9mDqKL3KjGk00XDJkWbXkTTPj+2EizVl3VrBYnoDJGmaZzEoE5UJbVi6Q5apfM9lWg7Ypd1oHTrcbhyf2odUGToRxmV71QA8kvtpOXk14ZXr4+LfmKRyWG+sUZmHTy0QrPF0YnZBFzmRk5A51Fu0b1JKFAtfeTAnJprAVkJk2Gi5pMPwkQOWnlaiiYxI03XAw2v2oUWvBi3OR/nLLG5sxEFW8XwcyNFkdxr0A3XbhLJMq+9D85we8CA==
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;6:lxSH9R8z4k33AP3et/PBhx1Q62wXLxZpRUBB9WqA2PIClNRFQSLfI01w/1bzCfZdrNq9XuuxmSZ43IfH1uUAN6aAlxt3Os31VkBasZuwErWwer35T64diciDOWALkYkUntx5WTfPXSOD0kqRHgdqXyynJwxuJg4e/LcHrtJOw3vllp+6d+ii5pRrBJcKzwq9N057YN3J2/Kji+psP4xYKlpZ+gYRW/stnM+2YmEVY1caJI/FZBJ+rrHESGCyfI0ifrb7sPVqwrA+EM11oMg8C+WZXv4QfyqjdH39g6MELGHs4438AZpEyRxruBqn+iBoS3WfvF4SxMW0SEKZ/3l5wK+RpbAjBWCZOEBnK6v7ObttSyEDEHY8JjhJzcjlERLDiq5ycHM+4GNZ1/Sz3eD1JwBIMLLJevYUNfZVt0T2yQtWP6HlVZv1oVZPEfeJp6mAI0IMCYulAix+HE831TTYXA==;5:V4WkDDYhC2Vt+ymxMixEEPq+SL03tgIcPPRLKNv9Uv0GT5ZCXXI3Cn4X3XFwo7zkhEG9sbFhwpH2k2uDRQyhofWjY1t81w869i5RyVU/alAASktjBaBUH1gBsuRTMaP5oPnr9qfiB0vWmmMM0b20gYKq/g0Q1Mj7ZqixstqwEJc=;24:i1CjqUaC/fHfYE7AWSccaifkfmjEwmwatzQJK1S/r2WXuz844JkIF14I7rDD9JnXIwwgoVgs45Mguv5wAxz6lds555L2R4dHmelI9ZlHDwE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;7:yLf0MkfyiT9FwkFx4Tg7N8DVjugs9ISMLkaWUpd5zP5rCoepBLAcPQFcyCwY7PDoDHrjxzbdOpYB50gksJs5mxAXAaR1cr7IEix44jrlEwCwXjTulmHVTEejOv0laWjaaTTNFVhVJUrv1ke9gjAr+Lb9zhz5QVAk0cZC3tLsU7RL69Yvi2/2npm/7/SBBGXO7dQVcrSSL5vMqsS2QKrCwI/1YbBdaGcLCAwflzQbOOdHwBjMKgr2neeyJdUhzwCa;20:/J/6Tp2aS4AIz/scPV12mhQuivb4ObI9TI8j+/b40G0SorykMPmtX5jikV8ky1HmZJ3hTson0OrekbY936v+kvSeutEc3Rcgi55Zl7mCafHcw9wx8dfrFnz3nOm6RSraANw6PFhBgeoni19jG185azSWF72a61TwZlG6n+0kdGbGFQuG9GlICyOxM6AtwcMcUwvf7z1eyRpeXt9oL9UYdVlyMzuY4bBKS/JIv0NimF35/q4oTbk/zGJRhrCNllrn
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:48:02.0346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab3af62-c8ce-4cd2-599f-08d5e7bb0802
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1332
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch add functionality responsible for detecting command timeout.
Because command can fail without any command completion event, driver
must handles such case in proper way. For this reason, driver implements
mechanism measuring the command time. If time expired driver aborts
last performed command.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ring.c | 156 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h      |   1 +
 2 files changed, 153 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 989d096f64ac..f942c19fdfc4 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -288,6 +288,103 @@ static bool usbssp_mod_cmd_timer(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+static struct usbssp_command *usbssp_next_queued_cmd(
+		struct usbssp_udc *usbssp_data)
+{
+	return list_first_entry_or_null(&usbssp_data->cmd_list,
+					struct usbssp_command,
+					cmd_list);
+}
+
+/*
+ * Turn all commands on command ring with status set to "aborted" to no-op trbs.
+ * If there are other commands waiting then restart the ring and kick the timer.
+ * This must be called with command ring stopped and usbssp_data->lock held.
+ */
+static void usbssp_handle_stopped_cmd_ring(struct usbssp_udc *usbssp_data,
+					   struct usbssp_command *cur_cmd)
+{
+	struct usbssp_command *i_cmd;
+
+	/* Turn all aborted commands in list to no-ops, then restart */
+	list_for_each_entry(i_cmd, &usbssp_data->cmd_list, cmd_list) {
+
+		if (i_cmd->status != COMP_COMMAND_ABORTED)
+			continue;
+
+		i_cmd->status = COMP_COMMAND_RING_STOPPED;
+
+		usbssp_dbg(usbssp_data, "Turn aborted command %p to no-op\n",
+			 i_cmd->command_trb);
+
+		trb_to_noop(i_cmd->command_trb, TRB_CMD_NOOP);
+
+		/*
+		 * caller waiting for completion is called when command
+		 *  completion event is received for these no-op commands
+		 */
+	}
+
+	usbssp_data->cmd_ring_state = CMD_RING_STATE_RUNNING;
+
+	/* ring command ring doorbell to restart the command ring */
+	if ((usbssp_data->cmd_ring->dequeue != usbssp_data->cmd_ring->enqueue) &&
+	    !(usbssp_data->usbssp_state & USBSSP_STATE_DYING)) {
+		usbssp_data->current_cmd = cur_cmd;
+		usbssp_mod_cmd_timer(usbssp_data, USBSSP_CMD_DEFAULT_TIMEOUT);
+		usbssp_ring_cmd_db(usbssp_data);
+	}
+}
+
+/* Must be called with usbssp_data->lock held, releases and aquires lock back */
+static int usbssp_abort_cmd_ring(struct usbssp_udc *usbssp_data,
+				 unsigned long flags)
+{
+	u64 temp_64;
+	int ret;
+
+	usbssp_dbg(usbssp_data, "Abort command ring\n");
+	reinit_completion(&usbssp_data->cmd_ring_stop_completion);
+
+	temp_64 = usbssp_read_64(usbssp_data, &usbssp_data->op_regs->cmd_ring);
+	usbssp_write_64(usbssp_data, temp_64 | CMD_RING_ABORT,
+			&usbssp_data->op_regs->cmd_ring);
+
+	/* Spec says software should also time the
+	 * completion of the Command Abort operation. If CRR is not negated in 5
+	 * seconds then driver handles it as if device died (-ENODEV).
+	 */
+	ret = usbssp_handshake(&usbssp_data->op_regs->cmd_ring,
+			CMD_RING_RUNNING, 0, 5 * 1000 * 1000);
+
+	if (ret < 0) {
+		usbssp_err(usbssp_data,
+				"Abort failed to stop command ring: %d\n", ret);
+		usbssp_halt(usbssp_data);
+		usbssp_udc_died(usbssp_data);
+		return ret;
+	}
+
+	/*
+	 * Writing the CMD_RING_ABORT bit should cause a cmd completion event,
+	 * Wait 2 secs (arbitrary number).
+	 */
+	spin_unlock_irqrestore(&usbssp_data->lock, flags);
+	ret = wait_for_completion_timeout(
+			&usbssp_data->cmd_ring_stop_completion,
+			msecs_to_jiffies(2000));
+	spin_lock_irqsave(&usbssp_data->lock, flags);
+	if (!ret) {
+		usbssp_dbg(usbssp_data,
+				"No stop event for abort, ring start fail?\n");
+		usbssp_cleanup_command_queue(usbssp_data);
+	} else {
+		usbssp_handle_stopped_cmd_ring(usbssp_data,
+				usbssp_next_queued_cmd(usbssp_data));
+	}
+	return 0;
+}
+
 void usbssp_ring_ep_doorbell(struct usbssp_udc *usbssp_data,
 		unsigned int ep_index,
 		unsigned int stream_id)
@@ -1056,10 +1153,6 @@ static void usbssp_handle_cmd_reset_dev(struct usbssp_udc *usbssp_data,
 		usbssp_warn(usbssp_data, "Reset device command completion\n");
 }
 
-void usbssp_handle_command_timeout(struct work_struct *work)
-{
-	/*TODO: implements function*/
-}
 
 static void usbssp_complete_del_and_free_cmd(struct usbssp_command *cmd,
 					     u32 status)
@@ -1082,6 +1175,61 @@ void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data)
 		usbssp_complete_del_and_free_cmd(cur_cmd, COMP_COMMAND_ABORTED);
 }
 
+void usbssp_handle_command_timeout(struct work_struct *work)
+{
+	struct usbssp_udc *usbssp_data;
+	unsigned long flags;
+	u64 hw_ring_state;
+
+	usbssp_data = container_of(to_delayed_work(work), struct usbssp_udc,
+			cmd_timer);
+
+	spin_lock_irqsave(&usbssp_data->lock, flags);
+
+	/*
+	 * If timeout work is pending, or current_cmd is NULL, it means we
+	 * raced with command completion. Command is handled so just return.
+	 */
+	if (!usbssp_data->current_cmd ||
+	     delayed_work_pending(&usbssp_data->cmd_timer)) {
+		spin_unlock_irqrestore(&usbssp_data->lock, flags);
+		return;
+	}
+	/* mark this command to be cancelled */
+	usbssp_data->current_cmd->status = COMP_COMMAND_ABORTED;
+
+	/* Make sure command ring is running before aborting it */
+	hw_ring_state = usbssp_read_64(usbssp_data,
+			&usbssp_data->op_regs->cmd_ring);
+	if (hw_ring_state == ~(u64)0) {
+		usbssp_udc_died(usbssp_data);
+		goto time_out_completed;
+	}
+
+	if ((usbssp_data->cmd_ring_state & CMD_RING_STATE_RUNNING) &&
+	    (hw_ring_state & CMD_RING_RUNNING))  {
+		/* Prevent new doorbell, and start command abort */
+		usbssp_data->cmd_ring_state = CMD_RING_STATE_ABORTED;
+		usbssp_dbg(usbssp_data, "Command timeout\n");
+		usbssp_abort_cmd_ring(usbssp_data, flags);
+		goto time_out_completed;
+	}
+
+	/* device disconnected. Bail out */
+	if (usbssp_data->usbssp_state & USBSSP_STATE_REMOVING) {
+		usbssp_dbg(usbssp_data, "device removed, ring start fail?\n");
+		usbssp_cleanup_command_queue(usbssp_data);
+		goto time_out_completed;
+	}
+
+	/* command timeout on stopped ring, ring can't be aborted */
+	usbssp_dbg(usbssp_data, "Command timeout on stopped ring\n");
+	usbssp_handle_stopped_cmd_ring(usbssp_data, usbssp_data->current_cmd);
+
+time_out_completed:
+	spin_unlock_irqrestore(&usbssp_data->lock, flags);
+}
+
 static void handle_cmd_completion(struct usbssp_udc *usbssp_data,
 		struct usbssp_event_cmd *event)
 {
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 8512ef727b98..38ae684d71e7 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1786,6 +1786,7 @@ void usbssp_set_link_state(struct usbssp_udc *usbssp_data,
 void usbssp_test_and_clear_bit(struct usbssp_udc *usbssp_data,
 		__le32 __iomem *port_regs, u32 port_bit);
 
+void usbssp_udc_died(struct usbssp_udc *usbssp_data);
 /* USBSSP DC contexts */
 struct usbssp_input_control_ctx *usbssp_get_input_control_ctx(
 		struct usbssp_container_ctx *ctx);
-- 
2.17.1

