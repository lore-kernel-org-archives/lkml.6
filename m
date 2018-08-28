Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF43C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B14C20842
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="M5IR1+/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B14C20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeH1ORK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:17:10 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:54240
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727085AbeH1ORG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtaAjHOP2/FHQdJzEkk00TEYZ8koIh2kZ35H+9vkmqw=;
 b=M5IR1+/LvAuDJ/iDHk0Y/D1y7ZWvBrpnTcSoo/Ku936QS1PKW7ZhHiJhuhbseu/4xJ2985u/b/hf+KQK461/0VhrBmGSoF++JEXsNcThC0XVCXBlO3pohuruiZXezlKYzf31vHRzOjNO+MNIWQ/2wS9rzfFKuJcgpFS77k2ouyE=
Received: from DM5PR07CA0094.namprd07.prod.outlook.com (2603:10b6:4:ae::23) by
 DM6PR07MB4409.namprd07.prod.outlook.com (2603:10b6:5:bf::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.13; Tue, 28 Aug 2018 10:26:03 +0000
Received: from DM3NAM05FT023.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::202) by DM5PR07CA0094.outlook.office365.com
 (2603:10b6:4:ae::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1080.14 via Frontend
 Transport; Tue, 28 Aug 2018 10:26:03 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT023.mail.protection.outlook.com (10.152.98.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1122.2 via Frontend Transport; Tue, 28 Aug 2018 10:26:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w7SAPsBY018582
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 28 Aug 2018 03:26:00 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 28 Aug 2018 12:26:07 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 28 Aug 2018 12:26:07 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w7SAPstC004226;
        Tue, 28 Aug 2018 11:25:54 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w7SAPs6h004197;
        Tue, 28 Aug 2018 11:25:54 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <pgaj@cadence.com>, <ltyrala@cadence.com>, <stelford@cadence.com>,
        <jartur@cadence.com>, <piotrs@cadence.com>
Subject: [PATCH v3 3/5] drm/dp: make dp_link_status and dp_get_lane_status usable from outside of the core
Date:   Tue, 28 Aug 2018 11:24:46 +0100
Message-ID: <1535451894-2518-4-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1535451894-2518-1-git-send-email-dkos@cadence.com>
References: <1535451894-2518-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(2980300002)(189003)(199004)(36092001)(42186006)(305945005)(336012)(476003)(51416003)(7636002)(110136005)(486006)(6666003)(47776003)(426003)(54906003)(4326008)(356003)(76176011)(107886003)(5660300001)(126002)(86362001)(186003)(2201001)(2616005)(11346002)(446003)(16586007)(26005)(316002)(14444005)(7416002)(48376002)(87636003)(8676002)(8936002)(50226002)(2906002)(246002)(478600001)(26826003)(106466001)(105596002)(36756003)(50466002)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4409;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT023;1:Vfve44ClVyc+XB27rmsRG8lEOXEhoxAXLZI5ZMueVr7/yKFlkrRq0rYgmK6lBiYFjAdOAJE7YATKk1mPZWqe4Ot/LZBqjbFma71jVVBwrD+0pqaOrDeTzPt5n4wZRhxw
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 971fa1b7-bbfb-459e-b7f8-08d60cd0a7f9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:DM6PR07MB4409;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4409;3:46ow9Jq6i8jnNnhaLC1xpUNiJRiO2vQG2cs5inAxRudd9E+3r+kuSdZskqo4ywgmku51dBJlWV74/XoZIg7bzANMNydyNZX0gqqd10tWSgWb9ou73gCGojhE/NpLXCM8/jdSmgZcjL9Jv1HV1uvHCfHJiYqNXX/Zzy0nzs5zNAci1cXX6cIxSuMTO4tkol6sFINjFz/hR4x5SyDPzByXqmvBQ6iWoJ20DrMIMZ4LKhuIQZ7cjxJm6B+EfJodBZ+KPJNLMt1UGazgvGMYv4+uF1sWIEMpvyD4Nb0+2FmA24t9MXiTqeB5yUDeg/at2Fswfw/BigURIPIBKn0pwWYfHg==;25:V/xiGTJaPnSjRP//RR3tSBRIl5iIB2bh+ixfeq7vU65weKi7FC+QqpKPgzD+6x3YUtF9Ocwyifnr33GTUXJYNBUM5KK7Y3JNIxIbAMLOAlxatvn2t0djmubCd4s+PHGYlp6yNUTDjUx5/+QLusTGXKppK2fOueLh8wkKzJbnQFWMdYM4O/4IlCamzO+IeiZ333J7Q6GMDSJ0q10zCppczc2dNo1BuE18vQt0As1Cg8SUi3769o7wmGzeFIr8jt8qUOL9NU8ykg8DlmjimvSeNbDAXeGleySdsINwodhXBvS7oFJA9Qe+YgHUwMeAZeQEfMm/aZYQBEI+6tb5OS7RUQ==;31:2TPEir9NeRmIpc8UQWTz18hytUIPIqTiBRqwCZGim2ojYPNX+ijjhskoMwdRY3QPiss2zwG4Tl45QVXUaOzGl4cIwi26o/4pe13IXdfqG2dUqZiZkvnus9zXOGnrQUsppxeZz7wPjWmibQmeV/0a/qNoG8BF//VbdFKz4Wgv/bJbRIDaATq/9a3YGVSLBYb7wM680QCf7O6F/nm+SEuGBz0XhdfZctN02HJqSllFkYs=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4409:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4409;20:xB7nWQvLwc1UG8N4DJSp9+xuvlJZnRoSjm4r3IVP4bniArhWdUm1r+6ff82s7RIKew5l+rRNNqkwRBJeoZ1ukOFtnhlgJ09Ewj4gDHQTtTPbZebwLeYSVrxmLi3P2r0sOCjVMRrm81IY4EWsbDD+zeygkSBBm4m+vQCxKJv+5ntBa2kO6I2L25dpRVGktJWJl2evtV11RYpWliTOKGqP52DvCi7uRCsCio+faBPtX5uWeFhpBJXM5LEJFAlOVZzMNfsq9z7SzotPJnft0PO01Qoe0c34c+3h4VkKo6ia9oGfH2UWC/0TkE8ZCzLZKgOoZgQlAFY15nz6He//ySiD7LiVa/MHWQ95Fnz09m/tlWSoijCdFbFGISZvLIxSfqs5rxkZ2sJ4UYEAQ2x7urSCGOd6VXA4cncabL52y3h5Z+cuk9+9pWxCguQPnf5dKRdWovqlywMol28SbzGo7AblqCBq5TL6YBWAs8bQRwCWLSUkdQJfkbsFUgvKPEeWB375;4:K6fPt1zTgMVuKUnPhRRZbOq7y+wesD95ckUlRhLKU36hNuPZsuO4HCVW4BD9G3reCDY6vn8+OHGa+y1Y+KGXjIBOxMouiW3Ws9cGEiSosDK0bQSfpL3dlNaAyiOdUGTepTwlwcgvUt93LGhAGziftEWUZCZI5M7ByZpc5vddBoZfhoxxL1H0EivmoWdeu0p8oz5m12BqtfurC7fxrrdYImwyfP3rvAXb6njbeRcO1KTQ9vY6RCwwfedem0tEwO6chV6UfB6nnukRh0ij9cSQRrE9W/7+1/l9OFQ0Xv3f4DSBOqYMDb8BBsnOuRviChhN
X-Microsoft-Antispam-PRVS: <DM6PR07MB4409933FFF0AACA3C6B5A02CCD0A0@DM6PR07MB4409.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:DM6PR07MB4409;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4409;
X-Forefront-PRVS: 077884B8B5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4409;23:jxWNAiw+86IC0klp8C5UTYtaZGQ3NuTEPA66qXAKa?=
 =?us-ascii?Q?BnASCcUf1wJkz2+1dMdCgrLOl9roYmy+nMZH97DE//E4TVW0Vgx0YdjlfEJR?=
 =?us-ascii?Q?/j9mSvjCCVf5nvP7MwZlBE2Qxu+VFppcW3OZABcJemWkQRQvV8aJ7C6Ytpj1?=
 =?us-ascii?Q?5WQcTjRJYpLj5FxQQIgsvxa/TAsOBbhr3Vp542hjY/PPlPIKaxTNDgTRGCSE?=
 =?us-ascii?Q?VUVBvJzP816nuEyoAR/FaONLlN4mYAGn8E0Lm7qeMgTYYpfQqV5BZ4QyGCKa?=
 =?us-ascii?Q?lN5XfySOrDAGZLjTbD1cOGn9N5nd3xSTu1P5N0PGHYBI6os+tz+2Fgpj/UYi?=
 =?us-ascii?Q?btiyw3ws2YhMK/8i5fNSSEVh2m5BvotNxblXxfMifuZR9O8oT7xdUiq3sI3V?=
 =?us-ascii?Q?rMzeyQRMKFM0pSCUcZUbof/0ptBoqY6X/ZX86puh7IfQs79EzVNbUqTSYbtp?=
 =?us-ascii?Q?sOEBwQlj5cy5C7Xr4HKt5dKxJIuPOKwbN0R3r5KcfDXHAHB91ED+L0OorFV6?=
 =?us-ascii?Q?k2IXaEs0N3klDYFg3K8tVm7IKmHII24UeaOAvq2Hqx2wnVs7t0ccyMOhi8p0?=
 =?us-ascii?Q?i/LnLkyBCmejLIKXmNSHiXoO7g0GSYtJIA2/o7hi46om/09UL9AHP4TKVh84?=
 =?us-ascii?Q?LnEoKShWOEJ+9mR2sYKEw3pjz3mHYv37NzLC9iw7XdB4RBWb4VrlWi2hcMR4?=
 =?us-ascii?Q?A/dxTpROO95O2J8QTVJTruhQHN7/upFOq/7hmEeC5cY1kJQIVFvx5eqoRqI7?=
 =?us-ascii?Q?yrU8hyNnJE6rEuRjYkgF2kPQera0l587gYkJc8lJtCIqXV6+9DGKYRbfNdLb?=
 =?us-ascii?Q?S6P/X/7oPDdTQ6U6ezAolpkSxjDdr9Ji1T4P51J4zy1RSOkOPELCuE340yL8?=
 =?us-ascii?Q?YXwzfFiLiQKoMG9V0kfbZ3RKDjxOWQO4hPU967rC3LSxCxVABFMj1acobUj3?=
 =?us-ascii?Q?ojXCp+Ni5tFYwKHkHDJ/eszxYNVTi5MtunR0/5NOYNE/MTZ+hV30q6oXeOxb?=
 =?us-ascii?Q?xyX6d/DPZdX/VwepXx2EX7S8e6iy4XJKgUn/MgH4NB0M0xDlGEb+sf0HFKfI?=
 =?us-ascii?Q?NyZ422t87yHz0pC/Iww3e1RCYpStmJ5r5WT4PMCJuIK2JhUf3KkepXjBy8Si?=
 =?us-ascii?Q?wjSaUMiMpnxq3O9yx29iB2fViF7samyswxuveupkEvgOOY/IYTRIHY1mKDUQ?=
 =?us-ascii?Q?41d1fsEsNhajjnZ280bLJ0KMIqUeZlqkpAf?=
X-Microsoft-Antispam-Message-Info: u0Z+QTzYHipAG1piGz5U/IKfZId+WcKwhFVfssahloiddiDlH9UMpacwtKRJT+tHIADuFWf7mMN6iJQQDWpkAGSwb96pyoSej5ZP8S4g1WyACcVBu0k2VU/j7z3GMYHi8jWIlmA8lgVZ037SpVlZ6RrzIRzXgKDF/o2zHKKpQmLr1WlG0A/6/pnAqVW6x4fWJI9zJsn7tvcfaaHEV14qwUfNPyXjqW3abyCKIhbgSNrWe5Hm4o8QS7v+py96I7TLHAszQjkhk1cTopdNdeQvNUd++5UGZV2x9qecH0zkoUhJRC0QtbS0bwyAehFZNhDDxKpI922sCpwwCbhzHi5mD0GcROu2k3UU8EjWQTykN3Q0M5X9miCjPgynCkl9XQTebBON5EhLYIv9QHJ1ncMgxg==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4409;6:KeIXHQJMYlfvJXHZ/5+23HFiKg8lywQS2Fh7nmYLg2UGjnekpAZ2D/eNX7RaaCS7KKIDD2UodZ9f57n8XcjHdDifY/qkMdd4+8GE5BpqrbluUpOVX0abFzPWRsTR6QznunjiPMuI8og1LZv+RqYvqgHViI/oSws6PA4Px71Nt92pXFzyN4db+HTXxlwR5NrQ9Vanle2GJ9um/ihy1WlU/YhxOF1voFTJMbNX2gDNH/XxUKDLm89dpi5ZLylevCe9hmMnVjAUCSQzuxrxt28ntyEoBiWA2AzvUWPHebknPox+HK9zf0LWxDtMUndvEm16ETMDxXnHuh+SwZQtIe8Rer/sE9lo7zf9T3Z1IXTVmMsb+JZ5FeoiInfYLNa1Q0tc0MgcJaAG6DnTXhZgLWmh40NxYed5sYhwjbNpzH3QZ0/eyOlw/YyG83oyOQnQ1GAsPZ7VqhaFGoXdZZLAmMmUcw==;5:ooGAw3r9Zkgjx22hQGB+MlA9b8zj4mBWo+p3NnRXui0SgJHwh0Ivl01oHPitB3LmjCAriNbpAviZPwVaKztBzhu/jUy9hqfeEKYATAuyDeGcSOQq7YJmstZeX7TK6pCkj7dpxQMmS6k7T6CkXcQcC+W66WNTzhoB3ogyyJFOaHE=;7:cM3v81Fio8rq16PDT5OCEWrclSca7zB/kZsAk47KYdT++kvWjwUUdyRUOwWt9tW2uM7AfqJ46bJsQVQxWRe4NbfE8IEXPcPo4aGfVLU1ikElYpwOAkowCBCC1l65sBdd0W7MZpXa4/ctgVsugKK9WooD4RTqYNSi9weEgS6q7okLxbTfOnGHvSJzX1lgl7pjjPIMCqK3P+UQKO5KcxQZFXq5tPrZrFCBI+sbDzh32qNi+CCU4PoQsSIzm6ZFrdt5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4409;20:fmHJwyQZMx70a4odWXF5wXvcH2uetSOYPelEEPbmUK29Ee5yuczxGTiqHXd6XnyESvetysMn+YMnxMGIiYviOp5Fjf8isPYRN2x6ZxnzUKI0lLkY4Taz39xtLB5Mj/n/HFLvyvq3q4Ha7lK6JvC9Th2WEyjCV6pByDKJZuVyt5BeUX1olevY3dnbva2I5fPCNtBR0rzVSw/Xzidtn+5jMoEnPYmO+Rr6TORvJmE73l7DjCrJvnOjEbWFqjIEbsmN
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 10:26:02.2582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 971fa1b7-bbfb-459e-b7f8-08d60cd0a7f9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4409
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

dp_link_status and dp_get_lane_status are pretty generic and can be used for
other means, so let's make it "public".

This adds drm_dp_link_status and drm_dp_get_lane_status to the header file and
add the appropriate EXPORT_SYMBOL for it so that it can be used by other
drivers, be they compiled built-in or as modules.

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 20 +++++++++++---------
 include/drm/drm_dp_helper.h     |  3 +++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 4b5bf6ee7fa7..ee9ec2ccf878 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -43,19 +43,21 @@
  */
 
 /* Helpers for DP link training */
-static u8 dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r)
+u8 drm_dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r)
 {
 	return link_status[r - DP_LANE0_1_STATUS];
 }
