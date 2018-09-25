Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048CFECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700112087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="oZvpcfWI";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="eUXCATng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700112087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbeIYPXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:23:13 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:44852 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729059AbeIYPXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:23:11 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8P9EKTe017053;
        Tue, 25 Sep 2018 02:15:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=fDWwy3Eoi4AMUfoY4dNWREojLk8RaLobC0XsWom0UGE=;
 b=oZvpcfWIcuQDl6F2MEgf7agzisD0VtpfZ0n+eFzPUgs6dU1Tdx0VD25w3UDpTDbP0QlO
 rXcewSLh9kHj9m7XXflEz9xGLbedUoCYphjZT+CinV0XO+7jkim17ZqRsYk6cqfzfIYC
 eMMmMimXMXMiwp77Jb9KnZV1ycn6ICgNhO5JS9gLptRq64dZj6RucrZBzyeh4gydnohS
 H1JvmsUSBMkJOWiD2CcHFjBiJqjfpbbGOqaiHPcqdlrDdEzvQxmUm5yXVvoXTm2Ne9Mh
 Rwp8DZkitIx0BeKmKvA9DtCMvgnN3sE7CYrJP2UjR8sZiWIxFN8WSlYBDpRletVj8GSm Kg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp0083.outbound.protection.outlook.com [216.32.181.83])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2mnhax4fjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Sep 2018 02:15:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDWwy3Eoi4AMUfoY4dNWREojLk8RaLobC0XsWom0UGE=;
 b=eUXCATngPSqns7/I8Uyof21Coe5sXO7HVSHillN9Z5lQ7ykFHTPF0qpFnMHQnjuzvEDwv0XgBSdtCDQT3rpLHVhoe1dTtAj4XW5EgRniDuhOxnU0EkIi/DcawCV3CwFcOw8ZCDTnJXuY430bXK3+rngOnLFfGbsK7+gRYL6fPVk=
