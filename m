Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945B7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3565820856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="MFJYFeAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3565820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733009AbeGSSnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:41 -0400
Received: from mail-cys01nam02on0045.outbound.protection.outlook.com ([104.47.37.45]:12061
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732031AbeGSSni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0rbzHUL+cL9PdBL0ZE2NASXqqiZ3aqVnXquqvf6ep4=;
 b=MFJYFeAKnckaKEmiKESlc84cL899Co5hLrMZM2Ecfoy+mr4cNGsizSZS3ZfzdXqmVINcdkZCaOdZM7qyX2NTCxUMo8M08HP2E3nAJ++jtMaH9MXi9J8iE7Er5twQI47C3rNDvN9RsWtxqw5n/9noeaadBY1jnBiwysKYlUAHQxk=
Received: from DM6PR07CA0027.namprd07.prod.outlook.com (2603:10b6:5:94::40) by
 SN6PR07MB4717.namprd07.prod.outlook.com (2603:10b6:805:3b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.21; Thu, 19 Jul 2018 17:59:19 +0000
Received: from DM3NAM05FT025.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by DM6PR07CA0027.outlook.office365.com
 (2603:10b6:5:94::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.21 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:18 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT025.mail.protection.outlook.com (10.152.98.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:18 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxAS1019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:17 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:27 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:27 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxCFY005781;
        Thu, 19 Jul 2018 18:59:12 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxCwL005770;
        Thu, 19 Jul 2018 18:59:12 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 11/31] usb: usbssp: added function for stopping driver.
Date:   Thu, 19 Jul 2018 18:57:44 +0100
Message-ID: <1532023084-28083-12-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(2980300002)(36092001)(189003)(199004)(486006)(4720700003)(5660300001)(14444005)(246002)(6666003)(476003)(2906002)(48376002)(11346002)(478600001)(50466002)(1671002)(2616005)(126002)(305945005)(87636003)(8936002)(36756003)(26826003)(8676002)(4326008)(316002)(356003)(446003)(426003)(54906003)(42186006)(16586007)(109986005)(86362001)(50226002)(186003)(336012)(106466001)(51416003)(107886003)(105596002)(47776003)(7636002)(76176011)(26005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4717;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT025;1:q/GdbBoOxEhjOUyrwHOBR7IQtkBhcBYWk8ZZrKadZILugZjulTS7oxRSy6jRmdTkh60tCO6l/X9A0rqQYZxb1S+j62MRlXpyPy/uXIqMMxUj6/qVOzsz4uhc2HU9gvvy
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cec676b-adf2-44d4-47bc-08d5eda15935
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN6PR07MB4717;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4717;3:IJB7Oqaox37AHD8LtTN+D39/blVxI12G8K0yoKUQn6l62mj7j2uJfaDoLzsyZs6rHxdvFp9jSKLUTgLk6nUvuIDHoHxTJCeHKT5A3lD6ViPKquNx4+SJGXHlaSyWi126NJcxJswzEB7otqRfN1Zd1E1b57/58+nefKQ9z1rtAF/+c9r+LOGXzC/1SkJcxUIsRFmtRkY6WFun4uwIYK95LHK2r8bOOaMZ4zypGowj+Ydd+QLOiqGtYrGy4Q4km36qluTv5Mb5RVoI8grM51CxFoxHHUduaW56akHrAeuyL8/Q+RIF36/2KFsPKMOvmuh/66OR3aLmA+URfYYdwrQiOhdsR+ANtFfJ3iHtyJfr95k=;25:PFIsw4l3aAuZIbKAlzc/Kr02lOYRO7wapXnzO6K+JPk17vJ8B3IfEoy+XWct8hJP+qiT5/cb+ztS+kvsCbpjLQGfu5GwYX6ejMQSJxo8gd+lNmLqCh6vnfmFKOEvPMn98wdGWZmB0bxx2h0blyGQ6D6rD+IZIP8drx4ZdWxamvQx1Zl/+MOSIOn7FuDH3/kEmn7fsLE0fcobPSGoBSrLbMJEpWzeXXX+dQYjbp9MuNW1X1Go+9lz+nRaqg4mPT6Wm0BvHnQ6XeJ+7whV+37hOkjlXU7/NYWYHS7iiS0Bx03dW8l3mWcuRGz68EURosdlD31yyQGtCih8zvq+Ng+yGQ==
X-MS-TrafficTypeDiagnostic: SN6PR07MB4717:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4717;31:LfYhC3n0loHSPdYVJ5pDjlv5XASUrISw02Y3fxFpbkDdQCDSih4N9YXr4MDZKzsnMSsdwIpMinIll/anZeVdGomCYOhGNiuzah/sPTa00G0DHoS4aHE5dfJC9qxLWofj58Bw32Mx20DZTCizcBjDIJlAH9U+qM48RfutxhHKzuK0tnGgT9poG0qJUhl+CofAfc4wz4DISUiQi+wECZu0IAgueMnhRyS2sLGNIqC/tX8=;20:pcRlkio+6fB/7HTCeMriBv0dVggU0NGnPNv8jDVYtF6W+jiZJb3b69P2wz8Yr5ghcCHVP8qFERYCUbKOqK+yRS2BcYeUXWSmXU13myk3sW50LvqGqQhP/jIzE+WxTQKAYBkpQdbnCee/WtEr21lxOUOGpll4JvEthc8f31ShTZcG5RV9KOdBKA18MbQFFBlBD7mqrHCpzwIufJtmYitPKUNP+1vv44y7MBd6JSKczuyaoUGt2VtDaDRpYGJANK23QJ/+pKOIV8ZH0KbreE2srFAvzWxpQ+0lFjc2NZ5y0JYeOyvvHyf6J6lhouGDhoKWqNO7G1LXwhotyJXvWK4aPTAck79ptN69GHa8TT1yuML/PGtmx1/MxWk5WmOmEVmmvgB9jh/1wR69EiZEcpp3rPan8BZqiDQC8m2Hy9v7pbpsnNwWbpSTcPwJIEmnPHfzae5jxYGizJxpeEMhq23APWGbL45LEqmuq0oGuPld4liIxe+Dmt48GqKnzs0BfTob
X-Microsoft-Antispam-PRVS: <SN6PR07MB471791F85614EE5F1909D600DD520@SN6PR07MB4717.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4717;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4717;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4717;4:VqUVraPqCRO3WOywvgHQukRUP+FgCpqIXPwpjYcBHjqFtKy0idDb7Rs7SQ+9eKbOVlL5ItkxCGTco20pIR9prsiMTLNivGRErKcFw4y+M1hhd4KTWH8Nu6/cx181GHtTMbtWQGmY1iPBksKUx91D37pLfs+XobdqJvRckijR+5bLlhWWavhyQ1au5kv3rre9bHd+dhmQeRuQxh/83cO9pHRyu5I8zSk2YyXHsQP94vmpcPc1RQQxxDfuXT8W4OvVZaeoIQ33/xkN2HNu3dM6zxHhqlTrznxPpBFHlFZ4NbdKKEHmjpQBJkpvXB47pWgs
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4717;23:uuKq1wzsaOpAW088uX2JAkmnsN5BvFnSVDHfhap1L?=
 =?us-ascii?Q?cE/oP2LVpzPg/5eGJeEQswKRmyZS2e8yx7LcAvQetoBpr/zaXJpJeVU1YFB2?=
 =?us-ascii?Q?1xKl2MnYOGR5F/cfxKjsZ40zHbcp/C6N7WOY68IFRDbRHFwLkvmjGqwLKXRO?=
 =?us-ascii?Q?ZeauPZQoh2qeOHKazhgxGcM+E5sAKYq5LnX10eFVPmv9ZHraU4OqjoZuZMCw?=
 =?us-ascii?Q?x5ypeLk3Dajjk7eSh36MWiv7zBAJyd5ozeqzPCWGj4DzT42NQdIk7UGhAwbn?=
 =?us-ascii?Q?MnyJZTkegiFoES+2J6IN9yxFNqoGhzdgJpYKaqEcp6AfHJua+1ZS6yvCN+TT?=
 =?us-ascii?Q?mw7v/ppetVt/20d46wBoXxbZb5VwZDqDNJdzl4PGAbR6tOD1fDO0B1fTHHbh?=
 =?us-ascii?Q?UJnGJ6zkqe5XxL8Zvmmx14ewzRqNPY1g5XvZBEetThiIyCrvGO16cwiHUJ+8?=
 =?us-ascii?Q?HCkm5HCkE+sc1BLaicbmdb98m/nL6gEq4j5PSyruF1DUkGs0WuYLH3rfCPgO?=
 =?us-ascii?Q?8wwrdKqK9QWkZTItUQw/4DYtGLCiGW32rj05tEs+q3cHRCWt5I71x+RWnOrf?=
 =?us-ascii?Q?itKC+f3+viRF2q9tnQyH10+LSUwKnW+BnS8kQcym7Wgr523JGbT1QkPcpL6J?=
 =?us-ascii?Q?uNgkqh4asi3WtdpnyOHO6fbz43yXr7NNIH7UddgG9+w//q1p15ydfNW7HYNZ?=
 =?us-ascii?Q?Fyrsq/5Eqc8rpS8IOxT9GhwDXZR7jKocDGZogRouv7WC8Xw+OBk/O/SFuCB+?=
 =?us-ascii?Q?WfSYzEbNLq69P2DqL0t9yv5fcIVA39O33DwJOCIyP9fen+pXUM/VPCpNrZTU?=
 =?us-ascii?Q?psxcwohlSsWYxsmIwKPUQcIO2eCVCopxh4usGZHEi4tiPFqx4YoFWC9BzaGS?=
 =?us-ascii?Q?rHYJQMljag9ikPuCZquJIzZm1OMonpdOIfFq6AEJcjnlLkTWpwoZcnt3gd/a?=
 =?us-ascii?Q?NUEsrYced1u/YYWDM0aN3/XNRzlLIR73nsfILqWc50/lFUYOT37dspDWM7Cy?=
 =?us-ascii?Q?gmg8ftS2m9ZhkZDj7weioyN3KB5HQBtfdrjllrl63q6li4vy2qFWZNkqwJKA?=
 =?us-ascii?Q?Mn6U+0aV44yIwFt30bwj/FONzVkCv8dJwtPS7hKLnYtUtCMQxNEchnZGsf5d?=
 =?us-ascii?Q?NBM2RAt4jx/wuAzgzdT2FpxnKYoUT2VSJKkHpctRnKtPhMMAJgXjA=3D=3D?=
X-Microsoft-Antispam-Message-Info: eWnad0RiEGNsbTI/IU9GYByRDXVflVCR84Ogw+1V+ARWZ67lTGNiptr6t/Met53+k50+zURDxMS0lduGfDVmwkgnFcZw/oivt+ofd6kikA7Qj/xBlMVdEOSsYtcCoGWJ5maBtT2zm9fgvCMlQMlfzspg69RqO4eTRjdvstlVhyT3wsRtGu9CNlcA+EUcYm1VykPLRTkLEVYUOQD9cb71FnKy/aBLagvu/VldgeWwJXbGspI8tt97BmXkHNERGecsdIeIgLWFvjFIKxS3z3zSkeTx47IxsA3/Y3nkFvJa4BCZTqIEXTVqBdnfmFenDiZGF2O8DXZzvQJUfVo8JaxQgwO6ZVFmofQ2O3F9q119GhhV5kn/P3gc3M7MTD/QEDXerhlfrd9cvljYTZdOMpJRvA==
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4717;6:6tMEx7AQGWeColjinWxR0GhyeRQr9j4OEUYouCAHbC2ThFuVIUWZVJOgr+PS6vzmzVczjerGcW2atu4bOSGnGlX6zF4Hum+C6uAwAxdGSfWGCVY4cglFK0lwGOUtQfJu3/eA2exvcmgy/WXpf1cb5KQeXjf2ER7W8zYrvclFMATZhv2r2nv6t34+5M0hsBaPJsDuKyeeokx5k0Uiu59j118tL0TNzww2cw1eoWC3rHDqMHrsIBYnqb71hhHnqULwkB7XClMiyg6t3yU+JZe1fyxrB61LhCkrQnJrM55hMUuPYXS8PVGBPG7dTkwe/T/snCVvnPWNHHL1XhbFSCn5d8jdFBTSuJr5WnXX98X0hapAP8HD213DMsvIj5V3AIyaH9bPq2RfBGgnY34GvTRVRt59ok4MEguXQahiELWWPkANIbIrZV6z6JPUiuHiiWWsxRpXekVXEW+KbU4vtmBM5A==;5:8YoVh/CQKNhpUlAOlWv6vuhMonxKkHqOAmgHTlmt4YrwxlRY0kxSQQr2AHLEnDXVNPAp73QUjiCCJQ7jc9ajHg2nGfKAcqRbKroqnxQzold8xa+8rdnwjHD0m8ylu4aJDk+aJCn5P1iAbQ8MYktnR/ORu+O/G9Eu8OE8j4NdN4Y=;24:Lbj/Q3N+KfWLn8LHoTu0qogO//lEpPPyyJMp/rgGgHtpbAxq+PyKvcrsgOF6aQC1T9mgyStLVzyXDad3lRTxoWaa+9+BCEvaXqWfRKUs9pU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4717;7:9iAjfUs2bZ1gRUKkTApYwsNnV4swAIhKIpJc2g1DHkdpr0wUNJYsH1VgEk2q8BtGQvjbfuy1A9SOFzzSxdLEKxsR5LTNAzw7XX+QgwzfSo0/mhzsS5qJ1lMO7d0gEoUsYZpkJbiJzylmeOlbGHJQ/TnwqbgUH45EQU5RgsYW0pLkLgQj+YjzWEHRG3JdgnwY/ITUDk63wuU2aF5BmvXWA8DsilO6vihEdRQX+DiWY0efMopJ2Ra0tCUMtE2ra7lS;20:XiIz5qtNvdgxJAlMTs9QMf1Cxh/jFdYynfQksk2pkgxhCPdILoRmFWlI0ZM+/WJS61Ydxd2Co7/4UIA2D8rQ3c62cpcwmpWAqGoeIyE9PlxJF+86z+i0XGomGX2QH5WLAkzaSxPnFlPPk8hLEC1WbEjo/QgFEoVgBdYh8z0gh7MLPZQnLtmDC8N7agvL0UBENl4jU4bJFq/66wP6LdYd9Tsyj8s7q7HKcOqdUuuBDAyyJJ25Uthwudm+dLkV+qOz
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:18.2005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cec676b-adf2-44d4-47bc-08d5eda15935
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4717
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is called by the gadget core when the USBSSP driver
is removed. Disable device contexts, disable IRQs, and quiesce the DC.
Reset the DC, finish any completed transactions, and cleanup memory.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 915983bc400f..2996b1d3baf7 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -200,6 +200,41 @@ int usbssp_init(struct usbssp_udc *usbssp_data)
 	return retval;
 }
 
+/*
+ * Stop USBSSP controller.
+ *
+ * This function is called by the gadget core when the USBSSP driver is removed.
+ * Its opposite is usbssp_run().
+ *
+ * Disable device contexts, disable IRQs, and quiesce the DC.
+ * Reset the DC, finish any completed transactions, and cleanup memory.
+ */
+void usbssp_stop(struct usbssp_udc *usbssp_data)
+{
+	u32 temp;
+
+	spin_lock_irq(&usbssp_data->lock);
+	usbssp_data->usbssp_state |= USBSSP_STATE_HALTED;
+	usbssp_data->cmd_ring_state = CMD_RING_STATE_STOPPED;
+	usbssp_halt(usbssp_data);
+	usbssp_reset(usbssp_data);
+	spin_unlock_irq(&usbssp_data->lock);
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Disabling event ring interrupts");
+	temp = readl(&usbssp_data->op_regs->status);
+	writel((temp & ~0x1fff) | STS_EINT, &usbssp_data->op_regs->status);
+	temp = readl(&usbssp_data->ir_set->irq_pending);
+	writel(ER_IRQ_DISABLE(temp), &usbssp_data->ir_set->irq_pending);
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"cleaning up memory");
+	usbssp_mem_cleanup(usbssp_data);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"usbssp_stop completed - status = %x",
+			readl(&usbssp_data->op_regs->status));
+}
+
 #ifdef CONFIG_PM
 /*
  * Stop DC (not bus-specific)
-- 
2.17.1