+EXPORT_SYMBOL(drm_dp_link_status);
 
-static u8 dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
+u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
 			     int lane)
 {
 	int i = DP_LANE0_1_STATUS + (lane >> 1);
 	int s = (lane & 1) * 4;
-	u8 l = dp_link_status(link_status, i);
+	u8 l = drm_dp_link_status(link_status, i);
 	return (l >> s) & 0xf;
 }
+EXPORT_SYMBOL(drm_dp_get_lane_status);
 
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count)
@@ -64,12 +66,12 @@ bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 	u8 lane_status;
 	int lane;
 
-	lane_align = dp_link_status(link_status,
-				    DP_LANE_ALIGN_STATUS_UPDATED);
+	lane_align = drm_dp_link_status(link_status,
+					DP_LANE_ALIGN_STATUS_UPDATED);
 	if ((lane_align & DP_INTERLANE_ALIGN_DONE) == 0)
 		return false;
 	for (lane = 0; lane < lane_count; lane++) {
-		lane_status = dp_get_lane_status(link_status, lane);
+		lane_status = drm_dp_get_lane_status(link_status, lane);
 		if ((lane_status & DP_CHANNEL_EQ_BITS) != DP_CHANNEL_EQ_BITS)
 			return false;
 	}
@@ -84,7 +86,7 @@ bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 	u8 lane_status;
 
 	for (lane = 0; lane < lane_count; lane++) {
-		lane_status = dp_get_lane_status(link_status, lane);
+		lane_status = drm_dp_get_lane_status(link_status, lane);
 		if ((lane_status & DP_LANE_CR_DONE) == 0)
 			return false;
 	}