Received: from BYAPR07CA0072.namprd07.prod.outlook.com (2603:10b6:a03:60::49)
 by SN1PR07MB2173.namprd07.prod.outlook.com (2a01:111:e400:c455::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Tue, 25 Sep
 2018 09:15:31 +0000
Received: from DM3NAM05FT055.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::206) by BYAPR07CA0072.outlook.office365.com
 (2603:10b6:a03:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Tue, 25 Sep 2018 09:15:30 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT055.mail.protection.outlook.com (10.152.98.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.5 via Frontend Transport; Tue, 25 Sep 2018 09:15:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w8P9FPqV028604
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 25 Sep 2018 02:15:28 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 25 Sep 2018 11:15:25 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 25 Sep 2018 11:15:25 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w8P9FHcN008169;
        Tue, 25 Sep 2018 10:15:17 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w8P9FG2q008124;
        Tue, 25 Sep 2018 10:15:16 +0100
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
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Damian Kos <dkos@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <pgaj@cadence.com>, <ltyrala@cadence.com>, <rafalc@cadence.com>,
        <jartur@cadence.com>, <piotrs@cadence.com>,
        <quentin.schulz@bootlin.com>, <jbergsagel@ti.com>
Subject: [PATCH v5 3/5] drm/dp: make dp_get_lane_status usable from outside of the core
Date:   Tue, 25 Sep 2018 10:13:33 +0100
Message-ID: <1537866837-4408-4-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1537866837-4408-1-git-send-email-dkos@cadence.com>
References: <1537866837-4408-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(36092001)(199004)(189003)(50226002)(8676002)(305945005)(86362001)(110136005)(16586007)(54906003)(316002)(105596002)(42186006)(7636002)(336012)(2201001)(47776003)(4326008)(246002)(426003)(8936002)(6666003)(2906002)(486006)(356003)(476003)(126002)(106466001)(2616005)(11346002)(446003)(26005)(186003)(36756003)(5660300001)(50466002)(51416003)(76176011)(7416002)(48376002)(26826003)(478600001)(87636003)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2173;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT055;1:LMIo1jJQFf5GuJmTIkJ4xLhM10EwxbeutDTiqLkYhTI63Uf/cXww4KWofnJzImrQg4FOocTSTIG9zxwrLNvvPhEEf1ow3KwOqFvb6+ilHUb6J/1ZW7E2PPqKWcflPZDA
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1225ed3c-4ac5-4dae-35d9-08d622c770b4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:SN1PR07MB2173;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2173;3:9ah9oe6182unCl55zkDUCwQAllsf+JMVSiXIDn5yGTcBCyJvr1OkLuLOLc41DwaAXjMLGu1QKGynairEVXNtfgxH7rSazmd53I4wqM5brbhsS5ebyUvv1TcFum6TrK1OFjwOe5Ap9s8BG3vXUtr7BEHWYnsgMZBsweh82bD08xa0KP+9IymfQD1znaxv9a27voxD4nwYW3ZVbqamRxtzOJFEN+MXIRB4nZt7kiGl0vGvJGEvFOimQ7QAlEdjX1gM3Bmd5C03nuyX8dhqJbMlO/uA5v6/ViKE6sB9cYXI/oQTdueY93enNf4n+tx7Cbeu7o7VkTuXfiGpA5QzP3UKY+GD2c6wi7cKGT95uTg4h4w=;25:FKl+1Su9kIKPLSpGLqRue3CZqBE2xqgx9Cat3wObOO9rJn/CEaHUKK40NAj5VlIScQFBTv4elEz64V/lNKOu639JSOmNvlMHf2tPR5h2+11Dh/dTNf+tYIpPP3aMFcaXjTknj6LVlyhX+zKDUqp/VnDIj7wjR0XBPPiTA9fACQhDS7xHXBESLidZM73o+QUXWdiRgfJEoR99oKQ0qFJ8B29FJCWvBYraRUw8t11adj97q2V7EV/4FnGz0EnfVf2MT6CmlCL8EsOh61lwo0Ksor6Tb6HlFKAXYIKVuvEzXjwnqFh1ef/TdGK0f+rWCzgt5ksLzJav90Vh7Wk8VNi2Zg==
X-MS-TrafficTypeDiagnostic: SN1PR07MB2173:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2173;31:lXGVDLLvk4M92PMZpPMSTpxtLvMCdbUWGIJWWWtUyCpKB6LQgvmLxODo+0/aPbmI4L6mlvlCfI9ORo38kjhjv2fMqSRXGOCorKIN7agCNGkkp8pQETnWQNmYkmj/DdD3ah43ruG92vB/dbRmiN4ScY4CwmfeyUHLezBEPvXlZtU2R7ZiS/jqTM9ugUaLIWGMCKWNaRx6TfxLd0Tch7RgtizORxzxDLEF4pARIXeFQqo=;20:/jhYfvuwcvYusQ45vsp7h7ugbQMifWhDcVbqiVwJBUN71ZtkrllniqhU4VISYU45sGMWa89g9p4kWfxnsKkJQmZdHKFmJVMCMVZO8/zALsIBPr5CC5kraFn2dskW1c5HMmQ4ypomCgecDXJIqCqj6IKjjNj8eajOU8shUWZIruh+MhMtTHZoJBeBi38IC6Mp/v99S+SvIifgHShVjaT67xzUsOuHOVm463WpnYEPWRtTbXGpjcfWulIyl6EYAATm1ekjA+fBM0fWmuXFrXH8chQyyiyNX52JiljNzY1JCQf9C9FbQnUI6jDpXatgPZq2DD9YCWXcpMJ27LPGFQ+VTC39o3YD94zvST1XJRnvjPFaROh+iTpKhM8WwWf1v0oXLfSyYgTmLFzlvMhf43cCv8rcg9CRUiOUYV73nu6XOiAZ5+mWDfhjy0qpekgR5ybkBgGV9CWT00+KHsgVh6oUtDT9PGLctJTSfObbSHIoCG7CQVzPuAwL6q+raNbH9mJF
X-Microsoft-Antispam-PRVS: <SN1PR07MB217378F409BBDC0FA11C17E2CD160@SN1PR07MB2173.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93003095)(3231355)(944501410)(52105095)(149066)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:SN1PR07MB2173;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2173;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2173;4:pO/YIqGvduVN+ZCws4Q+5yyVOncUc1VqXMXoa3i2v+YcIqXRlkWrFc1U18WnbGxnaLRwKZOLapMdWVqLVqWJZWleT4zNSYe6y4R7jDJhr3neJ1MjkdPiWzSJVrH5fGfJT1R1iC5y5aqq/6ox69iEMbeLp2V+X9FI6iVW53BS5Tbv0rQ/AwCKYlwXR05JzTdxlwwb/bLt4zEYqyl1oLNl4QegBCjb7+27qNpKK9JbN/x6Ekm/Cp9kw8jLkMgvTJbcMOenb418EXSdnmPIlcd10yUbAcmWMB5djCeTM+rJjTvEtkxENyYx+vppmWZKg76tpp8d25B40GJyoHXU3HXcnYlSGF/Pgqqlm7b8kNV/tB4=
X-Forefront-PRVS: 08062C429B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2173;23:+nbGF+Pq/uvi+soQzIbtW41l3bAOTTnwDKbr+nTyW?=
 =?us-ascii?Q?7lmNU0XhgMFawpVYP4LcwCNIdWyxFNu2w5EYUcEGGjXnDepFeSWHc4CSdtku?=
 =?us-ascii?Q?SHGmdoti+3hnviJ5CYTcCmoK5M2wGqIQ64kOLUvAU436QXjGNUI3wij2ScbP?=
 =?us-ascii?Q?+CdAaJ/RfKj4bvWYU0PNlZhyt3SPThHrMz0SvLR1eERi6Jo/YNvTVSTmVz4W?=
 =?us-ascii?Q?vE/og8CGOz8QofSCRGWRr9Om0JqCeuC2eMjFrM/L5QFlCOnfS/2IAwBxFZc7?=
 =?us-ascii?Q?cWy22hC21gyitMXjrgutu+JrWQZgMXkMSJGha4oxbgagp69xZggyMIjo0cQA?=
 =?us-ascii?Q?tOYWKm6E2EGc060UByA3dfApu3ViUL4Tp9p3mQk2ZfU4ZrLYIVWwXvz4hnxF?=
 =?us-ascii?Q?fvfX+Oekj6wRfrXLF6pYxsZvDkhr0k/gJurOCOSrZQBpSnow3JkjMyma25aT?=
 =?us-ascii?Q?e7IdodGSc+k9GmqfkeWBiawy9U57XOZ2UAvzbeuCVa3FQ1JUWjkrPQeM/p5w?=
 =?us-ascii?Q?Y7SxNAut9zodExZb3j7robXOr9jGbbL1MEMZm4n8a++vCsJx89/bs8Iq3pvX?=
 =?us-ascii?Q?gDozmGHeIaO/k+0dkvJQl4sgDHNuTUTVS8j6Q1EGVTZHkHsAUSjiEapnCWca?=
 =?us-ascii?Q?FzrwLy4pmuQy1zsi/yeWqbHk9G7m2QJbxRkdtSLei1LE2iHgAxkbsWCM5lbk?=
 =?us-ascii?Q?bLTZav5LZ6Fu3UTeC0CI7a3ouF6lNeMgzjWTISy6mpCjKtYzlBKjzNsTss0q?=
 =?us-ascii?Q?HmbiOgYevPscLaAcKtzJLXWYfXQK6HptWQ3sG5Ek4nWdmfLgWz783y2PqcWX?=
 =?us-ascii?Q?j22ykj7z5JSxZj28ZkgJmJqR1oX9rtxZES992VxVoHSuiGOeGIJNUkfOtbYe?=
 =?us-ascii?Q?OWd9uGwym+AXb3UFdbJSuu8IJ0HrGzFhaQTjmbJbrgYnkC2Dw0oNPATRPoTo?=
 =?us-ascii?Q?GFKW1s6iTlwt/YJbf4qQEbrg7TlLp/DuP4AN/y0cTMXSX/XGNNohOYW0EfVe?=
 =?us-ascii?Q?3WdNn+iNA5z40epyFPOvGZm8iWbMHbVlSAlunJCJ3jG8DF+W7+j/De++aKY6?=
 =?us-ascii?Q?Dx25VoTDYLtHjShXW0CxGJGj9ptvbEHp+eP82sWEFXXpj/QpOXGIu0OT/L03?=
 =?us-ascii?Q?yYhqemnWYzKJqwFdyrjnutUTujSxZy069kOtkof1JnmDVj3fTmW0A=3D=3D?=
X-Microsoft-Antispam-Message-Info: XpB5rc/mLV0RWmYGVF4DfVbTX5F2YpFzdqODRj7UCpsX3cckjjmKYXCrkjFdbxKx5368NNHDMsqJa+ISwluYjGJXzx3ygvHcUZ0mJG0Kuy8jApsh4pwAbW/d6SqqV6ywEi+YM3lKn5MPQQdCqS449J5qM3fVJWYQ/yyXpcp2jsCA3AQo1S81DwmW2Hrv6nrxLAlb2Reqi9zW9byQ24rEBU1WR0rhAbaTg0tVP/1mvcv0EMjZSioFuz/7uLSA6yF25kMbrCAfHkpafIZAyQhtPharYOiXtihnVUQ0oYM6Zk2HGyUlfyTG8VtstDwja36aOrWzSJ7165azvuYKoKUKGLf29ILPVk73DlZ4UmHoF46gmWFegdtXtLHcYYUMIU1EGhby1lxRh9nXFJms0Q6csg==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2173;6:YRZb6D+3uwXOuit2upATnNdACCjg+87B9oJe1u0e3/2qH9tswSwH09x7f9S9JIyr8sMUqxS+h7XwSvav7M9AasvGEso6SsWoN1xNGtci50TOW+cyvYiFr8blxsBdZz6NCUOy0vYUXatFip1XcQZQquNxcddR3LRB3kZ8f8DS+NtIWhRi8Ew3VWbhr+fofjnqTXIPFgi0SqEVfgk1be3zsDK6VCFJ/WeQTVub1srJv4h60aMV7c74rpqKuMp+nrcwN8mZw1oRaHCULLv+LBYGqmRi5G3aZs+HXG80mB7ad6rmQKBBaPPmCH5Bnecs2jzou8MXPkJhi45eqmnLmyh6xFj5r7igbFVI4iBeyrjCAI4iU4JLf+r+uY2j9J6BWTm9iJJ3HijTrnCmtdQWXrgoAYhzXCTvZEYED/WOlDK6lSDlcGio2q4lt1cppBXcCLpDZVocwadBoVMWXOyFQN559g==;5:VmP1IP7HsXn0R4ZegR4eCFloBpY8cyeJ89leOCkd8vjAiVbkU03uciz/9XJSJfEIOqn7u3vdPpa5FEQZw+m/rBDybwU6mUJTHX5kDnBFIhl378M1yYhsEltsjFmWOL4p/Q+ihFcl+tK3wwvixD1gzjZLToQwLHATh/PsRbr2V/s=;7:EBJbT4yMy4WYgj9880tzym/61XGRgdqow0ZGOR9q7ex4ScHCvpAz3TjBMEKvYMziDa5qaOf4h8HMk87iy7L6azMyH6NM0jMl0aFijKxssRGEqkgVKWc8O13Mtp42WIhZHa60fhk4baHsRpIauKw6TWH7K313DUamydVt16O5Dy3awdKaX5kwhBxL2ba4R5xRpw0+Q14d8TxMMXSnf9dIF/vKat/h6DGrWvsV2xTjiMLTod9kcYYB/laC55lma0Ak
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2173;20:aANna6VpMgSk9i/FBKF3l9+q9Rdu21yKhY7xCyGTLTrYAuLm/nOYswbYXFIIqBnARulMHmZZxqjCIl2vNc9jQR+eX8XvzpspS7lqvgy1ePmhtfsJxLLwZIBq/I8Sssq0WkuStHykHA35NpKOzTbCD1wk9x9WUgvWwpoJ2HLP0PDtl3BN8qPWRFtbxK/A4/EoGhcOz9AJsKwsX3zDKqoMlXjFgLs2xk9AlrktW6u0BciFKy77asNQ3vUI5HeblsOj
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 09:15:29.5604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1225ed3c-4ac5-4dae-35d9-08d622c770b4
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2173
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=873 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809250096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

dp_get_lane_status is pretty generic and can be used for other means,
so let's make it "public".

This adds drm_dp_get_lane_status to the header file and add the appropriate
EXPORT_SYMBOL for it so that it can be used by other drivers, be they compiled
built-in or as modules.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 9 +++++----
 include/drm/drm_dp_helper.h     | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 735ebde5c2f0..169db52f92f5 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -48,14 +48,15 @@ static u8 dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r)
 	return link_status[r - DP_LANE0_1_STATUS];
 }
 