@@ -99,7 +101,7 @@ u8 drm_dp_get_adjust_request_voltage(const u8 link_status[DP_LINK_STATUS_SIZE],
 	int s = ((lane & 1) ?
 		 DP_ADJUST_VOLTAGE_SWING_LANE1_SHIFT :
 		 DP_ADJUST_VOLTAGE_SWING_LANE0_SHIFT);
-	u8 l = dp_link_status(link_status, i);
+	u8 l = drm_dp_link_status(link_status, i);
 
 	return ((l >> s) & 0x3) << DP_TRAIN_VOLTAGE_SWING_SHIFT;
 }
@@ -112,7 +114,7 @@ u8 drm_dp_get_adjust_request_pre_emphasis(const u8 link_status[DP_LINK_STATUS_SI
 	int s = ((lane & 1) ?
 		 DP_ADJUST_PRE_EMPHASIS_LANE1_SHIFT :
 		 DP_ADJUST_PRE_EMPHASIS_LANE0_SHIFT);
-	u8 l = dp_link_status(link_status, i);
+	u8 l = drm_dp_link_status(link_status, i);
 
 	return ((l >> s) & 0x3) << DP_TRAIN_PRE_EMPHASIS_SHIFT;
 }
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 06a478679781..9930b2b269f2 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -952,6 +952,9 @@
 #define DP_MST_LOGICAL_PORT_0 8
 
 #define DP_LINK_STATUS_SIZE	   6
+
+u8 drm_dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r);
+u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE], int lane);
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count);
 bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
-- 
2.17.1