-static u8 dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
-			     int lane)
+u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
+			  int lane)
 {
 	int i = DP_LANE0_1_STATUS + (lane >> 1);
 	int s = (lane & 1) * 4;
 	u8 l = dp_link_status(link_status, i);
 	return (l >> s) & 0xf;
 }
+EXPORT_SYMBOL(drm_dp_get_lane_status);
 
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count)
@@ -69,7 +70,7 @@ bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 	if ((lane_align & DP_INTERLANE_ALIGN_DONE) == 0)
 		return false;
 	for (lane = 0; lane < lane_count; lane++) {
-		lane_status = dp_get_lane_status(link_status, lane);
+		lane_status = drm_dp_get_lane_status(link_status, lane);
 		if ((lane_status & DP_CHANNEL_EQ_BITS) != DP_CHANNEL_EQ_BITS)
 			return false;
 	}
@@ -84,7 +85,7 @@ bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 	u8 lane_status;
 
 	for (lane = 0; lane < lane_count; lane++) {
-		lane_status = dp_get_lane_status(link_status, lane);
+		lane_status = drm_dp_get_lane_status(link_status, lane);
 		if ((lane_status & DP_LANE_CR_DONE) == 0)
 			return false;
 	}
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 698082a02b97..973d2fda9654 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -952,6 +952,8 @@
 #define DP_MST_LOGICAL_PORT_0 8
 
 #define DP_LINK_STATUS_SIZE	   6
+
+u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE], int lane);
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count);
 bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
-- 
2.17.1

